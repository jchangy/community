package com.web.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.common.util.HttpSessionUtil;
import com.web.community.service.EmailService;
import com.web.community.service.UserInfoService;
import com.web.community.vo.ResultList;
import com.web.community.vo.UserInfoVO;
import com.web.community.vo.UserSignUpRequest;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class UserInfoController {

   @Autowired
   private UserInfoService uiService;

   @Autowired
   private EmailService emailService;
   
   private String storedVerificationCode;

   @PostMapping("/login")
   public UserInfoVO login(@RequestBody UserInfoVO user, HttpSession session) {
       UserInfoVO loginUser = uiService.login(user);
       
       if (loginUser != null) {
           session.setAttribute("user", loginUser);
           log.info("로그인 성공: user={}, uiNum={}", loginUser, loginUser.getUiNum());
           return loginUser;
       } else {
           log.warn("로그인 실패: 아이디 또는 비밀번호가 잘못되었습니다.");
       }
       return null;
   }

   @PostMapping("/logout")
   public boolean logout() {
      if (HttpSessionUtil.isLogin()) {
         HttpSessionUtil.getSession().setAttribute("user", null);
         return true;
      }
      return false;
   }

   @PostMapping("/user")
   public ResponseEntity<Map<String, String>> insertUser(@RequestBody UserInfoVO user) {
      Map<String, String> response = new HashMap<>();
      int result = uiService.insertUser(user);

      if (result > 0) {
         response.put("message", "회원가입이 완료되었습니다.");
         return ResponseEntity.ok(response);
      } else {
         response.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
      }
   }
   

	 @PutMapping("/users")
	 public int updateUsers(@RequestBody List<UserInfoVO> users) { 
		 return uiService.updateUsers(users);
	}
	 




	 @GetMapping("/userList") public ResultList<UserInfoVO> getUserList(UserInfoVO user) {
		 return uiService.selectUsersForAdmin(user); 
	}
	 

   @GetMapping("/users")
   public List<UserInfoVO> getUsers(UserInfoVO user) {
      return uiService.selectUsers(user);
   }

   @GetMapping("/user/{uiNum}")
   public UserInfoVO getUser(@PathVariable int uiNum) {
      return uiService.selectUser(uiNum);
   }

   @PostMapping("/user/{uiNum}")
   public ResponseEntity<Map<String, String>> updateUser(@PathVariable int uiNum, @RequestBody UserInfoVO user) {
       Map<String, String> response = new HashMap<>();

       // 현재 유저 정보 가져오기
       UserInfoVO currentUser = uiService.selectUser(uiNum);
       if (currentUser == null) {
           response.put("message", "사용자를 찾을 수 없습니다.");
           return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
       }

       // 아이디는 수정할 수 없기 때문에, 기존의 uiId 값을 유지
       user.setUiId(currentUser.getUiId());

       // 전화번호 수정 (전화번호가 null 또는 빈 값일 경우 수정하지 않음)
       if (user.getUiPhone() != null && !user.getUiPhone().isEmpty()) {
           currentUser.setUiPhone(user.getUiPhone());
       }

       // 좋아하는 팀 수정
       if (user.getUiFavorite() != null && !user.getUiFavorite().isEmpty()) {
           currentUser.setUiFavorite(user.getUiFavorite());
       }

       // 닉네임과 이메일은 기존과 비교하여 변경되었을 때만 업데이트 처리
       if (!currentUser.getUiNickName().equals(user.getUiNickName())) {
           if (!uiService.isNicknameAvailable(user.getUiNickName())) {
               response.put("message", "이미 사용 중인 닉네임입니다.");
               return ResponseEntity.badRequest().body(response);
           }
       }

       if (user.getUiNickName() != null && !user.getUiNickName().isEmpty()) {
           currentUser.setUiNickName(user.getUiNickName());
       }

       // 이름(uiName)은 변경 가능하지만 비어있을 경우 기존 이름 유지
       if (user.getUiName() != null && !user.getUiName().isEmpty()) {
           currentUser.setUiName(user.getUiName());
       }

       try {
           // 업데이트 처리
           user.setUiNum(uiNum); // 기존 사용자 번호 유지
           int result = uiService.updateUser(currentUser);

           if (result > 0) {
               response.put("message", "정보가 성공적으로 수정되었습니다.");
               return ResponseEntity.ok(response); // 성공 시 200 OK 반환
           } else {
               response.put("message", "정보 수정에 실패했습니다. 다시 시도해주세요.");
               return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 실패 시 500 상태 반환
           }
       } catch (DataTooLongException e) {
           // 데이터 길이 초과 오류 처리
           response.put("message", "입력한 값을 다시 확인해주세요.");
           return ResponseEntity.badRequest().body(response); // 400 Bad Request 반환
       } catch (Exception e) {
           // 기타 예외 처리
           response.put("message", "입력한 값을 다시 확인해주세요.");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 500 서버 오류 반환
       }
   }

   public class DataTooLongException extends RuntimeException {
	    public DataTooLongException(String message) {
	        super(message);
	    }
	}
   @PostMapping("/sendVerificationEmail")
   public ResponseEntity<?> sendVerificationEmail(@RequestBody Map<String, String> request) {
       String uiId = request.get("uiId"); // 요청 본문에서 uiId 가져오기
      String email = request.get("email");
   // 요청 본문 로그 추가
      log.info("sendVerificationEmail 호출 - uiId: {}, email: {}", uiId, email);

      // uiId가 null인지 확인
      if (uiId == null || uiId.isEmpty()) {
          return ResponseEntity.badRequest().body("uiId가 필요합니다.");
      }

      // 이메일이 null인지 확인
      if (email == null || email.isEmpty()) {
          return ResponseEntity.badRequest().body("이메일이 필요합니다.");
      }

   //  아이디와 이메일이 일치하는지 확인
     boolean isEmailValid = uiService.isEmailValid(uiId, email);
     if (!isEmailValid) {
         return ResponseEntity.badRequest().body("아이디와 이메일이 일치하지 않습니다.");
     }

      String storedVerificationCode = emailService.sendVerificationEmail(email);
      HttpSessionUtil.getSession().setAttribute("checkCode", storedVerificationCode);
      log.info("전송된 인증번호: {}", storedVerificationCode);
      if (storedVerificationCode == null) {
          return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이메일 전송에 실패했습니다.");
      }
      return ResponseEntity.ok(Map.of("message", "인증번호가 전송되었습니다."));
      
   }
   @PostMapping("/sendVerificationEmail2")
   public ResponseEntity<?> sendVerificationEmail2(@RequestBody Map<String, String> request) {
       String email = request.get("email"); // 요청 본문에서 email 가져오기

       // 요청 본문 로그 추가
       log.info("sendVerificationEmail2 호출 - email: {}", email);

       // 이메일이 null인지 확인
       if (email == null || email.isEmpty()) {
           return ResponseEntity.badRequest().body("이메일이 필요합니다.");
       }

       // 이메일 유효성 검사 (예: 데이터베이스에서 확인)
       boolean isEmailValid = uiService.isEmailValid2(email);
       if (!isEmailValid) {
           return ResponseEntity.badRequest().body("이메일이 유효하지 않습니다.");
       }

       // 인증번호 전송
       String storedVerificationCode = emailService.sendVerificationEmail(email);
       HttpSessionUtil.getSession().setAttribute("checkCode", storedVerificationCode);
       log.info("전송된 인증번호: {}", storedVerificationCode);
       if (storedVerificationCode == null) {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이메일 전송에 실패했습니다.");
       }
       return ResponseEntity.ok(Map.of("message", "인증번호가 전송되었습니다."));
   }
   @PostMapping("/sendVerificationEmailForSignUp")
   public ResponseEntity<?> sendVerificationEmailForSignUp(@RequestBody Map<String, String> request) {
       String email = request.get("email"); // 요청 본문에서 email 가져오기

       // 요청 본문 로그 추가
       log.info("sendVerificationEmailForSignUp 호출 - email: {}", email);

       // 이메일이 null인지 확인
       if (email == null || email.isEmpty()) {
           return ResponseEntity.badRequest().body("이메일이 필요합니다.");
       }

       // 인증번호 전송
       String storedVerificationCode = emailService.sendVerificationEmail(email);
       HttpSessionUtil.getSession().setAttribute("checkCode", storedVerificationCode);
       log.info("전송된 인증번호: {}", storedVerificationCode);
       
       if (storedVerificationCode == null) {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이메일 전송에 실패했습니다.");
       }
       
       return ResponseEntity.ok(Map.of("message", "인증번호가 전송되었습니다."));
   }
   // 상태 변수를 추가
   private boolean idChecked = false;
   private boolean nicknameChecked = false;
   private boolean phoneChecked = false;

   @PostMapping("/checkId")
   public ResponseEntity<Map<String, Boolean>> checkId(@RequestBody Map<String, String> request) {
      String uiId = request.get("uiId");
      idChecked = uiService.isIdAvailable(uiId);
      return ResponseEntity.ok(Map.of("available", idChecked));
   }

   @PostMapping("/checkNickname")
   public ResponseEntity<Map<String, Boolean>> checkNickname(@RequestBody Map<String, String> request) {
      String uiNickName = request.get("uiNickName");
      nicknameChecked = uiService.isNicknameAvailable(uiNickName);
      return ResponseEntity.ok(Map.of("available", nicknameChecked));
   }
   @PostMapping("/checkEmail")
   public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestBody Map<String, String> request) {
       String uiEmail = request.get("uiEmail");
       boolean emailChecked = uiService.isEmailAvailable(uiEmail); // 이메일 중복 확인 서비스 호출
       return ResponseEntity.ok(Map.of("available", emailChecked));
   }

   @PostMapping("/checkPhone")
   public ResponseEntity<Map<String, Boolean>> checkPhone(@RequestBody Map<String, String> request) {
      String uiPhone = request.get("uiPhone");
      phoneChecked = uiService.isPhoneAvailable(uiPhone);
      return ResponseEntity.ok(Map.of("available", phoneChecked));
   }

   @PostMapping("/register")
   public ResponseEntity<Map<String, String>> registerUser(@RequestBody UserInfoVO user) {
       Map<String, String> response = new HashMap<>();

       // 중복 확인 상태 확인
       if (!idChecked || !nicknameChecked || !phoneChecked) {
           StringBuilder messageBuilder = new StringBuilder();

           if (!idChecked) {
               messageBuilder.append("아이디가 이미 사용 중입니다. ");
           }
           if (!nicknameChecked) {
               messageBuilder.append("닉네임이 이미 사용 중입니다. ");
           }
           if (!phoneChecked && user.getUiPhone() != null && !user.getUiPhone().isEmpty()) {
               messageBuilder.append("전화번호가 이미 사용 중입니다.");
           }

           response.put("message", messageBuilder.toString());
           return ResponseEntity.badRequest().body(response);
       }

       // 최종적으로 사용자 등록
       int result = uiService.insertUser(user);
       if (result <= 0) {
           response.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
       }

       // 성공적으로 가입
       idChecked = false; // 상태 초기화
       nicknameChecked = false; // 상태 초기화
       phoneChecked = false; // 상태 초기화
       response.put("message", "회원가입이 완료되었습니다.");
       return ResponseEntity.ok(response);
   }


   @PostMapping("/verifyCode")
   public ResponseEntity<Map<String, Object>> verifyCode(@RequestBody Map<String, String> request) {
       String code = request.get("code");
       String email = request.get("email"); // 이메일 추가

       if (code == null || code.trim().isEmpty()) {
           return ResponseEntity.badRequest().body(Map.of("valid", false, "message", "인증번호를 입력해주세요."));
       }
       if (HttpSessionUtil.getSession().getAttribute("checkCode") == null) {
           return ResponseEntity.badRequest().body(Map.of("valid", false, "message", "인증번호 전송을 해주세요"));
       }

       String storedVerificationCode = (String) HttpSessionUtil.getSession().getAttribute("checkCode");
       boolean isValid = code.equals(storedVerificationCode);
       Map<String, Object> response = new HashMap<>();
       response.put("valid", isValid);

       if (isValid) {
           response.put("message", "인증번호가 확인되었습니다.");

           // 이메일로 사용자 ID 조회
           UserInfoVO user = uiService.findByEmail(email); // 이메일로 사용자 검색하는 서비스 메서드 호출
           if (user != null) {
               response.put("userId", user.getUiId()); // 사용자 ID 반환
           } else {
               response.put("userId", null); // 사용자가 없을 경우
           }
       } else {
           response.put("message", "인증번호가 일치하지 않습니다.");
       }

       return ResponseEntity.ok(response);
   }

   @PostMapping("/getUserIdByEmail")
   public ResponseEntity<Map<String, Object>> getUserIdByEmail(@RequestBody Map<String, String> request) {
       String email = request.get("email");
       UserInfoVO user = uiService.findByEmail(email); // 이메일로 사용자 검색하는 서비스 메서드 호출

       Map<String, Object> response = new HashMap<>();
       if (user != null) {
           response.put("id", user.getUiId()); // 사용자 ID 반환
       } else {
           response.put("id", null); // 사용자가 없을 경우
       }
       return ResponseEntity.ok(response);
   }

   @Autowired
   private UserInfoService userInfoService; // 주입 확인

   @DeleteMapping("/user")
   public ResponseEntity<Map<String, Object>> deleteUser(HttpSession session) {
       Map<String, Object> response = new HashMap<>();
       
       Integer userId = (Integer) session.getAttribute("userId"); // 세션에서 userId 가져오기
       log.info("탈퇴 요청 - 세션에서 가져온 userId: " + userId); // 확인 로그

       if (userId == null) {
           response.put("success", false);
           response.put("message", "로그인 정보가 없습니다.");
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
       }

       int result = userInfoService.deleteUser(userId);
       if (result > 0) {
           session.invalidate(); // 탈퇴 후 세션 무효화
           response.put("success", true);
           response.put("message", "회원 탈퇴가 완료되었습니다.");
           return ResponseEntity.ok(response);
       } else {
           response.put("success", false);
           response.put("message", "탈퇴에 실패했습니다.");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
       }
   }
   @PostMapping("/signUp")
   public ResponseEntity<Map<String, Object>> signUp(@RequestBody UserSignUpRequest request) {
       Map<String, Object> response = new HashMap<>();
       
       if (request == null || !request.isValid()) {
           response.put("success", false);
           response.put("message", "잘못된 요청입니다.");
           return ResponseEntity.badRequest().body(response);
       }
       
       // UserSignUpRequest에서 UserInfoVO로 변환
       UserInfoVO user = request.toUserInfoVO();
       
       // 중복 확인
       if (!uiService.isIdAvailable(user.getUiId())) {
           response.put("success", false);
           response.put("message", "아이디가 이미 사용 중입니다.");
           return ResponseEntity.badRequest().body(response);
       }
       if (!uiService.isNicknameAvailable(user.getUiNickName())) {
           response.put("success", false);
           response.put("message", "닉네임이 이미 사용 중입니다.");
           return ResponseEntity.badRequest().body(response);
       }

       // 회원가입 처리
       int result = uiService.insertUser(user);
       if (result > 0) {
           response.put("success", true);
           response.put("message", "회원가입이 완료되었습니다.");
       } else {
           response.put("success", false);
           response.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
       }
       return ResponseEntity.ok(response);
   }

   @PostMapping("/changePassword")
   public ResponseEntity<Map<String, String>> changePassword(@RequestBody UserInfoVO user) {
       // 비밀번호 변경 로직 수정: 인증번호 확인 없이 비밀번호 변경
       int result = uiService.updatePassword(user.getUiId(), user.getUiPwd());
       if (result > 0) {
           return ResponseEntity.ok(Map.of("message", "비밀번호가 변경되었습니다."));
       } else {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "비밀번호 변경에 실패했습니다."));
       }
   }
 
   
 
   
//   @PostMapping("/login")
//   public ResponseEntity<?> login(@RequestBody UserInfoVO user, HttpSession session) {
//       UserInfoVO loginUser = userInfoService.login(user);
//       if (loginUser != null) {
//           session.setAttribute("userId", loginUser.getUiNum()); // 세션에 사용자 ID 저장
//           return ResponseEntity.ok().body(loginUser);
//       } else {
//           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 실패");
//       }
//   }

   
   

   
   // @DeleteMapping("/user/{uiNum}")
   // public int deleteUser(@PathVariable int uiNum) {
   //    int result = uiService.deleteUser(uiNum);
   //    return result;
   // }

   @DeleteMapping("/user/{uiNum}")
	public ResponseEntity<Map<String, String>> deleteUser(@PathVariable int uiNum, HttpSession session) {
	    Map<String, String> response = new HashMap<>();
	    
	    try {
	        int result = uiService.deleteUser(uiNum);
	        if (result >= 0) {  // 0 이상이면 성공으로 처리 (삭제된 레코드가 없어도 성공)
	            // 세션 무효화
	            session.invalidate();
	            response.put("message", "회원 탈퇴가 완료되었습니다.");
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("message", "회원 탈퇴에 실패했습니다.");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    } catch (Exception e) {
	        response.put("message", "서버 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
    }
   
   @GetMapping("/signup-count")
   public List<UserInfoVO> getSignupStats() {
       List<UserInfoVO> stats = uiService.getRecentSignupCounts();
       log.info("Result: {}", stats);
       return stats;
   }
}
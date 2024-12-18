package com.web.community.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.CommentInfoMapper;
import com.web.community.mapper.ImageInfoMapper;
import com.web.community.mapper.PostInfoMapper;
import com.web.community.mapper.UserInfoMapper;
import com.web.community.vo.ResultList;
import com.web.community.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserInfoService {
    @Autowired
    private UserInfoMapper userInfoMapper;
    @Autowired
    private CommentInfoMapper commentInfoMapper;
    @Autowired
    private PostInfoMapper postInfoMapper;
    @Autowired
    private ImageInfoMapper imageInfoMapper;
    
    @Autowired
    private EmailService emailService;
    
    private static final int DEFAULT_COUNT = 5;

    // 로그인
    public UserInfoVO login(UserInfoVO user) {
        UserInfoVO loginUser = userInfoMapper.selectUserForLogin(user);
        if (loginUser != null) {
            log.info("로그인에 성공하였습니다.");
        } else {
            log.warn("로그인에 실패하였습니다.");
        }
        return loginUser;
    }

    public int deleteUser(int userId) {
	    try {
	        // 1. 이미지 삭제
	        imageInfoMapper.deleteByUserId(userId);
	        
	        // 2. 해당 사용자의 게시글에 달린 모든 댓글 삭제
	        List<Integer> userPostIds = postInfoMapper.selectPostIdsByUserId(userId);
	        for (Integer postId : userPostIds) {
	            commentInfoMapper.deleteCommentsByPost(postId);
	        }
	        
	        // 3. 사용자가 작성한 댓글 삭제
	        commentInfoMapper.deleteByUserId(userId);
	        
	        // 4. 게시글 삭제
	        postInfoMapper.deleteByUserId(userId);
	        
	        // 5. 사용자 정보 삭제
	        return userInfoMapper.deleteUser(userId);
	    } catch (Exception e) {
	        log.error("사용자 삭제 중 오류 발생: {}", e.getMessage());
	        throw e;
	    }
	}
    
    //사용자 목록 조회
    public ResultList<UserInfoVO> selectUsersForAdmin(UserInfoVO user){
    	if (user.getCount() == 0) {
    		user.setCount(DEFAULT_COUNT);
		}
		if (user.getPage() != 0) {
			int start = (user.getPage() - 1) * user.getCount();
			user.setStart(start);
		}
		
		ResultList<UserInfoVO> rl = new ResultList<>();
		List<UserInfoVO> users = userInfoMapper.selectUsers(user);
		rl.setList(users);
		int totalCnt = userInfoMapper.selectUsersTotal(user);
		rl.setCount(totalCnt);
		
		int userNumber = totalCnt - user.getStart();
        for (UserInfoVO userInfo : users) {
        	userInfo.setUserNum(userNumber--);
        }
		
		return rl;
    }
    
    
    // 사용자 조회
    public UserInfoVO selectUser(int uiNum) {
        return userInfoMapper.selectUser(uiNum);
    }
    
    public List<UserInfoVO> selectUsers(UserInfoVO user) {
        return userInfoMapper.selectUsers(user);
    }
    
    // 사용자 등록
    public int insertUser(UserInfoVO user) {
        try {
            int result = userInfoMapper.insertUser(user);
            if (result > 0) {
                log.info("회원가입 성공: {}", user.getUiId());
            } else {
                log.warn("회원가입 실패: 데이터가 삽입되지 않았습니다.");
            }
            return result;
        } catch (Exception e) {
            log.error("회원가입 중 오류 발생: {}", e.getMessage());
            return 0; // 실패 시 0 반환
        }
    }

    // 사용자 업데이트
    public int updateUser(UserInfoVO user) {
        return userInfoMapper.updateUser(user);
    }
    
    public int updateUsers(List<UserInfoVO> users) {
        return userInfoMapper.updateUsers(users);
    }
    
    // 이메일로 사용자 찾기
    public UserInfoVO findByEmail(String email) {
        return userInfoMapper.findByEmail(email); // Mapper를 통해 이메일로 사용자 검색
    }

    public boolean isIdAvailable(String uiId) {
        UserInfoVO user = userInfoMapper.selectUserById(uiId);
        return user == null; // 사용자가 없으면 사용 가능
    }

    public boolean isNicknameAvailable(String uiNickName) {
        UserInfoVO user = userInfoMapper.selectUserByNickname(uiNickName);
        return user == null; // 사용자가 없으면 사용 가능
    }
    public boolean isEmailAvailable(String email) {
        // 데이터베이스에서 이메일 존재 여부 확인
        return userInfoMapper.findByEmail(email) == null; // null이면 사용 가능
    }

    public boolean isPhoneAvailable(String uiPhone) {
        UserInfoVO user = userInfoMapper.selectUserByPhone(uiPhone);
        return user == null; // 사용자가 없으면 사용 가능
    }

    public boolean isEmailValid(String uiId, String uiEmail) {
        return userInfoMapper.isEmailValid(uiId, uiEmail);
    }
    public boolean isEmailValid2(String uiEmail) {
        return userInfoMapper.isEmailValid2(uiEmail);
    }

    public int updatePassword(String uiId, String uiPwd) {
        // 비밀번호 해싱을 하지 않고 그대로 사용
        int result = userInfoMapper.updatePassword(uiId, uiPwd);
        if (result > 0) {
            log.info("비밀번호가 성공적으로 변경되었습니다. 사용자 ID: {}", uiId);
        } else {
            log.warn("비밀번호 변경에 실패했습니다. 사용자 ID: {}", uiId);
        }
        return result;
    }
    
    public List<UserInfoVO> getRecentSignupCounts() {
        List<UserInfoVO> stats = userInfoMapper.findRecentSignupCounts();
        log.info("Data fetched: {}", stats);
        return stats;
    }
}
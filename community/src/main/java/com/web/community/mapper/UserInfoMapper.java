package com.web.community.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.web.community.vo.PostInfoVO;
import com.web.community.vo.UserInfoVO;

public interface UserInfoMapper {
    UserInfoVO selectUserForLogin(UserInfoVO user);
    int insertUser(UserInfoVO user);
    List<UserInfoVO> selectUsers(UserInfoVO user);
    UserInfoVO selectUser(int uiNum);
    int updateUser(UserInfoVO user);
    int updateUsers(List<UserInfoVO> users);
    int deleteUser(int uiNum);
   // int deleteUsers(@Param("uiNums") List<Integer> uiNums);
    UserInfoVO findByVerificationCode(String code); // 인증 코드로 사용자 조회
    UserInfoVO selectUserById(String uiId); // ID로 사용자 조회
    UserInfoVO selectUserByNickname(String uiNickName); // 닉네임으로 사용자 조회
    UserInfoVO selectUserByPhone(String uiPhone); // 전화번호로 사용자 조회
    UserInfoVO findByEmail(String email); // 이메일로 사용자 찾기
    
    boolean isEmailValid(@Param("uiId") String uiId, @Param("uiEmail") String uiEmail); // 이메일 검증
    boolean isEmailValid2(@Param("uiEmail") String uiEmail);
    int updatePassword(@Param("uiId") String uiId, @Param("uiPwd") String uiPwd); // 비밀번호 업데이트
    List<UserInfoVO> isAdminLogin(int isAdmin);
    List<PostInfoVO> selectUsersForAdmin(UserInfoVO user);
    int selectUsersTotal(UserInfoVO user);
	int getUserCount();
	List<UserInfoVO> findRecentSignupCounts();
}
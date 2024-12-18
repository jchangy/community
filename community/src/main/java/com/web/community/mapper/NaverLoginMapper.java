package com.web.community.mapper;

import com.web.community.vo.UserInfoVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NaverLoginMapper {
    
    UserInfoVO findByUiId(String uiId);
    
    void insertNaverUser(UserInfoVO userInfo);
    
    // 닉네임의 개수를 반환하는 메서드
    int countByNickname(@Param("nickname") String nickname);
    
    // 닉네임으로 사용자 정보를 가져오는 메서드
    UserInfoVO findByNickname(@Param("nickname") String nickname);
}
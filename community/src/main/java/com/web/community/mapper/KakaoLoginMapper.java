package com.web.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.web.community.vo.UserInfoVO;

@Mapper
public interface KakaoLoginMapper {
    void insertKakaoUser(UserInfoVO kakaoUser);
    UserInfoVO findByUiId(String uiId);
    UserInfoVO findByNickname(String nickname);
}
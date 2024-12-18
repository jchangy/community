package com.web.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.web.community.mapper.KakaoLoginMapper;
import com.web.community.vo.UserInfoVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class KakaoLoginService {
    
    private static final Logger log = LoggerFactory.getLogger(KakaoLoginService.class);
    
    @Autowired
    private KakaoLoginMapper kakaoLoginMapper;

    public UserInfoVO insertKakaoUser(UserInfoVO kakaoUser) {
        try {
            UserInfoVO existingUser = kakaoLoginMapper.findByUiId(kakaoUser.getUiId());
            
            if (existingUser != null) {
                log.info("Existing Kakao user found: {}", existingUser.getUiId());
                return existingUser;
            }

            UserInfoVO userWithSameNickname = kakaoLoginMapper.findByNickname(kakaoUser.getUiNickName());
            if (userWithSameNickname != null) {
                kakaoUser.setUiNickName(kakaoUser.getUiNickName() + "_" + System.currentTimeMillis() % 1000);
            }

            log.info("Registering new Kakao user: {}", kakaoUser.getUiId());
            kakaoLoginMapper.insertKakaoUser(kakaoUser);
            
            return kakaoUser;
            
        } catch (Exception e) {
            log.error("Error while registering Kakao user", e);
            throw new RuntimeException("Failed to register Kakao user: " + e.getMessage());
        }
    }
}
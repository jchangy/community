package com.web.community.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.web.community.mapper.NaverLoginMapper;
import com.web.community.vo.UserInfoVO;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NaverLoginService {
    
    @Autowired
    private NaverLoginMapper naverLoginMapper;
    
    @Transactional // 트랜잭션 관리 추가
    public UserInfoVO insertNaverUser(UserInfoVO userInfo) {
        // 사용자 ID로 기존 사용자 확인
        UserInfoVO existingUser = naverLoginMapper.findByUiId(userInfo.getUiId());
        if (existingUser != null) {
            // 기존 사용자가 있으면 해당 사용자 반환
            return existingUser;
        }
        
        // 새로운 사용자 추가
        naverLoginMapper.insertNaverUser(userInfo);
        return userInfo; // 새로 추가된 사용자 반환
    }

    // 닉네임 중복 확인 메서드
    public boolean isNicknameExists(String nickname) {
        return naverLoginMapper.countByNickname(nickname) > 0;
    }

    // 닉네임으로 사용자 정보 가져오기
    public UserInfoVO getUserByNickname(String nickname) {
        return naverLoginMapper.findByNickname(nickname);
    }
}
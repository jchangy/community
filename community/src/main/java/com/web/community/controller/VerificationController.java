package com.web.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.mapper.UserInfoMapper;
import com.web.community.vo.UserInfoVO;

@RestController
public class VerificationController {
    
    @Autowired
    private UserInfoMapper userInfoMapper;

    @GetMapping("/verify")
    public String verifyEmail(@RequestParam("code") String code) {
        UserInfoVO user = userInfoMapper.findByVerificationCode(code);
        if (user != null) {
            user.setEmailVerified(true); // 이메일 인증 완료
            userInfoMapper.updateUser(user);
            return "{\"message\":\"이메일 인증이 완료되었습니다!\"}"; // JSON 형식으로 응답
        }
        return "{\"message\":\"유효하지 않은 인증 코드입니다.\"}"; // JSON 형식으로 응답
    }
}

package com.web.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

import java.util.UUID;
@Slf4j
@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    public String sendVerificationEmail(String email) {
        String verificationCode = UUID.randomUUID().toString().substring(0, 6); // 6자리 인증번호 생성
        String subject = "회원가입 인증번호";
        String text = "인증번호: " + verificationCode;
        

        // 이메일 발송
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject(subject);
        message.setText(text);

        try {
            mailSender.send(message);
        } catch (MailException e) {
            log.error("이메일 전송 중 오류 발생: {}", e.getMessage());
            return null; // 오류 발생 시 null 반환
        }

        return verificationCode; // 이 값을 저장하거나 DB에 저장
    }
    
}
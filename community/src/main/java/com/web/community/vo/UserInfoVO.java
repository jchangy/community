package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserInfoVO {
    private Integer uiNum;
    private String uiId;
    private String uiPwd;
    private String uiName;
    private String uiNickName;
    private String uiEmail;
    private String uiPhone;
    private String uiFavorite;
    private String uiCredat;
    private String uiCretim;
    private boolean emailVerified; // 이메일 인증 여부
    private String verificationCode; // 인증 코드
    private boolean isKakaoUser; // 카카오톡 사용자 여부
    private boolean isNaverUser; // 네이버 사용자 여부 추가
    private int isAdmin;
    private String uiPwdConfirm; // 비밀번호 확인 필드
    private int start;
    private int page;
    private int count;
    private int userNum;
    private String month;
    private int signupCount;
    
}
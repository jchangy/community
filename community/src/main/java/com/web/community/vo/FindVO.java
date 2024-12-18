package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FindVO {
    private String uiId;          // 사용자 ID
    private String uiEmail;       // 사용자 이메일
    private String uiName;        // 사용자 이름
    private String uiNickName;    // 사용자 닉네임

    // 생성자
    public FindVO(String uiId, String uiEmail, String uiName, String uiNickName) {
        this.uiId = uiId;
        this.uiEmail = uiEmail;
        this.uiName = uiName;
        this.uiNickName = uiNickName;
    }
}
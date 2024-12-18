package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserSignUpRequest {
    private String uiName;
    private String uiId;
    private String uiPwd;
    private String uiNickName;
    private String uiEmail;
    private String uiPhone;  // 선택 사항
    private String uiFavorite;

    // UserInfoVO로 변환하는 메서드
    public UserInfoVO toUserInfoVO() {
        UserInfoVO userInfo = new UserInfoVO();
        userInfo.setUiName(this.uiName);
        userInfo.setUiId(this.uiId);
        userInfo.setUiPwd(this.uiPwd);
        userInfo.setUiNickName(this.uiNickName);
        userInfo.setUiEmail(this.uiEmail);
        userInfo.setUiPhone(this.uiPhone);
        userInfo.setUiFavorite(this.uiFavorite);
        return userInfo;
    }

    // 유효성 검사 메서드
    public boolean isValid() {
        return uiName != null && !uiName.trim().isEmpty() &&
               uiId != null && !uiId.trim().isEmpty() &&
               uiPwd != null && !uiPwd.trim().isEmpty() &&
               uiNickName != null && !uiNickName.trim().isEmpty() &&
               uiEmail != null && !uiEmail.trim().isEmpty();
               // uiPhone은 선택 사항이므로 유효성 검사에서 제외
    }
}

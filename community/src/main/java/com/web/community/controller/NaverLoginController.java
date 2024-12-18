package com.web.community.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.web.community.service.NaverLoginService;
import com.web.community.vo.UserInfoVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.UUID;

@Controller
public class NaverLoginController {
    
    private static final Logger log = LoggerFactory.getLogger(NaverLoginController.class);

    @Autowired
    private NaverLoginService naverLoginService;

    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Value("${naver.redirect.uri}")
    private String redirectUri;

    @GetMapping("/login/naver")
    public String naverLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("state", state);

        String naverLoginUrl = "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + redirectUri
                + "&state=" + state
                + "&prompt=login"; // 재로그인 시 인증을 강제하기 위한 파라미터 추가

        return "redirect:" + naverLoginUrl;
    }

    @GetMapping("/login/naver/callback")
    public String naverCallback(
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String state,
            @RequestParam(required = false) String error,
            HttpSession session) {

        if (error != null) {
            log.error("Naver login error: {}", error);
            return "redirect:/login?error=" + error;
        }

        try {
            String sessionState = (String) session.getAttribute("state");
            if (sessionState == null || !state.equals(sessionState)) {
                log.error("Invalid state token");
                return "redirect:/login?error=invalid_state";
            }

            String accessToken = getAccessToken(code, state);
            String userInfoResponse = getUserProfile(accessToken);
            
            log.info("User Profile Response: {}", userInfoResponse);
            
            JsonObject userInfo = JsonParser.parseString(userInfoResponse).getAsJsonObject()
                    .get("response").getAsJsonObject();

            String userName = userInfo.has("name") ? userInfo.get("name").getAsString() : null;
            if (userName == null) {
                log.error("User name not found in the response");
                return "redirect:/login?error=user_name_not_found";
            }

            String userNickName = userInfo.has("nickname") ? userInfo.get("nickname").getAsString() : null;
            if (userNickName == null) {
                log.error("User nickname not found in the response");
                return "redirect:/login?error=user_nickname_not_found";
            }

            String userEmail = userInfo.has("email") ? userInfo.get("email").getAsString() : null;
            String userPhone = userInfo.has("mobile") ? userInfo.get("mobile").getAsString() : null;

            if (naverLoginService.isNicknameExists(userNickName)) {
                UserInfoVO existingUser = naverLoginService.getUserByNickname(userNickName);
                session.setAttribute("user", existingUser);
                return "redirect:/"; // 메인 페이지로 리다이렉트
            }

            UserInfoVO userInfoVO = new UserInfoVO();
            String uniqueUiId = "NAVER_" + userName + "_" + UUID.randomUUID().toString();
            userInfoVO.setUiId(uniqueUiId);
            userInfoVO.setUiName(userName);
            userInfoVO.setUiNickName(userNickName);
            userInfoVO.setUiEmail(userEmail);
            userInfoVO.setUiPhone(userPhone);
            userInfoVO.setUiPwd(hashPassword("NAVER_USER"));
            userInfoVO.setNaverUser(true);

            naverLoginService.insertNaverUser(userInfoVO);
            session.setAttribute("user", userInfoVO);
            
            return "redirect:/";
            
        } catch (Exception e) {
            log.error("Naver login error", e);
            return "redirect:/login?error=" + e.getMessage();
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션 무효화
        session.invalidate();

        // 사용자에게 네이버에서 로그아웃하도록 안내
        String naverLogoutUrl = "https://nid.naver.com/nidlogin.logout";

        // 네이버 로그아웃 후 리다이렉트할 URL 
        String redirectUri = "http://goaltong.store/"; // 로그아웃 후 돌아올 URL

        // 네이버 로그아웃 URL에 redirect_uri 추가
        return "redirect:" + naverLogoutUrl + "?redirect_uri=" + redirectUri;
    }

    private String getAccessToken(String code, String state) throws Exception {
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectUri
                + "&code=" + code
                + "&state=" + state;

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        int responseCode = con.getResponseCode();
        BufferedReader br;
        if (responseCode == 200) {
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }

        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();

        JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
        return jsonResponse.get("access_token").getAsString();
    }

    private String getUserProfile(String accessToken) throws Exception {
        String apiURL = "https://openapi.naver.com/v1/nid/me";

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = con.getResponseCode();
        BufferedReader br;
        if (responseCode == 200) {
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }

        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();

        log.info("User Profile Response: {}", response.toString());

        return response.toString();
    }

    // 비밀번호 해시 함수
    public String hashPassword(String password) throws Exception {
        byte[] salt = new byte[16];
        SecureRandom random = new SecureRandom();
        random.nextBytes(salt);
        
        String saltString = Base64.getEncoder().encodeToString(salt);
        
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        
        String hashString = Base64.getEncoder().encodeToString(hash);
        
        return saltString + ":" + hashString;
    }
}
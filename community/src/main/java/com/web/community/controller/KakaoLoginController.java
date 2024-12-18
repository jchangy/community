package com.web.community.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.community.service.KakaoLoginService;
import com.web.community.vo.UserInfoVO;

@Controller
public class KakaoLoginController {

    private static final Logger log = LoggerFactory.getLogger(KakaoLoginController.class);

    @Autowired
    private KakaoLoginService kakaoLoginService;
    
    @Autowired
    private HttpServletRequest request;
    
    @Value("${kakao.app.key}")
    private String appKey; // application.properties 또는 application.yml에서 가져옴

    @Value("${kakao.redirect.uri}")
    private String redirectUri; // 리다이렉트 URI도 외부에서 관리

    @GetMapping("/login/kakao")
    public String kakaoLogin() {
        String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize"
                + "?client_id=" + appKey
                + "&redirect_uri=" + redirectUri
                + "&response_type=code"
                + "&prompt=login";  
        return "redirect:" + kakaoLoginUrl;
    }

    @GetMapping("/login/kakao/callback")
    public String kakaoCallback(@RequestParam(value = "code", required = false) String code) {
        if (code == null) {
            return "redirect:/";
        }

        try {
            String accessToken = getAccessToken(code);
            String userInfoResponse = getKakaoUserInfo(accessToken);
            
            String userId = extractUserId(userInfoResponse);
            String nickname = extractUserNickname(userInfoResponse);

            UserInfoVO userInfoVO = new UserInfoVO();
            userInfoVO.setUiId("KAKAO_" + userId);
            userInfoVO.setUiPwd("KAKAO_USER");
            userInfoVO.setUiName(nickname);
            userInfoVO.setUiNickName(nickname);
            userInfoVO.setKakaoUser(true);
            userInfoVO.setEmailVerified(true);

            UserInfoVO savedUser = kakaoLoginService.insertKakaoUser(userInfoVO);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", savedUser);
            
            return "redirect:/";
            
        } catch (Exception e) {
            log.error("Kakao login error", e);
            return "redirect:/";
        }
    }

    private String getAccessToken(String code) {
        String tokenRequestUrl = "https://kauth.kakao.com/oauth/token";
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "authorization_code");
        body.add("client_id", appKey);
        body.add("redirect_uri", redirectUri);
        body.add("code", code);

        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(tokenRequestUrl, requestEntity, String.class);

        return extractAccessToken(response.getBody());
    }

    private String getKakaoUserInfo(String accessToken) {
        String userInfoRequestUrl = "https://kapi.kakao.com/v2/user/me";
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(
            userInfoRequestUrl, 
            HttpMethod.GET, 
            entity, 
            String.class
        );

        return response.getBody();
    }

    private String extractAccessToken(String tokenResponse) {
        Gson gson = new Gson();
        try {
            JsonObject jsonObject = gson.fromJson(tokenResponse, JsonObject.class);
            if (jsonObject.has("access_token")) {
                return jsonObject.get("access_token").getAsString();
            } else {
                throw new IllegalArgumentException("Access token not found in response: " + tokenResponse);
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to extract access token: " + e.getMessage(), e);
        }
    }

    private String extractUserId(String userInfoResponse) {
        Gson gson = new Gson();
        try {
            JsonObject jsonObject = gson.fromJson(userInfoResponse, JsonObject.class);
            if (jsonObject.has("id")) {
                return jsonObject.get("id").getAsString();
            } else {
                throw new IllegalArgumentException("User ID not found in response: " + userInfoResponse);
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to extract user ID: " + e.getMessage(), e);
        }
    }

    private String extractUserNickname(String userInfoResponse) {
        Gson gson = new Gson();
        try {
            JsonObject jsonObject = gson.fromJson(userInfoResponse, JsonObject.class);
            if (jsonObject.has("properties") && jsonObject.getAsJsonObject("properties").has("nickname")) {
                return jsonObject.getAsJsonObject("properties").get("nickname").getAsString();
            } else {
                throw new IllegalArgumentException("Nickname not found in response: " + userInfoResponse);
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to extract user nickname: " + e.getMessage(), e);
        }
    }
}
package com.web.community.service;


import java.time.format.DateTimeFormatter;
import java.time.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.web.community.vo.MatchVO;

@Service
public class MatchService {
    private final String API_URL = "https://api.football-data.org/v4/teams/";

    // 팀 이름을 한글로 변환하기 위한 맵
    private static final Map<String, String> translationMap = new HashMap<>();
    private static final Map<String, String> statusTranslationMap = new HashMap<>();

    static {
        translationMap.put("Arsenal FC", "아스날");
        translationMap.put("Aston Villa FC", "아스톤 빌라");
        translationMap.put("Chelsea FC", "첼시");
        translationMap.put("Everton FC", "에버튼");
        translationMap.put("Fulham FC", "풀럼");
        translationMap.put("Liverpool FC", "리버풀");
        translationMap.put("Manchester City FC", "맨시티");
        translationMap.put("Manchester United FC", "맨유");
        translationMap.put("Newcastle United FC", "뉴캐슬");
        translationMap.put("Tottenham Hotspur FC", "토트넘 홋스퍼");
        translationMap.put("Wolverhampton Wanderers FC", "울버햄튼");
        translationMap.put("Leicester City FC", "레스터시티");
        translationMap.put("Southampton FC", "사우스 햄튼");
        translationMap.put("Ipswich Town FC", "입스위치 타운");
        translationMap.put("Nottingham Forest FC", "노팅엄 포레스트");
        translationMap.put("Crystal Palace FC", "크리스탈 팰리스");
        translationMap.put("Brighton & Hove Albion FC", "브라이튼");
        translationMap.put("Brentford FC", "브렌트포드");
        translationMap.put("West Ham United FC", "웨스트햄");
        translationMap.put("AFC Bournemouth", "본머스");

        statusTranslationMap.put("SCHEDULED", "예정됨");
        statusTranslationMap.put("TIMED", "예정됨");
        statusTranslationMap.put("LIVE", "진행 중");
        statusTranslationMap.put("IN_PLAY", "경기 중");
        statusTranslationMap.put("PAUSED", "일시 중지됨");
        statusTranslationMap.put("FINISHED", "종료됨");
        statusTranslationMap.put("POSTPONED", "연기됨");
        statusTranslationMap.put("CANCELLED", "취소됨");
    }

    public List<MatchVO> getTeamMatches(int teamId) {
        List<MatchVO> matches = new ArrayList<>();
        String url = API_URL + teamId + "/matches";

        RestTemplate restTemplate = new RestTemplate();
        
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Auth-Token", "a61b8c6337d1474fac182286f7f3af8b");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            JSONObject jsonObject = new JSONObject(response.getBody());
            JSONArray matchesArray = jsonObject.getJSONArray("matches");

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm"); // 초 제외한 시:분 형식
            
            for (int i = 0; i < matchesArray.length(); i++) {
                JSONObject matchJson = matchesArray.getJSONObject(i);
                
                if (matchJson.getJSONObject("competition").getString("name").equals("Premier League")) {
                    MatchVO match = new MatchVO();
                    
                    // UTC 시간을 ZonedDateTime으로 파싱하고 KST로 변환
                    ZonedDateTime utcDateTime = ZonedDateTime.parse(matchJson.getString("utcDate"), dateFormatter.withZone(ZoneId.of("UTC")));
                    ZonedDateTime kstDateTime = utcDateTime.withZoneSameInstant(ZoneId.of("Asia/Seoul"));
                    
                    match.setMatchDate(kstDateTime.toLocalDate());
                    match.setMatchTime(kstDateTime.format(timeFormatter)); // "HH:mm" 형식으로 시간 설정
                    
                    String homeTeam = matchJson.getJSONObject("homeTeam").getString("name");
                    String awayTeam = matchJson.getJSONObject("awayTeam").getString("name");
                    match.setHomeTeam(translationMap.getOrDefault(homeTeam, homeTeam));
                    match.setAwayTeam(translationMap.getOrDefault(awayTeam, awayTeam));
                    
                    match.setHomeTeamLogo(matchJson.getJSONObject("homeTeam").getString("crest"));
                    match.setAwayTeamLogo(matchJson.getJSONObject("awayTeam").getString("crest"));
                    
                    String status = matchJson.getString("status");
                    match.setStatus(statusTranslationMap.getOrDefault(status, status));

                    if (matchJson.getJSONObject("score").has("fullTime")) {
                        JSONObject fullTimeScore = matchJson.getJSONObject("score").getJSONObject("fullTime");
                        match.setHomeScore(fullTimeScore.optInt("home", 0));
                        match.setAwayScore(fullTimeScore.optInt("away", 0));
                    }

                    match.setCompetition(matchJson.getJSONObject("competition").getString("name"));
                    matches.add(match);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }

        return matches;
    }
}
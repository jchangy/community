package com.web.community.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.community.vo.ScheduleVO;
import com.web.community.vo.schedule.PremierLeagueResponse;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ScheduleService {

    private static final Map<String, String> translationMap = new HashMap<>();
    @Autowired
    private PremierLeagueService pls;
    @Autowired
    private ObjectMapper om;

    static {
        translationMap.put("Arsenal FC", "아스날");
        translationMap.put("Aston Villa FC", "아스톤 빌라");
        translationMap.put("AFC Bournemouth", "본머스");
        translationMap.put("Brentford FC", "브렌트포트");
        translationMap.put("Brighton & Hove Albion FC", "브라이튼");
        translationMap.put("Chelsea FC", "첼시");
        translationMap.put("Crystal Palace FC", "크리스탈 팰리스");
        translationMap.put("Everton FC", "에버튼");
        translationMap.put("Fulham FC", "풀햄");
        translationMap.put("Ipswich Town FC", "입스위치");
        translationMap.put("Leicester City FC", "레스터시티");
        translationMap.put("Liverpool FC", "리버풀");
        translationMap.put("Manchester City FC", "맨시티");
        translationMap.put("Manchester United FC", "맨유");
        translationMap.put("Newcastle United FC", "뉴캐슬");
        translationMap.put("Nottingham Forest FC", "노팅엄");
        translationMap.put("Southampton FC", "사우스햄튼");
        translationMap.put("Tottenham Hotspur FC", "토트넘");
        translationMap.put("West Ham United FC", "웨스트햄");
        translationMap.put("Wolverhampton Wanderers FC", "울버햄튼");
    }

    public List<ScheduleVO> getMonthlyMatches(int month, int year) {
        List<ScheduleVO> matchList = new ArrayList<>();

        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("X-Auth-Token", "a61b8c6337d1474fac182286f7f3af8b");
            HttpEntity<String> entity = new HttpEntity<>(headers);

            String url = String.format("http://api.football-data.org/v4/competitions/PL/matches?dateFrom=%d-%02d-01&dateTo=%d-%02d-28", year, month, year, month);
            String response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class).getBody();
            log.info("response={}", response);
            
            PremierLeagueResponse ple = om.readValue(response, PremierLeagueResponse.class);
            //pls.saveMatchData(ple);
            log.info("ple=>{}", ple);
            
            JSONObject jsonObject = new JSONObject(response);
            JSONArray matchesArray = jsonObject.getJSONArray("matches");

            SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
            SimpleDateFormat localFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            localFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));

            for (int i = 0; i < matchesArray.length(); i++) {
                JSONObject match = matchesArray.getJSONObject(i);
                Date utcDate = utcFormat.parse(match.getString("utcDate"));
                String localDate = localFormat.format(utcDate);

                ScheduleVO schedule = new ScheduleVO();
                schedule.setMatchId(match.getInt("id"));
                schedule.setMatchDate(localDate); // String 형식으로 설정

                String homeTeam = match.getJSONObject("homeTeam").getString("name");
                String awayTeam = match.getJSONObject("awayTeam").getString("name");
                schedule.setHomeTeam(translationMap.getOrDefault(homeTeam, homeTeam));
                schedule.setAwayTeam(translationMap.getOrDefault(awayTeam, awayTeam));
                schedule.setHomeTeamLogo(match.getJSONObject("homeTeam").optString("crest", ""));
                schedule.setAwayTeamLogo(match.getJSONObject("awayTeam").optString("crest", ""));

                String status = match.optString("status", "");
                if ("FINISHED".equals(status)) {
                    String homeScoreStr = match.getJSONObject("score").getJSONObject("fullTime").optString("home", "-");
                    String awayScoreStr = match.getJSONObject("score").getJSONObject("fullTime").optString("away", "-");

                    schedule.setHomeScore(parseScore(homeScoreStr));
                    schedule.setAwayScore(parseScore(awayScoreStr));
                }

                matchList.add(schedule);
            }
        } catch (Exception e) {
            log.error("Error retrieving match data: {}", e);
        }

        return matchList;
    }

    private Integer parseScore(String scoreStr) {
        try {
            return (scoreStr.equals("-") || scoreStr.trim().isEmpty()) ? null : Integer.parseInt(scoreStr);
        } catch (NumberFormatException e) {
            log.error("Score parsing error: {}", e.getMessage());
            return null;
        }
    }
}

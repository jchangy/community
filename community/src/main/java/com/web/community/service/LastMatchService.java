package com.web.community.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.web.community.vo.LastMatchVO;

@Service
public class LastMatchService {
	@Value("${api.key}")
    private String apiKey;
	
    public List<LastMatchVO> getRecentMatches(int count) {
        List<LastMatchVO> recentMatches = new ArrayList<>();
        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.set("X-Auth-Token", apiKey);
            HttpEntity<String> entity = new HttpEntity<>(headers);

            String response = restTemplate.exchange(
                "http://api.football-data.org/v4/competitions/PL/matches",
                HttpMethod.GET,
                entity,
                String.class
            ).getBody();

            JSONObject jsonObject = new JSONObject(response);
            JSONArray matchesArray = jsonObject.getJSONArray("matches");

            // 현재 시간 가져오기
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

            // 종료된 경기 중 현재 시간보다 이전인 경기만 필터링
            for (int i = 0; i < matchesArray.length(); i++) {
                JSONObject match = matchesArray.getJSONObject(i);
                String status = match.getString("status");

                // 최근에 끝난 경기만 추가
                if ("FINISHED".equals(status)) {
                    LastMatchVO lastMatch = new LastMatchVO();
                    lastMatch.setMatchId(match.getInt("id"));
                    lastMatch.setHomeTeam(match.getJSONObject("homeTeam").getString("name"));
                    lastMatch.setAwayTeam(match.getJSONObject("awayTeam").getString("name"));
                    lastMatch.setHomeScore(match.getJSONObject("score").getJSONObject("fullTime").getInt("home"));
                    lastMatch.setAwayScore(match.getJSONObject("score").getJSONObject("fullTime").getInt("away"));

                    // 경기 종료 시간 가져오기
                    String utcDateString = match.getString("utcDate");
                    Date matchDate = dateFormat.parse(utcDateString); // UTC 날짜를 Date 객체로 변환
                    lastMatch.setMatchDate(matchDate); // MatchVO에 종료 시간 추가

                    // 팀 로고 가져오기
                    lastMatch.setHomeTeamLogo(match.getJSONObject("homeTeam").getString("crest")); // 홈 팀 로고
                    lastMatch.setAwayTeamLogo(match.getJSONObject("awayTeam").getString("crest")); // 원정 팀 로고

                    // 현재 시간보다 이전에 끝난 경기만 추가
                    if (matchDate.before(now)) {
                        recentMatches.add(lastMatch);
                    }
                }
            }

            // 종료된 경기 중 가장 최근의 3경기만 반환
            return recentMatches.stream()
                .sorted((m1, m2) -> m2.getMatchDate().compareTo(m1.getMatchDate())) // 종료 시간 기준으로 내림차순 정렬
                .limit(count)
                .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recentMatches;
    }
}
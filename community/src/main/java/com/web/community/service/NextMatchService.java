package com.web.community.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NextMatchService {

    public String getNextMatch() {
        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("X-Auth-Token", "a61b8c6337d1474fac182286f7f3af8b");
            HttpEntity<String> entity = new HttpEntity<>(headers);

            String response = restTemplate.exchange(
                "http://api.football-data.org/v4/competitions/PL/matches",
                HttpMethod.GET,
                entity,
                String.class
            ).getBody();

            JSONObject jsonObject = new JSONObject(response);
            JSONArray matchesArray = jsonObject.getJSONArray("matches");

            SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
            Date now = new Date();
            Date nextMatchDate = null;
            String homeTeam = "";
            String awayTeam = "";

            for (int i = 0; i < matchesArray.length(); i++) {
                JSONObject match = matchesArray.getJSONObject(i);
                Date matchDate = utcFormat.parse(match.getString("utcDate"));

                if (matchDate.after(now)) {
                    if (nextMatchDate == null || matchDate.before(nextMatchDate)) {
                        nextMatchDate = matchDate;
                        homeTeam = match.getJSONObject("homeTeam").getString("name");
                        awayTeam = match.getJSONObject("awayTeam").getString("name");
                    }
                }
            }

            if (nextMatchDate != null) {
                long timeDiff = nextMatchDate.getTime() - now.getTime();
                long secondsRemaining = timeDiff / 1000;

                long days = secondsRemaining / (24 * 3600);
                secondsRemaining %= (24 * 3600);
                long hours = secondsRemaining / 3600;
                secondsRemaining %= 3600;
                long minutes = secondsRemaining / 60;
                long seconds = secondsRemaining % 60;

                return String.format("%s vs %s, 시작까지 남은 시간: %02d일 %02d시 %02d분", 
                                     homeTeam, awayTeam, days, hours, minutes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 다음 경기가 없을 경우 null 반환
    }
}
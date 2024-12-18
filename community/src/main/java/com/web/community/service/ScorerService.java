
package com.web.community.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.web.community.vo.ScorerVO;

@Service
public class ScorerService {

    private static final String SCORER_API_URL = "http://api.football-data.org/v4/competitions/PL/scorers";
    private static final String API_KEY = "a61b8c6337d1474fac182286f7f3af8b";

    public List<ScorerVO> getTopScorers() {
        List<ScorerVO> scorersList = new ArrayList<>();

        try {
            // API 요청 설정
            URL url = new URL(SCORER_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("X-Auth-Token", API_KEY);

            // 응답 데이터 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder content = new StringBuilder();
            String line;

            while ((line = in.readLine()) != null) {
                content.append(line);
            }
            in.close();
            conn.disconnect();

            // JSON 파싱
            JSONObject jsonResponse = new JSONObject(content.toString());
            JSONArray scorersArray = jsonResponse.getJSONArray("scorers");

            // "scorers" 배열을 순회하며 데이터 추출
            for (int i = 0; i < scorersArray.length(); i++) {
                JSONObject scorer = scorersArray.getJSONObject(i);
                JSONObject player = scorer.getJSONObject("player");
                JSONObject team = scorer.getJSONObject("team");

                String playerName = player.getString("name");
                String nationality = player.getString("nationality");
                String teamName = team.getString("name");
                int goals = scorer.getInt("numberOfGoals");

                // ScorerVO 객체 생성 후 리스트에 추가
                ScorerVO scorerVO = new ScorerVO(playerName, nationality, teamName, goals);
                scorersList.add(scorerVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return scorersList;
    }
}

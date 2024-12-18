package com.web.community.footballdata;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FootballDataAPI {
    private static final String API_URL = "https://api.football-data.org/v4/teams/57/matches";
    private static final String API_KEY = "a61b8c6337d1474fac182286f7f3af8b";

    public static void main(String[] args) {
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("X-Auth-Token", API_KEY);

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) { // 성공적으로 응답을 받았을 때
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder content = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();
                
                // JSON 데이터 파싱
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(content.toString());
                JsonNode matches = rootNode.path("matches");

                for (JsonNode match : matches) {
                    String homeTeam = match.path("homeTeam").path("name").asText();
                    String awayTeam = match.path("awayTeam").path("name").asText();
                    String matchDate = match.path("utcDate").asText();

                    System.out.println("Home Team: " + homeTeam);
                    System.out.println("Away Team: " + awayTeam);
                    System.out.println("Match Date: " + matchDate);
                    System.out.println("---------------------------");
                }
            } else {
                System.out.println("Failed to fetch data. Response code: " + responseCode);
            }
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

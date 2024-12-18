package com.web.community.util;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@PropertySource(value={"classpath:api.properties"})
@Slf4j
public class FootballDataGetterUtil {
    @Value("${api.key}")
    private String apiKey;
    
    private String apiUrl = "https://api.football-data.org/v4";
    
    public String getData(String endpoint) {
        try {
            URL url = new URL(apiUrl + endpoint);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("X-Auth-Token", apiKey);
            
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                return response.toString();
            } else {
                log.error("API request failed with response code: {}", responseCode);
                return null;
            }
        } catch (Exception e) {
            log.error("Error fetching data from API: {}", e.getMessage());
            return null;
        }
    }
}

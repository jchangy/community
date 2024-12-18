package com.web.community.dataextractor;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.web.community.vo.PlayerVO;

public class PlayerDataExtractor {
    public static List<PlayerVO> extractPlayersFromJson(String filePath) {
        List<PlayerVO> players = new ArrayList<>();
        Gson gson = new Gson();

        try (FileReader reader = new FileReader(filePath)) {
            JsonObject jsonObject = gson.fromJson(reader, JsonObject.class);
            JsonArray teams = jsonObject.getAsJsonArray("teams");

            for (JsonElement teamElement : teams) {
                JsonObject team = teamElement.getAsJsonObject();
                JsonArray squad = team.getAsJsonArray("squad");

                for (JsonElement playerElement : squad) {
                    JsonObject playerJson = playerElement.getAsJsonObject();
                    PlayerVO player = new PlayerVO();

                    player.setPiNum(playerJson.get("id").getAsInt());
                    player.setPiName(playerJson.get("name").getAsString());
                    player.setPiDateOfBirth(playerJson.get("dateOfBirth").getAsString());
                    player.setPiNationality(playerJson.get("nationality").getAsString());
                    player.setPiPosition(playerJson.get("position").getAsString());

                    // 셔츠 번호는 JSON에 없으므로 기본값 0으로 설정
                    player.setPiShirtNumber(0);

                    players.add(player);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return players;
    }

    public static void main(String[] args) {
        String filePath = "path/to/teams_example.json";
        List<PlayerVO> extractedPlayers = extractPlayersFromJson(filePath);
        
        for (PlayerVO player : extractedPlayers) {
            System.out.println(player);
        }
    }
}

package com.web.community.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.community.util.FootballDataGetterUtil;
import com.web.community.vo.LeagueVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@Controller
public class LeagueController {

    @Autowired
    private FootballDataGetterUtil footballDataGetterUtil;

    @Autowired
    private ObjectMapper objectMapper;

    @GetMapping("/leagues") // 경로 설정
    public String getLeagues(Model model) {
        String endpoint = "/competitions"; // 리그 API 엔드포인트
        String leaguesData = footballDataGetterUtil.getData(endpoint); // 리그 데이터를 요청

        try {
            System.out.println("Leagues Data: " + leaguesData); // JSON 데이터 로그 출력

            Map<String, Object> leaguesMap = objectMapper.readValue(leaguesData, new TypeReference<Map<String, Object>>() {});
            List<LeagueVO> leagues = objectMapper.convertValue(leaguesMap.get("competitions"), new TypeReference<List<LeagueVO>>() {});
            model.addAttribute("leagues", leagues); // 모델에 추가
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            model.addAttribute("error", "데이터를 불러오는 데 실패했습니다."); // 에러 메시지 추가
        }

        return "leagues"; // JSP 페이지 이름
    }
}

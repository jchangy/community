package com.web.community.controller;

import com.web.community.service.MatchService;
import com.web.community.vo.MatchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MatchController {

    @Autowired
    private MatchService matchService;

    // 기본 페이지 로드
    @GetMapping("/match/match")
    public String getMatchPage() {
        return "match/match";  // /WEB-INF/views/match/match.jsp로 이동
    }

    // AJAX 요청에 대한 JSON 응답
    @GetMapping("/api/teamMatches")
    @ResponseBody
    public List<MatchVO> getTeamMatches(@RequestParam("teamId") int teamId) {
        return matchService.getTeamMatches(teamId);
    }
}
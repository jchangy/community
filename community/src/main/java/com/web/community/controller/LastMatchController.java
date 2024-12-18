package com.web.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.community.service.LastMatchService;
import com.web.community.vo.LastMatchVO;

@Controller
public class LastMatchController {

    @Autowired
    private LastMatchService lastMatchService;

    @RequestMapping("/")
    public String index(Model model) {
        List<LastMatchVO> recentMatches = lastMatchService.getRecentMatches(3); // 최근 경기 3개 가져오기
        model.addAttribute("recentMatches", recentMatches); // recentMatches를 모델에 추가
        return "index"; // index.jsp로 이동
    }

    @RequestMapping("/lastMatches") // URL 매핑을 확인
    public String lastMatches(Model model) {
        List<LastMatchVO> recentMatches = lastMatchService.getRecentMatches(5); // 최근 경기 5개 가져오기
        model.addAttribute("recentMatches", recentMatches); // recentMatches를 모델에 추가
        return "lastMatches"; // lastMatches.jsp로 이동
    }
     @RequestMapping("/lastMatch2") // 새로운 요청 매핑 추가
    @ResponseBody // JSON 형식으로 응답
    public List<LastMatchVO> getLastMatchesApi() {
        return lastMatchService.getRecentMatches(3); // 최근 경기 5개 가져오기
    }
     
}
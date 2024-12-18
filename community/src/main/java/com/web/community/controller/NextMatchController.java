package com.web.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.community.service.NextMatchService;

@Controller
public class NextMatchController {

    @Autowired
    private NextMatchService nextMatchService;

    @RequestMapping("/nextMatch")
    public String getNextMatch(Model model) {
        String nextMatchInfo = nextMatchService.getNextMatch();
        model.addAttribute("nextMatchInfo", nextMatchInfo);
        return "view/index"; // 다음 경기 정보를 보여줄 JSP 파일 경로
    }
    

    @RequestMapping("/nextMatch2")
    @ResponseBody
    public String getNextMatch2() {
        return nextMatchService.getNextMatch();
    }
}
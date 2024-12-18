package com.web.community.controller;

import com.web.community.service.ScorerService;
import com.web.community.vo.ScorerVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ScorerController {

    @Autowired
    private ScorerService scorerService;

    @GetMapping("/scorers")
    public String getTopScorers(Model model) {
        List<ScorerVO> scorers = scorerService.getTopScorers();
        model.addAttribute("scorers", scorers);
        return "scorer";
    }
}

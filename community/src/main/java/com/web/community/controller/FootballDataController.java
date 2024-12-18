package com.web.community.controller;


import com.web.community.service.FootballDataService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FootballDataController {

    private final FootballDataService footballDataService;

    @Autowired
    public FootballDataController(FootballDataService footballDataService) {
        this.footballDataService = footballDataService;
    }

//    @GetMapping("/leagues")
//    public String fetchLeagues() {
//        return footballDataService.getLeagueData();
//    }
}

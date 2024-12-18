package com.web.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.util.FootballDataGetterUtil;

@Service
public class FootballDataService {

    private final FootballDataGetterUtil footballDataGetterUtil;

    @Autowired
    public FootballDataService(FootballDataGetterUtil footballDataGetterUtil) {
        this.footballDataGetterUtil = footballDataGetterUtil;
    }

    public String getLeagueData() {
        String endpoint = "/competitions"; // 원하는 엔드포인트로 변경
        return footballDataGetterUtil.getData(endpoint);
    }
}

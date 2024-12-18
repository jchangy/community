package com.web.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.PremierLeagueMapper;
import com.web.community.vo.schedule.Match;
import com.web.community.vo.schedule.PremierLeagueResponse;

@Service
public class PremierLeagueService {

	@Autowired
    private PremierLeagueMapper premierLeagueMapper;
    
    public void saveMatchData(PremierLeagueResponse response) {
        // 시즌 정보 저장
        if (response.getMatches() != null && !response.getMatches().isEmpty()) {
            Match firstMatch = response.getMatches().get(0);
            if (!premierLeagueMapper.existsSeasonById(firstMatch.getSeason().getId())) {
                premierLeagueMapper.insertSeason(firstMatch.getSeason());
            }
        }
        
        // 경기 정보와 팀 정보 저장
        for (Match match : response.getMatches()) {
            // 홈팀 정보 저장
            if (!premierLeagueMapper.existsTeamById(match.getHomeTeam().getId())) {
                premierLeagueMapper.insertTeam(match.getHomeTeam());
            }
            
            // 원정팀 정보 저장
            if (!premierLeagueMapper.existsTeamById(match.getAwayTeam().getId())) {
                premierLeagueMapper.insertTeam(match.getAwayTeam());
            }
            
            // 경기 정보 저장
            if(premierLeagueMapper.existMatchById(match.getId())) {
            	premierLeagueMapper.insertMatch(match);
            }
        }
    }
}

package com.web.community.mapper;

import com.web.community.vo.schedule.Match;
import com.web.community.vo.schedule.Season;
import com.web.community.vo.schedule.Team;

public interface PremierLeagueMapper {

    void insertMatch(Match match);
    
    void insertTeam(Team team);
    
    void insertSeason(Season season);
    boolean existsTeamById(Long teamId);
    
    boolean existsSeasonById(Long seasonId);
    
    boolean existMatchById(Long MatchId);
}

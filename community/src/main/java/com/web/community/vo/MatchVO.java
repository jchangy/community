package com.web.community.vo;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MatchVO {
	private LocalDate matchDate;
    private String matchTime;  // "HH:mm" 형식으로 저장
    private String homeTeam;
    private String awayTeam;
    private String status;
    private String competition;
    private String homeTeamLogo;
    private String awayTeamLogo;
    private Integer homeScore;
    private Integer awayScore;
    
   
    
}

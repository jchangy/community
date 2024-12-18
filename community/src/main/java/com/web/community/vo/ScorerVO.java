package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class ScorerVO {
	private String playerName;
    private String nationality;
    private String teamName;
    private int goals;
    
    public ScorerVO(String playerName, String nationality, String teamName, int goals) {
        this.playerName = playerName;
        this.nationality = nationality;
        this.teamName = teamName;
        this.goals = goals;
    }
    }


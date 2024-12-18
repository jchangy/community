package com.web.community.vo.schedule;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class Match {
    private Area area;
    private Competition competition;
    private Season season;
    private Long id; 
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private String utcDate;
    private String status;
    private int matchday;
    private String stage;
    private String group;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private String lastUpdated;
    private Team homeTeam;
    private Team awayTeam;
    private Score score;
    private Odds odds;
    private List<Referee> referees;
}

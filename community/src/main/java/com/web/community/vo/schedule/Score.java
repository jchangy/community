package com.web.community.vo.schedule;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)	
public class Score {
    private String winner;
    private String duration;
    private ScoreDetail fullTime;
    private ScoreDetail halfTime;
}

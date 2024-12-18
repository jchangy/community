package com.web.community.vo.schedule;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class PremierLeagueResponse {
    private Filters filters;
    private ResultSet resultSet;
    private Competition competition;
    private List<Match> matches;
}

package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;

@Getter
@Setter
@ToString
public class LastMatchVO {
    private int matchId;
    private String homeTeam;
    private String awayTeam;
    private Integer homeScore; // Integer로 변경
    private Integer awayScore; // Integer로 변경
    private String homeTeamLogo; // 홈 팀 로고 추가
    private String awayTeamLogo; // 원정 팀 로고 추가
    private Date matchDate; // 경기 종료 시간 추가

    public String getInfo() {
        return homeTeam + " vs " + awayTeam + " <br> " + homeScore + " - " + awayScore;
    }

    // 종료 시간을 "11월 08일 (금)" 형식으로 반환하는 메서드
    public String getFormattedMatchDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일 (E)"); // 원하는 형식으로 포맷
        return sdf.format(matchDate);
    }
}
package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class StandingsVO {
    private Season season;
    private List<Standing> standings;

    @Getter
    @Setter
    @ToString
    public static class Season {
        private String startDate;
        private String endDate;
    }

    @Getter
    @Setter
    @ToString
    public static class Standing {
        private List<Team> table;

        @Getter
        @Setter
        @ToString
        public static class Team {
            private String name;
            private String crest;
            private int position;
            private int playedGames;
            private int won;
            private int draw;
            private int lost;
            private int points;
        }
    }
}

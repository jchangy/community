package com.web.community.vo;

import lombok.Data;

@Data
public class LeagueVO {
    private int id;
    private Area area;
    private String name;
    private String code;
    private String type;
    private String emblem;
    private String plan;
    private CurrentSeason currentSeason;
    private int numberOfAvailableSeasons;
    private String lastUpdated;

    @Data
    public static class Area {
        private int id;
        private String name;
        private String code;
        private String flag;
    }

    @Data
    public static class CurrentSeason {
        private int id;
        private String startDate;
        private String endDate;
        private int currentMatchday;
        private Object winner; // 필요한 경우 적절한 타입으로 변경
    }
}

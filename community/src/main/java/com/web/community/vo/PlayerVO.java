package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PlayerVO {

    private int piNum;              // 선수 고유 ID
    private String piName;          // 선수 이름
    private String piDateOfBirth;   // 선수 생년월일
    private String piNationality;   // 선수 국적
    private String piPosition;      // 선수 포지션
    private int piShirtNumber;      // 선수 셔츠 번호

    private int tmNum;           // 팀 고유 ID
}

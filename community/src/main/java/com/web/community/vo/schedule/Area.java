package com.web.community.vo.schedule;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class Area {
    private Long id;
    private String name;
    private String code;
    private String flag;
}

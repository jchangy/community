package com.web.community.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResultList<T> {
	private List<T> list;
	private int count;
}

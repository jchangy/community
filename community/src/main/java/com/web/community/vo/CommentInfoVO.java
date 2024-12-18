package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentInfoVO {
	private int cmiNum;
	private String cmiContent;
	private String cmiCreated;
	private String cmiUpdated;
	private int piNum;
	private Integer uiNum;
	private String uiNickName;
	private String status;
	private int start;
	private int count;
	private int page;
}

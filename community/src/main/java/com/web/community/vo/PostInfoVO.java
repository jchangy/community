package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PostInfoVO {
	private Integer piNum;
	private String piTitle;
	private String piContent;
	private String uiNickName;
	private String piCreated;
	private String piUpdated;
	private int piViews;
	private String status;
	private Integer uiNum;	//작성자의 uiNum
	private int start;
	private int count;
	private int page;
	private int postNum;	//게시글 번호
}

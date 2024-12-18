package com.web.community.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReportVO {
	private int riNum;
	private int uiNum;
	private String uiNickName;
	private String reportedType;
	private int reportedNum;
	private String riReason;
	private Status status;
	private String riCreated;
	private String riUpdated;
	private String uiId;

	public enum Status {
	    대기중, 처리완료, 무시
	}
}

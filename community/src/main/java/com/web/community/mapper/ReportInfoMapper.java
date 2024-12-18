package com.web.community.mapper;

import java.util.List;

import com.web.community.vo.ReportVO;

public interface ReportInfoMapper {
	List<ReportVO> selectReportsByComments(ReportVO report);
	List<ReportVO> selectReportsByPosts(ReportVO report);
    int insertReport(ReportVO report);
    int updateReportStatus(ReportVO report);
    int deleteReport(int riNum);
}

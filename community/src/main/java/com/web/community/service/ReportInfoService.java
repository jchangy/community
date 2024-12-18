package com.web.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.ReportInfoMapper;
import com.web.community.vo.ReportVO;

@Service
public class ReportInfoService {
	@Autowired
	private ReportInfoMapper reportInfoMapper;

    // 모든 댓글 신고 정보 조회
    public List<ReportVO> selectReportsByComments(ReportVO report) {
        return reportInfoMapper.selectReportsByComments(report);
    }
    
    // 모든 게시글 신고 정보 조회
    public List<ReportVO> selectReportsByPosts(ReportVO report) {
        return reportInfoMapper.selectReportsByPosts(report);
    }

    // 신고 정보 삽입
    public int insertReport(ReportVO report) {
    	return reportInfoMapper.insertReport(report);
    }

    // 신고 상태 업데이트
    public int updateReportStatus(ReportVO report) {
    	return reportInfoMapper.updateReportStatus(report);
    }

    // 신고 정보 삭제
    public int deleteReport(int riNum) {
    	return reportInfoMapper.deleteReport(riNum);
    }
}

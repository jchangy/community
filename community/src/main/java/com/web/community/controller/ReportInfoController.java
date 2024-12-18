package com.web.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.service.ReportInfoService;
import com.web.community.vo.ReportVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class ReportInfoController {
	@Autowired
	private ReportInfoService reportInfoService;
	
	@GetMapping("/reports/comments")
	public List<ReportVO> getReportsByComments(ReportVO report){
		return reportInfoService.selectReportsByComments(report);
	}
	
	@GetMapping("/reports/posts")
	public List<ReportVO> getReportsByPosts(ReportVO report){
		return reportInfoService.selectReportsByPosts(report);
	}
	
	@PostMapping("/reports")
	public int addReport(@RequestBody ReportVO report) {
		if (report.getReportedType() == null) {
        log.error("ReportedType is null!");
    } else {
        log.info("ReportedType: {}", report.getReportedType());
    }
		return reportInfoService.insertReport(report);
	}
	
	@PutMapping("/reports")
	public int modifyReport(@RequestBody ReportVO report) {
		return reportInfoService.updateReportStatus(report);
	}
	
	@DeleteMapping("/reports/{riNum}")
	public int removeReport(@PathVariable int riNum) {
		return reportInfoService.deleteReport(riNum);
	}
	
}

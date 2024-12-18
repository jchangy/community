package com.web.community.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.community.service.ScheduleService;
import com.web.community.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping
    public String getSchedule(@RequestParam(value = "month", required = false) Integer month,
                              @RequestParam(value = "year", required = false) Integer year,
                              Model model) {
        // 현재 날짜를 기준으로 기본값 설정
        if (month == null || year == null) {
            LocalDate now = LocalDate.now();
            month = now.getMonthValue(); // 현재 월
            year = now.getYear(); // 현재 연도
        }

        List<ScheduleVO> matches = scheduleService.getMonthlyMatches(month, year);
        model.addAttribute("matches", matches);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("selectedYear", year);
        
        return "views/schedule/schedule"; // JSP 경로
    }

    // 새로운 메서드 추가
    @GetMapping("/views/schedule/schedule")
    public String redirectToCurrentMonth() {
        LocalDate now = LocalDate.now();
        int month = now.getMonthValue(); // 현재 월
        int year = now.getYear(); // 현재 연도

        // 리다이렉트
        return "redirect:/schedule?month=" + month + "&year=" + year;
    }
}
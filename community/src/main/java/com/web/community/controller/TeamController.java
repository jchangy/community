package com.web.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.service.TeamService;
import com.web.community.vo.TeamVO;

@RestController
@RequestMapping("/teams") // 공통 경로 설정
public class TeamController {

    @Autowired
    private TeamService teamService;

    // 모든 팀 목록 조회
    @GetMapping
    public List<TeamVO> getAllTeams(@RequestBody(required = false) TeamVO team) {
        return teamService.getTeams(team);
    }

    // 특정 팀 조회
    @GetMapping("/{tmNum}")
    public TeamVO getTeam(@PathVariable int tmNum) {
        return teamService.getTeam(tmNum);
    }

    // 팀 생성
    @PostMapping
    public int createTeam(@RequestBody TeamVO teamVO) {
        return teamService.addTeam(teamVO);
    }

    // 팀 정보 수정
    @PutMapping
    public int updateTeams(@RequestBody List<TeamVO> teamVOs) {
        return teamService.updateTeams(teamVOs); // 다중 팀 업데이트
    }

    // 팀 삭제
    @DeleteMapping("/{tmNum}")
    public int deleteTeam(@PathVariable int tmNum) {
        return teamService.deleteTeam(tmNum);
    }
}
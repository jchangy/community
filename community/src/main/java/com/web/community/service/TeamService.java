package com.web.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.TeamMapper;
import com.web.community.vo.TeamVO;

@Service
public class TeamService {

    @Autowired
    private TeamMapper teamMapper;

    public List<TeamVO> getTeams(TeamVO team) {
        return teamMapper.selectTeams(team);
    }

    public TeamVO getTeam(int tmNum) {
        return teamMapper.selectTeam(tmNum);
    }

    public int addTeam(TeamVO teamVO) {
        return teamMapper.insertTeam(teamVO);
    }

    public int updateTeams(List<TeamVO> teamVOs) {
        return teamMapper.updateTeams(teamVOs); // 다중 업데이트 호출
    }

    public int deleteTeam(int tmNum) {
        return teamMapper.deleteTeam(tmNum);
    }
    
    
}
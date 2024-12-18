package com.web.community.mapper;

import java.util.List;

import com.web.community.vo.TeamVO;

public interface TeamMapper {

	List<TeamVO> selectTeams(TeamVO team);
	TeamVO selectTeam(int tmNum);
	int insertTeam(TeamVO teamVO);
	int updateTeam(TeamVO teamVOs);
	int updateTeams(List<TeamVO> teamVOs);
	int deleteTeam(int tmNum);
	
	List<TeamVO> getAllTeams();
}

package com.web.community.mapper;

import java.util.List;
import com.web.community.vo.PlayerVO;

public interface PlayerMapper {
    List<PlayerVO> selectPlayers(PlayerVO playerVO);          // 모든 선수 목록 조회
    PlayerVO selectPlayer(int piNum);                         // 특정 선수 조회
    int insertPlayer(PlayerVO playerVO);                      // 선수 추가
    int updatePlayer(PlayerVO playerVO);                      // 선수 수정
    int insertPlayers(List<PlayerVO> players);                // 여러 선수 추가
    int deletePlayer(int piNum);                              // 선수 삭제
    List<PlayerVO> selectPlayersByTeam(int tmNum);            // 특정 팀의 선수 목록 조회
}

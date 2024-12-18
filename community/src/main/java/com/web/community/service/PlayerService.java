package com.web.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.PlayerMapper;
import com.web.community.vo.PlayerVO;

@Service
public class PlayerService {
    @Autowired
    private PlayerMapper playerMapper;

    @Autowired
    private ApiDataService apiDataService;  // 외부 API에서 데이터를 가져오는 서비스

    // DB에서 모든 선수 목록을 조회
    public List<PlayerVO> getPlayers(PlayerVO playerVO) {
        return playerMapper.selectPlayers(playerVO);
    }

    // 특정 선수를 DB에서 조회
    public PlayerVO getPlayer(int piNum) {
        return playerMapper.selectPlayer(piNum);
    }

    // 특정 팀의 선수 목록 조회
    public List<PlayerVO> getPlayersByTeam(int tmNum) {
        return playerMapper.selectPlayersByTeam(tmNum);
    }

    // 선수 추가
    public int addPlayer(PlayerVO playerVO) {
        return playerMapper.insertPlayer(playerVO);
    }

    public int modifyPlayers(List<PlayerVO> players) {
        int result = 0;
        for(PlayerVO player : players) {
            result += modifyPlayer(player);
        }
        return result;
    }

    // 선수 정보 수정
    public int modifyPlayer(PlayerVO playerVO) {
        return playerMapper.updatePlayer(playerVO);
    }

    // 특정 선수 삭제
    public int removePlayer(int piNum) {
        return playerMapper.deletePlayer(piNum);
    }

    // 여러 선수 추가
    public int addPlayers(List<PlayerVO> players) {
        return playerMapper.insertPlayers(players);
    }

    // 특정 선수가 DB에 없으면 외부 API에서 데이터를 가져와 DB에 저장
    public PlayerVO checkAndAddPlayer(int piNum) {
        PlayerVO player = playerMapper.selectPlayer(piNum);

        if (player == null) {
            // 외부 API에서 데이터를 가져옴
            player = apiDataService.retrieveDataFromApiById(piNum);
            if (player != null) {
                // DB에 저장
                playerMapper.insertPlayer(player);
            }
        }
        return player;
    }

    // 주기적인 데이터 갱신 로직 (API에서 데이터를 받아와 갱신)
    public void updatePlayersData() {
        List<PlayerVO> updatedPlayers = apiDataService.retrieveUpdatedData();
        for (PlayerVO player : updatedPlayers) {
            playerMapper.updatePlayer(player);
        }
    }
}

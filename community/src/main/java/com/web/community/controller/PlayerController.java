package com.web.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.web.community.service.PlayerService;
import com.web.community.util.FootballDataGetterUtil;
import com.web.community.vo.PlayerVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/players") // 공통 경로 설정
@Slf4j
public class PlayerController {
    
    @Autowired
    private PlayerService playerService;
    
    @Autowired
    private FootballDataGetterUtil footballDataGetterUtil;

    // 모든 선수 목록 조회
    @GetMapping
    public List<PlayerVO> getAllPlayers(PlayerVO playerVO) {
        return playerService.getPlayers(playerVO);
    }

    // 특정 선수 조회
    @GetMapping("/player/{piNum}")
    public PlayerVO getPlayer(@PathVariable int piNum) {
        return playerService.getPlayer(piNum);
    }

    // 특정 팀의 선수 목록 조회
    @GetMapping("/team/{tmNum}")
    public List<PlayerVO> getPlayersByTeam(@PathVariable int tmNum) {
        return playerService.getPlayersByTeam(tmNum);
    }

    // 특정 선수 확인 및 추가
    @PostMapping("/player/{piNum}")
    public PlayerVO checkAndAddPlayer(@PathVariable int piNum) {
        return playerService.checkAndAddPlayer(piNum);
    }

    // 선수 추가
    @PostMapping
    public int addPlayer(@RequestBody PlayerVO player) {
        return playerService.addPlayer(player);
    }

    // 선수 수정
    @PutMapping
    public int modifyPlayers(@RequestBody List<PlayerVO> players) {
        return playerService.modifyPlayers(players);
    }

    // 선수 수정
    @PutMapping("/{piNum}")
    public int modifyPlayer(@PathVariable int piNum, @RequestBody PlayerVO player) {
        player.setPiNum(piNum);
        return playerService.modifyPlayer(player);
    }

    // 선수 삭제
    @DeleteMapping("/player/{piNum}")
    public int removePlayer(@PathVariable int piNum) {
        return playerService.removePlayer(piNum);
    }
    
    // 팀 목록 조회
    @GetMapping("/getter/teams")
    public String apiCallTest() {
        return footballDataGetterUtil.getData("/competitions/PL/teams");
    }

    // 특정 팀의 선수 데이터 조회
    @GetMapping("/getter/teams/{teamId}")
    public String apiCallTest2(@PathVariable int teamId) {
        return footballDataGetterUtil.getData("/teams/" + teamId);
    }

    // 특정 선수 데이터 조회
    @GetMapping("/getter/player/{playerId}")
    public String apiCallTest3(@PathVariable int playerId) {
        return footballDataGetterUtil.getData("/persons/" + playerId);
    }
    
    // 다수의 선수 추가
    @PostMapping("/batch")
    public int addPlayers(@RequestBody List<PlayerVO> players) {
        return playerService.addPlayers(players);
    }
}

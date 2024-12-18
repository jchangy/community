package com.web.community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.service.LikeInfoService;
import com.web.community.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class LikeInfoController {
	@Autowired
	private LikeInfoService likeInfoService;
	
	// GET 메서드 추가
    @GetMapping("/like/{piNum}")
    public Map<String, Object> getLikeStatus(@PathVariable int piNum, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 현재 로그인한 사용자의 uiNum 가져오기
        Integer uiNum = null;
    if(session.getAttribute("user") != null) {
        UserInfoVO user = (UserInfoVO) session.getAttribute("user");
        uiNum = user.getUiNum();
    }
    
    // 좋아요 상태와 총 개수 확인
    boolean liked = false;
    if(uiNum != null) {
        liked = likeInfoService.countLikeByUser(piNum, uiNum) > 0;  // session 대신 uiNum 전달
    }
    int count = likeInfoService.countLikeByPost(piNum);
    
    result.put("liked", liked);
    result.put("count", count);
    
    return result;
    }

	@GetMapping("/like/{piNum}/count")
	public int countLikeByPost(@PathVariable int piNum) {
		return likeInfoService.countLikeByPost(piNum);
	} 
	
	@GetMapping("/like/{piNum}/user")
	public int countLikeByUser(@PathVariable int piNum, HttpSession session) {
		UserInfoVO user = (UserInfoVO) session.getAttribute("user");
		Integer uiNum = user.getUiNum();
	    log.info("getUiNum=>{}", uiNum);
	    log.info("piNum=>{}", piNum);
	    
	    return likeInfoService.countLikeByUser(piNum, uiNum);
	}
	
	@PostMapping("/like/{piNum}")
    public Map<String, Object> insertLike(@PathVariable int piNum, HttpSession session) {
        UserInfoVO user = (UserInfoVO) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("error", "로그인이 필요합니다.");
            return errorResult;
        }
        return likeInfoService.insertLike(piNum, user.getUiNum());
    }
}

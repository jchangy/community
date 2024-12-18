package com.web.community.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.LikeInfoMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LikeInfoService {
	@Autowired
	private LikeInfoMapper likeInfoMapper;
	
	public int countLikeByUser(int piNum, int uiNum) {
        return likeInfoMapper.countLikeByUser(piNum, uiNum);
    }
    
    public int countLikeByPost(int piNum) {
        return likeInfoMapper.countLikeByPost(piNum);
    }
    
    public Map<String, Object> insertLike(int piNum, int uiNum) {
        Map<String, Object> result = new HashMap<>();
        
        int count = countLikeByUser(piNum, uiNum);
        if(count > 0) {
            likeInfoMapper.deleteLike(piNum, uiNum);
            result.put("liked", false);
        } else {
            likeInfoMapper.insertLike(piNum, uiNum);
            result.put("liked", true);
        }
        result.put("count", countLikeByPost(piNum));
        return result;
    }
}

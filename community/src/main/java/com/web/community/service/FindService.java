package com.web.community.service;

import com.web.community.mapper.FindMapper;
import com.web.community.vo.FindVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FindService {

    @Autowired
    private FindMapper findMapper;

    public FindVO findUserByEmail(String uiEmail) {
        return findMapper.findByEmail(uiEmail); // FindVO를 직접 반환
    }
}
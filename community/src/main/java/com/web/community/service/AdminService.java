package com.web.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.UserInfoMapper;
import com.web.community.vo.UserInfoVO;

@Service
public class AdminService {
	@Autowired
    private UserInfoMapper userInfoMapper;

    public List<UserInfoVO> isAdminLogin(int isAdmin) {
        return userInfoMapper.isAdminLogin(isAdmin); 
    }
}

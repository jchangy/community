package com.web.community.controller;

import com.web.community.service.FindService;
import com.web.community.vo.FindVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/find")
public class FindController {

    @Autowired
    private FindService findService;

    @PostMapping("/by-email")
    public FindVO findUserByEmail(@RequestParam String uiEmail) {
        // 이메일로 사용자 찾기
        return findService.findUserByEmail(uiEmail);
    }
}
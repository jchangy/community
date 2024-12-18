package com.web.community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.web.community.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {

    private boolean isAdminLogin(HttpSession session) {
        UserInfoVO user = (UserInfoVO) session.getAttribute("user");
        return user != null && user.getIsAdmin() == 1;
    }

    @GetMapping("/views/admin/{pageName}")
    public String getAdminPage(@PathVariable("pageName") String pageName, HttpSession session) {
        if (!isAdminLogin(session)) {
            return "redirect:/";
        }
        return "views/admin/" + pageName;
    }
}




package com.web.community.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class HttpSessionUtil {

	public static HttpSession getSession() {
		ServletRequestAttributes sra =  (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest req = sra.getRequest();
		HttpSession session = req.getSession();
		return session;
	}
	
	public static boolean isLogin() {
		return getSession().getAttribute("user")!=null;
	}
}

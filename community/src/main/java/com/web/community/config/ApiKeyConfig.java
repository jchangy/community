package com.web.community.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

@Component
public class ApiKeyConfig {

    @Value("${api.key}")
    private String apiKey;

    private final ServletContext servletContext;

    public ApiKeyConfig(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @PostConstruct
    public void init() {
        servletContext.setAttribute("api.key", apiKey); // JSP에서 사용할 수 있도록 ServletContext에 설정
    }
}

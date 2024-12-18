//package com.web.community.controller;
//
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpMethod;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.client.RestTemplate;
//
//@Controller
//@RequestMapping("/proxy")
//public class ProxyController {
//
//    @GetMapping("/matches")
//    public ResponseEntity<String> getMatches(@RequestParam int month) {
//        String url = "http://api.football-data.org/v4/competitions/PL/matches";
//        
//        HttpHeaders headers = new HttpHeaders();
//        headers.set("X-Auth-Token", "a61b8c6337d1474fac182286f7f3af8b");
//
//        HttpEntity<String> entity = new HttpEntity<>(headers);
//        RestTemplate restTemplate = new RestTemplate();
//        return restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
//    }
//}
package com.web.community.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.web.community.vo.Article;
import com.web.community.vo.NewsResponse;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class NewsService {

    private final RestTemplate restTemplate;
    private final String apiKey = "4bd66a39c57d4a29bd637b8d3c07755e"; // 실제 API 키로 교체

    public NewsService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 기존 News API를 통한 축구 기사 가져오기 (영어 기사만)
    public List<Article> getPopularSoccerArticles(int page, String keyword) {
        String toDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
        String fromDate = LocalDate.now().minusDays(5).format(DateTimeFormatter.ISO_DATE);

        // API 호출 URL
        String url = String.format(
            "https://newsapi.org/v2/everything?q=%s&from=%s&to=%s&sortBy=popularity&apiKey=%s&pageSize=30&page=%d&language=en",
            keyword, fromDate, toDate, apiKey, page
        );

        // API 호출
        NewsResponse response = restTemplate.getForObject(url, NewsResponse.class);
        
        if (response == null || response.getArticles() == null) {
            return Collections.emptyList();
        }

        // 이미 처리한 기사들을 저장할 Set
        Set<String> processedUrls = new HashSet<>();

        // 삭제된 기사 필터링, 사진이 없는 기사 제외 및 중복 기사 제거
        List<Article> validArticles = new ArrayList<>();
        for (Article article : response.getArticles()) {
            // 제목이나 설명에 'Removed'가 포함되어 있으면 삭제된 기사로 간주하고 제외
            // 이미지가 없는 기사는 제외
            // 같은 URL을 가진 기사는 중복 처리
            if (article.getTitle() != null && !article.getTitle().contains("Removed") &&
                article.getDescription() != null && !article.getDescription().contains("Removed") &&
                article.getUrl() != null && !article.getUrl().isEmpty() &&
                article.getUrlToImage() != null && !article.getUrlToImage().isEmpty()) {

                // 중복 URL 체크
                if (!processedUrls.contains(article.getUrl())) {
                    validArticles.add(article);
                    processedUrls.add(article.getUrl());  // 이미 처리된 URL로 추가
                }
            }
        }

        return validArticles;
    }
}

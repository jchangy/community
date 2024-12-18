package com.web.community.controller;

import com.google.api.services.youtube.model.SearchResult;
import com.web.community.service.NewsService;
import com.web.community.service.YouTubeService;
import com.web.community.vo.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ViewsController {

    private static final Logger logger = LoggerFactory.getLogger(ViewsController.class);

    @Autowired
    private NewsService newsService;

    @Autowired
    private YouTubeService youTubeService;

    /**
     * 홈 페이지를 표시합니다. 축구 뉴스와 인기 유튜브 동영상을 가져옵니다.
     * @param model 뷰에 전달할 데이터
     * @return 뷰 이름
     */
    @GetMapping("/")
    public String home(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        String keyword = "england premier league match"; // 기본 키워드 설정

        // 축구 뉴스 가져오기 (최대 6개만)
        try {
            List<Article> articles = newsService.getPopularSoccerArticles(page, keyword);
            model.addAttribute("newsArticles", articles.subList(0, Math.min(6, articles.size()))); // 첫 6개만
        } catch (Exception e) {
            logger.error("Failed to fetch news", e);
            model.addAttribute("error", "뉴스를 가져오는 데 실패했습니다.");
        }

        // 인기 축구 동영상 가져오기
        try {
            List<SearchResult> videos = youTubeService.getPopularSoccerVideos();
            
            // 최근 4개의 비디오만 가져오기
            if (videos.size() > 4) {
                videos = videos.subList(0, 4); // 첫 4개만 가져옴
            }

            model.addAttribute("videos", videos); // 4개 비디오만 모델에 전달
        } catch (IOException e) {
            logger.error("Failed to fetch popular videos", e);
            model.addAttribute("error", "동영상을 가져오는 데 실패했습니다.");
        }

        return "views/index"; // index.jsp로 포워딩
    }


    /**
     * 모든 뉴스 페이지
     * @param model 뷰에 전달할 데이터
     * @return 모든 뉴스 보기 페이지
     */
    @GetMapping("/allNews")
    public String allNews(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        String keyword = "england premier league match"; // 기본 키워드 설정

        // 축구 뉴스 가져오기 (전체)
        try {
            List<Article> articles = newsService.getPopularSoccerArticles(page, keyword);
            System.out.println("Total articles fetched: " + articles.size()); // 뉴스 개수 출력
            model.addAttribute("newsArticles", articles); // 전체 뉴스 리스트
            
            // 전체 페이지 계산 (예: 40개씩 페이지 나누기)
            int totalPages = (int) Math.ceil(articles.size() / 40.0);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("page", page); // 현재 페이지 정보
        } catch (Exception e) {
            logger.error("Failed to fetch news", e);
            model.addAttribute("error", "뉴스를 가져오는 데 실패했습니다.");
        }

        return "views/allNews"; // all-news.jsp로 포워딩
    }
    
    @GetMapping("/allVideos")
    public String showAllVideos(Model model) {
        try {
            List<SearchResult> videos = youTubeService.getPopularSoccerVideos(); // 유튜브 영상 목록 가져오기
            model.addAttribute("videos", videos); // videos 속성에 목록 추가
        } catch (IOException e) {
            model.addAttribute("error", "유튜브 영상을 가져오는 데 실패했습니다.");
        }
        return "views/allVideos"; // allVideos.jsp로 포워딩
    }

    @GetMapping("/views/**")
    public void goPage() {
    }

    /*
     * @GetMapping("/") public String home() { return "views/index"; }
     */
}

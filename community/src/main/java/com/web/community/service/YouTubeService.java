package com.web.community.service;

import com.google.api.services.youtube.model.SearchListResponse;
import com.google.api.services.youtube.model.SearchResult;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.services.youtube.YouTube;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class YouTubeService {

    private final YouTube youTube;
    private final String apiKey;

    public YouTubeService(@Value("${youtube.api.key}") String apiKey) throws GeneralSecurityException, IOException {
        this.apiKey = apiKey; // API 키 초기화
        JsonFactory jsonFactory = GsonFactory.getDefaultInstance();

        // YouTube 클라이언트 초기화
        this.youTube = new YouTube.Builder(
                GoogleNetHttpTransport.newTrustedTransport(),
                jsonFactory,
                null
        )
                .setApplicationName("community")
                .build();
    }

    public List<SearchResult> getPopularSoccerVideos() throws IOException {
        // 최근 10일 이내로 필터링
        LocalDateTime daysAgo = LocalDateTime.now().minusDays(10);
        String publishedAfterString = daysAgo.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "Z";
        DateTime publishedAfter = new DateTime(publishedAfterString);

        // SPOTV 채널 ID
        String spotvChannelId = "UCtm_QoN2SIxwCE-59shX7Qg";

        // YouTube API 검색 요청
        YouTube.Search.List search = youTube.search()
                .list("snippet")
                .setQ("프리미어리그 하이라이트")
                .setType("video")
                .setOrder("viewCount")
                .setMaxResults(30L)
                .setPublishedAfter(publishedAfter)
                .setChannelId(spotvChannelId);

        // API 키 설정
        search.setKey(apiKey);

        // 요청 실행 및 결과 반환
        SearchListResponse searchResponse = search.execute();
        return searchResponse.getItems();
    }
}

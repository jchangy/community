package com.web.community.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.text.SimpleDateFormat;
import java.util.Date;

@Getter
@Setter
public class Article {
    private String title;
    private String description;
    private String url;
    private String content;
    private String publishedAt; // 날짜 필드 (String 타입으로 유지)

    @JsonProperty("urlToImage")
    private String urlToImage; // 이미지 URL 추가

    public Article() {
        // 기본 생성자
    }

    public Article(String title, String description, String url, String urlToImage) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.urlToImage = urlToImage;
    }

    // publishedAt을 Date 객체로 변환하는 메서드
    public Date getPublishedAtAsDate() {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            return sdf.parse(this.publishedAt);
        } catch (Exception e) {
            e.printStackTrace(); // 예외 처리 (변환 실패 시 null 반환)
            return null;
        }
    }

    // JSON 형식으로 문자열 반환
    @Override
    public String toString() {
        return "{" +
                "\"title\":\"" + title + "\"," +
                "\"description\":\"" + description + "\"," +
                "\"url\":\"" + url + "\"," +
                "\"urlToImage\":\"" + urlToImage + "\"" +
                "}";
    }
}

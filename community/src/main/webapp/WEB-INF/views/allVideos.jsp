<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All YouTube Videos</title>
    <style>
    	h2{
    		margin-top:50px;
    	}
    
        /* 비디오 그리드 스타일 */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        /* 개별 비디오 카드 스타일 */
        .video-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease-in-out;
        }

        .video-card:hover {
            transform: translateY(-5px);
        }

        /* iframe(유튜브 비디오) 스타일 */
        .video-card iframe {
            width: 100%;
            height: 180px;
            border: none;
            border-bottom: 2px solid #ddd;
        }

        /* 제목 스타일 */
        .video-card h3 {
            margin: 10px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        /* 링크 스타일 */
        .video-card a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.2s ease-in-out;
        }

        .video-card a:hover {
            color: #0056b3;
        }

        /* 설명 텍스트 스타일 */
        .video-card p {
            margin: 10px;
            font-size: 14px;
            color: #666;
        }

        /* 날짜 스타일 */
        .video-card p strong {
            color: #333;
        }
    </style>
</head>

<body>
 
<div class="container py-5">
  
<h1 class="text-center mb-4 fw-bold" style="padding: 10px 0;">경기 하이라이트</h1>
    <!-- 비디오 그리드 -->
    <div class="video-grid ">
        <!-- 영상 목록을 반복문으로 출력 -->
        <c:forEach var="video" items="${videos}">
            <div class="video-card">
                <iframe src="https://www.youtube.com/embed/${video.id.videoId}"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen></iframe>
                <h3>
                    <a href="https://www.youtube.com/watch?v=${video.id.videoId}" target="_blank">
                        ${video.snippet.title}
                    </a>
                </h3>
                <p>${video.snippet.description}</p>
                <p><strong>Published on:</strong> ${video.snippet.publishedAt}</p>
            </div>
        </c:forEach>
    </div>
</div>

</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Soccer Videos and News</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            gap: 20px;
        }

        .half {
            flex: 1;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .video-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .video-item {
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s;
        }

        .video-item:hover {
            transform: scale(1.05);
        }

        .video-item h3 {
            margin: 0;
            padding: 10px;
            background-color: #3498db;
            color: white;
            text-align: center;
        }

        .video-item iframe {
            width: 100%;
            height: 200px;
            border: none;
        }

        .video-item p {
            padding: 10px;
            font-size: 14px;
            color: #555;
            background-color: #f9f9f9;
            border-top: 1px solid #3498db;
        }

        .news-item {
            background: #ffffff;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .news-item h3 {
            margin: 0;
            color: #2c3e50;
        }

        .news-item p {
            font-size: 14px;
            color: #555;
        }

        a {
            text-decoration: none;
            color: #3498db;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 유튜브 동영상 섹션 -->
        <div class="half">
            <h1>인기 축구 영상</h1>
            <c:if test="${not empty videos}">
                <div class="video-list">
                    <c:forEach items="${videos}" var="video">
                        <div class="video-item">
                            <h3>${video.snippet.title}</h3>
                            <iframe src="https://www.youtube.com/embed/${video.id.videoId}" 
                                    allowfullscreen></iframe>
                            <p>${video.snippet.description}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty videos}">
                <p>No videos found.</p>
            </c:if>
        </div>

        <!-- 뉴스 기사 섹션 -->
  <div class="half">
    <h1>축구 관련 뉴스</h1>
    <c:if test="${not empty newsArticles}">
        <c:forEach items="${newsArticles}" var="article">
            <c:if test="${not empty article.urlToImage}"> <!-- 이미지가 있는 경우에만 표시 -->
                <div class="news-item">
                    <img src="${article.urlToImage}" alt="${article.title}" style="width: 100%; height: 30%; border-radius: 8px;">
                    <h3>${article.title}</h3>
                    <p>${article.description}</p>
                    <a href="${article.url}" target="_blank">자세히 보기</a>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${empty newsArticles}">
        <p>No news articles found.</p>
    </c:if>
</div>
    </div>
</body>
</html>

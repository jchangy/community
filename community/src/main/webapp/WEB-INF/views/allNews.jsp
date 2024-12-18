<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<div class="container py-5">
			<h1 class="text-center mb-4 fw-bold" style="padding: 10px 0;">해외 축구 뉴스</h1>

			<!-- 뉴스 목록 출력 -->
			<div class="row">
				<c:forEach var="article" items="${newsArticles}">
					<div class="col-md-4 mb-5">
						<div class="card h-100 shadow border-0 rounded news-card">
							<!-- 카드 본문 -->
							<div class="card-body d-flex flex-column p-4">
								<!-- 뉴스 제목 -->
								<h5 class="card-title mb-3">
									<a href="${article.url}" class="text-dark" target="_blank">${article.title}</a>
								</h5>
								<!-- 뉴스 설명 -->
								<p class="card-text mb-3 flex-grow-1">${article.description}</p>
								
								<!-- 이미지 -->
								<c:if test="${not empty article.urlToImage}">
									<img src="${article.urlToImage}" alt="기사 이미지" class="img-fluid mb-3">
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 에러 메시지 표시 -->
			<c:if test="${not empty error}">
				<div class="alert alert-danger mt-4">
					<p>${error}</p>
				</div>
			</c:if>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>

<script>
	async function logout(){
		const response = await fetch('/logout', {
	        method: 'POST'
	    });
	    const result = await response.json();
	    
	    if (response.ok) {
	    	location.href = '/';
	    	alert('로그아웃 되었습니다.');
	    } else{
	    	location.href = '/';
	    }
	}
</script>

<style>
    /* 카드 스타일 */
    .news-card {
        transition: transform 0.4s ease, box-shadow 0.4s ease;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
        background-color: #ffffff;
        margin-top: 20px;
    }

    .news-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2);
    }

    /* 뉴스 제목 스타일 */
    .card-title a {
        text-decoration: none;
        color: #2d2d2d;
        font-weight: 700;
        font-size: 1.25rem;
        transition: color 0.3s ease;
    }

    .card-title a:hover {
        color: #0056b3; /* 링크 호버 시 색상 변화 */
    }

    /* 뉴스 설명 텍스트 스타일 */
    .card-text {
        color: #777;
        font-size: 1rem;
        line-height: 1.6;
    }

    /* 이미지 스타일 */
    .news-card img {
        border-radius: 12px;
        margin-bottom: 15px;
        width: 100%;
        max-height: 180px;
        object-fit: cover;
        transition: transform 0.3s ease;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .news-card img:hover {
        transform: scale(1.08); /* 이미지 호버 시 확대 효과 */
    }

    /* 카드 본문 여백 조정 */
    .card-body {
        padding: 24px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
    }

    /* 타이틀 스타일 */
    h1 {
        font-size: 40px;
        color: #212529;
        margin-bottom: 20px;
        font-weight: 800;
        letter-spacing: -1px;
    }

    /* 전체 레이아웃 */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 15px;
    }

    /* 뉴스 카드 레이아웃 */
    .card-columns {
        column-count: 3;
        column-gap: 1.5rem;
    }

    /* 화면이 작아질 때 2열로 */
    @media (max-width: 992px) {
        .card-columns {
            column-count: 2;
        }
    }

    /* 화면이 더 작아질 때 1열로 */
    @media (max-width: 768px) {
        .card-columns {
            column-count: 1;
        }
    }
</style>


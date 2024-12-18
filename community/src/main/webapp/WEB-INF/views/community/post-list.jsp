<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container my-5 min-vh-100 justify-content-center">
	<div class="container text-primary mb-1 fs-3 fw-bold" style="letter-spacing: -3px;">전체 게시판</div>
	<div class="border-primary mb-3" style="border-bottom:3px solid"></div>
	<div class="container p-1" style="background-color:#005dc3">
		<div class="fw-bold fs-5 m-2" style="color:#fff">화제글</div>
	</div>
	<div class="container mb-5" style="border:5px solid #005dc3">
	    <div id="hotPosts" class="container py-3">
	        <!-- 여기에 화제글이 동적으로 추가됨 -->
	    </div>
	</div>
		<c:if test="${not empty user}">
			<div class="d-flex justify-content-end">
				<button onclick="insertPost()" class="btn btn-primary"
					style="letter-spacing: 0pt">글쓰기</button>
			</div>
		</c:if>
		<div class="d-flex justify-content-between mb-3">
			<div id="total" style="display: none"></div>
			<select id="count" onchange="getPosts(1)">
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>
		</div>
		<table class="table-borderless w-100 mx-auto px-3 text-center">
			<tr class="border-primary" style="border-top: 1px solid #963cff; border-bottom: 1px solid #963cff">
				<th data-col='piNum' scope="col">번호</th>
				<th data-col='piTitle' scope="col" class="px-5 py-2" style="width:800px">제목</th>
				<th data-col='uiNickName' scope="col">닉네임</th>
				<th data-col='piCredat' scope="col">작성날짜</th>
				<th data-col='piViews' scope="col">조회수</th>
			</tr>
			<tbody id="tBody"></tbody>
		</table>
		<div class="text-center my-5">
			<span id="pagination" class="text-center"></span><br>
		</div>
		<div class="d-flex justify-content-end">
			<select id="searchOption" class="form-select" style="width:100px; height:45px">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="nickName">닉네임</option>
			</select> <input type="text" id="searchInput" class="form-control w-25 "
				placeholder="검색어 입력">
			<button id="searchButton" class="btn fw-bold btn-outline-primary"
				style="letter-spacing: 0pt">검색</button>
		</div>
	</div>
	<script>
    document.querySelector("#searchButton").addEventListener("click", function() {
        getPosts(1); // 검색 시 항상 첫 페이지부터 시작하도록 설정
    });
    
    async function getHotPosts() {
        try {
        const response = await fetch('/posts/hot');
        const posts = await response.json();
        
        if (!posts || !Array.isArray(posts)) {
            console.error('유효하지 않은 데이터:', posts);
            return;
        }
        
        let html = '';
        posts.forEach((post, index) => {
            if (!post || !post.PI_TITLE) {
                return;
            }
            
            const title = post.PI_TITLE.length > 15 ? 
                         post.PI_TITLE.substring(0, 15) + '...' : 
                         post.PI_TITLE;
            
            html += '<div class="d-flex justify-content-between align-items-center mb-2">' +
                   '<div class="d-flex align-items-center">' +
                   '<span class="me-2 fw-bold" style="color:#005dc3">' + (index + 1) + '</span>' +
                   '<a href="/views/community/post-view?piNum=' + post.PI_NUM + '" ' +
                   'class="text-decoration-none text-dark fw-bold">' +
                   title +
                   '</a>' +
                   '</div>' +
                   '</div>';
        });
        
        document.querySelector('#hotPosts').innerHTML = html;
        } catch (error) {
            console.error('화제글 로딩 중 오류:', error);
        }
    }
    
    function startHotPostsInterval() {
        getHotPosts();
        setInterval(getHotPosts, 60000); // 60초마다 갱신
    }

    function insertPost(){
        location.href="/views/community/post-insert";
    }

    function getPosts(page) {
        var count = document.querySelector('#count').value;
        const xhr = new XMLHttpRequest();
        var searchValues = document.querySelector('#searchInput').value;
        var searchOption = document.querySelector('#searchOption').value;
        var url = '/posts?page=' + page;
        
        if (searchValues.length > 0) {
            if (searchOption === 'title') {
                url += '&piTitle=' + searchValues;
            } else if (searchOption === 'content') {
                url += '&piContent=' + searchValues;
            } else if (searchOption === 'nickName') {
                url += '&uiNickName=' + searchValues;
            }
        }
        url += '&count=' + count;
        
        xhr.open('GET', url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === xhr.DONE) {
                if (xhr.status === 200) {
                    var html = '';
                    const result = JSON.parse(xhr.responseText);
                    const posts = result.list;
                    function formatDate(dateTime) {
                        return dateTime.split(' ')[0]; // 공백을 기준으로 날짜 부분만 반환
                    }
                    var totalPosts = posts.length;
                    for (const post of posts) {
                        html += '<tr style="border-bottom:1px solid #A4A4A4">';
                        html += '<td class="p-3">' + post.postNum + '</td>';
                        html += '<td class="px-3"><a href="/views/community/post-view?piNum=' + post.piNum + '" class="fw-bold">' + truncateTitle(post.piTitle) + '</a></td>';
                        html += '<td class="p-3">' + post.uiNickName + '</td>';
                        html += '<td class="p-3">' + formatDate(post.piCreated) + '</td>';
                        html += '<td class="p-3">' + post.piViews + '</td>';
                        html += '</tr>';
                    }
                    document.querySelector('#tBody').innerHTML = html;
                    document.querySelector('#total').innerText = '총 개수 : ' + result.count;
                    html = '';
                    var sNum = (Math.ceil(page / 10) - 1) * 10 + 1;
                    var lNum = sNum + 9;
                    var total = Math.ceil(result.count / count);
                    if (lNum > total) {
                        lNum = total;
                    }
                    if (sNum != 1) {
                        html += '<a href="javascript:getPosts(' + (sNum - 1) + ')">◀</a>';
                    }
                    for (var i = sNum; i <= lNum; i++) {
                        if (i === page) {
                            html += ' [' + i + ']';
                        } else {
                            html += ' <a href="javascript:getPosts(' + i + ')">[' + i + ']</a> ';
                        }
                    }
                    if (lNum != total) {
                        html += '<a href="javascript:getPosts(' + (lNum + 1) + ')">▶</a>';
                    }
                    document.querySelector('#pagination').innerHTML = html;
                }
            }
        }
        xhr.send();
    }

    function truncateTitle(title) {
        const maxLength = 15;
        return title.length > maxLength ? title.substring(0, maxLength) + '...' : title;
    }

    function cleanContent(content) {
        return content
            .replace(/<img[^>]*>/g, '')  // 이미지 태그 제거
            .replace(/<video[^>]*>.*?<\/video>/g, '')  // 비디오 태그 제거
            .replace(/<iframe[^>]*>.*?<\/iframe>/g, '')  // iframe 태그 제거
            .trim(); // 양쪽 공백 제거
    }

    window.onload = function() {
        getPosts(1);
        startHotPostsInterval();
    };
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
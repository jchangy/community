<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>다음 경기</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        let nextMatchTime; // 다음 경기 시간

        function updateCountdown() {
            const now = new Date();
            const timeDiff = nextMatchTime - now;

            if (timeDiff > 0) {
                const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000);

                document.getElementById("countdown").innerText = 
                    `${days}일 ${hours}시 ${minutes}분 ${seconds}초`;
            } else {
                document.getElementById("countdown").innerText = "경기가 시작되었습니다!";
            }
        }

        window.onload = function() {
            nextMatchTime = new Date("${nextMatchTime}").getTime(); // 서버에서 전달된 시간
            setInterval(updateCountdown, 1000); // 1초마다 업데이트
        };
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">다음 경기 정보</h1>
        <div class="card mt-4">
            <div class="card-body text-center">
                <c:if test="${not empty nextMatchInfo}">
                    <p class="h5">${nextMatchInfo}</p>
                    <p id="countdown" class="h5"></p> <!-- 남은 시간 표시 -->
                </c:if>
                <c:if test="${empty nextMatchInfo}">
                    <p class="text-danger">다음 경기가 없습니다.</p>
                </c:if>
                <a href="/schedule" class="btn btn-primary mt-3">월간 경기 일정 보기</a>
            </div>
        </div>
    </div>
</body>
</html>
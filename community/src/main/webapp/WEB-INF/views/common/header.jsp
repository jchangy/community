<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>GoalTong | News & Community</title>
    <!-- Favicon-->
    <link rel="icon" type="image/png" sizes="32x32" href="/res/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="/res/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/res/favicon/favicon-16x16.png">
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/res/css/style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        
</head>
<body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg " style="background-color:#37003c">
            <div class="container px-5">
                <a class="navbar-brand text-white fw-bold" href="/"><img
                    src="/res/images/pl-logo.png" alt=""
                    style="width: 44px; height: 56px" class="mx-3">GoalTong</a>
                <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle text-white fw-bold me-3" id="navbarDropdownNews" href="/allNews" role="button" 
                            aria-expanded="false">뉴스</a>
                            <ul class="dropdown-menu dropdown-menu-end"
                                aria-labelledby="navbarDropdownNews">
                                <li>
                                    <a class="dropdown-item" href="/allNews">뉴스</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="/allVideos">유튜브</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link text-white fw-bold me-3" href="#" onclick="redirectToSchedule()">일정</a></li> <!-- 첫 번째 코드의 일정 링크 -->
                        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle text-white fw-bold me-3" id="navbarDropdownRank" href="/views/rank/team_rank" role="button" 
                            aria-expanded="false">순위</a>
                            <ul class="dropdown-menu dropdown-menu-end"
                                aria-labelledby="navbarDropdownRank">
                                <li>
                                    <a class="dropdown-item" href="/views/scorer/scorer">득점자 순위</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle text-white fw-bold me-3" id="navbarDropdownTeamInfo" href="/views/team/team" role="button" 
                            aria-expanded="false">팀</a>
                            <ul class="dropdown-menu dropdown-menu-end"
                                aria-labelledby="navbarDropdownTeamInfo">
                                <li>
                                    <a class="dropdown-item" href="/views/match/match">팀별 경기</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link text-white fw-bold me-4" href="/views/community/post-list">커뮤니티</a></li>
                    
                        <c:if test="${empty user}">
                            <button onclick="location.href='/views/user/login'" class="btn btn-light mx-1 fw-bold">로그인</button>
                            <button onclick="location.href='/views/user/signup'" class="btn btn-light fw-bold">회원가입</button>
                        </c:if>
                        <c:if test="${not empty user}">
                            <c:if test="${user.isAdmin == 1}">
                                <button onclick="location.href='/views/admin/dashboard'" class="btn btn-warning">관리자 페이지</button>
                            </c:if>
                            <c:if test="${user.isAdmin != 1}">
                                <button onclick="location.href='/views/user/mypage'" class="btn btn-light mx-1">마이페이지</button>
                            </c:if>
                            <button onclick="logout()" class="btn btn-light">로그아웃</button>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <script>
        async function logout() {
            const response = await fetch('/logout', {
                method: 'POST'
            });
            const result = await response.json();
            
            if (response.ok) {
                // 로그아웃 성공 시 알림을 띄우고 확인 후 이동
                alert('로그아웃 되었습니다.');
                location.href = '/'; // 알림 확인 후 이동
            } else {
                // 로그아웃 실패 시에도 알림을 띄우고 이동
                alert('로그아웃에 실패했습니다. 다시 시도해 주세요.');
                location.href = '/';
            }
        }

            function redirectToSchedule() {
                const now = new Date();
                const month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더함
                const year = now.getFullYear();
                const url = `/schedule?month=${month}&year=${year}`;
                window.location.href = url; // 리다이렉트
            }
        </script>
        
    </main>
</body>
</html>
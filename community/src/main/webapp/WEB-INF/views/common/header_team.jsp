<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Teams &mdash; Colorlib Sports Team Template</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
<link rel="stylesheet" href="/res/fonts/icomoon/style.css">
<link rel="stylesheet" href="/res/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/magnific-popup.css">
<link rel="stylesheet" href="/res/css/jquery-ui.css">
<link rel="stylesheet" href="/res/css/owl.carousel.min.css">
<link rel="stylesheet" href="/res/css/owl.theme.default.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/aos.css">
<link rel="stylesheet" href="/res/css/style.css">

<style>
	.container_team{
		display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;

	
</style>
</head>

<header class="site-navbar absolute transparent" role="banner">
	<div class="container_team">
		<a href="/views/team/team"><img src="/res/images/PL_text.png" alt="PL"></a>
	</div>
	<nav
		class="site-navigation position-relative text-right bg-black text-md-right"
		role="navigation">
		<div class="container position-relative">
			<div class="site-logo">
				<a href="/"><img src="/res/images/pl-logo.png" alt=""
					style="width: 88px; height: 112px"></a>
			</div>

			<div class="d-inline-block d-md-none ml-md-0 mr-auto py-3">
				<a href="#" class="site-menu-toggle js-menu-toggle text-white"><span
					class="icon-menu h3"></span></a>
			</div>

			<ul class="site-menu js-clone-nav d-none d-md-block">
				<li class="has-children"><a href="/views/schedule/schedule">뉴스<i class="fa-solid fa-caret-down"></i></a>
					<ul class="dropdown arrow-top">
						<li><a href="/views/match/match">뉴스</a></li>
						<li><a href="/views/match/match">유튜브</a></li>
					</ul>
				</li>
				<li class="has-children"><a href="/views/rank/team_rank">순위</a></li>
				<li class="has-children"><a href="/views/schedule/schedule">일정<i class="fa-solid fa-caret-down"></i></a>
					<ul class="dropdown arrow-top">
						<li><a href="/views/match/match">팀별 경기</a></li>
					</ul>
				</li>
				
				<li><a href="/views/team/team">팀</a></li>
				<li><a href="/views/scorer/scorer">득점자</a></li>
				<li class="has-children"><a href="/views/community/post-list">커뮤니티<i class="fa-solid fa-caret-down"></i></a>
					
				</li>
					
				<c:if test="${empty user}">
					<button class="btn btn-custom">회원가입</button>
					<button onclick="location.href='/views/user/login'"
						class="btn btn-custom">로그인</button>
				</c:if>
				<c:if test="${not empty user}">
					<button onclick="logout()" class="btn btn-custom">로그아웃</button>
				</c:if>
			</ul>
		</div>
	</nav>
</header>
<script>
	async function logout() {
		const response = await
		fetch('/logout', {
			method : 'POST'
		});
		const result = await
		response.json();

		if (response.ok) {
			location.href = '/';
			alert('로그아웃 되었습니다.');
		} else {
			location.href = '/';
		}
	}
</script>
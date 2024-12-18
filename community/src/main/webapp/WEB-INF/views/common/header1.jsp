<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>GoalTong &mdash;</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
<link rel="stylesheet" href="/res/fonts/icomoon/style.css">
<link rel="stylesheet" href="/res/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/magnific-popup.css">
<link rel="stylesheet" href="/res/css/jquery-ui.css">
<link rel="stylesheet" href="/res/css/owl.carousel.min.css">
<link rel="stylesheet" href="/res/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/aos.css">
<link rel="stylesheet" href="/res/css/style.css">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<link rel="icon" type="image/png" sizes="32x32"
	href="/res/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="/res/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/res/favicon/favicon-16x16.png">
<title>Sportz &mdash; Colorlib Sports Team Template</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
<link rel="stylesheet" href="/res/fonts/icomoon/style.css">
<link rel="stylesheet" href="/res/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/magnific-popup.css">
<link rel="stylesheet" href="/res/css/jquery-ui.css">
<link rel="stylesheet" href="/res/css/owl.carousel.min.css">
<link rel="stylesheet" href="/res/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/aos.css">
<link rel="stylesheet" href="/res/css/style.css">
<style>
.has-children {
	position: relative;
}

.dropdown {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	background-color: #444;
	min-width: 160px;
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

/* 드롭다운 항목 스타일 */
.dropdown li {
	border-bottom: 1px solid #555;
}

.dropdown a {
	color: white;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

/* 드롭다운 항목에 마우스 올렸을 때 스타일 */
.dropdown a:hover {
	background-color: #575757;
}

/* 드롭다운 메뉴가 보이게 하기 위한 스타일 */
.has-children:hover .dropdown {
	display: block;
}

/* 메뉴 항목에 마우스를 올렸을 때 스타일 */
.navbar li:hover>a {
	background-color: #575757;
}

/* 로그인, 회원가입 버튼 스타일 */
.btn-custom {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	margin-left: 10px;
	cursor: pointer;
}

.btn-custom:hover {
	background-color: #0056b3;
}

/* 모바일에서 드롭다운이 제대로 보이도록 */
@media ( max-width : 767px) {
	.site-menu {
		flex-direction: column;
		background-color: #333;
	}
	.site-menu li {
		width: 100%;
		text-align: center;
	}
	.has-children .dropdown {
		position: static;
		width: 100%;
	}
	.site-menu a {
		padding: 10px 10px;
	}
}
</style>

<title>GoalTong &mdash;</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
<link rel="stylesheet" href="/res/fonts/icomoon/style.css">
<link rel="stylesheet" href="/res/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/magnific-popup.css">
<link rel="stylesheet" href="/res/css/jquery-ui.css">
<link rel="stylesheet" href="/res/css/owl.carousel.min.css">
<link rel="stylesheet" href="/res/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/res/css/aos.css">
<link rel="stylesheet" href="/res/css/style.css">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<link rel="icon" type="image/png" sizes="32x32"
	href="/res/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="/res/favicon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/res/favicon/favicon-16x16.png">
</head>

<header class="site-navbar absolute transparent" role="banner">
	<div class="py-3">
		<div class="container logo-list">
			<div>
				<nav class="clubNavigation js-club-navigation"
					data-script="pl_global-header" role="menubar">
					<ul class="clubList" role="menu">
						<div class="first_teams">
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.arsenal.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t3.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t3@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.avfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t7.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t7@x2.png 2x">

									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.afcb.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t91.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t91@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.brentfordfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t94.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t94@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.brightonandhovealbion.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t36.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t36@x2.png 2x">

									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.chelseafc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t8.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t8@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.cpfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t31.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t31@x2.png 2x">

									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.evertonfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t11.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t11@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.fulhamfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t54.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t54@x2.png 2x">

									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.itfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t40.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t40@x2.png 2x">
									</div>
							</a></li>
						</div>

						<div class="second_teams">
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.lcfc.com/?lang=en?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t13.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t13@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.liverpoolfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t14.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t14@x2.png 2x">

									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.mancity.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t43.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t43@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.manutd.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t1.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t1@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.newcastleunited.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t4.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t4@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.nottinghamforest.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t17.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t17@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.southamptonfc.com/en?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t20.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t20@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.tottenhamhotspur.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t6.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t6@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="http://www.whufc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t21.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t21@x2.png 2x">
									</div>
							</a></li>
							<li class="clubList__club"><a class="clubList__link"
								target="_blank"
								href="https://www.wolves.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
								role="menuitem">
									<div class="badge badge--large badge-image-container"
										data-widget="club-badge-image" data-size="50">
										<img class="badge-image badge-image--50 js-badge-image"
											src="https://resources.premierleague.com/premierleague/badges/50/t39.png"
											srcset="https://resources.premierleague.com/premierleague/badges/50/t39@x2.png 2x">
									</div>
							</a></li>
						</div>
					</ul>
				</nav>
			</div>
		</div>
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
				<li class="has-children"><a href="/views/schedule/schedule">뉴스<i
						class="fa-solid fa-caret-down"></i></a>
					<ul class="dropdown arrow-top">
						<li><a href="/allNews">뉴스</a></li>
						<li><a href="/allVideos">유튜브</a></li>
					</ul>
				</li>
				<li class="has-children"><a href="/views/rank/team_rank">순위</a></li>
				<li class="has-children"><a href="/views/schedule/schedule">일정<i class="fa-solid fa-caret-down"></i></a>
					<ul class="dropdown arrow-top">
						<li><a href="/views/match/match">팀별 경기</a></li>
					</ul>
				</li>
				<li><a href="/views/team/team">팀</a></li>
				<li><a href="/views/lineup/lineup">라인업</a></li>
				<li class="has-children"><a href="/views/community/post-list">커뮤니티<i
						class="fa-solid fa-caret-down"></i></a></li>

				<c:if test="${empty user}">
					<button onclick="location.href='/views/user/signup'" class="btn btn-custom">회원가입</button>
					<button onclick="location.href='/views/user/login'"
						class="btn btn-custom">로그인</button>
				</c:if>
				<c:if test="${not empty user}">
					<c:if test="${user.isAdmin == 1}">
						<a href="/views/admin/admin">관리자 페이지</a>
					</c:if>

					<c:if test="${user.isAdmin != 1}">
						<a href="/views/user/mypage">마이페이지</a>
					</c:if>

					<button onclick="logout()" class="btn btn-custom">로그아웃</button>
				</c:if>
			</ul>
		</div>
	</nav>
</header>
<script>
	async function logout() {
		const response = await fetch('/logout', {
			method : 'POST'
		});

		const result = await response.json();

		if (response.ok) {
			alert('로그아웃 되었습니다.');
			location.href = '/';
		} else {
			location.href = '/';
		}
	}
</script>
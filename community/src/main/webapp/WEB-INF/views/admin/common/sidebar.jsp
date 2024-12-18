<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
<link href="/res/css/sidebar.css" rel="stylesheet">
</head>
<body>

	<!-- 네비게이션 바 -->
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#3d195b">
		<div class="container-fluid">
			<a class="navbar-brand mx-3 text-white fw-bold fs-2" href="/">GoalTong</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row" style="height:879px">
			<!-- 사이드바 -->
			<div class="col-md-3 col-lg-2 p-3" style="background-color:#3d195b">
				<ul class="list-unstyled ps-0">
				<li><a href="/views/admin/dashboard"
					class="btn fw-bold text-white fs-3">대시보드</a></li>
				<li class="mb-1">
					<button
						class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed text-white"
						data-bs-toggle="collapse" data-bs-target="#userboard-collapse"
						aria-expanded="false">회원 관리</button>
					<div class="collapse" id="userboard-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
							<li><a href="/views/admin/user-list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white">회원
									목록</a></li>
							<li><a href="/views/admin/post-list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white">게시글
									관리</a></li>
							<li><a href="/views/admin/comment-list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white">댓글
									관리</a></li>
						</ul>
					</div>
				</li>
				<li class="mb-1">
					<button
						class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed text-white"
						data-bs-toggle="collapse" data-bs-target="#teamboard-collapse"
						aria-expanded="false">팀 관리</button>
					<div class="collapse" id="teamboard-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
							<li><a href="/views/admin/team-list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white">팀 관리</a></li>
							<li><a href="/views/admin/player-list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white">선수 관리</a></li>
						</ul>
					</div>
				</li>
				<br>
				<li class="border-top my-3"></li>
				<br>
				<li class="mb-1">
					<button
						class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed text-white"
						data-bs-toggle="collapse" data-bs-target="#account-collapse"
						aria-expanded="false">계정</button>
					<div class="collapse" id="account-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
							<li><a href="#"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded text-white"
								onclick="logout()">로그아웃</a></li>
						</ul>
					</div>
				</li>
			</ul>
			</div>
			<script src="/res/js/sidebar.js"></script>
</body>
</html>
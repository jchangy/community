<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
.bg-purple1 {
	background-color: #37003c !important; /* 프리미어리그 보라색 */
}

.btn-outline-purple1 {
	color: #37003c; /* 프리미어리그 보라색 */
	border-color: #37003c;
}

.btn-outline-purple1:hover {
	background-color: #37003c;
	color: #fff;
}

.btn-purple1 {
	background-color: #37003c;
	color: #fff;
	border-color: #37003c;
}

.btn-purple1:hover {
	background-color: #963cff;
	color: #fff;
	border-color: #963cff;
}

.border-purple1 {
	border-color: #37003c; /* 프리미어리그 보라색 */
}

.link-purple {
	color: #37003c;
}
</style>


<body class="d-flex flex-column h-100">
	<!-- Header-->
	<header class="py-3" style="background-color: #37003c">
		<div class="container px-5">
			<div class="row gx-5 align-items-center justify-content-center">
				<div class="col-lg-8 col-xl-7 col-xxl-6">
					<div class="my-5 text-center text-xl-start">
						<h1 class="display-5 fw-bolder text-white mb-2"
							style="letter-spacing: -3px">프리미어 리그</h1>
						<p class="lead text-white mb-4" style="letter-spacing: -1px">
							"2024/2025 프리미어리그 시즌이 시작되었습니다! <br> 이번 시즌 주요 경기를 확인하세요!"
						</p>
						<div
							class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
							<a class="btn btn-light btn-lg px-4 fw-bold"
								onclick="redirectToSchedule()">시즌 일정 확인</a>

						</div>
					</div>
				</div>
				<div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
					<img class="img-fluid rounded-3 my-5"
						src="https://e0.365dm.com/24/07/1600x900/skysports-premier-league-season_6629191.jpg?20240717140210"
						alt="...">
				</div>
			</div>
		</div>
	</header>
	<!-- logo section-->
	<div class="py-1 bg-light">

		<div class="container-fluid px-1 mt-3">


			<div class="club-list">

				<ul class="list-unstyled d-flex justify-content-evenly mx-3">
					<li>
						<div class="text-muted mt-2 align-items-center fw-bold">
							Club Sites <i class="bi bi-box-arrow-up-right"></i>
						</div>
					</li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.arsenal.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t3.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.avfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t7.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.afcb.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t91.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.brentfordfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t94.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.brightonandhovealbion.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t36.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.chelseafc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t8.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.cpfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t31.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.evertonfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t11.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.fulhamfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t54.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.itfc.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t40.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.lcfc.com/?lang=en?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t13.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.liverpoolfc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t14.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.mancity.com?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t43.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.manutd.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t1.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.newcastleunited.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t4.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.nottinghamforest.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t17.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.southamptonfc.com/en?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t20.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.tottenhamhotspur.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t6.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="http://www.whufc.com/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t21.png">
					</a></li>
					<li class="clubList-club"><a class="clubList__link"
						href="https://www.wolves.co.uk/?utm_source=premier-league-website&amp;utm_campaign=website&amp;utm_medium=link"
						role="menuitem"> <img class=""
							src="https://resources.premierleague.com/premierleague/badges/50/t39.png">
					</a></li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Features section -->
	<!-- 순위표 -->
	<div class="container">
		<div class="">
			<h3 class="fw-bolder mt-5" style="letter-spacing: -3px">순위 및 최신
				경기 정보</h3>
			<div class="text-muted fs-6" style="letter-spacing: -1px">
				프리미어리그의 현재 순위를 확인하고, 최신 경기와 곧 있을 경기 일정을 한눈에 볼 수 있는 공간입니다. <br>리그의
				흐름을 파악하고, 다가오는 중요한 매치를 놓치지 마세요!
			</div>
		</div>
	</div>
	<section class="container py-5 d-flex justify-content-between"
		id="features">
		<div class="site-blocks-vs site-section rounded bg-light w-50">
			<div class="container py-3">
				<h4 class="mb-4 text-center fw-bold league-heading"
					style="letter-spacing: -3px">프리미어리그 순위표</h4>
				<%
				// API URL 및 API 키 가져오기
			    String apiUrl = "http://api.football-data.org/v4/competitions/PL/standings";
			    String apiKey = (String) application.getAttribute("api.key"); // ServletContext에서 API 키 가져오기

			    // HTTP 요청 설정
			    URL url = new URL(apiUrl);
			    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			    conn.setRequestMethod("GET");
			    conn.setRequestProperty("X-Auth-Token", apiKey);
			    conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // User-Agent 추가

			    // 응답 처리
			    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			    String inputLine;
			    StringBuffer content = new StringBuffer();

			    while ((inputLine = in.readLine()) != null) {
			        content.append(inputLine);
			    }
			    in.close();
			    conn.disconnect();

			    // JSON 데이터 처리
			    ObjectMapper mapper = new ObjectMapper();
			    Map<String, Object> jsonMap = mapper.readValue(content.toString(), Map.class);
				%>

				<table class="table table-hover">
					<tr class="text-center">
						<th class="bg-purple1 text-white">순위</th>
						<th class="bg-purple1 text-white">팀</th>
						<th class="bg-purple1 text-white">경기</th>
						<th class="bg-purple1 text-white">승</th>
						<th class="bg-purple1 text-white">무</th>
						<th class="bg-purple1 text-white">패</th>
						<th class="bg-purple1 text-white">승점</th>
					</tr>
					<%
					List<Map<String, Object>> standings = (List<Map<String, Object>>) ((Map<String, Object>) ((List<Map<String, Object>>) jsonMap
							.get("standings")).get(0)).get("table");
					for (int i = 0; i < 10 && i < standings.size(); i++) { // 상위 10팀만 표시
						Map<String, Object> teamData = standings.get(i);
						Map<String, Object> team = (Map<String, Object>) teamData.get("team");
						String teamLogo = (String) team.get("crest"); // 팀 로고 URL 가져오기
					%>
					<tr class="p-3">
						<td class="text-center"><%=teamData.get("position")%></td>
						<td><img src="<%=teamLogo%>"
							alt="<%=team.get("name")%> Logo"
							style="height: 30px; width: 30px; margin-right: 8px;"> <%=team.get("name")%>
						</td>
						<td class="text-center"><%=teamData.get("playedGames")%></td>
						<td class="text-center"><%=teamData.get("won")%></td>
						<td class="text-center"><%=teamData.get("draw")%></td>
						<td class="text-center"><%=teamData.get("lost")%></td>
						<td class="text-center text-primary fw-bold"><%=teamData.get("points")%></td>
					</tr>
					<%
					}
					%>
				</table>
				<div class="text-end">
					<!-- 오른쪽 정렬을 위한 div -->
					<a
						class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover"
						style="color: #37003c" href="/views/team/team_rank">더보기<i
						class="fa-solid fa-arrow-right-long mx-1"></i></a>
				</div>
			</div>
		</div>

		<!-- Next match -->
		<div class="w-40 mx-5">
			<div class="border mb-3 rounded p-3 next-match">
				<div class="card-body text-center">
					<div
						class="mr-auto order-md-1 w-60 text-center text-lg-left mb-3 mb-lg-0">
						<h4 class="text-center fw-bold" style="letter-spacing: -3px">다음
							경기 정보</h4>
						<div class="card mt-4 p-3" id="nextMatch"></div>
					</div>
					<a onclick="redirectToSchedule()" class="btn btn-purple1 mt-3">월간
						경기 일정 보기</a>
				</div>
			</div>
			<div class="row">
				<div class="container col-md-12">
					<h5 class="text-uppercase text-black fw-bold"
						style="letter-spacing: -1px">최근 경기</h5>
					<div class="card mt-4" id="lastMatch"></div>
				</div>
			</div>
		</div>
	</section>
	<div class="container">
		<div class="">
			<h3 class="fw-bolder mt-5" style="letter-spacing: -3px">경기 하이라이트</h3>
			<div class="text-muted fs-6" style="letter-spacing: -1px">
				프리미어리그의 주요 경기 하이라이트를 모아놓은 코너입니다. <br>최신 경기의 주요 순간을 빠르게 확인해보세요.
			</div>
		</div>
		<div class="text-end">
			<!-- 오른쪽 정렬을 위한 div -->
			<a
				class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover"
				style="color: #37003c" href="/allVideos">더보기<i
				class="fa-solid fa-arrow-right-long mx-1"></i></a>
		</div>
	</div>
	<!-- highlights preview section-->
	<section class="pt-3 pb-5 container">
		<div class="row gx-5">
			<!-- 경기 하이라이트 -->
			<div class="col-lg-12 mb-3">
				<div class="card h-100 shadow border-0">
					<div class="card-body p-4">


						<div>
							<!-- 영상들을 4개씩 그룹으로 나누어 출력 -->
							<c:forEach var="video" items="${videos}" varStatus="status">
								<c:if test="${status.index % 4 == 0}">
									<!-- 새로운 그룹 시작 (4개씩 한 줄로 나열) -->
									<div class="row">
								</c:if>

								<!-- 개별 영상 카드 (4개씩 표시) -->
								<div class="col-md-3">
									<div class="card shadow border-0" style="height: 100%;">
										<div class="card-body p-0">
											<figure>
												<iframe width="100%" height="200"
													src="https://www.youtube.com/embed/${video.id.videoId}"
													frameborder="0"
													allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
													allowfullscreen></iframe>
											</figure>
											<div class="card-text p-3">
												<span class="meta text-muted">${video.snippet.publishedAt}</span>
												<h5 class="card-title mb-3">
													<a
														href="https://www.youtube.com/watch?v=${video.id.videoId}"
														class="text-black">${video.snippet.title}</a>
												</h5>
												<p>${video.snippet.description}</p>
											</div>
										</div>
									</div>
								</div>

								<c:if
									test="${status.index % 4 == 3 || status.index == videos.size() - 1}">
									<!-- 그룹 끝 (4개마다 끝내기) -->
						</div>
						</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		</div>

	</section>




	</main>


	<script>
function redirectToSchedule() {
    const now = new Date();
    const month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더함
    const year = now.getFullYear();
    const url = `/schedule?month=${month}&year=${year}`;
    window.location.href = url; // 리다이렉트
}


let nextMatchTime; // 다음 경기 시간

async function updateCountdown() {
	const res = await fetch('/nextMatch2');
	const nextMatch = await res.text();
	document.querySelector('#nextMatch').innerHTML = nextMatch;
}

window.onload = async function() {
	// 서버에서 전달된 다음 경기 시작 시간을 가져옵니다.
	await updateCountdown();
	setInterval(updateCountdown, 60000); // 1초마다 업데이트
};

async function lastNextMatch() {
    const res = await fetch('/lastMatch2');
    const nextMatch = await res.json(); // JSON으로 파싱
    const lastMatchContainer = document.querySelector('#lastMatch'); // 요소 선택

    // HTML 문자열 초기화
    let html = '';

    // 각 경기 정보를 HTML로 변환
    nextMatch.forEach(match => {
        html += 
            '<div class="row bg-white align-items-center ml-0 mr-0 py-4 match-entry">' +
            '<div class="col-md-4 col-lg-4 mb-4 mb-lg-0">' +
                '<div class="text-center text-lg-left">' +
                    '<div class="d-block d-lg-flex align-items-center">' +
                        '<div class="text-center mb-3 mb-lg-0 mr-lg-3">' +
                            '<img src="' + match.homeTeamLogo + '" alt="' + match.homeTeam + ' 로고" class="img-sm" style="width: 80px; height: 80px">' +
                        '</div>' +
                        '<div class="text">' +
                            '<h3 class="h5 mx-2 text-black fw-bold" style="letter-spacing:-1px">' + match.homeTeam + '</h3>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
            '<div class="col-md-4 col-lg-4 text-center mb-4 mb-lg-0">' +
                '<div class="d-inline-block">' +
                    '<div class="py-2 px-4 mb-2 d-inline-block rounded" style="border:1px solid #37003c">' +
                        '<span class="h5 fw-bold">' + match.homeScore + ' - ' + match.awayScore + '</span>' +
                    '</div>' +
                    '<span class="d-block text-uppercase">' + match.formattedMatchDate + '</span>' +
                '</div>' +
            '</div>' +
            '<div class="col-md-4 col-lg-4 text-center text-lg-right">' +
                '<div class="">' +
                    '<div class="d-block d-lg-flex align-items-center">' +
                        '<div class="ml-lg-3 mb-3 mb-lg-0 order-2">' +
                            '<img src="' + match.awayTeamLogo + '" alt="' + match.awayTeam + ' 로고" class="img-sm rounded-circle" style="width: 80px; height: 80px">' +
                        '</div>' +
                        '<div class="text order-1 w-100">' +
                            '<h3 class="h5 mx-2 text-black fw-bold" style="letter-spacing:-1px">' + match.awayTeam + '</h3>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';
    });

    // HTML을 요소에 삽입
    lastMatchContainer.innerHTML = html; // lastMatchContainer에 HTML 삽입
}

window.addEventListener('load', lastNextMatch);
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
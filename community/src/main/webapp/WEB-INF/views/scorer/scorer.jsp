<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>득점자 순위</title>
<style>
    /* 전체 레이아웃 설정 */
    body {
        margin: 0;
        padding: 0;
        min-height: 100vh; /* 전체 화면 높이를 기준으로 설정 */
        display: flex;
        flex-direction: column; /* 세로 정렬 */
        font-family: Arial, sans-serif;
    }

    .main-content {
        flex: 1; /* 콘텐츠 영역 확장 */
        padding: 20px;
        background-color: #f8f9fa;
    }

    /* 테이블 스타일 */
    .table-container {
        width: 50%;
        margin: 0 auto;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }

    th {
        background-color: #37003c;
        color: white;
        padding: 15px;
        font-size: 16px;
    }

    td {
        padding: 15px;
        font-size: 14px;
        color: #495057;
        vertical-align: middle;
    }
	.player-name, .team-name {
	        font-size: 24px; /* 기본 크기 14px에서 10px 증가 */
	        font-weight: bold; /* 글자를 굵게 표시 */
	    }
    h2.container.text-center.mb-4 {
	    font-weight: 700 !important;
	    
	}

	h1.container.text-center.mb-4 {
	    padding: 20px;
	    font-weight: 700!important;
	}
    /* 순위 스타일 */
    .rank {
        font-weight: bold;
        font-size: 18px;
        color: #343a40;
    }

    .rank img {
        width: 30px;
        height: 30px;
    }

    /* 득점 스타일 */
    .goals {
        font-weight: bold;
        font-size: 16px;
        color: #28a745;
    }

    /* 1등 득점 스타일 */
    .gold-goals {
        color: #FFD700; 
        font-weight: bold;
        font-size: 18px;
    }

    
</style>
</head>
<body>

<div class="main-content">
    <h1 class="container text-center mb-4">Premier League 득점자 순위</h1>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th style="width: 10%;">순위</th>
                    <th style="width: 40%;">선수</th>
                    <th style="width: 40%;">팀</th>
                    <th style="width: 10%;">득점</th>
                </tr>
            </thead>
            <tbody>
<%
    // API 키 설정
    String apiKey = "a61b8c6337d1474fac182286f7f3af8b";

    // 득점자 순위 데이터 가져오기
    String scorerApiUrl = "http://api.football-data.org/v4/competitions/PL/scorers";
    URL scorerUrl = new URL(scorerApiUrl);
    HttpURLConnection scorerConn = (HttpURLConnection) scorerUrl.openConnection();
    scorerConn.setRequestMethod("GET");
    scorerConn.setRequestProperty("X-Auth-Token", apiKey);

    BufferedReader scorerIn = new BufferedReader(new InputStreamReader(scorerConn.getInputStream()));
    String scorerInputLine;
    StringBuffer scorerContent = new StringBuffer();

    while ((scorerInputLine = scorerIn.readLine()) != null) {
        scorerContent.append(scorerInputLine);
    }
    scorerIn.close();
    scorerConn.disconnect();

    ObjectMapper mapper = new ObjectMapper();
    Map<String, Object> scorerJsonMap = mapper.readValue(scorerContent.toString(), Map.class);

    // 하드코딩된 팀명 변환 맵
    Map<String, String> translationMap = new HashMap<>();
    translationMap.put("Arsenal FC", "아스날");
    translationMap.put("Aston Villa FC", "아스톤 빌라");
    translationMap.put("Chelsea FC", "첼시");
    translationMap.put("Everton FC", "에버튼");
    translationMap.put("Fulham FC", "풀럼");
    translationMap.put("Liverpool FC", "리버풀");
    translationMap.put("Manchester City FC", "맨시티");
    translationMap.put("Manchester United FC", "맨유");
    translationMap.put("Newcastle United FC", "뉴캐슬");
    translationMap.put("Tottenham Hotspur FC", "토트넘 홋스퍼");
    translationMap.put("Wolverhampton Wanderers FC", "울버햄튼");
    translationMap.put("Leicester City FC", "레스터시티");
    translationMap.put("Southampton FC", "사우스 햄튼");
    translationMap.put("Ipswich Town FC", "입스위치 타운");
    translationMap.put("Nottingham Forest FC", "노팅엄 포레스트");
    translationMap.put("Crystal Palace FC", "크리스탈 팰리스");
    translationMap.put("Brighton & Hove Albion FC", "브라이튼");
    translationMap.put("Brentford FC", "브렌트포드");
    translationMap.put("West Ham United FC", "웨스트햄");
    translationMap.put("AFC Bournemouth", "본머스");

    // 득점자 데이터 출력
    List<Map<String, Object>> scorers = (List<Map<String, Object>>) scorerJsonMap.get("scorers");
    int rank = 1;
    int displayRank = 1;
    int previousGoals = -1;

    for (Map<String, Object> scorerData : scorers) {
        Map<String, Object> player = (Map<String, Object>) scorerData.get("player");
        Map<String, Object> team = (Map<String, Object>) scorerData.get("team");

        String playerName = player != null ? (String) player.get("name") : "Unknown";
        String teamName = team != null ? (String) team.get("name") : "Unknown";
        String translatedTeamName = translationMap.getOrDefault(teamName, teamName);

        Integer goals = scorerData.get("goals") != null ? (Integer) scorerData.get("goals") : 0;

        // 같은 득점 수라면 동일 순위로 표시
        if (goals != previousGoals) {
            displayRank = rank;
        }
        previousGoals = goals;

        // 1등에 트로피 이미지 추가 및 득점 스타일 변경
        String rankDisplay = (displayRank == 1) ? "<img src='/res/images/trophy1.jpg' alt='Trophy'>" : String.valueOf(displayRank);
        String goalsClass = (displayRank == 1) ? "gold-goals" : "goals";
%>
                <tr>
                    <td class="rank"><%= rankDisplay %></td>
                    <td class="player-name"><%= playerName %></td>
                    <td class="team-name"><%= translatedTeamName %></td>
                    <td class="<%= goalsClass %>"><%= goals %></td>
                </tr>
<%
        rank++;
    }
%>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> <!-- 푸터 -->
</body>
</html>

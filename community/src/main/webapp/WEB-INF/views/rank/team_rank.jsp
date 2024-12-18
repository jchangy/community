<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프리미어리그 순위표</title>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 30px;
        background-color: #ffffff;
        font-family: Arial, sans-serif;
        font-size: 14px;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #dddddd;
    }

    th {
        background-color: #441259;
        color: white;
        font-weight: bold;
    }

	th:first-child {
        border-left: 5px solid #441259; /* #441259 색상의 선 추가 */
    }
    
    img.team-logo {
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    .top-four {
        border-left: 5px solid #1E90FF; /* 하늘색 */
    }

    .fifth-place {
        border-left: 5px solid #7CFC00; /* 연두색 */
    }

    .relegation-zone {
        border-left: 5px solid red;
    }

    .legend {
        margin-top: 20px;
        display: flex;
        gap: 20px;
    }

    .legend-item {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .legend-color {
        width: 20px;
        height: 20px;
        display: inline-block;
    }

    .skyblue {
        background-color: #1E90FF;
    }

    .green {
        background-color: #7CFC00;
    }

    .red {
        background-color: red;
    }
    
    .box{
    	margin-left: 140px; 
    }
</style>
</head>

<body>
<br>
<h1 class="text-center mb-4 fw-bold" style="padding: 10px 0;">프리미어리그 순위표</h1>

<%
    // 팀명 변환 맵
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

    String apiUrl = "http://api.football-data.org/v4/competitions/PL/standings";
    String apiKey = "a61b8c6337d1474fac182286f7f3af8b";

    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("X-Auth-Token", apiKey);

    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    String inputLine;
    StringBuffer content = new StringBuffer();

    while ((inputLine = in.readLine()) != null) {
        content.append(inputLine);
    }
    in.close();
    conn.disconnect();

    ObjectMapper mapper = new ObjectMapper();
    Map<String, Object> jsonMap = mapper.readValue(content.toString(), Map.class);
%>

<div class="container px-5">
<table class="container w-75">
    <tr>
        <th class="fw-bold fs-6">순위</th>
        <th class="fw-bold fs-6">팀</th>
        <th class="fw-bold fs-6">로고</th>
        <th class="fw-bold fs-6">경기</th>
        <th class="fw-bold fs-6">승</th>
        <th class="fw-bold fs-6">무</th>
        <th class="fw-bold fs-6">패</th>
        <th class="fw-bold fs-6">승점</th>
    </tr>
<%
    List<Map<String, Object>> standings = (List<Map<String, Object>>) ((Map<String, Object>) ((List<Map<String, Object>>) jsonMap.get("standings")).get(0)).get("table");
    for (Map<String, Object> teamData : standings) {
        Map<String, Object> team = (Map<String, Object>) teamData.get("team");

        String teamName = (String) team.get("name");
        String translatedTeamName = translationMap.getOrDefault(teamName, teamName);
        int position = (Integer) teamData.get("position");

        String rowClass = "";
        if (position >= 1 && position <= 4) {
            rowClass = "top-four";
        } else if (position == 5) {
            rowClass = "fifth-place";
        } else if (position >= 18 && position <= 20) {
            rowClass = "relegation-zone";
        }
%>
    <tr class="<%= rowClass %>">
        <td class="fs-6"><%= position %></td>
        <td class="fs-6"><%= translatedTeamName %></td>
        <td class="fs-6"><img class="team-logo" src="<%= team.get("crest") %>" alt="<%= translatedTeamName %> 로고"></td>
        <td class="fs-6"><%= teamData.get("playedGames") %></td>
        <td class="fs-6"><%= teamData.get("won") %></td>
        <td class="fs-6"><%= teamData.get("draw") %></td>
        <td class="fs-6"><%= teamData.get("lost") %></td>
        <td class="fw-bold fs-6 text-primary"><%= teamData.get("points") %></td>
    </tr>
<%
    }
%>
</table>


		<div class="legend" style="margin-bottom:50px; margin-left: 150px">
		    <div class="legend-item">
		        <span class="legend-color skyblue"></span> UEFA 챔피언스리그 진출
		    </div>
		    <div class="legend-item">
		        <span class="legend-color green"></span> UEFA 유로파리그 진출
		    </div>
		    <div class="legend-item">
		        <span class="legend-color red"></span> 리그 강등
		    </div>
		</div>

</div>
</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
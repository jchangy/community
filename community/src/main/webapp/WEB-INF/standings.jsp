<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>리그 순위</title>
</head>
<body>
    <h1>리그 순위</h1>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <c:if test="${not empty standings}">
        <h2>총 ${standings.season.startDate} - ${standings.season.endDate} 시즌</h2>
        <table border="1">
            <tr>
                <th>순위</th>
                <th>팀</th>
                <th>로고</th>
                <th>경기수</th>
                <th>승리</th>
                <th>무승부</th>
                <th>패배</th>
                <th>점수</th>
            </tr>
            <c:forEach var="team" items="${standings.standings[0].table}">
                <tr>
                    <td>${team.position}</td>
                    <td>${team.team.name}</td>
                    <td><img src="${team.team.crest}" alt="${team.team.name} 로고" width="30" height="30"/></td>
                    <td>${team.playedGames}</td>
                    <td>${team.won}</td> <!-- 승리 -->
                    <td>${team.draw}</td> <!-- 무승부 -->
                    <td>${team.lost}</td> <!-- 패배 -->
                    <td>${team.points}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html>

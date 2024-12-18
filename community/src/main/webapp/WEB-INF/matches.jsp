<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Matches</title>
</head>
<body>
    <h1>경기 목록</h1>

    <form action="/matches" method="get">
        <label for="date">날짜:</label>
        <input type="date" id="date" name="date">
        <button type="submit">검색</button>
    </form>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <c:if test="${not empty matches}">
        <h2>총 ${matches.resultSet.count}개의 경기</h2>
        <ul>
            <c:forEach var="match" items="${matches.matches}">
                <li>
                    <strong>${match.homeTeam.name}</strong> vs <strong>${match.awayTeam.name}</strong><br>
                    날짜: ${match.utcDate}<br>
                    상태: ${match.status}<br>
                    <img src="${match.homeTeam.crest}" alt="${match.homeTeam.name} 로고" width="50" />
                    <img src="${match.awayTeam.crest}" alt="${match.awayTeam.name} 로고" width="50" />
                </li>
            </c:forEach>
        </ul>
    </c:if>
</body>
</html>
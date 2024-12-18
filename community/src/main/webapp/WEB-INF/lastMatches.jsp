<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>최근 경기 결과</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .team-logo {
            width: 30px; /* 로고 크기 조정 */
            height: 30px;
            border-radius: 50%; /* 로고를 둥글게 */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">최근 경기 결과</h1>
        <div class="mt-4">
            <c:if test="${not empty recentMatches}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>경기일자</th>
                            <th>홈팀</th>
                            <th>스코어</th>
                            <th>원정팀</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="match" items="${recentMatches}">
                            <tr>
                                <td>${match.formattedMatchDate}</td>
                                <td>
                                    <img class="team-logo" src="${match.homeTeamLogo}" alt="${match.homeTeam} 로고">
                                    ${match.homeTeam}
                                </td>
                                <td>${match.homeScore} - ${match.awayScore}</td>
                                <td>
                                    <img class="team-logo" src="${match.awayTeamLogo}" alt="${match.awayTeam} 로고">
                                    ${match.awayTeam}
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty recentMatches}">
                <p class="text-danger">최근 경기가 없습니다.</p>
            </c:if>
        </div>
        <a href="/" class="btn btn-primary mt-3">홈으로 돌아가기</a>
    </div>
</body>
</html>
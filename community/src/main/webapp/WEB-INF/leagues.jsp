<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리그 목록</title>
</head>
<body>
    <h1>리그 목록</h1>
    
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <table border="1">
        <thead>
            <tr>
                <th>리그 ID</th>
                <th>리그 이름</th>
                <th>리그 코드</th>
                <th>국가</th>
                <th>엠블럼</th>
                <th>현재 시즌 시작일</th>
                <th>현재 시즌 종료일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${leagues}" var="league">
                <tr>
                    <td>${league.id}</td>
                    <td>${league.name}</td>
                    <td>${league.code}</td>
                    <td>${league.area.name}</td>
                    <td><img src="${league.emblem}" alt="${league.name} 엠블럼" style="width:50px;height:50px;"/></td>
                    <td>${league.currentSeason.startDate}</td>
                    <td>${league.currentSeason.endDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>

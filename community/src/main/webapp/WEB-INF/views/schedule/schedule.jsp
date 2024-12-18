<%@ page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Premier League Schedule</title>
    
    <style>
        /* 기본 박스 모델 설정 */
        *, *::before, *::after {
            box-sizing: border-box; /* 모든 요소에 border-box 적용 */
        }

        /* 전체 레이아웃 설정 */
        html, body {
            height: 100%;
            margin: 0;
            display: grid;
            grid-template-rows: auto 1fr auto; /* 헤더, 콘텐츠, 푸터 */
        }

        /* 기존 스타일 유지 */
        .center-container { text-align: center; margin-bottom: 20px; }
        .btn-primary, .btn-secondary { 
            margin: 5px; 
            padding: 8px 16px; 
            border-radius: 5px; 
            font-size: 0.9em; 
            flex: 1 0 auto; /* 버튼의 너비를 자동으로 조정 */
        }
        .button-container {
            display: flex; /* 버튼을 가로로 정렬 */
            flex-wrap: wrap; /* 버튼이 줄 바꿈 가능하도록 설정 */
            justify-content: center; /* 버튼을 중앙 정렬 */
            margin-bottom: 10px; /* 버튼과 다음 요소 간격 유지 */
        }
        .table-container { width: 90%; margin: 0 auto; padding-left: 10px; padding-right: 10px; }
        
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #37003C; font-weight: bold; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        
        .badge { padding: 5px 10px; border-radius: 5px; font-size: 0.8em; color: white; }
        .badge-finished { background-color: #28a745; }
        .badge-pending { background-color: #6c757d; }

        /* 콘텐츠 스타일 */
        .content {
            padding: 20px; /* 콘텐츠와 헤더 간격 유지 */
            overflow-y: auto; /* 수직 스크롤만 허용 */
            margin-bottom: 0; /* 콘텐츠와 푸터 간의 여백 제거 */
        }

		thead {
		    color: #FFFFFF; /* 글자색 */
		}
		
		thead th {
		    padding: 12px; /* 셀 간격 유지 */
		    font-weight: bold; /* 글씨 굵게 */
		    text-transform: uppercase; /* 대문자로 표시 (선택 사항) */
		    border: 1px solid #FFFFFF; /* 흰색 경계선 (선택 사항) */
		}

		        
/* 공통 버튼 스타일 */
.btn-primary, .btn-secondary {
    margin: 5px;
    padding: 12px 24px;
    border-radius: 25px;
    font-size: 1em;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    border: none;
    transition: all 0.3s ease;
}

/* 클릭된 버튼 스타일 */
.btn-primary {
    background: linear-gradient(135deg, #F5D6C6, #A349A4); /* 강렬한 보라에서 연한 보라로 */
    color: #FFFFFF; /* 흰색 텍스트 */
    box-shadow: 0 4px 8px rgba(139, 0, 139, 0.4); /* 보라빛 그림자 */
    border: none;
    padding: 12px 24px;
    border-radius: 25px;
    font-size: 1em;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
}

/* 클릭되지 않은 버튼 스타일 */
.btn-secondary {
    background: #FFFFFF; /* 흰색 배경 */
    color: #000000; /* 검정 텍스트 */
    border: 2px solid #D3D3D3; /* 얇은 회색 테두리 */
    box-shadow: none; /* 그림자 없음 */
    padding: 12px 24px;
    border-radius: 25px;
    font-size: 1em;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
}

/* Hover 효과 */
.btn-primary:hover {
    background: linear-gradient(135deg, #A349A4, #8B008B); /* 색상 반전 */
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(139, 0, 139, 0.6); /* 더 강한 그림자 */
}

.btn-secondary:hover {
    background: #F5F5F5; /* 살짝 밝아진 배경 */
    color: #000000;
    border-color: #C0C0C0; /* 테두리도 살짝 진해짐 */
    transform: translateY(-2px);
}

/* 클릭 효과 */
.btn-primary:active {
    transform: translateY(1px); /* 클릭 시 살짝 내려감 */
    box-shadow: 0 3px 6px rgba(139, 0, 139, 0.3); /* 그림자 감소 */
}

.btn-secondary:active {
    background: #E0E0E0; /* 눌렸을 때 어두운 흰색 */
    color: #000000;
    border-color: #B0B0B0;
    transform: translateY(1px);
}





    .button-container {
	    display: flex;
	    flex-direction: column; /* 버튼을 수직으로 정렬 */
	    gap: 10px; /* 각 행 간격 추가 */
	    justify-content: center; /* 중앙 정렬 */
	    align-items: center; /* 수평 중앙 정렬 */
	    margin-bottom: 20px; /* 버튼 그룹과 아래 콘텐츠 간격 */
	}
	
	.year-row {
	    display: flex;
	    flex-wrap: wrap; /* 버튼이 줄 바꿈 가능하도록 설정 */
	    justify-content: center; /* 버튼을 가로 중앙 정렬 */
	    gap: 10px; /* 버튼 간의 간격 추가 */
	}
</style>



</head>
<body>

<div class="container">
    <div class="content">
        <div class="center-container"><br>
            
            <br>
            <div class="button-container">

			    <div class="year-row">
			        <% int currentYear = 2024; %>
			        <% for (int i = 8; i <= 12; i++) { %>
			            <button type="button" onclick="location.href='<%=request.getContextPath()%>/schedule?month=<%= i %>&year=<%= currentYear %>'" 
			                class="<%= (request.getAttribute("selectedMonth") != null && (Integer)request.getAttribute("selectedMonth") == i &&
			                            request.getAttribute("selectedYear") != null && (Integer)request.getAttribute("selectedYear") == currentYear) ? "btn-primary btn-2024" : "btn-secondary btn-2024" %>">
			                <%= currentYear %>년 <%= i %>월
			            </button>
			        <% } %>
			    </div>

			    <div class="year-row">
			        <% currentYear = 2025; %>
			        <% for (int i = 1; i <= 5; i++) { %>
			            <button type="button" onclick="location.href='<%=request.getContextPath()%>/schedule?month=<%= i %>&year=<%= currentYear %>'" 
			                class="<%= (request.getAttribute("selectedMonth") != null && (Integer)request.getAttribute("selectedMonth") == i &&
			                            request.getAttribute("selectedYear") != null && (Integer)request.getAttribute("selectedYear") == currentYear) ? "btn-primary btn-2025" : "btn-secondary btn-2025" %>">
			                <%= currentYear %>년 <%= i %>월
			            </button>
			        <% } %>
			    </div>
			</div>

        </div>
        <br>
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>날짜</th>
                    <th>홈 팀</th>
                    <th>점수</th>
                    <th>원정 팀</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="match" items="${matches}">
                    <tr>
                        <td>${match.matchDate}</td>
                        <td>
                            <img src="${match.homeTeamLogo}" alt="${match.homeTeam} Logo" style="height: 30px; width: 30px;">
                            ${match.homeTeam}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${match.homeScore != null && match.awayScore != null}">
                                    ${match.homeScore} - ${match.awayScore}
                                </c:when>
                                <c:otherwise>예정</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <img src="${match.awayTeamLogo}" alt="${match.awayTeam} Logo" style="height: 30px; width: 30px;">
                            ${match.awayTeam}
                        </td>
                        <td>
                            <span class="badge ${match.homeScore != null ? 'badge-finished' : 'badge-pending'}">
                                <c:choose>
                                    <c:when test="${match.homeScore != null}">완료</c:when>
                                    <c:otherwise>예정</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="footer">
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>

</body>
</html>
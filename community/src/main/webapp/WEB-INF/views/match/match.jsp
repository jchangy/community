<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Matches</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
    body {
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .main-content {
        flex: 1;
    }

    .team-logo {
        width: 50px;
        height: 50px;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .team-logo:hover {
        transform: scale(1.1);
        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
    }

    .match-table-container {
        padding: 20px;
        display: flex;
        justify-content: center;
    }

    table {
        width: 100%;
        max-width: 800px;
        border-collapse: collapse;
        background-color: #ffffff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
    }

    th {
        background-color: #37003c;
        color: white;
        font-weight: bold;
        padding: 10px;
        text-align: center;
    }

    td {
        padding: 15px;
        border-bottom: 1px solid #f0f0f0;
        vertical-align: middle;
    }

    td.team {
        text-align: left;
    }

    td.text-right {
        text-align: right;
    }

    td.status-finished {
        color: #4CAF50;
        font-weight: bold;

        justify-content: space-between;
        align-items: center;
    }

    td.status-scheduled {
        color: #ff9800;
        font-weight: bold;
    }

    td.status-live {
        color: #f44336;
        font-weight: bold;
    }

    .row + .row {
        margin-top: 20px !important;
    }

    .no-data {
        text-align: center;
        font-size: 14px;
        color: #888;
    }
</style>

<script>
function loadTeamMatches(teamId) {
    // 기존 데이터를 초기화
    clearTable();

    $.ajax({
        url: "/api/teamMatches",
        type: "GET",
        data: { teamId: teamId },
        success: function(data) {
            if (data.length === 0) {
                $("#matchInfo tbody").append(
                    "<tr><td colspan='5' class='no-data'>경기 데이터가 없습니다.</td></tr>"
                );
            } else {
                let newRows = "";
                let roundCounter = 1; // 라운드 번호 초기화

                data.forEach(match => {
                    let statusClass = "";

                    if (match.status === "종료됨") statusClass = "status-finished";
                    else if (match.status === "예정됨") statusClass = "status-scheduled";
                    else if (match.status === "진행 중") statusClass = "status-live";

                    newRows += "<tr>" +
                        "<td>" + match.matchDate + " " + match.matchTime + "</td>" +
                        "<td class='team'><img src='" + match.homeTeamLogo + "' class='team-logo' alt='" + match.homeTeam + " Logo'> " + match.homeTeam + "</td>" +
                        "<td>" + (match.homeScore !== null ? match.homeScore : "-") + " - " + (match.awayScore !== null ? match.awayScore : "-") + "</td>" +
                        "<td class='team text-right'>" + match.awayTeam + " <img src='" + match.awayTeamLogo + "' class='team-logo' alt='" + match.awayTeam + " Logo'></td>" +
                        "<td class='" + statusClass + "'>" + match.status + " (" + roundCounter + "R)</td>" +
                    "</tr>";

                    roundCounter++; // 라운드 번호 증가
                });

                // 새 데이터를 테이블에 추가
                $("#matchInfo tbody").append(newRows);
            }
        },
        error: function() {
            alert("Error loading match data.");
        }
    });
}

function clearTable() {
    $("#matchInfo tbody").empty();
}
</script>
</head>
<body>
<h1 class="text-center mb-4 fw-bold" style="padding: 10px 0;">각 팀들의 경기 일정</h1>

<div class="container">
    <div class="row justify-content-center">
        <!-- 첫 번째 줄에 10개 로고 -->
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Arsenal FC.png" alt="Arsenal" onclick="loadTeamMatches(57)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Aston Villa FC.png" alt="Aston Villa" onclick="loadTeamMatches(58)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/AFC Bournemouth.png" alt="Bournemouth" onclick="loadTeamMatches(1044)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Brentford FC.png" alt="Brentford" onclick="loadTeamMatches(402)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Brighton & Hove Albion FC.png" alt="Brighton" onclick="loadTeamMatches(397)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Chelsea FC.png" alt="Chelsea" onclick="loadTeamMatches(61)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Crystal Palace FC.png" alt="Crystal Palace" onclick="loadTeamMatches(354)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Everton FC.png" alt="Everton" onclick="loadTeamMatches(62)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Fulham FC.png" alt="Fulham" onclick="loadTeamMatches(63)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Ipswich Town FC.png" alt="Ipswich" onclick="loadTeamMatches(402)" class="team-logo">
        </div>
    </div>
    <div class="row justify-content-center">
        <!-- 두 번째 줄에 10개 로고 -->
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Leicester City FC.png" alt="Leicester" onclick="loadTeamMatches(338)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Liverpool FC.png" alt="Liverpool" onclick="loadTeamMatches(64)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Manchester City FC.png" alt="Man City" onclick="loadTeamMatches(65)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Manchester United FC.png" alt="Man Utd" onclick="loadTeamMatches(66)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Newcastle United FC.png" alt="New Castle" onclick="loadTeamMatches(67)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Nottingham Forest FC.png" alt="Nottingham" onclick="loadTeamMatches(351)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Southampton FC.png" alt="Southampton" onclick="loadTeamMatches(340)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Tottenham Hotspur FC.png" alt="Tottenham" onclick="loadTeamMatches(73)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/West Ham United FC.png" alt="West Ham" onclick="loadTeamMatches(74)" class="team-logo">
        </div>
        <div class="col-1 text-center mb-3">
            <img src="/res/images/Wolverhampton Wanderers FC.png" alt="Wolverhampton" onclick="loadTeamMatches(76)" class="team-logo">
        </div>
    </div>
</div>

<div id="matchInfo" class="match-table-container">
    <table>
        <thead>
            <tr>
                <th>경기 날짜</th>
                <th>홈 팀</th>
                <th>점수</th>
                <th>원정 팀</th>
                <th>결과</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="5" class="no-data">보고 싶은 팀의 경기 일정을 선택해 주세요.</td>
            </tr>
        </tbody>
    </table>
</div>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

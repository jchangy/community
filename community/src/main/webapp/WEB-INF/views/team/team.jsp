<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>팀 상세 정보</title>

<style>
    h3 {
        margin-top: 15px;
        text-align: center;
    }

    .background-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url('/res/images/ground1.jpg'); 
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        opacity: 0.3; 
        z-index: -1;
    }

    .logo-container {
        display: grid;
        grid-template-columns: repeat(5, 1fr); 
        gap: 30px; 
        justify-items: center; 
    }

    .logo {
        display: flex;
        flex-direction: column; 
        align-items: center; 
        text-align: center;
    }

    .logo-container img {
        width: 50%;
        height: auto; 
    }

    .logo a {
        text-decoration: none; 
        color: black; 
    }

    .logo p {
        margin: 5px 0 0; 
        font-size: 20px; 
    }

</style>
</head>

<body>
    <div class="background-overlay"></div>

   <h1 class="text-center mb-4 fw-bold" style="padding: 10px 0;">팀 정보 확인</h1>


    <div class="logo-container container">
        <div class="logo">
            <a href="/views/team/team-view?tmNum=1">
                <img src="/res/images/Arsenal FC.png" alt="Arsenal" />
                <p>Arsenal FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=2">
                <img src="/res/images/Aston Villa FC.png" alt="Aston" />
                <p>Aston Villa FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=3">
                <img src="/res/images/Chelsea FC.png" alt="Chelsea" />
                <p>Chelsea FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=4">
                <img src="/res/images/Everton FC.png" alt="Everton" />
                <p>Everton FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=5">
                <img src="/res/images/Fulham FC.png" alt="Fulham" />
                <p>Fulham FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=6">
                <img src="/res/images/Liverpool FC.png" alt="Liverpool" />
                <p>Liverpool FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=7">
                <img src="/res/images/Manchester City FC.png" alt="Man_City" />
                <p>Manchester City FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=8">
                <img src="/res/images/Manchester United FC.png" alt="Man_Utd" />
                <p>Manchester United FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=9">
                <img src="/res/images/Newcastle United FC.png" alt="New_Castle" />
                <p>NewCastle United FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=10">
                <img src="/res/images/Tottenham Hotspur FC.png" alt="Tottenham" />
                <p>Tottenham Hotspur FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=11">
                <img src="/res/images/Wolverhampton Wanderers FC.png" alt="Wolverhampton" />
                <p>Wolverhampton Wanderers FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=12">
                <img src="/res/images/Leicester City FC.png" alt="Leicester City" />
                <p>Leicester City FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=13">
                <img src="/res/images/Southampton FC.png" alt="Southampton" />
                <p>Southampton FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=14">
                <img src="/res/images/Ipswich Town FC.png" alt="Ipswich" />
                <p>Ipswich Town FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=15">
                <img src="/res/images/Nottingham Forest FC.png" alt="Nottingham" />
                <p>Nottingham Forest FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=16">
                <img src="/res/images/Crystal Palace FC.png" alt="Crystal_Palace" />
                <p>Crystal Palace FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=17">
                <img src="/res/images/Brighton & Hove Albion FC.png" alt="Brighton" />
                <p>Brighton & Hove Albion FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=18">
                <img src="/res/images/Brentford FC.png" alt="Brentford" />
                <p>Brentford FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=19">
                <img src="/res/images/West Ham United FC.png" alt="Westham" />
                <p>West Ham United FC</p>
            </a>
        </div>
        <div class="logo">
            <a href="/views/team/team-view?tmNum=20">
                <img src="/res/images/AFC Bournemouth.png" alt="Bournemouth" />
                <p>AFC Bournemouth</p>
            </a>
        </div>
    </div>
</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
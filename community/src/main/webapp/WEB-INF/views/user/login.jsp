<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>Login 01</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/res/css/login/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<section class="ftco-section">
    <div class="d-flex justify-content-center">
        <a class="navbar-brand" href="/">
            <!-- 기존의 이미지 태그 제거 -->
        </a>
    </div>
    <br>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-5">
                <div class="login-wrap p-4 p-md-5" style="width: 100%;"> <!-- 로그인 박스 크기 유지 -->
                    <h3 class="text-center mb-4" style="font-weight: bold; color: #333333;">
                     <a href="/"> 
                        <img src="${pageContext.request.contextPath}/res/images/pl-logo.png" alt="" style="width: 100px; height: 120px; display: block; margin: 0 auto;"> <!-- 로그인 텍스트 위에 이미지 추가 -->
                    
                    </a></h3> <!-- 로그인 텍스트 -->
                    
                    <h3 class="text-center mb-4" style="font-weight: bold; color: #333333;">로그인</h3> <!-- 로그인 텍스트 -->

                    <div id="inputBox">
                        <div class="input-form-box">
                            <span style="font-size: 15px; font-weight: bold; color: #333333;">아이디 </span> <!-- 아이디 텍스트 스타일 변경 -->
                            <input type="text" id="uiId" class="form-control rounded-left" placeholder="아이디" required>
                        </div>
                        <div class="input-form-box">
                            <span style="font-size: 15px; font-weight: bold; color: #333333;">비밀번호 </span> <!-- 비밀번호 텍스트 스타일 변경 -->
                            <input type="password" id="uiPwd" class="form-control rounded-left" placeholder="비밀번호" required>
                        </div>
                        <div class="form-group" style="margin-top: 10px;"> <!-- 비밀번호와 아이디 저장 간격 조정 -->
                            <label class="checkbox-wrap checkbox-primary" style="color: #333333; font-weight: bold;">아이디 저장 <!-- 텍스트 변경 -->
                                <input type="checkbox"> <!-- 기본 설정 체크 해제 -->
                                <span class="checkmark"></span>
                            </label>
                        </div>
                        <div class="form-group">
                            <button type="button" class="form-control btn btn-primary rounded submit px-3" style="font-weight: bold;" onclick="login()">Login</button> <!-- Login 버튼 굵기 설정 -->
                        </div>
                        <div class="form-group text-md-right" style="display: flex; justify-content: space-between;"> <!-- 정렬을 위한 flexbox 사용 -->
                            <div style="flex: 1; text-align: center;">
                                <a href="/views/user/findid" style="text-decoration: none; color: blue;">아이디 찾기</a> <!-- 아이디 찾기 링크 -->
                            </div>
                            <div style="flex: 1; text-align: center;">
                                <a href="/views/user/findpwd" style="text-decoration: none; color: blue;">비밀번호 찾기</a> <!-- 비밀번호 찾기 링크 -->
                            </div>
                            <div style="flex: 1; text-align: center;">
                                <a href="/views/user/signup" style="text-decoration: none; color: blue;">회원가입</a> <!-- 회원가입 링크 -->
                            </div>
                        </div>
                    </div>
                    
                    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                        <!-- 네이버 로그인 -->
                        <div style="text-align: center; flex: 1; cursor: pointer;" onclick="location.href='http://goaltong.store/login/naver'"> <!-- 클릭 가능하도록 수정 -->
                            <img src="/res/icons/icon_naver_on.svg" alt="Naver Login" style="width: 60px; height: 60px; margin-bottom: 5px;"> <!-- 네이버 아이콘, 아래쪽 여백을 5px로 조정 -->
                            <p class="mantine-focus-auto m-b6d8b162 mantine-Text-root" style="font-size: 15px; font-weight: bold; color: #333333; margin-top: 2.5px;">네이버 로그인</p> <!-- 글자 크기 15px로 설정, 진하게, 검은색에 가까운 회색으로 변경 -->
                        </div>
                        <!-- 카카오톡 로그인 -->
                        <div style="text-align: center; flex: 1; cursor: pointer;" onclick="location.href='http://goaltong.store/login/kakao'"> <!-- 클릭 가능하도록 수정 -->
                            <img src="/res/icons/icon_kakao.svg" alt="KakaoTalk Login" style="width: 60px; height: 60px; margin-bottom: 5px;"> <!-- 카카오톡 아이콘, 아래쪽 여백을 5px로 조정 -->
                            <p class="mantine-focus-auto m-b6d8b162 mantine-Text-root" style="font-size: 15px; font-weight: bold; color: #333333; margin-top: 2.5px;">카카오 로그인</p> <!-- 글자 크기 15px로 설정, 진하게, 검은색에 가까운 회색으로 변경 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
    // 환경에 따라 API URL 설정
    const API_BASE_URL = window.location.hostname === 'localhost' ? 
        'http://localhost:8080' : 
        'https://goaltong.store';

    async function login() {
        const param = {
            uiId: document.querySelector('#uiId').value,
            uiPwd: document.querySelector('#uiPwd').value
        };
        try {
            const response = await fetch(`${API_BASE_URL}/login`, { // 동적으로 URL 설정
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(param)
            });

            if (!response.ok) {
                throw new Error('아이디나 비밀번호가 올바르지 않습니다.');
            }
            const user = await response.json();

            if (user && (user.isAdmin == 1 || user.isAdmin == 1)) {
                location.href = `${API_BASE_URL}/views/admin/dashboard`; // 동적으로 URL 설정
            } else if (user && user.uiName) {
                alert(user.uiName + '님 안녕하세요!');
                location.href = `${API_BASE_URL}/`; // 동적으로 URL 설정
            }
        } catch (error) {
            alert('아이디나 비밀번호를 확인해주세요');
        }
    }

    async function checkAdminAccess() {
        try {
            const response = await fetch(`${API_BASE_URL}/views/admin/admin`, { // 동적으로 URL 설정
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

        } catch (error) {
            console.error('에러 발생:', error);
            alert('서버와의 연결에 문제가 발생했습니다. 다시 시도해주세요.');
        }
    }
</script>
<script src="/res/js/login/jquery.min.js"></script>
<script src="/res/js/login/bootstrap.min.js"></script>
<script src="/res/js/login/popper.js"></script>
<script src="/res/js/login/main.js"></script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

</head>
<body class="text-center">

	<!-- 전체 영역을 지정하는 container -->
	<div id="container">
	
		<!-- 로그인 폼 영역 -->
		<div id="loginBox">

			<!-- 로그인 페이지 타이틀 -->
			<div id="loginBoxTitle">
				<a href="/views/index">홈</a>
			</div>
			
			<div id="inputBox">
				<!-- 기존 input 박스들 -->
				<div class="input-form-box">
					<span>아이디 </span><input type="text" id="uiId" class="form-control">
				</div>
				<div class="input-form-box">
					<span>비밀번호 </span><input type="password" id="uiPwd" class="form-control">
				</div>
				
				<!-- 버튼 그룹 - 로그인 영역 -->
				<div class="row g-0 mt-3">
					<div class="col-6">
						<a href="javascript:login()">
							<button type="button" class="btn btn-primary btn-xs w-100">로그인</button>
						</a>
					</div>
					<div class="col-6">
						<a href="http://localhost/login/kakao" class="btn btn-warning btn-xs w-100">카카오톡 로그인</a>
					</div>
				</div>

				<!-- 네이버 로그인 버튼 추가 -->
				<div class="row g-0 mt-3">
					<div class="col-12">
						<a href="http://localhost/login/naver" class="btn btn-success btn-xs w-100">네이버 로그인</a>
					</div>
				</div>
			
				<!-- 버튼 그룹 - 회원가입 영역 -->
				<div class="row g-0 mt-3">
					<div class="col-6">
						<a href="/views/user/signup" class="btn btn-secondary btn-xs w-100">회원가입</a>
					</div>
					<div class="col-6">
						<a href="http://localhost/login/kakao" class="btn btn-warning btn-xs w-100">카카오톡 회원가입</a>
					</div>
				</div>
			</div>

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script>
	async function login() {
		const param = {
			uiId: document.querySelector('#uiId').value,
			uiPwd: document.querySelector('#uiPwd').value
		};
		try {
			const response = await fetch('/login', {
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
			    location.href = '/views/admin/admin';
			} else if (user && user.uiName) {
			    alert(user.uiName + '님 안녕하세요!');
			    location.href = '/';
			}
		} catch (error) {
			alert('아이디나 비밀번호를 확인해주세요');
		}
	}
	
	async function checkAdminAccess() {
	    try {
	        const response = await fetch('/views/admin/admin', {
	            method: 'GET',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	        });

	        const data = await response.json();  // JSON 데이터 파싱

	        // 권한 부족 응답 처리
	        if (response.status === 403) {  // 403 Forbidden 상태 코드일 경우
	            // 권한 부족 메시지 표시
	            alert(data.message || '접근이 거부되었습니다.');

	            // 리디렉션 처리
	            if (data.redirectUrl) {
	                location.href = data.redirectUrl;  // 로그인 페이지로 리디렉션
	            }
	        } else {
	            // 관리자가 접근 가능한 경우
	            console.log('관리자 페이지 접근:', data.message);
	            // 관리자 페이지 내용 처리
	        }

	    } catch (error) {
	        console.error('에러 발생:', error);
	        alert('서버와의 연결에 문제가 발생했습니다. 다시 시도해주세요.');
	    }
	}
	</script>

</body>
</html>
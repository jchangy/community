<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="en">
<head>
<title>아이디 찾기</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/res/css/login/style.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
	<section class="ftco-section">
		<div class="d-flex justify-content-center">
			<a class="navbar-brand" href="/"> <!-- 기존의 이미지 태그 제거 -->
			</a>
		</div>
		<br>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5" style="width: 100%;">
						<!-- 로그인 박스 크기 유지 -->
						<h3 class="text-center mb-4"
							style="font-weight: bold; color: #333333;">
							 <a href="/"> 
                        <img src="${pageContext.request.contextPath}/res/images/pl-logo.png" alt="" style="width: 100px; height: 120px; display: block; margin: 0 auto;"> <!-- 로그인 텍스트 위에 이미지 추가 -->
                    
                    </a></h3>


						<h3 class="text-center mb-4"
							style="font-weight: bold; color: #333333;">아이디 찾기</h3>


						<div id="inputBox">
							<div class="input-form-box mb-3">
								<label for="uiEmail" class="form-label"
									style="font-weight: bold; color: #333333;">이메일</label> <input
									type="email" id="uiEmail" class="form-control"
									placeholder="이메일" required>
								<button type="button"
									class="form-control btn btn-primary rounded submit px-3 mt-2"
									style="font-weight: bold;"
									onclick="sendVerificationEmailForId(this)">인증번호 전송</button>
							</div>
							<div class="input-form-box mb-3">
								<label for="verificationCode" class="form-label"
									style="font-weight: bold; color: #333333;">인증번호</label> <input
									type="text" id="verificationCode" class="form-control"
									placeholder="인증번호" required>
								<button type="button" class="btn btn-primary mt-2"
									style="font-weight: bold;" onclick="verifyCode(this)">확인</button>
							</div>
							<!-- 사용자 ID를 표시할 텍스트 필드 -->
							<div class="input-form-box mb-3" id="userIdBox"
								style="display: none;">
								<label for="userId" class="form-label"
									style="font-weight: bold; color: #333333;">찾은 ID</label> <input
									type="text" id="userId" class="form-control"
									placeholder="사용자 ID" readonly>
							</div>
						</div>
						<!-- 홈으로 가는 버튼 추가 -->
						<div class="text-center mt-4">
							<button type="button" class="btn btn-primary" onclick="goHome()">홈으로</button>
							<button type="button" class="btn btn-primary"
								onclick="gofindpwd()">비밀번호 찾기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<script>
    function ajax({ url, method, param, json, callback }) {
        const xhr = new XMLHttpRequest();
        xhr.open(method, url, true);
        if (json) {
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        }
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                callback(xhr.status === 200 ? JSON.parse(xhr.responseText) : null);
            }
        };
        xhr.send(param);
    }

    function sendVerificationEmailForId(button) {
        const email = document.querySelector('#uiEmail').value; // 이메일 입력 필드에서 값 가져오기
        ajax({
            url: '/sendVerificationEmail2', // 이메일 인증을 위한 서버 엔드포인트 (2로 변경)
            method: 'POST',
            param: JSON.stringify({ email: email }), // 이메일만 전송
            json: true,
            callback: function(res) {
                if (!res) {
                    alert('이메일을 찾을 수 없습니다. 이메일을 다시 확인해 주세요.');
                } else {
                    alert(res.message);
                    // 버튼 색상 변경
                    button.classList.remove('btn-primary');
                    button.classList.add('btn-secondary'); // 회색으로 변경
                }
            }
        });
    }

    function verifyCode(button) {
        const verificationCode = document.querySelector('#verificationCode').value.trim();
        const email = document.querySelector('#uiEmail').value; // 이메일 추가

        // 입력된 인증번호를 로그로 출력
        console.log("입력된 인증번호:", verificationCode); // 이 줄을 추가합니다.

        ajax({
            url: '/verifyCode', // 인증번호 확인을 위한 서버 엔드포인트
            method: 'POST',
            param: JSON.stringify({ email: email, code: verificationCode }), // 이메일과 인증번호 전송
            json: true,
            callback: function(res) {
                if (!res) {
                    alert('인증번호 확인에 실패했습니다. 다시 시도하세요.');
                } else {
                    if (res.valid) {
                        alert('인증번호가 확인되었습니다.');

                        // 사용자 ID를 표시
                        document.getElementById('userId').value = res.userId; // 사용자 ID를 입력 필드에 설정
                        document.getElementById('userIdBox').style.display = 'block'; // 사용자 ID 박스 표시

                        // 버튼 색상 변경
                        button.classList.remove('btn-primary');
                        button.classList.add('btn-secondary'); // 회색으로 변경
                    } else {
                        alert(res.message || '인증번호가 일치하지 않습니다.'); // 서버에서 반환된 메시지 표시
                    }
                }
            }
        });
    }
    function goHome() {
        window.location.href = '/'; // 홈으로 리다이렉트
    }
    function  gofindpwd() {
        window.location.href = '/views/user/findpwd'; // 홈으로 리다이렉트
    }
</script>

</body>
</html>
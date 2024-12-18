<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="en">
<head>
    <title>비밀번호 찾기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/res/css/login/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
    <section class="ftco-section">
        <br>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-7 col-lg-5">
                    <div class="login-wrap p-4 p-md-5" style="width: 100%;">
                        <h3 class="text-center mb-4" style="font-weight: bold; color: #333333;">
                             <a href="/"> 
                        <img src="${pageContext.request.contextPath}/res/images/pl-logo.png" alt="" style="width: 100px; height: 120px; display: block; margin: 0 auto;"> <!-- 로그인 텍스트 위에 이미지 추가 -->
                    
                    </a></h3>
                        
                        <h3 class="text-center mb-4" style="font-weight: bold; color: #333333;">비밀번호 찾기</h3>

                        <div id="inputBox">
                            <div class="input-form-box mb-3">
                                <label for="uiId" class="form-label" style="font-weight: bold; color: #333333;">아이디</label>
                                <input type="text" id="uiId" class="form-control" placeholder="아이디" required>
                            </div>
                            <div class="input-form-box mb-3">
                                <label for="uiEmail" class="form-label" style="font-weight: bold; color: #333333;">이메일</label>
                                <input type="email" id="uiEmail" class="form-control" placeholder="이메일" required>
                            </div>
                            <div class="form-group">
                                <button type="button" class="form-control btn btn-primary rounded submit px-3" style="font-weight: bold;" onclick="sendVerificationEmailForPassword(this)">인증번호 전송</button>
                                <!-- 이메일 인증 버튼 -->
                            </div>
                            <div class="input-form-box mb-3">
                                <label for="verificationCode" class="form-label" style="font-weight: bold; color: #333333;">인증번호</label>
                                <input type="text" id="verificationCode" class="form-control" placeholder="인증번호" required>
                                <button type="button" class="btn btn-primary mt-2" style="font-weight: bold;" onclick="verifyCode(this)">확인</button>
                                <!-- 인증번호 확인 버튼 -->
                            </div>
                            <div class="input-form-box mb-3" id="newPasswordBox" style="display: none;">
                                <label for="newPassword" class="form-label" style="font-weight: bold; color: #333333;">새 비밀번호</label>
                                <input type="password" id="newPassword" class="form-control" placeholder="새 비밀번호" required>
                            </div>
                            <div class="form-group" id="changePasswordButton" style="display: none;">
                                <button type="button" class="form-control btn btn-primary rounded submit px-3" style="font-weight: bold;" onclick="changePassword(this)">확인</button>
                                <!-- 비밀번호 변경 버튼 -->
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
        let isVerificationValid = false; // 인증번호 유효성 상태

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

        function sendVerificationEmailForPassword(button) {
            const uiId = document.querySelector('#uiId').value; // 아이디 입력 필드에서 값 가져오기
            const uiEmail = document.querySelector('#uiEmail').value; // 이메일 입력 필드에서 값 가져오기

            // 이메일 인증 요청
            ajax({
                url: '/sendVerificationEmail', // 이메일 인증을 위한 서버 엔드포인트
                method: 'POST',
                param: JSON.stringify({ uiId: uiId, email: uiEmail }), // 아이디와 이메일 전송
                json: true,
                callback: function(res) {
                    if (!res) {
                        alert('인증번호 전송에 실패했습니다. 아이디와 이메일을 확인해 주세요.');
                    } else {
                        alert(res.message); // 서버에서 반환된 메시지 표시
                        // 버튼 색상 변경
                        button.classList.remove('btn-primary');
                        button.classList.add('btn-secondary'); // 회색으로 변경
                    }
                }
            });
        }

        function verifyCode(button) {
            const uiId = document.querySelector('#uiId').value;
            const uiEmail = document.querySelector('#uiEmail').value;
            const verificationCode = document.querySelector('#verificationCode').value;

            // 인증번호 확인 요청
            ajax({
                url: '/verifyCode', // 인증번호 확인을 위한 서버 엔드포인트
                method: 'POST',
                param: JSON.stringify({ email: uiEmail, code: verificationCode }), // 'id'를 'uiId'로 수정
                json: true,
                callback: function(res) {
                    if (!res) {
                        alert('인증번호 확인에 실패했습니다. 다시 시도하세요.');
                    } else {
                        if (res.valid) {
                            isVerificationValid = true; // 인증번호가 유효함
                            alert('인증번호가 확인되었습니다. 비밀번호를 변경할 수 있습니다.');

                            // 새 비밀번호 입력 필드와 버튼 표시
                            document.getElementById('newPasswordBox').style.display = 'block';
                            document.getElementById('changePasswordButton').style.display = 'block';

                            // 버튼 색상 변경
                            button.classList.remove('btn-primary');
                            button.classList.add('btn-secondary'); // 회색으로 변경
                        } else {
                            alert('인증번호가 일치하지 않습니다.');
                            isVerificationValid = false; // 인증번호가 유효하지 않음
                        }
                    }
                }
            });
        }

        function changePassword(button) {
            if (!isVerificationValid) {
                alert('인증번호를 먼저 확인해 주세요.');
                return; // 인증번호가 유효하지 않으면 비밀번호 변경을 진행하지 않음
            }

            const uiId = document.querySelector('#uiId').value;
            const uiEmail = document.querySelector('#uiEmail').value;
            const newPassword = document.querySelector('#newPassword').value;

            // 비밀번호 변경 요청
            ajax({
                url: '/changePassword', // 비밀번호 변경을 위한 서버 엔드포인트
                method: 'POST',
                param: JSON.stringify({ uiId: uiId, email: uiEmail, uiPwd: newPassword }),
                json: true,
                callback: function(res) {
                    if (!res) {
                        alert('비밀번호 변경에 실패했습니다. 다시 시도하세요.');
                    } else {
                        alert(res.message); // 서버에서 반환된 메시지 표시
                        if (res.message === "비밀번호가 변경되었습니다.") {
                            // 비밀번호 변경 성공 시 확인 대화상자 표시
                            if (confirm("비밀번호가 변경되었습니다. 확인을 누르면 로그인 화면으로 이동합니다.")) {
                                // 확인 버튼을 누르면 로그인 화면으로 리다이렉트
                                window.location.href = "https://goaltong.store/views/user/login";
                            }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>
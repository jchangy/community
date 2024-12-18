<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
        <div class="container py-5">
            <h2 class="text-center mb-4 fw-bold" style="font-size: 24px; font-weight: bold; color: #333333;">회원가입</h2> <!-- 글자 크기 및 굵기 설정 -->
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow border-0">
                        <div class="card-body p-4">
                            <!-- 회원가입 폼 시작 -->
                            <form id="signupForm">
                                <!-- 이름 입력 -->
                                <div class="mb-3">
                                    <label for="uiName" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">이름</label> 
                                    <input type="text" class="form-control" id="uiName" required>
                                </div>
                                <!-- 아이디 입력 -->
                                <div class="mb-3">
                                    <label for="uiId" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">아이디</label> 
                                    <input type="text" class="form-control" id="uiId" required>
                                    <button type="button" class="btn btn-primary btn-sm mt-2" onclick="checkId()">중복 확인</button> <!-- 버튼 색상 변경 -->
                                    <div id="idCheckMessage" class="mt-2" style="display: none;"></div>
                                </div>
                                <!-- 비밀번호 입력 -->
                                <div class="mb-3">
                                    <label for="uiPwd" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">비밀번호</label> 
                                    <input type="password" class="form-control" id="uiPwd" required>
                                </div>
                                <!-- 닉네임 입력 -->
                                <div class="mb-3">
                                    <label for="uiNickName" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">닉네임</label> 
                                    <input type="text" class="form-control" id="uiNickName">
                                    <button type="button" class="btn btn-primary btn-sm mt-2" onclick="checkNickname()">중복 확인</button> <!-- 버튼 색상 변경 -->
                                    <div id="nicknameCheckMessage" class="mt-2" style="display: none;"></div>
                                </div>

                                <!-- 이메일 입력 -->
                                <div class="mb-3">
                                    <label for="uiEmail" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">이메일</label> 
                                    <input type="email" class="form-control" id="uiEmail" required onchange="handleEmailChange()">
                                    <button type="button" class="btn btn-primary btn-sm mt-2" onclick="checkEmail()">중복 확인</button> <!-- 버튼 색상 변경 -->
                                 <button type="button" class="btn btn-primary btn-sm mt-2" id="sendVerificationButton" style="display: none;" onclick="sendVerificationEmailForSignUp()">인증번호 전송</button> 
                                    <div id="emailCheckMessage" class="mt-2" style="display: none;"></div>
                                </div>

                                <!-- 이메일 인증번호 입력 -->
                                <div class="mb-3" id="verificationCodeBox" style="display: none;">
                                    <label for="uiVerificationCode" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">인증번호</label>
                                    <input type="text" class="form-control" id="uiVerificationCode" required>
                                    <button type="button" class="btn btn-primary btn-sm mt-2" onclick="verifyCode()">확인</button> <!-- 버튼 색상 변경 -->
                                    <div id="verificationMessage" class="mt-2" style="display: none;"></div>
                                </div>
                                <!-- 전화번호 입력 -->
                                <div class="mb-3">
                                    <label for="uiPhone" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">전화번호 (선택)</label> 
                                    <input type="text" class="form-control" id="uiPhone">
                                </div>
                                <!-- 좋아하는 팀 선택 -->
                                <div class="mb-3">
                                    <label for="uiFavorite" class="form-label" style="font-size: 15px; font-weight: bold; color: #333333;">좋아하는 팀</label> 
                                    <select id="uiFavorite" class="form-control">
                                        <option value="">좋아하는 팀을 선택하세요</option>
                                        <option value="맨시티">맨시티</option>
                                        <option value="리버풀">리버풀</option>
                                        <option value="아스날">아스날</option>
                                        <option value="첼시">첼시</option>
                                        <option value="맨유">맨유</option>
                                        <option value="토트넘">토트넘</option>
                                        <option value="뉴캐슬">뉴캐슬</option>
                                        <option value="브라이튼">브라이튼</option>
                                        <option value="애스턴 빌라">애스턴 빌라</option>
                                        <option value="번리">번리</option>
                                        <option value="울버햄튼">울버햄튼</option>
                                        <option value="에버튼">에버튼</option>
                                        <option value="레스터">레스터</option>
                                        <option value="셰필드 유나이티드">셰필드 유나이티드</option>
                                        <option value="크리스탈 팰리스">크리스탈 팰리스</option>
                                        <option value="리즈 유나이티드">리즈 유나이티드</option>
                                        <option value="스완지 시티">스완지 시티</option>
                                        <option value="사우샘프턴">사우샘프턴</option>
                                    </select>
                                </div>
                                <!-- 회원가입 버튼 -->
                                <div class="d-grid">
                                    <button type="button" class="btn btn-primary" onclick="signUp()">회원가입</button> <!-- 버튼 색상 설정 -->
                                </div>
                            </form>
                            <!-- 회원가입 폼 끝 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        let initialUiId = '';
        let initialUiNickName = '';
        let initialUiEmail = ''; 
        let isVerificationCodeValid = false;
        let isIdAvailable = false;
        let isNicknameAvailable = false;
        let isEmailAvailable = false; 

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

        function sendVerificationEmailForSignUp() {
            const email = document.querySelector('#uiEmail').value;
            const uiId = document.querySelector('#uiId').value.trim();
            
            // 이메일이 비어 있는지 확인
            if (!email) {
                alert('이메일을 입력해 주세요.');
                return;
            }

            ajax({
                url: '/sendVerificationEmailForSignUp', // URL을 수정
                method: 'POST',
                param: JSON.stringify({ uiId: uiId, email: email }),
                json: true,
                callback: function(res) {
                    if (!res) {
                        alert('인증번호 전송에 실패했습니다. 이메일을 확인해 주세요.');
                    } else {
                        alert(res.message);
                        document.querySelector('#verificationCodeBox').style.display = 'block'; // 인증 코드 입력 박스 표시
                        document.querySelector('#uiVerificationCode').disabled = false; // 인증번호 입력란 활성화
                        document.querySelector('#uiVerificationCode').value = ''; // 입력란 초기화
                        document.querySelector('#verificationMessage').style.display = 'none'; // 메시지 숨김
                    }
                }
            });
        }

        function verifyCode() {
            const verificationCode = document.querySelector('#uiVerificationCode').value.trim();
            ajax({
                url: '/verifyCode',
                method: 'POST',
                param: JSON.stringify({ code: verificationCode }),
                json: true,
                callback: function(res) {
                    const messageDiv = document.querySelector('#verificationMessage');
                    if (!res) {
                        messageDiv.textContent = '인증번호 확인에 실패했습니다. 다시 시도하세요.';
                        messageDiv.style.display = 'block';
                        messageDiv.style.color = 'red';
                        isVerificationCodeValid = false;
                    } else {
                        if (res.valid) {
                            messageDiv.textContent = '인증번호가 확인되었습니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'green';
                            isVerificationCodeValid = true;
                            document.querySelector('#uiVerificationCode').disabled = true;

                            // 인증번호가 일치할 때 버튼 색상 변경
                            const verifyButton = document.querySelector('button[onclick="verifyCode()"]');
                            verifyButton.classList.remove('btn-primary');
                            verifyButton.classList.add('btn-secondary'); // 클릭 후 회색으로 변경
                        } else {
                            messageDiv.textContent = '인증번호가 일치하지 않습니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'red';
                            isVerificationCodeValid = false;
                        }
                    }
                }
            });
        }

        function checkId() {
            const uiId = document.querySelector('#uiId').value;
            initialUiId = uiId;
            document.querySelector('#idCheckMessage').style.display = 'none';
            ajax({
                url: '/checkId',
                method: 'POST',
                param: JSON.stringify({ uiId: uiId }),
                json: true,
                callback: function(res) {
                    const messageDiv = document.querySelector('#idCheckMessage');
                    if (res && res.available !== undefined) {
                        if (res.available) {
                            messageDiv.textContent = '사용 가능한 아이디입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'green';
                            isIdAvailable = true;

                            // 사용 가능한 경우 버튼 색상 변경
                            const checkIdButton = document.querySelector('button[onclick="checkId()"]');
                            checkIdButton.classList.remove('btn-primary');
                            checkIdButton.classList.add('btn-secondary'); // 클릭 후 회색으로 변경
                        } else {
                            messageDiv.textContent = '이미 사용 중인 아이디입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'red';
                            isIdAvailable = false;
                        }
                    } else {
                        messageDiv.textContent = '아이디 중복 확인에 실패했습니다.';
                        messageDiv.style.display = 'block';
                        messageDiv.style.color = 'red';
                        isIdAvailable = false;
                    }
                }
            });
        }

        function checkNickname() {
            const uiNickName = document.querySelector('#uiNickName').value;
            initialUiNickName = uiNickName;
            document.querySelector('#nicknameCheckMessage').style.display = 'none';
            ajax({
                url: '/checkNickname',
                method: 'POST',
                param: JSON.stringify({ uiNickName: uiNickName }),
                json: true,
                callback: function(res) {
                    const messageDiv = document.querySelector('#nicknameCheckMessage');
                    if (res && res.available !== undefined) {
                        if (res.available) {
                            messageDiv.textContent = '사용 가능한 닉네임입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'green';
                            isNicknameAvailable = true;

                            // 사용 가능한 경우 버튼 색상 변경
                            const checkNicknameButton = document.querySelector('button[onclick="checkNickname()"]');
                            checkNicknameButton.classList.remove('btn-primary');
                            checkNicknameButton.classList.add('btn-secondary'); // 클릭 후 회색으로 변경
                        } else {
                            messageDiv.textContent = '이미 사용 중인 닉네임입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'red';
                            isNicknameAvailable = false;
                        }
                    } else {
                        messageDiv.textContent = '닉네임 중복 확인에 실패했습니다.';
                        messageDiv.style.display = 'block';
                        messageDiv.style.color = 'red';
                        isNicknameAvailable = false;
                    }
                }
            });
        }

        function checkEmail() {
            const uiEmail = document.querySelector('#uiEmail').value;
            const messageDiv = document.querySelector('#emailCheckMessage');
            const sendVerificationButton = document.querySelector('#sendVerificationButton');
            
            messageDiv.style.display = 'none'; // 초기화
            sendVerificationButton.style.display = 'none'; // 인증번호 전송 버튼 숨김
            isEmailAvailable = false; // 초기화

            ajax({
                url: '/checkEmail',
                method: 'POST',
                param: JSON.stringify({ uiEmail: uiEmail }),
                json: true,
                callback: function(res) {
                    if (res && res.available !== undefined) {
                        if (res.available) {
                            messageDiv.textContent = '사용 가능한 이메일입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'green';
                            sendVerificationButton.style.display = 'block'; // 버튼 표시
                            isEmailAvailable = true; // 이메일 사용 가능

                            // 사용 가능한 경우 버튼 색상 변경
                            sendVerificationButton.classList.remove('btn-primary');
                            sendVerificationButton.classList.add('btn-secondary'); // 클릭 후 회색으로 변경
                        } else {
                            messageDiv.textContent = '이미 사용 중인 이메일입니다.';
                            messageDiv.style.display = 'block';
                            messageDiv.style.color = 'red';
                            sendVerificationButton.style.display = 'none'; // 버튼 숨김
                            isEmailAvailable = false; // 이메일 사용 불가
                        }
                    } else {
                        messageDiv.textContent = '이메일 중복 확인에 실패했습니다.';
                        messageDiv.style.display = 'block';
                        messageDiv.style.color = 'red';
                        sendVerificationButton.style.display = 'none'; // 버튼 숨김
                        isEmailAvailable = false; // 이메일 사용 불가
                    }
                }
            });
        }

        function handleEmailChange() {
            initialUiEmail = document.querySelector('#uiEmail').value.trim(); // 현재 이메일 저장
            isEmailAvailable = false; // 이메일 사용 가능 여부 초기화
            isVerificationCodeValid = false; // 인증 코드 유효성 초기화
            document.querySelector('#emailCheckMessage').style.display = 'none'; // 메시지 숨김
            document.querySelector('#sendVerificationButton').style.display = 'none'; // 인증번호 전송 버튼 숨김
        }

        function signUp() {
            const uiName = document.querySelector('#uiName').value.trim();
            const uiId = document.querySelector('#uiId').value.trim();
            const uiPwd = document.querySelector('#uiPwd').value;
            const uiNickName = document.querySelector('#uiNickName').value.trim();
            const uiEmail = document.querySelector('#uiEmail').value.trim();
            const uiPhone = document.querySelector('#uiPhone').value.trim();
            const uiFavorite = document.querySelector('#uiFavorite').value;

            if (!uiName || !uiId || !uiPwd || !uiNickName || !uiEmail || !uiFavorite) {
                alert('모든 필드를 올바르게 입력해주세요.');
                return;
            }

            if (!isIdAvailable) {
                alert('아이디 중복 확인을 해주세요.');
                return;
            }

            if (!isNicknameAvailable) {
                alert('닉네임 중복 확인을 해주세요.');
                return;
            }

            if (!isEmailAvailable) { // 이메일 중복 확인 추가
                alert('이메일 중복 확인을 해주세요.');
                return;
            }

            if (!isVerificationCodeValid) { // 이메일 인증 확인 추가
                alert('이메일 인증을 다시 해주세요.'); // 이메일 인증 알림
                return;
            }

            if (uiId !== initialUiId) {
                document.querySelector('#idCheckMessage').style.display = 'none';
                alert('아이디가 변경되었습니다. 다시 중복 확인을 해주세요.');
                return;
            }

            if (uiNickName !== initialUiNickName) {
                document.querySelector('#nicknameCheckMessage').style.display = 'none';
                alert('닉네임이 변경되었습니다. 다시 중복 확인을 해주세요.');
                return;
            }

            if (uiEmail !== initialUiEmail) { // 이메일 변경 확인 추가
                document.querySelector('#emailCheckMessage').style.display = 'none';
                alert('이메일이 변경되었습니다. 다시 중복 확인을 해주세요.');
                return;
            }

            const param = {
                uiName: uiName,
                uiId: uiId,
                uiPwd: uiPwd,
                uiNickName: uiNickName,
                uiEmail: uiEmail,
                uiPhone: uiPhone,
                uiFavorite: uiFavorite
            };

            console.log("회원가입 요청 파라미터:", param);

            ajax({
                url: '/signUp',
                method: 'POST',
                param: JSON.stringify(param),
                json: true,
                callback: function(res) {
                    if (res) {
                        if (res.success) {
                            alert('회원가입이 완료되었습니다.');
                            window.location.href = '/views/user/login';
                        } else {
                            alert(res.message || '회원가입에 실패했습니다. 다시 시도해 주세요.');
                        }
                    } else {
                        alert('서버 응답이 없습니다. 나중에 다시 시도해 주세요.');
                    }
                }
            });
        }
    </script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
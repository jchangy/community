<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
<!-- 부트스트랩 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- 사용자 정의 스타일 -->
  <style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa; /* 배경색 설정 */
        margin: 0; /* 페이지 전체의 여백을 없앰 */
    }
    h1, h2 {
        color: #343a40; /* 텍스트 색상 */
        text-align: center;
        margin-bottom: 30px;
    }
    /* 폼 컨테이너 (위, 아래, 양옆 여백 추가) */
    .container1 {
        background-color: #fff;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        max-width: 1200px; /* 최대 너비를 1200px로 설정 */
        width: 100%; /* 화면에 꽉 차도록 100% */
        margin: 40px auto; /* 위와 아래에 40px 여백 추가 */
    }
    .form-group {
        margin-bottom: 1.5rem;
    }
    /* 입력 필드 스타일 */
    input.form-control, select.form-control {
        font-size: 1rem;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    input.form-control:focus, select.form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }
    .form-control[readonly] {
        background-color: #f1f1f1;
        border-color: #ddd;
    }
    /* 버튼 스타일 */
    button {
        padding: 10px 20px;
        font-size: 1rem;
        border-radius: 4px;
    }
    button[type="button"] {
        cursor: pointer;
        width: 100%;
        margin-top: 10px;
    }
    .btn-primary {
        background-color: #007bff;
        border: none;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    .btn-danger {
        background-color: #dc3545;
        border: none;
    }
    .btn-danger:hover {
        background-color: #c82333;
    }
    .btn-secondary {
        background-color: #6c757d;
        border: none;
    }
    .btn-secondary:hover {
        background-color: #5a6268;
    }
    /* 버튼 그룹 스타일 */
    .button-group {
        display: flex;
        gap: 10px;
        justify-content: space-between; /* 버튼들 사이에 공간을 더 넓게 */
        margin-top: 20px;
    }
    /* 레이블 스타일 */
    .form-label {
        font-weight: bold;
        margin-bottom: 5px;
    }
    .alert {
        padding: 10px;
        margin-top: 20px;
        border-radius: 5px;
        text-align: center;
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
    }
    .alert-success {
        background-color: #d4edda;
        color: #155724;
    }
</style>
</head>

<body>

 <div class="container1">
        <h1 class="fw-bold">마이페이지</h1>
        <h2 class="fw-bold">정보 수정</h2>
        <form id="updateForm">
            <input type="hidden" name="uiNum" value="${user.uiNum}" />
            
            <!-- 이름: 수정할 수 없도록 readonly 설정 -->
             <div class="form-group">
                <label for="uiName" class="form-label">이름:</label>
                 <input type="text" name="uiName" class="form-control" value="${user.uiName}" readonly />
            </div>
            
            <!-- 아이디: 수정할 수 없도록 readonly 설정 -->
             <div class="form-group">
                <label for="uiId" class="form-label">아이디:</label>
                <input type="text" name="uiId" class="form-control" value="${user.uiId}" readonly />
            </div>
            
            <!-- 닉네임: 수정 가능 -->
            <div class="form-group">
                <label for="uiNickName" class="form-label">닉네임:</label>
                 <input type="text" name="uiNickName" class="form-control" value="${user.uiNickName}" />
            </div>
            
            <!-- 이메일: 수정할 수 없도록 readonly 설정 -->
             <div class="form-group">
                <label for="uiEmail" class="form-label">이메일:</label>
                <label for="uiEmail" class="form-label"><i class="fas fa-envelope"></i> 이메일</label>
                <input type="text" name="uiEmail" class="form-control" value="${user.uiEmail}" readonly />
            </div>
            
            <!-- 전화번호: 수정 가능 -->
             <div class="form-group">
                <label for="uiPhone" class="form-label">전화번호:</label>
                  <input type="text" name="uiPhone" class="form-control" value="${user.uiPhone}" />
            </div>
            
            <!-- 좋아하는 팀: 수정 가능 -->
             <div class="form-group">
                <label for="uiFavorite" class="form-label">좋아하는 팀:</label>
                  <select name="uiFavorite" class="form-control">
                    <option value="">선택</option>  
                    <option value="아스날" <c:if test="${user.uiFavorite == '아스날'}">selected</c:if>>아스날</option>
                    <option value="아스톤 빌라" <c:if test="${user.uiFavorite == '아스톤 빌라'}">selected</c:if>>아스톤 빌라</option>
                    <option value="본머스" <c:if test="${user.uiFavorite == '본머스'}">selected</c:if>>본머스</option>
                    <option value="브렌트포드" <c:if test="${user.uiFavorite == '브렌트포드'}">selected</c:if>>브렌트포드</option>
                    <option value="브라이튼" <c:if test="${user.uiFavorite == '브라이튼'}">selected</c:if>>브라이튼</option>
                    <option value="첼시" <c:if test="${user.uiFavorite == '첼시'}">selected</c:if>>첼시</option>
                    <option value="크리스탈 팰리스" <c:if test="${user.uiFavorite == '크리스탈 팰리스'}">selected</c:if>>크리스탈 팰리스</option>
                    <option value="에버턴" <c:if test="${user.uiFavorite == '에버턴'}">selected</c:if>>에버턴</option>
                    <option value="풀햄" <c:if test="${user.uiFavorite == '풀햄'}">selected</c:if>>풀햄</option>
                    <option value="리즈 유나이티드" <c:if test="${user.uiFavorite == '리즈 유나이티드'}">selected</c:if>>리즈 유나이티드</option>
                    <option value="레스터 시티" <c:if test="${user.uiFavorite == '레스터 시티'}">selected</c:if>>레스터 시티</option>
                    <option value="리버풀" <c:if test="${user.uiFavorite == '리버풀'}">selected</c:if>>리버풀</option>
                    <option value="맨체스터 시티" <c:if test="${user.uiFavorite == '맨체스터 시티'}">selected</c:if>>맨체스터 시티</option>
                    <option value="맨체스터 유나이티드" <c:if test="${user.uiFavorite == '맨체스터 유나이티드'}">selected</c:if>>맨체스터 유나이티드</option>
                    <option value="뉴캐슬 유나이티드" <c:if test="${user.uiFavorite == '뉴캐슬 유나이티드'}">selected</c:if>>뉴캐슬 유나이티드</option>
                    <option value="노리치 시티" <c:if test="${user.uiFavorite == '노리치 시티'}">selected</c:if>>노리치 시티</option>
                    <option value="셰필드 유나이티드" <c:if test="${user.uiFavorite == '셰필드 유나이티드'}">selected</c:if>>셰필드 유나이티드</option>
                    <option value="사우샘프턴" <c:if test="${user.uiFavorite == '사우샘프턴'}">selected</c:if>>사우샘프턴</option>
                    <option value="토트넘 홋스퍼" <c:if test="${user.uiFavorite == '토트넘 홋스퍼'}">selected</c:if>>토트넘 홋스퍼</option>
                    <option value="웨스트햄 유나이티드" <c:if test="${user.uiFavorite == '웨스트햄 유나이티드'}">selected</c:if>>웨스트햄 유나이티드</option>
                    <option value="울버햄튼 원더러스" <c:if test="${user.uiFavorite == '울버햄튼 원더러스'}">selected</c:if>>울버햄튼 원더러스</option>
                </select>
            </div>

            <!-- 버튼들 -->
             <div class="button-group">
                <button type="button" class="btn btn-primary" onclick="updateUser()">수정하기</button>
                <button type="button" class="btn btn-danger" onclick="deleteUser()">탈퇴하기</button>
                <button type="button" class="btn btn-secondary" onclick="location.href='/'">홈으로</button>
                 </div>
        </form>
    </div>

    <!-- 부트스트랩 및 사용자 정의 스크립트 -->
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 페이지가 로드될 때, 사용자 정보를 서버에서 받아옵니다.
        $(document).ready(function() {
            var uiNum = $('input[name="uiNum"]').val();  // 사용자 번호 (폼에 입력되어 있다고 가정)
            if (uiNum) {
                getUserInfo(uiNum);  // 페이지 로드 시 사용자 정보 불러오기
            }
        });
        
        // 사용자 정보 갱신 함수
        function getUserInfo(uiNum) {
            $.get('/user/' + uiNum, function(response) {
                // 서버에서 최신 사용자 정보 가져와서 화면 갱신
                $('#uiName').text(response.uiName);
                $('#uiId').text(response.uiId);
                $('#uiNickName').text(response.uiNickName);
                $('#uiEmail').text(response.uiEmail);
                $('#uiPhone').text(response.uiPhone);
                $('#uiFavorite').text(response.uiFavorite);
                // 폼에 최신 데이터 반영
                $('input[name="uiName"]').val(response.uiName);
                $('input[name="uiId"]').val(response.uiId);
                $('input[name="uiNickName"]').val(response.uiNickName);
                $('input[name="uiEmail"]').val(response.uiEmail);
                $('input[name="uiPhone"]').val(response.uiPhone);
                $('select[name="uiFavorite"]').val(response.uiFavorite);
            });
        }
        // 사용자 정보 업데이트 함수
      // 사용자 정보 업데이트 함수
function updateUser() {
    const user = {
        uiNum: document.querySelector('input[name="uiNum"]').value,
        uiNickName: document.querySelector('input[name="uiNickName"]').value,
        uiPhone: document.querySelector('input[name="uiPhone"]').value,
        uiFavorite: document.querySelector('select[name="uiFavorite"]').value
    };
    // user 객체가 올바르게 구성되었는지 확인
    console.log("User data to update:", user);
    fetch(`/user/${user.uiNum}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(user),
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(data => {
                alert(data.message);
                // 만약 "Data too long..." 메시지가 포함되면, 입력값을 확인하라는 메시지 출력
                if (data.message && data.message.startsWith("입력한 값이 너무 길어요")) {
                    alert("입력한 값이 너무 길어요. 다시 확인해주세요.");
                }
                throw new Error(data.message);
            });
        }
        return response.json();
    })
    .then(data => {
        console.log("Data received:", data); // 서버 응답 데이터 확인
        alert(data.message);
        window.location.reload();
    })
    .catch(error => {
        console.error("Error:", error);
    });
}
        // 사용자 탈퇴 함수
        function deleteUser() {
            const uiNum = document.querySelector('input[name="uiNum"]').value;
            if (!uiNum) {
                console.error("uiNum is undefined or null");
                alert("올바른 사용자 ID가 필요합니다.");
                return;
            }
            if (confirm('정말 탈퇴하시겠습니까?')) {
                fetch('/user/' + uiNum, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('서버 응답 오류');
                    }
                    return response.json();
                })
                .then(data => {
                    alert(data.message);
                    location.href = '/';  // 성공시 홈으로 이동
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('회원 탈퇴 처리 중 오류가 발생했습니다.');
                });
            }
        }
    </script>
</body>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
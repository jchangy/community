<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/common/sidebar.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="col-md-9 col-lg-10 p-4 h-100">
	<div class="container-fluid">	
		<h2 class="fw-bold mb-3">대시보드</h2>
		<div class="border border-tertiary mb-4"></div>
		<canvas id="signupChart" width="200" height="50"></canvas>
		<br>
		<div class="d-flex">
			<div class="card" style="width: 18rem;">
				
				<div class="card-body">
				  	  <h5 class="card-title fw-bold">회원 관리</h5>
				    <h6 class="card-subtitle mb-2 text-body-secondary">회원 목록 수정 및 삭제</h6>
				    <p class="card-text"></p>
				    <a href="/views/admin/user-list" class="card-link">회원 관리</a>
		  		</div>
			</div>
			<div class="card" style="width: 18rem;">
				<div class="card-body">
				  	  <h5 class="card-title fw-bold">게시글 관리</h5>
				    <h6 class="card-subtitle mb-2 text-body-secondary">게시글 목록 및 신고 내역 관리</h6>
				    <p class="card-text"></p>
				    <a href="/views/admin/post-list" class="card-link">게시글 관리로 이동</a>
		  		</div>
			</div>
			<div class="card" style="width: 18rem;">
				<div class="card-body">
				  	  <h5 class="card-title fw-bold">댓글 관리</h5>
				    <h6 class="card-subtitle mb-2 text-body-secondary">댓글 목록 및 신고 내역 관리</h6>
				    <p class="card-text"></p>
				    <a href="/views/admin/comment-list" class="card-link">댓글 관리 페이지</a>
		  		</div>
			</div>
		</div>
		<div class="d-flex">
			<div class="card" style="width: 18rem;">
				<div class="card-body">
				  	  <h5 class="card-title fw-bold">팀 관리</h5>
				    <h6 class="card-subtitle mb-2 text-body-secondary">팀 목록 수정 및 삭제</h6>
				    <p class="card-text"></p>
				    <a href="/views/admin/team-list" class="card-link">팀 목록 관리</a>
		  		</div>
			</div>
			<div class="card" style="width: 18rem;">
				<div class="card-body">
				  	  <h5 class="card-title fw-bold">선수 관리</h5>
				    <h6 class="card-subtitle mb-2 text-body-secondary">선수 목록 수정 및 삭제</h6>
				    <p class="card-text"></p>
				    <a href="/views/admin/player-list" class="card-link">선수 목록 관리</a>
		  		</div>
			</div>
		</div>
		<br>
	</div>
</div>
	<script>
    const ctx = document.querySelector('#signupChart');

 // 차트 초기화 변수
    let signupChart;

    // 데이터 로드 및 Chart.js 생성
    fetch('/signup-count')
        .then(response => response.json())
        .then(data => {
        	const allLabels = ['2024-10', '2024-11', '2024-12']; // 표시할 달
            const signupCounts = allLabels.map(label => {
                // 데이터에서 일치하는 달 찾기
                const match = data.find(item => item.month === label);
                return match ? match.signupCount : 0; // 데이터가 없으면 0으로 설정
            });

            // Chart.js 생성
            signupChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: allLabels, // X축 데이터
                    datasets: [{
                        label: '최근 가입한 유저수',
                        data: signupCounts, // Y축 데이터
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // 막대 배경색
                        borderColor: 'rgba(75, 192, 192, 1)', // 막대 테두리색
                        borderWidth: 1 // 막대 테두리 두께
                    }]
                },
                options: {
                    responsive: true, // 반응형 설정
                    scales: {
                    	x: {
                            barPercentage: 0.5,       // 막대 너비 조정 (기본값: 0.9)
                            categoryPercentage: 0.1, // 카테고리 내 막대 공간 비율 (기본값: 0.8)
                        },
                        y: {
                        	beginAtZero: true, // Y축 0부터 시작
                        	min: 0,            
                            max: 50, 
                            ticks: {
                                stepSize: 5    // Y축 간격을 5로 설정
                            }
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error fetching signup data:', error);
        });

		async function logout() {
			const response = await
			fetch('/logout', {
				method : 'POST'
			});
			const result = await
			response.json();

			if (response.ok) {
				location.href = '/';
				alert('로그아웃 되었습니다.');
			} else {
				location.href = '/';
			}
		}
	</script>
</body>
</html>
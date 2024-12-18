<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
    #postContent {
        min-height: 470px; /* 최소 높이 설정 */
        overflow: auto; /* 내용이 넘칠 경우 스크롤 가능 */
    }
</style>
<body>
	<div class="container px-5 my-5">
			<div class="d-flex justify-content-end my-1">
				<button id="prevPostBtn"
					class="" onclick="navigateToPrev()" style="background-color:#fff; border:none">이전글</button>
				<button id="nextPostBtn"
					class="mx-1" onclick="navigateToNext()" style="background-color:#fff; border:none">다음글</button>
				<button onclick="location.href='/views/community/post-list'" style="background-color:#fff; border:none">목록</button>
			</div>
			
		<div class="container px-2 h-75 border-primary" style="border-top: 2px solid">
			<div class="border-secondary-subtle pb-2 mb-4" style="border-bottom:1px solid">
				<h1 id="postTitle" class="container mt-5 mb-3">제목</h1>
				<div id="postCreated" class="container mx-1">작성날짜</div>
				
				<div class="container d-flex justify-content-between">
					<div class="d-flex align-items-center">
						<span class="comment-user-img" style="width: 40px; height: 40px; background-image: url('/res/images/profile.jpg'); background-size: cover; background-position: center; border-radius: 50%;"></span>
						<div id="postNickName" class="fs-5 mx-1 my-2">닉네임</div>
					</div>
					<div class="d-flex mt-2">
						<div>조회수</div>
						<div id="postViews" class="mx-1"></div>
						<div>| 댓글 <a href="#commentsSection"><span id="postCommentsCount" class="mx-1">0</span></a></div>
					</div>
				</div>
			</div>
			<div>
				<div id="postContent" class="container mt-3 px-3">내용</div>
			</div>
			<div>
				<div class="container d-flex justify-content-center mb-5">
					<button id="likeBtn" onclick="likeContent()" class="btn border px-3 py-2">추천<span id="likeCount"></span><br><i id="likeIcon" class="fa-regular fa-thumbs-up"></i></button>
				</div>
			</div>
			<div id="buttons" class="pb-2 d-flex justify-content-end px-3">
			<c:if test="${userUiNum}">
				<button onclick="updatePost()" class="btn btn-primary">수정</button>
				<button onclick="deletePost()" class="btn btn-primary">삭제</button>
			</c:if>
			<c:if test="${not empty user}">
				<button onclick="showReportModal('게시물', '${param.piNum}')" class="btn btn-danger">신고</button>
			</c:if>
		</div>
		<div id="commentsContainer" class="container">
			<div class="d-flex container border-primary pt-3" style="border-top:2px solid">
				<div id="commentsSection" class="mb-5">댓글</div>
				<span id="postCommentsCounts" class="d-flex mx-1"></span>
			</div>
			<div class="container d-flex justify-content-center mb-5">
				<c:if test="${not empty user}">
						<input type="text" id="commentInput" class="form-control me-2" style="max-width: 1000px;"
							placeholder="댓글을 입력하세요">
						<span class="d-flex">
							<button onclick="insertComment()" class="d-flex btn btn-primary align-items-center">작성</button>
						</span>
				</c:if>
			</div>
			<div id="commentsBody" class="container px-3"></div>
			<div class="d-flex justify-content-center">
			<div id="pagination" class="text-center mb-4"></div>
			</div>
		</div>
		</div>

		

		<div id="reportModal" class="modal z-3" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">신고하기</h5>
					</div>
					<div class="modal-body">
						<textarea id="reason" class="form-control" rows="4" cols="50"
							placeholder="신고 사유" style="resize: none"></textarea>
						<label for="reason">신고 사유</label>
					</div>
					<div class="modal-footer">
						<button onclick="closeReportModal()" class="btn btn-secondary">닫기</button>
						<button onclick="report()" class="btn btn-primary" id="reportBtn">신고하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	const piNum = '${param.piNum}';
	async function likeContent() {
	    try {
	        const response = await fetch('/like/' + piNum, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	            credentials: 'include'
	        });

	        const result = await response.json();
	        
	        if (result.error) {
	            alert(result.error);
	            location.href='/views/user/login';
	            return;
	        }

	        const likeIcon = document.querySelector('#likeIcon');
	        const likeCount = document.querySelector('#likeCount');
	        
	        if (result.liked) {
            likeIcon.classList.remove('fa-regular');
            likeIcon.classList.add('fa-solid');
            likeBtn.classList.add('btn-primary');  // 좋아요 시 primary 색상 추가
            likeBtn.classList.remove('border');    // 기존 border 클래스 제거
        } else {
            likeIcon.classList.remove('fa-solid');
            likeIcon.classList.add('fa-regular');
            likeBtn.classList.remove('btn-primary');  // 좋아요 취소 시 primary 색상 제거
            likeBtn.classList.add('border');          // 기존 border 클래스 추가
        }
	        likeCount.innerText = ' ' + result.count;
	        
	    } catch (error) {
	        console.error('오류 발생:', error);
	    }
	}

	// 페이지 로드 시 좋아요 상태 확인
	async function checkLikeStatus() {
		try {
			const response = await fetch('/like/' + piNum, {
				credentials: 'include'
			});
			
			const result = await response.json();
			
			const likeIcon = document.querySelector('#likeIcon');
			const likeCount = document.querySelector('#likeCount');
			const likeBtn = document.querySelector('#likeBtn');
				
				if (result.liked) {
				likeIcon.classList.remove('fa-regular');
				likeIcon.classList.add('fa-solid');
				likeBtn.classList.add('btn-primary');
				likeBtn.classList.remove('border');
				} else {
					likeIcon.classList.remove('fa-solid');
					likeIcon.classList.add('fa-regular');
					likeBtn.classList.remove('btn-primary');
					likeBtn.classList.add('border');
				}
				likeCount.innerText = ' ' + result.count;
		} catch (error) {
			console.error('좋아요 상태 확인 중 오류:', error);
		}
	}
	async function deletePost(){
		const response = await fetch('/posts/' + piNum, {
	        method: 'DELETE',
	        headers: {
	            'Content-Type': 'application/json'
	        }
	    });
	    if (confirm("게시글을 삭제하시겠습니까?")) {
	        alert('삭제되었습니다.');
	        location.href = '/views/community/post-list';
	    } else {
	        alert("이미 삭제된 게시글입니다.");
	    }
	};
		
		const userLoggedIn = ${not empty user ? "true" : "false"};
		const userUiNum = ${user != null ? user.uiNum : "null"};


		var reportedType = '';
		var reportedNum = '';
		
		function showReportModal(type, num) {
		    reportedType = type;
		    reportedNum = num;

		    // 모달 창을 보이게 함
		    document.querySelector("#reportModal").style.display = "block";
		    
		    const reportButton = document.querySelector("#reportBtn");
		    reportButton.onclick = function() {
		        report(type, num);
		    };
		}
		
		function closeReportModal(){
		    // 모달을 닫을 때 신고 유형과 번호 초기화
		    reportedType = '';
		    reportedNum = '';

		    document.querySelector('#reportModal').style.display = "none";
		}
		
		async function report(type, num){
			if (reportedType === '' || reportedNum === '') {
		        alert('잘못된 요청입니다. 다시 시도해주세요.');
		        return;  // 신고 유형이나 번호가 설정되지 않은 경우 종료
		    }
			
			const uiNum = '${user.uiNum}';
		    const reason = document.querySelector('#reason').value.trim();
		    
		    if (!reason) {
		        alert('신고 사유를 입력해주세요.');
		        return;
		    }
			
			const response = await fetch('/reports', {
				method: 'POST',
				headers: {
					'Content-Type' : 'application/json'
				},
				body: JSON.stringify({
					uiNum: uiNum,
	                reportedType: reportedType,
	                reportedNum: reportedNum,
	                riReason: reason
				})
			});
			
			if (response.ok) {
		        alert('신고가 정상적으로 접수되었습니다.');
		        closeReportModal();
		    } else {
		        alert('신고 처리에 실패했습니다. 다시 시도해주세요.');
		    }
		}
		
		function getPost() {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', '/posts/' + piNum);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === xhr.DONE) {
					if (xhr.status === 200) {
						const post = JSON.parse(xhr.responseText);
						document.querySelector('#postTitle').innerText = post.piTitle;
						document.querySelector('#postNickName').innerText = post.uiNickName;
						document.querySelector('#postCreated').innerText = post.piCreated;
						document.querySelector('#postViews').innerText = post.piViews;
						document.querySelector('#postContent').innerHTML = post.piContent;
						
						if (post.uiNum == userUiNum) {
							document.querySelector('#buttons').innerHTML = `
								<button onclick="updatePost()" class="btn btn-primary mx-1">수정</button>
								<button onclick="deletePost()" class="btn btn-primary">삭제</button>
							`;
						}
					}
				}
			}
			xhr.send();
		}
		
	    function updatePost(){
	    	const piNum = '${param.piNum}';
	    	location.href = '/views/community/post-update?piNum=' + piNum;
	    }

		function getComments(page) {
			const xhr = new XMLHttpRequest();
			const count = 5;
			const url = '/comments/' + piNum + '?page=' + page + '&count=' + count;

			xhr.open('GET', url);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === xhr.DONE) {
					if (xhr.status === 200) {
						const result = JSON.parse(xhr.responseText);
						const comments = result.list;
						const totalComments = result.count;

						let html = '';
						for (const comment of comments) {
							html += '<div class="border-bottom mb-3">';
							if (comment.status === "blocked") {
		                        html += '<div class="text-muted text-center">삭제된 댓글입니다.</div>';
		                    } else {
		                    	html += '<div id="comment-content-' + comment.cmiNum + '" class="d-flex justify-content-between align-items-center">'; // ID 추가
		                    	html += '<div class="d-flex align-items-center">';
		                        html += '<div class="comment-user-img" style="width: 30px; height: 30px; background-image: url(\'/res/images/profile.jpg\'); background-size: cover; background-position: center; border-radius: 50%;"></div>';
		                        html += '<div class="ml-2">' + comment.uiNickName + '</div>';
		                        html += '</div>';
		                        html += '<div>';
		                        if (userLoggedIn && comment.uiNum === userUiNum) {
		                        	html += '<button onclick="enableEditComment(' + comment.cmiNum + ')" class="btn btn-primary mx-1" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem">수정</button>';
		                            html += '<button onclick="deleteComment(' + comment.cmiNum + ')" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem">삭제</button>';
		                        }
		                        html += '</div>';
		                        if (userLoggedIn && userUiNum !== "null" && userUiNum !== comment.uiNum) {
		                            html += '<button class="btn btn-danger" onclick="showReportModal(\'댓글\', ' + comment.cmiNum + ')" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem">신고</button>';
		                        }
		                        html += '</div>';
		                        html += '<div class="d-flex justify-content-between">';
		                        html += '<div class="w-75">' + comment.cmiContent + '</div>';
		                        html += '<div class="text-muted" style="font-size: 0.9em;">' + comment.cmiCreated + '</div>';
		                        html += '</div>';
		                        
		                        // 댓글 수정
		                        html += '<div id="edit-comment-' + comment.cmiNum + '" class="d-none mt-2">';
		                        html += '<input type="text" id="edit-input-' + comment.cmiNum + '" class="form-control" value="' + comment.cmiContent + '">';
		                        html += '<button onclick="saveCommentEdit(' + comment.cmiNum + ')" class="btn btn-primary mt-2">저장</button>';
		                        html += '</div>';
		                    }

		                    html += '</div>';
						}
						document.querySelector('#commentsBody').innerHTML = html;
						
						document.querySelector('#postCommentsCount').innerText = totalComments;
						document.querySelector('#postCommentsCounts').innerText = totalComments;

						html = '';
						const totalPages = Math.ceil(totalComments / count);
						const sNum = (Math.ceil(page / 10) - 1) * 10 + 1;
						let lNum = sNum + 9;
						if (lNum > totalPages) {
							lNum = totalPages;
						}

						if (sNum !== 1) {
							html += '<a href="javascript:getComments(' + (sNum - 1) + ')">◀</a>';
						}

						for (let i = sNum; i <= lNum; i++) {
							if (i === page) {
								html += i;
							} else {
								html += ' <a href="javascript:getComments(' + i + ')">' + i + '</a> ';
							}
						}

						if (lNum < totalPages) {
							html += '<a href="javascript:getComments(' + (lNum + 1) + ')">▶</a>';
						}

						document.querySelector('#pagination').innerHTML = html;
					}
				}
			};
			xhr.send();
		}

		function enableEditComment(cmiNum) {
		    // 댓글 내용 영역 숨기고
		    const commentContent = document.querySelector('#comment-content-' + cmiNum);
		    if (commentContent) {
		        commentContent.classList.add('d-none');
		    } else {
		        console.error('댓글 내용 요소를 찾을 수 없습니다: cmiNum = ' + cmiNum);
		    }
		    // 수정 입력창과 저장 버튼 표시
		    document.querySelector('#edit-comment-' + cmiNum).classList.remove('d-none');
		}

		// 댓글 수정 후 저장 버튼을 클릭했을 때 실행
	async function saveCommentEdit(cmiNum) {
		const updatedContent = document.querySelector('#edit-input-' + cmiNum).value;

		const response = await fetch('/comments/' + cmiNum, {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ cmiContent: updatedContent }) // 수정된 내용 포함
		});

		if (response.ok) {
			// 페이지를 리로드하여 변경 사항을 반영
			location.reload();
		} else {
			alert("댓글 수정에 실패했습니다.");
		}
	}
		
		async function deleteComment(cmiNum) {
			if (confirm("댓글을 삭제하시겠습니까?")) {
				const response = await fetch('/comments/' + cmiNum, {
					method: 'DELETE',
					headers: {
						'Content-Type': 'application/json'
					}
				});

				if (response.ok) {
					alert("댓글이 삭제되었습니다.");
					location.reload();
				} else if (response.status === 404) {
					alert("댓글을 찾을 수 없습니다.");
				} else {
					alert("댓글 삭제에 실패했습니다.");
				}
			}
		}

		function insertComment() {
			const commentInput = document.querySelector('#commentInput');
			const commentContent = commentInput.value.trim();

			if (!commentContent) {
				alert("댓글을 입력해주세요.");
				return;
			}

			const param = {
				piNum: piNum,
				uiNum: userUiNum,
				cmiContent: commentContent
			};

			const xhr = new XMLHttpRequest();
			xhr.open('POST', '/comments');
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.onreadystatechange = function() {
				if (xhr.readyState === XMLHttpRequest.DONE) {
					const result = parseInt(xhr.responseText);
					if (result === -1) {
						alert("로그인 후 댓글을 작성할 수 있습니다.");
					} else if (result === 0) {
						alert("댓글 내용이 비어 있습니다.");
					} else {
						alert("댓글이 등록되었습니다.");
						commentInput.value = '';
						location.reload();
					}
				}
			};
			xhr.send(JSON.stringify(param));
		}

		let prevPostNum = null;
		let nextPostNum = null;

		async function getPrevPost() {
			const response = await fetch('/posts/' + piNum + '/prev');
			if (response.ok) {
				// 응답 본문이 비어 있지 않은지 확인
				if (response.status === 204) {
					document.querySelector('#prevPostBtn').disabled = true; // 이전글이 없으면 버튼 비활성화
					return;
				}

				const prevPost = await response.json();
				prevPostNum = prevPost.piNum;
			} else {
				document.querySelector('#prevPostBtn').disabled = true; // 이전글이 없으면 버튼 비활성화
			}
		}

		async function getNextPost() {
			const response = await fetch('/posts/' + piNum + '/next');
			if (response.ok) {
				// 응답 본문이 비어 있지 않은지 확인
				if (response.status === 204) {
					document.querySelector('#nextPostBtn').disabled = true; // 다음글이 없으면 버튼 비활성화
					return;
				}

				const nextPost = await response.json();
				nextPostNum = nextPost.piNum;
			} else {
				document.querySelector('#nextPostBtn').disabled = true; // 다음글이 없으면 버튼 비활성화
			}
		}
			

		function navigateToPrev() {
			if (prevPostNum) {
				location.href = '/views/community/post-view?piNum=' + prevPostNum;
			} else {
				alert('첫번째 게시글입니다.');
			}
		}

		function navigateToNext() {
			if (nextPostNum) {
				location.href = '/views/community/post-view?piNum=' + nextPostNum;
			} else {
				alert('마지막 게시글입니다.');
			}
		}

		window.addEventListener('load', function() {
			getComments(1);
		    getPost();
			getPrevPost();
			getNextPost();
			checkLikeStatus();
		});
	</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
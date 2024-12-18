<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*, com.fasterxml.jackson.databind.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<head>
<script type="text/javascript" src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
  integrity="sha256-7ZWbZUAi97rkirk4DcEp4GWDPkWpRMcNaEyXGsNXjLg=" crossorigin="anonymous">
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- include summernote css/js-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.css" integrity="sha512-ngQ4IGzHQ3s/Hh8kMyG4FC74wzitukRMIcTOoKT3EyzFZCILOPF0twiXOQn75eDINUfKBYmzYn2AA8DkAk8veQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-bs5.min.js" integrity="sha512-6F1RVfnxCprKJmfulcxxym1Dar5FsT/V2jiEUvABiaEiFWoQ8yHvqRM/Slf0qJKiwin6IDQucjXuolCfCKnaJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="/res/css/style.css" />	
</head>
<style>
	.dropdown:hover .dropdown-menu {
        display: block;
    }
    .navmenu:hover{
    	background-color:#37003c
    }

    /* 드롭다운 메뉴는 기본적으로 숨겨두기 */
    .dropdown-menu {
        display: none;
        position: absolute;
        right: 0; /* 드롭다운 메뉴가 오른쪽 끝에 위치하도록 설정 */
    }
</style>
<body>
<c:if test='${empty user}'>
    <script>
        alert('로그인이 필요합니다.');
        location.href = '/views/user/login';
    </script>
</c:if>
<div class="container min-vh-100 mt-5">
  <button class="d-flex btn btn-primary mb-3" onclick="insertPost()">등록</button>
  <input type="text" id="postTitle" placeholder="제목을 입력하세요" class="form-control mb-3">
  <textarea id="summernote"></textarea>
</div>
<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 650,
            focus: true,
            toolbar: [
                ['font', ['bold', 'italic', 'underline', 'strikethrough']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link', 'picture', 'video']],
                ['view', ['codeview']]
            ],
            callbacks: {
                onImageUpload: function(files) {
                    uploadImage(files[0]).then(function(url) {
                        $('#summernote').summernote('insertImage', url);
                        imageUrls.push(url);
                    }).catch(function(error) {
                        console.error(error);
                    });
                },
                onPaste: function(e) {
                    var clipboardData = e.originalEvent.clipboardData || window.clipboardData;
                    if (clipboardData && clipboardData.getData) {
                        var htmlData = clipboardData.getData('text/html');
                        var plainTextData = clipboardData.getData('text/plain');

                        // 이미지가 포함된 HTML인 경우 붙여넣기 방지
                        if (htmlData && htmlData.indexOf("<img") !== -1) {
                            e.preventDefault();
                            alert("이미지 복사 붙여넣기는 허용되지 않습니다. 파일로 업로드해 주세요.");
                        } else {
                            // 이미지가 포함되지 않은 경우 텍스트로 붙여넣기
                            setTimeout(function() {
                                document.execCommand("insertText", false, plainTextData);
                            }, 10);
                        }
                    }
                }
            }
        });
    });

    var imageUrls = [];
    const maxImages = 10;

    function uploadImage(file) {
        if (imageUrls.length >= maxImages) {
            alert("이미지 업로드는 최대 " + maxImages + "개까지 가능합니다.");
            return Promise.reject("Image upload limit reached"); // 반환 추가
        }

        var data = new FormData();
        data.append('file', file);

        return fetch('/posts/upload', {
            method: 'POST',
            body: data
        })
        .then(function(response) {
            if (!response.ok) throw new Error('Image upload failed');
            return response.json();
        })
        .then(function(json) {
            if (json.imageUrl) {
                return json.imageUrl;
            } else {
                throw new Error(json.error || 'Unknown error');
            }
        })
        .catch(function(error) {
            alert('이미지 업로드 중 오류가 발생했습니다.');
        });
    }

    function insertPost() {
        var title = $('#postTitle').val();
        var content = $('#summernote').summernote('code');

        if (!title) {
            alert('제목을 입력해주세요.');
            return;
        }

        var formData = new FormData();
        formData.append('piTitle', title);
        formData.append('piContent', content);

        imageUrls.forEach(function(url) {
            formData.append('imageUrls', url);
        });

        fetch('/posts', {
            method: 'POST',
            body: formData
        })
        .then(function(response) {
            if (!response.ok) throw new Error('Post submission failed');
            return response.json();
        })
        .then(function(piNum) {
            if (piNum > 0) {
                alert('게시글이 등록되었습니다!');
                window.location.href = "/views/community/post-list";
            } else {
                alert('게시글 등록 실패');
            }
        })
        .catch(function(error) {
            alert('게시글 등록 중 오류가 발생했습니다.');
        });
    }
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
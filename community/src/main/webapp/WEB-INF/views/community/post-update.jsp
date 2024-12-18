<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body>
<div class="container min-vh-100 mt-5">
  <input type="text" id="postTitle" placeholder="제목을 입력하세요" class="form-control mb-3">
  <textarea id="summernote"></textarea>
  <br>
  <button onclick="updatePost()" class="btn btn-success">수정하기</button>
</div>
<script>
	$(document).ready(function() {
	    $('#summernote').summernote({
	        height: 650,
	        focus: true,
	        toolbar: [
	            ['font', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
	            ['color', ['color']],
	            ['para', ['ul', 'ol', 'paragraph']],
	            ['insert', ['link', 'picture', 'video']],
	            ['view', ['codeview', 'help']]
	        ],
	        callbacks: {
	            onImageUpload: function(files) {
	                uploadImage(files[0]);
	            }
	        }
	    });
	});

	const piNum = '${param.piNum}';
	
    async function uploadImage(file) {
        let formData = new FormData();
        formData.append("file", file);

        try {
            const res = await fetch('/posts/upload', {
                method: 'POST',
                body: formData
            });
            const data = await res.json();
            if (data.imageUrl) {
                $('#summernote').summernote('focus'); // 포커스 설정
                $('#summernote').summernote('insertImage', data.imageUrl);
            } else {
                alert("이미지 업로드에 실패했습니다.");
            }
        } catch (error) {
            console.error("이미지 업로드 중 오류 발생:", error);
        }
    }

    async function updatePost(){
        const updatedData = {
            piTitle: document.querySelector('#postTitle').value,
            piContent: $('#summernote').summernote('code')
        };
    
        const res = await fetch('/posts/' + piNum, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        });

        const data = await res.json();
        document.querySelector('#postTitle').value = data.piTitle;
        $('#summernote').summernote('code', data.piContent); 
        alert('수정이 완료되었습니다!');
        location.href="/views/community/post-views?piNum=" + piNum;
    }

    async function updategetPost(){
    	const res = await fetch('/posts/' + piNum);
        const data = await res.json();
        
        document.querySelector('#postTitle').value = data.piTitle;
        $('#summernote').summernote('code', data.piContent);
    }
    
    window.addEventListener('load', updategetPost);
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

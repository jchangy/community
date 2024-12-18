<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/common/sidebar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/res/codebase/grid.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link href="/res/css/sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="/res/codebase/grid.css">
</head>
<body>

	<div class="col-md-9 col-lg-10 p-4">
		<div class="container-fluid">
			<!-- 아코디언 시작 -->
			<div class="accordion" id="accordionPanelsStayOpenExample">
				<!-- 첫 번째 아코디언 항목: 게시글 목록 -->
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseOne">게시글 목록</button>
					</h2>
					<div id="panelsStayOpen-collapseOne"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<!-- 게시글 그리드 -->
							<div id="PostGrid" style="width: 1478px; height: 250px;"></div>
							<div class="d-flex justify-content-end">
								<button onclick="saveGrid()" class="btn btn-secondary mx-1">저장</button>
								<button onclick="deleteGrid()" class="btn btn-secondary">삭제</button>
							</div>

							<div id="pagination" class="d-flex justify-content-center">
								<ul class="pagination">
									<li class="page-item" id="previous-page"><a
										class="page-link" href="javascript:void(0);"
										onclick="getPosts(currentPage - 1)" aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
									<div id="page-numbers" class="d-flex"></div>
									<li class="page-item" id="next-page"><a class="page-link"
										href="javascript:void(0);" onclick="getPosts(currentPage + 1)"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseTwo">신고 내역</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body">
							<!-- 게시글 신고 그리드 -->
                            <div id="reportGrid" style="width: 1478px; height: 300px;"></div>
                            <div class="d-flex justify-content-end">
                                <button onclick="saveReportGrid()" class="btn btn-secondary mx-1">저장</button>
                                <button onclick="deleteReportGrid()" class="btn btn-secondary">삭제</button>
                            </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 아코디언 끝 -->
	</div>
<script>
var reportGrid;
function saveReportGrid() {
    const rows = reportGrid.data.serialize();
    const checkedRows = rows.filter(row => row.rowId);

    if (checkedRows.length === 0) {
        alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
        return;
    }

    const report = {
        riNum: checkedRows[0].riNum,
        status: checkedRows[0].status === "처리완료" ? "처리완료" : "대기중"
    };

    axios.put('/reports', report, {
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(res => {
        if(res.data > 0) {
            alert('저장되었습니다.');
            getReport();
        } else {
            alert('저장에 실패했습니다.');
        }
    })
    .catch(err => {
        console.error(err);
        alert('저장 중 오류가 발생했습니다.');
    });
}

function deleteReportGrid() {
    const rows = reportGrid.data.serialize();
    const checkedRows = rows.filter(row => row.rowId);
    const riNums = checkedRows.map(row => row.riNum);

    if (riNums.length === 0) {
        alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
        return;
    }

    if (!confirm('선택한 신고 내역을 삭제하시겠습니까?')) {
        return;
    }

    axios.delete('/reports', { data: riNums })
    .then(res => {
        alert('삭제되었습니다.');
        getReport();
    })
    .catch(err => {
        console.error(err);
        alert('삭제 중 오류가 발생했습니다.');
    });
}

function reportList(){
	const columns = [
		{width:50, id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true, rowspan: 2}], type:'boolean', sortable:false},
		{width:200, id:'uiNickName', header:[{text:'닉네임', rowspan: 2}], editable:false},
		{width:225, id:'uiId', header:[{text:'아이디', rowspan: 2}], editable:false},
		{width:100, id:'reportedType', header:[{text:'신고 유형', rowspan: 2}], htmlEnable: true, editable:false},
		{width:100, id:'reportedNum', header:[{text:'신고 번호', rowspan: 2}], editable:false},
		{width:400, id:'riReason', header:[{text:'신고 사유', rowspan: 2}], editable:false},
		{width:100, id:'status', header:[{text:'상태'},{content:"comboFilter"}], editorType: "combobox", options: ["대기중","처리완료"],
        editable:true},
		{width:150, id:'riCreated', header:[{text:'신고날짜', rowspan: 2}], editable:false},
		{width:150, id:'riUpdated', header:[{text:'수정날짜', rowspan: 2}], editable:false}
	];
	
	reportGrid = new dhx.Grid('reportGrid', {
		columns : columns,
		leftSplit: 1,
		editable: true,
		dragItem: "both",
		keyNavigation: true,
		selection : "row",
		eventHandlers:{
			onclick:{
				'dhx_checkbox--check-all' : function(event,data){
					console.log(PostGrid.data);
					reportGrid.data.forEach(row=>{
						reportGrid.data.update(row.id,{[data.col.id]:event.target.checked});
					})
				}
			}
		}
	});
	getReport();
}

async function getReport() {
    try {
        const res = await axios.get('/reports/posts');

        const filteredPosts = res.data.map(row => ({
        	riNum: row.riNum,
            uiNickName: row.uiNickName,
            uiId: row.uiId,
            reportedType: row.reportedType,
            reportedNum: row.reportedNum,
            riReason: row.riReason,
            status: row.status,
            riCreated: row.riCreated,
            riUpdated: row.riUpdated
        }));

        reportGrid.data.parse(filteredPosts);
        console.log(filteredPosts);

    } catch (err) {
        alert('신고 목록을 가져오는 도중 오류가 발생했습니다.');
        console.error(err);
    }
}


	function deleteGrid() {
	    const rows = grid.data.serialize();
	    const checkedRows = rows.filter(row => row.rowId);
	    const piNums = checkedRows.map(row => row.piNum);

	    if (piNums.length === 0) {
	        alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
	        return;
	    }

        if (!confirm('선택한 게시글을 삭제하시겠습니까?')) {
	        return;
	    }


	    axios.delete('/posts', { data: piNums })
	    .then(res => {
	    	alert('삭제되었습니다.');
	        getPosts(currentPage);
	    })
	    .catch(err => {
            console.error('Error deleting posts:', err);
	        alert('삭제 중 오류가 발생했습니다.');
	    });
	}
    function saveGrid() {
    const rows = grid.data.serialize();
    console.log('All rows:', rows); // 모든 행 출력
    const checkedRows = rows.filter(row => row.rowId);
    console.log('Checked rows:', checkedRows); // 체크된 행 출력

    const filteredRows = checkedRows.map(row => ({
        piNum: row.piNum,
        piTitle: row.piTitle,
        piContent: row.piContent.replace(/<[^>]*>/g, ''),
        status: row.status
    }));

    console.log('Saving Rows:', filteredRows); // 저장할 행 출력

    if (filteredRows.length === 0) {
        alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
        return;
    }

    // 각 항목에 대해 PUT 요청을 보냄
    const promises = filteredRows.map(row => {
        console.log('Saving row with piNum:', row.piNum); // 각 행의 piNum 출력
        return axios.put('/posts/' + row.piNum + '/status', {
            status: row.status
        });
    });

    // 모든 요청이 완료된 후 처리
    Promise.all(promises)
        .then(responses => {
            alert('저장되었습니다.');
            getPosts(); // 게시글 목록 새로고침
        })
        .catch(err => {
            console.error('Error saving posts:', err);
            alert('저장 중 오류가 발생했습니다.');
        });
}

var grid, reportGrid;
var currentPage = 1; // 현재 페이지
var totalPosts = 0; // 총 게시글 수
var postsPerPage = 4; // 한 페이지당 게시글 수
var totalReports = 0; // 총 신고 수
var reportsPerPage = 5; // 한 페이지당 신고 수

function getCheckboxStr(){
	let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
	str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
	str += '<span class="dhx_checkbox__visual-input "></span>';
	str += '</label>';
	return str;
}
function init() {
    const columns = [
        {width: 50, id: 'rowId', header: [{text: getCheckboxStr(), htmlEnable: true, rowspan: 2}], type: 'boolean', sortable: false},
        {width: 100, id: 'piNum', header: [{text: '게시글 번호'}, { content: "inputFilter" }], editable: false},
        {width: 200, id: 'uiNickName', header: [{text: '닉네임', rowspan: 2}], editable: false},
        {width: 650, id: 'piContent', header: [{text: '게시글 내용', rowspan: 2}], editable: true, htmlEnable: true},
        {width: 85, id: 'status', header: [{text: '상태'},{content:"comboFilter"}], editorType: "combobox", options: ["active","blocked"],
        editable:true},
        {width: 180, id: 'piCreated', header: [{text: '작성일자', rowspan: 2}], editable: false},
        {width: 180, id: 'piUpdated', header: [{text: '수정일자', rowspan: 2}], editable: false}
    ];

    grid = new dhx.Grid('PostGrid', {
        columns: columns,
        leftSplit: 1,
        editable: true,
        dragItem: "both",
        keyNavigation: true,
        scrollX: false,
        scrollY: false,
        selection: "row",
        multiselection: true,
        eventHandlers: {
            onclick: {
                'dhx_checkbox--check-all': function(event, data) {
                    console.log(grid.data);
                    grid.data.forEach(row => {
                        grid.data.update(row.id, {[data.col.id]: event.target.checked});
                    })
                }
            }
        }
    });
    getPosts();
}

async function getPosts(page = 1) {
    try {
        currentPage = page;

        const res = await axios.get('/postList', {
            params: {
                page: currentPage,
                count: postsPerPage
            }
        });
        
        console.log('API Response:', res.data);

        if (!res.data || !res.data.list) {
            console.error('No data received from API');
            return;
        }

        const filteredPosts = res.data.list.map(function(post) {
            var contentWithLink = '<a href="/views/community/post-view?piNum=' + post.piNum + '" target="_blank">' + post.piContent + '</a>';
            
            return {
                rowId: false,
                piNum: post.piNum,
                uiNickName: post.uiNickName,
                piContent: contentWithLink,
                piCreated: post.piCreated,
                piUpdated: post.piUpdated,
                status: post.status
            };
        });

        grid.data.parse(filteredPosts);
        totalPosts = res.data.count;
        totalPages = Math.ceil(totalPosts / postsPerPage);
        updatePagination();

    } catch (err) {
        console.error('Error fetching posts:', err);
        alert('게시글 목록을 가져오는 도중 오류가 발생했습니다.');
    }
}

//페이지네이션 버튼 활성화/비활성화 처리
function updatePagination() {
    const prevButton = document.querySelector('#previous-page');
    const nextButton = document.querySelector('#next-page');
    const pageNumbers = document.querySelector('#page-numbers');

    const totalPages = Math.ceil(totalPosts / postsPerPage);

    if (currentPage === 1) {
        prevButton.classList.add('disabled');
    } else {
        prevButton.classList.remove('disabled');
    }

    if (currentPage === totalPages) {
        nextButton.classList.add('disabled');
    } else {
        nextButton.classList.remove('disabled');
    }

    pageNumbers.innerHTML = '';
    for (let i = 1; i <= totalPages; i++) {
        const pageItem = document.createElement('li');
        pageItem.classList.add('page-item');
        if (i === currentPage) {
            pageItem.classList.add('active');
        }

        const pageLink = document.createElement('a');
        pageLink.classList.add('page-link');
        pageLink.href = 'javascript:void(0);';
        pageLink.textContent = i;
        pageLink.onclick = function () {
            getPosts(i);
        };

        pageItem.appendChild(pageLink);
        pageNumbers.appendChild(pageItem);
    }
}


window.addEventListener('load', function() {
    init();
    reportList();
});
</script>
</body>
</html>
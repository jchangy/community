<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/common/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/res/codebase/grid.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link href="/res/css/sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="/res/codebase/grid.css">
</head>
<style>
</style>
<body>
<div class="col-md-9 col-lg-10 p-4">
		<div class="container-fluid d-flex justify-content-evenly">
			<!-- 아코디언 시작 -->
			<div class="accordion accordion-flush" id="accordionPanelsStayOpenExample" style="width:700px;">
				<!-- 첫 번째 아코디언 항목: 게시글 목록 -->
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button fw-bold" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseOne">프리미어리그 팀 목록</button>
					</h2>
					<div id="panelsStayOpen-collapseOne"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<!-- 그리드 -->
							<div id="teamGrid" style="width: 650px; height: 500px;"></div>
							<div class="d-flex mt-2">
								<button onclick="saveGrid()" class="btn btn-secondary">저장</button>
								<button onclick="deleteGrid()" class="btn btn-secondary mx-1">삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="accordion accordion-flush" id="accordionPanelsStayOpenExample" style="width:700px">
				<!-- 두 번째 아코디언 항목 -->
				<!-- <div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
							aria-controls="panelsStayOpen-collapseTwo">다른 리그 팀 목록</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body">
							그리드
							<div id="grid2" style="width: 650px; height: 500px;"></div>
							
						</div>
					</div>
				</div> -->
			</div>
		</div>
	</div>
	<!-- 아코디언 끝 -->
<script>
function deleteGrid(){
	const rows = grid.data.serialize();
	const checkedRows = row.filter(row=>row.rowId);
	const tmNums = rows.filter(row=>row.rowId).map(row=>row.tmNum);
	/* for(const checkedRow of checkedRows){
		uiNums.push(checkedRow.uiNum);
	} */
	axios.delete('/teams', {data:tmNums})
	.then(res=>{
		result = res.data;
		alert(result);
	})
}
function saveGrid(){
    const rows = grid.data.serialize();
    const checkedRows = rows.filter(row => row.rowId);

    // 필요한 필드만 포함시키기
    const filteredRows = checkedRows.map(row => ({
        tmNum: row.tmNum,
        tmName: row.tmName,
        tmCoach: row.tmCoach
    }));

    console.log('Filtered Rows:', filteredRows); // 요청 데이터 확인

    axios.put('/teams', filteredRows)
    .then(res => {
    	alert('저장되었습니다.');
        //alert(res.data);
    })
    .catch(err => {
    	alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
        //alert(err.response.data.message); // 사용자에게 알림
    });
}

function addTeam(){
	const newRow = {
			tmNum : 0,
			tmName : '',
			tmCoach : ''
	}
	grid.data.add(newRow);
}
var grid;
function getCheckboxStr(){
	let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
	str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
	str += '<span class="dhx_checkbox__visual-input "></span>';
	str += '</label>';
	return str;
}
function init(){
	const columns = [
		{width:60, id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true}], type:'boolean', sortable:false},
		{width:80, id:'tmNum', header:[{text:'번호'}], editable:false},
		{width:200, id:'tmName', header:[{text:'팀 이름'}], editable:true},
		{width:250, id:'tmCoach', header:[{text:'코치 이름'}], editable:true}
	];
	
	grid = new dhx.Grid('teamGrid', {
		columns : columns,
		leftSplit: 1,
		editable: true,
		dragItem: "both",
		keyNavigation: true,
		selection : "row",
		eventHandlers:{
			onclick:{
				'dhx_checkbox--check-all' : function(event,data){
					console.log(teamGrid.data);
					teamGrid.data.forEach(row=>{
						teamGrid.data.update(row.id,{[data.col.id]:event.target.checked});
					})
				}
			}
		}
	});
	getTeams();
}

async function getTeams(){
	const res = await axios.get('/teams');
	grid.data.parse(res.data);
}
window.addEventListener('load', init);
</script>
</body>
</html>
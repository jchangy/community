<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/common/sidebar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 목록</title>
<link rel="stylesheet" type="text/css" href="/res/codebase/grid.css" />
<script src="/res/codebase/grid.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<!-- axios 추가 -->
</head>
<style>
.button-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 각 줄에 5개의 버튼을 배치 */
    gap: 10px;
}

.button-grid button {
    padding: 10px;
    font-size: 16px;
}
</style>
<body>
<div class="col-md-9 col-lg-10 p-4">
		<div class="container-fluid d-flex justify-content-evenly">
			<!-- 아코디언 시작 -->
			<div class="accordion accordion-flush" id="accordionPanelsStayOpenExample" style="width:400px;">
				<!-- 첫 번째 아코디언 항목: 게시글 목록 -->
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button fw-bold" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseOne">팀 목록</button>
					</h2>
					<div id="panelsStayOpen-collapseOne"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<!-- 그리드 -->
							<div id="teamGrid" style="width: 350px; height: 500px;"></div>
							
						</div>
					</div>
				</div>
			</div>
			<div class="accordion accordion-flush" id="accordionPanelsStayOpenExample" style="width:1080px">
				<!-- 두 번째 아코디언 항목 -->
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseTwo">선수 목록</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body">
							<!-- 그리드 -->
							<div id="playerGrid" style="width: 1045px; height: 500px;"></div>
							<div class="d-flex justify-content-end mt-2">
								<button onclick="saveGrid()" class="btn btn-secondary mx-1">저장</button>
								<button onclick="deleteGrid()" class="btn btn-secondary">삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 아코디언 끝 -->
    <script>
    function deleteGrid() {
        const rows = grid.data.serialize();
        const checkedRows = rows.filter(row => row.rowId);
        const piNums = checkedRows.map(row => row.piNum);
        axios.delete('/players', { data: piNums })
            .then(res => {
                alert(res.data);
                getPlayers(); // 데이터 갱신
            });
    }

    function saveGrid() {
        const rows = grid.data.serialize();
        console.log('All rows:', rows);
        const checkedRows = rows.filter(row => row.rowId);
        console.log('Checked rows:', checkedRows);

        const filteredRows = checkedRows.map(row => ({
            piNum: row.piNum,
            piName: row.piName,
            piDateOfBirth: row.piDateOfBirth,
            piNationality: row.piNationality,
            piPosition: row.piPosition,
            piShirtNumber: row.piShirtNumber,
            tmNum: row.tmNum
        }));

        console.log('Saving Rows:', filteredRows);

        if (filteredRows.length === 0) {
            alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
            return;
        }

        // URL 경로 수정 및 데이터 형식 변경
        axios.put('/players', filteredRows, {
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(res => {
            if(res.data > 0) {
                alert('저장되었습니다.');
                getPlayers();
            } else {
                alert('저장에 실패했습니다.');
            }
        })
        .catch(err => {
            console.error('Error saving players:', err);
            alert('저장 중 오류가 발생했습니다.');
        });
    }

    function addPlayer() {
        const newRow = {
            piNum: 0,
            piName: '',
            piDateOfBirth: '',
            piNationality: '',
            piPosition: '',
            piShirtNumber: '',
            tmNum: ''
        };
        grid.data.add(newRow);
    }

    var grid, teamGrid;

    function getCheckboxStr() {
        let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
        str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
        str += '<span class="dhx_checkbox__visual-input "></span>';
        str += '</label>';
        return str;
    }

    function init() {
        const playerColumns = [
            { width: 60, id: 'rowId', header: [{ text: getCheckboxStr(), htmlEnable: true, rowspan: 2 }], type: 'boolean', sortable: false },
            { width: 80, id: 'piNum', header: [{ text: '번호', rowspan: 2 }], editable: false },
            { width: 220, id: 'piName', header: [{ text: '선수 이름' }, { content: "inputFilter" }], editable: true },
            { width: 100, id: 'piDateOfBirth', header: [{ text: '생년월일', rowspan: 2 }], editable: true },
            { width: 180, id: 'piNationality', header: [{ text: '국적', rowspan: 2 }], editable: true },
            { width: 180, id: 'piPosition', header: [{ text: '포지션' }, { content: "comboFilter" }], editorType: "combobox",
                options: ["Goalkeeper", "Defence", "Midfield", "Offence", "Centre-Back", "Left Winger", "Right Winger", "Defensive Midfield", "Central Midfield", "Left-Back", "Right-Back", "Attacking Midfield"],
                editable: true },
            { width: 100, id: 'piShirtNumber', header: [{ text: '등번호', rowspan: 2 }], editable: true },
            { width: 100, id: 'tmNum', header: [{ text: '팀 번호' }, { content: "inputFilter" }], editable: true }
        ];

        const teamColumns = [
            { width: 80, id: 'tmNum', header: [{ text: '팀 번호' }], editable: false },
            { width: 220, id: 'tmName', header: [{ text: '팀 이름' }], editable: false }
        ];

        // 선수 그리드 (팀에 맞는 선수 데이터를 표시)
        grid = new dhx.Grid('playerGrid', {
            columns: playerColumns,
            leftSplit: 1,
            editable: true,
            dragItem: "both",
            keyNavigation: true,
            selection: "row",
            eventHandlers: {
                onclick: {
                    'dhx_checkbox--check-all': function (event, data) {
                        grid.data.forEach(row => {
                            grid.data.update(row.id, { [data.col.id]: event.target.checked });
                        });
                    }
                }
            }
        });

        // 팀 목록 그리드 (팀을 클릭하여 선수 목록을 필터링)
        teamGrid = new dhx.Grid("teamGrid", {
            columns: teamColumns,
            leftSplit: 1,
            editable: false,
            dragItem: "both",
            keyNavigation: true,
            selection: "row",
		});
        teamGrid.events.on("cellClick", function(row) {
            const tmNum = row.tmNum;
            getPlayers(tmNum);
        });

        getPlayers();
        getTeams();
    }

    async function getTeams() {
        try {
            const res = await axios.get("/teams");
            
            const filteredTeams = res.data.map(team => ({
                tmNum: team.tmNum,
                tmName: team.tmName
            }));
            
            teamGrid.data.parse(filteredTeams);
        } catch (err) {
            alert("팀 정보를 가져오는 도중 오류가 발생했습니다.");
            console.error(err);
        }
    }

    async function getPlayers(tmNum) {
        try {
            const url = tmNum ? "/players/team/" + tmNum : "/players";
            const res = await axios.get(url);
            grid.data.parse(res.data);
        } catch (err) {
            alert("선수 정보를 가져오는 도중 오류가 발생했습니다.");
            console.error(err);
        }
    }

    window.addEventListener('load', init);
    </script>
</body>
</html>

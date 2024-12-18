<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/common/sidebar.jsp"%>
<head>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/res/codebase/grid.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="/res/css/sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="/res/codebase/grid.css">
</head>

<body>
	<div class="col-md-9 col-lg-10 p-4 h-100">
		<div class="container-fluid">
			<div class="m-3">
				<button onclick="saveGrid()" class="btn btn-secondary ml-5">저장</button>
				<button onclick="deleteGrid()" class="btn btn-secondary">삭제</button>
			</div>
			<div class="card m-3 border border-dark">
				<div class="card-header bg-secondary text-white">회원목록</div>
				<div>
					<div id="userGrid" style="width: 1479px; height: 600px"></div>
					<div id="pagination" class="d-flex justify-content-center">
						<ul class="pagination">
							<li class="page-item" id="previous-page"><a
								class="page-link" href="javascript:void(0);"
								onclick="getComments(currentPage - 1)" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
							</a></li>
							<div id="page-numbers" class="d-flex"></div>
							<li class="page-item" id="next-page"><a class="page-link"
								href="javascript:void(0);"
								onclick="getComments(currentPage + 1)" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
    var grid;
    var currentPage = 1; // 현재 페이지
    var totalUsers = 0;   // 총 사용자 수
    var usersPerPage = 10; // 한 페이지당 보여줄 사용자 수
    
    function deleteGrid() {
      const rows = grid.data.serialize();
      const checkedRows = rows.filter(row => row.rowId); // 'row'를 'rows'로 수정
      const uiNums = checkedRows.map(row => row.uiNum); // 수정된 checkedRows 사용

      if (uiNums.length === 0) {
          alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
          return;
      }

      axios.delete('/users', { data: uiNums })
        .then(res => {
          alert('삭제되었습니다.');
          getUsers(); // 사용자 목록 갱신
        })
        .catch(err => {
          alert('삭제 중 오류가 발생했습니다.');
          console.error(err); // 오류 로그
        });
    }

    function saveGrid() {
      const rows = grid.data.serialize();
      const checkedRows = rows.filter(row => row.rowId);

      // 필요한 필드만 포함시키기
      const filteredRows = checkedRows.map(row => ({
        uiNum: row.uiNum,
        uiName: row.uiName,
        uiId: row.uiId,
        uiNickName: row.uiNickName,
        uiEmail: row.uiEmail,
        uiPhone: row.uiPhone,
        uiFavorite: row.uiFavorite
      }));

      console.log('Filtered Rows:', filteredRows); // 요청 데이터 확인

      axios.put('/users', filteredRows)
        .then(res => {
          alert('저장되었습니다.');
          getUsers();
        })
        .catch(err => {
          alert('선택된 항목이 없습니다. 최소 하나의 항목을 선택해주세요.');
        });
    }

    function addUser() {
      const newRow = {
        uiNum : 0,
        uiName : '',
        uiId : '',
        uiNickName : '',
        uiEmail : '',
        uiPhone : '',
        uiFavorite : '',
        uiCredat : '',
        uiCretim : '',
      };
      grid.data.add(newRow);
    }

    function getCheckboxStr() {
      let str = '<label class="dhx_checkbox dhx_cell-editor__checkbox ">';
      str += '<input type="checkbox" class="dhx_checkbox__input dhx_checkbox--check-all">';
      str += '<span class="dhx_checkbox__visual-input "></span>';
      str += '</label>';
      return str;
    }

    function init() {
      const columns = [
        {width:60, id:'rowId', header:[{text:getCheckboxStr(), htmlEnable:true, rowspan: 2}], type:'boolean', sortable:false},
        {width:70, id:'uiNum', header:[{text:'번호'},{ content: "inputFilter" }], editable:false},
        {width:130, id:'uiName', header:[{text:'이름'},{ content: "inputFilter" }], editable:true},
        {width:200, id:'uiId', header:[{text:'아이디'}, { content: "inputFilter" }], editable:true},
        {width:150, id:'uiNickName', header:[{text:'닉네임'}, { content: "inputFilter" }], editable:true},
        {width:150, id:'uiFavorite', header:[{text:'관심 축구팀'},{content:"comboFilter"}], editorType: "combobox", 
          options: ["리버풀","맨시티","노팅엄 포레스트","첼시","아스널","빌라","토트넘","브라이튼","본머스","뉴캐슬","브렌트포드","풀럼","맨유","웨스트햄","레스터 시티","에버튼","크리스털 팰리스","입스위치","사우샘프턴","울버햄튼"],
          editable:true},
        {width:250, id:'uiEmail', header:[{text:'이메일', rowspan: 2}], editable:true},
        {width:150, id:'uiPhone', header:[{text:'전화번호'},{ content: "inputFilter" }], editable:true},
        {width:90, id:'uiCredat', header:[{text:'가입일', rowspan: 2}], editable:false},
        {width:90, id:'uiCretim', header:[{text:'가입시간', rowspan: 2}], editable:false}
      ];

      grid = new dhx.Grid('userGrid', {
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
    getUsers();
}

    async function getUsers(page = 1) {
        try {
            currentPage = page; // 현재 페이지 업데이트

            const res = await axios.get('/users', {
                params: {
                    page: currentPage,
                    count: usersPerPage
                }
            });

            console.log('API Response:', res.data);

            // 데이터를 가공하여 필요한 형식으로 변환
            const filteredUsers = res.data.map(function (user) {
                return {
                    rowId: false, // 체크박스를 위한 기본값
                    uiNum: user.uiNum,
                    uiId: user.uiId,
                    uiName: user.uiName,
                    uiNickName: user.uiNickName,
                    uiEmail: user.uiEmail,
                    uiPhone: user.uiPhone,
                    uiFavorite: user.uiFavorite,
                    uiCredat: user.uiCredat,
                    uiCretim: user.uiCretim
                };
            });

            // 현재 페이지에 맞는 데이터만 추출
            const startIndex = (currentPage - 1) * usersPerPage;
            const endIndex = startIndex + usersPerPage;
            const paginatedUsers = filteredUsers.slice(startIndex, endIndex);

            // 변환된 데이터로 Grid 업데이트
            grid.data.parse(paginatedUsers);

            // 총 사용자 수 계산 (서버에서 제공하는 전체 데이터 개수)
            totalUsers = res.data.length;
            totalPages = Math.ceil(totalUsers / usersPerPage); // 총 페이지 수 계산
            updatePagination();
        } catch (err) {
            console.error('Error fetching users:', err);
            alert('사용자 목록을 가져오는 도중 오류가 발생했습니다.');
        }
    }

  //페이지네이션 버튼 활성화/비활성화 처리
    function updatePagination() {
        const prevButton = document.querySelector('#previous-page');
        const nextButton = document.querySelector('#next-page');
        const pageNumbers = document.querySelector('#page-numbers');

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
                getUsers(i);
            };

            pageItem.appendChild(pageLink);
            pageNumbers.appendChild(pageItem);
        }
    }

    window.addEventListener('load', init);
  </script>
</body>
</html>

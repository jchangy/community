<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 상세 정보</title>
<style>
    body {
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }

    .stadium-info-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
    }

    .stadium-image {
        width: 500px; 
        height: 377px;
        margin-right: 20px; 
    }

    .stadium-details table {
        width: 480px; 
        height: 200px; 
        border-collapse: collapse; 
        table-layout: fixed; 
    }

    .stadium-details th, .stadium-details td {
        padding: 10px; 
        border: 1px solid #ddd; 
        text-align: center; /
        background-color: #f2f2f2; 
    }

    .stadium-details td img {
        background-color: transparent; 
        padding: 5px; 
        border: 1px solid #ddd; 
        border-radius: 5px; 
        max-width: 120px; 
        height: auto; 
    }

	#stadiumName {
            white-space: pre-line; /* 줄바꿈 문자(\n)를 브라우저에서 처리 */
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }


    .info-table, .player-table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: rgba(255, 255, 255, 0.9); 
    }

    .info-table th, .info-table td, .player-table th, .player-table td {
        padding: 10px; 
        border: 1px solid #ddd; 
        text-align: center; 
    }

    .info-table th, .player-table th {
        background-color: #37003c; 
        color: white; 
    }

    .player-table tr:nth-child(even) {
        background-color: #f2f2f2; 
    }

    .player-table tr:hover {
        background-color: #ddd; 
    }
</style>



</head>
<body>
    <h2 style="text-align: center; margin: 20px 0;">경기장 정보</h2>
	    <div class="stadium-info-container">
		    <img id="stadiumImage" class="stadium-image" alt="Stadium Image" />
		    <div class="stadium-details">
		        <table>
		            <tr>
		                <th colspan="2" id="stadiumName">경기장 이름</th>
		            </tr>
		            <tr>
		                <th>홈 유니폼</th>
		                <th>어웨이 유니폼</th>
		            </tr>
		            <tr>
		                <td><img id="homeUniform" src="" alt="Home Uniform" /></td>
		                <td><img id="awayUniform" src="" alt="Away Uniform" /></td>
		            </tr>
		        </table>
		    </div>
		</div>


    <h2 style="text-align: center; margin: 20px 0;">감독 정보</h2>
    <table class="info-table">
        <thead>
            <tr>
                <th>이름</th>
                <th>생년월일</th>
                <th>국적</th>
                <th>취임년도</th>
            </tr>
        </thead>
        <tbody id="managerInfo">
        </tbody>
    </table>

    <h2 style="text-align: center; margin: 20px 0;">선수 목록</h2>
    <table class="player-table">
        <thead>
            <tr>
                <th>이름</th>
                <th>생년월일</th>
                <th>국적</th>
                <th>포지션</th>
                <th>등번호</th>
            </tr>
        </thead>
        <tbody id="playerList">
        </tbody>
    </table>

    <script>
    // 각 팀의 감독 정보
    const teamManagers = {
    	    "1": { name: "Mikel Arteta", dob: "1982-03-26", nationality: "Spain", startYear: "2019" },
    	    "2": { name: "Unai Emery", dob: "1971-11-03", nationality: "Spain", startYear: "2022" },
    	    "3": { name: "Enzo Maresca", dob: "1980-02-10", nationality: "Italy", startYear: "2024" },
    	    "4": { name: "Sean Dyche", dob: "1971-06-28", nationality: "England", startYear: "2023" },
    	    "5": { name: "Marco Silva", dob: "1977-07-12", nationality: "Portugal", startYear: "2021" },
    	    "6": { name: "Arne Slot", dob: "1978-09-17", nationality: "Netherlands", startYear: "2024" },
    	    "7": { name: "Pep Guardiola", dob: "1971-01-18", nationality: "Spain", startYear: "2016" },
    	    "8": { name: "Erik ten Hag", dob: "1970-02-02", nationality: "Netherlands", startYear: "2022" },
    	    "9": { name: "Eddie Howe", dob: "1977-11-29", nationality: "England", startYear: "2021" },
    	    "10": { name: "Ange Postecoglou", dob: "1965-08-27", nationality: "Australia", startYear: "2023" },
    	    "11": { name: "Gary O'Neil", dob: "1983-05-18", nationality: "England", startYear: "2023" },
    	    "12": { name: "Steve Cooper", dob: "1979-12-10", nationality: "England", startYear: "2024" },
    	    "13": { name: "Russell Martin", dob: "1986-01-04", nationality: "England", startYear: "2023" },
    	    "14": { name: "Kieran McKenna", dob: "1986-05-14", nationality: "Northern Ireland", startYear: "2021" },
    	    "15": { name: "Nuno Espírito Santo", dob: "1974-01-25", nationality: "Portugal", startYear: "2023" },
    	    "16": { name: "Oliver Glasner", dob: "1974-08-28", nationality: "Austria", startYear: "2024" },
    	    "17": { name: "Fabian Hürzeler", dob: "1993-02-26", nationality: "Germany", startYear: "2024" },
    	    "18": { name: "Thomas Frank", dob: "1973-10-09", nationality: "Denmark", startYear: "2018" },
    	    "19": { name: "Julen Lopetegui", dob: "1966-08-28", nationality: "Spain", startYear: "2024" },
    	    "20": { name: "Andoni Iraola", dob: "1982-06-22", nationality: "Spain", startYear: "2023" },
    	};


    // 각 팀의 경기장 및 유니폼 정보
    const stadiumImages = {
        1: "/res/images/arsenal/stadium.jpg",
        2: "/res/images/astonvilla/stadium.jpg",
        3: "/res/images/chelsea/stadium.jpg",
        4: "/res/images/everton/stadium.jpg",
        5: "/res/images/fulham/stadium.jpg",
        6: "/res/images/liverpool/stadium.jpg",
        7: "/res/images/city/stadium.jpg",
        8: "/res/images/united/stadium.jpg",
        9: "/res/images/newcastle/stadium.jpg",
        10: "/res/images/tot/stadium.jpg",
        11: "/res/images/wolves/stadium.jpg",
        12: "/res/images/leicester/stadium.jpg",
        13: "/res/images/south/stadium.jpg",
        14: "/res/images/ipswich/stadium.jpg",
        15: "/res/images/notting/stadium.jpg",
        16: "/res/images/crystal/stadium.jpg",
        17: "/res/images/brighton/stadium.jpg",
        18: "/res/images/brentford/stadium.jpg",
        19: "/res/images/westham/stadium.jpg",
        20: "/res/images/bournmouth/stadium.jpg",
    };
    
    const stadiumNames = {
    	    1: "Emirates Stadium\n수용인원: 6,704명",
    	    2: "Villa Park\n수용인원: 42,785명",
    	    3: "Stamford Bridge\n수용인원: 40,341명",
    	    4: "Goodison Park\n수용인원: 39,572명",
    	    5: "Craven Cottage\n수용인원: 25,700명",
    	    6: "Anfield\n수용인원: 54,074명",
    	    7: "Etihad Stadium\n수용인원: 53,400명",
    	    8: "Old Trafford\n수용인원: 74,310명",
    	    9: "St James' Park\n수용인원: 52,305명",
    	    10: "Tottenham Hotspur Stadium\n수용인원: 62,850명",
    	    11: "Molineux Stadium\n수용인원: 31,700명",
    	    12: "King Power Stadium\n수용인원: 32,312명",
    	    13: "St Mary's Stadium\n수용인원: 32,505명",
    	    14: "Portman Road\n수용인원: 30,311명",
    	    15: "The City Ground\n수용인원: 30,445명",
    	    16: "Selhurst Park\n수용인원: 25,486명",
    	    17: "Amex Stadium\n수용인원: 31,800명",
    	    18: "Gtech Community Stadium\n수용인원: 17,250명",
    	    19: "London Stadium\n수용인원: 60,000명",
    	    20: "Vitality Stadium\n수용인원: 11,329명",
    	};


    const homeUniforms = {
            1: "/res/images/arsenal/home.webp",
            2: "/res/images/astonvilla/home.webp",
            3: "/res/images/chelsea/home.webp",
            4: "/res/images/everton/home.webp",
            5: "/res/images/fulham/home.webp",
            6: "/res/images/liverpool/home.webp",
            7: "/res/images/city/home.webp",
            8: "/res/images/united/home.webp",
            9: "/res/images/newcastle/home.webp",
            10: "/res/images/tot/home.webp",
            11: "/res/images/wolves/home.webp",
            12: "/res/images/leicester/home.webp",
            13: "/res/images/south/home.webp",
            14: "/res/images/ipswich/home.webp",
            15: "/res/images/notting/home.webp",
            16: "/res/images/crystal/home.webp",
            17: "/res/images/brighton/home.webp",
            18: "/res/images/brentford/home.webp",
            19: "/res/images/westham/home.webp",
            20: "/res/images/bournmouth/home.webp",
            
        };

    const awayUniforms = {
    		1: "/res/images/arsenal/away.webp",
            2: "/res/images/astonvilla/away.webp",
            3: "/res/images/chelsea/away.webp",
            4: "/res/images/everton/away.webp",
            5: "/res/images/fulham/away.webp",
            6: "/res/images/liverpool/away.webp",
            7: "/res/images/city/away.webp",
            8: "/res/images/united/away.webp",
            9: "/res/images/newcastle/away.webp",
            10: "/res/images/tot/away.webp",
            11: "/res/images/wolves/away.webp",
            12: "/res/images/leicester/away.webp",
            13: "/res/images/south/away.webp",
            14: "/res/images/ipswich/away.webp",
            15: "/res/images/notting/away.webp",
            16: "/res/images/crystal/away.webp",
            17: "/res/images/brighton/away.webp",
            18: "/res/images/brentford/away.webp",
            19: "/res/images/westham/away.webp",
            20: "/res/images/bournmouth/away.webp",
        
    };

    function showStadiumInfo(tmNum) {
        const stadiumImage = document.getElementById("stadiumImage");
        const stadiumName = document.getElementById("stadiumName");
        const homeUniform = document.getElementById("homeUniform");
        const awayUniform = document.getElementById("awayUniform");

        if (stadiumImages[tmNum]) {
            stadiumImage.src = stadiumImages[tmNum];
            stadiumName.textContent = stadiumNames[tmNum] || "Unknown";
            homeUniform.src = homeUniforms[tmNum] || "";
            awayUniform.src = awayUniforms[tmNum] || "";
        } else {
            stadiumImage.src = "";
            stadiumName.textContent = "Unknown";
            homeUniform.src = "";
            awayUniform.src = "";
        }
    }

    
    
    function displayManagerInfo(manager) {
        const managerInfo = document.querySelector('#managerInfo');
        const row = document.createElement('tr');
        
        const nameCell = document.createElement('td');
        nameCell.innerText = manager.name;
        row.appendChild(nameCell);

        const dobCell = document.createElement('td');
        dobCell.innerText = manager.dob;
        row.appendChild(dobCell);

        const nationalityCell = document.createElement('td');
        nationalityCell.innerText = manager.nationality;
        row.appendChild(nationalityCell);

        const startYearCell = document.createElement('td');
        startYearCell.innerText = manager.startYear;
        row.appendChild(startYearCell);

        managerInfo.appendChild(row);
    }

    function getPlayersByTeam(tmNum) {
        fetch('/players/team/' + tmNum)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to load players: ${response.status} ${response.statusText}`);
                }
                return response.json();
            })
            .then(players => {
                const playerList = document.querySelector('#playerList');
                playerList.innerHTML = ''; // 기존 내용을 초기화

                players.forEach(player => {
                    const playerRow = document.createElement('tr');
                    
                    const nameCell = document.createElement('td');
                    nameCell.innerText = player.piName;
                    playerRow.appendChild(nameCell);

                    const dobCell = document.createElement('td');
                    dobCell.innerText = player.piDateOfBirth;
                    playerRow.appendChild(dobCell);

                    const nationalityCell = document.createElement('td');
                    nationalityCell.innerText = player.piNationality;
                    playerRow.appendChild(nationalityCell);

                    const positionCell = document.createElement('td');
                    positionCell.innerText = player.piPosition;
                    playerRow.appendChild(positionCell);

                    const shirtNumberCell = document.createElement('td');
                    shirtNumberCell.innerText = player.piShirtNumber;
                    playerRow.appendChild(shirtNumberCell);

                    playerList.appendChild(playerRow);
                });
            })
            .catch(error => {
                console.error(error.message);
            });
    }

    window.addEventListener('load', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const tmNum = urlParams.get('tmNum');

        if (tmNum) {
            showStadiumInfo(tmNum);

            const manager = teamManagers[tmNum];
            if (manager) {
                displayManagerInfo(manager);
            } else {
                console.warn("No manager information found for team:", tmNum);
            }

            getPlayersByTeam(tmNum);
        }
    });
    </script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

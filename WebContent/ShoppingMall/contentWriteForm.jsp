<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 입력</title>

<style>
.app {
	width: auto;
	display: flex;
	flex-direction: column;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -450px;
    background-color:white; border: 1px solid #d2d2d2; padding: 20px;
}

div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.inline {
	display: inline-block;
}

table, th {
	border: 1px solid #d2d2d2;
}
td {
	padding: 2px;
}

.float_right {
	float: right;
}

.column {
	display: inline-flex;
	flex-direction: column;
}

.middle {
	display: inline-flex;
	flex-direction: row;
}

.colorNum {
	width: 60px;
}

a { 
	text-decoration:none 
} 
body {
	background-color: black;
}

.file-delete:hover{
	cursor: pointer;
}
.btnTag:hover{
	cursor: pointer;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app">
		<div>
			<a href="main.jsp"><i class="fas fa-arrow-left"></i></a>
		</div>
		<div style="text-align: center;">
			<h2 style="display: inline-block;">MUSINSA</h2>
			<p style="display: inline-block; font-size: 22px">WUSINSA</p>
		</div>
		<div>
			<div style="text-align: center;">
				<h3 style="display: inline-block; margin: 5px">게시물 등록</h3>
			</div>
		</div>
		<div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<form action="contentWritePro.jsp" method="post" name="frm" enctype="multipart/form-data">
			<div class="column">
				<div class="middle">
					<div>
						<table>
							<tr>
								<th>한정판매 여부</th>
								<td><input type="checkbox" name="limitedSale" value="Y"></td>
							</tr>

							<tr>
								<th>품번</th>
								<td><input type="text" name="article" placeholder="품번 입력"
									required></td>
							</tr>

							<tr>
								<th>브랜드명</th>
								<td><input type="text" name="brand" placeholder="브랜드명 입력"
									required></td>
							</tr>

							<tr>
								<th>상품명</th>
								<td><input type="text" name="product" placeholder="상품명 입력"
									required></td>
							</tr>

							<tr>
								<th>성별</th>
								<td><input type="radio" name="gender" value="공용"
									checked="checked">공용 <input type="radio" name="gender"
									value="남성">남성 <input type="radio" name="gender"
									value="여성">여성</td>
							</tr>

							<tr>
								<th>분류</th>
								<td><select id="part" name="part" onchange="itemChange()">
										<option value="상의">상의</option>
										<option value="아우터">아우터</option>
										<option value="바지">바지</option>
										<option value="가방">가방</option>
										<option value="스니커즈">스니커즈</option>
										<option value="신발">신발</option>
										<option value="시계">시계</option>
										<option value="모자">모자</option>
										<option value="스포츠">스포츠</option>
										<option value="양말/레그웨어">양말/레그웨어</option>
										<option value="속옷">속옷</option>
										<option value="안경">안경</option>
										<option value="쥬얼리">쥬얼리</option>
										<option value="악세서리">악세서리</option>
										<option value="뷰티">뷰티</option>
										<option value="기타">기타</option>
								</select></td>
							</tr>

							<tr>
								<th>세부 분류</th>
								<td><select id="detail" name="detail">
										<option value="반팔 티셔츠">반팔 티셔츠</option>
										<option value="피케/카라 티셔츠">피케/카라 티셔츠</option>
										<option value="팔 티셔츠">긴팔 티셔츠</option>
										<option value="맨투맨/스웨트 셔츠">맨투맨/스웨트 셔츠</option>
										<option value="민소매 티셔츠">민소매 티셔츠</option>
										<option value="후드 티셔츠">후드 티셔츠</option>
										<option value="셔츠/블라우스">셔츠/블라우스</option>
										<option value="니트/스웨터">니트/스웨터</option>
										<option value="기타 상의">기타 상의</option>
								</select></td>
							</tr>

							<tr>
								<th>판매가</th>
								<td><input type="number" name="price" placeholder="판매가 입력"
									required></td>
							</tr>

							<tr>
								<th>할인가</th>
								<td><input type="number" name="sale" placeholder="세일가 입력"
									required></td>
							</tr>

							<tr>
								<th>배송사</th>
								<td><select id="delivery" name="delivery">
										<option value="CJ대한통운">CJ대한통운</option>
										<option value="천일택배">천일택배</option>
										<option value="경동택배">경동택배</option>
										<option value="한진택배">한진택배</option>
										<option value="대신택배">대신택배</option>
										<option value="롯대택배">롯데택배</option>
								</select></td>
							</tr>

							<tr>
								<th>출고기간</th>
								<td><input type="number" name="releasedate" min="0"
									step="0.1" placeholder="출고기간 입력" required></td>
							</tr>

							<tr>
								<th>주말/공휴일 출고 여부</th>
								<td><input type="checkbox" name="weekend" value="Y"></td>
							</tr>
						</table>
						<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
						<div id="fileBox">
							<div>
								<input type="file" name="image1" accept="image/*" required> <span
									class="file-delete"><i class="fas fa-trash-alt"></i></span>
							</div>
							<div>
								<input type="file" name="image2" accept="image/*" required> <span
									class="file-delete"><i class="fas fa-trash-alt"></i></span>
							</div>
						</div>
					</div>

					<div>
						<div>물품 수량</div>
						<div>
							<input type="checkbox" name="S">S
							<table id="smailTable" style="display: none; text-align: center;">
								<tr>
									<td>red<br> <input type="number"
										class="colorNum small" name="redsn" value="0" min="0"></td>

									<td>orange<br> <input type="number"
										class="colorNum small" name="orangesn" value="0" min="0"></td>

									<td>yellow<br> <input type="number"
										class="colorNum small" name="yellowsn" value="0" min="0"></td>

									<td>green<br> <input type="number"
										class="colorNum small" name="greensn" value="0" min="0"></td>

									<td>blue<br> <input type="number"
										class="colorNum small" name="bluesn" value="0" min="0"></td>
								</tr>
							</table>
						</div>
						<div>
							<input type="checkbox" name="M">M
							<table id="mediumTable" style="display: none; text-align: center;">
								<tr>
									<td>red<br> <input type="number"
										class="colorNum medium" name="redmn" value="0" min="0"></td>

									<td>orange<br> <input type="number"
										class="colorNum medium" name="orangemn" value="0" min="0"></td>

									<td>yellow<br> <input type="number"
										class="colorNum medium" name="yellowmn" value="0" min="0"></td>

									<td>green<br> <input type="number"
										class="colorNum medium" name="greenmn" value="0" min="0"></td>

									<td>blue<br> <input type="number"
										class="colorNum medium" name="bluemn" value="0" min="0"></td>
								</tr>
							</table>
						</div>
						<div>
							<input type="checkbox" name="L">L
							<table id="largeTable" style="display: none; text-align: center;">
								<tr>
									<td>red<br> <input type="number"
										class="colorNum large" name="redln" value="0" min="0"></td>

									<td>orange<br> <input type="number"
										class="colorNum large" name="orangeln" value="0" min="0"></td>

									<td>yellow<br> <input type="number"
										class="colorNum large" name="yellowln" value="0" min="0"></td>

									<td>green<br> <input type="number"
										class="colorNum large" name="greenln" value="0" min="0"></td>

									<td>blue<br> <input type="number"
										class="colorNum large" name="blueln" value="0" min="0"></td>
								</tr>
							</table>
						</div>
						<div>
							<input type="checkbox" name="XL">XL
							<table id="xlargeTable" style="display: none; text-align: center;">
								<tr>
									<td>red<br> <input type="number"
										class="colorNum large" name="redxln" value="0" min="0"></td>

									<td>orange<br> <input type="number"
										class="colorNum large" name="orangexln" value="0" min="0"></td>

									<td>yellow<br> <input type="number"
										class="colorNum large" name="yellowxln" value="0" min="0"></td>

									<td>green<br> <input type="number"
										class="colorNum large" name="greenxln" value="0" min="0"></td>

									<td>blue<br> <input type="number"
										class="colorNum large" name="bluexln" value="0" min="0"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div style="text-align: center;">
					<input type="submit" class="btnTag" value="등록하기" style="width:250px; height: 50px; background-color: black; color: white; font-size: 15px;">
					<input type="reset" class="btnTag" value="초기화" style="width:250px; height: 50px; background-color: black; color: white; font-size: 15px;">
				</div>
			</div>
		</form>

	</div>

	<script src="../js/jquery-3.5.1.js"></script>
	<script>
		function itemChange() {
			var top = [ "반팔 티셔츠", "피케/카라 티셔츠", "긴팔 티셔츠", "맨투맨/스웨트 셔츠",
					"민소매 티셔츠", "후드 티셔츠", "셔츠/블라우스", "니트/스웨터", "기타 상의" ];
			var outer = [ "후드 집업", "환절기 코트", "블루종/MA-1", "겨울 싱글 코트",
					"레드/라이더스 재킷", "겨울 기타 코트", "트러커 재킷", "슈트/블레이저 제킷", "카디건",
					"아노락 재킷", "플리스/뽀글이", "트레이닝 재킷", "스타디움 재킷", "롱 패딩/롱 헤비 아우터",
					"숏 패딩/숏 헤비 아우터", "패딩 베스트", "베스트", "사파리/헌팅 재킷", "기타 아우터",
					"나일론/코치 재킷" ];
			var onepiece = ["미니 원피스", "미디 원피스", "맥시 원피스"];
			var pants = ["데님 팬츠", "숏 팬츠", "코튼 팬츠","레깅스","슈트 팬츠/슬랙스","점프 슈트/오버올","트레이닝/조거 팬츠","기타 바지"];
			var skirt = ["미니스커트","미디스커트","롱스커트"];
			var bag = ["백팩","웨이스트 백","메신저/크로스 백","클러치 백", "숄더/토트백","파우치 백","에코백","브리프케이스","보스턴/드럼/더플백","캐리어","기타 가방"];
			var snickers = ["캔버스/단화", "농구화", "러닝화/피트니스화", "기타 스니커즈"];
			var shoes = ["구두","부츠","힐/펌프스","플랫 슈즈","로퍼","모카신/보트 슈즈","샌들","슬리퍼","신발 용품","기타 신발"];
			var watch = ["디지털","쿼츠 아날로그","오토매틱 아날로그","시계 용품","기타 시계"];
			
			
			var selectItem = $('#part').val();
			console.log(selectItem);
			var changeItem;
			if (selectItem == '상의') {
				changeItem = top;
			} else if (selectItem == '아우터') {
				changeItem = outer;
			} else if (selectItem == '원피스') {
				changeItem = onepiece;
			} else if (selectItem == '바지') {
				changeItem = pants;
			} else if (selectItem == '스커트') {
				changeItem = skirt;
			} else if (selectItem == '가방') {
				changeItem = bag;
			} else if (selectItem == '스니커즈') {
				changeItem = snickers;
			} else if (selectItem == '신발') {
				changeItem = shoes;
			} else if (selectItem == '시계') {
				changeItem = watch;
			}

			$('#detail').empty();

			for (var count = 0; count < changeItem.length; count++) {

				var option = $('<option value="'+changeItem[count]+'">'
						+ changeItem[count] + '</option>');
				$('#detail').append(option);
			}
		}

		$('input[name="S"]').click(function() {
			var test = $('input[name="S"]').is(":checked");

			if (test) {
				$('#smailTable').show();
			} else {
				$('#smailTable').hide();
			}
		});

		$('input[name="M"]').click(function() {
			var test = $('input[name="M"]').is(":checked");

			if (test) {
				$('#mediumTable').show();
			} else {
				$('#mediumTable').hide();
			}
		});

		$('input[name="L"]').click(function() {
			var test = $('input[name="L"]').is(":checked");

			if (test) {
				$('#largeTable').show();
			} else {
				$('#largeTable').hide();
			}
		});

		$('input[name="XL"]').click(function() {
			var test = $('input[name="XL"]').is(":checked");

			if (test) {
				$('#xlargeTable').show();
			} else {
				$('#xlargeTable').hide();
			}
		});
		let fileIndex = 3;
		$('div#fileBox').on('click','span.file-delete',function(){
			$(this).closest('div').remove(); // 가장가까운 자기자신포함 삭제/ 자기제외삭제(Empty)
			let str = `
				<div>
					<input type="file" name="image\${fileIndex}" accept="image/*" required>
					<span class="file-delete"><i class="fas fa-trash-alt"></i></span>
				</div>
			`; // 뺵틱문법 
			$('#fileBox').append(str);
		});
	</script>

</body>
</html>
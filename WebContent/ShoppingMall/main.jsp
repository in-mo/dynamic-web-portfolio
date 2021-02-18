<%@page import="com.exam.vo.AttachVo"%>
<%@page import="com.exam.dao.AttachDao"%>
<%@page import="com.exam.vo.NoticeVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 로그인 상태유지 쿠키정보 가져오기
Cookie[] cookies = request.getCookies();
// 쿠키 name이 "id"인 쿠키객체 찾기
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("id")) {
	String id = cookie.getValue();

	// 로그인 인증 처리(세션에 id값 추가)
	session.setAttribute("id", id);
		}
	}
}

// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 있으면 ..님 반가워요~ [로그아웃]으로 바뀜. [회원가입]은 없어짐.

NoticeDao noticeDao = NoticeDao.getInstance();
// List<NoticeVo> contentList = noticeDao.getProducts();
// for (NoticeVo noticeVo : contentList)
// 	System.out.println(noticeVo);

AttachDao attachDao = AttachDao.getInstance();
// List<AttachVo> imageList = attachDao.getAttaches();

// 검색어 관련 파라미터값 가져오기. 없으면 null 리턴
String category = request.getParameter("category") == null ? "" : request.getParameter("category"); // 검색유형
String search = request.getParameter("search") == null ? "" : request.getParameter("search"); // 검색어
String detail = request.getParameter("detail") == null ? "" : request.getParameter("detail"); // 세부항목
int count = noticeDao.getCountBySearch(category, search, detail);

//한페이지당 보여줄 글갯수 설정
int pageSize = 8;

//사용자가 요청하는 페이지번호 파라미터값 가져오기
String strPageNum = request.getParameter("pageNum");
//사용자 요청 페이지번호 정보가 없을때(null 일때)
//기본 요청 페이지번호를 1페이지로 설정하기
strPageNum = (strPageNum == null) ? "1" : strPageNum;
//사용자 요청 페이지를 정수로 변환
int pageNum = Integer.parseInt(strPageNum);

//가져올 첫행번호 구하기
int startRow = (pageNum - 1) * pageSize;

List<NoticeVo> contentList = null;
if(count > 0)
	contentList = noticeDao.getProductsBySearch(startRow, pageSize, category, search, detail);
// List<AttachVo> imageList = attachDao.getAttachesByPage(startRow, pageSize);
// for (AttachVo noticeVo : imageList)
// 	System.out.println(noticeVo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>

<style>
div {
 	border: 1px solid #d2d2d2;
	padding: 10px;
}

.app {
	width: 1480px;
	margin: auto;
	display: flex;
	flex-direction: column;
}

.verticality {
	display: inline-flex;
	flex-direction: column;
}

.Horizontal {
	display: inline-flex;
	flex-direction: row;
}

.float_right {
	float: right;
}

table {
	border: 1px solid #d2d2d2;
}

.tabTitle:hover {
	background-color: #e3e3e3; 
	cursor: pointer;
}

#search {
	width: 300px;
}
.contentBox {
	width: 240px;
	height: 350px;
	font-size: 13px;
}

#searchText{
	width: 300px;
	height: 30px;
	margin-right: 20px;
	font-size: 18px;
}
table {
	width: 290px;
	font-size: 13px;
}

.tab {
	display: none;
}

.tabTitle {
	width: 290px;
}
a { 
	text-decoration:none 
} 

td {
	cursor: pointer;
}
td:hover {
	background-color: #d2d2d2;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

.tabBtn:hover {
	cursor: pointer;
}
.imgBox:hover {
	background-color: #e3e3e3; 
}

.productInfoBox:hover {
	background-color: #e3e3e3; 
}

.pageBtn {
	display: inline-block;
	width: 30px;
	height: 30px;
	text-align: center;
}
.fas:hover {
	cursor: pointer;
}
</style>
<link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" style="border:none;">
		<div class="verticality">
			<div id="header"><img src="../image/main_top_img.png"></div>
	
			<div id="header_2" style="background-color: black;">
				<form action="main.jsp">
					<h2 style="display: inline-block; margin-right: 20px; color: white;">MUSINSA STORE</h2>
					<select id="category" name="category" style="height: 30px;">
						<option value="상품명" <%=category.equals("상품명") ? "selected" : "" %>>상품명</option>
						<option value="브랜드" <%=category.equals("브랜드") ? "selected" : "" %>>브랜드</option>
					</select>
					<input type="search" id="search" name="search" value="" style="height: 30px;">
					<button type="submit" id="searchBtn" style="background-color: black; vertical-align: middle;">
						<i class="fas fa-search fa-2x" style="color: white; width: 30px; height: 30px; vertical-align: middle;"></i>
					</button>

<!-- 					<input type="submit" id="searchBtn" value="검색"> -->
				</form>
			</div>

			<div id="header_3" style="background-color: #f6f6f6 border:none;" >
				<span>전체</span> | <span>무신사(여성)</span> | <span>무신사(남자)</span>
				<hr style="border: 0; height: 1px; background: #d2d2d2;">
				<%
					if (id != null) {
				%>
				<%=id%>님 | <span id="logut"><a href="logout.jsp">로그아웃</a></span> |
					<span id="myPage"><a href="myPage.jsp">My Page</a></span>
				<%
					} else {
						%>
						<span id="login"><a href="loginForm.jsp">로그인</a></span> | <span
							id="join"><a href="joinForm.jsp">회원 가입</a></span>
						<%
							}
						%>
			</div>
		</div>

		<div class="Horizontal">
			<div id="nav_1">
				<div>
					<span id="products">상품</span> | <span>브랜드</span> | <span>숍연숍</span>
				</div>

<!-- 				<div style="border: 1px solid black;"> -->
<!-- 					<div class="tabTitle"> -->
<!-- 						<span>인기</span> <span class="float_right tabBtn">버튼</span> -->
<!-- 					</div> -->
<!-- 					<div class="tab" style="display: block; "> -->
<!-- 						<table> -->
<!-- 							<tr> -->
<!-- 								<td class="sweatshirts">맨투맨/스웨트 셔츠</td> -->
<!-- 								<td class="short_padding">숏 패딩/숏 헤비 아우터</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td class="hooded_sweatshirt">후드 티셔츠</td> -->
<!-- 								<td class="denim_pants">데님 팬츠</td> -->
<!-- 							</tr> -->

<!-- 							<tr> -->
<!-- 								<td class="neat">니트/스웨터</td> -->
<!-- 								<td class="suit_pants">슈트 팬츠/슬랙스</td> -->
<!-- 							</tr> -->

<!-- 							<tr> -->
<!-- 								<td class="hooded_zip-up">후드 집업</td> -->
<!-- 								<td class="training">트레이닝/조거 팬츠</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td class="fleece">플리스/뽀글이</td> -->
<!-- 								<td class="canvas">캔버스/단화</td> -->
<!-- 							</tr> -->

<!-- 							<tr> -->
<!-- 								<td></td> -->
<!-- 								<td class="running_shoes">러닝화/피트니스화</td> -->
<!-- 							</tr> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 				</div> -->


				<div>
					<div class="tabTitle">
						<span><b>상의</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="short_sleeve_t_shirt">반팔 티셔츠</td>
								<td class="pike">피케/카라 티셔츠</td>
							</tr>
							<tr>
								<td class="long_sleeve">긴팔 티셔츠</td>
								<td class="sweatshirts">맨투맨/스웨트 셔츠</td>
							</tr>

							<tr>
								<td class="sleeveless_t_shirt">민소매 티셔츠</td>
								<td class="hooded_sweatshirt">후드 티셔츠</td>
							</tr>

							<tr>
								<td class="shirt">셔츠/블라우스</td>
								<td class="neat">니트/스웨터</td>
							</tr>
							<tr>
								<td></td>
								<td class="other_tops">기타 상의</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>아우터</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="hooded_zip_up">후드 집업</td>
								<td class="change_season_coat">환절기 코트</td>
							</tr>
							<tr>
								<td class="bluesong">블루종/MA-1</td>
								<td class="winter_single_coat">겨울 싱글 코트</td>
							</tr>

							<tr>
								<td class="red">레드/라이더스 재킷</td>
								<td class="winter_other_caat">겨울 기타 코트</td>
							</tr>

							<tr>
								<td class="trunker_jacket">트러커 재킷</td>
								<td class="suit">슈트/블레이저 제킷</td>
							</tr>
						
							<tr>
								<td class="cardigan">카디건</td>
								<td class="anorak_jacket">아노락 재킷</td>
							</tr>
							
							<tr>
								<td class="fleece">플리스/뽀글이</td>
								<td class="training_jacket">트레이닝 재킷</td>
							</tr>
							
							<tr>
								<td class="stadium_jacket">스타디움 재킷</td>
								<td class="long_padding">롱 패딩/롱 헤비 아우터</td>
							</tr>
							
							<tr>
								<td class="short_padding">숏 패딩/숏 헤비 아우터</td>
								<td class="padding_best">패딩 베스트</td>
							</tr>
							
							<tr>
								<td class="best">베스트</td>
								<td class="Safari">사파리/헌팅 재킷</td>
							</tr>
							<tr>
								<td class="other_outer">기타 아우터</td>
								<td class="nylon">나일론/코치 재킷</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>원피스</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="mini_dress">미니 원피스</td>
								<td class="midi_dress">미디 원피스</td>
							</tr>
							<tr>
								<td></td>
								<td class="maxi_onepiece">맥시 원피스</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>바지</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="denim_pants">데님 팬츠</td>
								<td class="short_pants">숏 팬츠</td>
							</tr>
							<tr>
								<td class="cotton_pants">코튼 팬츠</td>
								<td class="leggings">레깅스</td>
							</tr>

							<tr>
								<td class="suit_pants">슈트 팬츠/슬랙스</td>
								<td class="jump_suit">점프 슈트/오버올</td>
							</tr>

							<tr>
								<td class="training">트레이닝/조거 팬츠</td>
								<td class="other_pants">기타 바지</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>스커트</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="miniskirt">미니스커트</td>
								<td class="midiskirt">미디스커트</td>
							</tr>
							<tr>
								<td></td>
								<td class="long_skirt">롱스커트</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span>가방</span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="backpack">백팩</td>
								<td class="waistback">웨이스트 백</td>
							</tr>
							<tr>
								<td class="messenger">메신저/크로스 백</td>
								<td class="clutch_back">클러치 백</td>
							</tr>

							<tr>
								<td class="shoulder">숄더/토트백</td>
								<td class="pouch_bag">파우치 백</td>
							</tr>

							<tr>
								<td class="eco_bag">에코백</td>
								<td class="briefcase">브리프케이스</td>
							</tr>
							<tr>
								<td class="boston">보스턴/드럼/더플백</td>
								<td class="carrier">캐리어</td>
							</tr>
							<tr>
								<td></td>
								<td class="other_bag">기타 가방</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>스니커즈</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="canvas">캔버스/단화</td>
								<td class="basketball_shoes">농구화</td>
							</tr>
							<tr>
								<td class="running_shoes">러닝화/피트니스화</td>
								<td class="other_sneakers">기타 스니커즈</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>신발</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table style="width: 290px; font-size: 13px;">
							<tr>
								<td class="shoes">구두</td>
								<td class="boots">부츠</td>
							</tr>
							<tr>
								<td class="heel">힐/펌프스</td>
								<td class="flat_shoes">플랫 슈즈</td>
							</tr>

							<tr>
								<td class="roper">로퍼</td>
								<td class="mochaicin">모카신/보트 슈즈</td>
							</tr>

							<tr>
								<td class="sandals">샌들</td>
								<td class="slippers">슬리퍼</td>
							</tr>
							<tr>
								<td class="footwear">신발 용품</td>
								<td class="other_shoes">기타 신발</td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div class="tabTitle">
						<span><b>시계</b></span> <span class="float_right tabBtn"><i class="fas fa-plus"></i></span>
					</div>
					<div class="tab">
						<table>
							<tr>
								<td class="digital">디지털</td>
								<td class="quartz_analog">쿼츠 아날로그</td>
							</tr>
							<tr>
								<td class="automotive_analog">오토매틱 아날로그</td>
								<td class="watch_articles">시계 용품</td>
							</tr>

							<tr>
								<td></td>
								<td class="other_clock">기타 시계</td>
							</tr>
						</table>
					</div>
				</div>
			</div>

			<div id="content_list">
				<%
				if(id!=null)
					if (id.equals("admin")) {
				%> 
					<span class="float_right" id="contentWrite"><a href="contentWriteForm.jsp"><i class="fas fa-edit fa-2x"></i></a></span><br>
				<%
					}
				%>
				<div id="content_list_top" class="Horizontal" style="border:none;"></div>
				<div id="content_list_bottom" class="Horizontal" style="border:none;"></div>
				<div id="page_countrol">
					<div id="page">
					<%
					// 글갯수가 0보다 크면 페이지블록 계산해서 출력하기
					if (count > 0) {
						// 총 필요한 페이지 갯수 구하기
						// 글50개. 한화면에보여줄글 10개 => 50/10 = 5 
						// 글55개. 한화면에보여줄글 10개 => 55/10 = 5 + 1페이지(나머지존재) => 6
						int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
						//int pageCount = (int) Math.ceil((double) count / pageSize);
						
						// 한 화면에 보여줄 페이지갯수 설정
						int pageBlock = 5;
						
						// 화면에 보여줄 시작페이지번호 구하기
						// 1~5          6~10          11~15          16~20       ...
						// 1~5 => 1     6~10 => 6     11~15 => 11    16~20 => 16
						int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
						
						// 화면에 보여줄 끝페이지번호 구하기
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount) {
							endPage = pageCount;
						}
						
						// [이전]
						if (startPage > pageBlock) {
							%>
							<span class="pageBtn"><a href="main.jsp?pageNum=<%=startPage - pageBlock %>"><i class="fas fa-angle-left"></i></a></span>
							<%
						}
						
						// 1 ~ 5
						for (int i=startPage; i<=endPage; i++) {
							if (i == pageNum) {
								%>
								<span class="pageBtn" style="background-color: #e3e3e3; "><a href="main.jsp?pageNum=<%=i %>&category=<%=category%>&search=<%=search%>&detail=<%=detail%>"><b><%=i %></b></a></span>
								<%
							} else {
								%>
								<span class="pageBtn"><a href="main.jsp?pageNum=<%=i %>&category=<%=category%>&search=<%=search%>&detail=<%=detail%>"><%=i %></a></span>
								<%
							}
						} // for
						
						
						// [다음]
						if (endPage < pageCount) {
							%>
							<span class="pageBtn"><a href="main.jsp?pageNum=<%=startPage + pageBlock %>"><i class="fas fa-angle-right"></i></a></span>
							<%
						}
					}
					%>
					</div>
				</div>

				<div style="position: fixed; right: 20px; bottom: 20px; text-align: center; background-color: white;">
				<%if(id!=null) { %>
					<div id="gotoBasketList"><i class="fas fa-shopping-basket fa-2x"></i></div>
				<%} %>
					<div id="gotoTop"><i class="fas fa-angle-up fa-2x"></i></div>
					<div id=gotoBottom><i class="fas fa-angle-down fa-2x"></i></div>
				</div>
			</div>
		</div>
	</div>
<script src="../js/jquery-3.5.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

	// 초기 tab 화면 표시 이벤트
	let detail = '<%=detail%>' == '' ? "없음" : '<%=detail%>';
	$('td:contains('+detail+')').parent().parent().parent().parent().show();
	let selectTabBtn = $('td:contains('+detail+')').parent().parent().parent().parent().prev().children('.tabBtn').children('.fas');
	selectTabBtn.attr('class', 'fas fa-minus');
	
	$('div.tabTitle').on('click', function() {
		if($(this).next().css('display')=='none') {
			$('.tab').hide();
			$('.tab').prev().children('.tabBtn').children('.fas').attr('class','fas fa-plus');
			$(this).next().show();
			$(this).children('.tabBtn').children('.fa-plus').attr('class','fas fa-minus');
		} else {
			$(this).next().hide();
			$(this).children('.tabBtn').children('.fa-minus').attr('class','fas fa-plus');
		}
	});

	// 자동검색 완성 이벤트
	$("#search").keyup(function() {
		let cmd = $(this).val();
		let selectItem = $("#category option:selected").val();
// 		console.log(cmd);
		if(cmd=='')
			return false;
		$.ajax({
			url: 'getSearchResultPro.jsp',
			data: 'cmd='+cmd+'&type='+selectItem,
			success:function(res){
// 				console.log(res);

				 $("#search").autocomplete({  //오토 컴플릿트 시작
			            source : res,    // source 는 자동 완성 대상
			            select : function(event, ui) {    //아이템 선택시
			                console.log(ui.item);
			            },
			            focus : function(event, ui) {    //포커스 가면
			                return false;//한글 에러 잡기용도로 사용됨
			            },
			            minLength: 1,// 최소 글자수
			            autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
			            classes: {    //잘 모르겠음
			                "ui-autocomplete": "highlight"
			            },
			            delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
//			            disabled: true, //자동완성 기능 끄기
			            position: { my : "right top", at: "right bottom" },    //잘 모르겠음
			            close : function(event){    //자동완성창 닫아질때 호출
// 			                console.log(event);
			            }
			        });
					
		
			}
		});
	});

	
	$('#gotoBasketList').on('click', function() {
		let isBasketList = confirm('장바구니로 이동하시겠습니까?');
		if(isBasketList){
			location.href = 'myProducts.jsp';
		}
	});

	$('#gotoTop').on('click', function() {
		$('html').scrollTop(0);
	});
	
	$('#gotoBottom').on('click', function() {
		$('html, body').scrollTop($(document).height());
	});
	
	<%
	if(contentList != null) {
		for (int i = 0; i < contentList.size(); i++) {%>
			var str=`
			<div class="verticality contentBox" style="border:none;">
				<div class="imgBox">
					<a href="content.jsp?article=<%=contentList.get(i).getAttachVo().getReg_article()%>&pageNum=<%=pageNum%>">
					<img
						src="../upload/<%=contentList.get(i).getAttachVo().getUploadpath()%>/
							<%=contentList.get(i).getAttachVo().getImage()%>"
						width="220" height="220">
						</a>
				</div>
				
				<div class="productInfoBox">
					<%
					if(contentList.get(i).getLimitedSale().equals("Y")) {%>
						<span><img src="../image/limited_sale2.png" height="20"></span><br> 
					<%
					}
					%>
					<span><a href="content.jsp?article=<%=contentList.get(i).getArticle()%>&pageNum=<%=pageNum%>"><%=contentList.get(i).getBrand()%></a></span><br>
					<span><a href="content.jsp?article=<%=contentList.get(i).getArticle()%>&pageNum=<%=pageNum%>"><%=contentList.get(i).getProduct()%></a></span><br>
					<span><%=contentList.get(i).getPrice()%>원</span><br>
					<%
					if(contentList.get(i).getLikecount() != 0) { 
					%>
					<span><i style="color: red;" class="fab fa-gratipay"><%=contentList.get(i).getLikecount()%></i></span><br>
					<%
					}
					%>
				</div>
			</div>
			`;
			
			<%if(i>3) {%>
				$('#content_list_bottom').append(str);
			<%}else {%>
			$('#content_list_top').append(str);
			<%}%>
		<%
		}
	}else {%>
		str=`
			<div>
				<h4>게시물이 없습니다.</h4>
			</div>
		`;
		$('#content_list_top').append(str);
	<%
	}
	%>
	/////////////////////////////////////////////////////////////////////////
	// 인기 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 맨투맨/스웨트 셔츠
	$('.sweatshirts').on('click', function() {
		let detail = $('.sweatshirts').text();
		console.log($('.sweatshirts').length);
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 숏 패딩/숏 헤비 아우터
	$('.short_padding').on('click', function() {
		let detail = $('.short_padding').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 후드 티셔츠
	$('.hooded_sweatshirt').on('click', function() {
		let detail = $('.hooded_sweatshirt').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 데님 팬츠
	$('.denim_pants').on('click', function() {
		let detail = $('.denim_pants').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 니트/스웨터
	$('.neat').on('click', function() {
		let detail = $('.neat').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 슈트 팬츠/슬랙스
	$('.suit_pants').on('click', function() {
		let detail = $('.suit_pants').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 후드 집업
	$('.hooded_zip_up').on('click', function() {
		let detail = $('.hooded_zip_up').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 트레이닝/조거 팬츠
	$('.training').on('click', function() {
		let detail = $('.training').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 플리스/뽀글이
	$('.fleece').on('click', function() {
		let detail = $('.fleece').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 캔버스/단화
	$('.canvas').on('click', function() {
		let detail = $('.canvas').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 러닝화/피트니스화
	$('.running_shoes').on('click', function() {
		let detail = $('.running_shoes').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 상의 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 반팔 티셔츠
	$('.short_sleeve_t_shirt').on('click', function() {
		let detail = $('.short_sleeve_t_shirt').text();
		console.log(detail);
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 피케/카라 티셔츠
	$('.pike').on('click', function() {
		let detail = $('.pike').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 긴팔 티셔츠
	$('.long_sleeve').on('click', function() {
		let detail = $('.long_sleeve').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 민소매 티셔츠
	$('.sleeveless_t_shirt').on('click', function() {
		let detail = $('.sleeveless_t_shirt').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 셔츠/블라우스
	$('.shirt').on('click', function() {
		let detail = $('.shirt').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 상의
	$('.other_tops').on('click', function() {
		let detail = $('.other_tops').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 아우터 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 환절기 코트
	$('.change_season_coat').on('click', function() {
		let detail = $('.change_season_coat').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 블루종
	$('.bluesong').on('click', function() {
		let detail = $('.bluesong').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 겨울 싱글 코트
	$('.winter_single_coat').on('click', function() {
		let detail = $('.winter_single_coat').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 레드/라이더스 재킷
	$('.red').on('click', function() {
		let detail = $('.red').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 겨울 기타 코트
	$('.winter_other_coat').on('click', function() {
		let detail = $('.winter_other_coat').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 트러커 재킷
	$('.trunker_jacket').on('click', function() {
		let detail = $('.trunker_jacket').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 슈트/블레이저 재킷
	$('.suit').on('click', function() {
		let detail = $('.suit').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 카디건
	$('.cardigan').on('click', function() {
		let detail = $('.cardigan').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 아노락 재킷
	$('.anorak_jacket').on('click', function() {
		let detail = $('.anorak_jacket').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 트레이닝 재킷
	$('.training_jacket').on('click', function() {
		let detail = $('.training_jacket').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 스타디움 재킷
	$('.stadium_jacket').on('click', function() {
		let detail = $('.stadium_jacket').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 롱 패딩/롱 헤비 아우터
	$('.long_padding').on('click', function() {
		let detail = $('.long_padding').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 패딩 베스트
	$('.padding_best').on('click', function() {
		let detail = $('.padding_best').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 패딩 베스트
	$('.best').on('click', function() {
		let detail = $('.best').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 사파리/헌팅 재킷
	$('.safari').on('click', function() {
		let detail = $('.safari').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 아우터
	$('.other_outer').on('click', function() {
		let detail = $('.other_outer').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 나일론/코치 재킷
	$('.nylon').on('click', function() {
		let detail = $('.nylon').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	/////////////////////////////////////////////////////////////////////////
	// 원피스 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 미니 원피스
	$('.mini_dress').on('click', function() {
		let detail = $('.mini_dress').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 미디 원피스
	$('.midi_dress').on('click', function() {
		let detail = $('.midi_dress').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 맥시 원피스
	$('.maxi_onepiece').on('click', function() {
		let detail = $('.maxi_onepiece').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 바지 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 숏 팬츠
	$('.short_pants').on('click', function() {
		let detail = $('.short_pants').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 코튼 팬츠
	$('.cotton_pants').on('click', function() {
		let detail = $('.cotton_pants').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 레깅스
	$('.leggings').on('click', function() {
		let detail = $('.leggings').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 점프 슈트/오버올
	$('.jump_suit').on('click', function() {
		let detail = $('.jump_suit').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 바지
	$('.other_pants').on('click', function() {
		let detail = $('.other_pants').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});

	/////////////////////////////////////////////////////////////////////////
	// 스커트 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 미니스커트
	$('.miniskirt').on('click', function() {
		let detail = $('.miniskirt').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 미디스커트
	$('.midiskirt').on('click', function() {
		let detail = $('.midiskirt').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});

	/////////////////////////////////////////////////////////////////////////
	// 가방 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 백팩
	$('.backpack').on('click', function() {
		let detail = $('.backpack').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 웨이스트 백
	$('.waistback').on('click', function() {
		let detail = $('.waistback').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 메신저
	$('.messenger').on('click', function() {
		let detail = $('.messenger').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 클러치 백
	$('.clutch_back').on('click', function() {
		let detail = $('.clutch_back').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 숄더/토트백
	$('.shoulder').on('click', function() {
		let detail = $('.shoulder').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 파우치 백
	$('.pouch_bag').on('click', function() {
		let detail = $('.pouch_bag').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 에코백
	$('.eco_bag').on('click', function() {
		let detail = $('.eco_bag').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 브리프케이스
	$('.briefcase').on('click', function() {
		let detail = $('.briefcase').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 보스턴/드럼/더블백
	$('.boston').on('click', function() {
		let detail = $('.boston').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 캐리어
	$('.carrier').on('click', function() {
		let detail = $('.carrier').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 가방
	$('.other_bag').on('click', function() {
		let detail = $('.other_bag').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 스니커즈 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 농구화
	$('.basketball_shoes').on('click', function() {
		let detail = $('.basketball_shoes').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 스니커즈
	$('.other_sneakers').on('click', function() {
		let detail = $('.other_sneakers').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 신발 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 구두
	$('.shoes').on('click', function() {
		let detail = $('.shoes').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 부츠
	$('.boots').on('click', function() {
		let detail = $('.boots').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 힐/펌프스
	$('.heel').on('click', function() {
		let detail = $('.heel').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 플랫 슈즈
	$('.flat_shoes').on('click', function() {
		let detail = $('.flat_shoes').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 로퍼
	$('.roper').on('click', function() {
		let detail = $('.roper').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 모카신/보트 슈즈
	$('.mochaicin').on('click', function() {
		let detail = $('.mochaicin').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 샌들
	$('.sandals').on('click', function() {
		let detail = $('.sandals').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 슬리퍼
	$('.slippers').on('click', function() {
		let detail = $('.slippers').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 신발 용품
	$('.footwear').on('click', function() {
		let detail = $('.footwear').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 신발
	$('.other_shoes').on('click', function() {
		let detail = $('.other_shoes').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	/////////////////////////////////////////////////////////////////////////
	// 시계 /////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	// 디지털
	$('.digital').on('click', function() {
		let detail = $('.digital').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 쿼츠 아날로그
	$('.quartz_analog').on('click', function() {
		let detail = $('.quartz_analog').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 오토매틱 아날로그
	$('.automotive_analog').on('click', function() {
		let detail = $('.automotive_analog').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 시계 용품
	$('.watch_articles').on('click', function() {
		let detail = $('.watch_articles').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
	
	// 기타 시계
	$('.other_clock').on('click', function() {
		let detail = $('.other_clock').text();
		location.href = 'main.jsp?detail='+detail+'&startRow=<%=startRow%>&pageSize=<%=pageSize%>';
	});
</script>
		
</body>
</html>

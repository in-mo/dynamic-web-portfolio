<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.dao.*"%>
<%@page import="com.exam.vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String id = (String) session.getAttribute("id") == null ? "" :  (String) session.getAttribute("id");
String article = request.getParameter("article");
String pageNum = request.getParameter("pageNum");
NoticeDao noticeDao = NoticeDao.getInstance();
MemberDao memberDao = MemberDao.getInstance();
QuantityDao quantityDao = QuantityDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();
OrderDao orderDao = OrderDao.getInstance();
ReplyDao replyDao = ReplyDao.getInstance();
QnaDao qnaDao = QnaDao.getInstance();
LikeDao likeDao = LikeDao.getInstance();

NoticeVo noticeVo1 = noticeDao.getProductByArticle(article);
LikeVo likeVo = likeDao.getProductLikeInfo(id, article);
noticeDao.updateReadcount(article);

List<QuantityVo> qList = quantityDao.getQuantityByArticle(article);
List<AttachVo> aList = attachDao.getAttachesByArticle(article);
List<OrderVo> orderList = orderDao.getOrderListByArticle(article);
List<ReplyVo> replyList = replyDao.getReplyesByArticle(article, 0, 5);
List<ReplyVo> replyGradeList = replyDao.getReplyesByArticle(article);
List<QnaVo> qnaList = qnaDao.getQnasByArticle(article, 1, 10);

int qnaCount = qnaDao.getCountByArtcle(article);
int replyCount = replyDao.getCountByArticle(article);
int likeCount = likeDao.getLikecount(article);

int[] genderCount = orderDao.getGenderCount(article);

double avg_age = 0;
for(int i=0;i<orderList.size();i++){
	MemberVo memberVo = memberDao.getMemberById(orderList.get(i).getId());
	avg_age +=memberVo.getAge();
}
avg_age =  Float.parseFloat(String.format("%.1f", avg_age/orderList.size()));

double grade = 0;
for(int i=0;i<replyGradeList.size();i++){
	grade += Float.parseFloat(replyGradeList.get(i).getGrade());
}
grade = Float.parseFloat(String.format("%.1f", grade/replyGradeList.size()));
noticeVo1.setAvg_age(Double.isNaN(avg_age)? 0: (float)avg_age);
noticeVo1.setGrade(Double.isNaN(grade)? 0: (float)grade);
noticeDao.updateNoticeData(noticeVo1);

NoticeVo noticeVo = noticeDao.getProductByArticle(article);

int numS = 5, numM = 5, numL = 5, numXL = 5;
for (int i = 0; i < qList.size(); i++) {
	String str = qList.get(i).getSize();
	if (str.equals("S"))
		numS = i;
	else if (str.equals("M"))
		numM = i;
	else if (str.equals("L"))
		numL = i;
	else if (str.equals("XL"))
		numXL = i;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>

<style>
.app {
	width: 835px;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -400px;
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
	padding: 5px;
}
td {
	padding: 5px;
}

tr:hover{
	cursor: pointer;
	background-color: #d2d2d2;
}

.productInfoTable{
	width: 430px;
}

.float_right {
	float: right;
}

.purchaseC {
	width: 50px;
	border:none;
	text-align: center;
}
.purchaseQ {
	width: 50px;
	text-align: center;
}

.purchaseS {
	width: 30px;
	border:none;
	text-align: center;
}
#contentInfo{
	width: 450px;
}

.verticality {
	display: inline-flex;
	flex-direction: column;
}

.Horizontal {
	display: inline-flex;
	flex-direction: row;
}
a { 
	text-decoration:none 
} 
.btnTag:hover {
	cursor: pointer;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
.image_container img {
	width: 100px;
	height: 100px;
}
.fa-trash-alt:hover{
	cursor: pointer;
}
.blind {
	position: absolute;
	overflow: hidden;
	margin: -1px;
	padding: 0;
	width: 1px;
	height: 1px;
  	border: none;
  	clip: rect(0, 0, 0, 0);
}

.startRadio {
  	display: inline-block;
  	overflow: hidden;
	height: 40px;
}
.startRadio:after {
	content: "";
	display: block;
	position: relative;
	z-index: 10;
	height: 40px;
	background: url("data:image/png;base64,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") repeat-x 0 0;
	background-size: contain;
	pointer-events: none;
}
.startRadio__box {
  	position: relative;
  	z-index: 1;
  	float: left;
  	width: 20px;
  	height: 40px;
  	cursor: pointer;
}
.startRadio__box input {
  	opacity: 0 !important;
  	height: 0 !important;
  	width: 0 !important;
  	position: absolute !important;
}
.startRadio__box input:checked + .startRadio__img {
  background-color: #0084ff;
}
.startRadio__img {
  display: block;
  position: absolute;
  right: 0;
  width: 500px;
  height: 40px;
  pointer-events: none;
}
body {
	background-color: black;
}
.orderBtn{
	text-align:center;
	display:table-cell;
	vertical-align:middle; 
	width:200px; 
	height: 50px; 
	padding:0px; 
	background-color: black; 
	color: white; 
	font-size: 18px;
}

.writeBtn{
	text-align:center;
	width:100px; 
	height: 30px; 
	background-color: black; 
	color: white; 
	font-size: 15px;
}

.pageBtn:hover{
	cursor: pointer;
}

.pageBtn{
	display: inline-block;
	width: 30px;
	height: 30px;
	text-align: center;
}

.reviewInfoBox {
	 border: solid #d2d2d2 1px;
}

.replyContent {
	width: 600px;
	border: solid #d2d2d2 1px;
}

.reviewInfoBox:hover{
	background-color: #efefef; 
}
.replyDeleteBtn:hover{
	cursor: pointer;
}
.replyModifyBtn:hover{
	cursor: pointer;
}
.replyDeleteBtn {
	width:100px; 
	height: 30px; 
	background-color: black; 
	color: white; 
	font-size: 15px;
	margin-left: 10px;
}
.replyModifyBtn{
	width:100px; 
	height: 30px; 
	background-color: black; 
	color: white; 
	font-size: 15px;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app">
		<span><a href="main.jsp?pageNum=<%=pageNum%>"><i class="fas fa-arrow-left"></i></a></span>
		<div class="Horizontal">
			<div class="inline" style="margin-top: 30px;">
				<h3>Product Image</h3>
				<hr style="border: 0; height: 1px; background: #d2d2d2;">
				<%
					for (AttachVo attachVo : aList) {
				%>
				<div>
					<img
						src="../upload/<%=attachVo.getUploadpath()%>/<%=attachVo.getImage()%>" width="300">
				</div>
				<%
					}
				%>
			</div>
	
			<div id="contentInfo" class="inline">
				<div>
					<%if(id.equals("admin")){ %>
					<span class="float_right btnTag" id="deleteBtn" style="margin-left: 10px;"><i class="fas fa-eraser fa-3x"></i></span>
					<span class="float_right btnTag" id="modifyBtn"><i class="fas fa-pen-square fa-3x"></i></span>
					<%} %>
					<%if(noticeVo.getLimitedSale().equals("Y")) {%>
						<h3>한정판매 <img src="../image/limited_sale.png" height="30"></h3> 
						<hr style="border: 0; height: 1px; background: #d2d2d2;">
					<%}%>
					<%if(noticeVo.getLimitedSale().equals("Y")) {%>
							<div>무신사 스토어를 포함한 제한된 판매처에서만 구매 가능한 상품입니다.</div>
					<%}%>
				</div>

				<div>
					<h3>Product Info</h3>
					<hr style="border: 0; height: 1px; background: #d2d2d2;">
					<table class="productInfoTable">
						<tr>
							<td>- 브랜드</td>
							<td><%=noticeVo.getBrand()%></td>
						</tr>
						
						<tr>
							<td>- 상품명</td>
							<td><%=noticeVo.getProduct()%></td>
						</tr>
						
						<tr>
							<td>- 성별</td>
							<td><%=noticeVo.getGender()%></td>
						</tr>
	
						<tr>
							<td>- 조회수</td>
							<td><%=noticeVo.getReadcount() + 1%></td>
						</tr>
	
						<tr>
							<td>- 누적판매</td>
							<td><%=noticeVo.getSalecount()%></td>
						</tr>
						
						<tr>
							<td>- 평점</td>
							<td id="productGrade"><%=noticeVo.getGrade()%></td>
						</tr>
						
						<tr>
							<td>- 좋아요</td>
							<td id="productLikecount"><%=likeCount%></td>
						</tr>
					</table>
				</div>
				<div style="text-align: center;">
					<span>⭐</span><%=noticeVo.getAvg_age() %>세,
					<%if(genderCount[0]==0 && genderCount[1]==0) {%>
						구매정보 부족<span>⭐</span>
					<%} else if(genderCount[0]==genderCount[1]){%>
						남녀모두 구매<span>⭐</span>
					<%} else {%>
					 <%=genderCount[0]>genderCount[1] ? "남성" : "여성" %>이 주로 구매<span>⭐</span>
					<%} %>
				</div>
				<div>
					<h3>Delivery Info</h3>
					<hr style="border: 0; height: 1px; background: #d2d2d2;">
					<table class="productInfoTable">
						<tr>
							<td>- 배송 방법</td>
							<td><%=noticeVo.getDelivery()%></td>
						</tr>
						<tr>
							<td>- 출고 기간</td>
							<td><%=noticeVo.getReleasedate()%> / <%
								if (noticeVo.getWeekend().equals("Y")) {
							%> 주말, 공휴일 배송 <%
								} else {
							%> 주말ㆍ공휴일 배송 제외 <%
								}
							%></td>
						</tr>
					</table>
				</div>
				<div>
					<h3>Price Info</h3>
					<hr style="border: 0; height: 1px; background: #d2d2d2;">
					<table class="productInfoTable">
						<tr>
							<td>- 무신사 판매가</td>
							<td><%=noticeVo.getPrice()%>원</td>
						</tr>
						<tr>
							<td>- 무신사 세일가</td>
							<td><%=noticeVo.getSale()%>원</td>
						</tr>
					</table>
				</div>
				<div>
					<h3>옵션</h3>
					<hr style="border: 0; height: 1px; background: #d2d2d2;">
					<form>
						<select name="size" id="size" style="width: 425px;" onchange="itemChange()">
							<option value="none">=== 사이즈 ===</option>
							<option value="S">S</option>
							<option value="M">M</option>
							<option value="L">L</option>
							<option value="XL">XL</option>
						</select><br> 
						<select name="color" id="color" style="width: 425px;" onchange="selectItem()">
						</select>
						<div id="purchaseList"></div>
						<div class="Horizontal" style="text-align: center;">
							<div>
								<div class="btnTag orderBtn" onclick="purchase();">바로 구매
								</div>
							</div>
							<div>
								<button type="button" style="height: 50px; background-color: white;" onclick="containItem()"><i class="fas fa-shopping-basket fa-3x btnTag"></i></button>
							</div>
							<div id="likeInfo" style="text-align: center;">
			<%	
						if(likeVo!=null) {
							if(likeVo.getIslike().equals("Y")){
			%>
								<i style="color: red;" class="fab fa-gratipay fa-3x btnTag" onclick="updateLikeInfo(event)">
									<input type="hidden" name="likeVal" value="Y">
								</i>
			<%
							} else {
			%>
								<i class="fab fa-gratipay fa-3x btnTag" onclick="updateLikeInfo(event)">
									<input type="hidden" name="likeVal" value="N">
								</i>
			<%
							}
						} else {
			%>
								<i class="fab fa-gratipay fa-3x btnTag" onclick="updateLikeInfo(event)">
									<input type="hidden" name="likeVal" value="N">
								</i>
			<%
						}
			%>
							</div>
						</div>
					</form>
				</div>
	
			</div>
		</div>
		<div id="analysis">
			<h4>구매 회원 분석</h4>
			<hr style="border: 0; height: 1px; background: #d2d2d2;">
			<div class="Horizontal">
				<div id="chart1" style="width: 50%; height: 100%;"></div>
				<div id="chart2" style="width: 50%; height: 100%;"></div>
			</div>
		</div>
		
		<div id="qnaList">
			<h4 id="qnaCount">Q&A 상품문의 [총 <%=qnaCount %>건]</h4>
			<hr style="border: 0; height: 1px; background: #d2d2d2;">
			<div>
				<table>
					<tr>
						<th style="width: 80px;">번호</th>
						<th style="width: 90px;">구분</th>
						<th style="width: 350px;">제목</th>
						<th style="width: 120px;">작성자</th>
						<th style="width: 120px;">등록일자</th>					
					</tr>
			<%if(qnaCount>0) { 
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				for(QnaVo qnaVo : qnaList){
			%>
					<tr>
						<td class="qnaNum" style="text-align: center;"><%=qnaVo.getNum() %></td>
						<td style="text-align: center;"><%=qnaVo.getType() %></td>
						<td onclick="qnaTitleClick(event)">
				<%
					if(qnaVo.getRe_lev()>0){
				%>
							<i class="fab fa-replyd fa-2x"></i>
							<%=qnaVo.getTitle() %>
				<%
					} else {
				%>
							<%=qnaVo.getTitle() %>
				<%
					}
				%>
						</td>
						<td class="qnaID" style="text-align: center;"><%=qnaVo.getId() %></td>
						<td style="text-align: center;"><%=sdf.format(qnaVo.getReg_date()) %></td>
					</tr>	
			<%	
				}
			} else {
			%>
					<tr>
						<td colspan="5" style="text-align: center;">등록된 질문이 없습니다.</td>
					</tr>
			<%
			}
			%>
				</table>
			</div>
			
			<div id="qnaPage">
			<%if(!id.equals("")&&(!id.equals("admin"))){%>
				<input type="button" class="float_right btnTag writeBtn" onclick="qnaWriteBtn()" value="글쓰기">
				<%} %>
			</div>
			
		</div>
		
		<div>
			<%if(!id.equals("")){ %>
			<h4>상품 리뷰 작성</h4>
			<hr style="border: 0; height: 1px; background: #d2d2d2;">
			<div class="Horizontal">
				<div class="image_container" style="width: 100px; height: 100px;">
					<img onerror="this.src='../image/no_img.png'" src="" id="previewImg" width="100" height="100">
				</div>
				
				<form enctype="multipart/form-data" id="replyForm" method="post">
					<input type="hidden" name="article" value="<%=article%>">
					<input type="hidden" name="grade" value="0">
					<input type="hidden" name="filename" value="">
					<textarea name="content" style="resize: none; width: 650px; height: 120px;" maxlength="100" placeholder="100자 이내"></textarea>
					<br>
					<div class="startRadio" style="padding: 0px;">
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">0.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">1</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">1.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">2</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">2.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">3</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">3.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">4</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">4.5</span></span>
						</label>
						<label class="startRadio__box">
							<input type="radio" name="star" >
							<span class="startRadio__img"><span class="blind">5</span></span>
						</label>
					</div>
					<div id="reviewWrite">
						<input type="file" name="image1" id="image1" accept="image/*" onchange="preViewImg(event);">
						<span class="image-delete"><i class="fas fa-trash-alt"></i></span>
					</div>
					<input type="button" class="float_right btnTag replyModifyBtn" id="applyReviewBtn" value="등록">
				</form>
			</div>
			<%
			}
			%>
			
			<div id="reviewBox">
				<h4>상품 리뷰</h4>
				<hr style="border: 0; height: 1px; background: #d2d2d2;">
				<%
				if(replyList.size() != 0) {
					for(ReplyVo replyVo : replyList) {
				%>
				<div class="reviewInfoBox" id="reviewInfo<%=replyVo.getNum()%>">
					<div>
						<input type="hidden" name="replyNum" value="<%=replyVo.getNum()%>">
						<input type="hidden" name="grade" value="<%=replyVo.getGrade()%>">
						<span>작성자 : <%=replyVo.getId() %></span>
						<span class="float_right" class="replyDate">작성 날짜 : <%=replyVo.getReg_date()%></span>
					</div>
					<div class="Horizontal">
						<div style="width: 100px; height: 100px;">
							<img src="../upload/<%=replyVo.getUploadpath() %>/<%=replyVo.getImage() %>" width="100" height="100">
						</div>
						<div class="replyContent"><%=replyVo.getContent() %></div>
					</div>
					<div class="startRadio" style="padding: 0px;">
						<label class="startRadio__box star0_5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">0.5</span></span>
						</label>
						<label class="startRadio__box star1">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">1</span></span>
						</label>
						<label class="startRadio__box star1_5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">1.5</span></span>
						</label>
						<label class="startRadio__box star2">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">2</span></span>
						</label>
						<label class="startRadio__box star2_5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">2.5</span></span>
						</label>
						<label class="startRadio__box star3">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">3</span></span>
						</label>
						<label class="startRadio__box star3_5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">3.5</span></span>
						</label>
						<label class="startRadio__box star4">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">4</span></span>
						</label>
						<label class="startRadio__box star4_5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">4.5</span></span>
						</label>
						<label class="startRadio__box star5">
							<input type="radio" class="star" name="star<%=replyVo.getNum()%>" disabled>
							<span class="startRadio__img"><span class="blind">5</span></span>
						</label>
					</div>
				<%
						if(id.equals(replyVo.getId())) {
				%>
					<input type="button" class="float_right replyDeleteBtn btnTage" value="삭제" onclick="replyDelete(event);">
					<input type="button" class="float_right replyModifyBtn btnTage" value="수정" onclick="replyUpdate(event);">
				<%
						} else if(id.equals("admin")){
				%>
							<input type="button" class="float_right replyDeleteBtn btnTage" value="삭제" onclick="replyDelete(event);">
				<%
						}
				%>
				</div>
				<%		
					}
				} else {
				%>
					<div id="noneReply">등록된 리뷰가 없습니다.</div>
				<%
				}
				%>
				<div id="replyPage">
				
				</div>
			</div>
		</div>
		<div style="position: fixed; right: 20px; bottom: 20px; text-align: center; background-color: white; border: 1px solid #d2d2d2;">
			<%if(id!="") { %>
				<div style="border: 1px solid #d2d2d2;" id="gotoBasketList"><i class="fas fa-shopping-basket fa-2x"></i></div>
			<%} %>
				<div style="border: 1px solid #d2d2d2;" id="gotoTop"><i class="fas fa-angle-up fa-2x btnTag"></i></div>
				<div style="border: 1px solid #d2d2d2;" id=gotoBottom><i class="fas fa-angle-down fa-2x btnTag"></i></div>
		</div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script src="https://malsup.github.com/jquery.form.js"></script>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
		var offset;
		var offCnt=0;
	
		$('#gotoTop').on('click', function() {
			$('html').scrollTop(0);
			offCnt = 0;
		});
		
		$('#gotoBottom').on('click', function() {
			if(offCnt == 0) {
				offset = $('#analysis').offset();
				$('html').animate({scrollTop: offset.top}, 400);
				offCnt = 1;
			} else {
				offset = $('#reviewBox').offset();
				$('html').animate({scrollTop: offset.top}, 400);
				offCnt = 2;
			}
		});
		
		$('#gotoBasketList').on('click', function() {
			let isBasketList = confirm('장바구니로 이동하시겠습니까?');
			if(isBasketList){
				location.href = 'myProducts.jsp';
			}
		});
	
		function updateLikeInfo(event) {
			let likeInfo = $(event.currentTarget).children('input[name="likeVal"]').val();
			let id = '<%=id%>';
			if(id == ''){
				alert('로그인 후 좋아요를 할 수 있습니다');
				return false;
			}
			
			if(likeInfo == 'N') {
				$(event.currentTarget).children('input[name="likeVal"]').val('Y');
				$(event.currentTarget).css('color','red');
				
				$.ajax({
					url: 'updateLikeInfoPro.jsp',
					data: {article: '<%=article%>', islike: 'Y'},
					success:function(res){
						$('#productLikecount').text(Number($('#productLikecount').text())+1);
					}
				});
			} else {
				$(event.currentTarget).children('input[name="likeVal"]').val('N');
				$(event.currentTarget).css('color','');
				
				$.ajax({
					url: 'updateLikeInfoPro.jsp',
					data: {article: '<%=article%>', islike: 'N'},
					success:function(res){
						$('#productLikecount').text(Number($('#productLikecount').text())-1);
					}
				});
			}
		}
	
		var qnaPageSize = 10;
		var qnaPageNum = 1;
		var qnaStartRow = (isNaN((qnaPageNum - 1) * qnaPageSize)) ? 0 : (qnaPageNum - 1) * qnaPageSize;
		var qnaCount = <%=qnaCount%>;
		updateQnaList();
		
		// Qna의 페이지 버튼 이벤트
		function qnaPageBtn(event){
			qnaPageNum = $(event.currentTarget).text();
			qnaStartRow = (qnaPageNum - 1) * qnaPageSize;
			updateQnaList();
		}
		
		//Qna의 이전버튼을 눌렀을때 이벤트
		function qnaPrevPage(){
			qnaPageNum = (Math.floor((qnaPageNum / 10)) - (replyPageNum % 10 == 0 ? 1 : 0)) * 10 + 1 - 10;
			qnaStartRow = (qnaPageNum - 1) * qnaPageSize;
			updateQnaList();
		}
		
		// Qna의 다음 버튼을 눌렀을 때 이벤트
		function qnaNextPage(){
			qnaPageNum = (Math.floor((qnaPageNum / 10)) - (replyPageNum % 10 == 0 ? 1 : 0)) * 10 + 1 + 10;
			qnaStartRow = (qnaPageNum - 1) * qnaPageSize;
			updateQnaList();
		}
		
		function updateQnaPage(){
			$.ajax({
				url: 'getQnaCount.jsp',
				data: 'article=<%=article%>',
				success:function(res){
					qnaCount = res;
				}
			});
			
			
			if(qnaCount > 0){
				let qnaPageInfoNum ='';
				let qnaPageCount = (Math.floor(qnaCount / qnaPageSize)) + (qnaCount % qnaPageSize == 0 ? 0 : 1);			
				let qnaPageBlock = 10;
				let qnaStartPage = (Math.floor((qnaPageNum / qnaPageBlock)) - (qnaPageNum % qnaPageBlock == 0 ? 1 : 0)) * qnaPageBlock + 1;
				
				let qnaEndPage = qnaStartPage + qnaPageBlock - 1;
				if (qnaEndPage > qnaPageCount) {
					qnaEndPage = qnaPageCount;
				}
				
				// [이전]
				if (qnaStartPage > qnaPageBlock) {
					qnaPageInfoNum+=`
						<span class="pageListNum pageBtn" onclick="qnaPrevPage()">[이전]</span>
					`;
				}
				
				// 1 ~ 5
				for (let i=qnaStartPage; i<=qnaEndPage; i++) {
					
					if (i == qnaPageNum) {
						qnaPageInfoNum+=`
							<span class="pageListNum pageBtn" style="background-color: #e3e3e3;" onclick="qnaPageBtn(event)"><b>\${ i }</b></span>
						`;
					} else {
						qnaPageInfoNum+=`
							<span class="pageListNum pageBtn" onclick="qnaPageBtn(event)">\${ i }</span>
						`;
					}
				} // for
				
				
				// [다음]
				if (qnaEndPage < qnaPageCount) {
					qnaPageInfoNum+=`
						<span class="pageListNum pageBtn" onclick="qnaNextPage()">[다음]</span>
					`;
				}
				$('#qnaPage').append(qnaPageInfoNum);
			}
		}
		var replyPageSize = 5;
		var replyPageNum = 1;
		var replyStartRow = (isNaN((replyPageNum - 1) * replyPageSize)) ? 0 : (replyPageNum - 1) * replyPageSize;;
		var replyCount = <%=replyCount%>;
		updateReplyPage();
		
		// 상품 리뷰의 페이지 버튼 이벤트
		function replyPageBtn(event){
			replyPageNum = $(event.currentTarget).text();
			replyStartRow = (replyPageNum - 1) * replyPageSize;
			getReplyListPro();
		}
		
		// 상품 리뷰의 이전버튼을 눌렀을때 이벤트
		function replyPrevPage(){
			replyPageNum = (Math.floor((replyPageNum / 5)) - (replyPageNum % 5 == 0 ? 1 : 0)) * 5 + 1 - 5;
			replyStartRow = (replyPageNum - 1) * replyPageSize;
			getReplyListPro();
		}
		
		// 상품 리뷰의 다음 버튼을 눌렀을 때 이벤트
		function replyNextPage(){
			replyPageNum = (Math.floor((replyPageNum / 5)) - (replyPageNum % 5 == 0 ? 1 : 0)) * 5 + 1 + 5;
			replyStartRow = (replyPageNum - 1) * replyPageSize;
			getReplyListPro();
		}
		
		// 상품 리뷰 글 목록 페이지화 이벤트
		function updateReplyPage(){
			$.ajax({
				url: 'getReplyCountPro.jsp',
				data: 'article=<%=article%>',
				success:function(res){
					replyCount = res;
				}
			});
			
			
			if(replyCount > 0){
				let replyPageInfoNum ='';
				let replyPageCount = (Math.floor(replyCount / replyPageSize)) + (replyCount % replyPageSize == 0 ? 0 : 1);			
				let replyPageBlock = 10;
				let replyStartPage = (Math.floor((replyPageNum / replyPageBlock)) - (replyPageNum % replyPageBlock == 0 ? 1 : 0)) * replyPageBlock + 1;
				
				let replyEndPage = replyStartPage + replyPageBlock - 1;
				if (replyEndPage > replyPageCount) {
					replyEndPage = replyPageCount;
				}
				
				// [이전]
				if (replyStartPage > replyPageBlock) {
					replyPageInfoNum+=`
						<span class="pageListNum pageBtn" onclick="replyPrevPage()">[이전]</span>
					`;
				}
				
				// 1 ~ 5
				for (let i=replyStartPage; i<=replyEndPage; i++) {
					
					if (i == replyPageNum) {
						replyPageInfoNum+=`
							<span class="pageListNum pageBtn" style="background-color: #e3e3e3;" onclick="replyPageBtn(event)"><b>\${ i }</b></span>
						`;
					} else {
						replyPageInfoNum+=`
							<span class="pageListNum pageBtn" onclick="replyPageBtn(event)">\${ i }</span>
						`;
					}
				} // for
				
				
				// [다음]
				if (replyEndPage < replyPageCount) {
					replyPageInfoNum+=`
						<span class="pageListNum pageBtn" onclick="replyNextPage()">[다음]</span>
					`;
				}
				$('#replyPage').append(replyPageInfoNum);
			}
		}
	
		// qna 답글 수정
		function qnaReplyoModifyBtn(event) {
			let qnaNum = event.currentTarget.parentNode.querySelector('input[name="qnaNum"]').value;
			console.log('qnaNum : '+ qnaNum);
			let isAnswer = confirm('답글을 수정하시겠습니까?');
			console.log($(event.currentTarget.parentNode.parentNode.parentNode).prev().prev().children('.qnaNum').text());
			if(isAnswer){
				window.open('productQnaAnswerForm.jsp?article=<%=article%>&qnaNum='+qnaNum+'&form=modify','productQna','width=600, height=900');
			}
		}
		
		// qna 댓글 쓰기
		function qnaReplyAddBtn(event){
			let qnaNum = event.currentTarget.parentNode.querySelector('input[name="qnaNum"]').value;
			let isAnswer = confirm('답글을 작성하시겠습니까?');
			if(isAnswer){
				window.open('productQnaAnswerForm.jsp?article=<%=article%>&qnaNum='+qnaNum+'&form=write','productQna','width=600, height=900');
			}
		}
		
		// qna 내용 삭제
		function qnaInfoDeleteBtn(event) {
			let qnaNum = event.currentTarget.parentNode.querySelector('input[name="qnaNum"]').value;
			let isDelete = confirm('글을 삭제하시겠습니까?');
			if(isDelete){
				$.ajax({
					url: 'deleteQnaInfoPro.jsp',
					data: { qnaNum : qnaNum},
					success:function(res){
						updateQnaList();
					}	
				});
			}
		}
		
		// qna 내용 수정창 띄우기
		function qnaInfoModifyBtn(event) {
			let qnaNum = event.currentTarget.parentNode.querySelector('input[name="qnaNum"]').value;
			window.open('productQnaForm.jsp?article=<%=article%>&qnaNum='+qnaNum,'productQna','width=600, height=980');
		}
		
		// qna 내용 표시 이벤트
		var dupCheck = 0;
		function qnaTitleClick(event) {
			let qnaNum = event.currentTarget.parentNode.querySelector('.qnaNum').innerHTML;
			let tag = event.currentTarget.parentNode;
			let id = '<%=id%>';
			let str;
			
			$.ajax({
				url: 'getQnaInfo.jsp',
				data: {num : qnaNum},
				success:function(res){
					$('.qnaContent').remove();
					
					if(dupCheck == res.num){
						dupCheck = 0;
						$('tr').css('background-color','');
						return false;
					}
						
					dupCheck = res.num;
					$('tr').css('background-color','');
					$(tag).css('background-color','#d2d2d2');
					str = `
						<tr class="qnaContent">
							<td colspan="5">
								<div style="border: 1px solid #d2d2d2;">\${ res.content }</div>
					`;
					if(id==res.id){
						str += `
								<div style="text-align: center">
									<input type="hidden" name="qnaNum" value="\${ res.num }">
									<input type="button" class="writeBtn btnTag" value="수정" onclick="qnaInfoModifyBtn(event)">
									<input type="button" class="writeBtn btnTag" value="삭제" onclick="qnaInfoDeleteBtn(event)">
								</div>
						`;
					} else if(id=='admin'){
						if(res.re_lev == 0){
							str += `
								<div style="text-align: center">
									<input type="hidden" name="qnaNum" value="\${ res.num }">
									<input type="button" class="writeBtn btnTag" value="답변" onclick="qnaReplyAddBtn(event)">
									<input type="button" class="writeBtn btnTag" value="삭제" onclick="qnaInfoDeleteBtn(event)">
								</div>
							`;
						} else {
							str += `
								<div style="text-align: center">
									<input type="hidden" name="qnaNum" value="\${ res.num }">
									<input type="button" class="writeBtn btnTag" value="수정" onclick="qnaReplyoModifyBtn(event)">
									<input type="button" class="writeBtn btnTag" value="삭제" onclick="qnaInfoDeleteBtn(event)">
								</div>
							`;
						}
					}
					str +=`
							</td>
						</tr>
					`;
					
 					$(tag).after(str);
				}
			});
		}
	
		// 상품 문의 게시물 총 건수 업데이트
		function getQnaCount(){
			$.ajax({
				url: 'getQnaCount.jsp',
				data: { article : '<%=article%>'},
				success:function(res){
					$('#qnaCount').text('Q&A 상품문의 [총 '+res+'건]');
				}
			});
		}
		// 상품 문의 게시글 갱신
		function updateQnaList(){
	        $.ajax({
	        	url: 'getQnaList.jsp',
	        	data: { article : '<%=article%>', qnaStartRow : qnaStartRow, qnaPageSize : qnaPageSize},
	        	success:function(res) {
// 	        		res = $.parseJSON(res);
// 					res = JSON.parse(res);
// 					if (res.isLogin == false) {
// 						return;
// 					}
					
// 					let list = res.qnaList;
					
	        		let str = '';
	        		
	        		str += `
	        			<h4 id="qnaCount">Q&A 상품문의 [총 <%=qnaCount %>건]</h4>
	        			<hr style="border: 0; height: 1px; background: #d2d2d2;">
        				<div>
        					<table>
		        				<tr>
									<th style="width: 80px;">번호</th>
									<th style="width: 90px;">구분</th>
									<th style="width: 350px;">제목</th>
									<th style="width: 120px;">작성자</th>
									<th style="width: 120px;">등록일자</th>					
								</tr>
	        		`;
	        		if(res.length>0){
	        			$.each(res, function(index, item){ 
	        				str+=`
	        					<tr>
		        					<td class="qnaNum" style="text-align: center;">\${ item.num }</td>
									<td style="text-align: center;">\${ item.type }</td>
							`;
							if(item.re_lev > 0){
								str+=`
									<td onclick="qnaTitleClick(event)">
										<i class="fab fa-replyd fa-2x"></i> \${ item.title }
									</td>
								`;
							} else {
								str+=`
									<td onclick="qnaTitleClick(event)">\${ item.title }</td>
								`;
							}
						
							str+=`
									<td class="qnaID" style="text-align: center;">\${ item.id }</td>
									<td style="text-align: center;">\${ item.reg_date }</td>
		        				</tr>
        					`;
        				});
	        		} else {
	        			str+=`
			        			<tr>
									<td colspan="5" style="text-align: center;">등록된 질문이 없습니다.</td>
								</tr>
						`;
	        		}
        			str+=`
        					</table>
        				</div>
        			`;
        			str+=`
        				<div id="qnaPage">
       				`;
            			<%if(!id.equals("")&&(!id.equals("admin"))){ %>
            			str+=`
        					<input type="button" class="float_right btnTag writeBtn" onclick="qnaWriteBtn()" value="글쓰기">
            				`;
            			<%} %>
           			str+=`
        				</div>
       				`;
        			$('#qnaList').empty();
        			$('#qnaList').append(str);
        			getQnaCount();
        			updateQnaPage();
				}
	        });
	    }
		
		// 상품 문의 글쓰기 창 띄우기
		function qnaWriteBtn() {
			window.open('productQnaForm.jsp?article=<%=article%>','.productQna','width=600, height=980');
		}
	
	
		// 초기 별의 갯수 설정
		var starTestCount='0';
		<%for(ReplyVo replyVo1 : replyList){%>
			starTestCount = '<%=replyVo1.getGrade()%>';
			if(starTestCount == '0.5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star0_5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
				
			else if(starTestCount == '1'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star1').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			
			else if(starTestCount == '1.5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star1_5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			else if(starTestCount == '2'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star2').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			
			else if(starTestCount == '2.5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star2_5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			else if(starTestCount == '3'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star3').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			
			else if(starTestCount == '3.5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star3_5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			else if(starTestCount == '4'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star4').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			
			else if(starTestCount == '4.5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star4_5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			else if(starTestCount == '5'){
				$('#reviewInfo<%=replyVo1.getNum()%>').children('.startRadio').children('.star5').children('input[name="star<%=replyVo1.getNum()%>"]').attr("checked",true);
			}
			
		<%}%>
		
		// 업데이트 시 별 갯수 설정 이벤트 
		function updateStar(res) {
			let reId;
			$.each(res, function(index, item){ 
				starTestCount = item.grade;
				reId='#reviewInfo'+item.num;
				if(starTestCount == '0.5'){
					$(reId).children('.startRadio').children('.star0_5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
					
				else if(starTestCount == '1'){
					$(reId).children('.startRadio').children('.star1').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				
				else if(starTestCount == '1.5'){
					$(reId).children('.startRadio').children('.star1_5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				else if(starTestCount == '2'){
					$(reId).children('.startRadio').children('.star2').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				
				else if(starTestCount == '2.5'){
					$(reId).children('.startRadio').children('.star2_5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				else if(starTestCount == '3'){
					$(reId).children('.startRadio').children('.star3').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				
				else if(starTestCount == '3.5'){
					$(reId).children('.startRadio').children('.star3_5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				else if(starTestCount == '4'){
					$(reId).children('.startRadio').children('.star4').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				
				else if(starTestCount == '4.5'){
					$(reId).children('.startRadio').children('.star4_5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
				else if(starTestCount == '5'){
					$(reId).children('.startRadio').children('.star5').children('input[name="star'+item.num+'"]').attr("checked",true);
				}
			});
		}
		
		// 리뷰글 작성시 별 설정 이벤트
		var starCount = 0;
		var updateStarCount = 0;
		$('input[name="star"]').on('click', function () {
			starCount = $(this).parent().children('.startRadio__img').children('.blind').text();
		});
		
		// 리뷰글 수정시 별 설정 이벤트
		function starCountChange(event){
			updateStarCount = event.currentTarget.parentNode.querySelector('.blind').innerHTML;
		}
	
		// 리뷰 수정 폼 표시 이벤트
		function replyUpdate(event){
			let replyNum = event.currentTarget.parentNode.querySelector('input[name="replyNum"]').value;
			let updateStarCnt = event.currentTarget.parentNode.querySelector('input[name="grade"]').value;
			let content = event.currentTarget.parentNode.querySelector('.replyContent').innerHTML;
			
			$('.replyModifyBtn').prop('disabled', true);
			
			content = content.replace(/<br>/gi,'\n');
			
			let img = event.currentTarget.parentNode.querySelector('img').getAttribute('src');
			let updateItem = event.currentTarget.parentNode;
			let imgSplit = img.split("/");
			let imgName = imgSplit[5];
			
			let updateInfoStr = `
				<div>
					<div class="Horizontal">
						<div class="image_container" style="width: 100px; height: 100px;">
							<img src="\${ img }" width="100" height="100">
						</div>
						
						<form enctype="multipart/form-data" name="replyUpdateForm" method="post">
							<input type="hidden" name="replyNum" value="\${ replyNum }">
							<input type="hidden" name="grade" value="0">
							<input type="hidden" name="isDelete" value="N">
							<textarea name="content" style="resize: none; width: 500px; height: 120px;" maxlength="100" placeholder="100자 이내">\${ content }</textarea>
							<br>
							<div class="startRadio" style="padding: 0px;">
			`;
			
			if(updateStarCnt == '0.5'){
			updateInfoStr += `<label class="startRadio__box star0_5">
								<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">0.5</span></span>
							</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star0_5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">0.5</span></span>
							</label>`;
			}
			if(updateStarCnt == '1'){
			updateInfoStr += `<label class="startRadio__box star1">
								<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">1</span></span>
							</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star1">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">1</span></span>
							</label>`;
			}
			if(updateStarCnt == '1.5'){
			updateInfoStr += `<label class="startRadio__box star1_5">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">1.5</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star1_5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">1.5</span></span>
							</label>`;
			}
			if(updateStarCnt == '2'){
			updateInfoStr += `<label class="startRadio__box star2">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">2</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star2">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">2</span></span>
							</label>`;
			}
			if(updateStarCnt == '2.5'){
			updateInfoStr += `<label class="startRadio__box star2_5">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">2.5</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star2_5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">2.5</span></span>
							</label>`;
			}
			if(updateStarCnt == '3'){
			updateInfoStr += `<label class="startRadio__box star3">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">3</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star3">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">3</span></span>
							</label>`;
			}
			if(updateStarCnt == '3.5'){
			updateInfoStr += `<label class="startRadio__box star3_5">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">3.5</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star3_5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">3.5</span></span>
							</label>`;
			}
			if(updateStarCnt == '4'){
			updateInfoStr += `<label class="startRadio__box star4">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">4</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star4">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">4</span></span>
							</label>`;
			}
			if(updateStarCnt == '4.5'){
			updateInfoStr += `<label class="startRadio__box star4_5">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">4.5</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star4_5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">4.5</span></span>
							</label>`;
			}
			if(updateStarCnt == '5'){
			updateInfoStr += `<label class="startRadio__box star5">
									<input type="radio" name="star\${ replyNum }"  checked onchange="starCountChange(event)">
									<span class="startRadio__img"><span class="blind">5</span></span>
								</label>`;
			}else{
			updateInfoStr += `<label class="startRadio__box star5">
								<input type="radio" name="star\${ replyNum }"  onchange="starCountChange(event)">
								<span class="startRadio__img"><span class="blind">5</span></span>
							</label>`;
			}
			updateInfoStr += `</div>
							<div>\${ imgName }<span class="oldImage-delete" onclick="oldImageDelete(event)"><i class="fas fa-trash-alt"></i></span>
							</div>
							<input type="button" class="float_right cancelReviewBtn btnTage" value="취소" onclick="cancelUpdateInfo(event);">
							<input type="button" class="float_right updateReviewBtn btnTage" value="수정" onclick="updateReplyInfo(event);">
						</form>
					</div>
				</div>
			`;
			$(updateItem).before(updateInfoStr);
			$(updateItem).hide();
		}
		
		// 리뷰 수정 취소 이벤트
		function cancelUpdateInfo(event){
			let updateItemNum = event.currentTarget.parentNode.parentNode.parentNode.querySelector('input[name="replyNum"]').value;
			let updateItem = $('#reviewInfo'+updateItemNum);
			let removeItem = event.currentTarget.parentNode.parentNode.parentNode;
			
			$(updateItem).show();
			$(removeItem).remove();
// 			console.log(removeItem);
			
			$('.replyModifyBtn').prop('disabled', false);
		}
		
		// 리뷰 첨부된 이미지 삭제 이벤트
		function oldImageDelete(event) {
// 			console.log(event.currentTarget.parentNode.parentNode.parentNode);
			event.currentTarget.parentNode.parentNode.parentNode.querySelector('img').setAttribute('src','');
			event.currentTarget.parentNode.parentNode.querySelector('input[name="isDelete"]').setAttribute('value', 'Y');
			let deleteTag = event.currentTarget.parentNode;
			let updateNewImgInfo = `
				<div>
					<input type="file" name="newImage1" accept="image/*" onchange="preViewImg(event);">
					<span class="newImageDelete"><i class="fas fa-trash-alt"></i></span>
				</div>
			`;
			$(deleteTag).after(updateNewImgInfo);
			event.target.parentNode.remove();
		}

		// 리뷰 목록 가져오기
		function getReplyListPro(){
			$.ajax({
				url: 'getReplyListPro.jsp',
				data: 'article=<%=article%>&replyStartRow='+replyStartRow+'&replyPageSize='+replyPageSize,
				success:function(res){
					
					$('#reviewBox').empty();
					let replyUpdateStr = `
						<h3>상품 리뷰</h3>
						<hr style="border: 0; height: 1px; background: #d2d2d2;">
					`;
					if(res.length != 0) {
						$.each(res, function(index, item){ 
							replyUpdateStr += `
								<div class="reviewInfoBox" id="reviewInfo\${ item.num }">
							`;
							replyUpdateStr += `
									<div>
										<input type="hidden" name="replyNum" value="\${ item.num }">
										<input type="hidden" name="grade" value="\${ item.grade }">
										<span>작성자 : \${ item.id }</span>
										<span class="float_right">작성 날짜 : \${ item.reg_date }</span>
									</div>
									<div class="Horizontal">
										<div style="width: 100px; height: 100px;">
											<img onerror="this.src='../image/no_img.png'" src="../upload/\${ item.uploadpath }/\${ item.image }" width="100" height="100">
										</div>
										<div class="replyContent">\${ item.content }</div>
									</div>
									<div class="startRadio" style="padding: 0px;">
										<label class="startRadio__box star0_5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">0.5</span></span>
										</label>
										<label class="startRadio__box star1">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">1</span></span>
										</label>
										<label class="startRadio__box star1_5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">1.5</span></span>
										</label>
										<label class="startRadio__box star2">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">2</span></span>
										</label>
										<label class="startRadio__box star2_5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">2.5</span></span>
										</label>
										<label class="startRadio__box star3">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">3</span></span>
										</label>
										<label class="startRadio__box star3_5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">3.5</span></span>
										</label>
										<label class="startRadio__box star4">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">4</span></span>
										</label>
										<label class="startRadio__box star4_5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">4.5</span></span>
										</label>
										<label class="startRadio__box star5">
											<input type="radio" class="star" name="star\${ item.num }" disabled>
											<span class="startRadio__img"><span class="blind">5</span></span>
										</label>
									</div>
									`;
							
							if(item.id =='<%=id%>') {
								replyUpdateStr += `
									<input type="button" class="float_right replyDeleteBtn btnTage" value="삭제" onclick="replyDelete(event)">
									<input type="button" class="float_right replyModifyBtn btnTage" value="수정" onclick="replyUpdate(event)">
								`;
							} else if('<%=id%>'=='admin'){
								replyUpdateStr += `
									<input type="button" class="float_right replyDeleteBtn btnTage" value="삭제" onclick="replyDelete(event)">
								`;								
							}
							replyUpdateStr += `
								</div>
							`;
						});
					} else {
						replyUpdateStr += `
							<div id="noneReply">등록된 리뷰가 없습니다.</div>
						`;
					}
					replyUpdateStr += `
							<div id="replyPage"></div>
					`;
					
					$('#reviewBox').append(replyUpdateStr);
					$('textarea[name="content"]').val('');
					$('#previewImg').attr("src", '');
					$('#image1').val('');
					$("input:radio[name='star']").prop('checked', false); // 해제하기
					updateStar(res);
					updateReplyPage();
					
					$.ajax({
						url: 'getReplyGradeListPro.jsp',
						data: {article : '<%=article%>'},
						success:function(res){
							$('#productGrade').text(res);
						}
					});
				}
			});
		}
		
		// 리뷰 글 업데이트 이벤트
		function updateReplyInfo(event) {
			let replyNum = event.currentTarget.parentNode.querySelector('input[name="replyNum"]').value;
			let replyForm = event.currentTarget.parentNode.parentNode.querySelector('form[name="replyUpdateForm"]');
			replyForm.querySelector('input[name="grade"]').setAttribute('value', updateStarCount);
// 			console.log(updateStarCount);
			$(replyForm).ajaxForm({
				url: 'updateReplyPro.jsp',
				method: "post",
				dataType : "json",
				enctype: 'multipart/form-data',
				success:function(res) {
// 					console.log(res);
					
					getReplyListPro();
				}
			});
			$(replyForm).submit();
			$('.replyModifyBtn').prop('disabled', false);
		}
		
		
		// 리뷰 삭제 이벤트	
		function replyDelete(event){
			let replyNum = event.currentTarget.parentNode.querySelector('input[name="replyNum"]').value;
			let deleteItem = event.currentTarget.parentNode;
// 			console.log(replyNum);
// 			console.log(deleteItem);
			
			let isDelete = confirm('상품 리뷰글을 삭제하시겠습니까?');
			if(isDelete){
				$.ajax({
					url: 'deleteReplyInfoPro.jsp',
					data: 'replyNum='+replyNum,
					success:function(res){
						
						getReplyListPro();
					}
				});
			}
		}
	
		// 리뷰 내용 작성 여부 이벤트
		$('#applyReviewBtn').on('click', function() {
			let content = $('textarea[name="content"]').val();
			let filename = $('input[name="filename"]').val();
			let grade = starCount;
			
			$('form#replyForm').children('input[name="grade"]').val(grade);
// 			console.log($('form#replyForm'));
// 			console.log(starCount);
			if(content.length == 0){
				alert('상품의 리뷰 내용을 입력해주세요!');
				return false;
			}
			let isApply = confirm('상품 리뷰글을 등록하시겠습니까?');
			if(isApply){
				// 리뷰 내용 DB 전송
				$("#replyForm").ajaxForm({
					url: 'addReplyPro.jsp',
					method: "post",
					dataType : "json",
					enctype: 'multipart/form-data',
					success:function(res) {
// 						console.log(res);
						getReplyListPro();
					}
				});
				$('#replyForm').submit();
			}
		});
		
		// 상품 리뷰 작성 이미지 미리보기
		function preViewImg(e) {
			let f = e.target.files[0];
			if(!f.type.match("image*")){
				alert("이미지만 첨부할 수 있습니다.");
				$("image1").val('');
				return false;
			}
			let imgTagInfo = e.target.parentNode.parentNode.parentNode.querySelector('img');
			console.log(imgTagInfo);
			let reader = new FileReader();
			reader.onload = function(e) {
				imgTagInfo.setAttribute('src', e.target.result);
// 				$('#previewImg').attr("src", e.target.result);
			};
			reader.readAsDataURL(f);
		}
		
		// 상품 리뷰 작성 첨부 파일 제거 및 새로 붙이기
		$('#reviewWrite').on('click','span.image-delete', function() {
			$('#previewImg').attr("src", '');
			$('#image1').val('');
		});

	
		//구글 시각화 API를 로딩하는 메소드
		google.charts.load('current', {
			packages : [ 'corechart' ]
		});
		
		google.charts.setOnLoadCallback(function() {

			// 남녀 성별 회원수 ajax 요청하기
			$.ajax({
				url: 'orderAgeRangePerCount.jsp',
				data : 'article=<%=article%>',
				success: function (response) {
					console.log(response);
					
					drawChart1(response);
				}
			});
			
			// 연령대별 회원수 ajax 요청하기
			$.ajax({
				url: 'genderPerCount.jsp',
				data : 'article=<%=article%>',
				success: function (response) {
					console.log(response);
					drawChart2(response);
				}
			});
		});
			
		
		// 파이차트 그리기
		function drawChart1(arr) {
			var dataTable = google.visualization.arrayToDataTable($.parseJSON(arr));
			
			var options = {
					title: '구매 회원 연령대'
			};
			
			var objDiv = document.getElementById('chart1');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(dataTable, options);
		}
		
		function drawChart2(arr) {
			var dataTable = google.visualization.arrayToDataTable($.parseJSON(arr));
			// 옵션객체 준비
			var options = {
					title: '구매 성별별 회원수',
					hAxis: {
						title: '성별별 회원수',
						titleTextStyle: {
							color: 'red'
						}
					}
			};
			// 차트를 그릴 영역인 div 객체를 가져옴 
			var objDiv = document.getElementById('chart2');
			// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
			var chart = new google.visualization.ColumnChart(objDiv);
			// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
			chart.draw(dataTable, options);
		}
		
		var sCount = ['<%=qList.get(numS).getRed() == 0 ? "품절" : qList.get(numS).getRed()%>',
			'<%=qList.get(numS).getOrange() == 0 ? "품절" : qList.get(numS).getOrange()%>',
			'<%=qList.get(numS).getYellow() == 0 ? "품절" : qList.get(numS).getYellow()%>',
			'<%=qList.get(numS).getGreen() == 0 ? "품절" : qList.get(numS).getGreen()%>', 
			'<%=qList.get(numS).getBlue() == 0 ? "품절" : qList.get(numS).getBlue()%>'];

		var mCount = ['<%=qList.get(numM).getRed() == 0 ? "품절" : qList.get(numM).getRed()%>',
			'<%=qList.get(numM).getOrange() == 0 ? "품절" : qList.get(numM).getOrange()%>',
			'<%=qList.get(numM).getYellow() == 0 ? "품절" : qList.get(numM).getYellow()%>',
			'<%=qList.get(numM).getGreen() == 0 ? "품절" : qList.get(numM).getGreen()%>', 
			'<%=qList.get(numM).getBlue() == 0 ? "품절" : qList.get(numM).getBlue()%>'];
		
		var lCount = ['<%=qList.get(numL).getRed() == 0 ? "품절" : qList.get(numL).getRed()%>',
				'<%=qList.get(numL).getOrange() == 0 ? "품절" : qList.get(numL).getOrange()%>',
				'<%=qList.get(numL).getYellow() == 0 ? "품절" : qList.get(numL).getYellow()%>',
				'<%=qList.get(numL).getGreen() == 0 ? "품절" : qList.get(numL).getGreen()%>', 
				'<%=qList.get(numL).getBlue() == 0 ? "품절" : qList.get(numL).getBlue()%>'];
		
		var xlCount = ['<%=qList.get(numXL).getRed() == 0 ? "품절" : qList.get(numXL).getRed()%>',
				'<%=qList.get(numXL).getOrange() == 0 ? "품절" : qList.get(numXL).getOrange()%>',
				'<%=qList.get(numXL).getYellow() == 0 ? "품절" : qList.get(numXL).getYellow()%>',
				'<%=qList.get(numXL).getGreen() == 0 ? "품절" : qList.get(numXL).getGreen()%>', 
				'<%=qList.get(numXL).getBlue() == 0 ? "품절" : qList.get(numXL).getBlue()%>'];
		
		// 사이즈 선택시 색상 선택 갱신
		function itemChange() {
			var color = [ "red", "orange", "yellow", "green", "blue" ];
			var selectItem = $('#size').val();
			
			$('#color').empty();
			
			if(selectItem == 'S') {
				for(var count = -1; count < color.length; count++) {
					if(count==-1){
						var option = $('<option value="none">==색상 선택==</option>');
						$('#color').append(option);
						 continue;
					}
					var option = $('<option value="'+ color[count] +'">'
								+color[count] +'['+ sCount[count]+']'+'</option>');
					$('#color').append(option);
				}	
			} else if(selectItem == 'M') {
				for(var count = -1; count < color.length; count++) {
					if(count==-1){
						var option = $('<option value="none">==색상 선택==</option>');
						$('#color').append(option);
						 continue;
					}
					var option = $('<option value="'+ color[count] +'">'
								+color[count] +'['+ mCount[count]+']'+'</option>');
					$('#color').append(option);
				}	
			} else if(selectItem == 'L') {
				for(var count = -1; count < color.length; count++) {
					if(count==-1){
						var option = $('<option value="none">==색상 선택==</option>');
						$('#color').append(option);
						 continue;
					}
					var option = $('<option value="'+ color[count] +'">'
								+color[count] +'['+ lCount[count]+']'+'</option>');
					$('#color').append(option);
				}	
			} else if(selectItem == 'XL') {
				for(var count = -1; count < color.length; count++) {
					if(count==-1){
						var option = $('<option value="none">==색상 선택==</option>');
						$('#color').append(option);
						 continue;
					}
					var option = $('<option value="'+ color[count] +'">'
								+color[count] +'['+ xlCount[count]+']'+'</option>');
					$('#color').append(option);
				}	
			}
		}
		
		let purchaseIndex = 1; // 선택 제품의 아이템 인덱스
		let purchaseCount = 1; 
		
		// 장바구니 담기 이벤트
		function containItem() {
			<%
			if(id.equals("")){
			%>
				location.href = 'loginForm.jsp';
				return;
			<%
			}
			%>
			var item_exist = $('input[name="purchaseSize1"]').length ? true : false;
			if(!item_exist) {
				alert('선택한 제품이 없습니다.');
				return;
			}

			var isStackItem = confirm("장바구니 담으시겠습니까?");
			if(!isStackItem) {
				alert('취소하셨습니다.');
				return;
			}
			var aJsonArray = new Array();
// 			console.log(purchaseIndex);
			for(var j=1;j<purchaseIndex;j++){
				var items_exist = $('input[name="purchaseSize' + j + '"]').length ? true : false;
// 				console.log(items_exist);
				
				if(items_exist) {
					var stackSize = $('input[name="purchaseSize' + j + '"]').val();
					var stackColor = $('input[name="purchaseColor' + j + '"]').val();
					var stackQuantity = $('input[name="purchaseQuantity' + j + '"]').val();
					
					var stackData = {"id": "<%=id%>", "size": stackSize, "color": stackColor, 
							"quantity": stackQuantity, "article": "<%=article%>"};
					aJsonArray.push(stackData);
				}
			}
			
			var jsonStackData = JSON.stringify(aJsonArray);
			$.ajax({
				url : 'stackBasketPro.jsp',
				type: 'post',
				data: 'jsonStackData=' + jsonStackData,
				success:function(data) {
					console.log('데이터 전송 완료');
					var gotoMyProducts = confirm("장바구니로 이동하시겠습니까?");
					if(gotoMyProducts){
						location.href = 'myProducts.jsp';
					}
				},
			  	error:function(jqXHR, textStatus, errorThrown){
			  		console.log('데이터 전송 에러');
		        }
			});

		}
		
		// 선택된 제품 표시 이벤트
		function selectItem() {
			var selectSize = $('#size').val();
			var selectItem = $('#color').val();
			var selectIndex = $("#color option").index( $("#color option:selected") );
			if(selectSize == 'S') {
				if(sCount[selectIndex-1] == '품절'){
					alert('해당 상품은 품절입니다.');
					return;
				}else if(selectItem == '==색상 선택=='){
					return;
				}
				if(purchaseCount > 5){
					alert('더이상 추가 불가능합니다.');
					return;
				}
				if(purchaseIndex > 1){
					for(var i=1;i<purchaseIndex;i++){
						var item_exist = $('input[name="purchaseColor' + i + '"]').length ? true : false;
						if(item_exist){
							let oldItem = $('input[name="purchaseColor' + i + '"]').val();
							let oldSize = $('input[name="purchaseSize' + i + '"]').val();
							if(oldItem==selectItem&&selectSize==oldSize){
								alert('중복된 상품입니다');
								return;
							}
						}
					}
				}
				let str = `
					<div>
						Size:<input type="text" class="purchaseS" name="purchaseSize\${purchaseIndex}" value="S">
						Color:<input type="text" class="purchaseC" name="purchaseColor\${purchaseIndex}" value="\${selectItem}" readonly>
						Quantity:<input type="number" class="purchaseQ" name="purchaseQuantity\${purchaseIndex}" value="1" min="1" max="\${sCount[selectIndex-1]}">
						<span class="purchase-delete"><i class="fas fa-trash-alt"></i></span>
					</div>
				`; // 뺵틱문법 
				
				$('#purchaseList').append(str);
				
				purchaseCount++;
				purchaseIndex++;
				
			} else if(selectSize == 'M'){
				if(mCount[selectIndex-1] == '품절'){
					alert('해당 상품은 품절입니다.');
					return;
				}else if(selectItem == '==색상 선택=='){
					return;
				}
				if(purchaseCount > 5){
					alert('더이상 추가 불가능합니다.');
					return;
				}
				
				if(purchaseIndex > 1){
					for(var i=1;i<purchaseIndex;i++){
						var item_exist = $('input[name="purchaseColor' + i + '"]').length ? true : false;
						if(item_exist){
							let oldItem = $('input[name="purchaseColor' + i + '"]').val();
							let oldSize = $('input[name="purchaseSize' + i + '"]').val();
							if(oldItem==selectItem&&selectSize==oldSize){
								alert('중복된 상품입니다');
								return;
							}
						}
					}
				}
				let str = `
					<div>
						Size:<input type="text" class="purchaseS" name="purchaseSize\${purchaseIndex}" value="M" readonly>
						Color:<input type="text" class="purchaseC" name="purchaseColor\${purchaseIndex}" value="\${selectItem}" readonly>
						Quantity:<input type="number" class="purchaseQ" name="purchaseQuantity\${purchaseIndex}" value="1" min="1" max="\${mCount[selectIndex-1]}">
						<span class="purchase-delete"><i class="fas fa-trash-alt"></i></span>
					</div>
				`; // 뺵틱문법 
				
				$('#purchaseList').append(str);
				
				purchaseCount++;
				purchaseIndex++;
			} else if(selectSize == 'L'){
				if(lCount[selectIndex-1] == '품절'){
					alert('해당 상품은 품절입니다.');
					return;
				}else if(selectItem == '==색상 선택=='){
					return;
				}
				if(purchaseCount > 5){
					alert('더이상 추가 불가능합니다.');
					return;
				}
				if(purchaseIndex > 1){
					for(var i=1;i<purchaseIndex;i++){
						var item_exist = $('input[name="purchaseColor' + i + '"]').length ? true : false;
						if(item_exist){
							let oldItem = $('input[name="purchaseColor' + i + '"]').val();
							let oldSize = $('input[name="purchaseSize' + i + '"]').val();
							if(oldItem==selectItem&&selectSize==oldSize){
								alert('중복된 상품입니다');
								return;
							}
						}
					}
				}
				let str = `
					<div>
						Size:<input type="text" class="purchaseS" name="purchaseSize\${purchaseIndex}" value="L" readonly>
						Color:<input type="text" class="purchaseC" name="purchaseColor\${purchaseIndex}" value="\${selectItem}" readonly>
						Quantity:<input type="number" class="purchaseQ" name="purchaseQuantity\${purchaseIndex}" value="1" min="1" max="\${lCount[selectIndex-1]}">
						<span class="purchase-delete"><i class="fas fa-trash-alt"></i></span>
					</div>
				`; // 뺵틱문법 
			
				$('#purchaseList').append(str);
			
				purchaseCount++;
				purchaseIndex++;
			} else if(selectSize == 'XL'){
				if(xlCount[selectIndex-1] == '품절'){
					alert('해당 상품은 품절입니다.');
					return;
				}else if(selectItem == '==색상 선택=='){
					return;
				}
				if(purchaseCount > 5){
					alert('더이상 추가 불가능합니다.');
					return;
				}
				if(purchaseIndex > 1){
					for(var i=1;i<purchaseIndex;i++){
						var item_exist = $('input[name="purchaseColor' + i + '"]').length ? true : false;
						if(item_exist){
							let oldItem = $('input[name="purchaseColor' + i + '"]').val();
							let oldSize = $('input[name="purchaseSize' + i + '"]').val();
							if(oldItem==selectItem&&selectSize==oldSize){
								alert('중복된 상품입니다');
								return;
							}
						}
					}
				}
				let str = `
					<div>
						Size:<input type="text" class="purchaseS" name="purchaseSize\${purchaseIndex}" value="XL" readonly>
						Color:<input type="text" class="purchaseC" name="purchaseColor\${purchaseIndex}" value="\${selectItem}" readonly>
						Quantity<input type="number" class="purchaseQ" name="purchaseQuantity\${purchaseIndex}" value="1" min="1" max="\${xlCount[selectIndex-1]}">
						<span class="purchase-delete"><i class="fas fa-trash-alt"></span>
					</div>
				`; // 뺵틱문법 
				
				$('#purchaseList').append(str);
				
				purchaseCount++;
				purchaseIndex++;
			}
		}
		
		// 동적 이벤트 연결 (이벤트 등록을 위임하는 방식)
		$('div#purchaseList').on('click','span.purchase-delete',function(){
			// $(this).parent().remove(); // 자기 부모 삭제
			$(this).closest('div').remove(); // 가장가까운 자기자신포함 삭제/ 자기제외삭제(Empty)
			
			purchaseIndex--;
		});
		
		$('#modifyBtn').on('click', function(){
			var isModify = confirm("게시글을 수정하시겠습니까?");
			if(isModify){
				location.href = 'contentModifyForm.jsp?article=<%=article%>&pageNum=<%=pageNum%>';
			}
		});
		
		$('#deleteBtn').on('click', function() {
			var isDelete = confirm("게시글을 삭제하시겠습니까?");
			if(isDelete){
				location.href = 'contentDeletePro.jsp?article=<%=article%>&pageNum=<%=pageNum%>';
			}
		});
		function purchase() {
			<%
			if(id.equals("")){
			%>
				location.href = 'loginForm.jsp';
				return;
			<%
			}
			%>
			var count = $('.purchaseS').length;
			if(count==0){
				alert('구매하실 상품을 선택해주세요!');
				return;
			}
			let sendDataArr = new Array();
			for(let i=0;i<count;i++) {
				let article = '<%=article%>';
				let size = $('input[name="purchaseSize'+(i+1)+'"]').val();
				let color = $('input[name="purchaseColor'+(i+1)+'"]').val();
				let quantity = $('input[name="purchaseQuantity'+(i+1)+'"]').val();
				
// 				console.log(article);
// 				console.log(size);
// 				console.log(color);
// 				console.log(quantity);
				
				let sendData = {"article": "<%=article%>", "size": size, "color": color, "quantity": quantity};
				sendDataArr.push(sendData);
			}
			var jsonData = JSON.stringify(sendDataArr);
			location.href = 'orderAddressForm.jsp?sendData='+encodeURIComponent(jsonData);
		}
		
	</script>
</body>
</html>



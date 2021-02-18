<%@page import="com.exam.vo.OrderVo"%>
<%@page import="com.exam.dao.OrderDao"%>
<%@page import="com.exam.vo.NoticeVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="com.exam.vo.BasketVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.BasketDao"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}
MemberDao memberDao = MemberDao.getInstance();
MemberVo memberVo = memberDao.getMemberById(id);

BasketDao basketDao = BasketDao.getInstance();
List<BasketVo> basketList = basketDao.getBasketById(id);

NoticeDao noticeDao = NoticeDao.getInstance();
NoticeVo[] noticeVo = new NoticeVo[basketList.size()];

for (int i = 0; i < basketList.size(); i++) {
	noticeVo[i] = noticeDao.getProductByArticle(basketList.get(i).getArticle());
}

OrderDao orderDao = OrderDao.getInstance();
List<OrderVo> orderList = orderDao.getOrderListById(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<style>
div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.app {
	flex-direction: column;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -280px;
}

table, th {
	border: 1px solid #d2d2d2;
}
td {
	padding: 5px;
}

.inline {
	display: inline-block;
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

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

.loginBtn:hover {
	cursor: pointer;
}

.float_right {
	float: right;
}

.btnHover:hover {
	background-color: #d2d2d2;
	cursor: pointer;
}

body {
	background-color: black;
}

#delete-basketItem{
	border: 1px solid #d2d2d2;
}

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" style="background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div>
			<a href="main.jsp"><i class="fas fa-arrow-left"></i></a>
		</div>
		<div style="text-align: center;">
			<h2 style="display: inline-block;">MUSINSA</h2>
			<p style="display: inline-block; font-size: 22px">WUSINSA</p>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div class="top">
			<div>
				<p style="display: inline-block; font-size: 22px; margin: 0px;">My Page</p>
				<span class="float_right btnHover" id="logoutBtn" style="margin-left: 10px;"><i class="fas fa-sign-out-alt fa-2x"></i></span>
				<span class="float_right btnHover" id="memberInfoModify"><i class="fas fa-user-edit fa-2x"></i></span>
			</div>
			<div class="Horizontal">
				<div style="width: 94px; height: 106px; border: solid #d2d2d2 1px; text-align: center;">
					<i class="fas fa-user fa-6x"></i>
				</div>
				<div class="verticality">
					<div>
						<span><%=memberVo.getName() %> 님</span><br>
					</div>
					<div>
						<span>아이디 : <%=memberVo.getId() %></span><br>
						<span>가입일 : <%=memberVo.getReg_date() %></span>
					</div>
				</div>
			</div>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div>
			<div>
				<div>
					주문내역 조회 <span><a href="myOrderInfo.jsp"><i class="fas fa-plus"></i></a></span>
				</div>

				<table id="orderList" style="width: 700px;">
					<tr>
						<th>상품정보</th>
						<th>주문일자</th>
						<th>주문금액(수량)</th>
					</tr>
					<%
				if(orderList.size()>0) {
					for(int i=0;i<orderList.size();i++) {
						NoticeVo vo = noticeDao.getProductByArticle(orderList.get(i).getArticle());
					%>
					<tr id="tr<%=i+1%>">
						<td><%=vo.getProduct() %></td>
						<td><%=orderList.get(i).getOrder_date() %></td>
						<td><%=orderList.get(i).getPrice() %>원 (<%=orderList.get(i).getQuantity() %>)</td>
					</tr>
					<%
					}
				} else {
					%>
					<tr style="text-align: center;">
						<td colspan="3">주문한 상품이 없습니다.</td>
					</tr>	
					<%
				}
					%>
				</table>
			</div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			<div>
				<div>
					장바구니 <span><a href="myProducts.jsp"><i class="fas fa-plus"></i></a></span>
				</div>
				<table id="basketList"  style="width: 700px;">
					<tr>
						<th>상품정보</th>
						<th>상품금액</th>
						<th>수량</th>
						<th>주문금액</th>
						<th>배송 형태/배송비</th>
						<th>주문관리</th>
					</tr>
					<%
				if(basketList.size()>0){
					for(int i=0;i<basketList.size();i++) {
						int price = noticeVo[i].getPrice()-noticeVo[i].getSale();
						int quantity = basketList.get(i).getQuantity();
						String delivery = noticeVo[i].getWeekend() == "Y" ? "주말/공휴일 가능" : "주말/공휴일 제외";
					%>
					<tr id="tr<%=i+1%>">
						<td><%=noticeVo[i].getProduct()%></td>
						<td><%=price %>원</td>
						<td><%=quantity %></td>
						<td><%=price*quantity%>원</td>
						<td><%=delivery %></td>
						<td><span class="btnHover" id="delete-basketItem">삭제하기</span></td>
					</tr>
					<%
					}
				} else {
					%>
					<tr style="text-align: center;">
						<td colspan="6">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
					<%
				}
					%>
				</table>
				<div style="text-align: center;">
					<button class="btnHover" id="orderBtn" style="width:290px; height: 50px; margin-bottom: 10px; background-color: black; color: white; font-size: 20px; margin-top: 10px;">결제하기
					</button>
				</div>
			</div>
		</div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script>
		// 회원 정보 수정 화면으로 이동 이벤트
		$('#memberInfoModify').on('click', function() {
			var isModify = confirm("회원 수정 화면으로 이동하시겠습니까?");
			if(isModify) {
				location.href = 'updateUserInfoForm.jsp';
			}
		});
		
		// 결제 화면으로 이동 이벤트
		$('#orderBtn').on('click', function() {
			let basketListCount = '<%=basketList.size()%>';
			if(basketListCount==0){
				alert('장바구니에 담긴 상품이 없습니다.');
				return false;
			}
			var isOrder = confirm("구매 화면으로 이동하시겠습니까?");
			if(isOrder) {
				location.href = 'orderAddressForm.jsp';
			}
		});
		
		$('#logoutBtn').click(function() {
			var isLogout = confirm("로그아웃하시겠습니까?");
			if(isLogout) {
				location.href = 'logout.jsp';
			}
		});
	</script>
</body>
</html>
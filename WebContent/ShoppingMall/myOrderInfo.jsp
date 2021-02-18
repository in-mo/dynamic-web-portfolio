<%@page import="com.exam.vo.OrderVo"%>
<%@page import="com.exam.dao.OrderDao"%>
<%@page import="com.exam.dao.AttachDao"%>
<%@page import="com.exam.vo.AttachVo"%>
<%@page import="com.exam.dao.QuantityDao"%>
<%@page import="com.exam.vo.NoticeVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="com.exam.vo.BasketVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.BasketDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}
NoticeDao noticeDao = NoticeDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();
OrderDao orderDao = OrderDao.getInstance();
List<OrderVo> orderList = orderDao.getOrderListById(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매내역</title>

<style>
div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.app {
	width: 945px;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -500px;
}

table, th {
	border: 1px solid #d2d2d2;
}

.Horizontal {
	display: inline-flex;
	flex-direction: row;
}

#explain th {
	width: 100px;
}

#explain td {
	width: 800px;
}

td {
	padding: 5px;
}

.productInfo{
	width: 350px;
}
body {
	background-color: black;
}

.delete-orderItem:hover{
	cursor: pointer;
	background-color: #d2d2d2;
}
.delete-orderItem{
	border: 1px solid #d2d2d2;
}

a { 
	text-decoration:none 
} 

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

.loginBtn:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="app" style="background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div>
			<span><a href="main.jsp">Main</a></span> > <span><a href="myPage.jsp">MyPage</a></span> > <span>주문내역</span>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<h4>상품 목록</h4>
		<div>
			<table id="orderTable" style="width: 920px;">
				<tr>
					<th>상품명(옵션)</th>
					<th>주문일자</th>
					<th>주문번호</th>
					<th>주문금액(수량)</th>
					<th>출고일자</th>
					<th>주문관리</th>
				</tr>

				<%
				if(orderList.size()>0){
					for (int i = 0; i < orderList.size(); i++) {
						NoticeVo noticeVo = noticeDao.getProductByArticle(orderList.get(i).getArticle());
				%>
				<tr id="tr<%=i+1%>" class="basketTr">
					<td class="productInfo" id="productInfo<%=i+1%>">
					<div class="Horizontal">
						<div>
							<%List<AttachVo> imageList = attachDao.getAttachesByArticle(orderList.get(i).getArticle()); %>
							<img src="../upload/<%=imageList.get(0).getUploadpath()%>/<%=imageList.get(0).getImage()%>"
								width="70">
						</div>
						<div>
							<span><%=noticeVo.getBrand() %></span><br><span><%=noticeVo.getProduct()%></span><br>
								색상:<span class="color" id="color<%=i+1%>"><%=orderList.get(i).getColor()%></span><br>
								크기:<span class="size" id="size<%=i+1 %>"><%=orderList.get(i).getSize()%></span>
								<input type="hidden" class="order_num" id="order_num<%=i+1 %>" value="<%=orderList.get(i).getOrder_num()%>">
							</div>
						</div>
					</td>
					<td class="orderDate" id="orderDate<%=i+1%>"><%=orderList.get(i).getOrder_date() %></td>
					<td class="orderNum" id="orderNum<%=i+1%>"><span><%=orderList.get(i).getOrder_num()%></span></td>
					<td class="priceNquantity"><span><%=orderList.get(i).getPrice()-noticeVo.getSale()*orderList.get(i).getQuantity()+"원 ("+ orderList.get(i).getQuantity()+")"%></span></td>
					<td class="expectDate" id="expectDate<%=i+1%>"><%=orderList.get(i).getExpect_date()%></td>
					<td><span class="delete-orderItem">주문취소</span></td>
				</tr>
				<%
					}
				} else {
				%>
				<tr style="text-align: center;">
					<td colspan="6">주문한 상품이 없습니다.</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div id="explain">
			<h4>주문 상태 설명</h4>
			<table>
				<tr>
					<th>주문 접수</th>
					<td>가상 계좌 주문이 완료되었습니다. 안내된 가상 계좌 번호로 입금이 가능합니다.</td>
				</tr>
				<tr>
					<th>입금 확인</th>
					<td>주문하신 상품의 결제가 완료되었습니다. 판매자가 주문을 확인하기 전 상태로, 옵션 교환 또는 주문 취소가 가능합니다.</td>
				</tr>
				
				<tr>
					<th>출고 처리 중</th>
					<td>주문하신 상품을 택배 업체로 전달할 수 있게 준비(포장) 중입니다. 옵션 변경 또는 주문 취소가 불가능합니다.</td>
				</tr>
				
				<tr>
					<th>출고 완료</th>
					<td>상품을 배송하기 위한 준비(포장)가 완료되어 출고지에서 택배 업체로 전달되었습니다.</td>
				</tr>
				
				<tr>
					<th>배송 시작</th>
					<td>택배 업체가 출고지로부터 전달받은 상품을 고객님의 배송지 주소로 안전하게 배송 중입니다.</td>
				</tr>
				
				<tr>
					<th>배송 완료</th>
					<td>주문하신 상품이 배송지 주소에 잘 도착했습니다.</td>
				</tr>
				
				<tr>
					<th>구매 확정</th>
					<td>상품을 정상적으로 수령하여 구매를 확정했습니다. 구매 확정을 하지 않으시더라도 출고 완료 후 9일이 지나면 자동으로 확정됩니다. 구매 확정 시 교환 또는 환불 요청이 불가능합니다.</td>
				</tr>
				
				<tr>
					<th>주문 취소</th>
					<td>가상 계좌 주문이 입금 전 취소되었습니다. 주문 접수 후 2일 내에 입금하지 않으시면 자동으로 취소됩니다.</td>
				</tr>
				
				<tr>
					<th>결제 오류</th>
					<td>카드 한도 초과, 계좌 잔액 부족 등의 사유로 결제 진행 중 취소되었습니다.</td>
				</tr>
			</table>
			
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			
			<h4>교환 상태 설명</h4>
			<table>
				<tr>
					<th>교환 요청</th>
					<td>상품 교환 신청이 접수되었으며 직접 택배 업체를 통해 상품을 보내주셔야 합니다. 이미 보내신 경우 반품 주소지에서 아직 검수가 완료되지 않은 상태입니다. 검수는 배송 완료 후 영업일 기준 2~3일 정도 소요됩니다.</td>
				</tr>
				<tr>
					<th>교환 완료</th>
					<td>보내주신 교환 요청 상품의 검수가 정상적으로 완료되었습니다. 교환 상품의 주문 상태가 출고 처리 중으로 변경될 수 있습니다.</td>
				</tr>
				
				<tr>
					<th>교환 주문</th>
					<td>접수상품 교환 신청 접수가 완료되었습니다. 교환 재고는 확정된 것이 아니기에 수시로 변동되는 재고로 인한 품절 등의 사유로 발송이 어려울 수 있습니다.</td>
				</tr>
				
				<tr>
					<th>교환 취소</th>
					<td>상품 교환 신청이 취소되었습니다.</td>
				</tr>
				
			</table>
			
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			
			<h4>환불 상태 설명</h4>
			<table>
				<tr>
					<th>환불 요청</th>
					<td>환불 요청상품 환불 신청이 접수되었으며 직접 택배 업체를 통해 상품을 보내주셔야 합니다. 이미 보내신 경우 반품 주소지에서 아직 검수가 완료되지 않은 상태입니다. 검수는 배송 완료 후 영업일 기준 2~3일 정도 소요됩니다.</td>
				</tr>
				<tr>
					<th>환불 처리</th>
					<td>중보내주신 환불 요청 상품의 검수가 정상적으로 완료되어 환불이 진행 중입니다.</td>
				</tr>
				
				<tr>
					<th>환불 완료</th>
					<td>환불 요청이 승인되었습니다. 결제 방법에 따라 영업일 기준 1~3일 이내 결제 취소 또는 계좌로 입금됩니다.</td>
				</tr>
			</table>
		</div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script>
	
	// 주문 취소 버튼 이벤트
	$('span.delete-orderItem').on('click', function() {
		var aJsonArray = new Array();
		var thisItem = $(this).parent().parent();
		var tagId = $(this).parent().parent().attr('id');
		var num = tagId.charAt(tagId.length-1);
		var order_num = $('#order_num'+num).val();
		
		console.log(order_num);
		$.ajax({
			url : 'deleteOrderItemPro.jsp',
			type : 'post',
			data: 'order_num=' + order_num,
			success:function(data1) {
				console.log('데이터 전송 완료');
				console.log(data1);
				$(thisItem).remove();
			},
		  	error:function(jqXHR, textStatus, errorThrown){
		  		console.log('데이터 전송 에러');
	        }
		});
	});
		
	</script>
</body>
</html>
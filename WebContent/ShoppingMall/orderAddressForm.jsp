<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.vo.AttachVo"%>
<%@page import="com.exam.dao.AttachDao"%>
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

String sendData = request.getParameter("sendData");
// System.out.println(sendData);

JsonParser jsonParser = null;
JsonArray jsonArray = null;

List<BasketVo> basketList =null;
NoticeVo[] noticeVo = null;

MemberDao memberDao = MemberDao.getInstance();
BasketDao basketDao = BasketDao.getInstance();
NoticeDao noticeDao = NoticeDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();

ArrayList<NoticeVo> productList = new ArrayList<>();
ArrayList<Integer> basketNumList = null;

MemberVo memberVo = memberDao.getMemberById(id);
int total = 0;
int saleCost = 0;

int directTotal = 0;
int directSaleCoust = 0;

if(sendData != null){ // 바로구매
	jsonParser = new JsonParser();
	jsonArray = (JsonArray) jsonParser.parse(sendData);
	for(int i=0;i<jsonArray.size();i++) {
		JsonObject object = (JsonObject) jsonArray.get(i);
		NoticeVo vo = noticeDao.getProductByArticle(object.get("article").getAsString());
		productList.add(vo);
	}
} else if(sendData == null){ // 장바구니 구매
	basketNumList = new ArrayList<>();
	basketList = basketDao.getBasketById(id);
	noticeVo = new NoticeVo[basketList.size()];
	for (int i = 0; i < basketList.size(); i++) {
		noticeVo[i] = noticeDao.getProductByArticle(basketList.get(i).getArticle());
		basketNumList.add(basketList.get(i).getNum());
		productList.add(noticeVo[i]);
	}
	 
	 for (int i = 0; i < noticeVo.length; i++) {
		total += noticeVo[i].getPrice() * basketList.get(i).getQuantity();
		saleCost += noticeVo[i].getSale() * basketList.get(i).getQuantity();
		}
}
session.setAttribute("basketNumList", basketNumList);
session.setAttribute("productList", productList);
// System.out.println(productList);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서</title>
<style>
div {
	padding: 10px;
}

.app {
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -500px;
	background-color:white; border: 1px solid #d2d2d2; padding: 20px;
}

table, th {
	border: 1px solid #d2d2d2;
	padding: 5px;
}
td {
	padding: 5px;
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
body {
	background-color: black;
}
.btnTag:hover{
	cursor: pointer;
}
.btnTag{
	width:360px; height: 50px; margin-top: 10px; margin-bottom:20px; background-color: black; color: white; font-size: 20px;
}

.inputTag {
	width:300px; height: 30px; margin-bottom: 10px;"
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app">
		<div>
			<span><a href="main.jsp">Main</a></span> > <span>주문서</span>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">	
		<div>Order / Payment</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">	
		<h3>Recipient Info</h3>
		<div>
			<table>
				<tr>
					<td>수령인</td>
					<td><input type="text" class="inputTag" name="name" placeholder="수령인 입력" value="<%=memberVo.getName()%>"></td>
				</tr>
			
				<tr>
					<td>휴대전화</td>
					<td>
						<input type="tel" name="tel" class="inputTag" placeholder="전화번호 입력" value="<%=memberVo.getTel()%>" required>
					</td>
				</tr>
				
				<tr>
					<td>Email</td>
					<td>
						<input type="email" name="email" class="inputTag" placeholder="이메일 입력" value="<%=memberVo.getEmail()%>" required>
					</td>
				</tr>
				
				<tr>
					<td>배송지 주소</td>
					<td><input type="text" class="inputTag" id="postcode" name="postcode" value="<%=memberVo.getPostcode() %>" placeholder="우편번호" readonly>
						<button type="button" onclick="openDaumZipAddress();"><i class="fas fa-map-marked-alt fa-2x"></i></button><br>
						<input type="text" class="inputTag" id="address1" name="address1" readonly value="<%=memberVo.getAddress1()%>" readonly><br>
						<input type="text" class="inputTag" id="address2" name="address2" required value="<%=memberVo.getAddress2()%>" >
					</td>
				</tr>
				
				<tr>
					<td>배송 메모</td>
					<td>
						<select class="inputTag" id="memo" name="memo">
							<option value="none">배송 시 요청사항을 선택해주세요</option>
							<option value="case1">부재 시 경비실에 맡겨주세요</option>
							<option value="case2">부재 시 택배함에 넣어주세요</option>
							<option value="case3">부재 시 집앞에 놔주세요</option>
							<option value="case4">파손의 위험이 있는 상품입니다. 배송시 주의해주세요</option>
						</select>
					</td>
				</tr>
				
			</table>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">	
		<div>
			<h3>Product Info</h3>
			<div>
				<table id="basketTable" style="width: 800px;">
					<tr>
						<th>상품정보</th>
						<th>수량</th>
						<th>상품 할인</th>
						<th>주문금액</th>
					</tr>
					
				</table>
			</div>
			<div style="padding: 0px">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			</div>	
			<div>
				※구매 가능 수량이 1개로 제한된 상품은 주문 취소 시, 24시간 내 가상계좌 재주문이 불가합니다.<br>
			※무신사는 기본적으로 전 상품 무료 배송입니다.<br> ※해외배송 상품으 배송료가 추가로 발생될 수 있습니다.<br>
			※2개 이상 브랜드를 주문하신 경우, 각각 개별 배송됩니다.<br> ※장바구니에 담은 시점과 현재의 판매 가격이
			달라질 수 있습니다.<br> ※결제 시 각종 할인 적용이 달라질 수 있습니다.<br> ※수량 제한 상품의
			경우, 가상계좌를 통한 주문은 최대 2건까지만 가능합니다.(미입금 주문기준, 기존 주문 합산)
			</div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			<h3>Payment Info</h3>
			<div id="paymentInfo">
			</div>
		</div>
		
		<div style="text-align: center;">
			<button class="btnTag" id="orderBtn">주문하기</button>
		</div>
	</div>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../js/jquery-3.5.1.js"></script>
	
	<script>
	var sendArray = new Array();
	<%
	if(sendData == null){
		for(int i=0;i<basketList.size();i++) {
		%>
		str =`
		<tr id="tr<%=i+1 %>">
			<td>
				<div class="Horizontal">
					<div>
						<%List<AttachVo> imageList = attachDao.getAttachesByArticle(basketList.get(i).getArticle()); %>
						<img src="../upload/<%=imageList.get(0).getUploadpath()%>/<%=imageList.get(0).getImage()%>"
							width="50">
					</div>
					<div class="basketInfo">
						<span><%=noticeVo[i].getBrand() %></span><br>
						<span><%=noticeVo[i].getProduct() %></span><br>
						<span>옵션 : <%=basketList.get(i).getSize() %> / <%=basketList.get(i).getColor() %></span>
					</div>
				</div>
			</td>
			
			<td><span id="quantity<%=i+1%>"><%=basketList.get(i).getQuantity()%></span></td>
			<td><span id="Sale<%=i+1%>"><%=noticeVo[i].getSale() %>원</span></td>
			<td><span id="price<%=i+1%>"><%=noticeVo[i].getPrice() * basketList.get(i).getQuantity()%>원</span></td>
			`;
			$('#basketTable').append(str);
			data = {"size": "<%=basketList.get(i).getSize() %>", "color": "<%=basketList.get(i).getColor() %>", "quantity": <%=basketList.get(i).getQuantity()%>};
			sendArray.push(data);
		<%	
		}%>
		str = `
			<table>
				<tr>
					<td>상품 금액</td>
					<td><%=total %>원</td>
				</tr>
				
				<tr>
					<td>할인 합계</td>
					<td><%=saleCost %>원</td>
				</tr>
				
				<tr>
					<td>최종 결제 금액</td>
					<td><%=total - saleCost %>원</td>
				</tr>
			</table>
			`;
			$('#paymentInfo').append(str);
		<%
	}else if(sendData!=null){
		if(jsonArray!=null){
			for(int i=0;i<jsonArray.size();i++) {
				JsonObject object = (JsonObject) jsonArray.get(i);
				NoticeVo vo = noticeDao.getProductByArticle(object.get("article").getAsString());
				%>
				str =`
					<tr id="tr<%=i+1 %>">
						<td>
							<div class="Horizontal">
								<div>
									<%List<AttachVo> imageList = attachDao.getAttachesByArticle(object.get("article").getAsString()); %>
									<img src="../upload/<%=imageList.get(0).getUploadpath()%>/<%=imageList.get(0).getImage()%>"
										width="50">
								</div>
								<div class="basketInfo">
									<span><%=vo.getBrand() %></span>
									<span><%=vo.getProduct() %></span><br>
									<span>옵션 : <%=object.get("size").getAsString() %> / <%=object.get("color").getAsString() %></span>
								</div>
							</div>
						</td>
						
						<td><span id="quantity<%=i+1%>"><%=object.get("quantity").getAsInt()%></span></td>
						<td><span id="Sale<%=i+1%>"><%=vo.getSale() %>원</span></td>
						<td><span id="price<%=i+1%>"><%=vo.getPrice() * object.get("quantity").getAsInt()%>원</span></td>
						`;
						$('#basketTable').append(str);
						data = {"size": "<%=object.get("size").getAsString() %>", "color": "<%=object.get("color").getAsString() %>", "quantity": <%=object.get("quantity").getAsInt()%>};
						sendArray.push(data);
				<%
			}
			
			for(int i=0;i<jsonArray.size();i++) {
				JsonObject object = (JsonObject) jsonArray.get(i);
				NoticeVo vo = noticeDao.getProductByArticle(object.get("article").getAsString());
				directTotal += vo.getPrice()*object.get("quantity").getAsInt();
				directSaleCoust += vo.getSale()*object.get("quantity").getAsInt();
			}
			%>
			str = `
				<table>
					<tr>
						<td>상품 금액</td>
						<td><%=directTotal %>원</td>
					</tr>
					
					<tr>
						<td>할인 합계</td>
						<td><%=directSaleCoust %>원</td>
					</tr>
					
					<tr>
						<td>결제 금액</td>
						<td><%=directTotal - directSaleCoust %>원</td>
					</tr>
				</table>
				`;
				$('#paymentInfo').append(str);
		<%
		}
	}
	%>
	function openDaumZipAddress() {
		new daum.Postcode({
			oncomplete: function(data) {
				$("#postcode").val(data.zonecode);			
				$("#address1").val(data.address);
				$("#address2").focus();
				console.log(data);
			}	
		}).open();
	}
	
	$('#orderBtn').on('click', function() {
		if($("#memo option:checked").val()=='none'){
			alert('배송 시 요청사항을 선택해주세요.');
			return;
		}
		
		var isOrder = confirm("결제창으로 이동하시겠습니까?");
		if(!isOrder) {
			alert('취소하셨습니다.');
			return;
		}
		var name = $('input[name="name"]').val();
		var tel = $('input[name="tel"]').val();
		var postcode = $('input[name=postcode]').val()
		var address = $('input[name="address1"]').val() +' '+ $('input[name="address2"]').val();
		var email = $('input[name="email"]').val();
		var memo = $("#memo option:checked").text();
		var totalPrice = '<%=sendData == null ? (total - saleCost) : (directTotal - directSaleCoust)%>';
		var jsonData = JSON.stringify(sendArray);
		location.href = 'paymentForm.jsp?jsonData='+encodeURIComponent(jsonData)+'&totalPrice='+totalPrice+'&name='+name+'&tel='+tel+'&postcode='+postcode+'&address='+address+'&memo='+memo+'&email='+email;
	});
	</script>
</body>
</html>
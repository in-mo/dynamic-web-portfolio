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

	BasketDao basketDao = BasketDao.getInstance();
List<BasketVo> basketList = basketDao.getBasketById(id);

QuantityDao quantityDao = QuantityDao.getInstance();
int[] colorCount = new int[basketList.size()];

NoticeDao noticeDao = NoticeDao.getInstance();
NoticeVo[] noticeVo = new NoticeVo[basketList.size()];
for (int i = 0; i < basketList.size(); i++) {
	noticeVo[i] = noticeDao.getProductByArticle(basketList.get(i).getArticle());
	colorCount[i] = quantityDao.getQuantityByProductInfo(basketList.get(i).getArticle(), 
			basketList.get(i).getSize(), basketList.get(i).getColor());
}

AttachDao attachDao = AttachDao.getInstance();

int total = 0;
int saleCost = 0;
for (int i = 0; i < noticeVo.length; i++) {
	total += noticeVo[i].getPrice() * basketList.get(i).getQuantity();
	saleCost += noticeVo[i].getSale() * basketList.get(i).getQuantity();
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<style>
div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.app {
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -500px;
}

table, th {
	border: 1px solid #d2d2d2;
}
td {
	padding: 2px;
}

.Horizontal {
	display: inline-flex;
	flex-direction: row;
}
body {
	background-color: black;
}

a { 
	text-decoration:none 
} 

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

.delete-basketItem {
	border: 1px solid #d2d2d2;
}
.delete-basketItem:hover {
	cursor: pointer;
	background-color: #d2d2d2;
}
.btnTag:hover{
	cursor: pointer;
}

.modifyBtn:hover{
	cursor: pointer;
}

.btnTag{
	width:360px; height: 50px; margin-top: 10px; margin-bottom:20px; background-color: black; color: white; font-size: 20px;
}

.inputTag {
	width:300px; height: 30px; margin-bottom: 10px;"
}
.addressTag {
	width:200px; height: 30px; margin-bottom: 10px;"
}

.textCenter {
	text-align: center;
}
</style>
</head>
<body>
	<div class="app" style="background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div>
			<span><a href="main.jsp">Main</a></span> > <span><a href="myPage.jsp">MyPage</a></span> > <span>장바구니</span>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">		
		<h4>상품 목록</h4>
		<div>
			<table id="basketTable" style="width: 1300px;">
				<tr>
					<th>번호</th>
					<th><input type="checkbox" id="allCheck"></th>
					<th>상품명(옵션)</th>
					<th>판매가</th>
					<th>할인가</th>
					<th>수량</th>
					<th>주문금액</th>
					<th>주문관리</th>
					<th>배송비/배송 형태</th>
				</tr>

				<%
				if(basketList.size()>0) {
					for (int i = 0; i < basketList.size(); i++) {
				%>
				<tr id="tr<%=i+1%>" class="basketTr">
					<td class="textCenter"><%=i + 1%></td>
					<td class="productCheck textCenter"><input type="checkbox" id="productCheck<%=i + 1%>"></td>
					<td class="productInfo" id="productInfo<%=i+1%>">
						<div class="Horizontal">
							<div>
								<%List<AttachVo> imageList = attachDao.getAttachesByArticle(basketList.get(i).getArticle()); %>
								<img src="../upload/<%=imageList.get(0).getUploadpath()%>/<%=imageList.get(0).getImage()%>"
									width="70">
							</div>
						<div>
							<span><%=noticeVo[i].getBrand() %></span><br><span><%=noticeVo[i].getProduct()%></span><br>
								색상:<span class="color" id="color<%=i+1%>"><%=basketList.get(i).getColor()%></span><br>
								크기:<span class="size" id="size<%=i+1 %>"><%=basketList.get(i).getSize()%></span>
								<input type="hidden" class="article" id="article<%=i+1 %>" value="<%=noticeVo[i].getArticle()%>">
							</div>
						</div>
					</td>
					<td class="price textCenter" id="price<%=i+1%>"><span><%=noticeVo[i].getPrice()%>원</span></td>
					<td class="sale textCenter" id="sale<%=i+1%>"><span><%=noticeVo[i].getSale()%>원</span></td>
					<td class="quantity textCenter"><input type="number" class="quantityNum" id="quantityNum<%=i+1 %>" name="quantityNum<%=i+1 %>" min="1" max="<%=colorCount[i]%>"
						value="<%=basketList.get(i).getQuantity()%>">
						<input type="button" class="modifyBtn" id="modifyBtn<%=i+1%>" name="modifyBtn<%=i+1%>" value="수정" onclick="modifyQuantity(this);">
					</td>
					<td class="orderPrice textCenter" id="orderPrice<%=i+1%>"><%=(noticeVo[i].getPrice() - noticeVo[i].getSale()) * basketList.get(i).getQuantity()%>원</td>
					<td class="textCenter"><span class="delete-basketItem">삭제하기</span></td>
					<td class="textCenter"><%=noticeVo[i].getDelivery()%> <%
 					if (noticeVo[i].getWeekend().equals("N")) {
					 %> ㆍ주말/공휴일 제외 <%
					 } else {%>
						ㆍ주말/공휴일 가능 <%
					 }%></td>
				</tr>
				<%
					}
				} else {
				%>
				<tr style="text-align: center;">
					<td colspan="9">장바구니에 담은 상품이 없습니다.</td>
				</tr>
				<%
				}
				 %>
			</table>
		</div>
		<div style="text-align: center;">
			<button class="btnTag" id="selectDelete">선택삭제</button>
		</div>
		<div class="orderResult">
			<table class="resultTable">
				<tr class="resultDiscount">
					<td>상품 할인</td>
					<td class="productsDiscount"><%=saleCost%>원</td>
				</tr>

				<tr class="resultCost">
					<td>총상품 금액</td>
					<td class="productCost"><%=total%>원</td>
				</tr>

				<tr class="resultTotal">
					<td>최종 결제 금액</td>
					<td class="totalCost"><%=total - saleCost%>원</td>
				</tr>
			</table>
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div>
			※구매 가능 수량이 1개로 제한된 상품은 주문 취소 시, 24시간 내 가상계좌 재주문이 불가합니다.<br>
			※무신사는 기본적으로 전 상품 무료 배송입니다.<br> ※해외배송 상품으 배송료가 추가로 발생될 수 있습니다.<br>
			※2개 이상 브랜드를 주문하신 경우, 각각 개별 배송됩니다.<br> ※장바구니에 담은 시점과 현재의 판매 가격이
			달라질 수 있습니다.<br> ※결제 시 각종 할인 적용이 달라질 수 있습니다.<br> ※수량 제한 상품의
			경우, 가상계좌를 통한 주문은 최대 2건까지만 가능합니다.(미입금 주문기준, 기존 주문 합산)
		</div>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div style="text-align: center;">
			<button class="btnTag" id="orderBtn">주문하기</button>
		</div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script>
	
	// 개별 수정 버튼 이벤트
	function modifyQuantity(data) {
		var tagName = $(data).attr('name');
		var num = tagName.charAt(tagName.length-1);
	
		
		var size = $('#size'+num).text();
		var color = $('#color'+num).text();
		var quantity = $('#quantityNum'+num).val();
		var article = $('#article'+num).val();

		var modifyData = {"id": "<%=id%>", "size": size, "color": color, 
				"quantity": quantity, "article": article};
		var jsonModifyData = JSON.stringify(modifyData);
		
			$.ajax({
				url : 'basketUpdatePro.jsp',
				type : 'post',
				data: 'jsonModifyData=' + jsonModifyData,
				success:function(data1) {
					console.log('데이터 전송 완료');
					var price = $('#price'+num).text();
					var sale = $('#sale'+num).text();
					$('#orderPrice'+num).text((price-sale)*quantity);
					
					var priceCost = 0;
					var productDiscount = 0;
					
					for(var i=0;i<$('.price').children().length;i++){
						priceCost += $('.price').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
						productDiscount += $('.sale').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
					}
					
					$('.productCost').text(priceCost+'원');
					$('.productsDiscount').text(productDiscount+'원');
					$('.totalCost').text((priceCost-productDiscount)+'원');
					
				},
			  	error:function(jqXHR, textStatus, errorThrown){
			  		console.log('데이터 전송 에러');
		        }
			});
		}
	
		// 개별 삭제 버튼 이벤트
		$('span.delete-basketItem').on('click', function() {
			var aJsonArray = new Array();
			var thisItem = $(this).parent().parent();
			var tagId = $(this).parent().parent().attr('id');
			var num = tagId.charAt(tagId.length-1);
		
			var size = $('#size'+num).text();
			var color = $('#color'+num).text();
			var quantity = $('#quantityNum'+num).val();
			var article = $('#article'+num).val();
			
			var deleteData = {"id": "<%=id%>", "size": size, "color": color, 
					"quantity": quantity, "article": article};
			aJsonArray.push(deleteData);
			var jsonDeleteData = JSON.stringify(aJsonArray);
			
			$.ajax({
				url : 'deleteBasketPro.jsp',
				type : 'post',
				data: 'jsonDeleteData=' + jsonDeleteData,
				success:function(data1) {
					console.log('데이터 전송 완료');
					$(thisItem).remove();
					
					var priceCost = 0;
					var productDiscount = 0;
					
					for(var i=0;i<$('.price').children().length;i++){
						priceCost += $('.price').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
						productDiscount += $('.sale').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
					}
					
					$('.productCost').text(priceCost+'원');
					$('.productsDiscount').text(productDiscount+'원');
					$('.totalCost').text((priceCost-productDiscount)+'원');
				},
			  	error:function(jqXHR, textStatus, errorThrown){
			  		console.log('데이터 전송 에러');
		        }
			});
		});
	
		// 전체 선택 체크 박스
		$('#allCheck').change(function() {
			if ($(this).is(":checked") == true) {
			 	for(var i=0;i<$('.productCheck').children().length;i++){
			 		$('.productCheck').children().prop("checked", true);
			 	}
				
			}else {
				for(var i=0;i<$('.productCheck').children().length;i++){
			 		$('.productCheck').children().prop("checked", false);
			 	}
			}
		});
		
		// 체크박스에 선택된 것들만 삭제 이벤트
		$('#selectDelete').on('click', function() {
			
			var arrItem = new Array();
			var count = 0;
			var aJsonArray = new Array();
			for(var i=0;i<$('.productCheck').children().length;i++){
		 		if($('.productCheck').children().eq(i).is(":checked")){
		 			var thisItem = $('.productCheck').children().eq(i).parent().parent();
					var tagId = $(thisItem).attr('id');
					var num = tagId.charAt(tagId.length-1);
					
					arrItem[count] = $(thisItem);
					count++;
					console.log('i : '+i);
					
		 			var size = $('#size'+num).text();
					var color = $('#color'+num).text();
					var quantity = $('#quantityNum'+num).val();
					var article = $('#article'+num).val();
					
					var deleteData = {"id": "<%=id%>", "size": size, "color": color, 
							"quantity": quantity, "article": article};
					aJsonArray.push(deleteData);
		 		}
			}
			
			var jsonDeleteData = JSON.stringify(aJsonArray);
			
			$.ajax({
				url : 'deleteBasketPro.jsp',
				type : 'post',
				data: 'jsonDeleteData=' + jsonDeleteData,
				success:function(data1) {
					console.log('데이터 전송 완료');
					
					for(var i=0;i<arrItem.length;i++){
						$(arrItem[i]).remove();
					}
					var priceCost = 0;
					var productDiscount = 0;
					
					for(var i=0;i<$('.price').children().length;i++){
						priceCost += $('.price').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
						productDiscount += $('.sale').children().eq(i).text()*$('.quantity').children().eq(i*2).val();
					}
					
					$('.productCost').text(priceCost+'원');
					$('.productsDiscount').text(productDiscount+'원');
					$('.totalCost').text((priceCost-productDiscount)+'원');
					
				},
			  		error:function(jqXHR, textStatus, errorThrown){
			  		console.log('데이터 전송 에러');
		        }
			});
			
		});
		$('#orderBtn').on('click', function() {
			let basketCount = <%=basketList.size()%>;
			if(basketCount == 0){
				alert('장바구니에 담긴 상품이 없습니다.');
				return false;
			}
			
			let isOrder = confirm('주문하시겠습니까?');
			if(isOrder) {
				location.href = 'orderAddressForm.jsp';
			}
		});
	</script>
</body>
</html>
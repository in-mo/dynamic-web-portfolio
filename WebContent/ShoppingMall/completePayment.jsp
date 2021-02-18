<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.vo.NoticeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("main.jsp");
		return;
	}
	
	
	MemberDao memberDao = MemberDao.getInstance();
	MemberVo memberVo = memberDao.getMemberById(id);
	
	ArrayList<NoticeVo> productList = (ArrayList) session.getAttribute("productList");
	System.out.println(productList);
	
	String totalPrice = request.getParameter("totalPrice");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	
	SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
	Date time = new Date();
	
	String orderDate = format.format(time);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    margin-left: -250px;
    background-color:white; border: 1px solid #d2d2d2; padding: 20px;
}

table, th {
	border: 1px solid #d2d2d2;
}
td {
	padding: 5px;
}
body {
	background-color: black;
}
.btnTag{
	width:360px; height: 50px; margin-top: 10px; margin-bottom:20px; background-color: black; color: white; font-size: 20px;
}
.btnTage:hover {
	cursor: pointer;
}

</style>
</head>
<body>
	<div class="app">
		<div style="text-align: center;">
			<h2 style="display: inline-block;">MUSINSA</h2>
			<p style="display: inline-block; font-size: 22px">WUSINSA</p>
		</div>
		<h3>결제 완료</h3>
		<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		<div>
			<table>
				<tr>
					<td>구매목록</td>
					<td>
					<%for(int i=0;i<productList.size();i++){%> 
						<span><%=productList.get(i).getProduct()%></span>
					
					<br>
					<%
					}
 					%>
					</td>
				</tr>
				<tr>
					<td>합계 금액</td>
					<td><%=totalPrice %>원</td>
				</tr>
				<tr>
					<td>구매 날짜</td>
					<td><%=orderDate %></td>
				</tr>
				<tr>
					<td>구매자 이름</td>
					<td><%=name %></td>
				</tr>
				
				<tr>
					<td>구매자 번호</td>
					<td><%=tel %></td>
				</tr>
				<tr>
					<td>구매자 주소</td>
					<td><%=address %></td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<button type="button" class="btnTag">완료</button>
		</div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script>
	$('.btnTag').click(function() {
		location.href = 'main.jsp';
	});
	</script>
</body>
</html>
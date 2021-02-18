<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div {
	padding: 10px;
}

.app {
	width: 380px;
	display: flex;
	flex-direction: column;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -250px;
    margin-left: -250px;
}

a { 
	text-decoration:none 
} 

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

.loginBtn:hover {
	cursor: pointer;
}

body {
	background-color: black;
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
		<div style="text-align: center;">
			<form action="loginPro.jsp" name="frm">
				<input type="text" name="id" placeholder="아이디를 입력해주세요." style="width:280px; height: 30px; margin-bottom: 10px;"><br>
				<input type="password" name="password" placeholder="비밀번호를 입력해주세요." style="width:280px; height: 30px; margin-bottom: 20px;"><br>
				
				<input type="submit" class="loginBtn" value="로그인" style="width:290px; height: 50px; margin-bottom: 10px; background-color: black; color: white; font-size: 20px;"><br>
				<label>로그인 상태 유지</label>
				<input type="checkbox" name="keepLogin" value="true">
			</form>
		</div>
		<div style="padding: 0px">
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<div style="text-align: center;">
			<a href="joinForm.jsp">회원 가입</a> | <a href="FindByUserForm.jsp?searchType=id">아이디
				찾기</a> | <a href="FindByUserForm.jsp?searchType=pass">비밀번호 찾기</a>
		</div>
		<div style="padding: 0px">
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<div style="text-align: center;">이용약관 | 개인정보처리방침 | 고객센터</div>

	</div>
</body>
</html>
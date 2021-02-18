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

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<style>
div {
/* 	border: 1px solid red; */
	padding: 10px;
}
.app {
	width: 800px;
	display: flex;
	flex-direction: column;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -400px;
}
.float_right {
	float: right;
}

a { 
	text-decoration:none 
} 

.btnTag {
	width: 100px;
	height: 30px;
}

.inputTag {
	width:300px; height: 30px; margin-bottom: 10px;"
}
.addressTag {
	width:200px; height: 30px; margin-bottom: 10px;"
}

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
body {
	background-color: black;
}
.btnTag:hover{
	cursor: pointer;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" style="background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div><a href="myPage.jsp"><i class="fas fa-arrow-left"></i></a></div>
		<div style="text-align: center;">
			<h2 style="display: inline-block;">MUSINSA</h2>
			<p style="display: inline-block; font-size: 22px">WUSINSA</p>
		</div>
		<div style="text-align: center;">
			<h3 style="display: inline-block;">회원정보 수정</h3>
		</div>
		<div style="padding: 0px">
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<div style="font-size: 20px;">
			<span class="float_right"><%=memberVo.getId() %>님의 정보</span>
		</div>
		<div>
			<span>비밀번호		</span>
			<input type="password" style="border:none"  id="oldPasswordInfo" disabled value="<%=memberVo.getPassword() %>">
			<input type="button" class="float_right btnTag" id="passwordModify" value="비밀번호 변경">
			
			<form id="passwordChk">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				현재 비밀번호 : <input type="password" class="inputTag" id="oldPassword" placeholder="최소 8자리 이상" required>
				<span id="oldPassCheckReuslt"></span><br>
				신규 비밀번호 : <input type="password" class="inputTag" id="newPassword" placeholder="최소 8자리 이상" required>
				<span id="newPassCheckReuslt"></span><br>
				신규 비밀번호 재 입력 : <input type="password" class="inputTag" id="newPasswordChk" placeholder="최소 8자리 이상" required><br>
				
				<input type="reset" class="btnTag" id="passCancel" value="취소">
				<input type="submit" class="btnTag" id="passSure" value="완료" disabled>
			</form>
		</div>
		
		<div>
			<span>이름	</span><span id="oldNameInfo"><%=memberVo.getName() %></span>
			<input type="button" class="float_right btnTag" id="nameModify" value="이름 변경">
			
			<form id="nameInfo">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				이름 : <input type="text" class="inputTag" id="name" value="<%=memberVo.getName() %>" maxlength="5" required>
				<input type="reset" class="btnTag" id="nameCancel" value="취소">
				<input type="submit" class="btnTag" id="nameSure" value="완료">
			</form>
		</div>
		
		<div>
			<span>나이	</span><span id="ageInfo"><%=memberVo.getAge() %></span>
			<input type="button" class="float_right btnTag" id="ageModify" value="나이 변경">
			
			<form id="ageForm">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				나이 : <input type="number" class="inputTag" id="age" value="<%=memberVo.getAge() %>" min="1" max="99" required>
				<input type="reset" class="btnTag" id="ageCancel" value="취소">
				<input type="submit" class="btnTag" id="ageSure" value="완료">
			</form>
		</div>
		
		<div>
			<span>이메일	</span><span id="emailInfo"><%=memberVo.getEmail() %></span>
			<input type="button" class="float_right btnTag" id="emailModify" value="이메일 변경">
			
			<form id="emailForm">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				이메일 : <input type="email" class="inputTag" id="email" value="<%=memberVo.getEmail() %>" required>
				<input type="reset" class="btnTag" id="emailCancel" value="취소">
				<input type="submit" class="btnTag" id="emailSure" value="완료">
			</form>
		</div>
		
		<div>
			<span>휴대전화		</span><span id="telInfo"><%=memberVo.getTel() %></span>
			<input type="button" class="float_right btnTag" id="telModify" value="휴대전화 변경">
			
			<form id="telForm">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				휴대전화 : <input type="tel" class="inputTag" id="tel" value="<%=memberVo.getTel() %>" required>
				<input type="reset" class="btnTag" id="telCancel" value="취소">
				<input type="submit" class="btnTag" id="telSure" value="완료">
			</form>
		</div>
		
		<div>
			<span>주소		</span><span id="addressInfo"><%=memberVo.getAddress1()+" "+ memberVo.getAddress2()%></span>
			<input type="button" class="float_right btnTag" id="addressModify" value="주소 변경">
			
			<form id="addressForm">
				<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
				우편번호 : <input type="text" class="addressTag" id="postcode" value="<%=memberVo.getPostcode() %>" readonly>
						<input type="button" value="주소찾기" onclick="openDaumZipAddress();"><br>
				주소 : <input type="text" class="addressTag" id="address1" value="<%=memberVo.getAddress1() %>" readonly><br>
				상세 주소 : <input type="text" class="addressTag" id="address2" value="<%=memberVo.getAddress2() %>" required><br>
				<input type="reset" class="btnTag" id="addressCancel" value="취소">
				<input type="submit" class="btnTag" id="addressSure" value="완료">
			</form>
		</div>
		<div style="text-align: center;">
			<input type="button" class="btnTag" id="deleteMemberBtn" style="width:250px; height: 50px; background-color: black; color: white; font-size: 18px;" value="회원 탈퇴">		
		</div>
	</div>
	
	<script src="../js/jquery-3.5.1.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
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
	
	$("form#passwordChk").hide();
	$('form#nameInfo').hide();
	$('form#emailForm').hide();
	$('form#telForm').hide();
	$('form#ageForm').hide();
	$('form#addressForm').hide();
	
	// 비밀번호 변경 버튼 이벤트
	$('#passwordModify').on('click', function() {
		$('#passwordChk').show();
		$('#oldPasswordInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 비밀번호 취소 버튼 이벤트
	$('form#passwordChk').on('reset', function(event) {
		$('#passwordChk').hide();
		$('#oldPasswordInfo').show();
		$('#passwordModify').prop("disabled", false);
		$('#newPassCheckReuslt').text('');
		$('#oldPassCheckReuslt').text('');
	});
	
	// 비밀번호 완료 버튼 이벤트
	$('form#passwordChk').on('submit', function(event) {
		let aJsonArray = new Array();
		let pass1 = $('#newPassword').val();
		let userInfoArr = {"password": pass1, "name": "", "age": 0,
				"gender": "", "email": "", "tel": "", "postcode": "", 
				"address1": "", "address2": ""};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('비밀번호가 변경 되었습니다.');
				$('#oldPasswordInfo').text(pass1);
				$('#oldPasswordInfo').show();
				$('#passwordModify').prop("disabled", false);
				$('#newPassCheckReuslt').text('');
				$('#oldPassCheckReuslt').text('');
				$('#passwordChk').hide();
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 이름 변경 버튼 이벤트
	$('#nameModify').on('click', function() {
		$('form#nameInfo').show();
		$('#oldNameInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 이름 취소 버튼 이벤트
	$('form#nameInfo').on('reset', function(event) {
		$('form#nameInfo').hide();
		$('#oldNameInfo').show();
		$('#nameModify').prop("disabled", false);
	});
	
	// 이름 완료 버튼 이벤트
	$('form#nameInfo').on('submit', function(event) {
		let aJsonArray = new Array();
		let name =$('#name').val();
		let userInfoArr = {"password": "", "name": name, "age": 0,
				"gender": "", "email": "", "tel": "", "postcode": "", 
				"address1": "", "address2": ""};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('이름이 변경 되었습니다.');
				$('#oldNameInfo').text(name);
				$('#oldNameInfo').show();
				
				$('form#nameInfo').hide();
				$('#nameModify').prop("disabled", false);
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 나이 변경 버튼 이벤트
	$('#ageModify').on('click', function() {
		$('form#ageForm').show();
		$('#ageInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 나이 취소 버튼 이벤트
	$('form#ageForm').on('reset', function(event) {
		$('form#ageForm').hide();
		$('#ageInfo').show();
		$('#ageModify').prop("disabled", false);
	});
	
	// 나이 완료 버튼 이벤트
	$('form#ageForm').on('submit', function(event) {
		let aJsonArray = new Array();
		let age =$('#age').val();
		let userInfoArr = {"password": "", "name": "", "age": age,
				"gender": "", "email": "", "tel": "", "postcode": "", 
				"address1": "", "address2": ""};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('나이가 변경 되었습니다.');
				$('#ageInfo').text(age);
				$('#ageInfo').show();
				
				$('form#ageForm').hide();
				$('#ageModify').prop("disabled", false);
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 이메일 변경 버튼 이벤트
	$('#emailModify').on('click', function() {
		$('form#emailForm').show();
		$('#emailInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 이메일 취소 버튼 이벤트
	$('form#emailForm').on('reset', function(event) {
		$('form#emailForm').hide();
		$('#emailInfo').show();
		$('#emailModify').prop("disabled", false);
	});
	
	// 이메일 완료 버튼 이벤트
	$('form#emailForm').on('submit', function(event) {
		let aJsonArray = new Array();
		let email =$('#email').val();
		let userInfoArr = {"password": "", "name": "", "age": 0,
				"gender": "", "email": email, "tel": "", "postcode": "", 
				"address1": "", "address2": ""};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('이메일이 변경 되었습니다.');
				$('#emailInfo').val(email);
				$('#emailInfo').show();
				
				$('form#emailForm').hide();
				$('#emailModify').prop("disabled", false);
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 휴대전화 변경 버튼 이벤트
	$('#telModify').on('click', function() {
		$('form#telForm').show();
		$('#telInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 휴대전화 취소 버튼 이벤트
	$('form#telForm').on('reset', function(event) {
		$('form#telForm').hide();
		$('#telInfo').show();
		$('#telModify').prop("disabled", false);
	});
	
	// 휴대전화 완료 버튼 이벤트
	$('form#telForm').on('submit', function(event) {
		let aJsonArray = new Array();
		let tel =$('#tel').val();
		let userInfoArr = {"password": "", "name": "", "age": 0,
				"gender": "", "email": "", "tel": tel, "postcode": "", 
				"address1": "", "address2": ""};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('휴대전호 번호가 변경 되었습니다.');
				$('#telInfo').text(tel);
				$('#telInfo').show();
				
				$('form#telForm').hide();
				$('#telModify').prop("disabled", false);
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 주소 변경 버튼 이벤트
	$('#addressModify').on('click', function() {
		$('form#addressForm').show();
		$('#addressInfo').hide();
		$(this).prop("disabled", true);
	});
	
	// 주소 취소 버튼 이벤트
	$('form#addressForm').on('reset', function(event) {
		$('form#addressForm').hide();
		$('#addressInfo').show();
		$('#addressModify').prop("disabled", false);
	});
	
	// 주소 완료 버튼 이벤트
	$('form#addressForm').on('submit', function(event) {
		let aJsonArray = new Array();
		let postcode = $('#postcode').val();
		let address1 = $('#address1').val();
		let address2 = $('#address2').val();
		let userInfoArr = {"password": "", "name": "", "age": 0,
				"gender": "", "email": "", "tel": "", "postcode": postcode, 
				"address1": address1, "address2": address2};
		
		aJsonArray.push(userInfoArr);
		let jsonData = JSON.stringify(aJsonArray);
		$.ajax({
			url : 'updateUserInfo.jsp',
			type : 'post',
			data: 'jsonData=' + jsonData,
			success:function(data1) {
				console.log('데이터 전송 완료');
				alert('주소가 변경 되었습니다.');
				$('#addressInfo').text(address1 + ' ' + address2);
				$('#addressInfo').show();
				
				$('form#addressForm').hide();
				$('#addressModify').prop("disabled", false);
			},
	  		error:function(jqXHR, textStatus, errorThrown){
	  			console.log('데이터 전송 에러');
        	}
		});
	});
	
	// 신규 비밀번호 2번째 포커스아웃 이벤트
	$('#newPasswordChk').focusout(function() {
		var pass1 = $('#newPassword').val();
	    var pass2 = $(this).val();
		if(pass1 == '' || pass2 == ''){
			$('#newPassCheckReuslt').text('입력된 신규 비밀번호가 없습니다.').css('color','red');
			return;
		}
		if(pass1.length<8||pass2.length<8){
			$('#newPassCheckReuslt').text('8자리 이상 입력해 주세요.').css('color','red');
			return;
		}
		if(pass1 != pass2){
			$('#newPassCheckReuslt').text('입력한 신규 비밀번호가 일치하지 않습니다.').css('color','red');
			return;
		}
		
		$('#newPassCheckReuslt').text('비밀번호가 일치합니다.').css('color','green');
		$('#passSure').prop("disabled", false);
	});
	
	// 기존 비밀번호 키업 이벤트
	$("#oldPassword").keyup(function() {
		if($('#oldPassword').val().length < 8){
			return;
		}
		if($("#oldPassword").val()!='<%=memberVo.getPassword()%>'){
			$('#oldPassCheckReuslt').text('비밀번호가 일치 하지 않습니다.').css('color','red');
			return;
		}
		$('#oldPassCheckReuslt').text('비밀번호가 일치합니다.').css('color','green');
	});
	
	$('#deleteMemberBtn').click(function(){
		let isDelete = confirm('정말 탈퇴하시겠습니까?');
		if(isDelete){
			$.ajax({
				url:'deleteMemberPro.jsp',
				data: {id : '<%=id%>'},
				success:function(res){
					console.log(res);
					location.href = 'main.jsp';
				}
			});
		}
	});
	
	</script>
</body>
</html>
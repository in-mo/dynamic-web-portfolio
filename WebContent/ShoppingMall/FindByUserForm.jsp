<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String searchType = request.getParameter("searchType") == null ? "id" : request.getParameter("searchType");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기/비밀번호 찾기</title>
<style>
div {
	padding: 10px;
}

.app {
	width: 310px;
	margin: auto;
	display: flex;
	flex-direction: column;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -250px;
    margin-left: -250px;
}

#id { 
	display: none;
}
a { 
	text-decoration:none 
} 

a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}

body {
	background-color: black;
}

.searchType {
	display: inline-block;
	width: 120px;
	height: 50px;
	text-align: center;
}

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" style=" background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div><a href="loginForm.jsp"><i class="fas fa-arrow-left"></i></a></div>
		<div style="text-align: center;">
			<h2 style="display: inline-block;">회원정보 찾기</h2>
		</div>
		<div style="text-align: center; line-height: 50px;">
	<%
		if(searchType.equals("id")) {	
	%>
			<span class="searchType"><a href="FindByUserForm.jsp?searchType=id">아이디 찾기</a></span>
			<span class="searchType" style="background-color: #d2d2d2;"><a href="FindByUserForm.jsp?searchType=pass" style=" color: #e7e7e7">비밀번호 찾기</a></span>
	<%
		} else {
	%>
			<span class="searchType" style="background-color: #d2d2d2;"><a href="FindByUserForm.jsp?searchType=id" style=" color: #e7e7e7">아이디 찾기</a></span>
			<span class="searchType"><a href="FindByUserForm.jsp?searchType=pass">비밀번호 찾기</a></span>
	<%
		}
	%>
			
		</div>
		<form id="findUserForm" style="text-align: center;">
			<%
			if(searchType.equals("id")) {%>
				<input type="text" name="name" placeholder="이름 입력" style="width:250px; height: 30px; margin-bottom: 10px;"><br>
				<input type="text" id="id_tel" maxlength="13" placeholder="전화번호 입력" style="width:250px; height: 30px; margin-bottom: 20px;"><br>
				<input type="button" id="searchIdBtn" value="아이디 찾기" style="width:260px; height: 50px; background-color: black; color: white; font-size: 20px;">
			<%} else {%>
				<input type="text" name="id" placeholder="아이디 입력" style="width:250px; height: 30px; margin-bottom: 10px;"><br>
				<input type="text" name="name" placeholder="이름 입력" style="width:250px; height: 30px; margin-bottom: 10px;"><br>
				<input type="tel" id="pass_tel" maxlength="13" placeholder="전화번호 입력" style="width:250px; height: 30px; margin-bottom: 20px;"><br>
				<input type="button" id="searchPassBtn" value="비밀번호 찾기" style="width:260px; height: 50px; background-color: black; color: white; font-size: 20px;">
			<%}
		%>
		</form>
		<div style="text-align: center;" id="result"></div>
	</div>
	<script src="../js/jquery-3.5.1.js"></script>
	<script>
		$('#searchIdBtn').on('click', function(event) {
			let name = $('input[name="name"]').val();
			let tel = $('#id_tel').val();
			
			var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}");

			if(name==''){
				alert("이름을 입력해주세요.");
				return;
			}
			
			if( !patt.test( $("#id_tel").val()) ){
			    alert("전화번호를 정확히 입력하여 주십시오.");
			    return false;
			}
			console.log(name);
			console.log(tel);
			$.ajax({
				url : 'FindByUserPro.jsp',
				data : 'id=&name='+name+'&tel='+tel,
				success:function(data){
					console.log(data);
					console.log(typeof data);
// 					$('#result').text(data);
					alert(data);
				}
			});
		});
		
		$('#searchPassBtn').on('click', function(event) {
			let id = $('input[name="id"]').val();
			let name = $('input[name="name"]').val();
			let tel = $('#pass_tel').val();
			console.log(id);
			var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}");

			if(name==''){
				alert("이름을 입력해주세요.");
				return;
			}
			
			if( !patt.test( $("#pass_tel").val()) ){
			    alert("전화번호를 정확히 입력하여 주십시오.");
			    return false;
			}
			console.log(name);
			console.log(tel);
			$.ajax({
				url : 'FindByUserPro.jsp',
				data : 'id='+id+'&name='+name+'&tel='+tel,
				success:function(data){
					console.log(data);
					console.log(typeof data);
					alert(data);
// 					$('#result').text(data);
				}
			});
		});
		
		var autoHypenPhone = function(str){
		      str = str.replace(/[^0-9]/g, '');
		      var tmp = '';
		      if( str.length < 4){
		          return str;
		      }else if(str.length < 7){
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3);
		          return tmp;
		      }else if(str.length < 11){
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3, 3);
		          tmp += '-';
		          tmp += str.substr(6);
		          return tmp;
		      }else{              
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3, 4);
		          tmp += '-';
		          tmp += str.substr(7);
		          return tmp;
		      }
		  
		      return str;
		}

		var tel = document.getElementById('id_tel') == null ? document.getElementById('pass_tel') : document.getElementById('id_tel');
		
		tel.onkeyup = function(){
			console.log(this.value);
			this.value = autoHypenPhone( this.value ) ;  
		}
		
	</script>
</body>
</html>
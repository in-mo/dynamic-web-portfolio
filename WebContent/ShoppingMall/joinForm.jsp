<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.app {
	width: 360px;
	position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -450px;
    margin-left: -250px;
}
.float_right {
	float: right;
}

body {
	background-color: black;
}
.inputTag {
	width:350px; height: 30px; margin-bottom: 10px;"
}
.addressTag {
	width:200px; height: 30px; margin-bottom: 10px;"
}
.btnTag:hover {
	cursor: pointer;
}

a:link { color: black;}
a:visited { color: black;}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
	<div class="app" style="background-color:white; border: 1px solid #d2d2d2; padding: 20px;">
		<div>
			<div><a href="main.jsp"><i class="fas fa-arrow-left"></i></a></div>
			<div style="text-align: center;">
				<h2 style="display: inline-block;">MUSINSA</h2>
				<p style="display: inline-block; font-size: 22px">WUSINSA</p>
			</div>
			<div style="text-align: center;">
				<h3 style="display: inline-block;">회원가입</h3>
			</div>
		</div>
		<form name="frm" action="joinPro.jsp" method="post" onsubmit="return sendData();">
			<div>아이디</div>
			<input type="text" class="inputTag" id="id" name="id" placeholder="아이디 입력 (5~10 자리)" size="5"  maxlength="10" required>
<!-- 			<input type="button" id="btnDupChk" value="중복 확인"> -->
			<span id="msgIdDup"></span>
			<br>
			<div>비밀번호</div>
			<input type="password" class="inputTag" id="password1" name="password" placeholder="비밀번호 최소 8자리 이상" maxlength="15" size="8"  maxlength="15" required>
			<br>
			<input type="password" class="inputTag" id="password2" name="password2" placeholder="비밀번호 확인" size="8" maxlength="15" required>
			<br>
			<span id="msgPass" style="font-size: 13px;"></span>
			<br>
			<div>이름</div>
			<input type="text" class="inputTag" id="name" name="name" maxlength="5" placeholder="이름 입력" required>
			<div>성별</div>
			<input type="radio" name="gender" value="man" checked required>남
			<input type="radio" name="gender" value="woman" required style="margin-bottom: 10px;">여
			<div>나이</div>
			<input type="number" class="inputTag" name="age" placeholder="나이 입력" min="1" max="99" maxlength="2" required>
			<div>Email</div>
			<input type="email" class="inputTag" name="email" placeholder="Email 입력" maxlength="30" required>
			<div>전화번호</div>
			<input type="tel" class="inputTag" name="tel" id="tel" maxlength="13" placeholder="전화번호 입력" required>
			<div>주소</div>
			<input type="text" class="addressTag" id="postcode" name="postcode" placeholder="우편번호" readonly>
			<button type="button" class="btnTag" onclick="openDaumZipAddress();">
				<i class="fas fa-search fa-2x" style="width: 30px; height: 30px; vertical-align: middle;"></i>
			</button><br>
			<input type="text" class="addressTag" id="address1" name="address1" placeholder="주소" readonly><br>
			<input type="text" class="addressTag" id="address2" name="address2" placeholder="상세주소" required><br>
			<input type="checkbox" name="termsAll" onclick="setTermsAll();" style="margin-bottom: 10px">약관 전체동의<br>
			<input type="checkbox" name="terms" id="term1" class="terms" style="margin-bottom: 10px" required>개인정보 수집 이용동의(필수)
			<a href="terms.jsp" class="float_right">약관보기</a><br>
			<input type="checkbox" name="terms" id="term2" class="terms" style="margin-bottom: 10px" required>무신사, 무신사스토어 이용약관(필수)<br>
			<input type="checkbox" name="terms" class="terms" style="margin-bottom: 10px">마케팅 활용 및 광고성 정보 수신 동의(선택)<br>
			<input type="checkbox" name="terms" id="term3" class="terms" required>만 14세 미만 가입 제한(필수)<br>

			<input class="btnTag" type="submit" value="가입하기" style="width:360px; height: 50px; margin-top: 20px; background-color: black; color: white; font-size: 20px;">
		</form>
	</div>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../js/jquery-3.5.1.js"></script>
	
	<script type="text/javascript">
	
		var dupChk = false;
		console.log(dupChk);

		// 주소 찾기
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
		
		// 전체 체크 선택 해제 이벤트
		function setTermsAll() {
			if($("input:checkbox[name=termsAll]").is(":checked") == true) {
				$("input:checkbox[name=terms]").each(function() {
					 this.checked = true;
				});
			} else {
				$("input:checkbox[name=terms]").each(function() {
					 this.checked = false;
				});
			}
		}
		
		// 중복 검사
// 		$('#btnDupChk').click(function() {
// 			let id = $('input[name="id"]').val();
			
// 			if(id == ''||id.length < 5){
// 				alert('아이디를 규격에 맞게 입력하세요.');
// 				$('input[name="id"]').focus();
// 				return;
// 			}
			
// 			window.open('joinIdDupCheck.jsp?id=' + id,'idDupCheck', 'width=500,height=400');
// 		});
		
		// 아이디 입력 여부 검사
		$('input[name="id"]').focusout(function() {
			let id = $('input[name="id"]').val().length;
			if(id<5){
				alert('아이디를 규격에 맞게 입력하세요.');
				$('input[name="id"]').focus();
			}
		});
		
		$('#id').keyup(function() {
			let id = $(this).val();
			if(id.length < 5){
				return false;
			}
			$.ajax({
				url :  'joinIdDupCheck.jsp',
				data: {id : id},
				success:function(response) {
// 					console.log(response);
					if(response.isIdDup){
						$('span#msgIdDup').text('이미 사용중인 아이디입니다.').css('color', 'red');
					} else {
						$('span#msgIdDup').text('사용 가능한 아이디입니다.').css('color', 'green');
					}
					dupChk = response.isIdDup;
					console.log(dupChk);
				}
			});
		});
		
		// 비밀번호 길이 및 비교
		$('#password2').focusout(function() {
			let pass1 = $('#password1').val();
			let pass2 = $(this).val();
			console.log('pass1 : '+ pass1);
			console.log('pass2 : '+ pass2);
			if(pass1.length < 8 || pass2.length < 8){
				alert('비밀번호를 규격에 맞게 입력하세요.');
				$('input[name="password"]').focus();
				return;
			}
			if(pass1 == pass2) {
				$('#msgPass').html('비밀번호가 일치합니다.').css('color','blue');
			} else {
				$('#msgPass').html('일치하지 않는 비밀번호입니다.').css('color','red');
			}
		});
		
		$('input[name="age"]').focusout(function(){
			let ageData = $('input[name="age"]').val();
			console.log(ageData.length);
			if(ageData.length>2){
				$('input[name="age"]').val('99');
			}
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
		
		var tel = document.getElementById('tel');
		tel.onkeyup = function(){
			console.log(this.value);
			this.value = autoHypenPhone( this.value ) ;  
		}
		
		function sendData() {
			var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}");
			
			//////////////////////////////////////////////////////////////
			// 아이디 입력 여부
			if($('#id').val() == '' || $('#id').val() == null){
				alert("아이디를 입력하지 않았습니다.");
				$('#id').focus();
				return false;
			}
			
			for(let i=0;i< $('#id').val().length;i++){
				ch = $('#id').val().charAt(i)
				if(!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
					alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
					$('#id').focus();
					return false;
				}
			}
			
			if($('#id').val().length < 5 || $('#id').val().length >10){
				alert("아이디는 5~10까지 입력해주세요.")
				$('#id').focus();
				return false;
			}
			
		    if ($('#id').val().indexOf(" ") >= 0) {
	            alert("아이디에 공백을 사용할 수 없습니다.")
	            $('#id').focus();
	            return false;
	        }
			
			if(dupChk){
				alert("아이디 중복을 확인해주세요.");
				return false;
			}
			
			//////////////////////////////////////////////////////////////////////////
			// 비밀번호 입력 여부
			if($('#password1').val() == ''){
				alert("비밀번호를 입력하지 않았습니다.")
	        	$('#password1').focus();
	            return false;
			}
			
			if($('#password2').val() == ''){
				alert("비밀번호를 입력하지 않았습니다.")
	        	$('#password2').focus();
	            return false;
			}
			
			if ($('#password1').val() == $('#id').val()) {
	            alert("아이디와 비밀번호가 같습니다.")
	           	$('#password1').focus();
	            return false;
	        }
			
			 //비밀번호 길이 체크(8~15자 까지 허용)
	        if ($('#password1').val().length < 8 || $('#password1').val().length>15) {
	            alert("비밀번호를 8~15자까지 입력해주세요.")
	           $('#password1').focus();
	            return false;
	        }
			 
			//////////////////////////////////////////////////////////////////////////
			// 이름 입력 여부
			if($('#name').val()==''){
				alert('이름을 입력하지 않았습니다.');
				$('#name').focus();
				return false;
			}
			
			if($('#name').val().length < 2){
	            alert("이름을 2자 이상 입력해주십시오.")
	           $('#name').focus();
	            return false;
	        }
			
			//////////////////////////////////////////////////////////////////////////
			// 이메일 입력 여부
	        if ($('input[name="email"]').val() == '') {
	            alert("이메일을 입력하지 않았습니다.")
	            $('input[name="email"]').focus();
	            return false;
	        }
	        
	        var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	        
	        if (regex.test($('input[name="email"]').val()) === false) {
	            alert("잘못된 이메일 형식입니다.");
	            $('input[name="email"]').val('');
           		$('input[name="email"]').focus();
	            return false;
	        }
	 
// 	        for (var i = 0; i < $('input[name="email"]').val().length; i++) {
// 	            chm = $('input[name="email"]').val().charAt(i)
// 	            if (!(chm >= '0' && chm <= '9') && !(chm >= 'a' && chm <= 'z')&&!(chm >= 'A' && chm <= 'Z')) {
// 	                alert("이메일은 영문 대소문자, 숫자만 입력가능합니다.");
// 					$('input[name="email"]').focus();
// 	                return false;
// 	            }
// 	        }
			
	        /////////////////////////////////////////////////////////////////////////////
	        // 전화번호 입력 여부
			if( !patt.test( $("#tel").val()) ){
			    alert("전화번호를 정확히 입력하여 주십시오.");
			    $('#tel').focus();
			    return false;
			}
		
	        /////////////////////////////////////////////////////////////////////////////
	        // 주소 입력 여부
	        if($('#postcode').val()==""||$('#address1').val()==""||$('#address2').val()==""){
	        	alert("주소를 입력하여 주십시오.");
	        	openDaumZipAddress();
	        	return false;
	        }
	        
	        //////////////////////////////////////////////////////////////////////////
	        // 약관 동의
	        if($('#term1').is(":checked") == false){
	        	alert("약관 체크를 해주세요.");
	        	$('#term1').focus();
	        	return false;
	        }
	        
	        if($('#term2').is(":checked") == false){
	        	alert("약관 체크를 해주세요.");
	        	$('#term2').focus();
	        	return false;
	        }
	        
	        if($('#term3').is(":checked") == false){
	        	alert("약관 체크를 해주세요.");
	        	$('#term3').focus();
	        	return false;
	        }
			$('form[name="frm"]').submit();
		}
		
	</script>
</body>
</html>
<%@page import="java.util.List"%>
<%@page import="com.exam.vo.*"%>
<%@page import="com.exam.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

MemberDao memberDao = MemberDao.getInstance();

String article = request.getParameter("article");

int qnaNum = Integer.parseInt(request.getParameter("qnaNum") == null ? "0" :request.getParameter("qnaNum"));
String form = request.getParameter("form");

NoticeDao noticeDao = NoticeDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();
QnaDao qnaDao = QnaDao.getInstance();

NoticeVo noticeVo = noticeDao.getProductByArticle(article);

List<AttachVo> attachList = attachDao.getAttachesByArticle(article);
QnaVo qnaVo = qnaDao.getQnaInfoByNum(qnaNum);
QnaVo prevQnaVo = qnaDao.getQnaInfoByNum(qnaVo.getRe_ref());
MemberVo memberVo = null;
if(form.equals("write"))
	memberVo = memberDao.getMemberById(id);
else
	memberVo = memberDao.getMemberById(prevQnaVo.getId());

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의</title>
<style>
.app {
	width: 500px;
	margin: auto;
	display: flex;
	flex-direction: column;
    background-color:white; border: 1px solid #d2d2d2; padding: 20px;
}

div {
/* 	border: 1px solid red; */
	padding: 10px;
}

.Horizontal {
	display: inline-flex;
	flex-direction: row;
}
.verticality {
	display: inline-flex;
	flex-direction: column;

}
.btnTag{
	width:200px; 
	height: 50px;
	margin-top: 10px;
	margin-bottom:10px; 
	background-color: black; 
	color: white;
	font-size: 20px;
}
.btnTage:hover {
	cursor: pointer;
}
body{
	background-color: black;
}
td{
	padding: 5px;
}
</style>
</head>
<body>
	<div class="app verticality">
		<h4>상품문의</h4>
		<div style="padding: 0px;">
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<div class="Horizontal">
			<div>
				<img src="../upload/<%=attachList.get(0).getUploadpath()%>/<%=attachList.get(0).getImage()%>" width="100">
			</div>
			<div class="verticality">
				<div><%=noticeVo.getBrand() %></div>
				<div><%=noticeVo.getProduct() %></div>
				<div><%=noticeVo.getPrice() %>원 → <%=noticeVo.getPrice() - noticeVo.getSale() %>원</div>
			</div>
		</div>
		<div style="padding: 0px;">
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
		</div>
		<form>
			<div>
				<table>
					<tr>
						<td>문의 유형</td>
						<td>
							<div><%=prevQnaVo.getType() %></div>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>
							<div><%=prevQnaVo.getId() %></div>
						</td>
					</tr>
					
					<tr>
						<td>제목</td>
						<td>
							<div><%=prevQnaVo.getTitle() %></div>
						</td>
					</tr>
					
					<tr>
						<td>이메일</td>
						<td>
							<div><%=memberVo.getEmail() %></div>
						</td>
					</tr>
					
					<tr>
						<td>내용</td>
						<td>
							<div><%=prevQnaVo.getContent() %></div>
						</td>
					</tr>
				</table>
			</div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			<div>
				<p><b>답변 안내</b></p>
				<table>
					<tr>
						<td>작성자</td>
						<td>
							<input type="text" name="admin" placeholder="관리자 이름 입력" value="관리자">
						</td>
					</tr>
					
					<tr>
						<td>내용</td>
						<td>
							<textarea name="content" maxlength="100" placeholder="내용 입력" style="resize: none; width: 300px; height: 120px;"></textarea>
						</td>
					</tr>
				</table>
			</div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			<div style="text-align: center;">
			<%
			if(form.equals("write")) {
			%>
				<input type="reset" class="btnTag" value="취소">
				<input type="button" class="btnTag" id="write" value="작성하기">
			<%
			} else {
			%>
				<input type="reset" class="btnTag" value="취소">
				<input type="button" class="btnTag" id="modify" value="수정하기">
			<%
			}
			%>
			</div>
		</form>
	</div>
	
<script src="../js/jquery-3.5.1.js"></script>
<script>
	
	// 수정일 시 초기 값 설정
	let form = '<%=form%>';
	if(form != 'write') {
		let type = '<%=qnaVo.getType()%>';
		let admin = '<%=qnaVo.getId()%>';
		let content = '<%=qnaVo.getContent()%>';
		content = content.replace(/<br>/gi,'\n');
		$('input[name="type"]').val([type]);
		$('input[name="admin"]').val(admin);
		$('textarea[name="content"]').val(content);
	}
	
	// 수정이벤트
	$('#modify').click(function() {
		let admin = $('input:text[name="admin"]').val();
		let content = $('textarea[name="content"]').val();
		let no_num = <%=prevQnaVo.getNum()%>;
		let type = '답변';
		let title = '<%=prevQnaVo.getNum()%> 번 글의 답글';
		content = content.replace(/<br>/gi,'\n');
		
		if(admin.length == 0){
			alert('담장자 이름을 입력해주세요');
			return false;
		}
		
		if(content.length == 0){
			alert('내용을 입력해주세요');
			return false;
		}
		
		let isModify = confirm('상품 문의글을 수정하시겠습니까?');
		$.ajax({
			url: 'updateQnaInfoPro.jsp',
			data: { no_num: no_num, writer : admin, title: title, content: content, type: type, article: '<%=article%>', quaNum: <%=qnaNum%>},
			success:function(res){
				call_parent();
				window.close();
			}
		});
	});
	
	// 작성 이벤트
	$('#write').click(function() {
		let admin = $('input:text[name="admin"]').val();
		let content = $('textarea[name="content"]').val();
		let no_num = <%=qnaVo.getNum()%>;
		let type = '답변';
		let title = '<%=qnaVo.getNum()%> 번 글의 답글';
		content = content.replace(/<br>/gi,'\n');
		
		if(admin.length == 0){
			alert('담장자 이름을 입력해주세요');
			return false;
		}
		
		if(content.length == 0){
			alert('내용을 입력해주세요');
			return false;
		}
		
		let isWrite = confirm('상품 문의글을 작성하시겠습니까?');
		if(isWrite){
			$.ajax({
				url: 'addQnaPro.jsp',
				data: { no_num: no_num, writer : admin, title: title, content: content, type: type, article: '<%=article%>'},
				success:function(res){
					call_parent();
					window.close();
				}
			});
		}
	});
	
	// 컨텐츠 창의 함수호출
	function call_parent (){
		try{
			opener.updateQnaList();
		}catch (e) {
			alert('다시 시도해주세요');
			window.close();
		}
	}
</script>
</body>
</html>
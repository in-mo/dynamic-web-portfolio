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
MemberVo memberVo = memberDao.getMemberById(id);

String article = request.getParameter("article");

int qnaNum = Integer.parseInt(request.getParameter("qnaNum") == null ? "0" :request.getParameter("qnaNum"));

NoticeDao noticeDao = NoticeDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();
QnaDao qnaDao = QnaDao.getInstance();

NoticeVo noticeVo = noticeDao.getProductByArticle(article);

List<AttachVo> attachList = attachDao.getAttachesByArticle(article);
QnaVo qnaVo = qnaDao.getQnaInfoByNum(qnaNum);

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
.btnTag:hover {
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
							<input type="radio" name="type" value="사이즈" checked>사이즈
							<input type="radio" name="type" value="배송">배송
							<input type="radio" name="type" value="재입고">재입고
							<input type="radio" name="type" value="기타">기타
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="title" maxlength="15" placeholder="15자 이내 입력">
						</td>
					</tr>
					
					<tr>
						<td>이메일</td>
						<td>
							<input type="email" name="email" placeholder="이메일 입력" value="<%=memberVo.getEmail()%>">
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
			<div>
				<p><b>상품문의 안내</b></p>
				<p>- 상품문의는 재입고, 사이즈, 배송 등 상품에 대하여 브랜드 담당자에게 문의하는 게시판입니다.</p>
				<p>- 욕설, 비방, 거래 글, 분쟁 유발, 명예훼손, 허위사실 유포, 타 쇼핑몰 언급,광고성 등의 부적절한 게시글은 금지합니다. 더불어 상품 문의 시 비밀글만 작성되도록 제한됩니다.</p>
				<p>- 주문번호, 연락처, 계좌번호 등의 개인 정보 관련 내용은 공개되지 않도록 비밀글로 문의해 주시기 바랍니다. 공개된 글은 비밀글로 전환될 수 있으며, 개인 정보 노출로 인한 피해는 무신사 스토어가 책임지지 않습니다.</p>
			</div>
			<hr style="border: 0; height: 1px; background-color: #d2d2d2;">
			<div style="text-align: center;">
			<%
			if(qnaNum == 0) {
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
	if(<%=qnaNum%>!=0) {
		let type = '<%=qnaVo.getType()%>';
		let title = '<%=qnaVo.getTitle()%>';
		let content = '<%=qnaVo.getContent()%>';
		content = content.replace(/<br>/gi,'\n');
		$('input[name="type"]').val([type]);
		$('input[name="title"]').val(title);
		$('textarea[name="content"]').val(content);
	}
	
	// 수정이벤트
	$('#modify').click(function() {
		let type = $('input:radio[name="type"]:checked').val();
		let title = $('input:text[name="title"]').val();
		let content = $('textarea[name="content"]').val();
		content = content.replace(/<br>/gi,'\n');
		
		if(title.length == 0){
			alert('제목을 입력해주세요');
			return false;
		}
		
		if(content.length == 0){
			alert('내용을 입력해주세요');
			return false;
		}
		
		let isModify = confirm('상품 문의글을 수정하시겠습니까?');
		$.ajax({
			url: 'updateQnaInfoPro.jsp',
			data: { writer : '<%=id%>', title: title, content: content, type: type, article: '<%=article%>', quaNum: <%=qnaNum%>},
			success:function(res){
				call_parent();
				window.close();
			}
		});
	});
	
	// 작성 이벤트
	$('#write').click(function() {
		let type = $('input:radio[name="type"]:checked').val();
		let title = $('input:text[name="title"]').val();
		let content = $('textarea[name="content"]').val();
		content = content.replace(/<br>/gi,'\n');
		
		if(title.length == 0){
			alert('제목을 입력해주세요');
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
				data: { writer : '<%=id%>', title: title, content: content, type: type, article: '<%=article%>'},
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
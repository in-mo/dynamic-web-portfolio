<%@page import="com.exam.vo.ReplyVo"%>
<%@page import="com.exam.dao.ReplyDao"%>
<%@page import="com.exam.vo.QnaVo"%>
<%@page import="com.exam.dao.QnaDao"%>
<%@page import="java.io.File"%>
<%@page import="com.exam.dao.AttachDao"%>
<%@page import="com.exam.vo.AttachVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

String article = request.getParameter("article");
String pageNum = request.getParameter("pageNum");
AttachDao attachDao = AttachDao.getInstance();
ReplyDao replyDao = ReplyDao.getInstance();

//게시판번호에 첨부된 첨부파일 리스트 가져오기
List<AttachVo> attachList = attachDao.getAttachesByArticle(article);
List<ReplyVo> replyList = replyDao.getReplyesByArticle(article);

String realPath = application.getRealPath("/upload");

//첨부파일 삭제
for (AttachVo attachVo : attachList) {
	// 삭제할 파일을 File 타입 객체로 준비
	// 파일 경로 , 파일 이름
	File file = new File(realPath + "/" + attachVo.getUploadpath(), attachVo.getImage());

	if (file.exists()) { // 해당 경로에 파일이 존재하면
		file.delete(); // 파일 삭제하기

	}
}
for (ReplyVo replyVo : replyList) {
	// 삭제할 파일을 File 타입 객체로 준비
	// 파일 경로 , 파일 이름
	File file = new File(realPath + "/" + replyVo.getUploadpath(), replyVo.getImage());

	if (file.exists()) { // 해당 경로에 파일이 존재하면
		file.delete(); // 파일 삭제하기

	}
}

NoticeDao noticeDao = NoticeDao.getInstance();
noticeDao.deleteContentByArticle(article);

response.sendRedirect("main.jsp?pageNum="+pageNum);

%>
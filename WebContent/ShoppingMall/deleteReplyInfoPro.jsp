<%@page import="java.io.File"%>
<%@page import="com.exam.dao.ReplyDao"%>
<%@page import="com.exam.vo.ReplyVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

request.setCharacterEncoding("utf-8");

int replyNum = Integer.parseInt(request.getParameter("replyNum"));

ReplyDao replyDao = ReplyDao.getInstance();
ReplyVo replyVo = replyDao.getReplyInfoByNum(replyNum);

String realPath = application.getRealPath("/upload");

File file = new File(realPath+"/"+replyVo.getUploadpath(), replyVo.getImage());
if(file.exists()){
	file.delete();
}

replyDao.deleteReplyInfoByNum(replyNum);

out.println(true);

%>
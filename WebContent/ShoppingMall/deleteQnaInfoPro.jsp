<%@page import="com.exam.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));

QnaDao qnaDao = QnaDao.getInstance();
qnaDao.deleteQnaInfoByNum(qnaNum);

out.println(true);
%>

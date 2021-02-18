<%@page import="com.exam.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String article = request.getParameter("article");

QnaDao qnaDao = QnaDao.getInstance();
int count = qnaDao.getCountByArtcle(article);

out.println(count);

%>
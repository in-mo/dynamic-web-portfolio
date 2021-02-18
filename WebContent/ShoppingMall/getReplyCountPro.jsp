<%@page import="com.exam.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String article = request.getParameter("article");

ReplyDao replyDao = ReplyDao.getInstance();
int count = replyDao.getCountByArticle(article);

out.println(count);
%>
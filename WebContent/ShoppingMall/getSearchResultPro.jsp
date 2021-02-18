<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String cmd = request.getParameter("cmd");
String type = request.getParameter("type");
NoticeDao noticeDao = NoticeDao.getInstance();

List<String> list = noticeDao.getProductsByCmd(cmd, type);
Gson gson = new Gson();
gson.toJson(list);
out.println(gson.toJson(list));
%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.vo.*"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.*"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String article = request.getParameter("article");
int replyStartRow = Integer.parseInt(request.getParameter("replyStartRow"));
int replyPageSize = Integer.parseInt(request.getParameter("replyPageSize"));
ReplyDao replyDao = ReplyDao.getInstance();

List<ReplyVo> replyList = replyDao.getReplyesByArticle(article, replyStartRow, replyPageSize);

Gson gson = new Gson();
String jsonPlace = gson.toJson(replyList);

out.println(jsonPlace);
%>
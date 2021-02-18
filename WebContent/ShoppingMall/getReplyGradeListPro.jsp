<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.vo.*"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.*"%>
<%@ page language="java" contentType="html/text; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String article = request.getParameter("article");
ReplyDao replyDao = ReplyDao.getInstance();

List<ReplyVo> replyList = replyDao.getReplyesByArticle(article);

float grade=0;
for(ReplyVo replyVo : replyList){
	grade += Float.parseFloat(replyVo.getGrade());
}
grade = Float.parseFloat(String.format("%.1f", grade/replyList.size()));

out.println(grade);
%>
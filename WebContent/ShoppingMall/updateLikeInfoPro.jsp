<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="com.exam.vo.LikeVo"%>
<%@page import="com.exam.dao.LikeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

request.setCharacterEncoding("utf-8");

String article = request.getParameter("article");
String islike = request.getParameter("islike");

LikeDao likeDao = LikeDao.getInstance();
NoticeDao noticeDao = NoticeDao.getInstance();

int check = likeDao.updateIslike(article, id, islike);
if(check != 1){
	LikeVo likeVo = new LikeVo();
	likeVo.setArticle(article);
	likeVo.setId(id);
	likeVo.setIslike(islike);
	likeDao.addLike(likeVo);
}

if(islike.equals("Y")){
	noticeDao.updateLikecount(article, 1);
}else if (islike.equals("N")){
	noticeDao.updateLikecount(article, -1);
}

out.println(true);
%>
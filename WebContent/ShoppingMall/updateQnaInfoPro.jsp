<%@page import="com.exam.dao.QnaDao"%>
<%@page import="com.exam.vo.QnaVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

request.setCharacterEncoding("utf-8");

int quaNum = Integer.parseInt(request.getParameter("quaNum"));
String writer = request.getParameter("writer");
String title = request.getParameter("title");
String content = request.getParameter("content");
String type = request.getParameter("type");
String article = request.getParameter("article");

QnaDao qnaDao = QnaDao.getInstance();

QnaVo qnaVo = new QnaVo();
qnaVo.setNum(quaNum);
qnaVo.setId(writer);
qnaVo.setTitle(title);
qnaVo.setContent(content);
qnaVo.setType(type);
qnaVo.setArticle(article);

qnaDao.updateQnaInfo(qnaVo);

System.out.println(qnaVo);

out.println(true);
%>
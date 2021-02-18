<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.vo.QnaVo"%>
<%@page import="com.exam.dao.QnaDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));

QnaDao qnaDao = QnaDao.getInstance();
QnaVo qnaVo = qnaDao.getQnaInfoByNum(num);

Gson gson = new Gson();
String jsonPlace = gson.toJson(qnaVo);

out.println(jsonPlace);

%>
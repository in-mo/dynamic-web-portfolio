<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.vo.QnaVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.QnaDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

// boolean isLogin = false;
// String id = (String) session.getAttribute("id");
// if (id != null) {
// 	isLogin = true;
// }
request.setCharacterEncoding("utf-8");

String article = request.getParameter("article");
int qnaStartRow = Integer.parseInt(request.getParameter("qnaStartRow"));
int qnaPageSize = Integer.parseInt(request.getParameter("qnaPageSize"));
QnaDao qnaDao = QnaDao.getInstance();
List<QnaVo> qnaList = qnaDao.getQnasByArticle(article, qnaStartRow, qnaPageSize);

// Map<String, Object> map = new HashMap<>();
// map.put("isLogin", isLogin);
// map.put("qnaList", qnaList);

Gson gson = new Gson();
String jsonPlace = gson.toJson(qnaList);

out.println(jsonPlace);
%>
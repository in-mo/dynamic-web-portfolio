<%@page import="com.exam.dao.*"%>
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

String writer = request.getParameter("writer");
String title = request.getParameter("title");
String content = request.getParameter("content");
String type = request.getParameter("type");
String article = request.getParameter("article");

int num = ConnectDB.getNextNum("qna_table"); // insert될 글번호 가져오기
int no_num = Integer.parseInt(request.getParameter("no_num") == null ? "0" : request.getParameter("no_num"));
QnaDao qnaDao = QnaDao.getInstance();

QnaVo qnaVo = new QnaVo();
qnaVo.setId(writer);
qnaVo.setTitle(title);
qnaVo.setContent(content);
qnaVo.setType(type);
qnaVo.setArticle(article);
qnaVo.setRe_ref(no_num == 0 ? num : no_num);
qnaVo.setRe_lev(id.equals("admin") ? 1 : 0);

qnaDao.addQna(qnaVo);

System.out.println(qnaVo);

out.println(true);
%>
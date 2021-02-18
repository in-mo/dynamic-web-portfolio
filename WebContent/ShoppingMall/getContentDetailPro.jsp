<%@page import="com.exam.vo.*"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.*"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.getParameter("utf-8");

String detail = request.getParameter("detail");
int startRow = Integer.parseInt(request.getParameter("startRow"));
int pageSize = Integer.parseInt(request.getParameter("pageSize"));

NoticeDao noticeDao = NoticeDao.getInstance();
List<NoticeVo> noticeList = noticeDao.getProductByDetail(detail, startRow, pageSize);
// System.out.println(noticeList);
out.println(noticeList);
%>
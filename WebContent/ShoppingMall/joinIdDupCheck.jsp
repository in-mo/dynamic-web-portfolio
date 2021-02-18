<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// 파라미터값 id 가져오기	
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");

MemberDao memberDao = MemberDao.getInstance();
int count = memberDao.getCountById(id);

JSONObject jsonObj = new JSONObject();
if(count == 1){
	jsonObj.put("isIdDup", true);
}else{
	jsonObj.put("isIdDup", false);
}
out.println(jsonObj);
%>

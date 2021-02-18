<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

request.getParameter("utf-8");
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

MemberDao memberDao = MemberDao.getInstance();
MemberVo memberVo = memberDao.getMemberById(id);

String jsonData = request.getParameter("jsonData");
JsonParser jsonParser = new JsonParser();
JsonArray jsonArray = (JsonArray) jsonParser.parse(jsonData);


JsonObject object = (JsonObject) jsonArray.get(0);
memberVo.setId(id);
memberVo.setPassword(object.get("password").getAsString().equals("") ? memberVo.getPassword() : object.get("password").getAsString());
memberVo.setName(object.get("name").getAsString().equals("") ? memberVo.getName() : object.get("name").getAsString());
memberVo.setAge(object.get("age").getAsInt() == 0 ? memberVo.getAge() : object.get("age").getAsInt());
memberVo.setGender(object.get("gender").getAsString().equals("") ? memberVo.getGender() : object.get("gender").getAsString());
memberVo.setEmail(object.get("email").getAsString().equals("") ? memberVo.getEmail() : object.get("email").getAsString());
memberVo.setTel(object.get("tel").getAsString().equals("") ? memberVo.getTel() : object.get("tel").getAsString());
memberVo.setPostcode(object.get("postcode").getAsString().equals("") ? memberVo.getPostcode() : object.get("postcode").getAsString());
memberVo.setAddress1(object.get("address1").getAsString().equals("") ? memberVo.getAddress1() : object.get("address1").getAsString());
memberVo.setAddress2(object.get("address2").getAsString().equals("") ? memberVo.getAddress2() : object.get("address2").getAsString());

memberDao.updateMemberById(memberVo);
out.println("OK");
%>
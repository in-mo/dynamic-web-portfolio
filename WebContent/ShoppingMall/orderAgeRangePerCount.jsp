<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String article = request.getParameter("article");
	OrderDao orderDao = OrderDao.getInstance();
	
	List<Map<String, Object>> list = orderDao.getOrderAgeRangePerCount(article);
	
// 	System.out.println(list);
	
	JSONArray jsonArray = new JSONArray();
	for (Map<String, Object> map : list) {
		String ageRange = (String) map.get("age_range");
		int cnt = (int) map.get("cnt");
		JSONArray rowArray = new JSONArray();
		rowArray.add(0, ageRange);
		rowArray.add(1, cnt);
		
		jsonArray.add(rowArray);
	}
	
	JSONArray titleArray = new JSONArray();
	titleArray.add("연령대");
	titleArray.add("구매회원수");
	
	jsonArray.add(0, titleArray);
	
// 	System.out.println(jsonArray);
	out.println(jsonArray);
%>
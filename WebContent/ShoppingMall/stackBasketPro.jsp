<%@page import="com.exam.dao.BasketDao"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.vo.BasketVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
String jsonStackData = request.getParameter("jsonStackData");

BasketDao basketDao = BasketDao.getInstance();

Gson gson = new Gson();

List<BasketVo> basketList = gson.fromJson(jsonStackData, new TypeToken<List<BasketVo>>(){}.getType());
for(int i=0;i<basketList.size();i++){
	basketDao.addBasket(basketList.get(i));
}


System.out.println("basketList: "+ basketList);
%>
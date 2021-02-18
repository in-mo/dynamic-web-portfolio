<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.exam.vo.BasketVo"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.dao.BasketDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String jsonModifyData = request.getParameter("jsonModifyData");

BasketDao basketDao = BasketDao.getInstance();

Gson gson = new Gson();

BasketVo basketVo = gson.fromJson(jsonModifyData, BasketVo.class);

basketDao.updateBasketInfo(basketVo);

System.out.println("basketVo: "+ basketVo);
%>
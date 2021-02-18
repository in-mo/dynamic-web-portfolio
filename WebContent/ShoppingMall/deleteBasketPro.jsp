<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.vo.BasketVo"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.exam.dao.BasketDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

request.setCharacterEncoding("utf-8");
String jsonDeleteData = request.getParameter("jsonDeleteData");

BasketDao basketDao = BasketDao.getInstance();

Gson gson = new Gson();

// BasketVo basketVo = gson.fromJson(jsonDeleteData, BasketVo.class);

List<BasketVo> basketList = gson.fromJson(jsonDeleteData, new TypeToken<List<BasketVo>>(){}.getType());
for(int i=0;i<basketList.size();i++){
	basketDao.deleteBasketInfo(basketList.get(i));
}

// basketDao.deleteBasketInfo(basketVo);

System.out.println("basketList: "+ basketList);
%>
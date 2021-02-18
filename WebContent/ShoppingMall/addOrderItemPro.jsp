<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.exam.dao.*"%>
<%@page import="com.exam.vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.getParameter("utf-8");
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

String jsonData = request.getParameter("jsonData");
ArrayList<NoticeVo> productList = (ArrayList) session.getAttribute("productList");
ArrayList<Integer> basketNumList = (ArrayList) session.getAttribute("basketNumList");
String memo = request.getParameter("memo");
String name = request.getParameter("name");
String email = request.getParameter("email");
String tel = request.getParameter("tel");
String address = request.getParameter("address");
String gender = request.getParameter("gender");
int age = Integer.parseInt(request.getParameter("age"));

JsonParser jsonParser = new JsonParser();
JsonArray jsonArray = (JsonArray) jsonParser.parse(jsonData);

DateFormat format = new SimpleDateFormat ("yyyy-MM-dd");

NoticeDao noticeDao = NoticeDao.getInstance();
QuantityDao quantityDao = QuantityDao.getInstance();
OrderDao orderDao = OrderDao.getInstance();
BasketDao basketDao = BasketDao.getInstance();

for (int i = 0; i < productList.size(); i++) {
	JsonObject object = (JsonObject) jsonArray.get(i);
	OrderVo orderVo = new OrderVo();
	orderVo.setArticle(productList.get(i).getArticle());
	
	noticeDao.updateSalecount(productList.get(i).getArticle(), object.get("quantity").getAsInt());
	
	orderVo.setId(id);
	orderVo.setSize(object.get("size").getAsString());
	orderVo.setColor(object.get("color").getAsString());
	orderVo.setQuantity(object.get("quantity").getAsInt());
	orderVo.setPrice(productList.get(i).getPrice()*object.get("quantity").getAsInt());
	orderVo.setName(name);
	orderVo.setAge(age);
	orderVo.setGender(gender);
	orderVo.setTel(tel);
	orderVo.setAbsence_msg(memo);
	orderVo.setAddress(address);
	orderVo.setDelivery(productList.get(i).getDelivery());
	
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	cal.add(Calendar.DATE, productList.get(i).getReleasedate()>1 ? (int)(productList.get(i).getReleasedate()) : 0);
	String orderDate = format.format(cal.getTime());
	orderVo.setExpect_date(orderDate);

	orderDao.addOrder(orderVo);
	System.out.println(orderVo);
	
	// 해당 제품의 수량 감소
	QuantityVo quantityVo = quantityDao.getQuantitByArticleNSize(productList.get(i).getArticle(), object.get("size").getAsString());
	if(object.get("color").getAsString().equals("red"))
		quantityVo.setRed(quantityVo.getRed() - object.get("quantity").getAsInt());
	else if(object.get("color").getAsString().equals("orange"))
		quantityVo.setOrange(quantityVo.getOrange() - object.get("quantity").getAsInt());
	else if(object.get("color").getAsString().equals("yellow"))
		quantityVo.setYellow(quantityVo.getYellow() - object.get("quantity").getAsInt());
	else if(object.get("color").getAsString().equals("green"))
		quantityVo.setGreen(quantityVo.getGreen() - object.get("quantity").getAsInt());
	else if(object.get("color").getAsString().equals("blue"))
		quantityVo.setBlue(quantityVo.getBlue() - object.get("quantity").getAsInt());
	
	quantityDao.updateQuantityInfo(quantityVo);
}

if(basketNumList != null) {
	for(int basketNum : basketNumList){
		basketDao.deleteBasketInfoByNum(basketNum);
	}
}

JSONObject jObj = new JSONObject();
jObj.put("isOk", true);

out.println(jObj.toString());
%>
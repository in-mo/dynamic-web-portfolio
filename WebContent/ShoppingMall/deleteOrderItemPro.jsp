<%@page import="com.exam.vo.*"%>
<%@page import="com.exam.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

request.setCharacterEncoding("utf-8");

int order_num = Integer.parseInt(request.getParameter("order_num"));

OrderDao orderDao = OrderDao.getInstance();
QuantityDao quantityDao = QuantityDao.getInstance();
NoticeDao noticeDao = NoticeDao.getInstance();

OrderVo orderVo = orderDao.getOrderItemByOrderNum(order_num);
String article = orderVo.getArticle();
int quantity = -orderVo.getQuantity();

noticeDao.updateSalecount(article, quantity);

// 취소시 재고 수량 원상 복귀
QuantityVo quantityVo = quantityDao.getQuantitByArticleNSize(orderVo.getArticle(), orderVo.getSize());
if(orderVo.getColor().equals("red"))
	quantityVo.setRed(quantityVo.getRed() + orderVo.getQuantity());
else if(orderVo.getColor().equals("orange"))
	quantityVo.setOrange(quantityVo.getOrange() + orderVo.getQuantity());
else if(orderVo.getColor().equals("yellow"))
	quantityVo.setYellow(quantityVo.getYellow() + orderVo.getQuantity());
else if(orderVo.getColor().equals("green"))
	quantityVo.setGreen(quantityVo.getGreen() + orderVo.getQuantity());
else if(orderVo.getColor().equals("blue"))
	quantityVo.setBlue(quantityVo.getBlue() + orderVo.getQuantity());

quantityDao.updateQuantityInfo(quantityVo);

orderDao.deleteAttachByNum(order_num);

out.println("OK");
%>
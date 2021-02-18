<%@page import="com.exam.vo.QuantityVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.QuantityDao"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String article = request.getParameter("article");
QuantityDao quantityDao = QuantityDao.getInstance();
List<QuantityVo> quantityList = quantityDao.getQuantityByArticle(article);
System.out.println(quantityList);
%>
<quantityList>
<%
for(QuantityVo quantityVo : quantityList){
	%>
	<quantity>
		<num><%=quantityVo.getNum()%></num>
		<size><%=quantityVo.getSize()%></size>
		<red><%=quantityVo.getRed()%></red>
		<orange><%=quantityVo.getOrange()%></orange>
		<yellow><%=quantityVo.getYellow()%></yellow>
		<green><%=quantityVo.getGreen()%></green>
		<blue><%=quantityVo.getBlue()%></blue>
	</quantity>
	<%		
}
%>
</quantityList>
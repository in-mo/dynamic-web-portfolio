<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String password = request.getParameter("password");
String strKeepLogin = request.getParameter("keepLogin");

MemberDao memberDao = MemberDao.getInstance();
int count = memberDao.memberCheckById(id, password);

switch (count) {
	case -1 :
%>
<script>
	alert('존재하지 않는 아이디입니다.');
	history.back();
</script>
<%
	break;

case 0 :
%>
<script>
	alert('비밀번호가 틀립니다.');
	history.back();
</script>
<%
	break;

case 1:
	// 로그인 상태유지 정보 확인하기
	boolean keepLogin = false;
	if (strKeepLogin != null) {
		keepLogin = Boolean.parseBoolean(strKeepLogin);
	}
	
	// 세션에 로그인 아이디를 저장 (로그인 처리)
	session.setAttribute("id", id);
	
	// 로그인 상태유지를 원하면 쿠키 생성 후 응답주기
	if(keepLogin) {
		Cookie cookie = new Cookie("id", id); // 웹사이트 주소도 내포되어있음
		//										웹서버에서 쿠키를 받고
		//										해당 웹서버로 다시 돌려줌.쿠키(유효기간:1주일)
		cookie.setMaxAge(60 * 10); // 초단위 설정 10분
		cookie.setPath("/"); // 쿠키를 받을 경로
		
		response.addCookie(cookie);
	}
	
	response.sendRedirect("main.jsp");
	break;
}
%>
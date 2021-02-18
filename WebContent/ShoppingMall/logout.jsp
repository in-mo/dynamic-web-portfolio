<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 세션값 초기화. 로그아웃 작업
	session.invalidate();

	// 로그인 상태 유지용 쿠키가 존재하면 삭제
	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("id")){
				cookie.setMaxAge(0); // 유효기간 0으로 설정
				cookie.setPath("/"); // 만든시점에 설정한 경로 (생성지점과 경로같아야 삭제가 됨)
				
				response.addCookie(cookie); // 쿠키정보 보내기
			}
		}
	}

	// index.jsp로 리다이렉트
	response.sendRedirect("main.jsp");
%>


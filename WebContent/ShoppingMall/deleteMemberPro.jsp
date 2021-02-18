<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}
String receiveId = request.getParameter("id");
MemberDao memberDao = MemberDao.getInstance();

MemberVo memberVo = memberDao.getMemberById(receiveId);

SimpleEmail email = new SimpleEmail();

//SMTP 서버 연결설정
email.setHostName("smtp.naver.com");
email.setSmtpPort(465);
email.setAuthentication("yin5946", "xhdrkffk13@");

//보안연결 SSL, TLS 설정
email.setSSLOnConnect(true);
email.setStartTLSEnabled(true);

String responseMsg = "fail";

try {
	// 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
	email.setFrom("yin5946@naver.com", "관리자", "utf-8");
	
	// 받는 사람 설정
	email.addTo(memberVo.getEmail(), memberVo.getName(), "utf-8");
	
	// 제목 설정
	email.setSubject("회원님의 회원 탈퇴에 관하여");
	
	// 본문 설정
	email.setMsg(memberVo.getName()+" 님은 회원 탈퇴를 하셨습니다..");
	
	// 메일 전송하기
	responseMsg = email.send();
	
} catch (EmailException e) {
	e.printStackTrace();
}

memberDao.deleteMemberById(receiveId);

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

out.println(true);
%>
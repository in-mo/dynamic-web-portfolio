<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id") == null ? "" : request.getParameter("id");
String name = request.getParameter("name");
String tel = request.getParameter("tel");

System.out.println(id);
System.out.println(name);
System.out.println(tel);

MemberDao memberDao = MemberDao.getInstance();

MemberVo memberVo = memberDao.searchUser(id, name, tel);

SimpleEmail email = new SimpleEmail();

//SMTP 서버 연결설정
email.setHostName("smtp.naver.com");
email.setSmtpPort(465);
email.setAuthentication("yin5946", "xhdrkffk13@");

//보안연결 SSL, TLS 설정
email.setSSLOnConnect(true);
email.setStartTLSEnabled(true);

String responseMsg = "fail";

if (memberVo.getReg_date() == null) {
	out.println("잘못된 정보이거나 해당 정보는 존재하지 않습니다.");
} else if(id.equals("")&&memberVo.getReg_date()!=null){
	out.println("회원님의 메일을 확인해주세요!");
	
	try {
		// 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
		email.setFrom("yin5946@naver.com", "관리자", "utf-8");
		
		// 받는 사람 설정
		email.addTo(memberVo.getEmail(), memberVo.getName(), "utf-8");
		
		// 제목 설정
		email.setSubject("회원님의 회원 정보에 관하여");
		
		// 본문 설정
		email.setMsg(memberVo.getName()+" 님의 아이디는\n\n"+memberVo.getId()+ " 입니다..");
		
		// 메일 전송하기
		responseMsg = email.send();
		
	} catch (EmailException e) {
		e.printStackTrace();
	}
	
} else if(!id.equals("")&&memberVo.getReg_date()!=null) {
	out.println("회원님의 메일을 확인해주세요!");
	
	try {
		// 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
		email.setFrom("yin5946@naver.com", "관리자", "utf-8");
		
		// 받는 사람 설정
		email.addTo(memberVo.getEmail(), memberVo.getName(), "utf-8");
		
		// 제목 설정
		email.setSubject("회원님의 회원 정보에 관하여");
		
		// 본문 설정
		email.setMsg(memberVo.getName()+"님의 비밀번호는 \n\n"+memberVo.getPassword()+ " 입니다..");
		
		// 메일 전송하기
		responseMsg = email.send();
		
	} catch (EmailException e) {
		e.printStackTrace();
	}
}

System.out.println("응답메시지: " + responseMsg);
%>
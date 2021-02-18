<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// post 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

// 액션태그로 Vo 객체 처리

// 액션태그로 Vo 객체에 파라미터값 저장
%>
<jsp:useBean id="memberVo" class="com.exam.vo.MemberVo" />
<jsp:setProperty property="*" name="memberVo" />

<%
	// 가입날짜 생성해서 넣기
memberVo.setReg_date(new Timestamp(System.currentTimeMillis()));

// Dao 객체 준비
MemberDao memberDao = MemberDao.getInstance();
// 메소드 호출
memberDao.insertMember(memberVo);

SimpleEmail email = new SimpleEmail();

//SMTP 서버 연결설정
email.setHostName("smtp.naver.com");
email.setSmtpPort(465);
email.setAuthentication("yin5946", "xhdrkffk13@");

// 보안연결 SSL, TLS 설정
email.setSSLOnConnect(true);
email.setStartTLSEnabled(true);

String responseMsg = "fail";

try {
	// 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
	email.setFrom("yin5946@naver.com", "관리자", "utf-8");
	
	// 받는 사람 설정
	email.addTo(memberVo.getEmail(), memberVo.getName(), "utf-8");
	
	// 제목 설정
	email.setSubject("회원 가입 축하에 관하여");
	
	// 본문 설정
	email.setMsg(memberVo.getName()+"님\n\n"+ "가입을 축하드립니다.");
	
	// 메일 전송하기
	responseMsg = email.send();
	
} catch (EmailException e) {
	e.printStackTrace();
}

System.out.println("응답메시지: " + responseMsg);
//response.sendRedirect("join.jsp");
%>
<script>
	alert('회원가입 성공');
	location.href = 'loginForm.jsp';
</script>
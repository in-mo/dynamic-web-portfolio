<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.exam.vo.ReplyVo"%>
<%@page import="com.exam.dao.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return;
}

	//업로드 할 실제 물리적 경로 구하기
String realPath = application.getRealPath("/upload"); // WebContent 경로
// System.out.println("realPath : " + realPath);

//오늘날짜 년월일 폴더가 존재하는지 확인해서 없으면 생성하기
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
String strDate = sdf.format(date); // 2020/11/11

File dir = new File(realPath, strDate);
// System.out.println("dir : " + dir.getPath());

if (!dir.exists()) {
	dir.mkdirs();
}

//파일 업로드 하기
MultipartRequest multi = new MultipartRequest(request, dir.getPath(), 1024 * 1024 * 100, // 100MB로 제한
		"utf-8", new DefaultFileRenamePolicy()); // 파일 이름 중복 방지(자동+1)

request.setCharacterEncoding("utf-8");

int replyNum = Integer.parseInt(multi.getParameter("replyNum"));
String isDelete = multi.getParameter("isDelete");
String grade = multi.getParameter("grade");

ReplyDao replyDao = ReplyDao.getInstance();
ReplyVo replyVo = replyDao.getReplyInfoByNum(replyNum);

if (isDelete.equals("Y")) {
	
	File file = new File(realPath + "/" + replyVo.getUploadpath(), replyVo.getImage());

	if (file.exists()) { // 해당 경로에 파일이 존재하면
		file.delete(); // 파일 삭제하기
	}
	
	//Enumeration은 반복자 객체, file의 name속성들을 가지고 있음
	String image1 = multi.getFilesystemName("newImage1");
	if (image1 == null) {
		image1 = "";
		strDate = "";
	}
	
	replyVo.setImage(image1);
	replyVo.setUploadpath(strDate);
}

replyVo.setContent(multi.getParameter("content"));
replyVo.setGrade(grade);
System.out.println(replyVo);

replyDao.updateReplyInfo(replyVo);

out.println(true);
%>
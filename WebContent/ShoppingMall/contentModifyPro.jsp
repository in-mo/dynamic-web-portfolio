<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.vo.*"%>
<%@page import="com.exam.dao.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 로그인 여부 확인
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("main.jsp");
	return; // sendRedirect 를 사용시 return으로 다음 자바코드를 생략시키는게 좋다.
}

// 파일 업로드 위해서 cos.jar 라이브러리를 프로젝트 빌드패스에 추가

// 업로드 객체 생성할때 필요한 인자값
// 1. request
// 2. 업로드할 폴더의 물리적 경로
// 3. 업로드 최대 파일 크기 제한
// 4. 파일명 한글처리 utf-8
// 5. 파일명 중복될때 이름변경규칙 가진 객체를 전달

// 업로드 할 실제 물리적 경로 구하기
String realPath = application.getRealPath("/upload"); // WebContent 경로
System.out.println("realPath : " + realPath);

// 오늘날짜 년월일 폴더가 존재하는지 확인해서 없으면 생성하기
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
String strDate = sdf.format(date); // 2020/11/11

File dir = new File(realPath, strDate);
System.out.println("dir : " + dir.getPath());

if (!dir.exists()) {
	dir.mkdirs();
}

// 파일 업로드 하기
MultipartRequest multi = new MultipartRequest(request, dir.getPath(), 1024 * 1024 * 100, // 100MB로 제한
		"utf-8", new DefaultFileRenamePolicy()); // 파일 이름 중복 방지(자동+1)

String pageNum = multi.getParameter("pageNum");

//DAO 객체 준비
NoticeDao noticeDao = NoticeDao.getInstance();
AttachDao attachDao = AttachDao.getInstance();
QuantityDao quantityDao = QuantityDao.getInstance();
OrderDao orderDao = OrderDao.getInstance();

//Enumeration은 반복자 객체, file의 name속성들을 가지고 있음
Enumeration<String> enu = multi.getFileNames();
while (enu.hasMoreElements()) {
	String fname = enu.nextElement();

	// 실제 업로드된 파일명 가져오기
	String filename = multi.getFilesystemName(fname);

	if (filename == null)
		continue;

	System.out.println("실제파일 : " + filename);

	// AttachVo 객체 준비
	AttachVo attachVo = new AttachVo();
	attachVo.setImage(filename); // 실제파일명을 Vo에 저장
	attachVo.setUploadpath(strDate); // "년/월/일" 경로를 저장
	attachVo.setReg_article(multi.getParameter("article")); // insert될 게시판 글번호 저장

	// attachVo를 attach 테이블에 insert하기
	attachDao.addImage(attachVo);

	System.out.println(attachVo);
}

String[] delFileNums = multi.getParameterValues("delfile");

if (delFileNums != null) {
	for (String delFileNum : delFileNums) {
		// 삭제할 첨부파일 번호를 숫자로 변환
		int num = Integer.parseInt(delFileNum);

		AttachVo attachVo = attachDao.getAttachByNum(num);

		//파일정보로 실제파일 존재여부 확인해서 삭제하기
		File delFile = new File(realPath + "/" + attachVo.getUploadpath(), attachVo.getImage());
		if (delFile.exists()) {
	delFile.delete();
		}

		// 첨부파일 테이블에 번호에 해당하는 레코드 한개 삭제하기
		attachDao.deleteAttachByNum(num);
	}
}

// NoticeVo 객체 준비
NoticeVo noticeVo = noticeDao.getProductByArticle(multi.getParameter("article"));
// 파라미터값 가져와서 VO에 저장
noticeVo.setLimitedSale(multi.getParameter("limitedSale") == null ? "N" : multi.getParameter("limitedSale"));
noticeVo.setBrand(multi.getParameter("brand"));
noticeVo.setProduct(multi.getParameter("product"));
noticeVo.setGender(multi.getParameter("gender"));
noticeVo.setPart(multi.getParameter("part"));
noticeVo.setDetail(multi.getParameter("detail"));
noticeVo.setPrice(Integer.parseInt(multi.getParameter("price")));
noticeVo.setSale(Integer.parseInt(multi.getParameter("sale")));
noticeVo.setDelivery(multi.getParameter("delivery"));
noticeVo.setReleasedate(Float.parseFloat(multi.getParameter("releasedate")));
noticeVo.setWeekend(multi.getParameter("weekend") == null ? "N" : multi.getParameter("weekend"));

System.out.println(noticeVo);

// 주글 등록하기
noticeDao.updateNoticeData(noticeVo);

// 구매 내역 수정
DateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
List<OrderVo> orderList = orderDao.getOrderListByArticle(multi.getParameter("article"));
if (orderList != null)
	for (int i = 0; i < orderList.size(); i++) {
		orderList.get(i).setDelivery(multi.getParameter("delivery"));
		orderList.get(i).setPrice((Integer.parseInt(multi.getParameter("price"))-Integer.parseInt(multi.getParameter("sale")))*orderList.get(i).getQuantity());
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, noticeVo.getReleasedate()>1 ? (int)(noticeVo.getReleasedate()) : 0);
		String orderDate = format.format(cal.getTime());
		orderList.get(i).setExpect_date(orderDate);
		
		orderDao.updateOrderInfo(orderList.get(i));
	}


// QuantityVo 객체 준비
QuantityVo quantityVo = new QuantityVo();
quantityVo.setNum(Integer.parseInt(multi.getParameter("snum")));
quantityVo.setSize("S");
quantityVo.setRed(Integer.parseInt(multi.getParameter("redsn")));
quantityVo.setOrange(Integer.parseInt(multi.getParameter("orangesn")));
quantityVo.setYellow(Integer.parseInt(multi.getParameter("yellowsn")));
quantityVo.setGreen(Integer.parseInt(multi.getParameter("greensn")));
quantityVo.setBlue(Integer.parseInt(multi.getParameter("bluesn")));
quantityVo.setReg_article(multi.getParameter("article"));
System.out.println(quantityVo);
quantityDao.updateQuantityInfo(quantityVo);
quantityVo = null;

quantityVo = new QuantityVo();
quantityVo.setNum(Integer.parseInt(multi.getParameter("mnum")));
quantityVo.setSize("M");
quantityVo.setRed(Integer.parseInt(multi.getParameter("redmn")));
quantityVo.setOrange(Integer.parseInt(multi.getParameter("orangemn")));
quantityVo.setYellow(Integer.parseInt(multi.getParameter("yellowmn")));
quantityVo.setGreen(Integer.parseInt(multi.getParameter("greenmn")));
quantityVo.setBlue(Integer.parseInt(multi.getParameter("bluemn")));
quantityVo.setReg_article(multi.getParameter("article"));
System.out.println(quantityVo);
quantityDao.updateQuantityInfo(quantityVo);
quantityVo = null;

quantityVo = new QuantityVo();
quantityVo.setNum(Integer.parseInt(multi.getParameter("lnum")));
quantityVo.setSize("L");
quantityVo.setRed(Integer.parseInt(multi.getParameter("redln")));
quantityVo.setOrange(Integer.parseInt(multi.getParameter("orangeln")));
quantityVo.setYellow(Integer.parseInt(multi.getParameter("yellowln")));
quantityVo.setGreen(Integer.parseInt(multi.getParameter("greenln")));
quantityVo.setBlue(Integer.parseInt(multi.getParameter("blueln")));
quantityVo.setReg_article(multi.getParameter("article"));
System.out.println(quantityVo);
quantityDao.updateQuantityInfo(quantityVo);
quantityVo = null;

quantityVo = new QuantityVo();
quantityVo.setNum(Integer.parseInt(multi.getParameter("xlnum")));
quantityVo.setSize("XL");
quantityVo.setRed(Integer.parseInt(multi.getParameter("redxln")));
quantityVo.setOrange(Integer.parseInt(multi.getParameter("orangexln")));
quantityVo.setYellow(Integer.parseInt(multi.getParameter("yellowxln")));
quantityVo.setGreen(Integer.parseInt(multi.getParameter("greenxln")));
quantityVo.setBlue(Integer.parseInt(multi.getParameter("bluexln")));
quantityVo.setReg_article(multi.getParameter("article"));
System.out.println(quantityVo);
quantityDao.updateQuantityInfo(quantityVo);

// 글내용 상세보기 화면 content.jsp로 이동
response.sendRedirect("content.jsp?article=" + multi.getParameter("article") + "&pageNum=" + pageNum);
%>
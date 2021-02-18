package com.exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectDB {

	// 헤로쿠 MySQL DB
	// mysql://b1c1a47b282024:e5b6361f@us-cdbr-east-02.cleardb.com/heroku_c1ebe10c2664633?reconnect=true&useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul

	// DB ID - b1c1a47b282024
	// DB PASSWD - e5b6361f
	// Localhost - us-cdbr-east-02.cleardb.com
	// 스키마 - heroku_c1ebe10c2664633
	// 한국어 처리 설정 -
	// useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul

	private static Connection con = null;

	public static Connection getConnection() throws Exception {
		
		// DB접속 정보
		String dbUrl = "jdbc:mysql://localhost:3306/jspdb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
		String dbId = "myid";
		String dbPwd = "mypwd";
		
		// 1단계. DB드라이버 클래스 로딩
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계. DB에 연결 시도. 연결후 Connection객체를 리턴함.
		con = DriverManager.getConnection(dbUrl, dbId, dbPwd);
		
		
		// 커넥션 풀 방식 - 커넥션 한개 빌려오기
		// javax.naming
//		Context context = new InitialContext();
		// javax.sql
//		DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/jspdb");
//		con = ds.getConnection(); // 안쓰는 커넥션 하나 빌려옴
		return con;
	}

	public static void close(Connection con, PreparedStatement pstmt) {
		close(con, pstmt, null);
	}

	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (con != null) {
				con.close(); // 커넥션 객체 반환 / 삭제x
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // close()
	
	public static int getNextNum(String tableName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = 0;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			
			sql = "SELECT AUTO_INCREMENT ";
			sql += "FROM information_schema.tables ";
			sql += "WHERE table_name = ? ";
			sql += "AND table_schema = DATABASE()";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tableName);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return num;
	}

}

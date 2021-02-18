package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.QnaVo;

public class QnaDao {

	private static QnaDao instance = new QnaDao();

	public static QnaDao getInstance() {
		return instance;
	}

	private QnaDao() {
	}

	public void addQna(QnaVo qnaVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "insert into qna_table (id, title, content, type, article, re_ref, re_lev, reg_date) ";
			sql += "values(?, ?, ?, ?, ?, ?, ?, now()) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qnaVo.getId());
			pstmt.setString(2, qnaVo.getTitle());
			pstmt.setString(3, qnaVo.getContent().replaceAll("\n", "<br>"));
			pstmt.setString(4, qnaVo.getType());
			pstmt.setString(5, qnaVo.getArticle());
			pstmt.setInt(6, qnaVo.getRe_ref());
			pstmt.setInt(7, qnaVo.getRe_lev());

			pstmt.executeUpdate();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public int getCountByArtcle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "select count(*) from qna_table where article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return count;
	}
	
	public List<QnaVo> getQnasByArticle(String article) {
		List<QnaVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from qna_table where article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaVo qnaVo = new QnaVo();
				qnaVo.setNum(rs.getInt("num"));
				qnaVo.setId(rs.getString("id"));
				qnaVo.setTitle(rs.getString("title"));
				qnaVo.setContent(rs.getString("content"));
				qnaVo.setType(rs.getString("type"));
				qnaVo.setArticle(rs.getString("article"));
				qnaVo.setRe_ref(rs.getInt("re_ref"));
				qnaVo.setRe_lev(rs.getInt("re_lev"));
				qnaVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(qnaVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}
	
	public List<QnaVo> getQnasByArticle(String article, int qnaStartRow, int qnaPageSize) {
		List<QnaVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from qna_table where article = ? ";
			sql += "order by re_ref desc, ";
			sql += "re_lev asc ";
			sql += "limit ?, ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.setInt(2, qnaStartRow);
			pstmt.setInt(3, qnaPageSize);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaVo qnaVo = new QnaVo();
				qnaVo.setNum(rs.getInt("num"));
				qnaVo.setId(rs.getString("id"));
				qnaVo.setTitle(rs.getString("title"));
				qnaVo.setContent(rs.getString("content"));
				qnaVo.setType(rs.getString("type"));
				qnaVo.setArticle(rs.getString("article"));
				qnaVo.setRe_ref(rs.getInt("re_ref"));
				qnaVo.setRe_lev(rs.getInt("re_lev"));
				qnaVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(qnaVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}

	public QnaVo getQnaInfoByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		QnaVo qnaVo = new QnaVo();
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from qna_table where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qnaVo.setNum(rs.getInt("num"));
				qnaVo.setId(rs.getString("id"));
				qnaVo.setTitle(rs.getString("title"));
				qnaVo.setContent(rs.getString("content"));
				qnaVo.setType(rs.getString("type"));
				qnaVo.setArticle(rs.getString("article"));
				qnaVo.setRe_ref(rs.getInt("re_ref"));
				qnaVo.setRe_lev(rs.getInt("re_lev"));
				qnaVo.setReg_date(rs.getTimestamp("reg_date"));
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return qnaVo;
	}
	
	public void updateQnaInfo(QnaVo qnaVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql ="";
		
		try {
			con = ConnectDB.getConnection();
			
			sql = "update qna_table ";
			sql += "set id = ? ";
			sql += ", title = ? ";
			sql += ", content = ? ";
			sql += ", type = ? ";
			sql += ", article = ? ";
			sql += "where num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qnaVo.getId());
			pstmt.setString(2, qnaVo.getTitle());
			pstmt.setString(3, qnaVo.getContent().replaceAll("\n", "<br>"));
			pstmt.setString(4, qnaVo.getType());
			pstmt.setString(5, qnaVo.getArticle());
			pstmt.setInt(6, qnaVo.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public void deleteQnaInfoByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "delete from qna_table where num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public void deleteQnaInfosByArticle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "delete from qna_table where article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);

			pstmt.executeUpdate();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
}

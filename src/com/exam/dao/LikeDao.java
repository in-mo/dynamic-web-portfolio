package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.exam.vo.LikeVo;

public class LikeDao {
	private static LikeDao instance = new LikeDao();

	public static LikeDao getInstance() {
		return instance;
	}

	private LikeDao() {
	}
	
	public void addLike(LikeVo likeVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "INSERT INTO like_table (id, article, islike) ";
			sql += "VALUES (?, ?, ?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, likeVo.getId());
			pstmt.setString(2, likeVo.getArticle());
			pstmt.setString(3, likeVo.getIslike());

			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public LikeVo getProductLikeInfo(String id, String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		LikeVo likeVo = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();

			sql = "SELECT * FROM like_table ";
			sql += "WHERE id = ? ";
			sql += "and article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, article);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				likeVo = new LikeVo();
				likeVo.setNum(rs.getInt("num"));
				likeVo.setId(rs.getString("id"));
				likeVo.setArticle(rs.getString("article"));
				likeVo.setIslike(rs.getString("islike"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return likeVo;
	}
	
	public int getLikecount(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();

			sql = "SELECT count(*) FROM like_table ";
			sql += "WHERE article = ? ";
			sql += "and islike = 'Y' ";

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
	
	public int updateIslike(String article, String id, String islike) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result=0;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE like_table ";
			sql += "SET islike = ? ";
			sql += "WHERE article = ? ";
			sql += "and id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, islike);
			pstmt.setString(2, article);
			pstmt.setString(3, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
		return result;
	}
	
	public void deleteProductLikeInfo(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		try {
			con = ConnectDB.getConnection();

			con.setAutoCommit(false); // 수동 commit으로 변경

			sql = "delete from like_table ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
}

package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.AttachVo;
import com.exam.vo.ReplyVo;

public class ReplyDao {
	private static ReplyDao instance = new ReplyDao();

	public static ReplyDao getInstance() {
		return instance;
	}

	private ReplyDao() {
	}

	public void addReplyDao(ReplyVo replyVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "insert into shop_reply_info (id, image, uploadpath, article, content, grade, reg_date) ";
			sql += "values(?, ?, ?, ?, ?, ?, now()) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, replyVo.getId());
			pstmt.setString(2, replyVo.getImage());
			pstmt.setString(3, replyVo.getUploadpath());
			pstmt.setString(4, replyVo.getArticle());
			pstmt.setString(5, replyVo.getContent().replaceAll("\n", "<br>"));
			pstmt.setString(6, replyVo.getGrade());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public List<ReplyVo> getReplyesByArticle(String article, int replyStartRow, int replyPageSize) {
		List<ReplyVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from shop_reply_info where article = ? ";
			sql += "order by reg_date desc ";
			sql += "limit ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.setInt(2, replyStartRow);
			pstmt.setInt(3, replyPageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReplyVo replyVo = new ReplyVo();
				replyVo.setNum(rs.getInt("num"));
				replyVo.setId(rs.getString("id"));
				replyVo.setImage(rs.getString("image"));
				replyVo.setUploadpath(rs.getString("uploadpath"));
				replyVo.setArticle(rs.getString("article"));
				replyVo.setContent(rs.getString("content"));
				replyVo.setGrade(rs.getString("grade"));
				replyVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(replyVo);
			}
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}
	
	public List<ReplyVo> getReplyesByArticle(String article) {
		List<ReplyVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from shop_reply_info where article = ? ";
			sql += "order by reg_date desc ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReplyVo replyVo = new ReplyVo();
				replyVo.setNum(rs.getInt("num"));
				replyVo.setId(rs.getString("id"));
				replyVo.setImage(rs.getString("image"));
				replyVo.setUploadpath(rs.getString("uploadpath"));
				replyVo.setArticle(rs.getString("article"));
				replyVo.setContent(rs.getString("content"));
				replyVo.setGrade(rs.getString("grade"));
				replyVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(replyVo);
			}
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}
	
	public ReplyVo getReplyInfoByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ReplyVo replyVo = new ReplyVo();
		
		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from shop_reply_info where num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				replyVo.setNum(rs.getInt("num"));
				replyVo.setId(rs.getString("id"));
				replyVo.setImage(rs.getString("image"));
				replyVo.setUploadpath(rs.getString("uploadpath"));
				replyVo.setArticle(rs.getString("article"));
				replyVo.setContent(rs.getString("content"));
				replyVo.setGrade(rs.getString("grade"));
				replyVo.setReg_date(rs.getTimestamp("reg_date"));

			}
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return replyVo;
	}
	
	public int getCountByArticle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "select count(*) from shop_reply_info where article = ?";

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
	
	public void updateReplyInfo(ReplyVo replyVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "update shop_reply_info ";
			sql += "SET id = ? ";
			sql += ", image = ? ";
			sql += ", uploadpath = ? ";
			sql += ", article = ? ";
			sql += ", content = ? ";
			sql += ", grade = ? ";
			sql += "where num = ? ";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, replyVo.getId());
			pstmt.setString(2, replyVo.getImage());
			pstmt.setString(3, replyVo.getUploadpath());
			pstmt.setString(4, replyVo.getArticle());
			pstmt.setString(5, replyVo.getContent().replaceAll("\n", "<br>"));
			pstmt.setString(6, replyVo.getGrade());
			pstmt.setInt(7, replyVo.getNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public void deleteReplyInfoByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "delete from shop_reply_info ";
			sql += "where num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
}

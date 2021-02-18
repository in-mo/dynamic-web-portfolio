package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.AttachVo;

public class AttachDao {

	private static AttachDao instance = new AttachDao();

	public static AttachDao getInstance() {
		return instance;
	}

	private AttachDao() {
	}

	// 게시물 이미지 추가
	public void addImage(AttachVo attachVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "insert into shopimage (image, uploadpath, reg_article) ";
			sql += "values(?, ?, ?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, attachVo.getImage());
			pstmt.setString(2, attachVo.getUploadpath());
			pstmt.setString(3, attachVo.getReg_article());

			pstmt.executeUpdate();

		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	// 모든 게시물 이미지 정보 가져오기
	public List<AttachVo> getAttaches() {
		List<AttachVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from shopimage order by num desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttachVo attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));
				
				list.add(attachVo);
			}
		}
		
		catch (Exception e){
			e.printStackTrace();
		} 
		
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	// 특정 게시물 이미지 정보 가져오기
	public List<AttachVo> getAttachesByArticle(String article) {
		List<AttachVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from shopimage where reg_article = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttachVo attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));
				
				list.add(attachVo);
			}
		}
		
		catch (Exception e){
			e.printStackTrace();
		} 
		
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	// 페이지별로 이미지 가져오기
	public List<AttachVo> getAttachesByPage(int startRow, int pageSize) {
		List<AttachVo> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from shopimage ";
			sql += "group by reg_article ";
			sql += "ORDER BY num desc ";
			sql += "LIMIT ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize*2);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttachVo attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));
				
				list.add(attachVo);
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public AttachVo getAttachByNum(int num) {
		AttachVo attachVo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from shopimage where num = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));
			}
		}
		
		catch (Exception e){
			e.printStackTrace();
		} 
		
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return attachVo;
	}
//	
	public void deleteAttachByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "delete from shopimage where num = ? ";

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
}
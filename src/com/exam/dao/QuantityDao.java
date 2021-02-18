package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.AttachVo;
import com.exam.vo.QuantityVo;

public class QuantityDao {

	private static QuantityDao instance = new QuantityDao();

	public static QuantityDao getInstance() {
		return instance;
	}

	private QuantityDao() {
	}

	// 게시물 수량 추가
	public void addQuantity(QuantityVo quantityVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "insert into productquantity (size, red, orange, ";
			sql += "yellow, green, blue, reg_article)";
			sql += "values(?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, quantityVo.getSize());
			pstmt.setInt(2, quantityVo.getRed());
			pstmt.setInt(3, quantityVo.getOrange());
			pstmt.setInt(4, quantityVo.getYellow());
			pstmt.setInt(5, quantityVo.getGreen());
			pstmt.setInt(6, quantityVo.getBlue());
			pstmt.setString(7, quantityVo.getReg_article());

			pstmt.executeUpdate();

		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}

	// 특정 게시물 수량 가져오기
	public List<QuantityVo> getQuantityByArticle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<QuantityVo> list = new ArrayList<>();

		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from productquantity where reg_article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QuantityVo quantityVo = new QuantityVo();
				quantityVo.setNum(rs.getInt("num"));
				quantityVo.setSize(rs.getString("size"));
				quantityVo.setRed(rs.getInt("red"));
				quantityVo.setOrange(rs.getInt("orange"));
				quantityVo.setYellow(rs.getInt("yellow"));
				quantityVo.setGreen(rs.getInt("green"));
				quantityVo.setBlue(rs.getInt("blue"));
				quantityVo.setReg_article(rs.getString("reg_article"));

				list.add(quantityVo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}

	public int getQuantityByProductInfo(String article, String size, String color) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;

		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select " + color + " from productquantity where reg_article = ? and size = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.setString(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				count = rs.getInt(color);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return count;
	}
	
	public QuantityVo getQuantitByArticleNSize(String article, String size) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		QuantityVo quantityVo = new QuantityVo();

		String sql = "";

		try {
			con = ConnectDB.getConnection();
			sql = "select * from productquantity where reg_article = ? and size = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.setString(2, size);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				quantityVo.setNum(rs.getInt("num"));
				quantityVo.setSize(rs.getString("size"));
				quantityVo.setRed(rs.getInt("red"));
				quantityVo.setOrange(rs.getInt("orange"));
				quantityVo.setYellow(rs.getInt("yellow"));
				quantityVo.setGreen(rs.getInt("green"));
				quantityVo.setBlue(rs.getInt("blue"));
				quantityVo.setReg_article(rs.getString("reg_article"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return quantityVo;
	}
	
	public void updateQuantityInfo(QuantityVo quantityVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";
		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE productquantity ";
			sql += "set red = ? ";
			sql += ", orange = ? ";
			sql += ", yellow = ? ";
			sql += ", green = ? ";
			sql += ", blue = ? ";
			sql += ", reg_article = ? ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, quantityVo.getRed());
			pstmt.setInt(2, quantityVo.getOrange());
			pstmt.setInt(3, quantityVo.getYellow());
			pstmt.setInt(4, quantityVo.getGreen());
			pstmt.setInt(5, quantityVo.getBlue());
			pstmt.setString(6, quantityVo.getReg_article());
			pstmt.setInt(7, quantityVo.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

//	public List<AttachVo> getAttachesByNoNum(int NoNum) {
//		List<AttachVo> list = new ArrayList<>();
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		
//		try {
//			con = ConnectDB.getConnection();
//			sql = "select * from attach where no_num = ? ";
//			
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, NoNum);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				AttachVo attachVo = new AttachVo();
//				attachVo.setNum(rs.getInt("num"));
//				attachVo.setFilename(rs.getString("filename"));
//				attachVo.setUploadpath(rs.getString("uploadpath"));
//				attachVo.setImage(rs.getString("image"));
//				attachVo.setNum(rs.getInt("no_num"));
//				
//				list.add(attachVo);
//			}
//		}
//		
//		catch (Exception e){
//			e.printStackTrace();
//		} 
//		
//		finally {
//			ConnectDB.close(con, pstmt, rs);
//		}
//		
//		return list;
//	}
//	
//	public void deleteAttachesByNoNum(int noNum) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		String sql = "";
//
//		try {
//			con = ConnectDB.getConnection();
//
//			sql = "delete from attach where no_num = ? ";
//
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, noNum);
//
//			pstmt.executeUpdate();
//		}
//
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		finally {
//			ConnectDB.close(con, pstmt);
//		}
//	}
}
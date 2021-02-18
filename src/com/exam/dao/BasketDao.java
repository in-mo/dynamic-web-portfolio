package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.BasketVo;

public class BasketDao {

	private static BasketDao instance = new BasketDao();

	public static BasketDao getInstance() {
		return instance;
	}

	private BasketDao() {
	}

	public void addBasket(BasketVo basketVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();

			sql = "insert into shopbasket (id, size, color, quantity, article, reg_date) ";
			sql += "values(?, ?, ?, ?, ?, now()) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, basketVo.getId());
			pstmt.setString(2, basketVo.getSize());
			pstmt.setString(3, basketVo.getColor());
			pstmt.setInt(4, basketVo.getQuantity());
			pstmt.setString(5, basketVo.getArticle());

			pstmt.executeUpdate();

		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public List<BasketVo> getBasketById(String id){
		List<BasketVo> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT * FROM shopbasket where id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BasketVo basketVo = new BasketVo();
				basketVo.setNum(rs.getInt("num"));
				basketVo.setId(rs.getString("id"));
				basketVo.setSize(rs.getString("size"));
				basketVo.setColor(rs.getString("color"));
				basketVo.setQuantity(rs.getInt("quantity"));
				basketVo.setArticle(rs.getString("article"));
				basketVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(basketVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return list;
	}
	
	public List<BasketVo> getBasketInfoByArticle(String article){
		List<BasketVo> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT * FROM shopbasket where article = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BasketVo basketVo = new BasketVo();
				basketVo.setNum(rs.getInt("num"));
				basketVo.setId(rs.getString("id"));
				basketVo.setSize(rs.getString("size"));
				basketVo.setColor(rs.getString("color"));
				basketVo.setQuantity(rs.getInt("quantity"));
				basketVo.setArticle(rs.getString("article"));
				basketVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(basketVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return list;
	}
	
	public void updateBasketInfo(BasketVo basketVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();

			sql = "update shopbasket set quantity = ? where id = ? ";
			sql += "and size = ? and color = ? and article = ?  ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, basketVo.getQuantity());
			pstmt.setString(2, basketVo.getId());
			pstmt.setString(3, basketVo.getSize());
			pstmt.setString(4, basketVo.getColor());
			pstmt.setString(5, basketVo.getArticle());
			
			pstmt.executeUpdate();

		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	public void deleteBasketInfoByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "DELETE FROM shopbasket ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			int count = pstmt.executeUpdate();
			System.out.println(count + "개 행이 삭제됨.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public void deleteBasketInfo(BasketVo basketVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "DELETE FROM shopbasket ";
			sql += "WHERE id = ? ";
			sql += "and size = ? ";
			sql += "and color = ? ";
			sql += "and article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, basketVo.getId());
			pstmt.setString(2, basketVo.getSize());
			pstmt.setString(3, basketVo.getColor());
			pstmt.setString(4, basketVo.getArticle());

			int count = pstmt.executeUpdate();
			System.out.println(count + "개 행이 삭제됨.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
}

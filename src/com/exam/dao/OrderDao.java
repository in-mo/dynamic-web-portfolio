package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.exam.vo.AttachVo;
import com.exam.vo.OrderVo;

public class OrderDao {

	private static OrderDao instance = new OrderDao();

	public static OrderDao getInstance() {
		return instance;
	}

	private OrderDao() {
	}

	// 주문내역 추가
	public void addOrder(OrderVo orderVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "insert into orderlist (article, id, size, color, quantity, price, name, ";
			sql += "age, gender, tel, absence_msg, address, delivery, expect_date, order_date) ";
			sql += "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now()) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderVo.getArticle());
			pstmt.setString(2, orderVo.getId());
			pstmt.setString(3, orderVo.getSize());
			pstmt.setString(4, orderVo.getColor());
			pstmt.setInt(5, orderVo.getQuantity());
			pstmt.setInt(6, orderVo.getPrice());
			pstmt.setString(7, orderVo.getName());
			pstmt.setInt(8, orderVo.getAge());
			pstmt.setString(9, orderVo.getGender());
			pstmt.setString(10, orderVo.getTel());
			pstmt.setString(11, orderVo.getAbsence_msg());
			pstmt.setString(12, orderVo.getAddress());
			pstmt.setString(13, orderVo.getDelivery());
			pstmt.setString(14, orderVo.getExpect_date());

			pstmt.executeUpdate();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public List<OrderVo> getOrderListById(String id){
		List<OrderVo> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from orderlist where id = ? order by order_date desc";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderVo orderVo = new OrderVo();
				orderVo.setOrder_num(rs.getInt("order_num"));
				orderVo.setArticle(rs.getString("article"));
				orderVo.setId(rs.getString("id"));
				orderVo.setSize(rs.getString("size"));
				orderVo.setColor(rs.getString("color"));
				orderVo.setQuantity(rs.getInt("quantity"));
				orderVo.setPrice(rs.getInt("price"));
				orderVo.setName(rs.getString("name"));
				orderVo.setAge(rs.getInt("age"));
				orderVo.setGender(rs.getString("gender"));
				orderVo.setTel(rs.getString("tel"));
				orderVo.setAbsence_msg(rs.getString("absence_msg"));
				orderVo.setAddress(rs.getString("address"));
				orderVo.setDelivery(rs.getString("delivery"));
				orderVo.setExpect_date(rs.getString("expect_date"));
				orderVo.setOrder_date(rs.getTimestamp("order_date"));
				
				list.add(orderVo);
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
			
		return list;
	}
	
	public OrderVo getOrderItemByOrderNum(int order_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		OrderVo orderVo = new OrderVo();
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from orderlist where order_num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				orderVo.setOrder_num(rs.getInt("order_num"));
				orderVo.setArticle(rs.getString("article"));
				orderVo.setId(rs.getString("id"));
				orderVo.setSize(rs.getString("size"));
				orderVo.setColor(rs.getString("color"));
				orderVo.setQuantity(rs.getInt("quantity"));
				orderVo.setPrice(rs.getInt("price"));
				orderVo.setName(rs.getString("name"));
				orderVo.setAge(rs.getInt("age"));
				orderVo.setGender(rs.getString("gender"));
				orderVo.setTel(rs.getString("tel"));
				orderVo.setAbsence_msg(rs.getString("absence_msg"));
				orderVo.setAddress(rs.getString("address"));
				orderVo.setDelivery(rs.getString("delivery"));
				orderVo.setExpect_date(rs.getString("expect_date"));
				orderVo.setOrder_date(rs.getTimestamp("order_date"));
				
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
			
		
		return orderVo;
	}
	
	public int[] getGenderCount(String article) {
		int[] count = new int[2];
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select  (select count(gender) from orderlist  ";
			sql +="				where gender= 'man' and article = ? ) mcount, ";
			sql +="			(select count(gender) from orderlist ";
			sql +="				where gender= 'woman' and article = ? ) wcount ";
			sql +="from dual;";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.setString(2, article);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count[0] = rs.getInt("mcount");
				count[1] = rs.getInt("wcount");
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return count;
	}
	
	public List<OrderVo> getOrderListByArticle(String article){
		List<OrderVo> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select * from orderlist where article = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderVo orderVo = new OrderVo();
				orderVo.setOrder_num(rs.getInt("order_num"));
				orderVo.setArticle(rs.getString("article"));
				orderVo.setId(rs.getString("id"));
				orderVo.setSize(rs.getString("size"));
				orderVo.setColor(rs.getString("color"));
				orderVo.setQuantity(rs.getInt("quantity"));
				orderVo.setPrice(rs.getInt("price"));
				orderVo.setName(rs.getString("name"));
				orderVo.setAge(rs.getInt("age"));
				orderVo.setGender(rs.getString("gender"));
				orderVo.setTel(rs.getString("tel"));
				orderVo.setAbsence_msg(rs.getString("absence_msg"));
				orderVo.setAddress(rs.getString("address"));
				orderVo.setDelivery(rs.getString("delivery"));
				orderVo.setExpect_date(rs.getString("expect_date"));
				orderVo.setOrder_date(rs.getTimestamp("order_date"));
				
				list.add(orderVo);
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
			
		return list;
	}
	
	public List<Map<String, Object>> getOrderAgeRangePerCount(String article){
		List<Map<String, Object>> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "select case ";
			sql += "when age between 10 and 19 then '10대' ";
			sql += "when age between 20 and 29 then '20대' ";
			sql += "when age between 30 and 39 then '30대' ";
			sql += "when age between 40 and 49 then '40대' ";
			sql += "when age >= 50 then '50대 이상' ";
			sql += "when age < 10 or age is null then '기타' ";
			sql += "end as age_range, ";
			sql += "count(*) as cnt  ";
			sql += "from orderlist where article = ? group by age_range ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> mapList = new HashMap<String, Object>();
				mapList.put("age_range", rs.getString(1));
				mapList.put("cnt", rs.getInt(2));
				
				list.add(mapList);
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public List<Map<String, Object>> genderPerCount(String article){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			con = ConnectDB.getConnection();
			sql = "SELECT gender, count(*) as cnt ";
			sql += "	FROM jspdb.orderlist ";
			sql += "where article = ? ";
			sql += "	group by gender";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> mapList = new HashMap<String, Object>();
				mapList.put("gender", rs.getString(1));
				mapList.put("cnt", rs.getInt(2));
				
				list.add(mapList);
			}
		}catch (Exception e){
			e.printStackTrace();
		} 
		finally {
			ConnectDB.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public void updateOrderInfo(OrderVo orderVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql ="";
		
		try {
			con = ConnectDB.getConnection();
			
			sql = "update orderlist ";
			sql += "set article = ? ";
			sql += ", id = ? ";
			sql += ", size = ? ";
			sql += ", color = ? ";
			sql += ", quantity = ? ";
			sql += ", price = ? ";
			sql += ", name = ? ";
			sql += ", age = ? ";
			sql += ", gender = ? ";
			sql += ", tel = ? ";
			sql += ", absence_msg = ? ";
			sql += ", address = ? ";
			sql += ", delivery = ? ";
			sql += ", expect_date = ? ";
			sql += "where order_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderVo.getArticle());
			pstmt.setString(2, orderVo.getId());
			pstmt.setString(3, orderVo.getSize());
			pstmt.setString(4, orderVo.getColor());
			pstmt.setInt(5, orderVo.getQuantity());
			pstmt.setInt(6, orderVo.getPrice());
			pstmt.setString(7, orderVo.getName());
			pstmt.setInt(8, orderVo.getAge());
			pstmt.setString(9, orderVo.getGender());
			pstmt.setString(10, orderVo.getTel());
			pstmt.setString(11, orderVo.getAbsence_msg());
			pstmt.setString(12, orderVo.getAddress());
			pstmt.setString(13, orderVo.getDelivery());
			pstmt.setString(14, orderVo.getExpect_date());
			pstmt.setInt(15, orderVo.getOrder_num());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	public void deleteAttachByNum(int order_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "delete from orderlist where order_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order_num);

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
//	public List<AttachVo> getAttaches() {
//		List<AttachVo> list = new ArrayList<>();
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		
//		try {
//			con = ConnectDB.getConnection();
//			sql = "select * from shopimage order by num desc";
//			
//			pstmt = con.prepareStatement(sql);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				AttachVo attachVo = new AttachVo();
//				attachVo.setNum(rs.getInt("num"));
//				attachVo.setImage(rs.getString("image"));
//				attachVo.setUploadpath(rs.getString("uploadpath"));
//				attachVo.setReg_article(rs.getString("reg_article"));
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
//	// 특정 게시물 이미지 정보 가져오기
//	public List<AttachVo> getAttachesByArticle(String article) {
//		List<AttachVo> list = new ArrayList<>();
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		
//		try {
//			con = ConnectDB.getConnection();
//			sql = "select * from shopimage where reg_article = ? ";
//			
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, article);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				AttachVo attachVo = new AttachVo();
//				attachVo.setNum(rs.getInt("num"));
//				attachVo.setImage(rs.getString("image"));
//				attachVo.setUploadpath(rs.getString("uploadpath"));
//				attachVo.setReg_article(rs.getString("reg_article"));
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
//	public AttachVo getAttachByNum(int num) {
//		AttachVo attachVo = null;
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		
//		try {
//			con = ConnectDB.getConnection();
//			sql = "select * from shopimage where num = ? ";
//			
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, num);
//			
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				attachVo = new AttachVo();
//				attachVo.setNum(rs.getInt("num"));
//				attachVo.setImage(rs.getString("image"));
//				attachVo.setUploadpath(rs.getString("uploadpath"));
//				attachVo.setReg_article(rs.getString("reg_article"));
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
//		return attachVo;
//	}
//	
	public static void main(String[] args) {
		OrderDao orderDao = OrderDao.getInstance();
		
		 List<Map<String, Object>> list = orderDao.getOrderAgeRangePerCount("BR814014");
		 System.out.println(list);
	}
}
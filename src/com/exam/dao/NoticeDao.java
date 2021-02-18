package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.AttachVo;
import com.exam.vo.NoticeVo;

public class NoticeDao {
	// 싱글톤
	private static NoticeDao instance = new NoticeDao();

	public static NoticeDao getInstance() {
		return instance;
	}

	private NoticeDao() {
	}

	// 게시물 추가
	public void addProduct(NoticeVo noticeVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "INSERT INTO shopproduct (article, limitedSale, brand, product, ";
			sql += "gender, part, detail, price, sale, delivery, releasedate, weekend, ";
			sql += "readcount, salecount, likecount, grade, avg_age, reg_date) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now()) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, noticeVo.getArticle());
			pstmt.setString(2, noticeVo.getLimitedSale());
			pstmt.setString(3, noticeVo.getBrand());
			pstmt.setString(4, noticeVo.getProduct());
			pstmt.setString(5, noticeVo.getGender());
			pstmt.setString(6, noticeVo.getPart());
			pstmt.setString(7, noticeVo.getDetail());
			pstmt.setInt(8, noticeVo.getPrice());
			pstmt.setInt(9, noticeVo.getSale());
			pstmt.setString(10, noticeVo.getDelivery());
			pstmt.setFloat(11, noticeVo.getReleasedate());
			pstmt.setString(12, noticeVo.getWeekend());
			pstmt.setInt(13, noticeVo.getReadcount());
			pstmt.setInt(14, noticeVo.getSalecount());
			pstmt.setInt(15, noticeVo.getLikecount());
			pstmt.setFloat(16, noticeVo.getGrade());
			pstmt.setFloat(17, noticeVo.getAvg_age());

			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	// 특정 게시물 정보 가져오기
	public NoticeVo getProductByArticle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		NoticeVo noticeVo = null;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "SELECT * FROM shopproduct WHERE article = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticeVo = new NoticeVo();

				noticeVo.setArticle(rs.getString("article"));
				noticeVo.setLimitedSale(rs.getString("limitedSale"));
				noticeVo.setBrand(rs.getString("brand"));
				noticeVo.setProduct(rs.getString("product"));
				noticeVo.setGender(rs.getString("gender"));
				noticeVo.setPart(rs.getString("part"));
				noticeVo.setDetail(rs.getString("detail"));
				noticeVo.setPrice(rs.getInt("price"));
				noticeVo.setSale(rs.getInt("sale"));
				noticeVo.setDelivery(rs.getString("delivery"));
				noticeVo.setReleasedate(rs.getFloat("releasedate"));
				noticeVo.setWeekend(rs.getString("weekend"));
				noticeVo.setReadcount(rs.getInt("readcount"));
				noticeVo.setSalecount(rs.getInt("salecount"));
				noticeVo.setLikecount(rs.getInt("likecount"));
				noticeVo.setGrade(rs.getFloat("grade"));
				noticeVo.setAvg_age(rs.getFloat("avg_age"));
				noticeVo.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return noticeVo;
	}

	// 세부 부위로 게시물 가져오기
	public List<NoticeVo> getProductByDetail(String detail, int startRow, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<NoticeVo> list = new ArrayList<NoticeVo>();

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "select p.article, p.limitedSale, p.brand, p.product, p.gender, p.part, ";
			sql += "	p.detail, p.price, p.sale, p.delivery, p.releasedate, p.weekend, ";
			sql += "	p.readcount, p.salecount, p.likecount, p.grade, p.avg_age, p.reg_date, ";
			sql += "	i.num, i.image, i.uploadpath, i.reg_article ";
			sql += "from shopproduct p left outer join shopimage i ";
			sql += "	on p.article = i.reg_article ";
			sql += "WHERE p.detail = ? ";
			sql += "group by reg_article order by num desc ";
			sql += "limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, detail);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeVo noticeVo = new NoticeVo();
				noticeVo.setArticle(rs.getString("article"));
				noticeVo.setLimitedSale(rs.getString("limitedSale"));
				noticeVo.setBrand(rs.getString("brand"));
				noticeVo.setProduct(rs.getString("product"));
				noticeVo.setGender(rs.getString("gender"));
				noticeVo.setPart(rs.getString("part"));
				noticeVo.setDetail(rs.getString("detail"));
				noticeVo.setPrice(rs.getInt("price"));
				noticeVo.setSale(rs.getInt("sale"));
				noticeVo.setDelivery(rs.getString("delivery"));
				noticeVo.setReleasedate(rs.getFloat("releasedate"));
				noticeVo.setWeekend(rs.getString("weekend"));
				noticeVo.setReadcount(rs.getInt("readcount"));
				noticeVo.setSalecount(rs.getInt("salecount"));
				noticeVo.setLikecount(rs.getInt("likecount"));
				noticeVo.setGrade(rs.getFloat("grade"));
				noticeVo.setAvg_age(rs.getFloat("avg_age"));
				noticeVo.setReg_date(rs.getTimestamp("reg_date"));

				AttachVo attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));

				noticeVo.setAttachVo(attachVo);

				list.add(noticeVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}

	// 게시물 조회수 갱신
	public void updateReadcount(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE shopproduct ";
			sql += "SET readcount = readcount + 1 ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
	
	// 좋아요 갱신
	public void updateLikecount(String article, int likecount) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE shopproduct ";
			sql += "SET likecount = likecount + ? ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, likecount);
			pstmt.setString(2, article);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	// 판매수 갱신
	public void updateSalecount(String article, int quantity) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE shopproduct ";
			sql += "SET salecount = salecount + ? ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setString(2, article);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public void updateAvgAge(String article, float avg_age) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE shopproduct ";
			sql += "SET avg_age = ? ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setFloat(1, avg_age);
			pstmt.setString(2, article);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

//
	// 전체글갯수 가져오기
	public int getCountAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "select count(*) from shopproduct;";

			pstmt = con.prepareStatement(sql);
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

	// 검색어어 대한 게시물 갯수
	public int getCountBySearch(String category, String search, String detail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "SELECT COUNT(*) FROM shopproduct ";

			// 동적 sql 구현
			if (category.equals("상품명")) {
				sql += "WHERE product LIKE CONCAT('%', ?, '%') ";
			} else if (category.equals("브랜드")) {
				sql += "WHERE brand LIKE CONCAT('%', ?, '%') ";
			} else if (!detail.equals("")) {
				sql += "WHERE detail = ? ";
			}

			pstmt = con.prepareStatement(sql);

			if (!category.equals("")) { // 검색어가 있을때
				pstmt.setString(1, search); // 물음표에 검색어 설정
			} else if (!detail.equals("")) {
				pstmt.setString(1, detail);
			}

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
	} // getCountBySearch()

	public List<NoticeVo> getProducts() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<NoticeVo> list = new ArrayList<>();

		try {
			con = ConnectDB.getConnection();
			String sql = "select * ";
			sql += "from shopproduct ";
			sql += "order by reg_date desc ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeVo noticeVo = new NoticeVo();
				noticeVo.setArticle(rs.getString("article"));
				noticeVo.setLimitedSale(rs.getString("limitedSale"));
				noticeVo.setBrand(rs.getString("brand"));
				noticeVo.setProduct(rs.getString("product"));
				noticeVo.setGender(rs.getString("gender"));
				noticeVo.setPart(rs.getString("part"));
				noticeVo.setDetail(rs.getString("detail"));
				noticeVo.setPrice(rs.getInt("price"));
				noticeVo.setSale(rs.getInt("sale"));
				noticeVo.setDelivery(rs.getString("delivery"));
				noticeVo.setReleasedate(rs.getFloat("releasedate"));
				noticeVo.setWeekend(rs.getString("weekend"));
				noticeVo.setReadcount(rs.getInt("readcount"));
				noticeVo.setSalecount(rs.getInt("salecount"));
				noticeVo.setLikecount(rs.getInt("likecount"));
				noticeVo.setGrade(rs.getFloat("grade"));
				noticeVo.setAvg_age(rs.getFloat("avg_age"));
				noticeVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(noticeVo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}

	public List<String> getProductsByCmd(String cmd, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<String> list = new ArrayList<>();
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "SELECT * ";
			sql += "FROM shopproduct ";
			if (type.equals("상품명"))
				sql += "where product like concat('%', ?, '%')";
			else if (type.equals("브랜드"))
				sql += "where brand like concat('%', ?, '%') ";
			sql += "ORDER BY reg_date desc ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cmd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (type.equals("상품명")) 
					list.add(rs.getString("product"));
				
				else if (type.equals("브랜드")) 
					list.add(rs.getString("brand"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return list;
	}

	// 페이지별로 게시물 가져오기
	public List<NoticeVo> getProductsByPage(int startRow, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<NoticeVo> list = new ArrayList<>();
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "SELECT * ";
			sql += "FROM shopproduct ";
			sql += "ORDER BY reg_date desc ";
			sql += "LIMIT ?, ? ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeVo noticeVo = new NoticeVo();
				noticeVo.setArticle(rs.getString("article"));
				noticeVo.setLimitedSale(rs.getString("limitedSale"));
				noticeVo.setBrand(rs.getString("brand"));
				noticeVo.setProduct(rs.getString("product"));
				noticeVo.setGender(rs.getString("gender"));
				noticeVo.setPart(rs.getString("part"));
				noticeVo.setDetail(rs.getString("detail"));
				noticeVo.setPrice(rs.getInt("price"));
				noticeVo.setSale(rs.getInt("sale"));
				noticeVo.setDelivery(rs.getString("delivery"));
				noticeVo.setReleasedate(rs.getFloat("releasedate"));
				noticeVo.setWeekend(rs.getString("weekend"));
				noticeVo.setReadcount(rs.getInt("readcount"));
				noticeVo.setSalecount(rs.getInt("salecount"));
				noticeVo.setLikecount(rs.getInt("likecount"));
				noticeVo.setGrade(rs.getFloat("grade"));
				noticeVo.setAvg_age(rs.getFloat("avg_age"));
				noticeVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(noticeVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return list;
	} // getNoticesBySearch()

	public List<NoticeVo> getProductsBySearch(int startRow, int pageSize, String category, String search,
			String detail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<NoticeVo> list = new ArrayList<>();
		String sql = "";

		try {
			con = ConnectDB.getConnection();

			sql = "select p.article, p.limitedSale, p.brand, p.product, p.gender, p.part, ";
			sql += "	p.detail, p.price, p.sale, p.delivery, p.releasedate, p.weekend, ";
			sql += "	p.readcount, p.salecount, p.likecount, p.grade, p.avg_age, p.reg_date, ";
			sql += "	i.num, i.image, i.uploadpath, i.reg_article ";
			sql += "from shopproduct p left outer join shopimage i ";
			sql += "	on p.article = i.reg_article ";
			// 동적 sql 구현
			if (!search.equals("")) {
				if (category.equals("상품명")) {
					sql += "WHERE p.product LIKE CONCAT('%', ?, '%') ";
				} else if (category.equals("브랜드")) {
					sql += "WHERE p.brand LIKE CONCAT('%', ?, '%') ";
				}
			} else if (!detail.equals("")) {
				sql += "where p.detail = ? ";
			}
			sql += "group by reg_article order by num desc ";
			sql += "LIMIT ?, ? ";

			pstmt = con.prepareStatement(sql);

			if (!search.equals("")) { // 검색어가 있을때
				pstmt.setString(1, search); // 물음표에 검색어 설정
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
			} else if (!detail.equals("")) {
				pstmt.setString(1, detail); // 특정 목록 설정
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
			} else { // 검색어가 없을때
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeVo noticeVo = new NoticeVo();
				noticeVo.setArticle(rs.getString("article"));
				noticeVo.setLimitedSale(rs.getString("limitedSale"));
				noticeVo.setBrand(rs.getString("brand"));
				noticeVo.setProduct(rs.getString("product"));
				noticeVo.setGender(rs.getString("gender"));
				noticeVo.setPart(rs.getString("part"));
				noticeVo.setDetail(rs.getString("detail"));
				noticeVo.setPrice(rs.getInt("price"));
				noticeVo.setSale(rs.getInt("sale"));
				noticeVo.setDelivery(rs.getString("delivery"));
				noticeVo.setReleasedate(rs.getFloat("releasedate"));
				noticeVo.setWeekend(rs.getString("weekend"));
				noticeVo.setReadcount(rs.getInt("readcount"));
				noticeVo.setSalecount(rs.getInt("salecount"));
				noticeVo.setLikecount(rs.getInt("likecount"));
				noticeVo.setGrade(rs.getFloat("grade"));
				noticeVo.setAvg_age(rs.getFloat("avg_age"));
				noticeVo.setReg_date(rs.getTimestamp("reg_date"));

				AttachVo attachVo = new AttachVo();
				attachVo.setNum(rs.getInt("num"));
				attachVo.setImage(rs.getString("image"));
				attachVo.setUploadpath(rs.getString("uploadpath"));
				attachVo.setReg_article(rs.getString("reg_article"));

				noticeVo.setAttachVo(attachVo);

				list.add(noticeVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return list;
	}

	public void updateNoticeData(NoticeVo noticeVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";
		try {
			con = ConnectDB.getConnection();

			sql = "UPDATE shopproduct ";
			sql += "set limitedSale = ? ";
			sql += ", brand = ? ";
			sql += ", product = ? ";
			sql += ", gender = ? ";
			sql += ", part = ? ";
			sql += ", detail = ? ";
			sql += ", price = ? ";
			sql += ", sale = ? ";
			sql += ", delivery = ? ";
			sql += ", releasedate = ? ";
			sql += ", weekend = ? ";
			sql += ", grade = ? ";
			sql += ", avg_age = ? ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, noticeVo.getLimitedSale());
			pstmt.setString(2, noticeVo.getBrand());
			pstmt.setString(3, noticeVo.getProduct());
			pstmt.setString(4, noticeVo.getGender());
			pstmt.setString(5, noticeVo.getPart());
			pstmt.setString(6, noticeVo.getDetail());
			pstmt.setInt(7, noticeVo.getPrice());
			pstmt.setInt(8, noticeVo.getSale());
			pstmt.setString(9, noticeVo.getDelivery());
			pstmt.setFloat(10, noticeVo.getReleasedate());
			pstmt.setString(11, noticeVo.getWeekend());
			pstmt.setFloat(12, noticeVo.getGrade());
			pstmt.setFloat(13, noticeVo.getAvg_age());
			pstmt.setString(14, noticeVo.getArticle());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public void deleteContentByArticle(String article) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "";
		try {
			con = ConnectDB.getConnection();

			con.setAutoCommit(false); // 수동 commit으로 변경

			sql = "delete from shopproduct ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();

			pstmt.close();

			sql = "delete from shopimage ";
			sql += "WHERE reg_article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();

			pstmt.close();
			
			sql = "delete from productquantity ";
			sql += "WHERE reg_article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();
			
			pstmt.close();

			sql = "delete from shopbasket ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();

			pstmt.close();
			
			sql = "delete from like_table ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "delete from shop_reply_info ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "delete from qna_table ";
			sql += "WHERE article = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article);
			pstmt.executeUpdate();
			
			con.commit();

			con.setAutoCommit(true);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}
//
//	public void deleteAll() {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		String sql = "";
//		try {
//			con = ConnectDB.getConnection();
//
//			sql = "delete from notice";
//
//			pstmt = con.prepareStatement(sql);
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			ConnectDB.close(con, pstmt);
//		}
//	}
//
//	// 답글
//	public boolean updateAndAddReply(NoticeVo noticeVo) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		String sql = "";
//		try {
//			con = ConnectDB.getConnection();
//
//			con.setAutoCommit(false); // 수동 commit으로 변경
//
//			sql = "UPDATE notice ";
//			sql += "SET re_seq = re_seq + 1 ";
//			sql += "WHERE re_ref = ? "; // 같은 그룹
//			sql += "and re_seq > ? "; // 순번보다 큰 것
//
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, noticeVo.getReRef());
//			pstmt.setInt(2, noticeVo.getReSeq());
//			pstmt.executeUpdate(); // auto commit 기능 내포
//
//			// update문장을 가진 pstmt 객체 닫기
//			pstmt.close();
//
//			sql = "INSERT INTO notice (id, subject, content, readcount, reg_date, ip, re_ref, re_lev, re_seq) ";
//			sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";
//
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, noticeVo.getId());
//			pstmt.setString(2, noticeVo.getSubject());
//			pstmt.setString(3, noticeVo.getContent());
//			pstmt.setInt(4, noticeVo.getReadcount());
//			pstmt.setTimestamp(5, noticeVo.getRegDate());
//			pstmt.setString(6, noticeVo.getIp());
//			pstmt.setInt(7, noticeVo.getReRef()); // 같은 그룹
//			pstmt.setInt(8, noticeVo.getReLev() + 1); // 답글쓰는 대상글의 들여쓰기 +1
//			pstmt.setInt(9, noticeVo.getReSeq() + 1); // 답글쓰는 대상글의 스룹내 순번 +1
//
//			pstmt.executeUpdate(); // auto commit 기능 내포
//
//			con.commit();
//
//			con.setAutoCommit(true);
//
//			return true;
//		} catch (Exception e) {
//			e.printStackTrace();
//			try {
//				con.rollback(); // 단위작업에 문제가 생기면 롤백(전체취소)하기
//			} catch (SQLException e1) {
//				e1.printStackTrace();
//			}
//			return false;
//		} finally {
//			ConnectDB.close(con, pstmt);
//		}
//	}

//	public static void main(String[] args) {
//		NoticeDao noticeDao = new NoticeDao();
//		
//		noticeDao.deleteAll();
//		
//		for (int i = 1; i < 1000; i++) {
//			NoticeVo noticeVo = new NoticeVo();
//
//			noticeVo.setId("user1");
//			noticeVo.setSubject("글제목 " + i);
//			noticeVo.setContent("글내용" + i);
//			noticeVo.setReadcount(0);
//			noticeVo.setRegDate(new Timestamp(System.currentTimeMillis()));
//			noticeVo.setIp("127.0.0.1");
//			noticeVo.setReRef(ConnectDB.getNextNum("notice")); //
//			noticeVo.setReLev(0);
//			noticeVo.setReSeq(0);
//
//			System.out.println(noticeVo.toString());
//
//			noticeDao.addNotice(noticeVo);
//		}
//
//		int count = noticeDao.getCountAll();
//		System.out.println("count = " + count);
//	}
}

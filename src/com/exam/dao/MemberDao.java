
package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.MemberVo;

public class MemberDao {
	// 헤로쿠 MySQL DB
	// mysql://b1c1a47b282024:e5b6361f@us-cdbr-east-02.cleardb.com/heroku_c1ebe10c2664633?reconnect=true&useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul

	// DB ID - b1c1a47b282024
	// DB PASSWD - e5b6361f
	// Localhost - us-cdbr-east-02.cleardb.com
	// 스키마 - heroku_c1ebe10c2664633
	// 한국어 처리 설정 -
	// useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul

	private static MemberDao instance = new MemberDao();

	public static MemberDao getInstance() {
		return instance;
	}

	public void insertMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnectDB.getConnection();

			String sql = "INSERT INTO shopmember(id, password, name, age, gender, email, tel, postcode, address1, address2, reg_date) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())"; // now() -> current_timestamp()
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getId());
			pstmt.setString(2, memberVo.getPassword());
			pstmt.setString(3, memberVo.getName());
			pstmt.setInt(4, memberVo.getAge());
			pstmt.setString(5, memberVo.getGender());
			pstmt.setString(6, memberVo.getEmail());
			pstmt.setString(7, memberVo.getTel());
			pstmt.setString(8, memberVo.getPostcode());
			pstmt.setString(9, memberVo.getAddress1());
			pstmt.setString(10, memberVo.getAddress2());

			int count = pstmt.executeUpdate();
			System.out.println(count + "개 행이 추가됨.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public List<MemberVo> getMembers() {
		List<MemberVo> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT * FROM shopmember";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVo memberVo = new MemberVo();

				memberVo.setId(rs.getString("id"));
				memberVo.setPassword(rs.getString("password"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age")); // int 는 null 값 반환x
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setTel(rs.getString("tel"));
				memberVo.setPostcode(rs.getString("postcode"));
				memberVo.setAddress1(rs.getString("address1"));
				memberVo.setAddress2(rs.getString("address2"));
				memberVo.setReg_date(rs.getTimestamp("reg_date"));

				list.add(memberVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return list;
	}

	public MemberVo getMemberById(String id) {
		MemberVo memberVo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT * FROM shopmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberVo = new MemberVo();
				memberVo.setId(rs.getString("id"));
				memberVo.setPassword(rs.getString("password"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age")); // int 는 null 값 반환x
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setTel(rs.getString("tel"));
				memberVo.setPostcode(rs.getString("postcode"));
				memberVo.setAddress1(rs.getString("address1"));
				memberVo.setAddress2(rs.getString("address2"));
				memberVo.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return memberVo;
	}

	public int memberCheckById(String id, String password) {
		// -1 없는 아이디
		// 0 패스워드 틀림
		// 1 아이디, 패스워드 모두 일치
		int check = -1;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT password FROM shopmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 비밀번호가 일치할 때
				if (password.equals(rs.getString("password")))
					check = 1;
				// 비밀번호가 일치하지 않을 때
				else
					check = 0;
			}
			// 모두 일치하지 않을 때
			else
				check = -1;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return check;
	}

	public void updateMemberById(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "UPDATE shopmember ";
			sql += "SET password = ? ";
			sql += ", name = ? ";
			sql += ", age = ? ";
			sql += ", gender = ? ";
			sql += ", email = ? ";
			sql += ", tel = ? ";
			sql += ", postcode = ? ";
			sql += ", address1 = ? ";
			sql += ", address2 = ? ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getPassword());
			pstmt.setString(2, memberVo.getName());
			pstmt.setInt(3, memberVo.getAge());
			pstmt.setString(4, memberVo.getGender());
			pstmt.setString(5, memberVo.getEmail());
			pstmt.setString(6, memberVo.getTel());
			pstmt.setString(7, memberVo.getPostcode());
			pstmt.setString(8, memberVo.getAddress1());
			pstmt.setString(9, memberVo.getAddress2());
			pstmt.setString(10, memberVo.getId());

			int count = pstmt.executeUpdate();
			System.out.println(count + "개 행이 수정됨.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public void deleteMemberById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = ConnectDB.getConnection();

			con.setAutoCommit(false); // 수동 commit으로 변경
			
			sql = "DELETE FROM shopmember ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "DELETE FROM like_table ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			pstmt.close();

			sql = "DELETE FROM shop_reply_info ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "DELETE FROM orderlist ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "DELETE FROM shopbasket ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			sql = "DELETE FROM qna_table ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			con.commit();

			con.setAutoCommit(true);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public MemberVo searchUser(String id, String name, String tel) {
		MemberVo memberVo = new MemberVo();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();

			if (id.equals("")) {
				String sql = "SELECT * FROM shopmember where name = ? and tel = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, tel);

				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					memberVo.setId(rs.getString("id"));
					memberVo.setPassword(rs.getString("password"));
					memberVo.setName(rs.getString("name"));
					memberVo.setAge(rs.getInt("age")); // int 는 null 값 반환x
					memberVo.setGender(rs.getString("gender"));
					memberVo.setEmail(rs.getString("email"));
					memberVo.setTel(rs.getString("tel"));
					memberVo.setPostcode(rs.getString("postcode"));
					memberVo.setAddress1(rs.getString("address1"));
					memberVo.setAddress2(rs.getString("address2"));
					memberVo.setReg_date(rs.getTimestamp("reg_date"));
				}
			} else {
				String sql = "SELECT * FROM shopmember where id = ? and name = ? and tel = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, name);
				pstmt.setString(3, tel);

				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					memberVo.setId(rs.getString("id"));
					memberVo.setPassword(rs.getString("password"));
					memberVo.setName(rs.getString("name"));
					memberVo.setAge(rs.getInt("age")); // int 는 null 값 반환x
					memberVo.setGender(rs.getString("gender"));
					memberVo.setEmail(rs.getString("email"));
					memberVo.setTel(rs.getString("tel"));
					memberVo.setPostcode(rs.getString("postcode"));
					memberVo.setAddress1(rs.getString("address1"));
					memberVo.setAddress2(rs.getString("address2"));
					memberVo.setReg_date(rs.getTimestamp("reg_date"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}

		return memberVo;
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ConnectDB.getConnection();
			String sql = "delete FROM shopmember";

			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			System.out.println("데이터 삭제됨.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt);
		}
	}

	public int getCountById(String id) {
		// -1 없는 아이디
		// 0 패스워드 틀림
		// 1 아이디, 패스워드 모두 일치
		int check = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();

			String sql = "SELECT count(*) FROM shopmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next())
				check = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectDB.close(con, pstmt, rs);
		}
		return check;
	}

	public static void main(String[] args) {
		MemberDao memberDao = new MemberDao();

		// 회원정보 1명 insert 하기
//		MemberVo memberVo = new MemberVo("3", "3", "3", 18, "F", "3@naver.com");
//		memberDao.insertMember(memberVo);
//		System.out.println(memberVo);

//		System.out.println("////////////////////////////////////////");

		// 전체 회원 목록 가져오기
		List<MemberVo> list = memberDao.getMembers();
		for (MemberVo memberVo2 : list)
			System.out.println(memberVo2);

//		System.out.println("////////////////////////////////////////");

		// 특정 Id에 해당하는 회원 1명 가져오기
//		memberVo = memberDao.getMemberById("Sin");
//		System.out.println(memberVo);

//		System.out.println("////////////////////////////////////////");

		// 특정 ID에 해당하는 회원의 이름 수정하기
//		memberVo.setName("k");
//		memberDao.updateMemberById(memberVo);
//		System.out.println(memberVo);

//		System.out.println("////////////////////////////////////////");

		// 특정 ID에 해당하는 회원 1명 삭제하기
//		memberDao.deleteMemberById("Sin");

		// 모든 회원 삭제하기
//		memberDao.deleteAll();
	}
}
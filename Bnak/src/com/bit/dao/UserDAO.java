package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.bit.dto.BankBookNumberDTO;
import com.bit.dto.BankbookDTO;
import com.bit.dto.UserDTO;
import com.bit.util.DBConnecion;
import com.bit.util.DBConnectionMgr;


public class UserDAO {

	private DBConnectionMgr pool;
	
	public UserDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	//회원가입
	public int join(UserDTO user) {
		//sql문
		//Column count doesn't match value count at row 1 -> tbl과 valuse(..) 일치해야한다.
		String sql="INSERT INTO tbl_user VALUES (?, ?, ?, ?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//시간설정
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd-hh:mm");
		
		try {
			//db연결
			conn=DBConnecion.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, sdf.format(timestamp));
			return pstmt.executeUpdate();		//실제 영향받은 데이터 반환
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close(); } catch (Exception e) {e.printStackTrace();}
		}

		
		return -1;
	}
	
	//로그인
	public int login(String userID,String userPW) {
		String sql= "SELECT userPW FROM TBL_USER WHERE userID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DBConnecion.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPW)) {
					return 1;	//로그인 성공
				}
				else {return 0;}//비밀번호 오류
			}
			return -1;			//아이디x
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {if(conn!=null) conn.close(); } catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close(); } catch (Exception e) {e.printStackTrace();}
		}
		
		return -2;			//db오류
		
	}
public UserDTO getuser(String id) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		UserDTO user= new UserDTO();
		try {
			conn=pool.getConnection();
			//맨위에꺼를 계산을해서 맨밑에꺼로 계산하게 해야함
			String sql="SELECT * FROM tbl_user WHERE userID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//db연결
			if(rs.next()) {
				user.setUserID(rs.getString("userID"));
				user.setUserPW(rs.getString("userPW"));
				user.setUserName(rs.getString("userName"));
				user.setDate(rs.getString("date"));
				
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		} finally {pool.freeConnection(conn, pstmt, rs);}	//db종료
		
		return user;
	}
	
}

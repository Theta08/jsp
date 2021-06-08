package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.bit.dto.UserDTO;
import com.bit.util.DBConnecion;


public class UserDAO {

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
		SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		
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
}

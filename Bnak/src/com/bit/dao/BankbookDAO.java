package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.bit.dto.BankbookDTO;
import com.bit.dto.UserDTO;
import com.bit.util.DBConnecion;
import com.bit.util.DBConnectionMgr;


public class BankbookDAO {
	
	private DBConnectionMgr pool;
	
	public BankbookDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//DB연결 닫기
	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();												
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
	}
	
	//통장 만들기
	public int makeBankBook(BankbookDTO bankbook) {
		//sql문
		//Column count doesn't match value count at row 1 -> tbl과 valuse(..) 일치해야한다.
		String sql="INSERT INTO tbl_bank VALUES (?, ?, ?, ?, ?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//시간설정
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		
		try {
			//db연결
			conn=pool.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bankbook.getBnumber());
			pstmt.setString(2,bankbook.getBname() );
			pstmt.setInt(3,bankbook.getBpassword() );
			//외래키 userDTO_userid 가지고온다.
			//오류 값이 안읽어와짐
			pstmt.setString(4,bankbook.getUserID().getUserID());		
//			pstmt.setString(4,"a");
			pstmt.setString(5, sdf.format(timestamp));
			return pstmt.executeUpdate();		//실제 영향받은 데이터 반환
		}catch (Exception e) {
			e.printStackTrace();
		} finally {pool.freeConnection(conn, pstmt, rs);}	//db종료
		
		return -1;
	}
	
	//통장번호 확인 
	public BankbookDTO numberCheck(int number) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		ResultSet rs=null;
		BankbookDTO bankbook =new BankbookDTO();
		try {
			
			//db연결
			conn=pool.getConnection();
			String sql="select * from tbl_bank WHERE bnumber= ?;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			rs=pstmt.executeQuery();		//select
		
			
			
			if(rs.next()) {
				bankbook.setBnumber(rs.getInt("bnumber"));
				bankbook.setBname(rs.getString("bname"));
				bankbook.setBpassword(rs.getInt("bpassword"));
				
				UserDTO user=new UserDTO();
				user.setUserID(rs.getString("buserid"));
				bankbook.setUserID(user);
				
				bankbook.setBdate(rs.getString("bdate"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {pool.freeConnection(conn, pstmt, rs);}	//db종료
		
		return bankbook;
		
		
	}

}

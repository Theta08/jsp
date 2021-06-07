package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.bit.dto.BankbookDTO;
import com.bit.util.DBConnecion;


public class BankbookDAO {
	
	//싱글패턴? 게시판 리스트
	private static BankbookDAO instance;
	
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
		String sql="INSERT INTO tbl_bank VALUES (?, ?, ?, ?)";
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
			pstmt.setInt(1, bankbook.getBnumber());
			pstmt.setString(2,bankbook.getBname() );
			pstmt.setInt(3,bankbook.getBpassword() );
			pstmt.setString(4, sdf.format(timestamp));
			return pstmt.executeUpdate();		//실제 영향받은 데이터 반환
		}catch (Exception e) {
			e.printStackTrace();
		} finally {closeAll(rs,pstmt,conn);}
		
		return -1;
	}
	

}

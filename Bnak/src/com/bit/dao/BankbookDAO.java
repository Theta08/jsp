package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

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
	
	//?
	public int getListCount(String items, String text) {
		//items
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;
		
		if (items == null && text == null)
			sql = "select count(*) from tbl_bank";
		else
			sql = "SELECT count(*) FROM tbl_bank where " + items + " like '%" + text + "%'";
		
		try {//DB
			conn = DBConnecion.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() ����: " + ex);
		} finally {			
			closeAll(rs,pstmt,conn);	
		}		
		return x;
	} 
	
	//게시판
	public ArrayList<BankbookDTO> getlist(int page, int limit, String items, String text){
		String sql="select * from tbl_bank";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//
		int total_record = getListCount(items, text );
		int start = (page - 1) * limit;	//limit=5 
		int index = start + 1;
		
		ArrayList<BankbookDTO> list=new ArrayList<BankbookDTO>();
		try {
			//db연결
			conn=DBConnecion.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.absolute(index)) {
				BankbookDTO board = new BankbookDTO();
				board.setBnumber(rs.getInt("num"));
				board.setBname(rs.getString("id"));
				board.setBpassword(rs.getInt("password"));
				board.setBdate(rs.getString("bdate"));
				list.add(board);
				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return list;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {closeAll(rs,pstmt,conn);}
		
		return null;
		
	}

}

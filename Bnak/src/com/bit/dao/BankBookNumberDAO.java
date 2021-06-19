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


public class BankBookNumberDAO {
	
	private DBConnectionMgr pool;
	
	public BankBookNumberDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//입금
	public int insert_plus(BankBookNumberDTO bnumber) {
		//sql문
//		BankbookDTO bankbook, int bn_plus, int bn_minus, int bn_sum, String bn_commit,
//		String bn_date
		String sql="INSERT INTO tbl_bankbooknumber (bn_number, bn_plus, bn_minus, bn_sum, bn_commit, bn_date)"
				+ " VALUES (?, ?, ?, ?, ?, ?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		//시간설정
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd-hh");
		
		try {
			//db연결
			conn=pool.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bnumber.getBankbook().getBnumber());
			pstmt.setInt(2,bnumber.getBn_plus());
			pstmt.setInt(3,bnumber.getBn_minus());
			pstmt.setInt(4,bnumber.getBn_sum());
			pstmt.setString(5,bnumber.getBn_commit());
			pstmt.setString(6,sdf.format(timestamp));

			return pstmt.executeUpdate();		//실제 영향받은 데이터 반환
		}catch (Exception e) {
			e.printStackTrace();
		} finally {pool.freeConnection(conn, pstmt, rs);}	//db종료
		
		return -1;
	}
	//외래키를 받기위해 BankbookDTO bankbook를 쓴다.
	//메소드 쓰는 곳에서 자기가 쓰고싶은 값을 set으로 설정해야한다.
	public BankBookNumberDTO getBankBook(BankbookDTO bankbook) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		BankBookNumberDTO bBookNumber= new BankBookNumberDTO();
		try {
			conn=pool.getConnection();
			//맨위에꺼를 계산을해서 맨밑에꺼로 계산하게 해야함
			String sql="SELECT * FROM tbl_bankbooknumber WHERE bn_number=? ORDER BY bn_idx DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bankbook.getBnumber());
			rs = pstmt.executeQuery();
			
			//db연결
			if(rs.next()) {
				//오류
//				bBookNumber.setBankbook(bm.setBnumber(rs.getInt("bm")));
				BankbookDTO bm=new BankbookDTO();
				bm.setBnumber(rs.getInt("bn_number"));
				bBookNumber.setBankbook(bm);
				
				bBookNumber.setBn_minus(rs.getInt("bn_minus"));
				bBookNumber.setBn_plus(rs.getInt("bn_plus"));
				bBookNumber.setBn_sum(rs.getInt("bn_sum"));
				bBookNumber.setBn_commit(rs.getString("bn_commit"));
				bBookNumber.setBn_date(rs.getString("bn_date"));
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		} finally {pool.freeConnection(conn, pstmt, rs);}	//db종료
		
		return bBookNumber;
	}
	//test
	public UserDTO getBankBook2(String id) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = null;
		UserDTO user=new UserDTO();
		
		try {
			conn=pool.getConnection();
			sql="SELECT * FROM tbl_user WHERE userID=?";
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

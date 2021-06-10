package com.bit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.bit.dto.BankBookNumberDTO;
import com.bit.dto.BankbookDTO;
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
		String sql="INSERT INTO tbl_bankbooknumber VALUES (?, ?, ?, ?, ?, ?)";
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
	
	

}

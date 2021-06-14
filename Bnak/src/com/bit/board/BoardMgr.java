package com.bit.board;
import java.io.File;
//myBankBook.jsp 리스트
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



import com.bit.dto.BankbookDTO;
import com.bit.dto.UserDTO;
import com.bit.util.DBConnectionMgr;

import board.BoardBean;
import board.UtilMgr;


public class BoardMgr {
	
	private DBConnectionMgr pool;
	public static final String ENCTYPE = "UTF-8";

	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Board Total Count : 총 게시물수
	//user: 로그인한  id
	//user 를 가지고 총 게시물 카운트
	public int getTotalCount(String keyField, String keyWord,String user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select count(*) from tbl_bank where buserid LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user);
			}else {
				//검색인 경우
				sql = "select count(*) from tbl_bank where " 
				+ keyField +" like ? and buserid LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setString(2, user);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//Board List : 페이지당 보여줄 갯수만 리턴, 검색 포함.
	//keyField : 선택옵션(name, subject, content)
	//keyWord : 검색어
	//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
	//user: 로그인한 사용자
	public Vector<BankbookDTO> getBoardList(String keyField, 
			String keyWord,int start, int cnt,String user){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BankbookDTO> vlist = new Vector<BankbookDTO>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우 게시판 정렬 (날짜순)
				sql = "select * from tbl_bank where buserid LIKE ? order by bdate desc "
						+ "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}else {
				//검색인 경우
				sql = "select * from tbl_bank where " + keyField 
						+" like ? and buserid LIKE ? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,"%"+keyWord+"%");
				pstmt.setString(2, user);
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BankbookDTO bank = new BankbookDTO();
				bank.setBnumber(rs.getInt("bnumber"));
				bank.setBname(rs.getString("bname"));
				bank.setBpassword(rs.getInt("bpassword"));
				bank.setBdate(rs.getString("bdate"));
				
				vlist.addElement(bank);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Board Get : 한개의 게시물, 13개 컬럼 모두 리턴
		public BankbookDTO getBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			BankbookDTO bean = new BankbookDTO();
			try {
				con = pool.getConnection();
				sql = "select * from tbl_bank where bnumber = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setBnumber(rs.getInt("bnumber"));
					bean.setBname(rs.getString("bnanme"));
					bean.setBpassword(rs.getInt("bpassworld"));
					
					bean.setBdate(rs.getString("bdate"));
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	
	
	//Board Delete : 업로드 파일 삭제
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tbl_bank where bnumber=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
}



















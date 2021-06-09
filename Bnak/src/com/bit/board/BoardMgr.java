package com.bit.board;
//myBankBook.jsp 리스트
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



import com.bit.dto.BankbookDTO;
import com.bit.util.DBConnectionMgr;


public class BoardMgr {
	
	private DBConnectionMgr pool;
	public static final String ENCTYPE = "UTF-8";

	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Board Total Count : 총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select count(*) from tbl_bank";
				pstmt = con.prepareStatement(sql);
			}else {
				//검색인 경우
				sql = "select count(*) from tbl_bank where " 
				+ keyField +" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
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
	public Vector<BankbookDTO> getBoardList(String keyField, 
			String keyWord,int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BankbookDTO> vlist = new Vector<BankbookDTO>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우 게시판 정렬 (날짜순)
				sql = "select * from tbl_bank order by bdate desc "
						+ "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//검색인 경우
				sql = "select * from tbl_bank where " + keyField 
						+" like ? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
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
	
	/*
	 * //Board Get : 한개의 게시물, 13개 컬럼 모두 리턴 public BankbookDTO getBoard(int num) {
	 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
	 * String sql = null; BankbookDTO bean = new BankbookDTO(); try { con =
	 * pool.getConnection(); sql = "select * from tblBoard where num = ?"; pstmt =
	 * con.prepareStatement(sql); pstmt.setInt(1, num); rs = pstmt.executeQuery();
	 * if(rs.next()) { bean.setNum(rs.getInt("num"));
	 * bean.setName(rs.getString("name")); bean.setSubject(rs.getString("subject"));
	 * bean.setContent(rs.getString("content")); bean.setPos(rs.getInt("pos"));
	 * bean.setRef(rs.getInt("ref")); bean.setDepth(rs.getInt("depth"));
	 * bean.setRegdate(rs.getString("regdate")); bean.setPass(rs.getString("pass"));
	 * bean.setIp(rs.getString("ip")); bean.setCount(rs.getInt("count"));
	 * bean.setFilename(rs.getString("filename"));
	 * bean.setFilesize(rs.getInt("filesize")); } } catch (Exception e) {
	 * e.printStackTrace(); } finally { pool.freeConnection(con, pstmt, rs); }
	 * return bean; }
	 */
	
}



















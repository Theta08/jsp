package com.bit.board;
//myBankBook.jsp 리스트
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.bit.dto.BankbookDTO;
import com.bit.util.DBConnectionMgr;
import com.bit.util.UtilMgr;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/board/fileupload/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10*1024*1024;

	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
//-----------------??---------------??		
	
	//Board Insert : 파일업로드, contentType, ref의 상대적인 위치값
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//////////파일업로드 폴더 생성//////////////
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) {//폴더가 존재하지 않는다면
				//mkdir:상위 폴더가 없으면 생성불가 
				//mkdirs:상위 폴더가 없어도 생성가능
				dir.mkdirs();
			}
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
							new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			//모든 게시물이 파일업로드를 하는거 아니다.
			//사용자가 파일을 업로드 하는 경우
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			//게시물 contentType : text, html
			String content = multi.getParameter("content");//게시물 내용
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			///답변을 위한 ref 설정/////
			int ref = getMaxNum() + 1;
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Board Max Num : ref에 저장에 필요한 기능
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblBoard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
//-----------------??---------------??	
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
	
	
	//Post 1000 : 페이징 및 블럭 처리를 위해 게시물 1000개 삽입.
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
			sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public static void main(String[] args) {
		BoardMgr mgr = new BoardMgr();
		mgr.post1000();
		System.out.println("성공~~");
	}
	
}



















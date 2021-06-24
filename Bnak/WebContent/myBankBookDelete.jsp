<%@page import="com.bit.board.BoardMgr"%>
<%@page import="com.bit.util.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--계좌번호 삭제  -->
<%
	request.setCharacterEncoding("UTF-8");
	
	
	int num = UtilMgr.parseInt(request,"bnumber");
	
	BoardMgr boardMgr=new BoardMgr();
	
	//기록삭제(BankBookNumber)
	boardMgr.deleteBoardNumber(num);
	
	//계좌번호 삭제 
	//boardMgr.deleteBoardNumber(num) 하지않고 쓰면 외래키 제약조건때문에 오류남
	boardMgr.deleteBoard(num);
	
	
	
	String url="myBankBook.jsp";
	response.sendRedirect(url);
%>
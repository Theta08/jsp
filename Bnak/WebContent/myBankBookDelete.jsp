<%@page import="com.bit.board.BoardMgr"%>
<%@page import="com.bit.util.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//이게 왜됨??
	int num = UtilMgr.parseInt(request,"bnumber");
	//int num=132453;
	BoardMgr boardMgr=new BoardMgr();
	boardMgr.deleteBoard(num);
	
	String url="myBankBook.jsp";
	response.sendRedirect(url);
%>
<%--test
 num: <%=num %><br>
  --%>

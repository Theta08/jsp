<%@page import="com.bit.dto.Test2DTO"%>
<%@page import="com.bit.dao.BankBookNumberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.bit.dto.Test1DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- test  -->
<%
	request.setCharacterEncoding("UTF-8");
	
	String userID=(String)request.getParameter("id");
	String userPassword=request.getParameter("pw");
	
	String user=(String)request.getParameter("user");
	String com=(String)request.getParameter("com");
	
	String id="aa";
	
	BankBookNumberDAO test1DAO=new BankBookNumberDAO();
	int result=test1DAO.insertT1(new Test1DTO(userID,userPassword));
	Test1DTO t1=new Test1DTO();
	Test2DTO t2=new Test2DTO();
	
	t1.setId(userID);
	
	test1DAO.insertT2(new Test2DTO(user,com,t1));
%>

userID:<%=userID%><br>
userPassword:<%=userPassword %><br>
t_id:<%=userID %><br>

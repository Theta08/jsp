<%@page import="com.bit.dto.BankbookDTO"%>
<%@page import="com.bit.dto.BankBookNumberDTO"%>
<%@page import="com.bit.dto.UserDTO"%>
<%@page import="com.bit.dao.BankBookNumberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
    
 <%
 	BankBookNumberDAO bnum=new BankBookNumberDAO();
	String a="a";
	UserDTO user=bnum.getBankBook2(a);
	String id=user.getUserID();
	String pw=user.getUserPW();
	String name=user.getUserName();
	String date=user.getDate();
 	
	int n=27475;
	
	BankbookDTO bk=new BankbookDTO();
	bk.setBnumber(n);
	BankBookNumberDTO book=bnum.getBankBook(bk);
	
	int num=bk.getBnumber();
	int plus=book.getBn_plus();
	int minus=book.getBn_minus();
	int sum=book.getBn_sum();
	String commit=book.getBn_commit();
	String bdate=book.getBn_date();
	
	
	
	
 %>
user_id: <%=id %><br>
user_pw: <%=pw %><br>
user_name: <%=name %><br>
user_date: <%=date %><br>

<hr>
book_num: <%=num %><br>
book_plus: <%=plus %><br>
user_minus: <%=minus %><br>
user_sum: <%=sum %><br>
user_commit: <%=commit %><br>
user_bdate: <%=bdate %><br>
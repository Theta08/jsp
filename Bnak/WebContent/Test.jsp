<%@page import="com.bit.dao.BankbookDAO"%>
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
 	
//--------------tbl_bank---------------------	
	BankbookDAO bb=new BankbookDAO();
	
	UserDTO user1= new UserDTO();
	String nam="a";
	user1.setUserID(a);
	
	int number1=27475;
	BankbookDTO b=bb.numberCheck(number1);
	
	int b_n=b.getBnumber();
	String bname=b.getBname();
	int b_pw=b.getBnumber();
	String b_userid=user1.getUserID();
	String b_date=b.getBdate();
	
//--------------tbl_bankbooknumber--------------------	
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

<hr>
<h3>tbl_bank</h3>
b_num:<%=b_n%><br>
b_bname:<%=bname%><br>
b_pw:<%=b_pw%><br>
b_userid:<%=b_userid%><br>
b_date:<%=b_date%><br>
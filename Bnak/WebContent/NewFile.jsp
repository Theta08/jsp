<%@page import="com.bit.dto.UserDTO"%>
<%@page import="com.bit.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
UserDAO userdao=new UserDAO();
String a="b";
UserDTO userdto=userdao.getuser(a);

String id=userdto.getUserID();
String pw=userdto.getUserPW();
String name=userdto.getUserName();
String date=userdto.getDate(); 



/* UserDTO user=bnum.getBankBook2(a);
String id=user.getUserID();
String pw=user.getUserPW();
String name=user.getUserName();
String date=user.getDate();  */

%>
userID_a:<%=id%><br>
userID_a1:<%=pw%><br>
userID_a2:<%=name%><br>
userID_a3:<%=date%><br>
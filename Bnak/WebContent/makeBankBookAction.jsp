<%@page import="java.io.PrintWriter"%>
<%@page import="com.bit.dao.BankbookDAO"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bname=request.getParameter("bname");
	int bnumber=Integer.parseInt(request.getParameter("bnumber"));
	int password=Integer.parseInt(request.getParameter("bpassword"));

	//@수정 필요
	//이름의 로그인시 이름으로 만들어야함 외래키 사용해야함 
	BankbookDAO bankbook=new BankbookDAO();
	int result=bankbook.makeBankBook(new BankbookDTO(bnumber,bname,password,null));
 
	//통장 만들기
	if(result==1){
		PrintWriter script=response.getWriter();
		System.out.print("");
		script.println("<script>");
		script.println("alert('통장만들기 성공')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>


<%--  
bname: <%=bname%><br>
bnumber: <%=bnumber%><br>
password: <%=password%><br>  --%>



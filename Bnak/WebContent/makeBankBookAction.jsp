<%@page import="com.bit.dto.UserDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.bit.dao.BankbookDAO"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bname=request.getParameter("bname");
	String userID=(String)session.getAttribute("userID");
	
	//삭제시 tbl_bankbooknumber에있는거도 삭제시키게 해야함  오류남(외레키)
	int bnumber=Integer.parseInt(request.getParameter("bnumber"));
	int password=Integer.parseInt(request.getParameter("bpassword"));

	//외래키 가져오기
	UserDTO userID_=new UserDTO();
	userID_.setUserID(userID);
	
	BankbookDAO bankbook=new BankbookDAO();
	int result=bankbook.makeBankBook(new BankbookDTO(bnumber,bname,password,userID_,null));
	//public BankbookDTO(int bnumber, String bname, int bpassword, UserDTO userID, String bdate)
 
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



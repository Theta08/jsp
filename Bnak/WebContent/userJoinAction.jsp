<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.io.PrintWriter"%>
<%@ page import="com.bit.dao.UserDAO" %>
<%@ page import="com.bit.dto.UserDTO" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userID=request.getParameter("id");
	String userPassword=request.getParameter("password");
	String userName=request.getParameter("name");
	
	//null 확인
	if(userID==null||userPassword==null||userName==null){
		PrintWriter script=response.getWriter();
		System.out.print("");
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
 	UserDAO userDAO=new UserDAO();
	int result=userDAO.join(new UserDTO(userID,userPassword,userName,null));
	if(result==1){
		PrintWriter script=response.getWriter();
		System.out.print("");
		script.println("<script>");
		script.println("alert('회원가입 성공')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
<%-- userID:<%=userID%><br>
userPassword:<%=userPassword %><br>
userName:<%=userName %><br> --%>
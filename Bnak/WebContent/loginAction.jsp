<%@page import="java.io.PrintWriter"%>
<%@page import="com.bit.dao.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userID=null;
	String userPassword=null;
	
	if(request.getParameter("userID")!=null){
		userID=(String)request.getParameter("userID");
	}
	
	if(request.getParameter("userPassword")!=null){
		userPassword=(String)request.getParameter("userPassword");
	}
	
	userDAO userDAO=new userDAO();
	//로그인 확인
	int result=userDAO.login(userID, userPassword);
	//성공
	if(result==1){
		PrintWriter script=response.getWriter();
		session.setAttribute("userID", userID);		//로그인시 userID =1 
		script.println("<script>");
		script.println("location.href='index.jsp'"); //입력x 전
		script.println("</script>");
		script.close();
	}else if(result==0){//비밀번호 오류
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();"); //입력x 전
		script.println("</script>");
		script.close();
		return;
		
	}else if(result==-1){// id x
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('존제하지 않은 아이디입니다');");
		script.println("history.back();"); //입력x 전
		script.println("</script>");
		script.close();
		return;
		
	}else if(result==-2){ //db 오류
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('DB 오류');");
		script.println("history.back();"); //입력x 전
		script.println("</script>");
		script.close();
		return;
	} 
	
	
%>
id:<%=userID %><br>
pw:<%=userPassword %><br>

id:${param.userID}<br>
pw:${param.userPassword}<br>
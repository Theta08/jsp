<%@page import="java.io.PrintWriter"%>
<%@page import="com.bit.dto.BankBookNumberDTO"%>
<%@page import="com.bit.dao.BankBookNumberDAO"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");

	//계좌번호
	int bnumber=Integer.parseInt(request.getParameter("bn_number"));	
	//출금할 금액
	int money=Integer.parseInt(request.getParameter("bn_minus"));	
	String note=request.getParameter("bn_commit");
	
	
	//총 금액
	int max=0;
	max-=money;
	
	/* //총합을 저장해서 db에 넣어야함 
	session.setAttribute("booknum_max", max); */
	
	BankbookDTO bm=new BankbookDTO();
	bm.setBnumber(bnumber);
	
	BankBookNumberDAO bnum=new BankBookNumberDAO();
	//출금 칼럼에 0
	int result=bnum.insert_plus(new BankBookNumberDTO(bm,0,money,max,note,null));
	
 	if(result==1){
		PrintWriter script=response.getWriter();
		session.setAttribute("booknum_max", max);
		System.out.print("");
		script.println("<script>");
		script.println("alert('출금 성공')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	} 
%>
bnumber<%=bnumber%><br>
maney:${booknum_max+booknum_plush}<br>
maney:<%=money%><br>
note:<%=note%><br>
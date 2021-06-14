<%@page import="com.bit.util.UtilMgr"%>
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
	//입금한 금액
	int money=Integer.parseInt(request.getParameter("bn_plus"));	
	String note=request.getParameter("bn_commit");

	//int num = UtilMgr.parseInt(request,"bnumber");
	
	//총 금액
	int max=0;
	max+=money;
	int j=40;
	
	//sql bnumber를 이용해서 최신 sum을 가져온다.
	//그리고 max함수 실행을한다
	//max에 저장한다.
	//sql insert로 저장
	
	
	/* //총합을 저장해서 db에 넣어야함 
	pageContext.setAttribute("booknum_plush", j);
	session.setAttribute("booknum_max", max); */
	
	BankbookDTO bm=new BankbookDTO();
	bm.setBnumber(bnumber);
	
	BankBookNumberDAO bnum=new BankBookNumberDAO();
	//출금 칼럼에 0
	//int result=bnum.insert_plus(new BankBookNumberDTO(bm,money,0,max,note,null));
	
 	/* if(result==1){
		PrintWriter script=response.getWriter();
		session.setAttribute("booknum_max", max);
		System.out.print("");
		script.println("<script>");
		script.println("alert('입금 성공')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}  */
%>
<%-- num: <%=num %><br> --%>
bnumber<%=bnumber%><br>
<!-- setAttribute를 써야함 -->
maney++:${money}<br>
j: ${j}<br>
<!--  -->
maney:<%=money+55%><br>

note:<%=note%><br>
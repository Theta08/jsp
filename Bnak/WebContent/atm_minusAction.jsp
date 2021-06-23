<%@page import="com.bit.dto.UserDTO"%>
<%@page import="com.bit.dao.BankbookDAO"%>
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
	
	//비밀번호
	int userpw=Integer.parseInt(request.getParameter("bn_pw"));
	
	///sql bnumber를 이용해서 최신 sum을 가져온다.
	//그리고 sum함수 실행을한다
	//sum에 저장한다.
	//sql insert로 저장
	BankbookDTO bm=new BankbookDTO();
	bm.setBnumber(bnumber);
	
	BankBookNumberDAO bnum=new BankBookNumberDAO();
	BankBookNumberDTO book=bnum.getBankBook(bm);
	
	int num=bm.getBnumber();
	int plus=book.getBn_plus();
	int minus=book.getBn_minus();
	int sum=book.getBn_sum();			//계좌 총금액을 구하기위해씀
	String commit=book.getBn_commit();
	String bdate=book.getBn_date();
	
	
	
	//총금액
	//날짜별 내림차순이로 처음 sum값과 입금한 값을 더함
	//더한값을 sum에넣고 db에 저장해 총금액을 구한다.
	 sum-=money;
	
	//비밀번호 확인을 위해 tbl_bank테이블 호출
	String userID=(String)session.getAttribute("userID");
	
	BankbookDAO bb=new BankbookDAO();
	UserDTO user1= new UserDTO();
	user1.setUserID(userID);
	
	BankbookDTO b=bb.numberCheck(bnumber);
	
	int b_n=b.getBnumber();
	String bname=b.getBname();
	int b_pw=b.getBpassword();	//비밀번호 비교
	String b_userid=user1.getUserID();
	String b_date=b.getBdate();
	
	if(b_pw==userpw){
		//출금
		int result=bnum.insert_plus(new BankBookNumberDTO(bm,0,money,sum,note,null));
		
	 	if(result==1){
			PrintWriter script=response.getWriter();
			System.out.print("");
			script.println("<script>");
			script.println("alert('출금 성공')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} 
		
	}else{
		PrintWriter script=response.getWriter();
		System.out.print("");
		script.println("<script>");
		script.println("alert('비밀번호 오류')");
		script.println("location.href='atm_minus.jsp'");
		script.println("</script>");
		
	} 
%>
bnumber<%=bnumber%><br>
maney:${booknum_sum+booknum_plush}<br>
maney:<%=money%><br>
note:<%=note%><br>
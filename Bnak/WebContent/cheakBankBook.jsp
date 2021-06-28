<%@page import="java.util.Vector"%>
<%@page import="com.bit.util.UtilMgr"%>
<%@page import="com.bit.dto.BankBookNumberDTO"%>
<%@page import="com.bit.dao.BankBookNumberDAO"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@page import="java.io.PrintWriter"%>
<jsp:useBean id="mgr" class="com.bit.board.BoardMgr"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
<body>

	 <%
		request.setCharacterEncoding("UTF-8");
		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
		
		//로그인 id
		String userID=(String)session.getAttribute("userID");	
		//String userID="a";
		
		//요청된 numPerPage 처리
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
		if(request.getParameter("numPerPage")!=null){
			numPerPage = UtilMgr.parseInt(request, "numPerPage");
		}
		
		//검색에 필요한 변수
		String keyField = "", keyWord = "";
		//검색일때
		if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
		}
		
		//검색 후에 다시 처음화면 요청
		if(request.getParameter("reload")!=null&&
			request.getParameter("reload").equals("true")){
			keyField = ""; keyWord = "";
		}
		
		totalRecord = mgr.getTotalCount(keyField, keyWord, userID);
		//out.print("totalRecord : " + totalRecord);
		
		//nowPage 요청 처리
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		//sql문에 들어가는 start, cnt 선언
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage;
		
		//전체페이지 개수
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		//전체블럭 개수
		 totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		//현재블럭
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
	 
	 
    <!-- 모달:파업창,오픈 버튼 -->
    <!-- 모달을 오픈할수 있는 버튼: 추가(데이터토글,타겟) -->
		<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bankBookModal">
           	내통장 »
       	</button> -->
   
 
		   <!-- Modal에 숨어있다가 버튼클릭시 화면에 출력 -->
		    <div class="modal fade" id="bankBookModal" tabindex="-1" aria-labelledby="mo1" aria-hidden="true">
		        <div class="modal-dialog">
		            <div class="modal-content">
		            
		                <div class="modal-header">
		                    <h5 class="modal-title" id="mo1">내 통장</h5>
		                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
		                
		                <div class="modal-body">						
		               <!--  <form action="#" method="post" name="newBank"> -->
		                 	<div class="form-row">
								<div class="form-group col-sm-6">
									<%-- <label>이름</label>
										<input type="text" name="bname" class="form-control" maxlength="20" value=<%=userID%>> --%>
								</div>
								
							</div>
							<!--게좌번호 리스트 테이블  -->
							<div class="form-row">
								<table class="table table-hover" id="table">
								<%	
								//로그인한 유저 통장보기
								Vector<BankbookDTO> vlist = 
								mgr.getBoardList(keyField, keyWord, start, cnt, userID);
								int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
								if(vlist.isEmpty()){%>																						
									<tr align="center">
										<td>등록된 통장이 없습니다.</td>
									</tr>
								<%}else{%> 
								
									<tr align="center" colspan="2">
										
										<th>계좌번호</th>
										<th>금액</th>
									</tr>
										<%
											for(int i=0;i<numPerPage;i++){
											if(i==listSize) break;
											BankbookDTO bean = vlist.get(i);
											int bnumber = bean.getBnumber();//계좌번호
											String bname = bean.getBname();//이름
										%>
									<tr align="center">
										<td><%=bnumber%></td>
										<td style="color: #d73246; font-weight:500">
										<!--총금액 -->
										<% 
											BankbookDTO bm=new BankbookDTO();
											bm.setBnumber(bnumber);
				
											BankBookNumberDAO bnum=new BankBookNumberDAO();
											BankBookNumberDTO book=bnum.getBankBook(bm);
											int sum=book.getBn_sum();
										%>
											<%=sum %>
										</td>
									</tr>	
					
						<%			}//---for%>				
									
						<%			}//---if-else%>		
						</table>
							</div>							
		                </div>
		            </div>
		        </div>
		    </div>
       
    <!-- 부트스트랩 JS링크 -->
    <!-- min용량이 적은거 -->
    <script src="resources/js/jquery-3.5.1.min.js"></script>
    <script src="resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
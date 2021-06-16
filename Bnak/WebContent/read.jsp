<!-- read.jsp -->
<%@page import="com.bit.dto.BankBookNumberDTO"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="com.bit.util.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="com.bit.board.BoardMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		//read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3

//----------------------------------------------
		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
				
		//로그인 id
		//String userID=(String)session.getAttribute("userID");
		//계좌번호?_test
		int num = UtilMgr.parseInt(request, "num");	
		//int num=20408;
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
		
		totalRecord = mgr.getTotalCount2(keyField, keyWord, num);
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
				
//----------------------------------------------
		
	
%>
<html>
<head>
<title>JSP Board</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<script type="text/javascript">

//-----------------------------------------
function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value = 
			<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function  list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}

//------------------------------------------
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}

</script>
</head>
<body>
<header>
	<jsp:include page="navbar.jsp"/>
</header>
<div class="jumbotron">
        <div class="container">
          <h1 class="display-3">내 통장</h1>
        </div>
</div>
<div class="container">
	<table>
		<tr>
			<td width="600">
			Total : <%=totalRecord%>Articles(<font color="red">
			<%=nowPage+"/"+totalPage%>Pages</font>)
			</td>
		</tr>
	</table>
			<div>
				<div class="text-right">
					<form name="npFrm" method="post">
					<select name="numPerPage" size="1" 
					onchange="numPerFn(this.form.numPerPage.value)">
	    				<option value="5">5개 보기</option>
	    				<option value="10" selected>10개 보기</option>
	    				<option value="15">15개 보기</option>
	    				<option value="30">30개 보기</option>
	   				</select>
	   			</form>
	   				<script>document.npFrm.numPerPage.value=<%=numPerPage%></script>
				</div>
			</div>
			<!-- 검색기능 -->
			<form  name="searchFrm">
				<div>
					<table  width="100%">
				 		<tr>
				  			<td align="center" valign="bottom">
				   				<select name="keyField" size="1" >
				    				<!-- <option value="bn_"> 이 름</option> -->
				    				<option value="bn_date">날짜</option>
				    				<option value="bn_commit"> 메모</option>
				   				</select>
				   				<input size="20" name="keyWord">
				   				<input type="button"  value="찾기"  class="btn btn-primary" onClick="javascript:check()">
				   				<input type="hidden" name="nowPage" value="1">
				  			</td>
				 		</tr>
					</table>
				</div>
			</form>
			
			
			<!-- 테이블 list 보기 -->
			<div style="padding-top: 50px">
				<table class="table table-hover">
		<%	
				//로그인한 유저 통장계좌 상세보기
				Vector<BankBookNumberDTO> vlist = 
				mgr.getBankBookBoardList(keyField, keyWord, start, cnt, num);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
					out.println("등록된 돈이 없습니다.");
				}else{
		%> 
				
				
					<tr align="center" colspan="2">
						<th>번호</th>
						<th>입금</th>
						<th>출금</th>
						<th>남은금액</th>
						<th>코멘트</th>
						<th>날짜</th>
						
					</tr>
		<%
				for(int i=0;i<numPerPage;i++){
					if(i==listSize) break;
					BankbookDTO bm=new BankbookDTO();
					bm.setBnumber(num);
					
					BankBookNumberDTO bean = vlist.get(i);
					
					int bernum=bm.getBnumber();
					int plus=bean.getBn_plus();
					int minus=bean.getBn_minus();
					int sum=bean.getBn_sum();			//계좌 총금액을 구하기위해씀
					String commit=bean.getBn_commit();
					String regdate=bean.getBn_date();
					//댓글 count
					//int bcount = cmgr.getBCommentCount(num);
		%>		
					
					<tr align="center">
						<td><%=totalRecord-start-i%></td>
						<td align="center">
							<%-- <%for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");} %> --%>
							<%=plus%>
							<%-- <%if(bcount>0){%>
								<font color="red">(<%=bcount%>)</font>
							<%}%> --%>
						</td>
						<td><%=minus%></td>
						<td><%=sum %></td>
						<td><%=commit %></td>
						<td>
							<%=regdate%>
						</td>
					</tr>
				
		<%			}//---for%>				
				</table>
		<%			}//---if-else%>

			<table>
				<tr>
					<td>
					<!-- 페이징 및 블럭 Start -->
							<%if(totalPage>0){%>
						<!-- 이전 블럭 -->
						<%if(nowBlock>1){ %>
							<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
						<%} %>
						<!-- 페이징 -->
						<%
								int pageStart = (nowBlock-1)*pagePerBlock+1;
								int pageEnd = (pageStart+pagePerBlock)<totalPage?
										pageStart+pagePerBlock:totalPage+1;
								for(;pageStart<pageEnd;pageStart++){
						%>
							<a href="javascript:pageing('<%=pageStart%>')">
							<%if(nowPage==pageStart){%><font color="blue"><%}%>
								[<%=pageStart%>]
							<%if(nowPage==pageStart){%></font><%}%>
							</a>
						<%}//---for%>
						<!-- 다음 블럭 -->
						<%if(totalBlock>nowBlock){ %>
								<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
						<%} %>
					<%}//---if1%>
					<!-- 페이징 및 블럭 End -->
					</td>
					
				</tr>
			</table>
			</div>
			<div class="text-right">
					<!-- <a href="post.jsp">[글쓰기]</a> -->
					<a href="myBankBook.jsp" class="btn btn-success">처음으로</a>
			</div>

			<hr>

	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="nowPage" value="1">
	</form>
 	
	<form name="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="num" value="<%=num%>">
	</form> 
</div>
</body>
</html>






















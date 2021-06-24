<%@page import="com.bit.dto.BankBookNumberDTO"%>
<%@page import="com.bit.dao.BankBookNumberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.bit.dto.BankbookDTO"%>
<%@page import="com.bit.util.UtilMgr"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="mgr" class="com.bit.board.BoardMgr"/>
<%@ page import="java.util.*"%>
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
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<script type="text/javascript">
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
	//list.jsp에서 read.jsp로 요청이 될때 기존에 조건 같이 넘어감.
	//기존 조건 : keyField,keyWord,nowPage,numPerPage
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.submit();
	}
</script>
<title>Insert title here</title>
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
				    				<option value="bname"> 이 름</option>
				    				<option value="bnumber"> 계좌번호</option>
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
				//로그인한 유저 통장보기
				Vector<BankbookDTO> vlist = 
				mgr.getBoardList(keyField, keyWord, start, cnt, userID);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
					out.println("등록된 통장이 없습니다.");
				}else{
		%> 
				
				
					<tr align="center" colspan="2">
						<th>번호</th>
						<th>계좌번호</th>
						<th>이름</th>
						<th>금액</th>
						<th>비밀번호</th>
						<th>날 짜</th>
					</tr>
		<%
				for(int i=0;i<numPerPage;i++){
					if(i==listSize) break;
					BankbookDTO bean = vlist.get(i);
					int bnumber = bean.getBnumber();//계좌번호
					String bname = bean.getBname();//이름
					int pw = bean.getBpassword();// 비밀번호
					String regdate = bean.getBdate();//날짜
					//댓글 count
					//int bcount = cmgr.getBCommentCount(num);
		%>		
					
					<tr align="center">
						<td><%=totalRecord-start-i%></td>
						<td align="center">
							<%-- <%for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");} %> --%>
							<a href="javascript:read('<%=bnumber%>')"><%=bnumber%></a>
							<%-- <%if(bcount>0){%>
								<font color="red">(<%=bcount%>)</font>
							<%}%> --%>
						</td>
						<td><%=bname%></td>
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
						<td><%=pw %></td>
						<td>
							<%=regdate%>
							<input type="button" class="btn btn-danger" value="삭제" onclick="location.href='myBankBookDelete.jsp?bnumber=<%=bnumber%>'"/>
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
					<a href="index.jsp" class="btn btn-success">home</a>
			</div>

			<hr>

	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="nowPage" value="1">
	</form>
	
	<form name="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
<%-- 	<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>"> --%>
		<input type="hidden" name="num">
	</form>
</div>
</body>
</html>
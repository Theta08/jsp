<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<meta charset="UTF-8">
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
	
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 ?건	</span>
				</div>
			</div>
			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>통장번호</th>
						<th>날짜</th>
						<th>맡긴금액</th>
						<th>거래내용</th>
						<th>총금액</th>
					</tr>
					
					
					<tr>
						<td>통장번호</td>
						<td>날짜</td>
						<td>맡긴금액</td>
						<td>거래내용</td>
						<td>총금액</td>
					</tr>
				


				</table>
			</div>



			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp; 
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
						</select> <input name="text" type="text" /> <input type="submit" id="btnAdd" class="btn btn-primary " value="검색 " />
						</td>
					</tr>
				</table>
			</div>

</div>

</body>
</html>
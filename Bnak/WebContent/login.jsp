<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="navbar.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
<div class="container mt-3" style="max-width: 560px">
		<form method="post" action="loginAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword" class="form-control">
			</div>
			<button type="submit" class="btn btn-lg btn-primary btn-block">로그인</button>
		</form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- 버튼클릭시 난수 생성하기  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-3" style="max-width: 560px">
		<form method="post" action="testAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="id" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="pw" class="form-control">
			</div>
			
			<div class="form-group">
				<label>user</label>
				<input type="text" name="user" class="form-control">
			</div>
			<div class="form-group">
				<label>com</label>
				<input type="password" name="com" class="form-control">
			</div>
			
			<button type="submit" class="btn btn-lg btn-primary btn-block">로그인</button>
		</form>
</div>

</body>
</html>
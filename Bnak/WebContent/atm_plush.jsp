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
	<header>
		<jsp:include page="navbar.jsp"/>
	</header>
	<div class="jumbotron">
        <div class="container">
          <h1 class="display-3">돈 입금하기</h1>
          <h2>${userID}</h2>
        </div>
      </div>
	<div class="container col-md-7 col-lg-8">
	<form action="./atm_plushAction.jsp" method="post" name="bank_get" onsubmit="return cheak()">
		<label>계좌번호</label>
		<div class="form-row">
			<div class="form-group col-sm-8">
				<input type="text" name="bn_number" placeholder="계좌번호를  적어주세요" class="form-control" maxlength="10">
			</div>
			<div class="form-group col-sm-2">
				<button type="button" class="btn btn-primary " onclick="makeRandBtn()">
						확인
				</button>
			</div>
			<div class="form-group col-sm-8">
				<label>금액을 적어주세요</label>
				<input type="text" name="bn_plus" placeholder="금액을 적어주세요" class="form-control" maxlength="10">
			</div>
			<div class="form-group col-sm-8">
				<label>메모</label>
				<input type="text" name="bn_commit" class="form-control" maxlength="10">
			</div>
		</div>
	<br>
	
		<div class="footer" align="right">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary">확인</button>
		</div>
		</form>
	</div>

</body>
</html>
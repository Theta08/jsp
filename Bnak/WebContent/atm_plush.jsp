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
	<div class="jumbotron" style="background-image: url('resources/img/give.jpg'); background-size: cover; height: 100%; background-position: center;">
        <div class="container">
          <h1 class="display-3">돈 입금하기</h1>
        </div>
      </div>
	<div class="container col-md-7 col-lg-8">
		<form action="./atm_plushAction.jsp" method="post" name="bank_get" onsubmit="return cheak()">	
		 <label>계좌번호</label>
			<div class="form-row">
				<!-- 계좌번호 가져오기  -->
				<div class="form-group col-sm-8">
					<input type="text" name="bn_number" placeholder="계좌번호를  적어주세요" class="form-control" maxlength="10">
				</div>
				 <div class="form-group col-sm-2">
					<%-- <jsp:include page="cheakBankBook.jsp"/> --%>
				
				</div>
				 
				<div class="form-group col-sm-8">
					<label>금액을 적어주세요</label>
					<input type="text" name="bn_plus" placeholder="금액을 적어주세요" class="form-control" maxlength="10">
				</div>
				<div class="form-group col-sm-8">
					<label>메모</label>
					<input type="text" name="bn_commit" class="form-control" maxlength="10">
				</div>
			
			<div class="footer" align="right">
					<a class="btn btn-secondary" href="index.jsp" role="button"> 나가기</a>
					<button type="submit" class="btn btn-primary">확인</button>
			</div>
			
			</div>
			<br>
		
		</form>
	</div>
	

</body>
<script>
//빈칸 검사
	function cheak(){
		if (!document.bank_get.bn_number.value) {
			alert("계좌번호를 적어주세요.");
			return false;
		}
	
	 	if (!document.bank_get.bn_plus.value) {
			alert("금액을 적어주세요");
			return false;
		}
	 	
	 	
	}
	function makeRandBtn(){
		//alert("btn cheak");
	   var num=Number(document.getElementById("bnumber").value);
	   
	   console.log('가져온 텍스트:', num+5);
	}
</script>
</html>
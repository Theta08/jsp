<%@page import="com.bit.dto.BankbookDTO"%>
<%@page import="com.bit.dto.UserDTO"%>
<%@page import="com.bit.dao.BankbookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<title>입금</title>
</head>
<body>
	<header>
		<jsp:include page="navbar.jsp"/>
	</header>
	<div class="jumbotron" style="background-image: url('resources/img/give.jpg'); background-size: cover; height: 100%; background-position: center;">
        <div class="container">
          <h1 class="display-3" id="t">돈 입금하기</h1>
        </div>
      </div>
	<div class="container col-md-7 col-lg-8">
		<form action="./atm_plushAction.jsp" method="post" name="bank_get" onsubmit="return cheak()">	
		 <label>계좌번호</label>
			<div class="form-row">
				<!-- 계좌번호 가져오기  -->
				<div class="form-group col-sm-8">
					<input type="text" name="bn_number" placeholder="계좌번호를  적어주세요" id="bankNum" class="form-control" maxlength="10">
				</div>
				
				 <div class="form-group col-sm-2">
					 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bankBookModal">
			           	내통장 »
			       	</button>
			       		<jsp:include page="cheakBankBook.jsp"/>
				</div>
				
				<div class="form-group col-sm-4">
					<label>금액을 적어주세요</label>
					<input type="text" name="bn_plus" placeholder="금액을 적어주세요" class="form-control" maxlength="10">
				</div>
				<div class="form-group col-sm-4">
					<label>비밀번호</label>
					<input type="password" name="bn_pw" class="form-control" maxlength="10"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				</div>
				<div class="form-group col-sm-8">
					<label>메모</label>
					<input type="text" name="bn_commit" class="form-control" maxlength="10">
				</div>
			
			</div>
			<br>
			
			<div class="footer" align="right">
					<a class="btn btn-secondary" href="index.jsp" role="button"> 나가기</a>
					<button type="submit" class="btn btn-primary">확인</button>
			</div>
		</form>
	</div>
	

</body>
<script>
	
var a=document.getElementById('table');
var cell=a.getElementsByTagName('td');
var str="";
//테이블 값찾기
for(var i=0;i<cell.length;i++){
	cell[i].onclick=function(){
	    //console.log(this.innerHTML);
	    str=this.innerHTML;
	    console.log(str);
	 	//모던 숫자 클릭시 값의 #bankNum text에 넣기
	    document.getElementById('bankNum').value=str;
	    };
	}
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
	 	if (!document.bank_get.bn_pw.value) {
			alert("비밀번호를 적어주세요");
			return false;
		}
	 	
	}
</script>
</html>
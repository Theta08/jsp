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
	<% //session으로 id값 가져오기 
			String userID=null;
			if(session.getAttribute("userID")!=null){
				userID=(String)session.getAttribute("userID");
			}
	 %>
	 <%
			if(userID!=null){	    
	 %>
	<header>
		<jsp:include page="navbar.jsp"/>
	</header>
	<div class="jumbotron">
        <div class="container">
          <h1 class="display-3">돈 출금하기</h1>
        </div>
      </div>
	<div class="container col-md-7 col-lg-8">
	<form action="./atm_minusAction.jsp" method="post" name="bank_give" onsubmit="return cheak()">
		<label>계좌번호</label>
		<div class="form-row">
			<div class="form-group col-sm-8">
				<input type="text" name="bn_number" placeholder="계좌번호를  적어주세요" id="bankNum" class="form-control" maxlength="10">
			</div>
			<div class="form-group col-sm-2">
				<button type="button" class="btn btn-primary "data-toggle="modal" data-target="#bankBookModal">
						내통장 »
				</button>
				<jsp:include page="cheakBankBook.jsp"/>
			</div>
			<div class="form-group col-sm-8">
				<label>금액을 적어주세요</label>
				<input type="text" name="bn_minus" placeholder="금액을 적어주세요" class="form-control" maxlength="10">
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
		 <%
			}
		  %>
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

	function cheak(){
		if (!document.bank_give.bn_number.value) {
			alert("계좌번호를 적어주세요.");
			return false;
		}
	
	 	if (!document.bank_give.bn_minus.value) {
			alert("금액을 적어주세요");
			return false;
		}
	 	
	 	
}
</script>
</body>
</html>
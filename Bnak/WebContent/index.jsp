<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">

<title>입출금 통장</title>
</head>
<% 
	String userID=(String)session.getAttribute("userID");
%>
<body>
<header>
	<jsp:include page="navbar.jsp"/>
</header>
<main role="main">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron" style="background-image: url('resources/img/sky.jpg'); background-size: cover; background-position: center;">
        <div class="container">
          <h1 class="display-3">입출금 은행</h1>
          <p></p>
          <p><jsp:include page="makeBankBook.jsp"/></p>
        </div>
      </div>

      <div class="container text-center" >
        <!-- Example row of columns -->
        <!-- https://www.flaticon.com/ img 사용 -->
        <div class="row">
          <div class="col-md-4">
            <h2 class="">돈 출금하기</h2>
             <a class="" role="button" onclick="checkForm(1)">
		         <img src="resources/img/atm.png" width="60%" alt="...">
             </a>
          </div>
          <div class="col-md-4">
            <h2>돈 입금하기</h2>
          	 <a class="" role="button" onclick="checkForm(2)">
				<img src="resources/img/moneyAdd.png" width="60%" alt="...">	
			</a>
          </div>
          <div class="col-md-4">
            <h2>내 통장</h2>
            <a class="" role="button" onclick="checkForm(3)">
				<img src="resources/img/bankbook.png" class="img-fluid rounded" alt="...">	
				
			</a>
          </div>
        </div>

        <hr>

      </div> <!-- /container -->

    </main>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function checkForm(a) {// 로그인확인 
	//alert("실험");
	if (${userID==null}) {
		alert("로그인 해주세요.");
		return false;
	}
	  switch (a){
      case 1: location.href = "./atm_minus.jsp";	//로그인시atm_minus.jsp로 감 
      			break;
      case 2: location.href = "./atm_plush.jsp";	//로그인시 atm_plush.jsp로 감 
      			break;
      case 3: location.href = "./myBankBook.jsp";	//로그인시 myBankBook.jsp로 감 
      			break;
  }
	  //location.href = "./myBankBook.jsp"	//로그인시 myBankBook.jsp로 감
}
</script>
</body>
</html>
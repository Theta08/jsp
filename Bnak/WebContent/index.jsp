<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">

<title>Insert title here</title>
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

      <div class="container" >
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md-4">
            <h2>돈 보내기</h2>
           <!--  <img src="resources/img/sky.jpg" class="img-fluid"> -->
          <i class="fas fa-camera"></i>
          <i class="fas fa-hand-holding-usd"></i>
            <p><a class="btn btn-outline-primary" href="atm_minus.jsp" role="button">View details »</a></p>
          </div>
          <div class="col-md-4">
            <h2>돈 입금하기</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
            <p><a class="btn btn-secondary" href="atm_plush.jsp" role="button">View details »</a></p>
          </div>
          <div class="col-md-4">
            <h2>내 통장</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
            <p><a class="btn btn-secondary" href="#" role="button" onclick="checkForm()">View details »</a></p>
          </div>
        </div>

        <hr>

      </div> <!-- /container -->

    </main>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function checkForm() {// 로그인확인 
	//alert("실험");
	if (${userID==null}) {
		alert("로그인 해주세요.");
		return false;
	}
	location.href = "./myBankBook.jsp"	//로그인시 myBankBook.jsp로 감
}
</script>
</body>
</html>
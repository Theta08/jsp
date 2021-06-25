<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">   
<!-- nav바 -->
	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="./index.jsp">
	  	<img src="resources/img/bank_icon.png">
	  </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="./index.jsp">Home <span class="sr-only"></span></a>
	      </li>
	    </ul>
	    <% 
			String userID=null;
			if(session.getAttribute("userID")!=null){
				userID=(String)session.getAttribute("userID");
			}
		%>
	    <%
			if(userID!=null){	    
	    %>
	    <ul class="nav justify-content-end">
		  <li style="padding-top: 7px;">
		    [<%=userID%>]님 환영합니다.
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="./userLogout.jsp">로그아웃</a>
		  </li>
		</ul>
		  <%
			}
			else{
		  %>
		  <ul class="nav justify-content-end">
			  <li class="nav-item">
			    <a class="nav-link active" href="./login.jsp">로그인</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="./userJoin.jsp">회원가입</a>
			  </li>
			<%
				}
			%>
		</ul>
		
	  </div>
	</nav>


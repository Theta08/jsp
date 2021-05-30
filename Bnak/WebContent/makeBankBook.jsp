<%@page import="java.io.PrintWriter"%>
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
<body>
	<% 
			String userID=null;
			if(session.getAttribute("userID")!=null){
				userID=(String)session.getAttribute("userID");
			}
	 %>
	 <%
			if(userID!=null){	    
	 %>
    <!-- 모달:파업창,오픈 버튼 -->
    <!-- 모달을 오픈할수 있는 버튼: 추가(데이터토글,타겟) -->
    <div class="container">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
            	통장만들기 »
        </button>
    </div>
 
		   <!-- Modal에 숨어있다가 버튼클릭시 화면에 출력 -->
		    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="mo1" aria-hidden="true">
		        <div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title" id="mo1">통장 만들기</h5>
		                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
		                <div class="modal-body">
		                <form action="./#" method="post">
		                 	<div class="form-row">
								<div class="form-group col-sm-6">
									<label>강의명</label>
										<input type="text" name="lectureName" class="form-control" maxlength="20">
								</div>
								<div class="form-group col-sm-6">
									<label>계좌만들기</label>
										<input type="text" name="professorName" class="form-control" maxlength="20">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-10">
									계좌번호	
									<input type="text" name="bnumber" id="randBtnNumber" class="form-control" maxlength="10">
									
								</div>
								<div class="form-group col-sm-2">
									<button type="button" class="btn btn-primary" onclick="makeRandBtn()">
											생성
									</button>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-8">
									비밀번호<input type="text" name="bpassword" class="form-control" maxlength="20">
								</div>
							</div>
							</form>
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		                    <button type="submit" class="btn btn-primary">Save changes</button>
		                </div>
		            </div>
		        </div>
		    </div>
          <%
			}
		  %>
    <!-- 부트스트랩 JS링크 -->
    <!-- min용량이 적은거 -->
    <script src="resources/js/jquery-3.5.1.min.js"></script>
    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script>
    	//버튼 클릭시 랜덤 숫자 발생
	    function makeRandBtn() {//통장번호 랜덤값 지정
	    	var myArray1 = new Array();
        	var v="";			//통장번호담는 변수
        	for (var i=0;i<5;i++){
        		var a=(Math.floor((Math.random()*10))).toString();	//1~9 랜덤숫자
        		myArray1.push(a);
        		v+=myArray1[i];
        		console.log(""+myArray1[i]);
        		console.log("v:"+v);
        	}
	    	document.getElementById("randBtnNumber").value = ''+v;
	    }
    </script>
</body>
</html>
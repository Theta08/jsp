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
<input type="button" value="버튼" onclick="showEvent()">
<input    id="test" value="test1" type="text" class="inputbox" size="20" /><br>
<input    id="test1" value="test1" type="text" class="inputbox" size="20" /><br>

    <script>
        function showEvent() {
        	var i=Math.floor((Math.random()*10));
        	var myArray1 = new Array();
        	var v="";
        	for (var i=0;i<5;i++){
        		var a=(Math.floor((Math.random()*10))).toString();
        		myArray1.push(a);
        		v+=myArray1[i];
        		console.log(""+myArray1[i]);
        		console.log("v:"+v);
        	}
        	console.log(""+myArray1[i]);
        	console.log(myArray1.length);
        	
        	document.getElementById("test1").value = ''+v
        }
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<div id="ExplainDiv">
		
	</div>
	<img src="Images/TPR Intro.jpg" width="100%">
<center>
	<div id="loginDiv">
		<form action="Logon.jsp" method="get">
			<fs>아이디:<input type="text" name="Userid"><br></fs>
			<fs>패스워드:<input type="text" name="Password"><br></fs>
			<input type="submit" name="Register" value="가입하기">
			<input type="submit" name="Login" value="로그인">
			<br>
			<a href="AuthCheck.jsp" target="_blank"><fi>로그인 없이 인증서 확인하기</fi></a>
		</form>
	</div>
	</center>
	
</body>
</html>
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
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!</fib>
	<a href="Chat.jsp" target="_blank"><fh>채팅하기</fh></a><br>
	<a href="SelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="12%"></a>
	<a href="CreateTeam.jsp"><img src="Images/Menu_Team.jpg" width="12%"></a>
	<a href="ManageDaily.jsp"><img src="Images/Menu_Daily.jpg" width="12%"></a>
	<a href="TeamDaily.jsp"><img src="Images/Menu_TeamDaily.jpg" width="12%"></a>
	<a href="Work.jsp"><img src="Images/Menu_Work.jpg" width="12%"></a>
	<a href="Gantt.jsp"><img src="Images/Menu_Gantt.jpg" width="12%"></a>
	<a href="Auth.jsp"><img src="Images/Menu_Auth.jpg" width="12%"></a>
	
	</div>
	<fs>PMS 시스템에선 오로지 아이다와 이름만 있으면 OK입니다.<br>
	*만 필수 입력 사항입니다.</fs><br>
	<fi>(다만, 비밀번호를 설정하지 않으면 팀 생성이 불가능합니다.)</fi>
	<% %>
	<a href="Index.jsp"><fi>로그인 화면으로</fi></a>
	<form action="DoRegister.jsp" method="post">
		<fn>아이디(*):</fn><input type="text" name="Userid"><br>
		<fn>비밀번호:</fn><input type="text" name="Password"><br>
		<fn>이름(*)</fn><input type="text" name="Name"><br>
		<fn>학교:</fn><input type="text" name="University"><br>
		<fn>학과:</fn><input type="text" name="Major"><br>
		<input type="submit" name="Register" value="가입하기">
	</form>
</body>
</html>
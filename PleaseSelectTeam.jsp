<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="Design.css">
</head>
<body>
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!</fib>
	<a href="PleaseSelectTeam.jsp"><fh>채팅하기</fh></a><br>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Team.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Daily.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_TeamDaily.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Work.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Gantt.jpg" width="12%"></a>
	<a href="PleaseSelectTeam.jsp"><img src="Images/Menu_Auth.jpg" width="12%"></a>
	
	</div>
	<hs>먼저, 팀을 선택해 주세요</hs>
	<a href="Main.jsp"><input type="button" value="돌아가기"></a>
	
</body>
</body>
</html>
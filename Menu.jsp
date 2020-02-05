<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!<br></fib>
	<a href="SelectTeam.jsp" target="Main"><img src="Images/Menu_Project.jpg" width="12.5%"></a>
	<a href="CreateTeam.jsp" target="Main"><img src="Images/Menu_Team.jpg" width="12.5%"></a>
	<a href="ManageDaily.jsp" target="Main"><img src="Images/Menu_Daily.jpg" width="12.5%"></a>
	<a href="TeamDaily.jsp" target="Main"><img src="Images/Menu_TeamDaily.jpg" width="12.5%"></a>
	<a href="Work.jsp" target="Main"><img src="Images/Menu_Work.jpg" width="12.5%"></a>
	<a href="Gantt.jsp" target="Main"><img src="Images/Menu_Gantt.jpg" width="12.5%"></a>
	<a href="Auth.jsp" target="Main"><img src="Images/Menu_Auth.jpg" width="12.5%"></a>
	</div>
</body>
</html>
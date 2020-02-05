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
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Time" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>
<%@page import="pmsl.PMSlib" %>
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!<br></fib>
	<a href="SelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="11%"></a>
	<a href="CreateTeam.jsp"><img src="Images/Menu_Team.jpg" width="11%"></a>
	<a href="ManageDaily.jsp"><img src="Images/Menu_Daily.jpg" width="11%"></a>
	<a href="TeamDaily.jsp"><img src="Images/Menu_TeamDaily.jpg" width="11%"></a>
	<a href="Work.jsp"><img src="Images/Menu_Work.jpg" width="11%"></a>
	<a href="Gantt.jsp"><img src="Images/Menu_Gantt.jpg" width="11%"></a>
	<a href="Auth.jsp"><img src="Images/Menu_Auth.jpg" width="11%"></a>
	<a href="Board.jsp"><img src="Images/Menu_Board.jpg" width="11%"></a>
	</div>

<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	int DailyID=Integer.valueOf(request.getParameter("DailyID").toString());
	int datevalue=Integer.valueOf(request.getParameter("datevalue").toString());
	st.execute("DELETE FROM DAILY WHERE DAILYID="+DailyID);
	//out.print("DELETE FROM DAILY WHERE DAILYID="+DailyID);
	conn.close();
%>
<br><br>
<fi>일정 삭제 성공!</fi><br>
<a href="AddDaily.jsp?date=<%=datevalue %>"><input type="button" value="돌아가기"></a>
</body>
</html>
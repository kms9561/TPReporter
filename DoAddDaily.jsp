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
<%@page errorPage="Error.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Time" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>
<%@page import="pmsl.PMSlib" %>
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
<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	int datevalue=Integer.valueOf(request.getParameter("date").toString());
	
	
	int DailyID=0;
	rs=st.executeQuery("SELECT DailyID from Daily order by DailyID desc");
	while(rs.next())
	{
		DailyID=rs.getInt("DailyID")+1;
		break;
	}
	String MemberID=session.getAttribute("MemberID").toString();
	int isRepeatable=0;
	String Date=PMSlib.makeDate(datevalue/10000, (datevalue%10000)/100, datevalue%100);
	String Day=null;
	String Content=request.getParameter("Content").toString();
	String startTime=request.getParameter("StartHour").toString()+":"+request.getParameter("StartMinutes").toString()+":00";
	String endTime=request.getParameter("EndHour").toString()+":"+request.getParameter("EndMinutes").toString()+":00";
	//Start,End는 유효성 검사가 필요하다.
	//컨텐츠가 공란이면 에러가 생기니 바꿔줘야한다.
	if(Content.equals(""))
		Content="  ";
	st.execute("INSERT INTO DAILY VALUES("+DailyID+",'"+MemberID+"',0,'"+Date+"',null,'"+Content+"','"+startTime+"','"+endTime+"')");
	conn.close();
%>

<br><br>
<fi>일정 등록 성공!</fi><br>
<a href="AddDaily.jsp?date=<%=datevalue %>"><input type="button" value="돌아가기"></a>
</body>
</html>
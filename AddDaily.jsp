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
<%@page import="pmsl.DailyManager" %>
<%@page import="pmsl.Daily" %>
<%@page import="java.sql.Date" %>
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
	int datevalue=Integer.valueOf(request.getParameter("date"));
	int year=datevalue/10000;
	int month=(datevalue%10000)/100;
	int date=datevalue%100;

	
%>
<fs>
<%
	out.print(year+"년 "+month+"월 "+date+"일의 일정<br>");
%>
</fs>

<table>
<%
	DailyManager dm=DailyManager.getInstance();
	int nextindex=0;
	Daily tempDaily=null;
	dm.loadDailys(session.getAttribute("MemberID").toString(), year, month, date);
	while(dm.hasNext())
	{
		tempDaily=dm.getDaily();
		if(tempDaily.getRepeatable()==0)
		{
			out.print("<tr>");
			out.print("<td><fn>");
			out.print(tempDaily.getDate());
			out.print("</td></fn>");
			out.print("<td><fn>");
			out.print(tempDaily.getStartHour()+"시"+tempDaily.getStartMinutes()+"분");
			out.print("</td></fn>");
			out.print("<td><fn>");
			out.print(tempDaily.getContent());
			out.print("</td></fn>");
			out.print("<td><fn>");
			out.print("<a href='DoDeleteDaily.jsp?DailyID="+tempDaily.getDailyID()+
				"&datevalue="+datevalue+"'><input type='button' value='일정삭제'></a>");
			out.print("</td></fn>");
			out.print("</tr>");
		}
	}
%>
</table>

<br><br><br>



<form name="addDaily" method="post" action="DoAddDaily.jsp">
<fi>
<%
	out.print(year+"년 "+month+"월 "+date+"일에 일정 추가하기");
%>
</fi>
<input type="text" name="date" value="<%=datevalue %>" readonly size="0"><br>
<fn>시작시간:<input type="date" name="StartHour">시<input type="date" name="StartMinutes" min="0" max="59">분<br>
종료시간:<input type="date" name="EndHour">시<input type="date" name="EndMinutes">분<br>
일정내용:<input type="text" name="Content"><br>
<input type="submit" value="일정등록"><a href="ManageDaily.jsp"><input type="button" value="돌아가기"></a>
</fn>
</form>

</body>
</html>
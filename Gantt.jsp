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
<body>
<%@page import="pmsl.GanttManager" %>
<%@page import="pmsl.SessionManager" %>


<% GanttManager gm=GanttManager.getInstacne();

int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
if(session.getAttribute("TeamID")==null)
{
	//세션정보불충분 예외
}
else
{
	TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());	
}
if(request.getParameter("SuperWorkID")!=null)
{

	gm.flushWork();
	gm.flushNextIndex();
	gm.loadWorkWithoutChild(TeamID, Integer.valueOf(request.getParameter("SuperWorkID").toString()));

	
	
}else{
	gm.loadWorkWithoutChild(TeamID);
}

gm.setStartEndDate(session.getAttribute("TeamName").toString());
%>
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
<table border="1">
<tr>
<td width="10%"><fs>작업명</fs></td>
<td width="10%"><fs>담당자</fs></td>
<td width="80%">
	<table border="0">
		<tr>
		<td><fn>시작일:<% out.print(gm.getStartDate());%></fn></td>
		<td><fn>오늘:<% out.print(gm.getNowDate()); %></fn></td>
		<td><fn>종료일:<% out.print(gm.getEndDate()); %></fn></td></tr>
	</table>
</td>
</tr>


<%

	for(int i=0;i<gm.getNextIndex();i++)
		out.print(gm.printGanttRow(i));

%>
</table>
</body>
</html>
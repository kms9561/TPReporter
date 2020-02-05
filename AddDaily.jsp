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
	<fib><% out.print(session.getAttribute("Name")); %>�� ȯ���մϴ�!</fib>
	<a href="Chat.jsp" target="_blank"><fh>ä���ϱ�</fh></a><br>
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
	out.print(year+"�� "+month+"�� "+date+"���� ����<br>");
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
			out.print(tempDaily.getStartHour()+"��"+tempDaily.getStartMinutes()+"��");
			out.print("</td></fn>");
			out.print("<td><fn>");
			out.print(tempDaily.getContent());
			out.print("</td></fn>");
			out.print("<td><fn>");
			out.print("<a href='DoDeleteDaily.jsp?DailyID="+tempDaily.getDailyID()+
				"&datevalue="+datevalue+"'><input type='button' value='��������'></a>");
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
	out.print(year+"�� "+month+"�� "+date+"�Ͽ� ���� �߰��ϱ�");
%>
</fi>
<input type="text" name="date" value="<%=datevalue %>" readonly size="0"><br>
<fn>���۽ð�:<input type="date" name="StartHour">��<input type="date" name="StartMinutes" min="0" max="59">��<br>
����ð�:<input type="date" name="EndHour">��<input type="date" name="EndMinutes">��<br>
��������:<input type="text" name="Content"><br>
<input type="submit" value="�������"><a href="ManageDaily.jsp"><input type="button" value="���ư���"></a>
</fn>
</form>

</body>
</html>
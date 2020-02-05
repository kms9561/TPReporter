<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- �� �������� ���常 ���� ����. -->
</head>
<body>
<%@page import="pmsl.TeamDailyManager" %>
<%@page import="pmsl.DailyManager" %>
<%@page import="pmsl.Daily" %>
<%@page import="java.util.Date" %><!--  JDK���� Date�� ���� �������̰� Ķ������ �����ƴٰ� ��. -->
<%@page import="java.util.Calendar" %>
<%@page import="pmsl.Datevalue" %>
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
	
	DailyManager dm=DailyManager.getInstance();
	TeamDailyManager tm=TeamDailyManager.getInstance();
	tm.allocateExists();	//���� �ʱ�ȭ ����!!
	Calendar cal=Calendar.getInstance();
	//Ķ������ Date�� �޸� �Ͽ����� 1�̴�... �� �򰥷�(����Ʈ�� 0�� �Ͽ���;) ���� 1���� 0.
 
	int datevalue;
	if(request.getParameter("datevalue")==null)
	{
		datevalue=Datevalue.makeDatevalue();
		
	}else{
		datevalue=Integer.valueOf(request.getParameter("datevalue"));
	}
	
%>
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getPrevMonth(datevalue)%>">
<input type="button" value="<<"></a> 
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getPrevWeek(datevalue)%>">
<input type="button" value="<"></a> 
<%
cal.set(Calendar.YEAR,Datevalue.getYear(datevalue));
cal.set(Calendar.MONTH,Datevalue.getMonth(datevalue)-1);
cal.set(Calendar.DATE,Datevalue.getDate(datevalue));
//cal�� ��¥�� datevalue��
cal.set(Calendar.DATE, cal.get(Calendar.DATE)-cal.get(Calendar.DAY_OF_WEEK)+1);
%>
<fs>
<%=cal.get(Calendar.MONTH)+1 %>��
<%=cal.get(Calendar.WEEK_OF_MONTH) %>��</fs>
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getNextWeek(datevalue)%>">
<input type="button" value=">"></a> 
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getNextMonth(datevalue)%>">
<input type="button" value=">>"></a> 
<br>
<fh>�������� ������ Ȯ���ϰ� <br>
���� ������ ��ƺ�����.</fh>

<br><br>

<% 
	int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
	out.print("<table>");
	//���ó�¥�� cal������ ������ �߰�,
	out.print("<tr><td></td>");
	for(int day=1;day<=7;day++)
	{
		out.print("<td><fh>"+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.DATE)+"<br>("
		+dm.transDay(cal.get(Calendar.DAY_OF_WEEK)-1)+")</fh></td>");
		cal.set(Calendar.DATE,cal.get(Calendar.DATE)+1);
	}
	out.print("</tr>");
	
	
	
	//cal=Calendar.getInstance();	//<-�ٽ� �ν��Ͻ� �� �ϸ� ���糯¥�� ���ƿ��� ��!
	//�ٽ� DV������
	cal.set(Calendar.YEAR,Datevalue.getYear(datevalue));
	cal.set(Calendar.MONTH,Datevalue.getMonth(datevalue)-1);
	cal.set(Calendar.DATE,Datevalue.getDate(datevalue));
	
	cal.set(Calendar.DATE, cal.get(Calendar.DATE)-cal.get(Calendar.DAY_OF_WEEK)+1);	
	//cal�� ��¥�� �̹��� �Ͽ��Ϸ� �ٽ� �ѹ� ����.
	for(int i=0;i<7;i++)
	{
		tm.loadDailyExists(TeamID, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1,cal.get(Calendar.DATE));
		tm.loadTeamDailyExists(TeamID, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1,cal.get(Calendar.DATE));
		cal.set(Calendar.DATE, cal.get(Calendar.DATE)+1);
	}
	final int STARTTIME=6;
	final int MAXTIME=10;
	int time=0; int day=0;
	for(time=0;time<tm.getMAXTIME();time++)
	{
		out.print(tm.printRows(time));
	}

	
	
	out.print("</table>");
%>
<% cal=Calendar.getInstance(); %>
<form name="addTeamDaily" action="DoTeamDaily.jsp" method="post">
	<fn>
	<input type="text" name="year" value=<%=cal.get(Calendar.YEAR) %> >��
	<input type="month" name="month">�� <input type="date" name="date">�Ͽ�<br></fn>
	<fn>���۽ð�:<input type="text" name="StartHour">��<input type="text" name="StartMinutes" min="0" max="59">��</fn><br>
	<fn>����ð�:<input type="text" name="EndHour">��<input type="text" name="EndMinutes">��</fn><br>
	<fn>��������:<input type="text" name="Content">�� ������</fn><br>
	<input type="submit" name="ClickAdd" value="�߰��մϴ�."><input type="submit" name="ClickDelete" value="�����մϴ�">
</form>
<br><fi>24�ð����� �Է��ϼ���.(���� 3��->15��.)
<br>���� �ÿ��� ���ڿ� ���븸 �Է��ϼ���.</fi>
</body>
</html>
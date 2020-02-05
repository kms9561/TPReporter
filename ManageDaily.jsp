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
<%@page import="pmsl.DailyManager" %>
<%@page import="java.sql.Date" %>
<%@page import="pmsl.Daily" %>
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
<% String MemberID=session.getAttribute("MemberID").toString();
	DailyManager dm=DailyManager.getInstance();
	Date thisdate=null;
	Date firstday=null;
	int lastday=30;
	int datevalue=0;
%>
<%	
	//datevalue값 로드.
	if(request.getParameter("date")==null)
	{
		thisdate=new Date(System.currentTimeMillis());
		datevalue=(thisdate.getYear()+1900)*10000+(thisdate.getMonth()+1)*100+thisdate.getDate();
	}
	else
	{
		datevalue=Integer.valueOf(request.getParameter("date"));
		thisdate=new Date(datevalue/10000-1900,(datevalue%10000)/100-1,datevalue%100);
	}

	//데이터벨류를 분석	
	firstday=new Date(thisdate.getYear(),thisdate.getMonth(),1);
	lastday=new Date(thisdate.getYear(),thisdate.getMonth()+1,0).getDate()+1;
	int year=thisdate.getYear()+1900;
	int month=thisdate.getMonth()+1;
	int date=1;	
%>
<%
	int prevmonth_date=year*10000+(month-1)*100+date;
	if(month<=12)
		 prevmonth_date=(year-1)*10000+12*100+date;
	int nextmonth_date=year*10000+(month+1)*100+date;
	if(month>=12)
		 nextmonth_date=(year+1)*10000+1*100+date;
	int prevyear_date=(year-1)*10000+month*100+date;
	int nextyear_date=(year+1)*10000+month*100+date;
%>

<div name="target_month">
<a href="ManageDaily.jsp?date=<%=prevmonth_date %>"><input type="button" name="prev" value="<"></a>
<% out.print("<fs>"+year+"년 "+month+"월</fs>"); %>
<a href="ManageDaily.jsp?date=<%=nextmonth_date %>"><input type="button" name="next" value=">"></a><br>
</div>

<table name="month_calender">

	<tr>
		<td><fh>일요일</fh></td><td><fh>월요일</fh></td><td><fh>화요일</fh></td><td><fh>수요일</fh></td>
		<td><fh>목요일</fh></td><td><fh>금요일</fh></td><td><fh>토요일</fh></td>
	</tr>
	
<%
	out.print("<tr>");
	//전월 공백 출력
	int day=0;
	for(day=0;day<firstday.getDay();day++)
	{
		out.print("<td></td>");
	}
	date=1;
	Daily d=null;
	for(date=1;date<lastday;)
	{
		
		while(day<7&&date<lastday)
		{
			out.print("<td><fh>");
			out.print("<a href='AddDaily.jsp?date="+(year*10000+month*100+date)+"'>"+date+"</a><br>");
			//일정정보출력
			dm.loadDailys(MemberID, year, month, date);
			while(dm.hasNext())
			{
				d=dm.getDaily();
				if(d.getDate()!=null)
					out.print(d.getContent()+"<br>");
			}
			dm.fleshNextIndex();
			dm.fleshDailys();
			out.print("</fh></td>");
			day++;
			date++;
		}
		out.print("</tr>");
		out.print("<tr>");
		day=0;
	}
	out.print("</tr>");

%>

</table>

</body>
</html>
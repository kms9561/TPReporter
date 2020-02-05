<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- 이 페이지는 조장만 접근 가능. -->
</head>
<body>
<%@page import="pmsl.TeamDailyManager" %>
<%@page import="pmsl.DailyManager" %>
<%@page import="pmsl.Daily" %>
<%@page import="java.util.Date" %><!--  JDK에서 Date은 낡은 구버전이고 캘린더로 업뎃됐다고 함. -->
<%@page import="java.util.Calendar" %>
<%@page import="pmsl.Datevalue" %>
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
	
	DailyManager dm=DailyManager.getInstance();
	TeamDailyManager tm=TeamDailyManager.getInstance();
	tm.allocateExists();	//변수 초기화 선언!!
	Calendar cal=Calendar.getInstance();
	//캘린더는 Date와 달리 일요일이 1이다... 아 헷갈려(데이트는 0이 일요일;) 또한 1월은 0.
 
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
//cal의 날짜를 datevalue로
cal.set(Calendar.DATE, cal.get(Calendar.DATE)-cal.get(Calendar.DAY_OF_WEEK)+1);
%>
<fs>
<%=cal.get(Calendar.MONTH)+1 %>월
<%=cal.get(Calendar.WEEK_OF_MONTH) %>주</fs>
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getNextWeek(datevalue)%>">
<input type="button" value=">"></a> 
<a href="TeamDaily.jsp?datevalue=<%=Datevalue.getNextMonth(datevalue)%>">
<input type="button" value=">>"></a> 
<br>
<fh>팀원들의 일정을 확인하고 <br>
팀의 일정을 잡아보세요.</fh>

<br><br>

<% 
	int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
	out.print("<table>");
	//오늘날짜로 cal세팅은 위에서 했고,
	out.print("<tr><td></td>");
	for(int day=1;day<=7;day++)
	{
		out.print("<td><fh>"+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.DATE)+"<br>("
		+dm.transDay(cal.get(Calendar.DAY_OF_WEEK)-1)+")</fh></td>");
		cal.set(Calendar.DATE,cal.get(Calendar.DATE)+1);
	}
	out.print("</tr>");
	
	
	
	//cal=Calendar.getInstance();	//<-다시 인스턴스 겟 하면 현재날짜로 돌아오는 것!
	//다시 DV값으로
	cal.set(Calendar.YEAR,Datevalue.getYear(datevalue));
	cal.set(Calendar.MONTH,Datevalue.getMonth(datevalue)-1);
	cal.set(Calendar.DATE,Datevalue.getDate(datevalue));
	
	cal.set(Calendar.DATE, cal.get(Calendar.DATE)-cal.get(Calendar.DAY_OF_WEEK)+1);	
	//cal의 날짜를 이번주 일요일로 다시 한번 세팅.
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
	<input type="text" name="year" value=<%=cal.get(Calendar.YEAR) %> >년
	<input type="month" name="month">월 <input type="date" name="date">일에<br></fn>
	<fn>시작시간:<input type="text" name="StartHour">시<input type="text" name="StartMinutes" min="0" max="59">분</fn><br>
	<fn>종료시간:<input type="text" name="EndHour">시<input type="text" name="EndMinutes">분</fn><br>
	<fn>일정내용:<input type="text" name="Content">인 일정을</fn><br>
	<input type="submit" name="ClickAdd" value="추가합니다."><input type="submit" name="ClickDelete" value="삭제합니다">
</form>
<br><fi>24시간제로 입력하세요.(오후 3시->15시.)
<br>삭제 시에는 일자와 내용만 입력하세요.</fi>
</body>
</html>
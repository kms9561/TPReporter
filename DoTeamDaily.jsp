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

<%@page import="pmsl.DBconnecter" %><!--  JDK에서 Date은 낡은 구버전이고 캘린더로 업뎃됐다고 함. -->
<%@page import="java.util.Calendar" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Date" %>
<%@page import="pmsl.Daily" %>
<%@page errorPage="Error.jsp" %>
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
	int TeamID=0;
	int StartHour=-1; 
	int EndHour=-1;
	int StartMinutes=-1; int EndMinutes =-1 ;
	int DailyID=0; 
	String dateString=null; String StartTime=null; String EndTime=null; //추가에서 싸용하는 변수
	
	String MemberID=session.getAttribute("MemberID").toString();
	String TeamName=session.getAttribute("TeamName").toString();
	
	
	String content=request.getParameter("Content");
	if(!request.getParameter("StartHour").equals("")&&!request.getParameter("StartMinutes").equals(""))
	{
		StartHour=Integer.valueOf(request.getParameter("StartHour"));
		StartMinutes=Integer.valueOf(request.getParameter("StartMinutes"));
	
	}
	if(!request.getParameter("EndHour").equals("")&&!request.getParameter("EndMinutes").equals(""))
	{
		EndHour=Integer.valueOf(request.getParameter("EndHour"));
		EndMinutes=Integer.valueOf(request.getParameter("EndMinutes"));
	}
	
	
	dateString=(request.getParameter("year")+"-"+request.getParameter("month")+
			"-"+request.getParameter("date"));
%>

<%
Connection conn=DBconnecter.getConnection();
Statement st=conn.createStatement();
ResultSet rs=null;
rs=st.executeQuery("SELECT TeamID from Team where TeamName='"+TeamName+"' AND LeaderID='"+MemberID+"'" );
while(rs.next())
{
	TeamID=rs.getInt("TeamID");
	break;
}
if(request.getParameter("ClickAdd")==null)
{//삭제 명령
	if(StartHour!=-1){
		//시작시간으로 삭제
		st.execute("DELETE from TeamDaily where TeamID="+TeamID+" AND StartTime='"+Daily.makeTime(StartHour, StartMinutes)+
		"' AND Date='"+dateString+"'");
	}else if(EndHour!=-1){
		st.execute("DELETE from TeamDaily where TeamID="+TeamID+" AND EndTime='"+Daily.makeTime(EndHour, EndMinutes)+"' AND Date='"+
	dateString+"'");
		
	}else if(content!=null){
		st.execute("DELETE from TeamDaily where TeamID="+TeamID+" AND Content='"+content+"' AND Date='"+dateString+"'");
	}
	
	
	
}else{
//츠기 명령
	rs=st.executeQuery("SELECT DailyID from TeamDaily order by DailyID desc");
	while(rs.next())
	{
		DailyID=rs.getInt("DailyID");
		DailyID++;
		break;
	}
	StartTime=Daily.makeTime(StartHour, StartMinutes);
	EndTime=Daily.makeTime(EndHour, EndMinutes);
	st.execute("INSERT INTO TeamDaily VALUES("+DailyID+","+TeamID+",'"+dateString+"','"
						+content+"','"+StartTime+"','"+EndTime+"')");
	
}
conn.close();

%>
<fi>작업이 완료되었습니다.</fi>
<a href="TeamDaily.jsp"><input type="button" value="돌아가기"></a>
</body>
</html>
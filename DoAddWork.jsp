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
<%@page import="pmsl.DBconnecter" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.Calendar" %>
<%@page errorPage="Error.jsp" %>
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

int superWorkID=-1;
int endYear=-1;
int endMonth=-1;
int endDate=-1;
int workID=0;
int agreeID=0;
String content="";
String TeamName=null;
String MemberID=null;
String EndDate="";
Calendar c=Calendar.getInstance();
c.setTimeInMillis(System.currentTimeMillis());
String StartDate=c.get(Calendar.YEAR)+"-"+c.get(Calendar.MONTH)+"-"+c.get(Calendar.DATE);
//int TeamID=-1;//하드코드

if(!request.getParameter("Super").equals("null"))
	superWorkID=Integer.valueOf(request.getParameter("Super").toString());
if(request.getParameter("EndDate_year")!=null)
	endYear=Integer.valueOf(request.getParameter("EndDate_year").toString());
if(request.getParameter("EndDate_month")!=null)
	endMonth=Integer.valueOf(request.getParameter("EndDate_month").toString());
if(request.getParameter("EndDate_date")!=null)
	endDate=Integer.valueOf(request.getParameter("EndDate_date").toString());
if(request.getParameter("Content")!=null)
{
	content=request.getParameter("Content").toString();

}



TeamName=session.getAttribute("TeamName").toString();
MemberID=session.getAttribute("MemberID").toString();
%>
<%
Connection conn=DBconnecter.getConnection();
Statement st=conn.createStatement();
ResultSet rs=null;
rs=st.executeQuery("SELECT WorkID from Work order by WorkID desc");
while(rs.next()){
	workID=rs.getInt("WorkID")+1;
	break;
}
rs=st.executeQuery("SELECT AgreeID from Work_Agree order by AgreeID desc");
while(rs.next())
{
	agreeID=rs.getInt("AgreeID")+1;
	break;
}
//팀ID구하기가 들어가야//
int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
if(session.getAttribute("TeamID")==null)
{
	TeamID=0;	
}else{
	TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
}

EndDate=endYear+"-"+endMonth+"-"+endDate;
if(content.equals(""))
	content=" "; 


if(superWorkID==-1)
{
	
	st.execute("INSERT into Work values("+workID+",'"+MemberID+"',"+TeamID+",null,'"
			+StartDate+"','"+EndDate+"','"+EndDate+"','suggest',0,'"+content+"','X')");

}else{
	st.execute("INSERT into Work values("+workID+",'"+MemberID+"',"+TeamID+","+superWorkID
			+",'"+StartDate+"','"+EndDate+"','"+EndDate+"','suggest',0,'"+content+"','X')");
}

st.execute("INSERT into Work_agree values("+agreeID+","+TeamID+","+workID+",'"+
MemberID+"','yes')");

out.print("<fi>업무를 제안했습니다. 팀장의 승인을 기다려 주세요.</fi>");
%>
<br>
<a href="AddWork.jsp"><input type="button" value="돌아가기"></a>&nbsp;
<a href="Work.jsp"><input type="button" value="업무관리로 돌아가기"></a>

</body>
</html>
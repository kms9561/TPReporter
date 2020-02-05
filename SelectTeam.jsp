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

<!--  소속된 팀 정보를 받아온다. -->
<!--  DB처리를 위해 include하는 부분임 -->
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>
<% 	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	
	ResultSet rs=null;


%>

<% String MemberID=""; String Name="쿠기가 생성되지 않았습니다. 쿠키 허용 설정으로 해 주세요.";
int MAXTEAM=5;
int[] TeamIDs=new int[MAXTEAM];
String[] TeamNames=new String[MAXTEAM];
String[] ProjectNames=new String[MAXTEAM];
String[] StartDates=new String[MAXTEAM];
String[] EndDates=new String[MAXTEAM];%>
<% 
	MemberID=session.getAttribute("MemberID").toString();

	
	rs=st.executeQuery("SELECT name from Member where memberID='"+MemberID+"'");
	while(rs.next())
		Name=rs.getString("Name");
	session.setAttribute("Name", Name);
	
	rs=st.executeQuery("SELECT * from teamjoin where memberID='"+MemberID+"'");
	
	int NowTeam=0;
	while(rs.next()&&NowTeam<MAXTEAM)
	{
		TeamIDs[NowTeam++]=rs.getInt("TeamID");
		
	}


	for(int i=0;i<NowTeam;i++)
	{
		rs=st.executeQuery("SELECT * from team where TeamID="+TeamIDs[i]);
		while(rs.next()&&i<MAXTEAM)
		{
			TeamNames[i]=rs.getString("TeamName");
			ProjectNames[i]=rs.getString("ProjectName");
			StartDates[i]=rs.getString("StartDate");
			EndDates[i]=rs.getString("EndDate");
			
		
		}
	}
	st.close();
	rs.close();
	conn.close();
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
	
	<div id="selectedTeamDiv">

<fh>
<%
	if(session.getAttribute("TeamName")==null){
		out.print("관리할 프로젝트(팀)을 선택해주세요.");
	}else{
		out.print(session.getAttribute("TeamName")+"팀을 선택하셨습니다. 버튼을 선택해 바꿀 수 있습니다.");
	}
%>
</fh>

	</div>
	
	<div id="body">
	
	 <form id="selectTeamForm" action="DoSelectTeam.jsp" method="get">
		<table border="1">
			<tr>
				<td><fs>팀 이름</fs></td><fs><td><fs>프로젝트 이름</fs></td>
				<td><fs>시작일</fs></td><td><fs>종료일</fs></td>
			</tr>
<%
		for(int i=0;i<NowTeam;i++)
		{
			out.print("<tr>");
			
			out.print("<td>"); 		
			//out.print(TeamNames[i]); 
			out.print("<input type=submit name='Select' value='"+TeamNames[i]+"'>"); 
			out.print("</td>");
			out.print("<td><fn>"); out.print(ProjectNames[i]); out.print("</fn></td>");
			out.print("<td><fn>"); out.print(StartDates[i]); out.print("</fn></td>");
			out.print("<td><fn>"); out.print(EndDates[i]); out.print("</fn></td>");
			out.print("</tr>");
			
		}
%>

			
		</table>  
	</form>        
	</div>

	<a href="CreateTeam.jsp"><fh>팀 또는 프로젝트를 새로 생성합니까?</fh></a>
	<form name="jointeamform" action="DoJoinTeam.jsp" method="post">
		<fn>팀 고유번호 <input type="text" name="TeamID">인 팀에 가입하시겠습니까?<br></fn>
		<input type="submit" value="네">
		
	</form>
	
</body>
</html>
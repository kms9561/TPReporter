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

<!--  �Ҽӵ� �� ������ �޾ƿ´�. -->
<!--  DBó���� ���� include�ϴ� �κ��� -->
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>
<% 	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	
	ResultSet rs=null;


%>

<% String MemberID=""; String Name="��Ⱑ �������� �ʾҽ��ϴ�. ��Ű ��� �������� �� �ּ���.";
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
	
	<div id="selectedTeamDiv">

<fh>
<%
	if(session.getAttribute("TeamName")==null){
		out.print("������ ������Ʈ(��)�� �������ּ���.");
	}else{
		out.print(session.getAttribute("TeamName")+"���� �����ϼ̽��ϴ�. ��ư�� ������ �ٲ� �� �ֽ��ϴ�.");
	}
%>
</fh>

	</div>
	
	<div id="body">
	
	 <form id="selectTeamForm" action="DoSelectTeam.jsp" method="get">
		<table border="1">
			<tr>
				<td><fs>�� �̸�</fs></td><fs><td><fs>������Ʈ �̸�</fs></td>
				<td><fs>������</fs></td><td><fs>������</fs></td>
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

	<a href="CreateTeam.jsp"><fh>�� �Ǵ� ������Ʈ�� ���� �����մϱ�?</fh></a>
	<form name="jointeamform" action="DoJoinTeam.jsp" method="post">
		<fn>�� ������ȣ <input type="text" name="TeamID">�� ���� �����Ͻðڽ��ϱ�?<br></fn>
		<input type="submit" value="��">
		
	</form>
	
</body>
</html>
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
<!--  DBó���� ���� include�ϴ� �κ��� -->
<%@page errorPage="Error.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.PMSlib" %>


	
<% long TeamID=PMSlib.getRandom();
if(TeamID<0)
	TeamID=0-TeamID*2;
%>

<!--  ������ ���� ��ư�� null. -->

<% String TeamName=request.getParameter("TeamName"); 
String LeaderID=null;






String ProjectName=request.getParameter("ProjectName"); 
String StartDate=DBconnecter.getNowDate();
String EndDate=DBconnecter.makeDate(Integer.valueOf(request.getParameter("year")),
		Integer.valueOf(request.getParameter("month")),
		Integer.valueOf(request.getParameter("date"))
		);
if(EndDate.equals("ERROR"))
{//���� �Է°� ���Ἲ ���� ó��
	response.sendError(400, "Error.jsp");
}

%>
<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	
	String LeaderPassword=null;
	
	rs=st.executeQuery("SELECT TeamID from Team where TeamId="+TeamID);
	int flag=0;
	while(rs.next()&&flag<10)
	{
		TeamID=DBconnecter.getRandom();


	}
	if(flag>=10)
	{
		out.print("<fi>�˼��մϴ�. ��� �� �ٽ� �õ��� �ּ���.</fi>"); //�ؽ��ڵ� �ߺ��� 10���̳� �ݺ�;;;
	}else{
		LeaderID=session.getAttribute("MemberID").toString();
		//������ �ٸ� �ؽ�Ʈ�� ����� �ص� �����ϳ� DATE���� ���Ἲ ó�� �ݵ�� �����ؼ� �� ��!!!!
		rs=st.executeQuery("SELECT Password from Member where MemberID='"+LeaderID+"'");
		while(rs.next())
		{
			LeaderPassword=rs.getString("Password");
			break;
		}
		if(LeaderPassword==null||LeaderPassword.length()<2)
		{
			out.print("<fi>��й�ȣ�� �������� ���� ������ ���� ������ �� �����ϴ�.<br>");
			out.print("��й�ȣ�� ������ �ּ���.</fi>");
		}
		else
		{	
			st.execute("INSERT into Team VALUES("+TeamID+",'"+TeamName+"','"+LeaderID+"','"+ProjectName+"','"+StartDate+"','"+EndDate+"')");
			//out.print("INSER into TeamJoin VALUES("+TeamID+",'"+LeaderID+"')");
			st.execute("INSERT into TeamJoin VALUES("+TeamID+",'"+LeaderID+"')");
			out.print("<fi>������ȣ�� "+TeamID+"�� ���� �����Ǿ����ϴ�!</fi><br>");
			out.print("<fi>�� ������ȣ�� ������� �����ϼ���. ������ȣ�� �����̴ٰ��? �� ���� â���� Ȯ���ϼ���!</fi>");
		}
	}
	conn.close();
%>
<br>
<a href="SelectTeam.jsp"><input type="button" value="���ư���"></a>
</body>
</html>
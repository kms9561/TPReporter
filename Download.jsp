<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<%@page import="pmsl.DBconnecter" %>
<%@page import="java.io.File"%>
<%@page import="pmsl.PMSlib" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
</head>

<body>
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
	String WorkID=request.getParameter("WorkID");
	String TeamID=session.getAttribute("TeamID").toString();

%>
<table border="0">
<tr><td><fs>���ϸ�</fs></td><td></td><td></td><td><fs>���� ����</fs></td>
<td><fs>���δ�</fs></td><td><fs>���ε� ��¥</fs></td>
</tr>
<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	String filePath=null;
	String UploaderID=null;
	rs=st.executeQuery("Select FileName, file.MemberID, TeamID, Content, Name, Date, WorkID from file, Member " 
			+"where file.MemberID=Member.MemberID AND TeamID="+TeamID+" AND WorkID="+WorkID);
	while(rs.next())
	{
		UploaderID=rs.getString("MemberID");
		filePath="/upload/"+TeamID+"/"+UploaderID+"/";
		out.print("<tr>");
		out.print("<td><fn>"+rs.getString("FileName")+"</fn></td>");
		out.print("<td><fn><a href='DoDownload.jsp?FileName="+rs.getString("FileName")+
		"'><input type='button' value='�ٿ�ε�'></a></fn></td>");
		//ǥ �ȿ� ���� �ִ� �� �Ұ�����-.
		//�����غ���, Team������ Member������ ������ ���ǿ� ���� �Ѥ�;;
		out.print("<td><fn><a href='DoDeleteFile.jsp?FileName="+rs.getString("FileName")+
				"'><input type='button' value='����'></a></fn></td>");
		out.print("<td><fn>"+rs.getString("Content")+"</fn></td>");
		out.print("<td><fn>"+rs.getString("Name")+"</fn></td>");
		out.print("<td><fn>"+rs.getString("Date")+"</fn></td>");
		
		out.print("</tr>");
	}
%>

</table>
<form method="post" action="Upload.jsp">
	<input type="hidden" name="WorkID" value=<%=WorkID %>>
	<input type="submit" value="�ڷ� ���ε�">
</form>
<input type="button" value="���ư���" onclick="history.back(-1);">
</body>
</html>
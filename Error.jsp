<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page isErrorPage="true"%>
<% response.setStatus(200); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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
<ft>������ �߻��߽��ϴ�.</ft>
<% String ErrHandler=exception.getMessage().split(":")[0];
	if(ErrHandler.equals("For input string"))
	{	//For input String:... ���ڸ� �־�� �� ���� ���ڸ� ���� ����.
		//Data truncation:... ����Ʈ ���� ���� �� ���� ����.
		out.print("<fi>��Ȯ�� ���ڸ� �־��ּ���.</fi>");
	}
	else if(ErrHandler.equals("Data truncation"))
	{
		out.print("<fi>��Ȯ�� ��¥/�ð� ���� �־��ּ���.</fi>");
	}
	else
	{
		out.print("<fi>�� �� ���� ������ �߻��߽��ϴ�.</fi>");
		
	}
%>
<a href="javascript:history.back()"><input type="button" value="���ư���"></a>
</body>
</html>
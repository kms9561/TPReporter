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
	<fs>PMS �ý��ۿ��� ������ ���̴ٿ� �̸��� ������ OK�Դϴ�.<br>
	*�� �ʼ� �Է� �����Դϴ�.</fs><br>
	<fi>(�ٸ�, ��й�ȣ�� �������� ������ �� ������ �Ұ����մϴ�.)</fi>
	<% %>
	<a href="Index.jsp"><fi>�α��� ȭ������</fi></a>
	<form action="DoRegister.jsp" method="post">
		<fn>���̵�(*):</fn><input type="text" name="Userid"><br>
		<fn>��й�ȣ:</fn><input type="text" name="Password"><br>
		<fn>�̸�(*)</fn><input type="text" name="Name"><br>
		<fn>�б�:</fn><input type="text" name="University"><br>
		<fn>�а�:</fn><input type="text" name="Major"><br>
		<input type="submit" name="Register" value="�����ϱ�">
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- ���ο� ������ �߰���.  -->
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
String SuperWork=null;	//���� ���� �ؿ� �߰��ϴ� ���, ���⿡ ����.
if(request.getParameter("Super")!=null)
	SuperWork=request.getParameter("Super").toString();
//session.setAttribute("TeamName", "test");	//<-���߿� ����
String TeamName=session.getAttribute("TeamName").toString();
%>
<ft>������Ʈ�� ������ ���� ������ �߰��ϵ��� �����մϴ�.</ft>
<form name="addwork" action="DoAddWork.jsp" method="post">
<fn>��������:</fn><input type="text" name="Super" readonly value=
<% out.print(SuperWork); %> ><fi>�� �ʵ�� ������ �� �����ϴ�.</fi><br><br>
<fn>��������:</fn><input type="text" name="Content"><br><br>
<fn>��������:</fn><input type="text" name="EndDate_year"><fn>��</fn>&nbsp;
<input type="text" name="EndDate_month"><fn>�� &nbsp;</fn>
<input type="text" name="EndDate_date"><fn>�ϱ���</fn><br>
<!--  
�ִ���븶������:<input type="text" name="MaxEndDate_year">��&nbsp;
<input type="text" name="MaxEndDate_month">��&nbsp;
<input type="text" name="MaxEndDate_date">�ϱ���(�Է����� �ʾƵ� �����մϴ�.)
-->
<a href="Work.jsp"><input type="button" value="���ư���"></a><input type="submit" value="��������">
</form>
</body>
</html>
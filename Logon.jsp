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
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>

<!--  ������ ���� ��ư�� null. -->


<% String Userid=request.getParameter("Userid"); 
	String Password=request.getParameter("Password"); %>
	
	
	<!--  SQL ������ ���� ó���� ���⿡ �ְ������...
�⺻���� ������ ������ mysql���� ���ִµ� -->


<% 	if(request.getParameter("Register")==null)
	{	//�α����� ó��
		SessionManager sm=SessionManager.getInstance();
		String msghandle=sm.login(session, Userid, Password);
		if(msghandle.equals("OK"))
		{
			response.sendRedirect("Main.jsp");
		}
		else
		{
			out.print("<fi>"+msghandle+"</fi>");
		}

	}
	else
	{	//������ ó��
		response.sendRedirect("Register.jsp");
	}


	
%>


	<a href="Index.jsp"><input type="button" value="���ư���"></a><br>
	<a href="Register.jsp"><input type="button" value="�����ϱ�"></a>
</body>
</html>
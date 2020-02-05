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

<!--  DB처리를 위해 include하는 부분임 -->
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="pmsl.SessionManager" %>

<!--  누르지 않은 버튼은 null. -->


<% String Userid=request.getParameter("Userid"); 
	String Password=request.getParameter("Password"); %>
	
	
	<!--  SQL 인젝션 방지 처리를 여기에 넣고싶은뎀...
기본적인 인젝션 방지는 mysql에서 해주는듯 -->


<% 	if(request.getParameter("Register")==null)
	{	//로그인의 처리
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
	{	//가입의 처리
		response.sendRedirect("Register.jsp");
	}


	
%>


	<a href="Index.jsp"><input type="button" value="돌아가기"></a><br>
	<a href="Register.jsp"><input type="button" value="가입하기"></a>
</body>
</html>
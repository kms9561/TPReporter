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
<%@page errorPage="Error.jsp" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>

<% Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null; 
	long TeamID=Integer.valueOf(request.getParameter("TeamID"));
	String MemberID=session.getAttribute("MemberID").toString();
	out.print("INSERT INTO TEAMJOIN VALUES("+TeamID+",'"+MemberID+"')");
	st.execute("INSERT INTO TEAMJOIN VALUES("+TeamID+",'"+MemberID+"')");
	response.sendRedirect("SelectTeam.jsp");
%>
</body>
</html>
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
<%@page import="pmsl.PMSlib" %>
<%	
	String TeamName=request.getParameter("Select");
	session.setAttribute("TeamName", TeamName);
	Connection conn=DBconnecter.getConnection();
	int TeamID=-1;
	Statement st=conn.createStatement();
	ResultSet rs=st.executeQuery("SELECT TeamID from Team where TeamName='"+TeamName+"'");
	while(rs.next())
	{
		TeamID=rs.getInt("TeamID");
		break;
	}
	conn.close();
	session.setAttribute("TeamID", TeamID);
	//팀 선택  버튼 이름이 죄다 select인데, value값을 리턴함. 다만 팀명은 PK가 아님.
	response.sendRedirect("SelectTeam.jsp");
%><br>

</body>
</html>
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
<%@page import="pmsl.AuthManager" %>
<%@page import="pmsl.FileDesc" %>
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!<br></fib>
	<a href="SelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="11%"></a>
	<a href="CreateTeam.jsp"><img src="Images/Menu_Team.jpg" width="11%"></a>
	<a href="ManageDaily.jsp"><img src="Images/Menu_Daily.jpg" width="11%"></a>
	<a href="TeamDaily.jsp"><img src="Images/Menu_TeamDaily.jpg" width="11%"></a>
	<a href="Work.jsp"><img src="Images/Menu_Work.jpg" width="11%"></a>
	<a href="Gantt.jsp"><img src="Images/Menu_Gantt.jpg" width="11%"></a>
	<a href="Auth.jsp"><img src="Images/Menu_Auth.jpg" width="11%"></a>
	<a href="Board.jsp"><img src="Images/Menu_Board.jpg" width="11%"></a>
	</div>
<!--  누르지 않은 버튼은 null. -->


<% String Userid=request.getParameter("Userid"); 
	String Name=request.getParameter("Name");
	String Password=request.getParameter("Password");
	String University=request.getParameter("University");
	String Major=request.getParameter("Major");
	%>
<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	//out.println("INSERT INTO MEMBER VALUES('"+ Userid+"','"+Name+"','"+Password+"','"+University+"','"+Major+"'"+")");
	ResultSet rs=null;
	rs=st.executeQuery("SELECT Memberid from member where Memberid='"+Userid+"'");
	
	if(rs.next())
	{
		out.print("<fi>이미 있는 아이디입니다!</fi>");
	}else if(Userid.equals("")|Name.equals("")){
		out.print("아이디 또는 이름이 공란입니다!");
	}
	else
	{
		Userid=Userid.trim(); //인증서 기능 추가 과정에서, ID에 공백이 들어가면 안 된다.
		
		st.execute("INSERT INTO MEMBER VALUES('"+ Userid+"','"+Name+"','"+Password+"','"+University+"','"+Major+"'"+")");	//i,u,d처리
		//공개키와 비밀키를 형성해서 저장시켜 줘야 한다.
		AuthManager.RegisterMemberKey(Userid, request.getRealPath("/"));
		out.print("<fs>TPR에 가입하신 것을 환영합니다!</fs>");
	}
	conn.close();
%>
<br>
<a href="Register.jsp"><input type="button" value="돌아가기"></a>      <a href="Index.jsp">
<input type="button" value="로그인 화면으로"></a>
</body>
</html>
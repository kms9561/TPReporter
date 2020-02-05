<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<%@page import="pmsl.PMSlib" %>

<% %>
<% 	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();	
	ResultSet rs=null;
	rs=st.executeQuery("SELECT ChatID from Chatlog order by ChatID desc");
	int chatID=-1;
	if(rs.next())
	{
		chatID=Integer.valueOf(rs.getString("ChatID"))+1;
	}else{
		chatID=0;
	}
	
	int TeamID=2;
	String EndDate=PMSlib.getNowDate();
	String TeamName=session.getAttribute("TeamName").toString();
	rs=st.executeQuery("SELECT TeamID,EndDate from Team where TeamName='"+TeamName+"'");
	while(rs.next()){
		TeamID=Integer.valueOf(rs.getString("TeamID"));
		EndDate=PMSlib.getEndDateAdded(rs.getString("EndDate"));
	}
	String MemberID=session.getAttribute("MemberID").toString();
	
	
	
	
	request.setCharacterEncoding("EUC-KR");
	String Content=request.getParameter("chatText").toString();
	out.print("INSERT INTO CHATLOG VALUES("+chatID+","+String.valueOf(TeamID)+",'"+MemberID+"','"+EndDate+"','"+Content+"')");
	st.execute("INSERT INTO CHATLOG VALUES("+chatID+","+String.valueOf(TeamID)+",'"+MemberID+"','"+EndDate+"','"+Content+"')");
	conn.close();
	response.sendRedirect("Chat.jsp");

%>
</body>
</html>
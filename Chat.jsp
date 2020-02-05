<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- 
<META HTTP-EQUIV="refresh" CONTENT="4">
	<frameset rows="80%,20%">
		
		
		<frame src="Chat_Log.jsp" name="top">
		<frame src="Chat_Add.jsp" name="bot">
	</frameset>
 -->
 <link rel="stylesheet" href="Design.css">
 <%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.DBconnecter" %>
<title>Insert title here</title>
<script>



//엔터 치면 채팅 기록되도록 하기 위해... 이렇게 하면 된다고 함
function init(){
	form=document.getElementById("addChat");
	text=document.getElementById("chatText");
	text.addEventListener("keypress",doChat,flase);
	
}
function doChat(){
	
	form.submit();
}
window.addEventListener("load",init,false);
</script>
</head>
<body>

<% int maxChatlog=10; %>


<% 	
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;

%>
<!-- 채팅 입력부 -->
<div id="chatAdd">
	<form id="addChat" action="DoChat.jsp" method="post">
		<input type="text" width="500" name="chatText">
		<input type="submit" value="등록" name="submit">
		<input type="button" value="새로고침" name="refresh" onClick="window.location.reload()">
	</form>
	</div>
	
	<hr>
	
<!-- 채팅 표시부 -->	
	<div id="chatlog">
	<%
		rs=st.executeQuery("select ChatID,MemberID, Content from ChatLog where teamID='test' order by ChatID desc");
		int nowChatlog=0;
		while(rs.next()&&nowChatlog<maxChatlog)
		{
			out.print("<fh>"+rs.getString("MemberID")+"</fh>");	out.print("<br>");
			out.print("<fn>"+rs.getString("Content")+"</fn>");
			out.print("<br><br>");
		}
	%>

	</div>



</body>
</html>
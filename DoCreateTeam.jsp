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


	
<% long TeamID=PMSlib.getRandom();
if(TeamID<0)
	TeamID=0-TeamID*2;
%>

<!--  누르지 않은 버튼은 null. -->

<% String TeamName=request.getParameter("TeamName"); 
String LeaderID=null;






String ProjectName=request.getParameter("ProjectName"); 
String StartDate=DBconnecter.getNowDate();
String EndDate=DBconnecter.makeDate(Integer.valueOf(request.getParameter("year")),
		Integer.valueOf(request.getParameter("month")),
		Integer.valueOf(request.getParameter("date"))
		);
if(EndDate.equals("ERROR"))
{//일자 입력값 무결성 위반 처리
	response.sendError(400, "Error.jsp");
}

%>
<%
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	
	String LeaderPassword=null;
	
	rs=st.executeQuery("SELECT TeamID from Team where TeamId="+TeamID);
	int flag=0;
	while(rs.next()&&flag<10)
	{
		TeamID=DBconnecter.getRandom();


	}
	if(flag>=10)
	{
		out.print("<fi>죄송합니다. 잠시 후 다시 시도해 주세요.</fi>"); //해시코드 중복이 10번이나 반복;;;
	}else{
		LeaderID=session.getAttribute("MemberID").toString();
		//위에서 다른 텍스트는 저대로 해도 무방하나 DATE값은 무결성 처리 반드시 주의해서 할 것!!!!
		rs=st.executeQuery("SELECT Password from Member where MemberID='"+LeaderID+"'");
		while(rs.next())
		{
			LeaderPassword=rs.getString("Password");
			break;
		}
		if(LeaderPassword==null||LeaderPassword.length()<2)
		{
			out.print("<fi>비밀번호가 설정되지 않은 계정은 팀을 생성할 수 없습니다.<br>");
			out.print("비밀번호를 설정해 주세요.</fi>");
		}
		else
		{	
			st.execute("INSERT into Team VALUES("+TeamID+",'"+TeamName+"','"+LeaderID+"','"+ProjectName+"','"+StartDate+"','"+EndDate+"')");
			//out.print("INSER into TeamJoin VALUES("+TeamID+",'"+LeaderID+"')");
			st.execute("INSERT into TeamJoin VALUES("+TeamID+",'"+LeaderID+"')");
			out.print("<fi>고유번호가 "+TeamID+"인 팀이 생성되었습니다!</fi><br>");
			out.print("<fi>이 고유번호를 팀원들과 공유하세요. 고유번호를 잊으셨다고요? 팀 관리 창에서 확인하세요!</fi>");
		}
	}
	conn.close();
%>
<br>
<a href="SelectTeam.jsp"><input type="button" value="돌아가기"></a>
</body>
</html>
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

<%@page import="pmsl.DBconnecter" %>
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!</fib>
	<a href="Chat.jsp" target="_blank"><fh>채팅하기</fh></a><br>
	
	
	
<%
//createTeam.jsp는 팀 선택 없이(세션정보없이) 접근 가능하므로 다음과 같이 메뉴를 예외적으로 만든다.
	if(session.getAttribute("TeamID")==null)
	{
		//out.print("팀 선택 없는 상태.");
		out.print("<a href='Main.jsp'><img src='Images/Menu_Project.jpg' width='12%'></a>"+
				"<a href='CreateTeam.jsp'><img src='Images/Menu_Team.jpg' width='12%'></a>"+
				"<a href='PleaseSelectTeam.jsp'><img src='Images/Menu_Daily.jpg' width='12%'></a>"+
				"<a href='PleaseSelectTeam.jsp'><img src='Images/Menu_TeamDaily.jpg' width='12%'></a>"+
				"<a href='PleaseSelectTeam.jsp'><img src='Images/Menu_Work.jpg' width='12%'></a>"+
				"<a href='PleaseSelectTeam.jsp'><img src='Images/Menu_Gantt.jpg' width='12%'></a>"+
				"<a href='PleaseSelectTeam.jsp'><img src='Images/Menu_Auth.jpg' width='12%'></a>"
				
				);
	}
	else
	{
		out.print("<a href='SelectTeam.jsp'><img src='Images/Menu_Project.jpg' width='12%'></a>"+
				"<a href='CreateTeam.jsp'><img src='Images/Menu_Team.jpg' width='12%'></a>"+
				"<a href='ManageDaily.jsp'><img src='Images/Menu_Daily.jpg' width='12%'></a>"+
				"<a href='TeamDaily.jsp'><img src='Images/Menu_TeamDaily.jpg' width='12%'></a>"+
				"<a href='Work.jsp'><img src='Images/Menu_Work.jpg' width='12%'></a>"+
				"<a href='Gantt.jsp'><img src='Images/Menu_Gantt.jpg' width='12%'></a>"+
				"<a href='Auth.jsp'><img src='Images/Menu_Auth.jpg' width='12%'></a>"
				);
	}
%>
	
	</div>
	
	
	
	
	<fs>오직 고유번호만 공유하면 같은 팀으로 작업할 수 있습니다.</fs><br>
	<div>
		<form name="inputform" action="DoCreateTeam.jsp" method="post">
			<fn>팀 이름:<input type="text" name="TeamName"></fn><br>
			<fn>프로젝트명:<input type="text" name="ProjectName">(입력하지 않아도 무방합니다.)</fn><br>
			<fn>프로젝트 종료일자:<input type="text" width=5 name="year">년</fn> 
			<input type="text" width="5" name="month"><fn>월</fn>
			<input type="text" width="5" name="date"><fn>일</fn>
			<br><input type="submit" value="팀을 생성합니다.">
		</form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- 새로운 업무를 추가함.  -->
</head>
<body>
	<div id="menu">
	<img src="Images/TPR Logo.jpg" width="80px">
	<fib><% out.print(session.getAttribute("Name")); %>님 환영합니다!</fib>
	<a href="Chat.jsp" target="_blank"><fh>채팅하기</fh></a><br>
	<a href="SelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="12%"></a>
	<a href="CreateTeam.jsp"><img src="Images/Menu_Team.jpg" width="12%"></a>
	<a href="ManageDaily.jsp"><img src="Images/Menu_Daily.jpg" width="12%"></a>
	<a href="TeamDaily.jsp"><img src="Images/Menu_TeamDaily.jpg" width="12%"></a>
	<a href="Work.jsp"><img src="Images/Menu_Work.jpg" width="12%"></a>
	<a href="Gantt.jsp"><img src="Images/Menu_Gantt.jpg" width="12%"></a>
	<a href="Auth.jsp"><img src="Images/Menu_Auth.jpg" width="12%"></a>
	
	</div>
<%
String SuperWork=null;	//상위 업무 밑에 추가하는 경우, 여기에 저장.
if(request.getParameter("Super")!=null)
	SuperWork=request.getParameter("Super").toString();
//session.setAttribute("TeamName", "test");	//<-나중에 삭제
String TeamName=session.getAttribute("TeamName").toString();
%>
<ft>프로젝트에 다음과 같은 업무를 추가하도록 제안합니다.</ft>
<form name="addwork" action="DoAddWork.jsp" method="post">
<fn>상위업무:</fn><input type="text" name="Super" readonly value=
<% out.print(SuperWork); %> ><fi>이 필드는 수정할 수 없습니다.</fi><br><br>
<fn>업무내용:</fn><input type="text" name="Content"><br><br>
<fn>마감기한:</fn><input type="text" name="EndDate_year"><fn>년</fn>&nbsp;
<input type="text" name="EndDate_month"><fn>월 &nbsp;</fn>
<input type="text" name="EndDate_date"><fn>일까지</fn><br>
<!--  
최대허용마감기한:<input type="text" name="MaxEndDate_year">년&nbsp;
<input type="text" name="MaxEndDate_month">월&nbsp;
<input type="text" name="MaxEndDate_date">일까지(입력하지 않아도 무방합니다.)
-->
<a href="Work.jsp"><input type="button" value="돌아가기"></a><input type="submit" value="업무제안">
</form>
</body>
</html>
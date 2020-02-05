<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<%@ page import="java.io.File" %>
<%@page import="pmsl.DBconnecter" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
</head>
<body>
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
<%	//나중에 삭제
	session.setAttribute("TeamID", "0");
	session.setAttribute("MemberID", "test");
%>

<%
	String FileName=request.getParameter("FileName");
	String TeamID=session.getAttribute("TeamID").toString();
	//TeamID는 실제로 숫자.
	String UploaderID=null;
	String DeleterID=session.getAttribute("MemberID").toString();
	
	//복잡하지만, 업로드 ID를 GET으로 받다간 권한없는 사람의 무단 삭제가 가능하므로, DB를 검색한다.
	Connection conn=DBconnecter.getConnection();
	Statement st=conn.createStatement();
	ResultSet rs=null;
	rs=st.executeQuery("SELECT MemberID from File where FileName='"+FileName+"'");
	while(rs.next())
	{
		UploaderID=rs.getString("MemberID");
		break;
	}
	String filePath="/upload/"+TeamID+"/"+UploaderID+"/";
	String sPath=request.getRealPath("/upload/"+TeamID+"/"+UploaderID+"/");
	String deletePath=sPath+"/"+FileName;

	File file=new File(sPath+FileName);
	if(file.exists())
	{
		if(DeleterID.equals(UploaderID))
		{
			if(file.delete())
			{
				out.print("<fi>파일을 성공적으로 삭제했습니다.</fi>");
				st.execute("DELETE FROM FILE where MemberID='"+UploaderID+"'");
			}
			else
			{
				out.print("<fi>에러:파일 삭제에 실패했습니다.</fi>");
			}
		}
		else
		{//권한 없음
			out.print("<fi>에러:파일을 업로드한 사람이 아니면, 삭제할 수 없습니다.</fi>");
		}
		
	}
	else
	{//파일 없음
		out.print("<fi>에러:파일이 존재하지 않습니다.</fi>");
		
	}

%>
<br>
<a href="Download.jsp"><input type="button" value="돌아가기"></a>
<a href="Work.jsp"><input type="button" value="작업 화면으로 돌아가기"></a>
</body>
</html>
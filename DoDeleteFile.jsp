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
	<fib><% out.print(session.getAttribute("Name")); %>�� ȯ���մϴ�!<br></fib>
	<a href="SelectTeam.jsp"><img src="Images/Menu_Project.jpg" width="11%"></a>
	<a href="CreateTeam.jsp"><img src="Images/Menu_Team.jpg" width="11%"></a>
	<a href="ManageDaily.jsp"><img src="Images/Menu_Daily.jpg" width="11%"></a>
	<a href="TeamDaily.jsp"><img src="Images/Menu_TeamDaily.jpg" width="11%"></a>
	<a href="Work.jsp"><img src="Images/Menu_Work.jpg" width="11%"></a>
	<a href="Gantt.jsp"><img src="Images/Menu_Gantt.jpg" width="11%"></a>
	<a href="Auth.jsp"><img src="Images/Menu_Auth.jpg" width="11%"></a>
	<a href="Board.jsp"><img src="Images/Menu_Board.jpg" width="11%"></a>
	</div>
<%	//���߿� ����
	session.setAttribute("TeamID", "0");
	session.setAttribute("MemberID", "test");
%>

<%
	String FileName=request.getParameter("FileName");
	String TeamID=session.getAttribute("TeamID").toString();
	//TeamID�� ������ ����.
	String UploaderID=null;
	String DeleterID=session.getAttribute("MemberID").toString();
	
	//����������, ���ε� ID�� GET���� �޴ٰ� ���Ѿ��� ����� ���� ������ �����ϹǷ�, DB�� �˻��Ѵ�.
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
				out.print("<fi>������ ���������� �����߽��ϴ�.</fi>");
				st.execute("DELETE FROM FILE where MemberID='"+UploaderID+"'");
			}
			else
			{
				out.print("<fi>����:���� ������ �����߽��ϴ�.</fi>");
			}
		}
		else
		{//���� ����
			out.print("<fi>����:������ ���ε��� ����� �ƴϸ�, ������ �� �����ϴ�.</fi>");
		}
		
	}
	else
	{//���� ����
		out.print("<fi>����:������ �������� �ʽ��ϴ�.</fi>");
		
	}

%>
<br>
<a href="Download.jsp"><input type="button" value="���ư���"></a>
<a href="Work.jsp"><input type="button" value="�۾� ȭ������ ���ư���"></a>
</body>
</html>
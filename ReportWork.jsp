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
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="pmsl.WorkManager" %>
<%@page import="java.sql.ResultSet" %>
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
final int MAXLEVEL=8;
String[] LevelColor=new String[8]; //십의자리를 상징하는 색깔.
LevelColor[0]="#EEFEC8";
LevelColor[1]="#CEFEC8";
LevelColor[2]="#AEFEC8";
LevelColor[3]="#8EFEC8";
LevelColor[4]="#6EFEC8";
LevelColor[5]="#4EFEC8";
LevelColor[6]="#2EFED8";
LevelColor[7]="#0EFEE8";
String[] LevelString=new String[8];
LevelString[0]="준비중";
LevelString[1]="조사/학습중";
LevelString[2]="설계중";
LevelString[3]="제작중";
LevelString[4]="테스트중";
LevelString[5]="수정중";
LevelString[6]="발표/설명작업중";
LevelString[7]="작업완료";
String[] DetailColor=new String[10];
DetailColor[0]="skyblue";
DetailColor[1]="skyblue";
DetailColor[2]="skyblue";
DetailColor[3]="skyblue";
DetailColor[4]="skyblue";
DetailColor[5]="skyblue";
DetailColor[6]="skyblue";
DetailColor[7]="skyblue";
DetailColor[8]="skyblue";
DetailColor[9]="skyblue";
String WorkName="";
%>

<%
int MadeRate=0;
//int WorkID=-1;
String WorkID=null; //실제는 숫자값.
int code=0;
int dcode=0;

if(request.getParameter("WorkID")!=null)
{
	WorkID=request.getParameter("WorkID").toString();
	
}else{
	response.sendRedirect("Work.jsp");	//<-WorkID에러.

}



Connection conn=DBconnecter.getConnection();
Statement st=conn.createStatement();
ResultSet rs=null;
ResultSet rs2=null;
String TempTeamID="";
int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
rs2=st.executeQuery("SELECT WorkID, TeamID from Work where TeamID="+TeamID+" AND WorkID="+WorkID);
if(!rs2.next())
{ //권한 없음
	
	response.sendRedirect("UserError.jsp");
}
rs2.close();

if(request.getParameter("code")!=null)
{
	rs=st.executeQuery("SELECT MadeRate from Work where WorkID="+WorkID);
	while(rs.next())
	{
		MadeRate=rs.getInt("MadeRate");
		break;
	}
	code=Integer.valueOf(request.getParameter("code").toString());
	if(code==80) 
	{
		code=79;	//80코드처리를 따로 해 줄 것!
	}
	
}
else
{	//코드가 없는 경우로, DB처리가 필요함!

	
	 rs=st.executeQuery("SELECT MadeRate from Work where WorkID="+WorkID);
	while(rs.next())
	{
		MadeRate=rs.getInt("MadeRate");
		break;
	}
	response.sendRedirect("ReportWork.jsp?WorkID="+WorkID+"&code="+MadeRate);
}
%>
<%
rs=st.executeQuery("SELECT content from work where WorkID="+WorkID);
while(rs.next())
{
	WorkName=rs.getString("Content");
	break;
}
%>
<fs>현재 진행중인 작업이 얼마나 진행되었나요?</fs><br>
<fh>현재 작업중 작업:<%=WorkName %><br>
단계:<%=LevelString[code/10] %></fh>

<center>
<table border="1" id="levelProcess">

<tr>
<%
for(int i=0;i<MAXLEVEL;i++)
{
	out.print("<td ");
	if(code/10>=i)
	{
		out.print("bgColor='"+LevelColor[i]+"'>");
	}else{
		out.print("><fn>");
	}
	out.print(LevelString[i]+"<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+(i*10+code%10)+"'><input type='button' value='선택'></a></fn></td>");
}
%>

</tr>

</table>
</center>

<br>
<fh>완료한 정도:대략 <%=code%10*10 %>%정도</fh><br>
<center>
<table>
<tr>
<%
for(int i=0;i<10;i++)
{
	out.print("<td ");
	if(code%10>=i)
	{
		out.print("bgColor='"+DetailColor[i]+"'>");
	}else{
		out.print("><fn>");
	}
	
	out.print((i*10)+"%<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+(code/10*10+i)+"'><input type='button' value='완료'></a></fn></td>");
}
%>
<td><% out.print("<fn>전부<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+((code/10+1)*10)+"'><input type='button' value='완료'></a></fn></td>"); %>
</tr></table>
</center>
<form method="post" action="Upload.jsp">
	<input type="hidden" name="WorkID" value=<%=WorkID %>>
	<input type="submit" value="자료 업로드">
</form>
<form method="post" action="Download.jsp">
	<input type="hidden" name="WorkID" value=<%=WorkID %>>
	<input type="submit" value="자료 다운로드">
</form>

<a href="DoReportWork.jsp?code=<%=code %>&WorkID=<%=WorkID%>"><input type="button" value="이 상태로 저장"></a>
</body>
</html>
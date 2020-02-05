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
	<fib><% out.print(session.getAttribute("Name")); %>�� ȯ���մϴ�!</fib>
	<a href="Chat.jsp" target="_blank"><fh>ä���ϱ�</fh></a><br>
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
String[] LevelColor=new String[8]; //�����ڸ��� ��¡�ϴ� ����.
LevelColor[0]="#EEFEC8";
LevelColor[1]="#CEFEC8";
LevelColor[2]="#AEFEC8";
LevelColor[3]="#8EFEC8";
LevelColor[4]="#6EFEC8";
LevelColor[5]="#4EFEC8";
LevelColor[6]="#2EFED8";
LevelColor[7]="#0EFEE8";
String[] LevelString=new String[8];
LevelString[0]="�غ���";
LevelString[1]="����/�н���";
LevelString[2]="������";
LevelString[3]="������";
LevelString[4]="�׽�Ʈ��";
LevelString[5]="������";
LevelString[6]="��ǥ/�����۾���";
LevelString[7]="�۾��Ϸ�";
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
String WorkID=null; //������ ���ڰ�.
int code=0;
int dcode=0;

if(request.getParameter("WorkID")!=null)
{
	WorkID=request.getParameter("WorkID").toString();
	
}else{
	response.sendRedirect("Work.jsp");	//<-WorkID����.

}



Connection conn=DBconnecter.getConnection();
Statement st=conn.createStatement();
ResultSet rs=null;
ResultSet rs2=null;
String TempTeamID="";
int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
rs2=st.executeQuery("SELECT WorkID, TeamID from Work where TeamID="+TeamID+" AND WorkID="+WorkID);
if(!rs2.next())
{ //���� ����
	
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
		code=79;	//80�ڵ�ó���� ���� �� �� ��!
	}
	
}
else
{	//�ڵ尡 ���� ����, DBó���� �ʿ���!

	
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
<fs>���� �������� �۾��� �󸶳� ����Ǿ�����?</fs><br>
<fh>���� �۾��� �۾�:<%=WorkName %><br>
�ܰ�:<%=LevelString[code/10] %></fh>

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
	out.print(LevelString[i]+"<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+(i*10+code%10)+"'><input type='button' value='����'></a></fn></td>");
}
%>

</tr>

</table>
</center>

<br>
<fh>�Ϸ��� ����:�뷫 <%=code%10*10 %>%����</fh><br>
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
	
	out.print((i*10)+"%<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+(code/10*10+i)+"'><input type='button' value='�Ϸ�'></a></fn></td>");
}
%>
<td><% out.print("<fn>����<br><a href='ReportWork.jsp?WorkID="+WorkID+"&code="+((code/10+1)*10)+"'><input type='button' value='�Ϸ�'></a></fn></td>"); %>
</tr></table>
</center>
<form method="post" action="Upload.jsp">
	<input type="hidden" name="WorkID" value=<%=WorkID %>>
	<input type="submit" value="�ڷ� ���ε�">
</form>
<form method="post" action="Download.jsp">
	<input type="hidden" name="WorkID" value=<%=WorkID %>>
	<input type="submit" value="�ڷ� �ٿ�ε�">
</form>

<a href="DoReportWork.jsp?code=<%=code %>&WorkID=<%=WorkID%>"><input type="button" value="�� ���·� ����"></a>
</body>
</html>
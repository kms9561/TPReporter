<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="Design.css">

</head>
<body>

<%
String ResultString="<fi>���⿡ ���� ����� ǥ�õ˴ϴ�.</fi>";
if(request.getParameter("Result")!=null)
{
	if(request.getParameter("Result").toString().equals("true"))
	{
		ResultString="<img src='Images/Auth_OK.jpg'><fi>������ �����߽��ϴ�. �� ������/������ �����մϴ�.</fi>";
	}else if(request.getParameter("Result").toString().equals("false")){
		ResultString="<img src='Images/Auth_Fail.jpg'><fi>������ �����߽��ϴ�. �� ������/������ �ջ�,����,�����Ǿ����ϴ�.</fi>";
	}else{
		ResultString="<img src='Images/Auth_Fail.jpg'><fi>���� ������ ���ε� �� �� �����ϴ�.</fi>";
	}
	
}
%>
<ft>�α��� ����, �������� Ȯ�� �� �� �ֽ��ϴ�.</ft><br>
<form method="post" action="DoAuthCert.jsp" enctype="multipart/form-data">

<fs>������ ���� ������ Ȯ���մϴ�.</fs><br>
<input type="file" name="TeamCert" accept=".txt">
<input type="submit" value="������ ����">
</form>

<br><br>

<form method="post" action="DoAuthFile.jsp" enctype="multipart/form-data">
<fs>������ �ø� ����� �������� �´��� Ȯ���մϴ�.</fs><br>
<fi>����: </fi><input type="file" name="File" id="File"><br>
<fi>������:</fi><input type="file" name="Cert" id="Cert" accept=".txt">
<input type="submit" value="���� ����">
</form>

<br>


<fh>������ �����̶� �����ϰų�, Ű�� �����߰ų�, ���� �̸��� �ٲپ����� ������ �����մϴ�.</fh>
<br><br>

<table>
<tr><td><fs>���� ����� ǥ�õ˴ϴ�.</fs>
<div name="Result" id="Result">
<%=ResultString %>
</div>
</td></tr>
</table>
</body>
</html>
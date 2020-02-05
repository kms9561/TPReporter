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
String ResultString="<fi>여기에 인증 결과가 표시됩니다.</fi>";
if(request.getParameter("Result")!=null)
{
	if(request.getParameter("Result").toString().equals("true"))
	{
		ResultString="<img src='Images/Auth_OK.jpg'><fi>인증에 성공했습니다. 이 인증서/파일은 정당합니다.</fi>";
	}else if(request.getParameter("Result").toString().equals("false")){
		ResultString="<img src='Images/Auth_Fail.jpg'><fi>인증에 실패했습니다. 이 인증서/파일은 손상,변경,위조되었습니다.</fi>";
	}else{
		ResultString="<img src='Images/Auth_Fail.jpg'><fi>실행 파일을 업로드 할 수 없습니다.</fi>";
	}
	
}
%>
<ft>로그인 없이, 인증서를 확인 할 수 있습니다.</ft><br>
<form method="post" action="DoAuthCert.jsp" enctype="multipart/form-data">

<fs>인증서 변조 유무를 확인합니다.</fs><br>
<input type="file" name="TeamCert" accept=".txt">
<input type="submit" value="인증서 인증">
</form>

<br><br>

<form method="post" action="DoAuthFile.jsp" enctype="multipart/form-data">
<fs>파일을 올린 사람이 인증서와 맞는지 확인합니다.</fs><br>
<fi>파일: </fi><input type="file" name="File" id="File"><br>
<fi>인증서:</fi><input type="file" name="Cert" id="Cert" accept=".txt">
<input type="submit" value="파일 인증">
</form>

<br>


<fh>파일을 조금이라도 수정하거나, 키를 변경했거나, 파일 이름을 바꾸었으면 인증에 실패합니다.</fh>
<br><br>

<table>
<tr><td><fs>인증 결과가 표시됩니다.</fs>
<div name="Result" id="Result">
<%=ResultString %>
</div>
</td></tr>
</table>
</body>
</html>
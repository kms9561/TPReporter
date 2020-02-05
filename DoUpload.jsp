<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="Design.css">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="pmsl.DBconnecter" %>
<%@page import="java.io.File"%>
<%@page import="pmsl.PMSlib" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.Calendar" %>
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


	<%
	String WorkID="-1"; //<-multi에서 가져옴. 이건 초기화값.

	String TeamID=session.getAttribute("TeamID").toString();
	String MemberID=session.getAttribute("MemberID").toString();
	
	String Content="";

	
	
	String fileName = "";
	String orgfileName= "";

	
	String uploadPath = request.getRealPath("/upload/"); // upload는 폴더명 / 폴더의 경로를 구해옴
	
	
	//해당 폴더가 있는지 차근차근 확인한다.
	uploadPath=uploadPath+TeamID+"/";
	File folder=new File(uploadPath);
	if(!folder.exists())
	{
		try{
			folder.mkdir();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	uploadPath=uploadPath+MemberID+"/";
	folder=new File(uploadPath);
	if(!folder.exists())
	{
		try{
			folder.mkdir();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	//폴더가 업다면, 생성되었고, uploadPath도 특정 폴더를 가리킨다.
	//이 부분에서 파일 필터링 처리 해 줘야...
	try {
		MultipartRequest multi = new MultipartRequest( 
				request, 
				uploadPath, 
				10 * 1024, 
				"utf-8", 
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);

		fileName = multi.getFilesystemName("file"); 
		orgfileName = multi.getOriginalFileName("file"); 
		WorkID=multi.getParameter("WorkID");
	
		if(PMSlib.isSafeFileName(fileName))
		{
			//DB에 정보를 갱신한다.
			Connection conn=DBconnecter.getConnection();
			Statement st=conn.createStatement();
			st.execute("UPDATE Work SET FileExist='O' where WorkID="+WorkID);
			Calendar c=Calendar.getInstance();
			String DateString=c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DATE);
			st.execute("INSERT into File values("+TeamID+",'"+MemberID+"',"+WorkID+",'"+fileName+"','"+
					DateString+"','"+Content+"')");
			st.close();
			conn.close();
			response.sendRedirect("Download.jsp");
		}
		else
		{	//실행파일
			File delFile=new File(uploadPath+"/"+fileName);
			delFile.delete();
			out.print("<fi>실행 파일은 업로드 할 수 없습니다.</fi>");
		}
	} catch (Exception e) {
		e.getStackTrace();
	} // 업로드 종료
	
%>
<br>
<input type="button" value="돌아가기" onclick="history.back(-1);">
</body>

</html>
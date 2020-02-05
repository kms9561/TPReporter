<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
<%@ page import="pmsl.AuthManager" %>
<%@ page import="pmsl.FileDesc" %>


	<%
	
	
	
	String fileName = "";
	String orgfileName= "";
	String certFileName="";
	String orgCertFileName="";
	
	String uploadPath = request.getRealPath("/temp/certificate"); // upload는 폴더명 / 폴더의 경로를 구해옴
	
	
	//해당 폴더가 있는지 차근차근 확인한다.

	File folder=new File(uploadPath);
	if(!folder.exists())
	{
		try{
			folder.mkdirs();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	//폴더가 업다면, 생성되었고, uploadPath도 특정 폴더를 가리킨다.
	
	
	//이 부분에서 파일 필터링 처리 해 줘야...
	
	try {
		MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024, // 첨부파일 최대 용량 설정(bite) / 10KB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);

		fileName = multi.getFilesystemName("File"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
		orgfileName = multi.getOriginalFileName("File"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
		certFileName=multi.getFilesystemName("Cert");
		orgCertFileName=multi.getOriginalFileName("Cert");
		File delFile=null;
		File delCert=null;
		if(PMSlib.isSafeFileName(fileName))
		{
			//인증 처리를 해 준다.
			//AuthManager am=AuthManager.getInstance();0
			File file=new File(uploadPath+"/"+fileName);
			File cert=new File(uploadPath+"/"+certFileName);
			boolean result=AuthManager.authFile(file, cert, request.getRealPath("/"));
			out.print(result);
			delFile=new File(uploadPath+"/"+fileName);
			delCert=new File(uploadPath+"/"+certFileName);
			delFile.delete();
			delCert.delete();
			out.print("uploadPath:"+uploadPath+"<br>");
			out.print("인증 성공 여부:"+result);
			response.sendRedirect("AuthCheck.jsp?Result="+result);

		}
		else
		{	//실행파일
			delFile=new File(uploadPath+"/"+fileName);
			delCert=new File(uploadPath+"/"+certFileName);
			delFile.delete();
			delCert.delete();
		
			response.sendRedirect("AuthCheck.jsp?Result=uploadFail");
		}
		
	} catch (Exception e) {
		out.print("에러 발생");
		out.print(e.getMessage()+"<br>");
		out.print(e.getStackTrace()+"<br>");
		out.print(uploadPath);
		e.getStackTrace();
	} // 업로드 종료
	out.print("아무것도 못함");
%>
</body>
</html>
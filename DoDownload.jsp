
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<head>
<link rel="stylesheet" href="Design.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 다운로드 페이지</title>
</head>
<body>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>



<%
	String TeamID=session.getAttribute("TeamID").toString();
	String MemberID=session.getAttribute("MemberID").toString();
    String fileName = request.getParameter("FileName"); //<-파일만의 이름이다.
     
    // 업로드한 폴더의 위치와 업로드 폴더의 이름을 알아야 한다.
 // WebContent/upload
    String uploadPath = request.getRealPath("/upload/"+TeamID+"/"+MemberID+"/");
    String sFilePath = uploadPath + fileName;
    System.out.println("sFilePath : " + sFilePath);
    File outputFile =new File(sFilePath);
    byte[] temp =new byte[1024*1024*10];
     
    FileInputStream in =new FileInputStream(outputFile);
     
 
    String sMimeType = getServletContext().getMimeType(sFilePath);
    if ( sMimeType ==null )
        sMimeType ="application.octec-stream";

     
    //파일 다운로드 시작
    response.setContentType(sMimeType);
    String sEncoding =new String(fileName.getBytes("euc-kr"),"8859_1"); //인코딩
  	//기타 내용
    String FileNameCode ="attachment;filename="+sEncoding;
    response.setHeader("Content-Disposition",FileNameCode);
    //브라우저에 쓰기
    ServletOutputStream out2 = response.getOutputStream();
    int numRead =0;
    while((numRead = in.read(temp,0,temp.length)) != -1)
    {//temp 배열에 읽어올건데 0번째 인덱스부터 한번에 최대 temp.length 만큼 읽어온다.

        out2.write(temp,0,numRead);
    }
    // 자원 해제
    out2.flush();
    out2.close();
    in.close();
 	
%>

</body>


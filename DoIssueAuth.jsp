<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ page import="pmsl.AuthManager" %>
<%@ page import="java.io.File" %>
<%@page import="java.io.FileInputStream"%>
<%
	
	int TeamID=Integer.valueOf(session.getAttribute("TeamID").toString());
	File cert=AuthManager.addCertificate(TeamID,request.getRealPath("/"));
	
   
    byte[] temp =new byte[1024*1024*10];
    String CertFileName=cert.getName();
    FileInputStream in =new FileInputStream(cert);
    String sMimeType = getServletContext().getMimeType(cert.getPath());

    // �������� ���� ���� ����ó��
    if ( sMimeType ==null )
        sMimeType ="application.octec-stream";
    
    
    //���� �ٿ�ε� ����
    response.setContentType(sMimeType);
    
    //���ڵ�
    String sEncoding =new String(CertFileName.getBytes("euc-kr"),"8859_1");
    String CD ="Content-Disposition";
    String FileNameCode ="attachment;filename="+sEncoding;
    response.setHeader(CD,FileNameCode);
     
    // �������� ����
    ServletOutputStream out2 = response.getOutputStream();
     
    int numRead =0;
    while((numRead = in.read(temp,0,temp.length)) != -1)
    {// temp �迭�� �о�ðǵ� 0��° �ε������� �ѹ��� �ִ� temp.length ��ŭ �о�´�.
        out2.write(temp,0,numRead);
    }
    // �ڿ� ����
    out2.flush();
    out2.close();
    in.close();
    cert.delete();
    response.sendRedirect("Auth.jsp");
%>
</body>
</html>
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
	
	String uploadPath = request.getRealPath("/temp/certificate"); // upload�� ������ / ������ ��θ� ���ؿ�
	
	
	//�ش� ������ �ִ��� �������� Ȯ���Ѵ�.

	File folder=new File(uploadPath);
	if(!folder.exists())
	{
		try{
			folder.mkdirs();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	//������ ���ٸ�, �����Ǿ���, uploadPath�� Ư�� ������ ����Ų��.
	
	
	//�� �κп��� ���� ���͸� ó�� �� ���...
	
	try {
		MultipartRequest multi = new MultipartRequest( // MultipartRequest �ν��Ͻ� ����(cos.jar�� ���̺귯��)
				request, 
				uploadPath, // ������ ������ ���丮 ����
				10 * 1024, // ÷������ �ִ� �뷮 ����(bite) / 10KB / �뷮 �ʰ� �� ���� �߻�
				"utf-8", // ���ڵ� ��� ����
				new DefaultFileRenamePolicy() // �ߺ� ���� ó��(������ ���ϸ��� ���ε�Ǹ� �ڿ� ���� ���� �ٿ� �ߺ� ȸ��)
		);

		fileName = multi.getFilesystemName("File"); // name=file1�� ���ε�� �ý��� ���ϸ��� ����(�ߺ��� ������ ������, �ߺ� ó�� �� ���� �̸�)
		orgfileName = multi.getOriginalFileName("File"); // name=file1�� ���ε�� �������� �̸��� ����(�ߺ� ó�� �� �̸�)
		certFileName=multi.getFilesystemName("Cert");
		orgCertFileName=multi.getOriginalFileName("Cert");
		File delFile=null;
		File delCert=null;
		if(PMSlib.isSafeFileName(fileName))
		{
			//���� ó���� �� �ش�.
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
			out.print("���� ���� ����:"+result);
			response.sendRedirect("AuthCheck.jsp?Result="+result);

		}
		else
		{	//��������
			delFile=new File(uploadPath+"/"+fileName);
			delCert=new File(uploadPath+"/"+certFileName);
			delFile.delete();
			delCert.delete();
		
			response.sendRedirect("AuthCheck.jsp?Result=uploadFail");
		}
		
	} catch (Exception e) {
		out.print("���� �߻�");
		out.print(e.getMessage()+"<br>");
		out.print(e.getStackTrace()+"<br>");
		out.print(uploadPath);
		e.getStackTrace();
	} // ���ε� ����
	out.print("�ƹ��͵� ����");
%>
</body>
</html>
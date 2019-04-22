<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.FileItem" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.RequestContext" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext" %>
<!DOCTYPE html>
<%@ page import="trial.uploadTransactions"%>
<html>
<head>
<style>
body{
	background-image:url("images/image1.jpg");
	background-position: 25% 50%
}
</style>
<meta charset="ISO-8859-1">
<title>Uploaded Transactions</title>
</head>
<body>
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = "E:\\Trail project\\";
 
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
 
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("E:\\Uploaded Files"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      try{ 
    	  List fileItems = upload.parseRequest(new ServletRequestContext(request));
    	  Iterator i = fileItems.iterator();
         out.println("<html>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  {
                String fieldName = fi.getFieldName();
                String fileName = fi.getName();
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                file = new File( filePath + "yourFileName") ;
                fi.write( file ) ;
                //out.println("Uploaded Filename: " + fileName + "<br>");
                uploadTransactions ut=new uploadTransactions();
                ut.openFile(fileName);
            }
         }
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
   
%>
  <br />
  <div align="center">
  <table style="background-color:#F8F8F8;r" align="center">
  <tr>
  <td><font  style="color:black;font-family:arial;font-style:bold;">Transactions validated successfully!</font> </td>
  </tr>
  <tr>
  <td>
   <br/>
  <br/>
<button onClick="window.location='displayTransactions.jsp';" value="click">Display Transactions</button>
  </td>
  </tr>
  </table>
  
 
 
</div>
</body>
</html>
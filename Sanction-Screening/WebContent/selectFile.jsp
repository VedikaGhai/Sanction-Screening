<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
	background-image:url("images/image1.jpg");
	background-position: 25% 50%
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select File</title>
</head>
<body>
<div align="center">
<form action="uploaded.jsp" method="post" enctype="multipart/form-data">
<table  style="background-color:#F8F8F8;r" align="center">
<tr>
<td>
<font  style="color:black;font-family:arial;font-style:bold-italics;">Upload transaction file</font> 
</td>
</tr>
<tr><td>
<input type="file" name="file" size="50" />
<br />
</td>
</tr>
<tr>
<td>
<br/>
<input type="submit" value="Upload File" />
</td>
</tr>
</table>
</form>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sanction Fail</title>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body style='background-color: #b4baae;'>
<br/>
<table>
<tr>
<td><button onClick="window.location='displayTransactions.jsp';" value="click">Display Transactions</button></td>
<td><button onClick="window.location='displayAll.jsp';" value="click">Display All</button></td>
<td><button onClick="window.location='validatePass.jsp';" value="click">Validate Pass</button></td>
<td><button onClick="window.location='validateFail.jsp';" value="click">Validate Fail</button></td>
<td><button onClick="window.location='sanctionFail.jsp';" value="click">Sanction Fail</button></td>
<td><button onClick="window.location='sanctionPass.jsp';" value="click">Sanction Pass</button></td>
</tr>
</table>
<br>
<div class="table100 ver3 m-b-110">
					<div class="table100-head">
					</div>
					
<div class="table100-body js-pscroll">
						<table>
							<tbody>
							<tr class="row100 head">
									<th class="cell100 column1">Transaction Ref</th>
									<th class="cell100 column2">Date</th>
									<th class="cell100 column3">Payer Name</th>
									<th class="cell100 column4">Payer Account</th>
									<th class="cell100 column5">Payee Name</th>
									<th class="cell100 column6">Payee Account</th>
									<th class="cell100 column7">Amount(Rs.)</th>
									<th class="cell100 column8">Validate</th>
									<th class="cell100 column9">Screen</th>
								</tr>
<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vedika","root","root@123");  
	Statement stmt=con.createStatement();
	 ResultSet rs=stmt.executeQuery("select * from transactions where Screen='Fail';");  
    while (rs.next()) {
%>
<tr class="row100 body">
<td><%=rs.getString(1)%></td>
<td><%=rs.getDate(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>
<td><%=rs.getString(6)%></td>
<td><%=rs.getDouble(7)%></td>
<td><%=rs.getString(8)%></td>
<td><%=rs.getString(9)%></td>


</tr>
<%
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</tbody>
						</table>
					</div>
				</div>
<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			var ps = new PerfectScrollbar(this);

			$(window).on('resize', function(){
				ps.update();
			})
		});
			
		
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
</body>
</html>
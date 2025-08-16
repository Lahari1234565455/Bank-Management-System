<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Accounts | Bank Management System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

body {
    font-family: 'Poppins', sans-serif;
    background: #001f3f; /* dark blue background */
    min-height: 100vh;
    margin: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding: 30px;
    overflow-x: hidden;
}

h1 {
    color: #00c6ff; /* bright blue title */
    font-size: 36px;
    text-align: center;
    margin-bottom: 10px;
}

h3 {
    color: #b0e0ff; /* lighter blue subtitle */
    text-align: center;
    margin-bottom: 25px;
    font-weight: 400;
}

table {
    border-collapse: collapse;
    width: 90%;
    max-width: 1000px;
    background: #00264d; /* dark blue table background */
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
}

th, td {
    padding: 14px 18px;
    text-align: center;
    color: #ffffff; /* white text for clarity */
    font-size: 16px;
}

th {
    background: #004e92; /* professional dark blue header */
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 1px;
}

tr:nth-child(even) {
    background: #003366; /* slightly lighter dark blue row */
}

tr:nth-child(odd) {
    background: #00264d; /* dark blue row */
}

tr:hover {
    background: #0059b3; /* highlight hover row */
    transform: scale(1.01);
    transition: 0.3s ease;
}

/* Back Button */
.btn-back {
    margin-top: 25px;
    display: inline-block;
    padding: 12px 25px;
    border-radius: 10px;
    background: #004e92; /* dark blue button */
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    text-decoration: none;
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    transition: 0.3s ease-in-out;
}

.btn-back:hover {
    background: #0074d9; /* lighter blue hover */
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 8px 20px rgba(0,0,0,0.3);
}

/* Floating Circles (optional, can keep for decoration) */
.circle {
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
    animation: float 6s infinite ease-in-out;
    z-index: -1;
}
.circle1 { width: 150px; height: 150px; background: #004e92; top: 50px; left: 30px; }
.circle2 { width: 100px; height: 100px; background: #00c6ff; bottom: 60px; right: 50px; animation-delay: 2s; }
.circle3 { width: 120px; height: 120px; background: #0074d9; top: 200px; right: 150px; animation-delay: 4s; }

@keyframes float {
    0%,100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }
}
</style>
</head>
<body>

<div class="circle circle1"></div>
<div class="circle circle2"></div>
<div class="circle circle3"></div>

<h1><i class="fas fa-university"></i> Bank Management System</h1>
<h3>All Accounts</h3>

<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM accounts");
        ResultSet rs = ps.executeQuery();
%>

<table>
    <tr>
        <th>Account Id</th>
        <th>Account Holder Name</th>
        <th>Account Type</th>
        <th>Balance</th>
    </tr>

<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt(1) %></td>
        <td><%= rs.getString(2) %></td>
        <td><%= rs.getString(3) %></td>
        <td> <%= rs.getInt(4) %> Rs.</td>
    </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
    }
%>
</table>

<a href="dashboard.html" class="btn-back"><i class="fas fa-arrow-left"></i> Go Back to Home</a>

</body>
</html>

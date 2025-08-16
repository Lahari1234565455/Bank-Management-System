<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Details | Bank Management System</title>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #004e92, #000428);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .card {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.3);
        width: 450px;
        animation: fadeIn 1s ease-in-out;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #004e92;
        font-size: 26px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    td {
        padding: 12px 8px;
        font-size: 16px;
        color: #333;
    }

    label {
        font-weight: bold;
        color: #004e92;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px;
        border: 2px solid #004e92;
        border-radius: 10px;
        font-size: 15px;
        background: #f9f9f9;
        color: #333;
    }

    input[readonly] {
        background: #f0f0f0;
        cursor: not-allowed;
    }

    .btn {
        display: block;
        margin: 20px auto 0;
        padding: 12px 25px;
        background: linear-gradient(135deg, #004e92, #00c6ff);
        border: none;
        border-radius: 10px;
        color: white;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s ease-in-out;
    }

    .btn:hover {
        background: linear-gradient(135deg, #00c6ff, #004e92);
        transform: scale(1.05);
        box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>

<%
    String id = request.getParameter("id");
    int idNum = Integer.parseInt(id);

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");
        PreparedStatement ps = con.prepareStatement("select * from accounts where account_id = ?");
        ps.setInt(1, idNum);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
%>

    <div class="card">
        <h2>Account Details</h2>
        <form action="<%=request.getContextPath()%>/dashboard.html" method="post">
            <table>
                <tr>
                    <td><label>Account ID:</label></td>
                    <td><input type="text" value="<%=rs.getInt(1)%>" readonly /></td>
                </tr>
                <tr>
                    <td><label>Holder Name:</label></td>
                    <td><input type="text" value="<%=rs.getString(2)%>" readonly /></td>
                </tr>
                <tr>
                    <td><label>Account Type:</label></td>
                    <td><input type="text" value="<%=rs.getString(3)%>" readonly /></td>
                </tr>
                <tr>
                    <td><label>Balance:</label></td>
                    <td><input type="text" value="<%=rs.getString(4)%>" readonly /></td>
                </tr>
            </table>
            <button type="submit" class="btn">Go Back to dash board</button>
        </form>
    </div>

<%
        } else {
%>
    <div class="card">
        <h2>No Account Found</h2>
        <p style="text-align:center; color:#333;">No account exists with ID: <b><%=id%></b></p>
    </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Delete Account Result | Bank Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            color: #333;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 450px;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            margin-bottom: 15px;
            font-size: 26px;
            color: #2a5298;
        }

        .message {
            font-size: 18px;
            margin: 20px 0;
            font-weight: 500;
        }

        .success {
            color: green;
        }

        .failure {
            color: red;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 15px;
            transition: transform 0.2s, background 0.3s;
        }

        a:hover {
            background: linear-gradient(135deg, #2a5298, #1e3c72);
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bank Management System</h1>
        <div class="message">
            <%
                String id = request.getParameter("id");
                try {
                    int account_id = Integer.parseInt(id);

                    // JDBC Connection
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");
                    PreparedStatement ps = con.prepareStatement("delete from accounts where account_id = ?");
                    ps.setInt(1, account_id);
                    int i = ps.executeUpdate();
                    if (i > 0) {
                        out.println("<span class='success'> Account deleted successfully!</span>");
                    } else {
                        out.println("<span class='failure'> Account deletion failed. Account not found.</span>");
                    }
                } catch (Exception e) {
                    out.println("<span class='failure'>⚠️ Error: " + e.getMessage() + "</span>");
                }
            %>
        </div>
        <a href="dashboard.html"> Go back to Home Page</a>
    </div>
</body>
</html>

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
<title>Withdraw Money | Bank Management System</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #004e92, #000428);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .card {
        background: #fff;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0px 10px 25px rgba(0,0,0,0.3);
        width: 450px;
        text-align: center;
        animation: fadeIn 1s ease-in-out;
        position: relative;
    }

    h1 {
        color: #004e92;
        margin-bottom: 20px;
        font-size: 28px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    }

    p {
        font-size: 16px;
        color: #004e92;
        margin: 10px 0;
    }

    .success {
        background: rgba(0,198,255,0.2);
        color: #004e92;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
    }

    .error {
        background: rgba(231,76,60,0.2);
        color: #e74c3c;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
    }

    label {
        display: block;
        font-weight: 500;
        color: #004e92;
        margin-bottom: 5px;
        text-align: left;
    }

    input[type="number"] {
        width: 100%;
        padding: 10px;
        border-radius: 10px;
        border: 2px solid #004e92;
        font-size: 15px;
        background: #f9f9f9;
        color: #333;
        outline: none;
        transition: all 0.3s ease;
        margin-bottom: 15px;
    }

    input[type="number"]:focus {
        box-shadow: 0px 0px 10px #00c6ff;
        transform: scale(1.02);
    }

    input[type="submit"] {
        padding: 12px 25px;
        background: linear-gradient(135deg, #004e92, #00c6ff);
        border: none;
        border-radius: 10px;
        color: #fff;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s ease-in-out;
    }

    input[type="submit"]:hover {
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
<div class="card">
    <h1><i class="fas fa-money-bill-wave"></i> Withdraw Money</h1>

<%
String id = request.getParameter("id");
String withdrawAmount = request.getParameter("withdraw");

if (id != null && !id.trim().isEmpty()) {
    int idNum = Integer.parseInt(id);
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");

        if (withdrawAmount == null) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_id = ?");
            ps.setInt(1, idNum);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");
%>
                <div class="success"><b>Current Balance:</b> <%= currentBalance %></div>
                <form action="withdraw_money_controller.jsp" method="post">
                    <input type="hidden" name="id" value="<%= idNum %>" />
                    <label>Enter amount to withdraw:</label>
                    <input type="number" step="0.01" name="withdraw" required />
                    <input type="submit" value="Withdraw" />
                </form>
<%
            } else {
%>
                <div class="error">Account not found.</div>
<%
            }
        } else {
            double withdraw = Double.parseDouble(withdrawAmount);
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_id = ?");
            ps1.setInt(1, idNum);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                double currentBalance = rs1.getDouble("balance");

                if (withdraw > currentBalance) {
%>
                    <div class="error">Insufficient balance. Withdrawal failed.</div>
<%
                } else {
                    double newBalance = currentBalance - withdraw;

                    PreparedStatement ps2 = con.prepareStatement(
                        "UPDATE accounts SET balance = ? WHERE account_id = ?");
                    ps2.setDouble(1, newBalance);
                    ps2.setInt(2, idNum);
                    int updated = ps2.executeUpdate();

                    if (updated > 0) {
%>
                        <div class="success">Withdrawal Successful!</div>
                        <div class="success"><b>Previous Balance:</b> <%= currentBalance %></div>
                        <div class="success"><b>Withdrawn Amount:</b> <%= withdraw %></div>
                        <div class="success"><b>New Balance:</b> <%= newBalance %></div>
<%
                    } else {
%>
                        <div class="error">Failed to update balance.</div>
<%
                    }
                }
            } else {
%>
                <div class="error">Account not found.</div>
<%
            }
        }
        con.close();
    } catch (Exception e) {
%>
        <div class="error">Error: <%= e.getMessage() %></div>
<%
    }
}
%>
</div>
</body>
</html>

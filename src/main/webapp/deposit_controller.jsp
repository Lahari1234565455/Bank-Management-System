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
<title>Deposit Money</title>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .container {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        width: 400px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        text-align: center;
        animation: fadeIn 0.8s ease-in-out;
    }
    h1 {
        margin-bottom: 20px;
        color: #2a5298;
    }
    label {
        font-weight: bold;
        display: block;
        margin: 15px 0 5px;
        color: #333;
    }
    input[type="number"], input[type="text"] {
        width: 90%;
        padding: 10px;
        border: 2px solid #2a5298;
        border-radius: 10px;
        outline: none;
        font-size: 15px;
        margin-bottom: 20px;
        transition: 0.3s;
    }
    input[type="number"]:focus, input[type="text"]:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 8px #1e3c72;
    }
    input[type="submit"] {
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        color: #fff;
        padding: 12px 25px;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: 0.3s ease-in-out;
    }
    input[type="submit"]:hover {
        background: linear-gradient(135deg, #2a5298, #1e3c72);
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }
    .success {
        color: green;
        font-weight: bold;
        margin: 15px 0;
    }
    .error {
        color: red;
        font-weight: bold;
        margin: 15px 0;
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
        text-decoration:none;
    }

    .btn:hover {
        background: linear-gradient(135deg, #00c6ff, #004e92);
        transform: scale(1.05);
        box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
    }

   
    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(-20px);}
        to {opacity: 1; transform: translateY(0);}
    }
</style>
</head>
<body>
<div class="container">
    <h1>Deposit Money</h1>

<%
String id = request.getParameter("id");
String depositAmount = request.getParameter("deposit");

if (id != null && !id.trim().isEmpty()) {
    int idNum = Integer.parseInt(id);
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");

        if (depositAmount == null) {
            // Step 1: Show current balance and ask for deposit amount
            PreparedStatement ps = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_id = ?");
            ps.setInt(1, idNum);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");
%>
                <p>Current Balance: <b><%= currentBalance %></b></p>
                <form action="deposit_controller.jsp" method="post">
                    <input type="hidden" name="id" value="<%= idNum %>" />
                    <label>Enter amount to deposit:</label>
                    <input type="number" step="0.01" name="deposit" required />
                    <input type="submit" value="Deposit" />
                </form>
<%
            } else {
%>
                <p class="error">Account not found.</p>
<%
            }
        } else {
            // Step 2: Update balance
            double deposit = Double.parseDouble(depositAmount);
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT balance FROM accounts WHERE account_id = ?");
            ps1.setInt(1, idNum);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                double currentBalance = rs1.getDouble("balance");
                double newBalance = currentBalance + deposit;

                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE accounts SET balance = ? WHERE account_id = ?");
                ps2.setDouble(1, newBalance);
                ps2.setInt(2, idNum);
                int updated = ps2.executeUpdate();

                if (updated > 0) {
%>
                    <p class="success">Deposit Successful!</p>
                    <p>Previous Balance: <%= currentBalance %></p>
                    <p>Deposited Amount: <%= deposit %></p>
                    <p>New Balance: <b><%= newBalance %></b></p>
                    <a href="dashboard.html" class="btn">Go Back to dash board</a>
<%
                } else {
%>
                    <p class="error">Failed to update balance.</p>
<%
                }
            } else {
%>
                <p class="error">Account not found.</p>
<%
            }
        }
        con.close();
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    }
}
%>
            

</div>
</body>
</html>

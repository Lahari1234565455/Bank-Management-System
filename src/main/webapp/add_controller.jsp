<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Add Account Result | Bank Management System</title>
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
        animation: fadeIn 1s ease-in-out;
        position: relative;
        text-align: center;
    }

    h2 {
        font-size: 24px;
        color: #004e92;
        margin-bottom: 20px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    }

    p {
        font-size: 16px;
        color: #333;
        margin-bottom: 25px;
        text-align: left;
        line-height: 1.6;
    }

    .success, .error {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        flex-wrap: wrap;
    }

    .success { color: #2ecc71; }
    .error { color: #e74c3c; }

    .btn {
        display: inline-block;
        margin: 8px 5px 0;
        padding: 12px 25px;
        border-radius: 10px;
        text-decoration: none;
        font-size: 16px;
        font-weight: bold;
        transition: 0.3s ease-in-out;
        color: white;
        cursor: pointer;
        border: none;
    }

    .btn-home {
        background: linear-gradient(135deg, #004e92, #00c6ff);
    }

    .btn-home:hover {
        background: linear-gradient(135deg, #00c6ff, #004e92);
        transform: scale(1.05);
        box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
    }

    .btn-view {
        background: linear-gradient(135deg, #2ecc71, #27ae60);
    }

    .btn-view:hover {
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
String holder_name = request.getParameter("holder_name");
String account_type = request.getParameter("account_type");
String balance = request.getParameter("balance");

int account_id = Integer.parseInt(id);
int amount_balance = Integer.parseInt(balance);

boolean success = false;
boolean duplicate = false;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms"
    );

    PreparedStatement checkStmt = con.prepareStatement("SELECT 1 FROM accounts WHERE ACCOUNT_ID = ?");
    checkStmt.setInt(1, account_id);
    ResultSet rs = checkStmt.executeQuery();

    if (rs.next()) {
        duplicate = true;
    } else {
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO accounts (ACCOUNT_ID, ACCOUNT_HOLDER_NAME, ACCOUNT_TYPE, BALANCE) VALUES (?,?,?,?)"
        );
        ps.setInt(1, account_id);
        ps.setString(2, holder_name);
        ps.setString(3, account_type);
        ps.setInt(4, amount_balance);

        int i = ps.executeUpdate();
        if (i > 0) success = true;

        ps.close();
    }

    rs.close();
    checkStmt.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<div class="card">
    <% if(success) { %>
        <div class="success"><i class="fas fa-check-circle"></i> Account Added Successfully!</div>
        <p><b>Account ID:</b> <%= id %><br>
           <b>Holder Name:</b> <%= holder_name %><br>
           <b>Type:</b> <%= account_type %><br>
           <b>Balance:</b> <%= balance %></p>
    <% } else if(duplicate) { %>
        <div class="error"><i class="fas fa-exclamation-circle"></i> Account ID <%= id %> already exists!</div>
    <% } else { %>
        <div class="error"><i class="fas fa-times-circle"></i> Insertion Failed. Try Again!</div>
    <% } %>

    <a href="add_account.html" class="btn btn-home"><i class="fas fa-arrow-left"></i> Back to Form</a>
    <a href="view_all_accounts_controller.jsp" class="btn btn-view"><i class="fas fa-database"></i> View Accounts</a>
</div>

</body>
</html>

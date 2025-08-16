<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    int idNum = Integer.parseInt(id);

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM accounts WHERE account_id = ?");
        ps.setInt(1, idNum);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Account</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 15px;
            color: #fff;
            width: 380px;
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .form-container h2 {
            margin-bottom: 20px;
            color: #ffdd57;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: none;
            outline: none;
            font-size: 15px;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-group input[readonly] {
            background: #e0e0e0;
            cursor: not-allowed;
        }

        .btn {
            margin-top: 20px;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.25);
        }

        .btn:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #dd2476, #ff512f);
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Update Account</h2>
        <form action="account_update.jsp" method="post">
            <div class="form-group">
                <label>Account ID</label>
                <input type="text" name="id" value="<%=rs.getInt(1)%>" readonly>
            </div>
            <div class="form-group">
                <label>Holder Name</label>
                <input type="text" name="holder_name" value="<%=rs.getString(2)%>">
            </div>
            <div class="form-group">
                <label>Account Type</label>
                <input type="text" name="account_type" value="<%=rs.getString(3)%>">
            </div>
            <div class="form-group">
                <label>Balance</label>
                <input type="text" name="balance" value="<%=rs.getDouble(4)%>">
            </div>
            <button type="submit" class="btn">Update Account</button>
        </form>
    </div>
</body>
</html>
<%
        } else {
            out.println("<p style='color:red; font-family:Arial; text-align:center; margin-top:20px;'>❌ Account not found.</p>");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

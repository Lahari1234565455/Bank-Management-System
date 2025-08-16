<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Account Update</title>
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

        .container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            color: white;
            width: 420px;
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.3);
        }

        .container h2 {
            margin-bottom: 15px;
            color: #ffdd57;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            margin-top: 20px;
            animation: fadeIn 0.8s ease-in-out;
        }

        .success {
            background: rgba(46, 204, 113, 0.9);
            color: white;
            box-shadow: 0px 4px 12px rgba(39, 174, 96, 0.6);
        }

        .error {
            background: rgba(231, 76, 60, 0.9);
            color: white;
            box-shadow: 0px 4px 12px rgba(192, 57, 43, 0.6);
        }

        .btn {
            margin-top: 25px;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #dd2476, #ff512f);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bank Management System</h2>
        <%
            String id = request.getParameter("id");
            String holder_name = request.getParameter("holder_name");
            String account_type = request.getParameter("account_type");
            String balance = request.getParameter("balance");

            try {
                int idNum = Integer.parseInt(id);
                double total_balance = Double.parseDouble(balance);

                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "bms", "bms");

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE accounts SET account_holder_name = ?, account_type = ?, balance = ? WHERE account_id = ?");
                ps.setString(1, holder_name);
                ps.setString(2, account_type);
                ps.setDouble(3, total_balance);
                ps.setInt(4, idNum);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    out.println("<div class='alert success'> Account updated successfully!</div>");
                } else {
                    out.println("<div class='alert error'> Update failed. Please try again.</div>");
                }
                con.close();
            } catch (Exception e) {
                out.println("<div class='alert error'>⚠️ Error: " + e.getMessage() + "</div>");
                e.printStackTrace();
            }
        %>
        <br>
        
         <a href="dashboard.html" class="btn"> Go Back to Dashboard</a>
    </div>
</body>
</html>

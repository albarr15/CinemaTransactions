<%-- 
    Document   : view_schedules
    Created on : 11 21, 23, 4:29:05 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,  java.sql.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Schedules</title>
    </head>
    <body>
       <center> 
            <table border ="1">
                <tr>
                    <th>Schedule ID</th> 
                    <th>Date</th> 
                    <th>Time</th> 
                    <th>Movie</th>
                    <th>Cinema No.</th>
                </tr>
        <% 
            try{
                // Connect to database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                Statement st = conn.createStatement();
                
                // Display all sched data in table format
                String str = "SELECT sched.sched_id, sched.date, sched.time, movie.movie_title, sched.cinema_num"
                        + "   FROM ctmdb.sched LEFT JOIN ctmdb.movie ON sched.movie_id = movie.movie_id";
                ResultSet rst = st.executeQuery(str);
                
                while (rst.next()) {
                    %>
                    <tr>
                        <td><%=rst.getString("sched_id") %></td>
                        <td><%=rst.getString("date") %></td>
                        <td><%=rst.getString("time") %></td>
                        <td><%=rst.getString("movie_title") %></td>
                        <td><%=rst.getString("cinema_num") %></td>
                    </tr>
                    <%
                }
            
            } catch (Exception e) {
            System.out.println(e.getMessage());
        }
         %>
            </table>
        </center>
    </body>
</html>
<%-- 
    Document   : view_movielist
    Created on : 11 21, 23, 3:29:36 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie Sales Report</title>
    </head>
    <body>
        <center> 
            
            <h1> DAILY </h1>
            <table border ="1">
                <tr>
                    <th>Movie Title</th> 
                    <th>Date</th> 
                    <th>Revenue</th>
                    <th># of Tickets Sold</th> 
                </tr>
        <% 
            try{
                // Connect to database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                Statement st = conn.createStatement();
                
                // Display all Movies in table format
                String str = "SELECT m.movie_title, s.date, SUM(t.price) AS revenue, COUNT(t.ticket_id) AS numTicketsSold"
                        + " FROM ctmdb.ticket t JOIN ctmdb.sched s ON s.sched_id = t.sched_id"
                        + " JOIN ctmdb.movie m ON m.movie_id = s.movie_id GROUP BY m.movie_title, s.date, t.sched_id"
                        + " ORDER BY revenue DESC, numTicketsSold DESC";
                ResultSet rst = st.executeQuery(str);
                
                while (rst.next()) {
                    %>
                    <tr>
                        <td><%=rst.getString("movie_title") %></td>
                        <td><%=rst.getString("date") %></td>
                        <td><%=rst.getInt("revenue") %></td>
                        <td><%=rst.getInt("numTicketsSold") %></td>
                    </tr>
                    <%
                }
            
            } catch (Exception e) {
            System.out.println(e.getMessage());
        }
         %>
            </table>
            
            <h1> WEEKLY </h1>
            <table border ="1">
                <tr>
                    <th>Movie Title</th> 
                    <th>Date</th> 
                    <th>Week #</th>
                    <th>Revenue</th>
                    <th># of Tickets Sold</th> 
                </tr>
        <% 
            try{
                // Connect to database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                Statement st = conn.createStatement();
                
                // Display all Movies in table format
                String str = "SELECT m.movie_title, WEEK(s.date) AS week, s.date, SUM(t.price) AS revenue, COUNT(t.ticket_id) AS numTicketsSold"
                        + " FROM ctmdb.ticket t JOIN ctmdb.sched s ON s.sched_id = t.sched_id"
                        + " JOIN ctmdb.movie m ON m.movie_id = s.movie_id GROUP BY m.movie_title, YEAR(s.date), MONTH(s.date), WEEK(s.date), t.sched_id"
                        + " ORDER BY revenue DESC, numTicketsSold DESC";
                ResultSet rst = st.executeQuery(str);
                
                while (rst.next()) {
                    %>
                    <tr>
                        <td><%=rst.getString("movie_title") %></td>
                        <td><%=rst.getString("date") %></td>
                        <td><%=rst.getString("week") %></td>
                        <td><%=rst.getInt("revenue") %></td>
                        <td><%=rst.getInt("numTicketsSold") %></td>
                    </tr>
                    <%
                }
            
            } catch (Exception e) {
            System.out.println(e.getMessage());
        }
         %>
            </table>
            
            <h1> MONTHLY </h1>
            <table border ="1">
                <tr>
                    <th>Movie Title</th> 
                    <th>Date</th> 
                    <th>Year</th>
                    <th>Revenue</th>
                    <th># of Tickets Sold</th> 
                </tr>
        <% 
            try{
                // Connect to database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                Statement st = conn.createStatement();
                
                // Display all Movies in table format
                String str = "SELECT m.movie_title, YEAR(s.date) AS year, s.date, SUM(t.price) AS revenue, COUNT(t.ticket_id) AS numTicketsSold"
                        + " FROM ctmdb.ticket t JOIN ctmdb.sched s ON s.sched_id = t.sched_id"
                        + " JOIN ctmdb.movie m ON m.movie_id = s.movie_id GROUP BY m.movie_title, YEAR(s.date), t.sched_id"
                        + " ORDER BY revenue DESC, numTicketsSold DESC";
                ResultSet rst = st.executeQuery(str);
                
                while (rst.next()) {
                    %>
                    <tr>
                        <td><%=rst.getString("movie_title") %></td>
                        <td><%=rst.getString("date") %></td>
                        <td><%=rst.getString("year") %></td>
                        <td><%=rst.getInt("revenue") %></td>
                        <td><%=rst.getInt("numTicketsSold") %></td>
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
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
        <title>View Movie List</title>
    </head>
    <body>
        <center> 
            <table border ="1">
                <tr>
                    <th>Title</th> 
                    <th>Rated</th> 
                    <th>Genre</th>
                    <th>Director</th> 
                    <th>Starring</th> 
                    <th>Synopsis</th> 
                    <th>Formats</th> 
                    <th>Minutes</th> 
                    <th>Status</th> 
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
                String str = "SELECT * FROM ctmdb.movie";
                ResultSet rst = st.executeQuery(str);
                
                while (rst.next()) {
                    %>
                    <tr>
                        <td><%=rst.getString("movie_title") %></td>
                        <td><%=rst.getString("rating") %></td>
                        <td><%=rst.getString("genre") %></td>
                        <td><%=rst.getString("director") %></td>
                        <td><%=rst.getString("actors") %></td>
                        <td><%=rst.getString("synopsis") %></td>
                        <td><%=rst.getString("movie_type") %></td>
                        <td><%=rst.getInt("minutes") %></td>
                        <td><%=rst.getString("movie_status") %></td>
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
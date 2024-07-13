<%-- 
    Document   : movie_popularity
    Created on : 11 21, 23, 11:02:32 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie Popularity Report</title>
    </head>
    <body>
        <center> 
            <table border ="1">
                <tr>
                    <th>Genre</th> 
                    <th>Tickets Sold</th>
                </tr>
        <% 
            try{
                // Connect to database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                Statement st = conn.createStatement();
                
                // Display action count
                String str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%action%'"
                            + "GROUP BY movie.movie_id) sub";
                ResultSet rst = st.executeQuery(str);
                
                    %>
                <tr>
                    <td>action</td>
                    <td><%=rst.getInt("total_count")%></td>
                </tr>
          <%// Display adventure count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%adventure%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>adventure</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display biography count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%biography%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>biography</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display comedy count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%comedy%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>comedy</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display drama count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%drama%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>drama</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display family count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%family%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>family</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display fantasy count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%fantasy%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>fantasy</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display horror count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%horror%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>horror</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display mystery count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%mystery%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>mystery</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display romance count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%romance%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>romance</td>
                     <td><%=rst.getInt("total_count")%></td>
            <%// Display thriller count
                str = "SELECT SUM(counts) AS total_count"
                            + "FROM (SELECT COUNT(*) AS counts"
                            + "FROM ctmdb.ticket"
                            + "JOIN ctmdb.sched ON ctmdb.ticket.sched_id = ctmdb.sched.sched_id"
                            + "JOIN ctmdb.movie ON ctmdb.sched.movie_id = ctmdb.movie.movie_id"
                            + "WHERE genre LIKE '%thriller%'"
                            + "GROUP BY movie.movie_id) sub";
                rst = st.executeQuery(str);
                    %>
                 <tr>
                     <td>thriller</td>
                     <td><%=rst.getInt("total_count")%></td>
                    <%
            } catch (Exception e) {
            System.out.println(e.getMessage());
        }
         %>
            </table>
        </center>
    </body>
</html>
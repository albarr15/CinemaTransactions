<%-- 
    Document   : seach_seat_process
    Created on : 11 22, 23, 1:00:41 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Seat</title>
    </head>
    <body>
        <jsp:useBean id="S" class="cinemamanagement.seat" scope="session" />
        <form action="index.html">
            <%
            //Receive values from search_ticket.html
            String search = request.getParameter("search");
            String value = request.getParameter("value");
            
            int status;
            if (search.equalsIgnoreCase("view_all"))
                status = S.search_all();
            else
                status = S.search_seat(search, value);
            
            
            if (status > 0) {  %>
                <h1>Searching...</h1>
                <h2>These are the results found!</h2>
                <table border="1">
                    <tr>
                        <th>Seat ID</th>
                        <th>Seat Type</th>
                        <th>Schedule ID</th>
                        <th>Seat Status</th>
                    </tr>
                    <% for (int i = 0; i < status; i++) {%>
                    <tr>
                        <td><%= S.seat_idlist.get(i)%></td>
                        <td><%= S.seat_typelist.get(i)%></td>
                        <td><%= S.sched_idlist.get(i)%></td>
                        <td><%= S.seat_statuslist.get(i)%></td>
                    </tr>
                    <% } %>
                </table>
            <% } else if (status == 0) { %>
               <h1>Searching...</h1>
               <h2>Sorry! "<%= value %>" in <%= search %> does not exist!</h2>
            <% } else { %>
               <h1>Error in searching</h1>
            <% } %>
            
            <input type="submit" value="Back to Main Menu">
        </form>
    </body>
</html>
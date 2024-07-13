<%-- 
    Document   : delete_seat
    Created on : 11 22, 23, 2:05:20 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Seat</title>
    </head>
    <body>
        <jsp:useBean id="S" class="cinemamanagement.seat" scope="session" />
        <form action="delete_seat_process.jsp">
            <h1 style="text-align:left; font-family:verdana; font-size: 200%">Delete Seat</h1>
            <table style="text-align: left;">
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Seat ID to be deleted:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="delete" id="delete">
                        <%  S.get_seatList();
                            for(int i = 0; i < S.seat_idlist.size(); i++) {
                        %>
                                <option value= "<%=S.seat_idlist.get(i)%>"><%=S.seat_idlist.get(i)%></option>
                        <% } %>
                        </select> 
                    </td>
                </tr>
            </table>
                <tr>
                    <input type="submit" value="Delete">
                </tr>
        </form>
                        
        <%
            int status = S.search_all();
            if (status > 0) {  %>
                <h2>Table for reference</h2>
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
        <% } else { %>
           <h3>Table not available at the moment...</h3>
        <% } %>
    </body>
</html>
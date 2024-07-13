<%-- 
    Document   : search_tkt_process
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Ticket</title>
    </head>
    <body>
        <jsp:useBean id="T" class="cinemamanagement.ticket" scope="session" />
        <form action="index.html">
            <%
            //Receive values from search_ticket.html
            String search = request.getParameter("search");
            String value = request.getParameter("value");
            
            int status;
            if (search.equalsIgnoreCase("view_all"))
                status = T.search_all();
            else
                status = T.search_ticket(search, value);
            
            if (status > 0) {  %>
                <h1>Searching...</h1>
                <h2>These are the results found!</h2>
                <table border="1">
                    <tr>
                        <th>Ticket ID</th>
                        <th>Schedule ID</th>
                        <th>Seat ID</th>
                        <th>Payment Type</th>
                        <th>Amount</th>
                        <th>Price</th>
                        <th>Change</th>
                        <th>Date</th>
                        <th>Number of Tickets</th>
                    </tr>
                    <% for (int i = 0; i < status; i++) {%>
                    <tr>
                        <td><%= T.ticket_idList.get(i)%></td>
                        <td><%= T.sched_idList.get(i)%></td>
                        <td><%= T.seat_idList.get(i)%></td>
                        <td><%= T.paymentList.get(i)%></td>
                        <td><%= T.amountList.get(i)%></td>
                        <td><%= T.priceList.get(i)%></td>
                        <td><%= T.changeList.get(i)%></td>
                        <td><%= T.dateList.get(i)%></td>
                        <td><%= T.countList.get(i)%></td>
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

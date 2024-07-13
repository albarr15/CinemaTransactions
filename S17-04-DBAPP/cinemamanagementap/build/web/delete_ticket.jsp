<%-- 
    Document   : delete_ticket
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Ticket</title>
    </head>
    <body>
        <jsp:useBean id="T" class="cinemamanagement.ticket" scope="session" />
        <form action="delete_tkt_process.jsp">
            <h1 style="text-align:left; font-family:verdana; font-size: 200%">Delete Ticket</h1>
            <table style="text-align: left;">
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Ticket ID to be deleted:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="delete" id="delete">
                        <%  T.get_ticketList();
                            for(int i = 0; i < T.ticket_idList.size(); i++) {
                        %>
                                <option value= "<%=T.ticket_idList.get(i)%>"><%=T.ticket_idList.get(i)%></option>
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
            int status = T.search_all();
            if (status > 0) {  %>
                <h2>Table for reference</h2>
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
                    </tr>
                    <% } %>
                </table>
        <% } else { %>
           <h3>Table not available at the moment...</h3>
        <% } %>
    </body>
</html>

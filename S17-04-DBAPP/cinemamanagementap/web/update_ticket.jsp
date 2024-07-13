<%-- 
    Document   : update_ticket
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Ticket</title>
    </head>
    <body>
        <jsp:useBean id="T" class="cinemamanagement.ticket" scope="session" />
        <form action="update_tkt_process.jsp">
            <h1 style="text-align:left; font-family:verdana; font-size: 200%">Update Ticket</h1>
            <table style="text-align: left;">
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Ticket ID to be updated:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="update" id="update">
                        <%  T.get_ticketListUpdate();
                            for(int i = 0; i < T.ticket_idList.size(); i++) {
                        %>
                                <option value= "<%=T.ticket_idList.get(i)%>"><%=T.ticket_idList.get(i)%></option>
                        <% } %>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">New Schedule ID:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="new_sched" id="new_sched" required>
                        <%  T.get_schedListUpdate();
                            for(int i = 0; i < T.sched_idList.size(); i++) {
                        %>
                                <option value= "<%=T.sched_idList.get(i)%>"><%=T.sched_idList.get(i)%></option>
                        <% } %>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">New Seat ID:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px"><input type="text" id="new_seat" name="new_seat" maxlength="4" style="width: 150px;" required></td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Payment type:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="new_payment" id="new_payment">
                            <option value="GCash">GCash</option>
                            <option value="PayMaya">PayMaya</option>
                            <option value="Master Card">Master Card</option>
                            <option value="Cash">Cash</option>
                        </select>
                    </td>
                </tr>
                <tr>   
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Additional Amount:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px"><input type="number" id="add_amount" name="add_amount" style="width: 150px;"></td>
                </tr>
                
            </table>
                <tr>
                    <input type="submit" value="Update">
                </tr>
        </form>
    </body>
</html>

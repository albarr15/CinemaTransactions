<%-- 
    Document   : delete_tkt_process
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
        <form action="index.html">
            <%
            //Receive values from delete_ticket.jsp
            String sTicket = request.getParameter("delete");
            int ticket = Integer.parseInt(sTicket);
            
            int status = T.delete_ticket(ticket);
            
            if (status == 1) {  %>
               <h1>The ticket was successfully deleted.</h1>
            <% } else { %>
               <h1>Deletion of the ticket was unsuccessful.</h1>
            <% } %>
            
            <input type="submit" value="Back to Main Menu">
        </form>
    </body>
</html>

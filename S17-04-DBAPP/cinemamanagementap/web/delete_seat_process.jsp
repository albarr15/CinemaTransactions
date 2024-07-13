<%-- 
    Document   : delete_seat_process
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
        <form action="index.html">
            <%
            //Receive values from delete_seat.jsp
            String sSeat = request.getParameter("delete");
            int seat = Integer.parseInt(sSeat);
            
            int status = S.delete_seat(seat);
            
            if (status == 1) {  %>
               <h1>The ticket was successfully deleted.</h1>
            <% } else { %>
               <h1>Deletion of the ticket was unsuccessful.</h1>
            <% } %>
            
            <input type="submit" value="Back to Main Menu">
        </form>
    </body>
</html>

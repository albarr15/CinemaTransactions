<%-- 
    Document   : update_tkt_process
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
        <%
            //Receive values from update_ticket.jsp
            String sTicket_id = request.getParameter("update");
            String sched_id = request.getParameter("new_sched");
            String sSeat_id = request.getParameter("new_seat");
            String payment = request.getParameter("new_payment");
            String sAmount = request.getParameter("add_amount");
            
            int ticket_id = Integer.valueOf(sTicket_id);
            int seat_id = Integer.valueOf(sSeat_id);
            float amount = Float.valueOf(sAmount);
            
            T.ticket_id = ticket_id;
            T.sched_id = sched_id;
            T.seat_id  = seat_id;
            T.payment  = payment;
            T.amount   = amount;
            
            int status = T.update_ticket();
            
            if (status==1) {
        %>
            <form action="index.html">
                <h1>Updated ticket successfully!</h1>
                <input type="submit" value="Back to Main Menu">
            </form>
        <%  } else if (status==2) {
        %>
            <form action="ticket.html">
                <h1>Error: Insufficient amount..!</h1>
                <input type="submit" value="Go Back to Ticket">
            </form>
        <%  } else if (status==12) {
        %>
            <form action="ticket.html">
                <h1>Error: Seat ID does not exist..!</h1>
                <input type="submit" value="Go Back to Ticket">
            </form>
        <%  } else if (status==13) {
        %>
            <form action="ticket.html">
                <h1>Error: Seat unavailable..!</h1>
                <input type="submit" value="Go Back to Ticket">
            </form>
        <%  } else {
        %>
            <form action="index.html">
                <h1>Error in buying ticket...</h1>
                <input type="submit" value="Back to Main Menu">
            </form>
        <%  }
        %>
    </body>
</html>

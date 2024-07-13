<%-- 
    Document   : buy_tkt_process.jsp
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Ticket</title>
    </head>
    <body>
        <jsp:useBean id="T" class="cinemamanagement.ticket" scope="session" />
        <%
            //Receive values from buy_ticket.html
            String sched_id = request.getParameter("schedule");
            String sSeat_id = request.getParameter("seat");
            String payment = request.getParameter("payment");
            String sAmount = request.getParameter("amount");
            int seat_id = Integer.valueOf(sSeat_id);
            float amount = Float.valueOf(sAmount);
            
            T.sched_id = sched_id;
            T.seat_id  = seat_id;
            T.payment  = payment;
            T.amount   = amount;
            
            int status = T.buy_ticket();
            
            if (status==1) {
        %>
            
            <form action="index.html">
                <h1>Bought ticket successfully!</h1>
                <input type="submit" value="Back to Main Menu">
            </form>
        <%  } else if (status==2) {
        %>
            <form action="buy_ticket.html">
                <h1>Error: Insufficient amount..!</h1>
                <input type="submit" value="Redo">
            </form>
        <%  } else if (status==11) {
        %>
            <form action="buy_ticket.html">
                <h1>Error: Schedule ID does not exist..!</h1>
                <input type="submit" value="Redo">
            </form>
        <%  } else if (status==12) {
        %>
            <form action="buy_ticket.html">
                <h1>Error: Seat ID does not exist..!</h1>
                <input type="submit" value="Redo">
            </form>
        <%  } else if (status==13) {
        %>
            <form action="buy_ticket.html">
                <h1>Error: Seat unavailable..!</h1>
                <input type="submit" value="Redo">
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

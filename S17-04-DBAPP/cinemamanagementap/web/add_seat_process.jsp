<%-- 
    Document   : seats_processing
    Created on : 11 20, 23, 9:05:54 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seats Processing</title>
    </head>
    <body>
        <form action="index.html">
            <jsp:useBean id="S" class="cinemamanagement.seat" scope="session" />

            <%  //Receive values from seat.html
                String v_sched_id = request.getParameter("sched_id");
                String v_seat_type = request.getParameter("seat_type");

                S.sched_id = v_sched_id;
                S.seat_type = v_seat_type;
                int status = S.add_seat();

                if(status == 1) {
            %>
            <h1>Adding Seat Successful!</h1>
            <%  } else { %>
            <h1>Adding Seat Failed!</h1>
            <%  } %>
            
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>

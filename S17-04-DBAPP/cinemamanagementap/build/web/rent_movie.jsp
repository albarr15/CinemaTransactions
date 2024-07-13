<%-- 
    Document   : rent_movie
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cinemamanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rent Movie</title>
    </head>
    <body>
        <jsp:useBean id="T" class="cinemamanagement.ticket" scope="session" />
        <form action="rent_process.jsp">
            <h1 style="text-align:left; font-family:verdana; font-size: 200%">Rent Movie</h1>
            <table style="text-align: left;">
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Schedule ID:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="rent_sched" id="rent_sched">
                        <%  T.rent_schedList();
                            for(int i = 0; i < T.sched_idList.size(); i++) {
                        %>
                                <option value= "<%=T.sched_idList.get(i)%>"><%=T.sched_idList.get(i)%></option>
                        <% } %>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">One (1) Seat ID:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px"><input type="text" id="rent_seat" name="rent_seat" maxlength="4" style="width: 150px;" required></td>
                </tr>
                <tr>
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Payment type:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px">
                        <select name="rent_payment" id="rent_payment">
                            <option value="GCash">GCash</option>
                            <option value="PayMaya">PayMaya</option>
                            <option value="Master Card">Master Card</option>
                            <option value="Cash">Cash</option>
                        </select>
                    </td>
                </tr>
                <tr>   
                    <td style="padding-bottom: 5px; padding-left: 10px; font-size: 120%">Amount:</td>
                    <td style="padding-bottom: 5px; padding-right: 10px"><input type="number" id="rent_amount" name="rent_amount" style="width: 150px;"></td>
                </tr>
                
            </table>
                <tr>
                    <input type="submit" value="Rent Movie">
                </tr>
        </form>
    </body>
</html>

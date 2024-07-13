package cinemamanagement;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;
import java.time.*;

public class ticket {
    /*
    RETURN TYPES
        0  = error
        1  = success
        2  = insufficient amount
        11 = non-existing sched_id
        12 = non_existing seat_id
        13 = seat unavailable
    */
    
    public int       ticket_id;
    public String    sched_id;
    public int       seat_id;
    public String    payment;
    public double    amount;
    public double    price;
    public double    change;
    public java.util.Date date;
    public int       count;
    
    private final String connection = "jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678";
    
    public ArrayList<Integer>    ticket_idList = new ArrayList<>();
    public ArrayList<String>     sched_idList  = new ArrayList<>();
    public ArrayList<Integer>    seat_idList   = new ArrayList<>();
    public ArrayList<String>     paymentList   = new ArrayList<>();
    public ArrayList<Double>     amountList    = new ArrayList<>();
    public ArrayList<Double>     priceList     = new ArrayList<>();
    public ArrayList<Double>     changeList    = new ArrayList<>();
    public ArrayList<java.util.Date> dateList  = new ArrayList<>();
    public ArrayList<Integer>    countList     = new ArrayList<>();
    
    public ticket () { }
    
    public int rent_schedList() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT sched_id FROM ctmdb.sched s JOIN ctmdb.cinema c "
                                                            + "ON s.cinema_num = c.cinema_num WHERE s.avail_seats = c.total_seats;");
            ResultSet rst = pstmt.executeQuery();
            
            sched_idList.clear();
            
            while (rst.next()) {
                sched_id = rst.getString("sched_id");
                sched_idList.add(sched_id);
            }

            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	}   
    }
    
    public int rent_movie() {
        double seat_price = 0;
        String seat_type;
        double movie_price = 0;
        int num_seats = 0;
        int avail = 0;
        /*  0  = non-existent
            1  = existing
            2  = unavailable
        */
        
        try {
            //Connect to the database
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            
            //Prepare SQL statement
                //FOR TICKET_ID
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ticket_id) + 1 AS next_id FROM ctmdb.ticket");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                ticket_id = rst.getInt("next_id");
            }
            
            pstmt = conn.prepareStatement("SELECT price, avail_seats FROM ctmdb.sched WHERE sched_id = ?");
            pstmt.setString(1, sched_id);
            rst = pstmt.executeQuery();
            while (rst.next()) {
                movie_price = rst.getDouble("price");
                num_seats = rst.getInt("avail_seats");
            }
            
                //VERIFY SEAT_ID
            pstmt = conn.prepareStatement("SELECT * FROM ctmdb.seat WHERE sched_id = ?");
            pstmt.setString(1, sched_id);
            rst = pstmt.executeQuery();
            while (rst.next()) {
                    //get same seat_id
                if (rst.getInt("seat_id") == (seat_id)) {
                    avail = 1;
                    seat_type = rst.getString("seat_type"); //get seat_type for price
                        //get price of seat
                    PreparedStatement pstmt2 = conn.prepareStatement("SELECT price FROM ctmdb.seat_type WHERE seat_type = ?");
                    pstmt2.setString(1, seat_type);
                    ResultSet rst2 = pstmt2.executeQuery();
                    while (rst2.next()) {
                        seat_price = rst2.getDouble("price");
                    }
                    pstmt2.close();
                }
            }
            
                //return error
            if (avail == 0)
                return 12;
                
            price = (seat_price + movie_price) * num_seats;
            
                // return error
            if (amount < price) {
                return 2;
            } else {
                //save the new ticket
                pstmt = conn.prepareStatement("INSERT INTO ctmdb.ticket (ticket_id, sched_id, seat_id, payment_type, amount, price, pay_change, pay_date, num_tickets) "
                                                + "VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                pstmt.setInt(1, ticket_id);
                pstmt.setString(2, sched_id);
                pstmt.setInt(3, seat_id);
                pstmt.setString(4, payment);
                pstmt.setDouble(5, amount);
                pstmt.setDouble(6, price);
                change = amount - price;
                pstmt.setDouble(7, change);
                pstmt.setDate(8, java.sql.Date.valueOf(java.time.LocalDate.now()));
                pstmt.setInt(9, num_seats);
                pstmt.executeUpdate();
                
                pstmt = conn.prepareStatement("UPDATE ctmdb.seat SET seat_status = 0 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();

                pstmt = conn.prepareStatement("UPDATE ctmdb.sched SET avail_seats = 0 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
                
                
                
                pstmt.close();
                conn.close();
                
                return 1;
            }
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        } 
        
    }
    
    public int update_ticket() {
        
        double seat_price = 0;
        String seat_type;
        double movie_price = 0;
        double amount_temp = 0;
        double price_temp = 0;
        String sched_temp = "";
        int seat_temp = 0;
        int avail = 0;
        /*  0  = non-existent
            1  = existing
            2  = unavailable
        */
        
        try {
            //Connect to the database
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT amount, price, seat_id, sched_id FROM ctmdb.ticket WHERE ticket_id = ?");
            pstmt.setInt(1, ticket_id);
            ResultSet rst = pstmt.executeQuery();
            
            while (rst.next()) {
                amount_temp = rst.getDouble("amount");
                price_temp = rst.getDouble("price");
                seat_temp = rst.getInt("seat_id");
                sched_temp = rst.getString("sched_id");
            }
            
            pstmt = conn.prepareStatement("SELECT price FROM ctmdb.sched WHERE sched_id = ?");
            pstmt.setString(1, sched_id);
            rst = pstmt.executeQuery();
            while (rst.next()) {
                movie_price = rst.getDouble("price");
            }
            
                //VERIFY SEAT_ID AND CHECK IF AVAILABLE SEAT
            pstmt = conn.prepareStatement("SELECT * FROM ctmdb.seat WHERE sched_id = ?");
            pstmt.setString(1, sched_id);
            rst = pstmt.executeQuery();
            while (rst.next()) {
                    //get same seat_id
                if (rst.getInt("seat_id") == (seat_id)) {
                        //check if available
                    if (rst.getInt("seat_status") == 1) {
                        avail = 1;
                        seat_type = rst.getString("seat_type"); //get seat_type for price
                            //get price of seat
                        PreparedStatement pstmt2 = conn.prepareStatement("SELECT price FROM ctmdb.seat_type WHERE seat_type = ?");
                        pstmt2.setString(1, seat_type);
                        ResultSet rst2 = pstmt2.executeQuery();
                        while (rst2.next()) {
                            seat_price = rst2.getDouble("price");
                        }
                        pstmt2.close();
                    } else
                        avail = 2; //seat unavailable
                    break;
                }
            }
            
                //return error
            if (avail == 0)
                return 12;
            else if (avail == 2)
                return 13;
                
            price = seat_price + movie_price;
            double extra = price - price_temp;
            
                // return error
            if (amount < extra) {
                return 2;
            } else {
                //save the new ticket
                pstmt = conn.prepareStatement("UPDATE ticket SET sched_id = ?, seat_id = ?, payment_type = ?, amount = ?, price = ?, "
                                                + "pay_change = ?, pay_date = ?, num_tickets = 1 WHERE ticket_id = ?");
                
                pstmt.setString(1, sched_id);
                pstmt.setInt(2, seat_id);
                pstmt.setString(3, payment);
                amount += amount_temp;
                pstmt.setDouble(4, amount);
                pstmt.setDouble(5, price);
                change = amount - price;
                pstmt.setDouble(6, change);
                pstmt.setDate(7, java.sql.Date.valueOf(java.time.LocalDate.now()));
                pstmt.setInt(8, ticket_id);

                pstmt.executeUpdate();
                pstmt.close();
                conn.close();
                
                update_buy(1);
                
                seat_id = seat_temp;
                sched_id = sched_temp;
                
                update_buy(0);
                
                return 1;
            }
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }  
    }
    
    public int get_ticketListUpdate() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT t.ticket_id FROM ctmdb.ticket t JOIN ctmdb.sched s "
                                                                + "ON t.sched_id = s.sched_id WHERE s.date > t.pay_date AND s.date > NOW()");
            ResultSet rst = pstmt.executeQuery();
            
            ticket_idList.clear();
            
            while (rst.next()) {
                ticket_id = rst.getInt("ticket_id");
                ticket_idList.add(ticket_id);
            }

            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	}   
    }
    
    public int get_schedListUpdate() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT sched_id FROM ctmdb.sched WHERE date >= NOW()");
            ResultSet rst = pstmt.executeQuery();
            
            sched_idList.clear();
            
            while (rst.next()) {
                sched_id = rst.getString("sched_id");
                sched_idList.add(sched_id);
            }

            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	}   
    }
    
    public int get_ticketList() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT ticket_id FROM ctmdb.ticket");
            ResultSet rst = pstmt.executeQuery();
            
            ticket_idList.clear();
            
            while (rst.next()) {
                ticket_id = rst.getInt("ticket_id");
                ticket_idList.add(ticket_id);
            }

            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	}   
    }
    
    public int delete_ticket(int ticket) {
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            String date = java.time.LocalDate.now().toString();
            LocalDate dateNow = java.time.LocalDate.now();
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT pay_date, seat_id, sched_id FROM ctmdb.ticket WHERE ticket_id = ?");
            pstmt.setInt(1, ticket);
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                date = rst.getString("pay_date");
                seat_id = rst.getInt("seat_id");
                sched_id = rst.getString("sched_id");
            }
            
            LocalDate dateTkt = LocalDate.parse(date);
            
            if(dateTkt.isAfter(dateNow))
                update_buy(0);

            pstmt = conn.prepareStatement("DELETE from ctmdb.ticket WHERE ticket_id = ?");
            pstmt.setInt(1, ticket);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	} 
    }
    
    public int search_ticket (String search, String value) {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            
            String newSearch = search;
            
            if (search.equalsIgnoreCase("amount_exact") || search.equalsIgnoreCase("amount_less")
                    || search.equalsIgnoreCase("amount_more")) {
                newSearch = "amount";
            }
            
            if (search.equalsIgnoreCase("price_exact") || search.equalsIgnoreCase("price_less")
                    || search.equalsIgnoreCase("price_more")) {
                newSearch = "price";
            }
            
            if (search.equalsIgnoreCase("change_exact") || search.equalsIgnoreCase("change_less")
                    || search.equalsIgnoreCase("change_more")) {
                newSearch = "pay_change";
            }
            
            if (search.equalsIgnoreCase("date_exact") || search.equalsIgnoreCase("date_before")
                    || search.equalsIgnoreCase("date_after")) {
                newSearch = "pay_date";
            }
            
            if (search.equalsIgnoreCase("single") || search.equalsIgnoreCase("rent"))
                newSearch = "num_tickets";
            
            String sql_statement = "SELECT * FROM ctmdb.ticket WHERE " + newSearch;
            String add;
            
            switch (search) {
                /*
                case "ticket_id":
                case "seat_id":
                    int nVal = Integer.parseInt(value);
                    add = " = " + nVal;
                    break;
                */
                case "amount_exact":
                case "price_exact":
                case "change_exact":
                    double dVal = Double.parseDouble(value);
                    add = " = " + dVal;
                    break;
                case "amount_less":
                case "price_less":
                case "change_less":
                    double dValL = Double.parseDouble(value);
                    add = " < " + dValL;
                    break;
                case "change_more":
                case "price_more":
                case "amount_more":
                    double dValM = Double.parseDouble(value);
                    add = " > " + dValM;
                    break;
                    
                case "date_before":
                    add = " < '" + value + "'";
                    break;
                case "date_after":
                    add = " > '" + value + "'";
                    break;
                    
                case "single":
                    add = " = 1";
                    break;
                case "rent":
                    add = " > 1";
                    break;
                default: add = " LIKE '%" + value + "%'";
            }
            String final_sql = sql_statement + add;
            
            PreparedStatement pstmt = conn.prepareStatement(final_sql);
            ResultSet rst = pstmt.executeQuery();
            
            ticket_idList.clear();
            sched_idList.clear();
            seat_idList.clear();
            paymentList.clear();
            amountList.clear();
            priceList.clear();
            changeList.clear();
            dateList.clear();
            countList.clear();
    
            int nCtr = 0;
            
            while (rst.next()) {
                ticket_id = rst.getInt("ticket_id");
                sched_id = rst.getString("sched_id");
                seat_id = rst.getInt("seat_id");
                payment = rst.getString("payment_type");
                amount = rst.getDouble("amount");
                price = rst.getDouble("price");
                change = rst.getDouble("pay_change");
                date = rst.getDate("pay_date");
                count = rst.getInt("num_tickets");
  
                ticket_idList.add(ticket_id);
                sched_idList.add(sched_id);
                seat_idList.add(seat_id);
                paymentList.add(payment);
                amountList.add(amount);
                priceList.add(price);
                changeList.add(change);
                dateList.add(date);
                countList.add(count);
                nCtr++;
            }

            pstmt.close();
            conn.close();

            return nCtr;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return -1;
	} 
    }
    
    public int search_all() {
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
	
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ctmdb.ticket");
            ResultSet rst = pstmt.executeQuery();
            
            ticket_idList.clear();
            sched_idList.clear();
            seat_idList.clear();
            paymentList.clear();
            amountList.clear();
            priceList.clear();
            changeList.clear();
            dateList.clear();
            countList.clear();
            
            int nCtr = 0;
            
            while (rst.next()) {
                ticket_id = rst.getInt("ticket_id");
                sched_id = rst.getString("sched_id");
                seat_id = rst.getInt("seat_id");
                payment = rst.getString("payment_type");
                amount = rst.getDouble("amount");
                price = rst.getDouble("price");
                change = rst.getDouble("pay_change");
                date = rst.getDate("pay_date");
                count = rst.getInt("num_tickets");
  
                ticket_idList.add(ticket_id);
                sched_idList.add(sched_id);
                seat_idList.add(seat_id);
                paymentList.add(payment);
                amountList.add(amount);
                priceList.add(price);
                changeList.add(change);
                dateList.add(date);
                countList.add(count);
                nCtr++;
            }

            pstmt.close();
            conn.close();

            return nCtr;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return -1;
        } 
        
    }
    
    public int update_buy(int buy) {
        /*
            buy = 1 means seat is taken
            buy = 0 means ticket is deleted
        */
        try {
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt;
                
            if(buy == 1) {
                //update seat_status to 0 since taken already
                pstmt = conn.prepareStatement("UPDATE ctmdb.seat SET seat_status = 0 WHERE seat_id = ?");
                pstmt.setInt(1, seat_id);
                pstmt.executeUpdate();

                //update avail_seats since -1
                pstmt = conn.prepareStatement("UPDATE ctmdb.sched SET avail_seats = avail_seats - 1 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
            } else {
                //update seat_status to 1 since ticket does not exist
                pstmt = conn.prepareStatement("UPDATE ctmdb.seat SET seat_status = 1 WHERE seat_id = ?");
                pstmt.setInt(1, seat_id);
                pstmt.executeUpdate();

                //update avail_seats since +1
                pstmt = conn.prepareStatement("UPDATE ctmdb.sched SET avail_seats = avail_seats + 1 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
            }
            
            pstmt.close();
            conn.close();

            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int buy_ticket() {
        double seat_price = 0;
        String seat_type;
        double movie_price = 0;
        int avail = 0;
        /*  0  = non-existent
            1  = existing
            2  = unavailable
        */
        
        try {
            //Connect to the database
            Connection conn;
            conn = DriverManager.getConnection(connection);
            System.out.println("Connection Successful");
            
            //Prepare SQL statement
            
                //FOR TICKET_ID
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ticket_id) + 1 AS next_id FROM ctmdb.ticket");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                ticket_id = rst.getInt("next_id");
            }
            
                //VERIFY SCHED_ID
            pstmt = conn.prepareStatement("SELECT sched_id, price FROM ctmdb.sched");
            rst = pstmt.executeQuery();
            while (rst.next()) {
                if (rst.getString("sched_id").equalsIgnoreCase(sched_id)) {
                    avail = 1;
                    movie_price = rst.getDouble("price");
                    break;
                }
            }
                //return error
            if (avail == 0)
                return 11;
            else
                avail = 0;
            
                //VERIFY SEAT_ID AND CHECK IF AVAILABLE SEAT
            pstmt = conn.prepareStatement("SELECT * FROM ctmdb.seat WHERE sched_id = ?");
            pstmt.setString(1, sched_id);
            rst = pstmt.executeQuery();
            while (rst.next()) {
                    //get same seat_id
                if (rst.getInt("seat_id") == (seat_id)) {
                        //check if available
                    if (rst.getInt("seat_status") == 1) {
                        avail = 1;
                        seat_type = rst.getString("seat_type"); //get seat_type for price
                            //get price of seat
                        PreparedStatement pstmt2 = conn.prepareStatement("SELECT price FROM ctmdb.seat_type WHERE seat_type = ?");
                        pstmt2.setString(1, seat_type);
                        ResultSet rst2 = pstmt2.executeQuery();
                        while (rst2.next()) {
                            seat_price = rst2.getDouble("price");
                        }
                        pstmt2.close();
                    } else
                        avail = 2; //seat unavailable
                    break;
                }
            }
            
                //return error
            if (avail == 0)
                return 12;
            else if (avail == 2)
                return 13;
                
            price = seat_price + movie_price;
            
                // return error
            if (amount < price) {
                return 2;
            } else {
                //save the new ticket
                pstmt = conn.prepareStatement("INSERT INTO ticket (ticket_id, sched_id, seat_id, payment_type, amount, price, pay_change, pay_date, num_tickets) "
                                                + "VALUE (?, ?, ?, ?, ?, ?, ?, ?, 1)");
                pstmt.setInt(1, ticket_id);
                pstmt.setString(2, sched_id);
                pstmt.setInt(3, seat_id);
                pstmt.setString(4, payment);
                pstmt.setDouble(5, amount);
                pstmt.setDouble(6, price);
                change = amount - price;
                pstmt.setDouble(7, change);
                pstmt.setDate(8, java.sql.Date.valueOf(java.time.LocalDate.now()));

                pstmt.executeUpdate();
                pstmt.close();
                conn.close();
                
                update_buy(1);
                
                return 1;
            }
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }       
    }
    
    public static void main (String args[]) {
        
        //ticket t = new ticket();
        //t.sched_id = "S000000002";
        //t.seat_id = "2001";
        //t.payment = "Cash";
        //t.amount = 200.0;
        //t.buy_ticket();
    }
}

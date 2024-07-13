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

public class seat {
    
    // fields of seats
    public Integer seat_id;
    public String seat_type;
    public String sched_id;
    public int seat_status;
    
    // list of seats
    public ArrayList<Integer> seat_idlist        = new ArrayList<> ();
    public ArrayList<String> seat_typelist      = new ArrayList<> ();
    public ArrayList<String> sched_idlist    = new ArrayList<> ();
    public ArrayList<Integer> seat_statuslist   = new ArrayList<> ();
    
    
    public seat() {}
    
    public int get_seatList() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT seat_id FROM ctmdb.seat");
            ResultSet rst = pstmt.executeQuery();
            
            seat_idlist.clear();
            
            while (rst.next()) {
                seat_id = rst.getInt("seat_id");
                seat_idlist.add(seat_id);
            }

            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	}   
    }
    
    public int add_seat() {
        
        try{
            // Connect to database
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            // Prepare SQL Statement
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(seat_id)+1 AS next_id  FROM ctmdb.seat");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                seat_id = rst.getInt("next_id");
            }
            
            // Save new seat
            pstmt = conn.prepareStatement("INSERT INTO seat (seat_id, seat_type, sched_id, seat_status) VALUE (?, ?, ?, ?)");
            pstmt.setInt(1, seat_id);
            pstmt.setString(2, seat_type);
            pstmt.setString(3, sched_id);
            seat_status = 1; // seat will always be available upon creation
            pstmt.setInt(4, seat_status);
            
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            
            System.out.println("Successful");
            System.out.println("Seat: " + seat_id);
            System.out.println("Schedule: " + sched_id);
            System.out.println("Seat Type: " + seat_type);
            System.out.println("Status: " + seat_status);
            return 1;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
        
    }
    
    public int update_seat(String sched_id, String seat_type, Integer status) {
        /*
            1 means seat is available
            0 means ticket is occupied
        */
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt;
                
            if(status == 1) {
                //update avail_seats since +1
                pstmt = conn.prepareStatement("UPDATE ctmdb.sched SET avail_seats = avail_seats + 1 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
                
                // update seat_status
                pstmt = conn.prepareStatement("UPDATE ctmdb.seat SET seat_status = 0 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
            } else {
                // update avail_seats since -1
                pstmt = conn.prepareStatement("UPDATE ctmdb.sched SET avail_seats = avail_seats - 1 WHERE sched_id = ?");
                pstmt.setString(1, sched_id);
                pstmt.executeUpdate();
                
                // update seat_status
                pstmt = conn.prepareStatement("UPDATE ctmdb.seat SET seat_status = 1 WHERE sched_id = ?");
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
    
    public int delete_seat(int seat) {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt;

            pstmt = conn.prepareStatement("DELETE from ctmdb.seat WHERE seat_id = ?");
            pstmt.setInt(1, seat);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            return 1;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
	} 
    }
    
    public int search_seat(String search, String value) {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            String newSearch = search;
            
            if (search.equalsIgnoreCase("seat_status_avail") || search.equalsIgnoreCase("seat_status_occupied")) {
                newSearch = "seat_status";
            }
            
            if (search.equalsIgnoreCase("seat_type_reg") || search.equalsIgnoreCase("seat_type_prem")
                    || search.equalsIgnoreCase("seat_type_pwd")) {
                newSearch = "seat_type";
            }
            
            if (search.equalsIgnoreCase("sched_id")) {
                newSearch = "sched_id";
            }
            
            String sql_statement = "SELECT * FROM ctmdb.seat WHERE " + newSearch;
            String add;
            
            switch (search) {
                
                case "seat_status_avail":
                    add = "= 1";
                    break;
                case "seat_status_occupied":
                    add = "= 0";
                    break;
                case "seat_type_reg":
                    add = "= 'regular'";
                    break;
                case "seat_type_prem":
                    add = "= 'premium'";
                    break;
                case "seat_type_pwd":
                    add = "= 'pwd'";
                    break;
                case "sched_id":
                    add = " = '" + value + "'";
                    break;
                default: add = " LIKE '%" + value + "%'";
                    break;
            }
            
            String final_sql = sql_statement + add;
            
            PreparedStatement pstmt = conn.prepareStatement(final_sql);
            ResultSet rst = pstmt.executeQuery();
            
            seat_idlist.clear();
            seat_typelist.clear();
            sched_idlist.clear();
            seat_statuslist.clear();
    
            int count = 0;
            
            while (rst.next()) {
                seat_id = rst.getInt("seat_id");
                seat_type = rst.getString("seat_type");
                sched_id = rst.getString("sched_id");
                seat_status = rst.getInt("seat_status");
  
                seat_idlist.add(seat_id);
                seat_typelist.add(seat_type);
                sched_idlist.add(sched_id);
                seat_statuslist.add(seat_status);
                count++;
            }

            pstmt.close();
            conn.close();

            return count;
	} catch (Exception e) {
            System.out.println(e.getMessage());
            return -1;
	} 
    }
    
    public int search_all() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
	
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ctmdb.seat");
            ResultSet rst = pstmt.executeQuery();
            
            seat_idlist.clear();
            seat_typelist.clear();
            sched_idlist.clear();
            seat_statuslist.clear();
            
            int count = 0;
            
            while (rst.next()) {
                seat_id = rst.getInt("seat_id");
                seat_type = rst.getString("seat_type");
                sched_id = rst.getString("sched_id");
                seat_status = rst.getInt("seat_status");
  
                seat_idlist.add(seat_id);
                seat_typelist.add(seat_type);
                sched_idlist.add(sched_id);
                seat_statuslist.add(seat_status);
                count++;
            }

            pstmt.close();
            conn.close();

            return count;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return -1;
        } 
        
    }
    
    public static void main (String args[]) {
        seat s = new seat();
        s.sched_id = "S000000005";
        s.seat_type = "regular";
        s.add_seat();
        
        
    }
}

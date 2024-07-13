/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cinemamanagement;

import java.sql.*;

/**
 *
 * @author ccslearner
 */
public class schedule {
    public int status;

    public schedule () { }
    
    public int displayScheds() {
        try {
            //Connect to the database
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT schedule.sched_id, schedule.date_time, movie.movie_title, schedule.cinema_num FROM schedule LEFT JOIN movie ON schedule.movie_id = movie.movie_id");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                System.out.println("Schedule ID: " + rst.getString("sched_id"));
                System.out.println("Schedule: " + rst.getString("date_time"));
                System.out.println("Movie: " + rst.getString("movie_title"));
                System.out.println("Cinema  " + rst.getString("cinema_num"));
            }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            status = 0;
        }
        return status;
    }
    public static void main (String args[]) { }
}
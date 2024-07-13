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
import java.sql.*;
public class movie {
    
    public int status;

    public movie () { }
    
    public int displayMovies() {
        
        try {
            //Connect to the database
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ctmdb?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM movie WHERE movie_status = 'now showing OR movie_status = 'coming soon");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                System.out.println(rst.getString("movie_title"));
                System.out.println("Rated " + rst.getString("rating"));
                System.out.println("Genre/s: " + rst.getString("genre"));
                System.out.println("Directed by: " + rst.getString("director"));
                System.out.println("Starring: " + rst.getString("actors"));
                System.out.println("Synopsis: " + rst.getString("Synopsis: "));
                System.out.println("Available in: " + rst.getString("movie_type"));
                System.out.println("Runtime: " + rst.getString("minutes"));
                System.out.println("Status: " + rst.getString("movie_status"));
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
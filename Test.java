import java.sql.*;

public class Test {
    public static void main(String[] args) throws Exception {
        String URL = "jdbc:mysql://localhost:3306/emergency_db";
        String USER = "root";
        String PASSWORD = "root";
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Contacts:");
            try (Statement s = conn.createStatement(); ResultSet rs = s.executeQuery("SELECT * FROM contacts")) {
                int count = 0;
                while (rs.next()) {
                    System.out.println(rs.getString("name") + " - " + rs.getString("phone") + " - " + rs.getString("email"));
                    count++;
                }
                System.out.println("Total contacts: " + count);
            }
            
            System.out.println("\nAlert Logs:");
            try (Statement s = conn.createStatement(); ResultSet rs = s.executeQuery("SELECT * FROM alert_logs ORDER BY id DESC LIMIT 5")) {
                while(rs.next()) {
                    System.out.println(rs.getString("status") + " | " + rs.getString("message"));
                }
            }
        }
    }
}

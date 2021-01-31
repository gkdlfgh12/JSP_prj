package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
		try {
			String dbUrl = "jdbc:oracle:thin:@localhost:1521/XEPDB1";
			String uid = "book_ex";
			String upw = "book_ex";
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			return DriverManager.getConnection(dbUrl, uid, upw);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}

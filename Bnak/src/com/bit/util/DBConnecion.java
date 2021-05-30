package com.bit.util;

import java.sql.Connection;
import java.sql.DriverManager;

//mysql연결
public class DBConnecion {
	public static Connection getConnection() {
		try {
			//mysql db연결
			String url = "jdbc:mysql://localhost:3306/bankdb?useSSL=false";
			String user="root";
			String password="1234";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(url, user, password);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}

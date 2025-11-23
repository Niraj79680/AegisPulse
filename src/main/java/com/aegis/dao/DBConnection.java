package com.aegis.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // 1. Database URL: Connects to localhost on port 3306, database name is 'aegis_db'
    private static final String URL = "jdbc:mysql://localhost:3306/aegis_db";

    // 2. Database Credentials
    private static final String USER = "root";

    // 3. YOUR PASSWORD HERE
    // If you set a password in the installer, put it here.
    // If you didn't set one (rare for the installer method), leave it empty "".
    private static final String PASSWORD = "Constitution123";

    // Method to get a connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Database Connection Failed!");
        }
        return conn;
    }
}
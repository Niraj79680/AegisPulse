package com.aegis.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // db config (local mysql)
    private static final String URL = "jdbc:mysql://localhost:3306/aegis_db";
    private static final String USER = "root";
    private static final String PASSWORD = "Constitution123";

    // returns a live db connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // load mysql driver (required for jdbc)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // open connection to db
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException | SQLException e) {
            // driver missing or db unreachable
            e.printStackTrace();
            System.out.println("Database Connection Failed!");
        }
        return conn; // may return null if failed
    }
}

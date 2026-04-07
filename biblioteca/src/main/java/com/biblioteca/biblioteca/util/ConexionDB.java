package com.biblioteca.biblioteca.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {
    private static final String URL = "jdbc:mysql://localhost:3306/biblioteca_db?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "adso123";
    private static Connection conexion = null;

    private ConexionDB() {}

    public static Connection getConexion() {
        try {
            if (conexion == null || conexion.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conexion;
    }
}
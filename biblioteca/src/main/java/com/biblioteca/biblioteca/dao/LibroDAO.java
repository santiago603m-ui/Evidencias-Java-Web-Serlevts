package com.biblioteca.biblioteca.dao;

import com.biblioteca.biblioteca.modelo.Libro;
import com.biblioteca.biblioteca.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {

    public List<Libro> listar() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libros";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Libro(rs.getInt("id_libro"), rs.getString("titulo"), rs.getString("autor"), rs.getInt("disponibles")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean crear(Libro l) {
        String sql = "INSERT INTO libros (titulo, autor, disponibles) VALUES (?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, l.getTitulo());
            ps.setString(2, l.getAutor());
            ps.setInt(3, l.getDisponibles());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editar(Libro l) {
        String sql = "UPDATE libros SET titulo=?, autor=?, disponibles=? WHERE id_libro=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, l.getTitulo());
            ps.setString(2, l.getAutor());
            ps.setInt(3, l.getDisponibles());
            ps.setInt(4, l.getIdLibro());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM libros WHERE id_libro=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Libro buscarPorId(int id) {
        String sql = "SELECT * FROM libros WHERE id_libro=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Libro(rs.getInt("id_libro"), rs.getString("titulo"), rs.getString("autor"), rs.getInt("disponibles"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
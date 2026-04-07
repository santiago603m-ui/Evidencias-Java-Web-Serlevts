package com.biblioteca.biblioteca.dao;

import com.biblioteca.biblioteca.modelo.Prestamo;
import com.biblioteca.biblioteca.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {

    private final String SELECT_BASE = "SELECT p.*, u.nombre AS nombre_usuario, l.titulo AS titulo_libro FROM prestamos p JOIN usuarios u ON p.id_usuario = u.id_usuario JOIN libros l ON p.id_libro = l.id_libro";

    public List<Prestamo> listar() {
        List<Prestamo> lista = new ArrayList<>();
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(SELECT_BASE);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearPrestamo(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Prestamo buscarPorId(int id) {
        String sql = SELECT_BASE + " WHERE p.id_prestamo=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapearPrestamo(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Prestamo> listarPorUsuario(int idUsuario) {
        List<Prestamo> lista = new ArrayList<>();
        String sql = SELECT_BASE + " WHERE p.id_usuario=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapearPrestamo(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    private Prestamo mapearPrestamo(ResultSet rs) throws SQLException {
        return new Prestamo(
                rs.getInt("id_prestamo"),
                rs.getInt("id_usuario"),
                rs.getInt("id_libro"),
                rs.getDate("fecha_prestamo"),
                rs.getDate("fecha_devolucion"),
                rs.getString("estado"),
                rs.getString("nombre_usuario"),
                rs.getString("titulo_libro")
        );
    }

    public boolean crear(Prestamo p) {
        String sql = "INSERT INTO prestamos (id_usuario, id_libro, fecha_prestamo, estado) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, p.getIdUsuario());
            ps.setInt(2, p.getIdLibro());
            ps.setDate(3, p.getFechaPrestamo());
            ps.setString(4, "ACTIVO");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarEstado(int id, String estado, Date fechaDev) {
        String sql = "UPDATE prestamos SET estado=?, fecha_devolucion=? WHERE id_prestamo=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setDate(2, fechaDev);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM prestamos WHERE id_prestamo=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
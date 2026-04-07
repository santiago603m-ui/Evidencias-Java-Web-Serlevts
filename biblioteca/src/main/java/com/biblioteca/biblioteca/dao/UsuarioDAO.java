package com.biblioteca.biblioteca.dao;

import com.biblioteca.biblioteca.modelo.Usuario;
import com.biblioteca.biblioteca.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public Usuario validar(String correo, String pass) {
        String sql = "SELECT * FROM usuarios WHERE correo=? AND password=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(rs.getInt("id_usuario"), rs.getString("nombre"), rs.getString("correo"), rs.getString("password"), rs.getString("rol"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Usuario(rs.getInt("id_usuario"), rs.getString("nombre"), rs.getString("correo"), rs.getString("password"), rs.getString("rol")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean crear(Usuario u) {
        String sql = "INSERT INTO usuarios (nombre, correo, password, rol) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editar(Usuario u) {
        String sql = "UPDATE usuarios SET nombre=?, correo=?, password=?, rol=? WHERE id_usuario=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            ps.setInt(5, u.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM usuarios WHERE id_usuario=?";
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
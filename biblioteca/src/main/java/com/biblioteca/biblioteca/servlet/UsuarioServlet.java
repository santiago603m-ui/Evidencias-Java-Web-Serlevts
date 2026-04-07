package com.biblioteca.biblioteca.servlet;

import com.biblioteca.biblioteca.dao.UsuarioDAO;
import com.biblioteca.biblioteca.modelo.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("logout".equals(accion)) {
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("login".equals(accion)) {
            String correo = request.getParameter("txtCorreo");
            String clave = request.getParameter("txtPass");

            Usuario usuario = usuarioDAO.validar(correo, clave);

            if (usuario != null) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("user", usuario);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Credenciales incorrectas");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("registrar".equals(accion)) {
            String nombre = request.getParameter("txtNombre");
            String correo = request.getParameter("txtCorreo");
            String clave = request.getParameter("txtPass");

            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setNombre(nombre);
            nuevoUsuario.setCorreo(correo);
            nuevoUsuario.setPassword(clave);
            nuevoUsuario.setRol("ESTUDIANTE");

            boolean insertado = usuarioDAO.crear(nuevoUsuario);

            if (insertado) {
                request.setAttribute("mensaje", "Registro exitoso. Ya puedes iniciar sesión.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "No se pudo completar el registro. El correo podría estar en uso.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}

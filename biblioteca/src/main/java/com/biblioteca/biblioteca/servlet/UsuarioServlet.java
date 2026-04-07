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
        }
    }
}
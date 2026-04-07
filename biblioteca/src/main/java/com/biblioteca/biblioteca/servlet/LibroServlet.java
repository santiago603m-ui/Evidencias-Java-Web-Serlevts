package com.biblioteca.biblioteca.servlet;

import com.biblioteca.biblioteca.dao.LibroDAO;
import com.biblioteca.biblioteca.modelo.Libro;
import com.biblioteca.biblioteca.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LibroServlet", urlPatterns = {"/LibroServlet"})
public class LibroServlet extends HttpServlet {

    private LibroDAO libroDAO = new LibroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        accion = (accion == null) ? "listar" : accion;

        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (accion) {
            case "listar":
                List<Libro> lista = libroDAO.listar();
                request.setAttribute("libros", lista);
                request.getRequestDispatcher("vistas/ListadoLibros.jsp").forward(request, response);
                break;

            case "editar":
                int idEdit = Integer.parseInt(request.getParameter("id"));
                Libro lib = libroDAO.buscarPorId(idEdit);
                request.setAttribute("libro", lib);
                request.getRequestDispatcher("vistas/EditarLibro.jsp").forward(request, response);
                break;

            case "nuevo":
                if ("ADMIN".equals(user.getRol())) {
                    request.getRequestDispatcher("vistas/FormularioCrearLibro.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                break;

            case "eliminar":
                if ("ADMIN".equals(user.getRol())) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    libroDAO.eliminar(id);
                    response.sendRedirect("LibroServlet?accion=listar");
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                break;

            default:
                response.sendRedirect("LibroServlet?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accion = request.getParameter("accion");

        if ("ADMIN".equals(user.getRol())) {
            String titulo = request.getParameter("txtTitulo");
            String autor = request.getParameter("txtAutor");
            int stock = Integer.parseInt(request.getParameter("txtStock"));

            if ("guardar".equals(accion)) {
                Libro nuevoLibro = new Libro(0, titulo, autor, stock);
                libroDAO.crear(nuevoLibro);
            } else if ("actualizar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("txtId"));
                Libro libroEdit = new Libro(id, titulo, autor, stock);
                libroDAO.editar(libroEdit);
            }
            response.sendRedirect("LibroServlet?accion=listar");
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }
}

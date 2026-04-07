package com.biblioteca.biblioteca.servlet;

import com.biblioteca.biblioteca.dao.PrestamoDAO;
import com.biblioteca.biblioteca.dao.LibroDAO;
import com.biblioteca.biblioteca.modelo.Prestamo;
import com.biblioteca.biblioteca.modelo.Usuario;
import com.biblioteca.biblioteca.modelo.Libro;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PrestamoServlet", urlPatterns = {"/PrestamoServlet"})
public class PrestamoServlet extends HttpServlet {

    private PrestamoDAO prestamoDAO = new PrestamoDAO();
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
                if ("ADMIN".equals(user.getRol())) {
                    List<Prestamo> lista = prestamoDAO.listar();
                    request.setAttribute("prestamos", lista);
                    request.getRequestDispatcher("vistas/ListadoPrestamos.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                break;

            case "mis_prestamos":
                List<Prestamo> misPrestamos = prestamoDAO.listarPorUsuario(user.getIdUsuario());
                request.setAttribute("prestamos", misPrestamos);
                request.getRequestDispatcher("vistas/PrestamosUsuario.jsp").forward(request, response);
                break;

            case "nuevo":
                List<Libro> librosDisponibles = libroDAO.listar();
                request.setAttribute("libros", librosDisponibles);
                request.getRequestDispatcher("vistas/NuevoPrestamo.jsp").forward(request, response);
                break;

            case "eliminar":
                if ("ADMIN".equals(user.getRol())) {
                    String idParam = request.getParameter("id");
                    if (idParam == null) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    int id = Integer.parseInt(idParam);
                    prestamoDAO.eliminar(id);
                    response.sendRedirect("PrestamoServlet?accion=listar");
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                break;

            case "devolver":
                String idParam = request.getParameter("id");
                if (idParam == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }

                int idPrestamo = Integer.parseInt(idParam);
                Prestamo p = prestamoDAO.buscarPorId(idPrestamo);

                if (p != null) {
                    long millis = System.currentTimeMillis();
                    Date fechaDev = new Date(millis);

                    prestamoDAO.actualizarEstado(idPrestamo, "DEVUELTO", fechaDev);

                    Libro lib = libroDAO.buscarPorId(p.getIdLibro());
                    if (lib != null) {
                        lib.setDisponibles(lib.getDisponibles() + 1);
                        libroDAO.editar(lib);
                    }
                }

                response.sendRedirect("PrestamoServlet?accion=listar");
                break;

            default:
                response.sendRedirect("PrestamoServlet?accion=mis_prestamos");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("user");
        String accion = request.getParameter("accion");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (accion == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if ("guardar".equals(accion)) {
            int idLibro = Integer.parseInt(request.getParameter("idLibro"));
            int idUsuario = user.getIdUsuario();

            Libro lib = libroDAO.buscarPorId(idLibro);

            if (lib == null || lib.getDisponibles() <= 0) {
                request.setAttribute("error", "No hay libros disponibles");
                request.getRequestDispatcher("vistas/NuevoPrestamo.jsp").forward(request, response);
                return;
            }

            long millis = System.currentTimeMillis();
            Date fechaActual = new Date(millis);

            Prestamo p = new Prestamo();
            p.setIdLibro(idLibro);
            p.setIdUsuario(idUsuario);
            p.setFechaPrestamo(fechaActual);

            boolean ok = prestamoDAO.crear(p);

            if (ok) {
                lib.setDisponibles(lib.getDisponibles() - 1);
                libroDAO.editar(lib);
            }

            if ("ADMIN".equals(user.getRol())) {
                response.sendRedirect("PrestamoServlet?accion=listar");
            } else {
                response.sendRedirect("PrestamoServlet?accion=mis_prestamos");
            }
        }
    }
}
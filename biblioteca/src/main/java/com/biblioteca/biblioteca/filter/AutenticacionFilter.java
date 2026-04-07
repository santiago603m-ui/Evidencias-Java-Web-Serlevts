package com.biblioteca.biblioteca.filter;

import com.biblioteca.biblioteca.modelo.Usuario;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/dashboard.jsp", "/LibroServlet", "/PrestamoServlet", "/vistas/*"})
public class AutenticacionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            Usuario usuario = (Usuario) session.getAttribute("user");
            String accion = httpRequest.getParameter("accion");

            if (accion != null) {
                boolean esAccionAdmin = accion.equals("guardar")
                        || accion.equals("actualizar")
                        || accion.equals("eliminar")
                        || accion.equals("editar")
                        || accion.equals("nuevo");

                String uri = httpRequest.getRequestURI();
                boolean esLibroServlet = uri.contains("LibroServlet");

                if (esAccionAdmin && esLibroServlet && !"ADMIN".equals(usuario.getRol())) {
                    httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN,
                            "No tiene permisos de administrador.");
                    return;
                }
            }

            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}

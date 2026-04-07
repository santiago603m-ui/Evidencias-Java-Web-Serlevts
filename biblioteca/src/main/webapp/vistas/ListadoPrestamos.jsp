<%@page import="java.util.List"%>
<%@page import="com.biblioteca.biblioteca.modelo.Prestamo"%>
<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mis Préstamos — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --gold: #C9A84C;
                --gold-light: #E8C97A;
                --gold-dark: #8B6914;
                --black: #080808;
                --black-card: #111111;
                --white: #F5F0E8;
                --white-dim: #8A8070;
                --border: rgba(201,168,76,0.15);
                --success: #2ecc71;
                --danger: #e74c3c;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Raleway', sans-serif;
                background: var(--black);
                color: var(--white);
                min-height: 100vh;
            }

            .page-header {
                padding: 40px 60px 30px;
                border-bottom: 1px solid var(--border);
                background: linear-gradient(180deg, rgba(201,168,76,0.04) 0%, transparent 100%);
            }

            .page-header h1 {
                font-family: 'Cinzel', serif;
                font-size: 26px;
                margin-bottom: 6px;
            }

            .page-header p {
                font-size: 12px;
                color: var(--white-dim);
            }

            .main-content {
                padding: 40px 60px 80px;
            }

            .stats-row {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
                margin-bottom: 40px;
            }

            .stat-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 16px;
                padding: 24px;
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .stat-icon {
                width: 44px;
                height: 44px;
                background: rgba(201,168,76,0.08);
                border: 1px solid var(--border);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--gold);
            }

            .stat-label {
                font-size: 10px;
                color: var(--white-dim);
                letter-spacing: 1.5px;
                text-transform: uppercase;
                margin-bottom: 4px;
            }

            .stat-value {
                font-family: 'Cinzel', serif;
                font-size: 22px;
                font-weight: 700;
                color: var(--gold);
            }

            .table-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 20px;
                overflow: hidden;
            }

            .table-card-header {
                padding: 20px 24px;
                border-bottom: 1px solid var(--border);
            }

            .table-card-header h3 {
                font-family: 'Cinzel', serif;
                font-size: 13px;
                color: var(--white);
                letter-spacing: 1px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead tr {
                background: rgba(201,168,76,0.06);
                border-bottom: 1px solid var(--border);
            }

            thead th {
                padding: 14px 20px;
                font-size: 9px;
                font-weight: 700;
                letter-spacing: 2.5px;
                color: var(--gold);
                text-transform: uppercase;
                text-align: left;
            }

            tbody tr {
                border-bottom: 1px solid rgba(255,255,255,0.04);
            }

            td {
                padding: 16px 20px;
                font-size: 13px;
                vertical-align: middle;
            }

            .td-id {
                font-family: 'Cinzel', serif;
                color: var(--gold);
                font-weight: 600;
            }
            .td-book {
                font-weight: 600;
            }
            .td-date {
                color: var(--white-dim);
                font-size: 12px;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 4px 12px;
                border-radius: 50px;
                font-size: 10px;
                font-weight: 700;
            }

            .status-active-red {
                background: rgba(231, 76, 60, 0.1);
                border: 1px solid rgba(231, 76, 60, 0.25);
                color: var(--danger);
            }

            .status-returned-green {
                background: rgba(46, 204, 113, 0.1);
                border: 1px solid rgba(46, 204, 113, 0.25);
                color: var(--success);
            }

            .btn-browse {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                color: #000;
                text-decoration: none;
                border-radius: 10px;
                padding: 12px 24px;
                font-size: 12px;
                font-weight: 700;
                font-family: 'Cinzel', serif;
            }

            .btn-action {
                width: 34px;
                height: 34px;
                border-radius: 8px;
                border: 1px solid;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                background: transparent;
            }

            .btn-return {
                border-color: rgba(46,204,113,0.3);
                color: var(--success);
            }

            .empty-state {
                text-align: center;
                padding: 80px 20px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp" />

        <div class="page-header">
            <h1><i class="fa-solid fa-bookmark" style="color:var(--gold);margin-right:12px;"></i>Mis Préstamos</h1>
            <p>Historial y estado de tus solicitudes de material bibliográfico</p>
        </div>

        <div class="main-content">
            <%
                int total = (prestamos != null) ? prestamos.size() : 0;
                int activos = 0;
                if (prestamos != null) {
                    for (Prestamo p : prestamos) {
                        if (!"DEVUELTO".equalsIgnoreCase(p.getEstado())) {
                            activos++;
                        }
                    }
                }
            %>

            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-book-bookmark"></i></div>
                    <div>
                        <div class="stat-label">Total Préstamos</div>
                        <div class="stat-value"><%= total%></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <div>
                        <div class="stat-label">Activos</div>
                        <div class="stat-value"><%= activos%></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
                    <div>
                        <div class="stat-label">Estado</div>
                        <div class="stat-value" style="font-size:14px;"><%= total > 0 ? "Al día" : "Sin préstamos"%></div>
                    </div>
                </div>
            </div>

            <div class="table-card">
                <div class="table-card-header">
                    <h3><i class="fa-solid fa-list-check" style="color:var(--gold);margin-right:8px;"></i>Historial de Solicitudes</h3>
                </div>

                <% if (prestamos != null && !prestamos.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Libro</th>
                            <th>Usuario</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Prestamo p : prestamos) {
                                boolean esDevuelto = "DEVUELTO".equalsIgnoreCase(p.getEstado());
                        %>
                        <tr>
                            <td class="td-id"># Prestamo <%= p.getIdPrestamo()%></td>
                            <td class="td-book"><%= p.getTituloLibro()%></td>
                            <td class="td-book"><%= p.getNombreUsuario()%></td>
                            <td class="td-date"><%= p.getFechaPrestamo()%></td>
                            <td>
                                <span class="status-badge <%= esDevuelto ? "status-returned-green" : "status-active-red"%>">
                                    <i class="fa-solid fa-circle" style="font-size:6px;"></i> <%= p.getEstado()%>
                                </span>
                            </td>
                            <td>
                                <% if (!esDevuelto) {%>
                                <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=devolver&id=<%= p.getIdPrestamo()%>"
                                   class="btn-action btn-return" 
                                   onclick="confirmarDevolucion(event, this.href)">
                                    <i class="fa-solid fa-check-double"></i>
                                </a>
                                <% } else { %>
                                <span style="color: var(--white-dim); font-style: italic;">Entregado</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <div class="empty-state">
                    <h3>Sin solicitudes registradas</h3>
                    <a href="<%=request.getContextPath()%>/LibroServlet?accion=listar" class="btn-browse">Explorar Catálogo</a>
                </div>
                <% }%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                           function confirmarDevolucion(event, url) {
                                               event.preventDefault();
                                               Swal.fire({
                                                   title: '¿Marcar como entregado?',
                                                   text: "El libro pasará a estado DEVUELTO.",
                                                   icon: 'question',
                                                   background: '#111',
                                                   color: '#F5F0E8',
                                                   showCancelButton: true,
                                                   confirmButtonColor: '#2ecc71',
                                                   cancelButtonColor: '#8A8070',
                                                   confirmButtonText: 'Sí, confirmar',
                                                   cancelButtonText: 'Cancelar'
                                               }).then((result) => {
                                                   if (result.isConfirmed)
                                                       window.location.href = url;
                                               });
                                           }
        </script>
    </body>
</html>
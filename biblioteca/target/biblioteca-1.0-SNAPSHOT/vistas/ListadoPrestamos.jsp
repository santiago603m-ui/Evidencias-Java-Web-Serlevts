<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>

<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mis Préstamos — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
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
                --mora: #ff4444;
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
            .table-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 20px;
                padding: 24px;
            }
            .dataTables_wrapper {
                font-family: 'Raleway', sans-serif;
                color: var(--white);
            }
            table.dataTable {
                border-collapse: collapse !important;
                border: none !important;
                margin-bottom: 20px !important;
            }
            table.dataTable thead th {
                background: rgba(201,168,76,0.06) !important;
                color: var(--gold) !important;
                font-family: 'Cinzel', serif;
                font-size: 10px !important;
                letter-spacing: 1.5px;
                text-transform: uppercase;
                border-bottom: 1px solid var(--border) !important;
                padding: 15px !important;
            }
            table.dataTable tbody tr {
                background-color: transparent !important;
            }
            table.dataTable tbody td {
                padding: 16px !important;
                font-size: 13px;
                color: var(--white);
                border-bottom: 1px solid rgba(255,255,255,0.05) !important;
            }
            .dataTables_filter input {
                background: var(--black) !important;
                border: 1px solid var(--border) !important;
                color: var(--white) !important;
                border-radius: 8px;
                padding: 6px 12px;
                margin-left: 10px;
            }
            .dataTables_info, .dataTables_length {
                color: var(--white-dim) !important;
                font-size: 12px;
            }
            .dataTables_paginate .paginate_button {
                color: var(--white-dim) !important;
            }
            .dataTables_paginate .paginate_button.current {
                background: var(--gold) !important;
                color: #000 !important;
                border: none !important;
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
            .status-active {
                background: rgba(201,168,76,0.1);
                border: 1px solid var(--border);
                color: var(--gold);
            }
            .status-returned {
                background: rgba(46,204,113,0.1);
                border: 1px solid rgba(46,204,113,0.25);
                color: var(--success);
            }
            .status-mora {
                background: rgba(231,76,60,0.1);
                border: 1px solid rgba(231,76,60,0.25);
                color: var(--mora);
            }
            .td-id {
                font-family: 'Cinzel', serif;
                color: var(--gold);
                font-weight: 600;
            }
            .multa-valor {
                color: var(--mora);
                font-weight: 700;
                display: block;
                font-size: 12px;
                margin-top: 4px;
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
            }
            .btn-return {
                border-color: rgba(46,204,113,0.3);
                color: var(--success);
            }
        </style>
    </head>
    <body>
        <jsp:include page="../navbar.jsp" />
        <div class="page-header">
            <h1><i class="fa-solid fa-clock-rotate-left" style="color:var(--gold);margin-right:12px;"></i>Mis Préstamos</h1>
            <p>Gestión de deudas y fechas de entrega de la Sinfónica de Nobsa</p>
        </div>
        <div class="main-content">
            <div class="table-card">
                <table id="tablaPrestamos" class="display">
                    <thead>
                        <tr>
                            <th># ID</th>
                            <th>Material</th>
                            <th>Usuario</th>
                            <th>F. Préstamo</th>
                            <th>F. Límite</th>
                            <th>F. Entrega</th>
                            <th>Estado / Multa</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${prestamos}">
                            <tr>
                                <td class="td-id">#${p.idPrestamo}</td>
                                <td style="font-weight:600;">${p.tituloLibro}</td>
                                <td>${p.nombreUsuario}</td>
                                <td style="color:var(--white-dim);">${p.fechaPrestamo}</td>
                                <td style="color:var(--gold-light);">${p.fechaDevolucionEsperada}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.fechaDevolucion}">
                                            <span style="color:var(--success);"><i class="fa-solid fa-check"></i> ${p.fechaDevolucion}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:var(--white-dim); font-style:italic; font-size:11px;">Pendiente</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:set var="claseBadge" value="${p.estado == 'DEVUELTO' ? 'status-returned' : (p.estado == 'MORA' ? 'status-mora' : 'status-active')}" />
                                    <span class="status-badge ${claseBadge}">
                                        <i class="fa-solid fa-circle" style="font-size:5px;"></i> ${p.estado}
                                    </span>
                                    <c:if test="${p.multa > 0}">
                                        <span class="multa-valor">
                                            <fmt:formatNumber value="${p.multa}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                        </span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${p.estado != 'DEVUELTO'}">
                                        <a href="${pageContext.request.contextPath}/PrestamoServlet?accion=devolver&id=${p.idPrestamo}"
                                           class="btn-action btn-return" 
                                           onclick="confirmarDevolucion(event, this.href)">
                                            <i class="fa-solid fa-arrow-rotate-left"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${p.estado == 'DEVUELTO'}">
                                        <i class="fa-solid fa-circle-check" style="color:var(--white-dim); opacity:0.3;"></i>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                               $(document).ready(function () {
                                                   $('#tablaPrestamos').DataTable({
                                                       language: {url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'},
                                                       pageLength: 10,
                                                       order: [[0, 'desc']],
                                                       responsive: true,
                                                       dom: '<"top"f>rt<"bottom"lip><"clear">'
                                                   });
                                               });
                                               function confirmarDevolucion(event, url) {
                                                   event.preventDefault();
                                                   Swal.fire({
                                                       title: '¿Confirmar entrega?',
                                                       text: "Se registrará la devolución en el sistema.",
                                                       icon: 'question',
                                                       background: '#111',
                                                       color: '#F5F0E8',
                                                       showCancelButton: true,
                                                       confirmButtonColor: '#C9A84C',
                                                       cancelButtonColor: '#444',
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
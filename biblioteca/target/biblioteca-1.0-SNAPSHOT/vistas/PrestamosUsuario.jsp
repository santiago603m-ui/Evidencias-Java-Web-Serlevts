<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.biblioteca.biblioteca.modelo.Prestamo"%>

<%
    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mis Préstamos</title>

        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Raleway', sans-serif;
                background: #080808;
                color: #F5F0E8;
                padding: 40px;
            }

            .title {
                font-family: 'Cinzel', serif;
                font-size: 28px;
                margin-bottom: 30px;
                color: #C9A84C;
                text-align: center;
            }

            .grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                gap: 25px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .card {
                background: rgba(20, 20, 20, 0.9);
                border: 1px solid rgba(201,168,76,0.15);
                border-radius: 16px;
                padding: 25px;
                transition: transform 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .card:hover {
                transform: translateY(-5px);
                border-color: rgba(201,168,76,0.4);
            }

            .card-header {
                border-bottom: 1px solid rgba(255,255,255,0.05);
                margin-bottom: 15px;
                padding-bottom: 10px;
            }

            .libro-titulo {
                font-family: 'Cinzel', serif;
                color: #C9A84C;
                font-size: 18px;
                display: block;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 14px;
            }

            .label { color: #888; }
            .value { font-weight: 500; }

            .multa-box {
                margin-top: 15px;
                padding: 10px;
                background: rgba(255, 50, 50, 0.1);
                border-radius: 8px;
                border: 1px solid rgba(255, 50, 50, 0.2);
                color: #ff6b6b;
                text-align: center;
                font-weight: 700;
            }

            .estado {
                display: inline-block;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 10px;
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
                margin-top: 10px;
            }

            .activo { background: rgba(201,168,76,0.2); color: #C9A84C; }
            .devuelto { background: rgba(0,255,150,0.15); color: #00ff99; }
            .mora { background: rgba(255,50,50,0.2); color: #ff4444; border: 1px solid #ff4444; }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp"/>

        <h2 class="title">Mis Préstamos</h2>

        <div class="grid">
            <% if (prestamos != null) {
                for (Prestamo p : prestamos) { %>

            <div class="card">
                <div class="card-header">
                    <span class="libro-titulo"><i class="fa-solid fa-book"></i> <%= p.getTituloLibro() %></span>
                </div>

                <div class="info-row">
                    <span class="label">Fecha Préstamo:</span>
                    <span class="value"><%= p.getFechaPrestamo() %></span>
                </div>

                <div class="info-row">
                    <span class="label">Fecha Límite:</span>
                    <span class="value" style="color: #E8C97A;"><%= p.getFechaDevolucionEsperada() %></span>
                </div>

                <div class="info-row">
                    <span class="label">Devuelto el:</span>
                    <span class="value"><%= (p.getFechaDevolucion() != null) ? p.getFechaDevolucion() : "Pendiente" %></span>
                </div>

                <%
                    String claseEstado = "activo";
                    if ("DEVUELTO".equals(p.getEstado())) claseEstado = "devuelto";
                    else if ("MORA".equals(p.getEstado())) claseEstado = "mora";
                %>

                <span class="estado <%= claseEstado %>">
                    <i class="fa-solid fa-circle" style="font-size: 6px; vertical-align: middle; margin-right: 5px;"></i>
                    <%= p.getEstado() %>
                </span>

                <% if (p.getMulta() > 0) { %>
                <div class="multa-box">
                    <i class="fa-solid fa-sack-dollar"></i> Multa: $<%= String.format("%,.0f", p.getMulta()) %>
                </div>
                <% } %>
            </div>

            <% }
            } else { %>
                <p style="text-align: center; grid-column: 1/-1;">No tienes préstamos registrados.</p>
            <% } %>
        </div>

    </body>
</html>
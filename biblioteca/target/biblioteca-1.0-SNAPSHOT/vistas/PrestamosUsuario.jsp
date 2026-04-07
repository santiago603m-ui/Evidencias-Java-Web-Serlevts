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
            }

            .grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }

            .card {
                background: #111;
                border: 1px solid rgba(201,168,76,0.2);
                border-radius: 16px;
                padding: 20px;
            }

            .estado {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 11px;
            }

            .activo {
                background: rgba(201,168,76,0.2);
                color: #C9A84C;
            }

            .devuelto {
                background: rgba(0,255,150,0.2);
                color: #00ff99;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp"/>

        <h2 class="title">Mis Préstamos</h2>

        <div class="grid">
            <% if (prestamos != null) {
        for (Prestamo p : prestamos) {%>

            <div class="card">
                <p><b>ID:</b> <%= p.getIdPrestamo()%></p>
                <p><b>Libro:</b> <%= p.getIdLibro()%></p>
                <p><b>Libro:</b> <%= p.getIdUsuario()%></p>
                <p><b>Fecha:</b> <%= p.getFechaPrestamo()%></p>
                <p><b>Devolución:</b> <%= p.getFechaDevolucion()%></p>

                <span class="estado <%= p.getEstado().equals("ACTIVO") ? "activo" : "devuelto"%>">
                    <%= p.getEstado()%>
                </span>
            </div>

            <%  }
    }%>
        </div>

    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.biblioteca.biblioteca.modelo.Libro"%>

<%
    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nuevo Préstamo</title>

        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Raleway', sans-serif;
                background: #080808;
                color: #F5F0E8;
                padding: 40px;
            }

            .container {
                max-width: 500px;
                margin: auto;
                background: #111;
                padding: 30px;
                border-radius: 20px;
                border: 1px solid rgba(201,168,76,0.2);
            }

            .title {
                font-family: 'Cinzel', serif;
                color: #C9A84C;
                margin-bottom: 20px;
            }

            select, button {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border-radius: 8px;
                border: none;
            }

            select {
                background: #000;
                color: white;
            }

            button {
                background: #C9A84C;
                color: black;
                font-weight: bold;
                cursor: pointer;
            }

            button:hover {
                background: #E8C97A;
            }

            .error {
                color: red;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp"/>

        <div class="container">
            <h2 class="title">Nuevo Préstamo</h2>

            <% if (request.getAttribute("error") != null) {%>
            <div class="error"><%= request.getAttribute("error")%></div>
            <% }%>

            <form action="<%=request.getContextPath()%>/PrestamoServlet" method="post">
                <input type="hidden" name="accion" value="guardar">

                <label>Seleccionar Libro:</label>
                <select name="idLibro" required>
                    <% for (Libro l : libros) {%>
                    <option value="<%= l.getIdLibro()%>">
                        <%= l.getTitulo()%> (Disponibles: <%= l.getDisponibles()%>)
                    </option>
                    <% }%>
                </select>

                <button type="submit">Registrar Préstamo</button>
            </form>
        </div>

    </body>
</html>
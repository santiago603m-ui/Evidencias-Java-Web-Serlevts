<%@page import="java.util.List"%>
<%@page import="com.biblioteca.biblioteca.modelo.Libro"%>
<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    boolean isAdmin = "ADMIN".equals(user.getRol());
    List<Libro> lista = (List<Libro>) request.getAttribute("libros");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Catálogo — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                --border-hover: rgba(201,168,76,0.4);
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
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 16px;
            }

            .page-title-area h1 {
                font-family: 'Cinzel', serif;
                font-size: 26px;
                font-weight: 700;
                color: var(--white);
                margin-bottom: 4px;
            }

            .page-title-area p {
                font-size: 12px;
                color: var(--white-dim);
                letter-spacing: 0.5px;
            }

            .btn-nuevo {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                color: #000;
                text-decoration: none;
                border-radius: 10px;
                padding: 11px 22px;
                font-size: 12px;
                font-weight: 700;
                font-family: 'Cinzel', serif;
                letter-spacing: 1px;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
            }

            .btn-nuevo:hover {
                background: linear-gradient(135deg, var(--gold-light), var(--gold));
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(201,168,76,0.3);
            }

            .search-bar {
                padding: 20px 60px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .search-input-wrap {
                position: relative;
                flex: 1;
                max-width: 400px;
            }

            .search-input-wrap i {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--white-dim);
                font-size: 13px;
            }

            .search-input {
                width: 100%;
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 11px 14px 11px 40px;
                color: var(--white);
                font-family: 'Raleway', sans-serif;
                font-size: 13px;
                outline: none;
                transition: border-color 0.2s;
            }

            .search-input:focus {
                border-color: var(--gold);
            }
            .search-input::placeholder {
                color: var(--white-dim);
            }

            .result-count {
                font-size: 11px;
                color: var(--white-dim);
                padding: 0 60px 10px;
                letter-spacing: 0.5px;
            }

            .result-count span {
                color: var(--gold);
                font-weight: 700;
            }

            .catalog-container {
                padding: 0 60px 60px;
            }

            .catalog-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 24px;
            }

            .book-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 20px;
                padding: 24px;
                display: flex;
                flex-direction: column;
                transition: all 0.3s ease;
                animation: card-in 0.5s ease both;
            }

            .book-card:nth-child(1) { animation-delay: 0.05s; }
            .book-card:nth-child(2) { animation-delay: 0.10s; }
            .book-card:nth-child(3) { animation-delay: 0.15s; }
            .book-card:nth-child(4) { animation-delay: 0.20s; }
            .book-card:nth-child(5) { animation-delay: 0.25s; }
            .book-card:nth-child(6) { animation-delay: 0.30s; }

            @keyframes card-in {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .book-card:hover {
                border-color: var(--border-hover);
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(201,168,76,0.08);
            }

            .book-cover-placeholder {
                height: 160px;
                background: rgba(201,168,76,0.03);
                border: 1px solid rgba(201,168,76,0.1);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                color: var(--gold);
                font-size: 45px;
                opacity: 0.7;
                transition: all 0.3s;
            }

            .book-card:hover .book-cover-placeholder {
                background: rgba(201,168,76,0.08);
                color: var(--gold-light);
                opacity: 1;
            }

            .book-id {
                font-family: 'Cinzel', serif;
                color: var(--gold);
                font-size: 11px;
                font-weight: 700;
                margin-bottom: 8px;
                letter-spacing: 1px;
            }

            .book-title {
                font-size: 16px;
                font-weight: 600;
                color: var(--white);
                margin-bottom: 6px;
                line-height: 1.4;
            }

            .book-author {
                color: var(--white-dim);
                font-size: 12px;
                margin-bottom: 16px;
                flex-grow: 1; 
            }

            .book-stock {
                margin-bottom: 20px;
            }

            .stock-badge {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 4px 12px;
                border-radius: 50px;
                font-size: 11px;
                font-weight: 600;
            }

            .stock-ok {
                background: rgba(46,204,113,0.1);
                border: 1px solid rgba(46,204,113,0.25);
                color: var(--success);
            }

            .stock-low {
                background: rgba(231,76,60,0.1);
                border: 1px solid rgba(231,76,60,0.25);
                color: var(--danger);
            }

            .book-actions {
                display: flex;
                align-items: center;
                gap: 10px;
                padding-top: 16px;
                border-top: 1px solid rgba(255,255,255,0.05);
            }

            .btn-action {
                flex: 1; 
                height: 38px;
                border-radius: 10px;
                border: 1px solid;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                font-size: 12px;
                font-weight: 600;
                text-decoration: none;
                cursor: pointer;
                transition: all 0.2s;
                background: transparent;
            }

            .btn-edit {
                border-color: rgba(201,168,76,0.3);
                color: var(--gold);
            }

            .btn-edit:hover {
                background: rgba(201,168,76,0.15);
                border-color: var(--gold);
            }

            .btn-delete {
                border-color: rgba(231,76,60,0.3);
                color: var(--danger);
            }

            .btn-delete:hover {
                background: rgba(231,76,60,0.15);
                border-color: var(--danger);
            }

            .btn-solicitar {
                flex: 1; 
                display: inline-flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                padding: 10px 16px;
                background: rgba(201,168,76,0.08);
                border: 1px solid rgba(201,168,76,0.25);
                border-radius: 10px;
                color: var(--gold);
                font-size: 12px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.2s;
                cursor: pointer;
            }

            .btn-solicitar:hover {
                background: rgba(201,168,76,0.18);
                border-color: var(--gold);
            }

            .empty-state {
                grid-column: 1 / -1;
                text-align: center;
                padding: 80px 20px;
                background: var(--black-card);
                border: 1px dashed var(--border);
                border-radius: 20px;
            }

            .empty-state i {
                font-size: 50px;
                color: var(--white-dim);
                opacity: 0.3;
                margin-bottom: 20px;
                display: block;
            }

            .empty-state h3 {
                font-family: 'Cinzel', serif;
                font-size: 16px;
                color: var(--white-dim);
                margin-bottom: 8px;
            }

            .empty-state p {
                font-size: 12px;
                color: var(--white-dim);
                opacity: 0.6;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp" />

        <div class="page-header">
            <div class="page-title-area">
                <h1><i class="fa-solid fa-book-open" style="color:var(--gold);margin-right:12px;font-size:22px;"></i>Colección Académica</h1>
                <p>Catálogo de material bibliográfico disponible en la institución</p>
            </div>
            <% if (isAdmin) {%>
            <a href="<%=request.getContextPath()%>/LibroServlet?accion=nuevo" class="btn-nuevo">
                <i class="fa-solid fa-plus"></i> Nuevo Libro
            </a>
            <% }%>
        </div>

        <div class="search-bar">
            <div class="search-input-wrap">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" class="search-input" placeholder="Buscar por título o autor..." id="searchInput">
            </div>
        </div>

        <div class="result-count">
            Total: <span id="countDisplay"><%= (lista != null ? lista.size() : 0)%></span> libros encontrados
        </div>

        <div class="catalog-container">
            <div class="catalog-grid" id="libroGrid">
                <%
                    if (lista != null && !lista.isEmpty()) {
                        for (Libro l : lista) {
                %>
                <div class="book-card">
                    <div class="book-cover-placeholder">
                        <i class="fa-solid fa-book-bookmark"></i>
                    </div>
                    
                    <div class="book-id">#<%= l.getIdLibro()%></div>
                    <h3 class="book-title"><%= l.getTitulo()%></h3>
                    <p class="book-author"><i class="fa-solid fa-pen-nib" style="margin-right: 5px; opacity: 0.7;"></i><%= l.getAutor()%></p>
                    
                    <div class="book-stock">
                        <span class="stock-badge <%= l.getDisponibles() > 0 ? "stock-ok" : "stock-low"%>">
                            <i class="fa-solid fa-circle" style="font-size:6px;"></i>
                            <%= l.getDisponibles()%> unid.
                        </span>
                    </div>

                    <div class="book-actions">
                        <% if (isAdmin) {%>
                        <a href="<%=request.getContextPath()%>/LibroServlet?accion=editar&id=<%= l.getIdLibro()%>"
                           class="btn-action btn-edit" title="Editar">
                            <i class="fa-solid fa-pen"></i> Editar
                        </a>
                        <a href="<%=request.getContextPath()%>/LibroServlet?accion=eliminar&id=<%= l.getIdLibro()%>"
                           class="btn-action btn-delete" 
                           title="Eliminar"
                           onclick="confirmarEliminacion(event, this.href)">
                            <i class="fa-solid fa-trash"></i> Borrar
                        </a>
                        <% } else {%>
                        <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=nuevo&idLibro=<%= l.getIdLibro()%>"
                           class="btn-solicitar">
                            <i class="fa-solid fa-hand-holding-hand"></i> Solicitar Préstamo
                        </a>
                        <% } %>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="empty-state">
                    <i class="fa-solid fa-book-open"></i>
                    <h3>Sin registros en el catálogo</h3>
                    <p>No hay libros disponibles en este momento.</p>
                </div>
                <% }%>
            </div>
        </div>

        <script>
            document.getElementById('searchInput').addEventListener('input', function () {
                const term = this.value.toLowerCase();
                const cards = document.querySelectorAll('.book-card');
                let count = 0;

                cards.forEach(card => {
                    const title = card.querySelector('.book-title')?.textContent.toLowerCase() || "";
                    const author = card.querySelector('.book-author')?.textContent.toLowerCase() || "";

                    if (title.includes(term) || author.includes(term)) {
                        card.style.display = 'flex'; 
                        count++;
                    } else {
                        card.style.display = 'none';
                    }
                });
                document.getElementById('countDisplay').textContent = count;
            });

            function confirmarEliminacion(event, url) {
                event.preventDefault();

                Swal.fire({
                    title: '¿Eliminar este libro?',
                    text: "Se borrará permanentemente de la base de datos.",
                    icon: 'warning',
                    background: '#111', 
                    color: '#F5F0E8',
                    showCancelButton: true,
                    confirmButtonColor: '#e74c3c',
                    cancelButtonColor: '#8A8070',
                    confirmButtonText: '<i class="fa-solid fa-trash"></i> Sí, eliminar',
                    cancelButtonText: 'Cancelar',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                    }
                });
            }
        </script>

    </body>
</html>
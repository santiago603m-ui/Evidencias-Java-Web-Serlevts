<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRol())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nuevo Libro — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --gold: #C9A84C;
                --gold-light: #E8C97A;
                --gold-dark: #8B6914;
                --black: #080808;
                --black-card: #111111;
                --black-input: #0d0d0d;
                --white: #F5F0E8;
                --white-dim: #8A8070;
                --border: rgba(201,168,76,0.15);
                --border-focus: rgba(201,168,76,0.5);
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

            .page-container {
                display: flex;
                align-items: flex-start;
                justify-content: center;
                padding: 50px 20px 80px;
                min-height: calc(100vh - 70px);
            }

            .form-wrapper {
                width: 100%;
                max-width: 580px;
                animation: form-in 0.6s cubic-bezier(0.16,1,0.3,1) both;
            }

            @keyframes form-in {
                from {
                    opacity: 0;
                    transform: translateY(25px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .breadcrumb {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 28px;
                font-size: 11px;
                color: var(--white-dim);
            }

            .breadcrumb a {
                color: var(--white-dim);
                text-decoration: none;
                transition: color 0.2s;
            }

            .breadcrumb a:hover {
                color: var(--gold);
            }
            .breadcrumb i {
                font-size: 9px;
                color: var(--border);
            }
            .breadcrumb span {
                color: var(--gold);
            }

            /* Form card */
            .form-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 24px;
                overflow: hidden;
            }

            .form-card-header {
                padding: 36px 40px 28px;
                border-bottom: 1px solid var(--border);
                background: linear-gradient(135deg, rgba(201,168,76,0.06) 0%, transparent 60%);
                position: relative;
            }

            .form-card-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, var(--gold), var(--gold-dark), transparent);
            }

            .header-icon {
                width: 52px;
                height: 52px;
                background: rgba(201,168,76,0.1);
                border: 1px solid rgba(201,168,76,0.25);
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--gold);
                font-size: 20px;
                margin-bottom: 18px;
            }

            .form-card-header h2 {
                font-family: 'Cinzel', serif;
                font-size: 20px;
                font-weight: 700;
                color: var(--white);
                margin-bottom: 6px;
            }

            .form-card-header p {
                font-size: 12px;
                color: var(--white-dim);
            }

            .form-body {
                padding: 36px 40px 40px;
            }

            .form-group {
                margin-bottom: 24px;
                animation: field-in 0.4s ease both;
            }

            .form-group:nth-child(1) {
                animation-delay: 0.1s;
            }
            .form-group:nth-child(2) {
                animation-delay: 0.2s;
            }
            .form-group:nth-child(3) {
                animation-delay: 0.3s;
            }

            @keyframes field-in {
                from {
                    opacity: 0;
                    transform: translateY(8px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .form-label {
                display: flex;
                align-items: center;
                gap: 7px;
                font-size: 10px;
                font-weight: 700;
                letter-spacing: 2px;
                color: var(--white-dim);
                text-transform: uppercase;
                margin-bottom: 10px;
            }

            .form-label i {
                color: var(--gold);
                font-size: 11px;
            }

            .form-input {
                width: 100%;
                background: var(--black-input);
                border: 1px solid rgba(255,255,255,0.07);
                border-radius: 12px;
                padding: 14px 16px;
                color: var(--white);
                font-family: 'Raleway', sans-serif;
                font-size: 13px;
                outline: none;
                transition: all 0.25s;
            }

            .form-input:focus {
                border-color: var(--gold);
                background: rgba(201,168,76,0.03);
                box-shadow: 0 0 0 3px rgba(201,168,76,0.07);
            }

            .form-input::placeholder {
                color: rgba(255,255,255,0.18);
            }

            .input-hint {
                font-size: 10px;
                color: var(--white-dim);
                margin-top: 6px;
                letter-spacing: 0.3px;
            }

            /* Number input styling */
            .stock-control {
                display: flex;
                align-items: center;
                gap: 0;
                background: var(--black-input);
                border: 1px solid rgba(255,255,255,0.07);
                border-radius: 12px;
                overflow: hidden;
                transition: border-color 0.25s;
            }

            .stock-control:focus-within {
                border-color: var(--gold);
                box-shadow: 0 0 0 3px rgba(201,168,76,0.07);
            }

            .stock-btn {
                width: 44px;
                background: rgba(201,168,76,0.08);
                border: none;
                color: var(--gold);
                font-size: 16px;
                cursor: pointer;
                padding: 14px 0;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s;
                flex-shrink: 0;
            }

            .stock-btn:hover {
                background: rgba(201,168,76,0.15);
            }

            .stock-input {
                flex: 1;
                background: transparent;
                border: none;
                outline: none;
                color: var(--white);
                font-family: 'Cinzel', serif;
                font-size: 18px;
                font-weight: 700;
                text-align: center;
                padding: 14px 0;
            }

            /* Actions */
            .form-actions {
                display: flex;
                gap: 12px;
                padding-top: 8px;
                animation: field-in 0.4s ease 0.4s both;
            }

            .btn-submit {
                flex: 1;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                color: #000;
                border: none;
                border-radius: 12px;
                padding: 15px;
                font-family: 'Cinzel', serif;
                font-size: 12px;
                font-weight: 700;
                letter-spacing: 2px;
                cursor: pointer;
                transition: all 0.3s;
                position: relative;
                overflow: hidden;
            }

            .btn-submit::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, var(--gold-light), var(--gold));
                opacity: 0;
                transition: opacity 0.3s;
            }

            .btn-submit:hover::before {
                opacity: 1;
            }
            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(201,168,76,0.3);
            }

            .btn-submit span {
                position: relative;
                z-index: 1;
            }

            .btn-cancel {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                padding: 15px 24px;
                background: transparent;
                border: 1px solid rgba(255,255,255,0.1);
                border-radius: 12px;
                color: var(--white-dim);
                font-size: 12px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.2s;
                cursor: pointer;
                font-family: 'Raleway', sans-serif;
            }

            .btn-cancel:hover {
                border-color: rgba(255,255,255,0.2);
                color: var(--white);
                background: rgba(255,255,255,0.04);
            }
        </style>
    </head>
    <body>

        <jsp:include page="../navbar.jsp" />

        <div class="page-container">
            <div class="form-wrapper">

                <div class="breadcrumb">
                    <a href="<%=request.getContextPath()%>/dashboard.jsp"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    <i class="fa-solid fa-chevron-right"></i>
                    <a href="<%=request.getContextPath()%>/LibroServlet?accion=listar">Catálogo</a>
                    <i class="fa-solid fa-chevron-right"></i>
                    <span>Nuevo Libro</span>
                </div>

                <div class="form-card">
                    <div class="form-card-header">
                        <div class="header-icon">
                            <i class="fa-solid fa-folder-plus"></i>
                        </div>
                        <h2>Registrar Nuevo Libro</h2>
                        <p>Completa los datos para agregar material al inventario bibliográfico.</p>
                    </div>

                    <div class="form-body">
                        <form action="<%=request.getContextPath()%>/LibroServlet" method="POST">
                            <input type="hidden" name="accion" value="guardar">

                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-solid fa-heading"></i> Título del Libro
                                </label>
                                <input type="text" name="txtTitulo" class="form-input"
                                       placeholder="Ej: Cálculo Integral — Thomas" required>
                                <div class="input-hint">Ingresa el nombre completo del libro o material académico.</div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-solid fa-user-pen"></i> Autor / Investigador
                                </label>
                                <input type="text" name="txtAutor" class="form-input"
                                       placeholder="Ej: George B. Thomas" required>
                                <div class="input-hint">Nombre del autor principal o editorial responsable.</div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-solid fa-layer-group"></i> Stock Inicial
                                </label>
                                <div class="stock-control">
                                    <button type="button" class="stock-btn" onclick="adjustStock(-1)">−</button>
                                    <input type="number" name="txtStock" id="stockInput"
                                           class="stock-input" value="1" min="1" required>
                                    <button type="button" class="stock-btn" onclick="adjustStock(1)">+</button>
                                </div>
                                <div class="input-hint">Número de ejemplares físicos disponibles para préstamo.</div>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn-submit">
                                    <span><i class="fa-solid fa-floppy-disk"></i>&nbsp;&nbsp;GUARDAR EN SISTEMA</span>
                                </button>
                                <a href="<%=request.getContextPath()%>/LibroServlet?accion=listar" class="btn-cancel">
                                    <i class="fa-solid fa-xmark"></i> Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>

        <script>
            function adjustStock(delta) {
                const input = document.getElementById('stockInput');
                const current = parseInt(input.value) || 1;
                const next = Math.max(1, current + delta);
                input.value = next;
            }
        </script>

    </body>
</html>

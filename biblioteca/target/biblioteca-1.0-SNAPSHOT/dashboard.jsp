<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    boolean isAdmin = "ADMIN".equals(user.getRol());
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --gold: #C9A84C;
                --gold-light: #E8C97A;
                --gold-dark: #8B6914;
                --gold-glow: rgba(201,168,76,0.2);
                --black: #080808;
                --black-card: #111111;
                --black-hover: #181818;
                --white: #F5F0E8;
                --white-dim: #8A8070;
                --border: rgba(201,168,76,0.15);
                --border-hover: rgba(201,168,76,0.4);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Raleway', sans-serif;
                color: var(--white);
                min-height: 100vh;
            }

            .hero-banner {
                background: linear-gradient(135deg, #0d0a00 0%, #1c1400 50%, #0a0800 100%);
                border-bottom: 1px solid var(--border);
                padding: 50px 60px;
                position: relative;
                overflow: hidden;
            }

            .hero-banner::before {
                content: '';
                position: absolute;
                top: -100px;
                right: -100px;
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(201,168,76,0.12) 0%, transparent 60%);
                pointer-events: none;
            }

            .hero-banner::after {
                content: '\f02d';
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                position: absolute;
                right: 60px;
                bottom: -30px;
                font-size: 180px;
                color: rgba(201,168,76,0.06);
                line-height: 1;
            }

            .hero-label {
                font-size: 10px;
                font-weight: 600;
                letter-spacing: 4px;
                color: var(--gold);
                text-transform: uppercase;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .hero-label::before {
                content: '';
                display: inline-block;
                width: 20px;
                height: 1px;
                background: var(--gold);
            }

            .hero-name {
                font-family: 'Cinzel', serif;
                font-size: 42px;
                font-weight: 700;
                color: var(--white);
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }

            .hero-name span {
                color: var(--gold);
            }

            .hero-sub {
                font-size: 13px;
                color: var(--white-dim);
                max-width: 500px;
                line-height: 1.7;
                position: relative;
                z-index: 1;
            }

            .hero-meta {
                display: flex;
                gap: 24px;
                margin-top: 28px;
                position: relative;
                z-index: 1;
            }

            .hero-meta-item {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 11px;
                color: var(--white-dim);
                background: rgba(255,255,255,0.04);
                border: 1px solid var(--border);
                border-radius: 50px;
                padding: 6px 14px;
            }

            .hero-meta-item i {
                color: var(--gold);
            }

            .main-content {
                padding: 50px 60px;
            }

            .section-title {
                font-family: 'Cinzel', serif;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 3px;
                color: var(--white-dim);
                text-transform: uppercase;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .section-title::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .cards-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 20px;
                margin-bottom: 50px;
            }

            .action-card {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 20px;
                padding: 32px 28px;
                cursor: pointer;
                text-decoration: none;
                display: block;
                position: relative;
                overflow: hidden;
                transition: all 0.35s cubic-bezier(0.16,1,0.3,1);
                animation: card-in 0.5s ease both;
            }

            .action-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .action-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .action-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .action-card:nth-child(4) {
                animation-delay: 0.4s;
            }

            @keyframes card-in {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .action-card::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(201,168,76,0.05) 0%, transparent 60%);
                opacity: 0;
                transition: opacity 0.35s;
            }

            .action-card:hover {
                border-color: var(--border-hover);
                transform: translateY(-6px);
                box-shadow: 0 20px 40px rgba(0,0,0,0.5), 0 0 0 1px rgba(201,168,76,0.2);
            }

            .action-card:hover::before {
                opacity: 1;
            }

            .card-icon-wrap {
                width: 54px;
                height: 54px;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 22px;
                margin-bottom: 22px;
                position: relative;
                z-index: 1;
            }

            .icon-gold {
                background: rgba(201,168,76,0.12);
                border: 1px solid rgba(201,168,76,0.25);
                color: var(--gold);
            }

            .icon-white {
                background: rgba(245,240,232,0.06);
                border: 1px solid rgba(245,240,232,0.1);
                color: var(--white);
            }

            .card-title {
                font-family: 'Cinzel', serif;
                font-size: 15px;
                font-weight: 600;
                color: var(--white);
                margin-bottom: 8px;
                position: relative;
                z-index: 1;
            }

            .card-desc {
                font-size: 12px;
                color: var(--white-dim);
                line-height: 1.6;
                position: relative;
                z-index: 1;
            }

            .card-arrow {
                position: absolute;
                bottom: 28px;
                right: 28px;
                width: 32px;
                height: 32px;
                background: var(--border);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--gold);
                font-size: 12px;
                transition: all 0.3s;
            }

            .action-card:hover .card-arrow {
                background: var(--gold);
                color: #000;
            }

            .card-admin-badge {
                position: absolute;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                color: #000;
                font-size: 8px;
                font-weight: 700;
                letter-spacing: 1.5px;
                padding: 4px 10px;
                border-radius: 50px;
                text-transform: uppercase;
            }

            .stats-row {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
                margin-bottom: 50px;
            }

            .stat-box {
                background: var(--black-card);
                border: 1px solid var(--border);
                border-radius: 16px;
                padding: 24px;
                display: flex;
                align-items: center;
                gap: 16px;
                animation: card-in 0.5s ease both;
            }

            .stat-box:nth-child(1) {
                animation-delay: 0.5s;
            }
            .stat-box:nth-child(2) {
                animation-delay: 0.6s;
            }
            .stat-box:nth-child(3) {
                animation-delay: 0.7s;
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
                font-size: 16px;
                flex-shrink: 0;
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
                font-size: 20px;
                font-weight: 700;
                color: var(--gold);
            }
        </style>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />

        <div class="hero-banner">
            <div class="hero-label">Panel Principal</div>
            <h1 class="hero-name">Bienvenido, <span><%= user.getNombre()%></span></h1>
            <p class="hero-sub">
                Accede al sistema integrado de gestión bibliotecaria de la Universidad Regional de Boyacá.
                Consulta el catálogo, gestiona préstamos y administra el inventario académico.
            </p>
            <div class="hero-meta">
                <div class="hero-meta-item">
                    <i class="fa-solid fa-circle-check"></i> Sesión Activa
                </div>
                <div class="hero-meta-item">
                    <i class="fa-solid fa-id-badge"></i> Rol: <%= user.getRol()%>
                </div>
                <div class="hero-meta-item">
                    <i class="fa-solid fa-university"></i> Uniboyacá
                </div>
            </div>
        </div>

        <div class="main-content">

            <div class="section-title">Acciones Rápidas</div>

            <div class="cards-grid">
                <a href="<%=request.getContextPath()%>/LibroServlet?accion=listar" class="action-card">
                    <div class="card-icon-wrap icon-gold">
                        <i class="fa-solid fa-book-open"></i>
                    </div>
                    <div class="card-title">Explorar Catálogo</div>
                    <div class="card-desc">Consulta la disponibilidad de libros y material académico en tiempo real.</div>
                    <div class="card-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                </a>

                <% if (isAdmin) {%>
                <a href="<%=request.getContextPath()%>/LibroServlet?accion=nuevo" class="action-card">
                    <span class="card-admin-badge">Admin</span>
                    <div class="card-icon-wrap icon-gold">
                        <i class="fa-solid fa-plus-circle"></i>
                    </div>
                    <div class="card-title">Registrar Material</div>
                    <div class="card-desc">Añade nuevos títulos al inventario bibliográfico de la institución.</div>
                    <div class="card-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                </a>

                <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=listar" class="action-card">
                    <span class="card-admin-badge">Admin</span>
                    <div class="card-icon-wrap icon-white">
                        <i class="fa-solid fa-list-check"></i>
                    </div>
                    <div class="card-title">Gestión de Préstamos</div>
                    <div class="card-desc">Administra todos los préstamos activos, historial y devoluciones pendientes.</div>
                    <div class="card-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                </a>

                <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=nuevo" class="action-card">
                    <span class="card-admin-badge">Admin</span>
                    <div class="card-icon-wrap icon-white">
                        <i class="fa-solid fa-handshake"></i>
                    </div>
                    <div class="card-title">Nuevo Préstamo</div>
                    <div class="card-desc">Registra un nuevo préstamo para un estudiante desde el panel administrativo.</div>
                    <div class="card-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                </a>
                <% } else {%>
                <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=mis_prestamos" class="action-card">
                    <div class="card-icon-wrap icon-white">
                        <i class="fa-solid fa-clock-rotate-left"></i>
                    </div>
                    <div class="card-title">Mis Préstamos</div>
                    <div class="card-desc">Consulta el historial de tus solicitudes de préstamo y fechas de devolución.</div>
                    <div class="card-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                </a>
                <% }%>
            </div>

            <div class="section-title">Información del Sistema</div>

            <div class="stats-row">
                <div class="stat-box">
                    <div class="stat-icon"><i class="fa-solid fa-book"></i></div>
                    <div>
                        <div class="stat-label">Módulo Activo</div>
                        <div class="stat-value">Biblioteca</div>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon"><i class="fa-solid fa-server"></i></div>
                    <div>
                        <div class="stat-label">Servidor</div>
                        <div class="stat-value">Tomcat 8.5</div>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon"><i class="fa-solid fa-database"></i></div>
                    <div>
                        <div class="stat-label">Base de Datos</div>
                        <div class="stat-value">MySQL 8</div>
                    </div>
                </div>
            </div>

        </div>

    </body>
</html>

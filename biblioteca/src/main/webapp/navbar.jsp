<%@page import="com.biblioteca.biblioteca.modelo.Usuario"%>
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="bg-animated-overlay"></div>

<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Raleway:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    :root {
        --gold: #C9A84C;
        --gold-light: #E8C97A;
        --gold-dark: #8B6914;
        --black: #0A0A0A;
        --black-soft: #111111;
        --black-card: #161616;
        --white: #F5F0E8;
        --white-dim: #C8C0B0;
        --border: rgba(201,168,76,0.25);
    }

    /* Estilos del fondo animado */
    .bg-animated-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        background: radial-gradient(circle at 50% 50%, #121212 0%, #050505 100%);
        pointer-events: none; /* Importante: permite hacer clic a través del fondo */
    }

    .bg-animated-overlay::after {
        content: "";
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background-image:
            radial-gradient(2px 2px at 20px 30px, var(--gold-dark), rgba(0,0,0,0)),
            radial-gradient(2px 2px at 100px 150px, #fff, rgba(0,0,0,0)),
            radial-gradient(1.5px 1.5px at 50px 160px, var(--gold), rgba(0,0,0,0)),
            radial-gradient(2px 2px at 180px 40px, rgba(255,255,255,0.3), rgba(0,0,0,0));
        background-repeat: repeat;
        background-size: 250px 250px;
        opacity: 0.1;
        animation: rotateBg 180s linear infinite;
    }

    @keyframes rotateBg {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(360deg);
        }
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Raleway', sans-serif;
        background-color: var(--black);
        color: var(--white);
        min-height: 100vh;
    }

    .navbar-premium {
        background: linear-gradient(90deg, #000000 0%, #0d0d0d 50%, #000000 100%);
        border-bottom: 1px solid var(--border);
        padding: 0 2rem;
        height: 70px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 4px 30px rgba(0,0,0,0.8), 0 1px 0 rgba(201,168,76,0.3);
    }

    .nav-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .nav-brand-icon {
        width: 42px;
        height: 42px;
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        color: #000;
        box-shadow: 0 0 15px rgba(201,168,76,0.4);
    }

    .nav-brand-text {
        display: flex;
        flex-direction: column;
        line-height: 1;
    }

    .nav-brand-title {
        font-family: 'Cinzel', serif;
        font-size: 14px;
        font-weight: 700;
        color: var(--gold);
        letter-spacing: 2px;
    }

    .nav-brand-sub {
        font-size: 9px;
        color: var(--white-dim);
        letter-spacing: 3px;
        text-transform: uppercase;
        margin-top: 2px;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 4px;
        list-style: none;
    }

    .nav-links a {
        display: flex;
        align-items: center;
        gap: 7px;
        padding: 8px 16px;
        border-radius: 8px;
        text-decoration: none;
        color: var(--white-dim);
        font-size: 11px;
        font-weight: 500;
        letter-spacing: 0.5px;
        transition: all 0.25s ease;
        border: 1px solid transparent;
        text-transform: uppercase;
    }

    .nav-links a:hover {
        color: var(--gold);
        background: rgba(201,168,76,0.08);
        border-color: var(--border);
    }

    .nav-admin-badge {
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        color: #000 !important;
        font-weight: 700 !important;
    }

    .nav-user-area {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .nav-user-info {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 6px 14px;
        background: rgba(255,255,255,0.04);
        border: 1px solid var(--border);
        border-radius: 50px;
    }

    .nav-user-avatar {
        width: 30px;
        height: 30px;
        background: linear-gradient(135deg, var(--gold), var(--gold-dark));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        color: #000;
        font-weight: 700;
    }

    .nav-user-name {
        font-size: 12px;
        font-weight: 500;
        color: var(--white);
    }

    .nav-user-role {
        font-size: 9px;
        color: var(--gold);
        letter-spacing: 1px;
        text-transform: uppercase;
    }

    .nav-logout {
        width: 36px;
        height: 36px;
        background: rgba(255,50,50,0.1);
        border: 1px solid rgba(255,50,50,0.2);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ff6b6b;
        text-decoration: none;
        transition: all 0.25s;
    }

    .nav-logout:hover {
        background: rgba(255,50,50,0.2);
        transform: scale(1.05);
    }

    .navbar-premium::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 2px;
        background: linear-gradient(90deg, transparent, var(--gold), transparent);
    }
</style>

<nav class="navbar-premium">
    <a href="<%=request.getContextPath()%>/dashboard.jsp" class="nav-brand">
        <div class="nav-brand-icon">
            <i class="fa-solid fa-book-open"></i>
        </div>
        <div class="nav-brand-text">
            <span class="nav-brand-title">BIBLIOTECA</span>
            <span class="nav-brand-sub">Uniboyacá · Sistema</span>
        </div>
    </a>

    <ul class="nav-links">
        <li>
            <a href="<%=request.getContextPath()%>/dashboard.jsp">
                <i class="fa-solid fa-gauge-high"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/LibroServlet?accion=listar">
                <i class="fa-solid fa-book-open"></i> Catálogo
            </a>
        </li>
        <% if ("ADMIN".equals(user.getRol())) {%>
        <li>
            <a href="<%=request.getContextPath()%>/LibroServlet?accion=nuevo" class="nav-admin-badge">
                <i class="fa-solid fa-plus"></i> Nuevo Libro
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=listar">
                <i class="fa-solid fa-list-check"></i> Préstamos
            </a>
        </li>
        <% } else {%>
        <li>
            <a href="<%=request.getContextPath()%>/PrestamoServlet?accion=mis_prestamos">
                <i class="fa-solid fa-clock-rotate-left"></i> Mis Préstamos
            </a>
        </li>
        <% }%>
    </ul>

    <div class="nav-user-area">
        <div class="nav-user-info">
            <div class="nav-user-avatar">
                <%= user.getNombre().substring(0, 1).toUpperCase()%>
            </div>
            <div>
                <div class="nav-user-name"><%= user.getNombre()%></div>
                <div class="nav-user-role"><%= user.getRol()%></div>
            </div>
        </div>
        <a href="<%=request.getContextPath()%>/UsuarioServlet?accion=logout" class="nav-logout" title="Cerrar sesión">
            <i class="fa-solid fa-power-off"></i>
        </a>
    </div>

    <script src="https://cdn.botpress.cloud/webchat/v3.6/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2026/03/26/12/20260326122832-AGK4TU2F.js" defer></script>
</nav>
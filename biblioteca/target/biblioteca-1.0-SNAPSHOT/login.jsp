<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Acceso — Biblioteca Uniboyacá</title>
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700;900&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --gold: #C9A84C;
                --gold-light: #E8C97A;
                --gold-dark: #8B6914;
                --black: #050505;
                --black-card: #111111;
                --black-input: #0d0d0d;
                --white: #F5F0E8;
                --white-dim: #9A9080;
                --border: rgba(201,168,76,0.2);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Raleway', sans-serif;
                background: var(--black);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
                position: relative;
            }

            .bg-scene {
                position: fixed;
                inset: 0;
                z-index: 0;
            }
            .bg-grid {
                position: absolute;
                inset: 0;
                background-image: linear-gradient(rgba(201,168,76,0.04) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(201,168,76,0.04) 1px, transparent 1px);
                background-size: 60px 60px;
                animation: grid-drift 30s linear infinite;
            }
            @keyframes grid-drift {
                from {
                    transform: translateY(0);
                }
                to {
                    transform: translateY(60px);
                }
            }

            .login-wrapper {
                position: relative;
                z-index: 10;
                display: flex;
                width: 100%;
                max-width: 1000px;
                min-height: 580px;
                margin: 2rem;
                border-radius: 24px;
                overflow: hidden;
                box-shadow: 0 0 0 1px var(--border), 0 40px 80px rgba(0,0,0,0.8);
            }

            .login-panel-left {
                flex: 1;
                background: linear-gradient(160deg, #0d0a00 0%, #1a1200 40%, #0d0800 100%);
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                position: relative;
                border-right: 1px solid var(--border);
            }

            .panel-logo h1 {
                font-family: 'Cinzel', serif;
                font-size: 28px;
                color: var(--gold);
                letter-spacing: 3px;
            }
            .panel-logo p {
                font-size: 11px;
                color: var(--white-dim);
                text-transform: uppercase;
                margin-top: 8px;
            }

            .login-panel-right {
                width: 420px;
                background: var(--black-card);
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .form-header h2 {
                font-family: 'Cinzel', serif;
                font-size: 22px;
                color: var(--white);
                margin-bottom: 8px;
            }
            .gold-line {
                width: 40px;
                height: 2px;
                background: linear-gradient(90deg, var(--gold), transparent);
                margin: 14px 0;
            }

            .alert {
                font-size: 12px;
                padding: 12px;
                border-radius: 10px;
                margin-bottom: 20px;
                border: 1px solid;
            }
            .alert-error {
                background: rgba(255, 71, 87, 0.1);
                color: #ff4757;
                border-color: rgba(255, 71, 87, 0.2);
            }
            .alert-success {
                background: rgba(46, 213, 115, 0.1);
                color: #2ed573;
                border-color: rgba(46, 213, 115, 0.2);
            }

            .form-group {
                margin-bottom: 20px;
            }
            .form-label {
                display: block;
                font-size: 10px;
                font-weight: 600;
                color: var(--white-dim);
                letter-spacing: 2px;
                text-transform: uppercase;
                margin-bottom: 8px;
            }
            .input-wrapper {
                position: relative;
            }
            .input-icon {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--white-dim);
                font-size: 13px;
                z-index: 1;
            }

            .form-input {
                width: 100%;
                background: var(--black-input);
                border: 1px solid rgba(255,255,255,0.08);
                border-radius: 10px;
                padding: 13px 14px 13px 40px;
                color: var(--white);
                font-family: 'Raleway', sans-serif;
                outline: none;
                transition: all 0.25s;
            }
            .form-input:focus {
                border-color: var(--gold);
                background: rgba(201,168,76,0.04);
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                color: #000;
                border: none;
                border-radius: 10px;
                padding: 14px;
                font-family: 'Cinzel', serif;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s;
            }
            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(201,168,76,0.35);
            }

            .modal-overlay {
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.85);
                backdrop-filter: blur(8px);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                padding: 20px;
            }
            .modal-content {
                background: var(--black-card);
                width: 100%;
                max-width: 450px;
                padding: 50px;
                border-radius: 24px;
                border: 1px solid var(--border);
                position: relative;
                animation: modal-in 0.4s ease-out;
            }
            @keyframes modal-in {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .modal-close {
                position: absolute;
                top: 20px;
                right: 20px;
                background: none;
                border: none;
                color: var(--white-dim);
                font-size: 20px;
                cursor: pointer;
            }

            @media (max-width: 768px) {
                .login-panel-left {
                    display: none;
                }
                .login-panel-right {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <div class="bg-scene"><div class="bg-grid"></div></div>

        <div class="login-wrapper">
            <div class="login-panel-left">
                <div class="panel-logo">
                    <div style="width:50px;height:50px;background:var(--gold);border-radius:12px;display:flex;align-items:center;justify-content:center;margin-bottom:20px;color:#000;font-size:20px;">
                        <i class="fa-solid fa-book-open"></i>
                    </div>
                    <h1>BIBLIOTECA</h1>
                    <p>Uniboyacá</p>
                </div>
                <div style="font-size: 10px; color: var(--white-dim); letter-spacing: 1px; border-top: 1px solid var(--border); padding-top: 20px;">
                    © 2026 · UNIVERSIDAD REGIONAL DE BOYACÁ
                </div>
            </div>

            <div class="login-panel-right">
                <div class="form-header">
                    <h2>Iniciar Sesión</h2>
                    <div class="gold-line"></div>
                </div>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error")%></div>
                <% } %>
                <% if (request.getAttribute("mensaje") != null) {%>
                <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> <%= request.getAttribute("mensaje")%></div>
                <% }%>

                <form action="<%=request.getContextPath()%>/UsuarioServlet" method="POST">
                    <input type="hidden" name="accion" value="login">
                    <div class="form-group">
                        <label class="form-label">Correo</label>
                        <div class="input-wrapper">
                            <input type="email" name="txtCorreo" class="form-input" placeholder="usuario@uniboyaca.edu.co" required>
                            <i class="fa-solid fa-envelope input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Contraseña</label>
                        <div class="input-wrapper">
                            <input type="password" name="txtPass" class="form-input" placeholder="••••••••" required>
                            <i class="fa-solid fa-lock input-icon"></i>
                        </div>
                    </div>
                    <button type="submit" class="btn-login">INGRESAR AL SISTEMA</button>
                </form>

                <div style="text-align: center; margin-top: 25px;">
                    <p style="font-size: 11px; color: var(--white-dim);">
                        ¿No tienes cuenta? <a href="javascript:void(0)" onclick="abrir()" style="color: var(--gold); text-decoration: none; font-weight: 700;">REGÍSTRATE</a>
                    </p>
                </div>
            </div>
        </div>

        <div id="modalRegistro" class="modal-overlay">
            <div class="modal-content">
                <button class="modal-close" onclick="cerrar()"><i class="fa-solid fa-xmark"></i></button>
                <div class="form-header">
                    <h2>Nueva Cuenta</h2>
                    <div class="gold-line"></div>
                </div>
                <form action="<%=request.getContextPath()%>/UsuarioServlet" method="POST">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="form-group">
                        <label class="form-label">Nombre</label>
                        <div class="input-wrapper">
                            <input type="text" name="txtNombre" class="form-input" required>
                            <i class="fa-solid fa-user input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Correo</label>
                        <div class="input-wrapper">
                            <input type="email" name="txtCorreo" class="form-input" required>
                            <i class="fa-solid fa-envelope input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Clave</label>
                        <div class="input-wrapper">
                            <input type="password" name="txtPass" class="form-input" required>
                            <i class="fa-solid fa-shield-heart input-icon"></i>
                        </div>
                    </div>
                    <button type="submit" class="btn-login">CREAR USUARIO</button>
                </form>
            </div>
        </div>

        <script>
            function abrir() {
                document.getElementById('modalRegistro').style.display = 'flex';
            }
            function cerrar() {
                document.getElementById('modalRegistro').style.display = 'none';
            }
            window.onclick = function (e) {
                if (e.target == document.getElementById('modalRegistro'))
                    cerrar();
            }
        </script>
    </body>
</html>
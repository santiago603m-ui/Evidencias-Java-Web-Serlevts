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
                --gold-glow: rgba(201,168,76,0.35);
                --black: #050505;
                --black-card: #111111;
                --black-input: #0d0d0d;
                --white: #F5F0E8;
                --white-dim: #9A9080;
                --border: rgba(201,168,76,0.2);
                --border-hover: rgba(201,168,76,0.5);
                --error: #ff4757;
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
                background-image:
                    linear-gradient(rgba(201,168,76,0.04) 1px, transparent 1px),
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

            .bg-orb {
                position: absolute;
                border-radius: 50%;
                filter: blur(80px);
                animation: orb-pulse 8s ease-in-out infinite;
            }

            .bg-orb-1 {
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(201,168,76,0.12) 0%, transparent 70%);
                top: -150px;
                left: -150px;
                animation-delay: 0s;
            }

            .bg-orb-2 {
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(201,168,76,0.08) 0%, transparent 70%);
                bottom: -100px;
                right: -100px;
                animation-delay: 4s;
            }

            @keyframes orb-pulse {
                0%, 100% {
                    opacity: 0.6;
                    transform: scale(1);
                }
                50% {
                    opacity: 1;
                    transform: scale(1.1);
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
                animation: wrapper-in 0.8s cubic-bezier(0.16,1,0.3,1) both;
            }

            @keyframes wrapper-in {
                from {
                    opacity: 0;
                    transform: translateY(30px) scale(0.97);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .login-panel-left {
                flex: 1;
                background: linear-gradient(160deg, #0d0a00 0%, #1a1200 40%, #0d0800 100%);
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                position: relative;
                overflow: hidden;
                border-right: 1px solid var(--border);
            }

            .panel-bg-pattern {
                position: absolute;
                inset: 0;
                background:
                    repeating-linear-gradient(
                    45deg,
                    transparent,
                    transparent 30px,
                    rgba(201,168,76,0.03) 30px,
                    rgba(201,168,76,0.03) 31px
                    );
            }

            .panel-logo {
                position: relative;
                z-index: 2;
            }

            .panel-logo-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 26px;
                color: #000;
                margin-bottom: 24px;
                box-shadow: 0 0 30px rgba(201,168,76,0.4);
            }

            .panel-logo h1 {
                font-family: 'Cinzel', serif;
                font-size: 28px;
                font-weight: 700;
                color: var(--gold);
                letter-spacing: 3px;
                line-height: 1.2;
            }

            .panel-logo p {
                font-size: 11px;
                color: var(--white-dim);
                letter-spacing: 3px;
                text-transform: uppercase;
                margin-top: 8px;
            }

            .panel-features {
                position: relative;
                z-index: 2;
            }

            .panel-feature {
                display: flex;
                align-items: flex-start;
                gap: 14px;
                margin-bottom: 24px;
                animation: feature-in 0.6s ease both;
            }

            .panel-feature:nth-child(1) {
                animation-delay: 0.3s;
            }
            .panel-feature:nth-child(2) {
                animation-delay: 0.45s;
            }
            .panel-feature:nth-child(3) {
                animation-delay: 0.6s;
            }

            @keyframes feature-in {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .feature-icon {
                width: 38px;
                height: 38px;
                background: rgba(201,168,76,0.1);
                border: 1px solid var(--border);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--gold);
                font-size: 14px;
                flex-shrink: 0;
                margin-top: 2px;
            }

            .feature-text h4 {
                font-size: 13px;
                font-weight: 600;
                color: var(--white);
                margin-bottom: 3px;
            }

            .feature-text p {
                font-size: 11px;
                color: var(--white-dim);
                line-height: 1.5;
            }

            .panel-footer {
                position: relative;
                z-index: 2;
                font-size: 10px;
                color: var(--white-dim);
                letter-spacing: 1.5px;
                text-transform: uppercase;
                border-top: 1px solid var(--border);
                padding-top: 20px;
            }

            .login-panel-right {
                width: 420px;
                background: var(--black-card);
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .form-header {
                margin-bottom: 40px;
            }

            .form-header h2 {
                font-family: 'Cinzel', serif;
                font-size: 22px;
                font-weight: 600;
                color: var(--white);
                margin-bottom: 8px;
            }

            .form-header p {
                font-size: 12px;
                color: var(--white-dim);
                letter-spacing: 0.5px;
            }

            .form-header .gold-line {
                width: 40px;
                height: 2px;
                background: linear-gradient(90deg, var(--gold), transparent);
                margin: 14px 0;
            }

            .form-group {
                margin-bottom: 20px;
                animation: field-in 0.5s ease both;
            }

            .form-group:nth-child(1) {
                animation-delay: 0.4s;
            }
            .form-group:nth-child(2) {
                animation-delay: 0.5s;
            }

            @keyframes field-in {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
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
                transition: color 0.2s;
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
                font-size: 13px;
                outline: none;
                transition: all 0.25s;
            }

            .form-input:focus {
                border-color: var(--gold);
                background: rgba(201,168,76,0.04);
                box-shadow: 0 0 0 3px rgba(201,168,76,0.08);
            }

            .form-input:focus + .input-icon,
            .input-wrapper:focus-within .input-icon {
                color: var(--gold);
            }

            .form-input::placeholder {
                color: rgba(255,255,255,0.2);
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, var(--gold) 0%, var(--gold-dark) 100%);
                color: #000;
                border: none;
                border-radius: 10px;
                padding: 14px;
                font-family: 'Cinzel', serif;
                font-size: 13px;
                font-weight: 700;
                letter-spacing: 2px;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 28px;
                position: relative;
                overflow: hidden;
                animation: btn-in 0.5s ease 0.6s both;
            }

            @keyframes btn-in {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .btn-login::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, var(--gold-light), var(--gold));
                opacity: 0;
                transition: opacity 0.3s;
            }

            .btn-login:hover::before {
                opacity: 1;
            }
            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(201,168,76,0.35);
            }
            .btn-login:active {
                transform: translateY(0);
            }

            .btn-login span {
                position: relative;
                z-index: 1;
            }

            .alert-error {
                background: rgba(255,71,87,0.1);
                border: 1px solid rgba(255,71,87,0.3);
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 12px;
                color: #ff6b7a;
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 24px;
                animation: shake 0.4s ease;
            }

            @keyframes shake {
                0%, 100% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-6px);
                }
                75% {
                    transform: translateX(6px);
                }
            }

            @media (max-width: 768px) {
                .login-panel-left {
                    display: none;
                }
                .login-panel-right {
                    width: 100%;
                    padding: 40px 30px;
                }
            }
        </style>
    </head>
    <body>

        <div class="bg-scene">
            <div class="bg-grid"></div>
            <div class="bg-orb bg-orb-1"></div>
            <div class="bg-orb bg-orb-2"></div>
        </div>

        <div class="login-wrapper">
            <div class="login-panel-left">
                <div class="panel-bg-pattern"></div>

                <div class="panel-logo">
                    <div class="panel-logo-icon">
                        <i class="fa-solid fa-book-open"></i>
                    </div>
                    <h1>BIBLIOTECA</h1>
                    <p>Uniboyacá · Gestión Académica</p>
                </div>

                <div class="panel-features">
                    <div class="panel-feature">
                        <div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div>
                        <div class="feature-text">
                            <h4>Acceso Seguro</h4>
                            <p>Sistema autenticado con control de roles para administradores y estudiantes.</p>
                        </div>
                    </div>
                    <div class="panel-feature">
                        <div class="feature-icon"><i class="fa-solid fa-book"></i></div>
                        <div class="feature-text">
                            <h4>Catálogo Digital</h4>
                            <p>Consulta disponibilidad de material académico en tiempo real.</p>
                        </div>
                    </div>
                    <div class="panel-feature">
                        <div class="feature-icon"><i class="fa-solid fa-arrow-right-arrow-left"></i></div>
                        <div class="feature-text">
                            <h4>Gestión de Préstamos</h4>
                            <p>Solicita y controla el historial de préstamos desde cualquier dispositivo.</p>
                        </div>
                    </div>
                </div>

                <div class="panel-footer">
                    © 2026 · Universidad Regional de Boyacá · SENA
                </div>
            </div>

            <div class="login-panel-right">
                <div class="form-header">
                    <h2>Iniciar Sesión</h2>
                    <div class="gold-line"></div>
                    <p>Ingresa tus credenciales institucionales para continuar</p>
                </div>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert-error">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <%= request.getAttribute("error")%>
                </div>
                <% }%>

                <form action="<%=request.getContextPath()%>/UsuarioServlet" method="POST">
                    <input type="hidden" name="accion" value="login">

                    <div class="form-group">
                        <label class="form-label">Correo Institucional</label>
                        <div class="input-wrapper">
                            <input type="email" name="txtCorreo" class="form-input"
                                   placeholder="usuario@uniboyaca.edu.co" required>
                            <i class="fa-solid fa-envelope input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Contraseña</label>
                        <div class="input-wrapper">
                            <input type="password" name="txtPass" class="form-input"
                                   placeholder="••••••••" required>
                            <i class="fa-solid fa-lock input-icon"></i>
                        </div>
                    </div>

                    <button type="submit" class="btn-login">
                        <span>INGRESAR AL SISTEMA &nbsp;<i class="fa-solid fa-arrow-right-to-bracket"></i></span>
                    </button>
                </form>
            </div>
        </div>

    </body>
</html>

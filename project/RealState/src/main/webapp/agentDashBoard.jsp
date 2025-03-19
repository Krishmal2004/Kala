<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Real Estate Portal</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #0a192f;
            --secondary: #112240;
            --accent: #64ffda;
            --text: #8892b0;
            --text-light: #ccd6f6;
        }

        body {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            min-height: 100vh;
            color: var(--text-light);
            font-family: 'Calibre', sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
        }

        .system-info {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(17, 34, 64, 0.8);
            backdrop-filter: blur(10px);
            padding: 12px 20px;
            border-radius: 12px;
            border: 1px solid rgba(100, 255, 218, 0.1);
            color: var(--accent);
            font-size: 0.9rem;
            z-index: 1000;
            animation: slideInRight 0.5s ease;
        }

        .user-info {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(17, 34, 64, 0.8);
            backdrop-filter: blur(10px);
            padding: 12px 20px;
            border-radius: 12px;
            border: 1px solid rgba(100, 255, 218, 0.1);
            color: var(--accent);
            font-size: 0.9rem;
            z-index: 1000;
            animation: slideInLeft 0.5s ease;
        }

        .login-container {
            position: relative;
            z-index: 2;
            padding-top: 100px;
        }

        .login-card {
            background: rgba(17, 34, 64, 0.7);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(100, 255, 218, 0.1);
            padding: 2.5rem;
            max-width: 450px;
            margin: auto;
            transform: translateY(20px);
            animation: fadeInUp 0.8s ease forwards;
        }

        .form-control {
            background: rgba(10, 25, 47, 0.7);
            border: 1px solid rgba(100, 255, 218, 0.1);
            color: var(--text-light);
            border-radius: 8px;
            padding: 12px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(10, 25, 47, 0.9);
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(100, 255, 218, 0.1);
            color: var(--text-light);
        }

        .btn-login {
            background: transparent;
            color: var(--accent);
            border: 1px solid var(--accent);
            border-radius: 8px;
            padding: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-login:hover {
            background: rgba(100, 255, 218, 0.1);
            color: var(--accent);
            transform: translateY(-2px);
        }

        .btn-login::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                transparent,
                rgba(100, 255, 218, 0.1),
                transparent
            );
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) rotate(45deg); }
            100% { transform: translateX(100%) rotate(45deg); }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .role-selector {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .role-option {
            flex: 1;
            background: rgba(10, 25, 47, 0.7);
            border: 1px solid rgba(100, 255, 218, 0.1);
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .role-option:hover {
            background: rgba(100, 255, 218, 0.1);
            transform: translateY(-2px);
        }

        .role-option.active {
            border-color: var(--accent);
            background: rgba(100, 255, 218, 0.1);
        }

        .role-option i {
            font-size: 1.5rem;
            color: var(--accent);
            margin-bottom: 8px;
        }

        .input-group-text {
            background: rgba(10, 25, 47, 0.7);
            border: 1px solid rgba(100, 255, 218, 0.1);
            color: var(--accent);
        }
    </style>
</head>
<body>
    <!-- Particles.js Container -->
    <div id="particles-js"></div>

    <!-- System Info -->
    <div class="system-info">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-19 18:21:51</span>
    </div>

    <!-- User Info -->
    <div class="user-info">
        <i class="fas fa-user me-2"></i>
        <span>Krishmal2004</span>
    </div>

    <div class="container login-container">
        <div class="login-card">
            <div class="text-center mb-4">
                <i class="fas fa-user-shield fa-3x mb-3" style="color: var(--accent);"></i>
                <h3 class="text-light">Welcome Back</h3>
                <p style="color: var(--text);">Please login to your account</p>
            </div>

            <form action="LoginServlet" method="POST" id="loginForm">
                <!-- Role Selection -->
                <div class="role-selector">
                    <div class="role-option active" data-role="buyer">
                        <i class="fas fa-home"></i>
                        <div>Buyer</div>
                    </div>
                    <div class="role-option" data-role="agent">
                        <i class="fas fa-user-tie"></i>
                        <div>Agent</div>
                    </div>
                    <div class="role-option" data-role="student">
                        <i class="fas fa-user-graduate"></i>
                        <div>Student</div>
                    </div>
                </div>

                <input type="hidden" name="userType" id="userType" value="buyer">

                <!-- Email -->
                <div class="input-group mb-3">
                    <span class="input-group-text">
                        <i class="fas fa-envelope"></i>
                    </span>
                    <input type="email" name="email" class="form-control" placeholder="Email address" required>
                </div>

                <!-- Password -->
                <div class="input-group mb-4">
                    <span class="input-group-text">
                        <i class="fas fa-lock"></i>
                    </span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="d-flex justify-content-between mb-4">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label" for="remember">Remember me</label>
                    </div>
                    <a href="forgot-password.jsp" style="color: var(--accent);">Forgot Password?</a>
                </div>

                <!-- Login Button -->
                <button type="submit" class="btn btn-login w-100 mb-3">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </button>

                <!-- Register Link -->
                <div class="text-center">
                    <span style="color: var(--text);">Don't have an account? </span>
                    <a href="register.jsp" style="color: var(--accent);">Register here</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    
    <script>
        // Initialize Particles.js
        particlesJS("particles-js", {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#64ffda" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.5,
                    random: false,
                    animation: { enable: true, speed: 1, opacity_min: 0.1, sync: false }
                },
                size: {
                    value: 3,
                    random: true,
                    animation: { enable: true, speed: 40, size_min: 0.1, sync: false }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#64ffda",
                    opacity: 0.2,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 3,
                    direction: "none",
                    random: false,
                    straight: false,
                    out_mode: "out",
                    bounce: false,
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" },
                    resize: true
                }
            },
            retina_detect: true
        });

        // Update current time
        function updateTime() {
            document.getElementById('current-time').textContent = 
                new Date().toISOString().slice(0, 19).replace('T', ' ');
        }
        setInterval(updateTime, 1000);

        // Role selection
        document.querySelectorAll('.role-option').forEach(option => {
            option.addEventListener('click', function() {
                // Remove active class from all options
                document.querySelectorAll('.role-option').forEach(opt => 
                    opt.classList.remove('active'));
                
                // Add active class to clicked option
                this.classList.add('active');
                
                // Update hidden input
                document.getElementById('userType').value = this.dataset.role;
            });
        });

        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.querySelector('input[name="email"]').value;
            const password = document.querySelector('input[name="password"]').value;

            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
    </script>
</body>
</html>
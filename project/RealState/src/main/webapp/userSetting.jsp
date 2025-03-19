<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings - Real Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        :root {
            --dark-blue-1: #000c24;
            --dark-blue-2: #001a4d;
            --blue-accent: #0055ff;
            --light-blue: #e6f0ff;
            --white: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.1);
            --success-color: #28a745;
            --danger-color: #dc3545;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--dark-blue-1), var(--dark-blue-2));
            font-family: 'Poppins', sans-serif;
        }

        /* Navigation Bar */
        .custom-navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        /* Settings Container */
        .settings-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem 1rem;
        }

        /* Settings Card */
        .settings-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem;
            color: var(--white);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
            opacity: 0;
            transform: translateY(20px);
            animation: slideUp 0.6s ease forwards;
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* User Avatar */
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid var(--blue-accent);
            padding: 3px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .user-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 85, 255, 0.4);
        }

        /* Form Controls */
        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--white);
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--blue-accent);
            color: var(--white);
            box-shadow: 0 0 0 0.25rem rgba(0, 85, 255, 0.25);
        }

        /* Custom Buttons */
        .btn-custom {
            background: rgba(0, 85, 255, 0.15);
            border: 1px solid var(--blue-accent);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background: var(--blue-accent);
            transform: translateY(-2px);
        }

        /* Navigation Pills */
        .nav-pills .nav-link {
            color: var(--white);
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin: 0.3rem 0;
            transition: all 0.3s ease;
        }

        .nav-pills .nav-link.active {
            background: var(--blue-accent);
            color: var(--white);
        }

        .nav-pills .nav-link:not(.active):hover {
            background: rgba(0, 85, 255, 0.15);
        }

        /* Time Display */
        .time-display {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 85, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: var(--white);
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9rem;
            z-index: 1000;
        }

        /* Home Return Button */
        .home-return-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: white;
            text-decoration: none;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .home-return-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(-5px);
            color: white;
            text-decoration: none;
        }

        .home-return-btn i {
            transition: transform 0.3s ease;
        }

        .home-return-btn:hover i {
            transform: translateX(-3px);
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: -300px;
            background: var(--success-color);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            z-index: 1001;
        }

        .notification.show {
            right: 20px;
        }

        /* Welcome Text */
        .welcome-text {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            font-size: 0.9rem;
            z-index: 1000;
            border: 1px solid rgba(255, 255, 255, 0.2);
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <!-- Home Return Button -->
    <a href="userDashboard.jsp" class="home-return-btn animate__animated animate__fadeIn">
        <i class="fas fa-arrow-left"></i>
        <span>Back to Home</span>
    </a>

    <!-- Welcome Message -->
    <div class="welcome-text animate__animated animate__fadeIn">
        <i class="fas fa-user me-2"></i>Welcome, Krishmal2004
    </div>

    <!-- Time Display -->
    <div class="time-display animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-16 08:17:01</span>
    </div>

    <!-- Notification -->
    <div class="notification" id="notification">
        <i class="fas fa-check-circle me-2"></i>
        <span id="notification-text">Settings saved successfully!</span>
    </div>

    <!-- Main Content -->
    <div class="container settings-container">
        <div class="settings-card">
            <div class="row align-items-center mb-4">
                <div class="col-auto">
                    <img src="https://ui-avatars.com/api/?name=Krishmal2004&background=0055ff&color=fff" 
                         alt="Profile Picture" 
                         class="user-avatar"
                         onclick="document.getElementById('avatar-upload').click()">
                    <input type="file" id="avatar-upload" hidden accept="image/*">
                </div>
                <div class="col">
                    <h2 class="mb-1">Krishmal2004</h2>
                    <p class="text-light mb-0">Real Estate Agent</p>
                </div>
            </div>

            <div class="row">
                <!-- Navigation Pills -->
                <div class="col-md-3">
                    <div class="nav flex-column nav-pills" role="tablist">
                        <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#profile">
                            <i class="fas fa-user me-2"></i>Profile
                        </button>
                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#security">
                            <i class="fas fa-shield-alt me-2"></i>Security
                        </button>
                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#preferences">
                            <i class="fas fa-cog me-2"></i>Preferences
                        </button>
                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#notifications">
                            <i class="fas fa-bell me-2"></i>Notifications
                        </button>
                        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#listings">
                            <i class="fas fa-home me-2"></i>Listings
                        </button>
                    </div>
                </div>

                <!-- Tab Content -->
                <div class="col-md-9">
                    <div class="tab-content">
                        <!-- Profile Tab -->
                        <div class="tab-pane fade show active" id="profile">
                            <h3 class="mb-4">Profile Information</h3>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">First Name</label>
                                        <input type="text" class="form-control" value="Krishmal">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Last Name</label>
                                        <input type="text" class="form-control" value="2004">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="krishmal@example.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Phone</label>
                                        <input type="tel" class="form-control" value="+94 70 219 5755">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Bio</label>
                                        <textarea class="form-control" rows="3">Experienced real estate agent specializing in residential properties.</textarea>
                                    </div>
                                    <div class="col-12">
                                        <button type="button" class="btn btn-custom" onclick="saveSettings()">
                                            <i class="fas fa-save me-2"></i>Save Changes
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Security Tab -->
                        <div class="tab-pane fade" id="security">
                            <h3 class="mb-4">Security Settings</h3>
                            <form>
                                <div class="mb-3">
                                    <label class="form-label">Current Password</label>
                                    <input type="password" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">New Password</label>
                                    <input type="password" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control">
                                </div>
                                <button type="button" class="btn btn-custom">
                                    <i class="fas fa-key me-2"></i>Update Password
                                </button>
                            </form>
                        </div>

                        <!-- Preferences Tab -->
                        <div class="tab-pane fade" id="preferences">
                            <h3 class="mb-4">User Preferences</h3>
                            <form>
                                <div class="mb-3">
                                    <label class="form-label">Language</label>
                                    <select class="form-select">
                                        <option value="en">English</option>
                                        <option value="si">Sinhala</option>
                                        <option value="ta">Tamil</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Time Zone</label>
                                    <select class="form-select">
                                        <option value="UTC">UTC</option>
                                        <option value="Asia/Colombo" selected>Asia/Colombo</option>
                                    </select>
                                </div>
                                <button type="button" class="btn btn-custom">
                                    <i class="fas fa-save me-2"></i>Save Preferences
                                </button>
                            </form>
                        </div>

                        <!-- Notifications Tab -->
                        <div class="tab-pane fade" id="notifications">
                            <h3 class="mb-4">Notification Settings</h3>
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" checked>
                                    <label class="form-check-label">Email Notifications</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" checked>
                                
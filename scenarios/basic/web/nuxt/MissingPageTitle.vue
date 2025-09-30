<template>
  <div class="settings-application">
    <header class="app-header">
      <div class="header-content">
        <div class="logo-section">
          <img src="/api/placeholder/40/40" alt="AppLogo" class="app-logo" />
          <h1 class="app-title">Settings</h1>
        </div>
        
        <nav class="header-nav">
          <a href="/dashboard" class="nav-link">Dashboard</a>
          <a href="/projects" class="nav-link">Projects</a>
          <a href="/team" class="nav-link">Team</a>
          <a href="/reports" class="nav-link">Reports</a>
        </nav>
        
        <div class="user-menu">
          <img src="/api/placeholder/35/35" alt="User Avatar" class="user-avatar" />
          <span class="user-name">John Doe</span>
        </div>
      </div>
    </header>

    <div class="main-layout">
      <aside class="sidebar">
        <nav class="sidebar-nav">
          <div class="nav-section">
            <h3 class="nav-section-title">Account</h3>
            <ul class="nav-list">
              <li><a href="/profile" class="nav-item">Profile</a></li>
              <li><a href="/security" class="nav-item">Security</a></li>
              <li><a href="/billing" class="nav-item">Billing</a></li>
              <li><a href="/notifications" class="nav-item">Notifications</a></li>
            </ul>
          </div>
          
          <div class="nav-section">
            <h3 class="nav-section-title">Preferences</h3>
            <ul class="nav-list">
              <li><a href="/appearance" class="nav-item">Appearance</a></li>
              <li><a href="/language" class="nav-item">Language</a></li>
              <li><a href="/timezone" class="nav-item">Timezone</a></li>
              <li><a href="/privacy" class="nav-item">Privacy</a></li>
            </ul>
          </div>
          
          <div class="nav-section">
            <h3 class="nav-section-title">System</h3>
            <ul class="nav-list">
              <li><a href="/integrations" class="nav-item">Integrations</a></li>
              <li><a href="/api" class="nav-item">API Keys</a></li>
              <li><a href="/logs" class="nav-item">Activity Logs</a></li>
              <li><a href="/backup" class="nav-item">Backup</a></li>
            </ul>
          </div>
        </nav>
      </aside>

      <main class="main-content">
        <div class="content-header">
          <div class="breadcrumb">
            <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
            <span class="breadcrumb-separator">/</span>
            <span class="breadcrumb-current">Settings</span>
          </div>
        </div>

        <div class="settings-content">
          <div class="settings-section">
            <h2 class="section-title">Profile Settings</h2>
            <p class="section-description">
              Manage your personal information and account details
            </p>
            
            <form class="settings-form">
              <div class="form-group">
                <label for="firstName" class="form-label">First Name</label>
                <input 
                  type="text" 
                  id="firstName" 
                  name="firstName"
                  class="form-input"
                  value="John"
                />
              </div>
              
              <div class="form-group">
                <label for="lastName" class="form-label">Last Name</label>
                <input 
                  type="text" 
                  id="lastName" 
                  name="lastName"
                  class="form-input"
                  value="Doe"
                />
              </div>
              
              <div class="form-group">
                <label for="email" class="form-label">Email Address</label>
                <input 
                  type="email" 
                  id="email" 
                  name="email"
                  class="form-input"
                  value="john.doe@example.com"
                />
              </div>
              
              <div class="form-group">
                <label for="phone" class="form-label">Phone Number</label>
                <input 
                  type="tel" 
                  id="phone" 
                  name="phone"
                  class="form-input"
                  value="+1 (555) 123-4567"
                />
              </div>
              
              <div class="form-group">
                <label for="bio" class="form-label">Bio</label>
                <textarea 
                  id="bio" 
                  name="bio"
                  class="form-textarea"
                  rows="4"
                  placeholder="Tell us about yourself..."
                >Software engineer with 5+ years of experience in web development and cloud technologies.</textarea>
              </div>
              
              <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <button type="button" class="btn btn-secondary">Cancel</button>
              </div>
            </form>
          </div>

          <div class="settings-section">
            <h2 class="section-title">Security Settings</h2>
            <p class="section-description">
              Manage your password and security preferences
            </p>
            
            <div class="security-options">
              <div class="security-item">
                <div class="security-info">
                  <h3 class="security-title">Password</h3>
                  <p class="security-description">Last changed 30 days ago</p>
                </div>
                <button class="btn btn-outline">Change Password</button>
              </div>
              
              <div class="security-item">
                <div class="security-info">
                  <h3 class="security-title">Two-Factor Authentication</h3>
                  <p class="security-description">Add an extra layer of security to your account</p>
                </div>
                <button class="btn btn-outline">Enable 2FA</button>
              </div>
              
              <div class="security-item">
                <div class="security-info">
                  <h3 class="security-title">Login Sessions</h3>
                  <p class="security-description">Manage active sessions across devices</p>
                </div>
                <button class="btn btn-outline">View Sessions</button>
              </div>
            </div>
          </div>

          <div class="settings-section">
            <h2 class="section-title">Notification Preferences</h2>
            <p class="section-description">
              Choose how you want to be notified about updates and activities
            </p>
            
            <div class="notification-options">
              <div class="notification-group">
                <h3 class="notification-group-title">Email Notifications</h3>
                <div class="notification-items">
                  <label class="notification-item">
                    <input type="checkbox" checked />
                    <span class="notification-label">Project updates</span>
                  </label>
                  <label class="notification-item">
                    <input type="checkbox" checked />
                    <span class="notification-label">Team messages</span>
                  </label>
                  <label class="notification-item">
                    <input type="checkbox" />
                    <span class="notification-label">Marketing emails</span>
                  </label>
                  <label class="notification-item">
                    <input type="checkbox" checked />
                    <span class="notification-label">Security alerts</span>
                  </label>
                </div>
              </div>
              
              <div class="notification-group">
                <h3 class="notification-group-title">Push Notifications</h3>
                <div class="notification-items">
                  <label class="notification-item">
                    <input type="checkbox" checked />
                    <span class="notification-label">Mobile push</span>
                  </label>
                  <label class="notification-item">
                    <input type="checkbox" />
                    <span class="notification-label">Desktop notifications</span>
                  </label>
                  <label class="notification-item">
                    <input type="checkbox" checked />
                    <span class="notification-label">Browser notifications</span>
                  </label>
                </div>
              </div>
            </div>
          </div>

          <div class="settings-section">
            <h2 class="section-title">Appearance Settings</h2>
            <p class="section-description">
              Customize the look and feel of your application
            </p>
            
            <div class="appearance-options">
              <div class="appearance-group">
                <h3 class="appearance-group-title">Theme</h3>
                <div class="theme-options">
                  <label class="theme-option">
                    <input type="radio" name="theme" value="light" checked />
                    <div class="theme-preview light">
                      <div class="theme-name">Light</div>
                    </div>
                  </label>
                  <label class="theme-option">
                    <input type="radio" name="theme" value="dark" />
                    <div class="theme-preview dark">
                      <div class="theme-name">Dark</div>
                    </div>
                  </label>
                  <label class="theme-option">
                    <input type="radio" name="theme" value="auto" />
                    <div class="theme-preview auto">
                      <div class="theme-name">Auto</div>
                    </div>
                  </label>
                </div>
              </div>
              
              <div class="appearance-group">
                <h3 class="appearance-group-title">Language</h3>
                <select class="language-select">
                  <option value="en">English</option>
                  <option value="es">Spanish</option>
                  <option value="fr">French</option>
                  <option value="de">German</option>
                  <option value="ja">Japanese</option>
                </select>
              </div>
              
              <div class="appearance-group">
                <h3 class="appearance-group-title">Timezone</h3>
                <select class="timezone-select">
                  <option value="UTC-8">Pacific Time (UTC-8)</option>
                  <option value="UTC-7">Mountain Time (UTC-7)</option>
                  <option value="UTC-6">Central Time (UTC-6)</option>
                  <option value="UTC-5">Eastern Time (UTC-5)</option>
                  <option value="UTC+0">UTC (UTC+0)</option>
                  <option value="UTC+1">Central European Time (UTC+1)</option>
                </select>
              </div>
            </div>
          </div>

          <div class="settings-section">
            <h2 class="section-title">Privacy Settings</h2>
            <p class="section-description">
              Control your privacy and data sharing preferences
            </p>
            
            <div class="privacy-options">
              <div class="privacy-item">
                <div class="privacy-info">
                  <h3 class="privacy-title">Profile Visibility</h3>
                  <p class="privacy-description">Who can see your profile information</p>
                </div>
                <select class="privacy-select">
                  <option value="public">Public</option>
                  <option value="team">Team Only</option>
                  <option value="private">Private</option>
                </select>
              </div>
              
              <div class="privacy-item">
                <div class="privacy-info">
                  <h3 class="privacy-title">Activity Status</h3>
                  <p class="privacy-description">Show when you're online or offline</p>
                </div>
                <label class="privacy-toggle">
                  <input type="checkbox" checked />
                  <span class="toggle-slider"></span>
                </label>
              </div>
              
              <div class="privacy-item">
                <div class="privacy-info">
                  <h3 class="privacy-title">Data Analytics</h3>
                  <p class="privacy-description">Allow usage data to improve our services</p>
                </div>
                <label class="privacy-toggle">
                  <input type="checkbox" checked />
                  <span class="toggle-slider"></span>
                </label>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <footer class="app-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Account</h4>
          <ul class="footer-links">
            <li><a href="/profile">Profile</a></li>
            <li><a href="/security">Security</a></li>
            <li><a href="/billing">Billing</a></li>
            <li><a href="/notifications">Notifications</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Preferences</h4>
          <ul class="footer-links">
            <li><a href="/appearance">Appearance</a></li>
            <li><a href="/language">Language</a></li>
            <li><a href="/timezone">Timezone</a></li>
            <li><a href="/privacy">Privacy</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Support</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact Us</a></li>
            <li><a href="/feedback">Feedback</a></li>
            <li><a href="/status">System Status</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Legal</h4>
          <ul class="footer-links">
            <li><a href="/terms">Terms of Service</a></li>
            <li><a href="/privacy-policy">Privacy Policy</a></li>
            <li><a href="/cookies">Cookie Policy</a></li>
            <li><a href="/gdpr">GDPR</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 Settings Application. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
// No JavaScript needed for this component
</script>

<style scoped>
.settings-application {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.app-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 15px;
}

.app-logo {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.app-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.header-nav {
  display: flex;
  gap: 30px;
}

.nav-link {
  color: #333;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
}

.nav-link:hover {
  color: #007bff;
}

.user-menu {
  display: flex;
  align-items: center;
  gap: 10px;
}

.user-avatar {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  object-fit: cover;
}

.user-name {
  font-weight: 500;
  color: #333;
}

.main-layout {
  display: flex;
  max-width: 1400px;
  margin: 0 auto;
  min-height: calc(100vh - 70px);
}

.sidebar {
  width: 250px;
  background: white;
  box-shadow: 2px 0 10px rgba(0,0,0,0.1);
  padding: 30px 0;
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.nav-section {
  padding: 0 30px;
}

.nav-section-title {
  margin: 0 0 15px 0;
  font-size: 14px;
  font-weight: bold;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-item {
  display: block;
  padding: 12px 0;
  color: #333;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
  border-left: 3px solid transparent;
  padding-left: 15px;
}

.nav-item:hover {
  color: #007bff;
  border-left-color: #007bff;
}

.main-content {
  flex: 1;
  padding: 30px;
  background: white;
  margin: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.content-header {
  margin-bottom: 30px;
}

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
}

.breadcrumb-link {
  color: #007bff;
  text-decoration: none;
}

.breadcrumb-link:hover {
  text-decoration: underline;
}

.breadcrumb-separator {
  color: #ccc;
}

.breadcrumb-current {
  color: #333;
  font-weight: 500;
}

.settings-content {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.settings-section {
  padding-bottom: 40px;
  border-bottom: 1px solid #eee;
}

.settings-section:last-child {
  border-bottom: none;
  padding-bottom: 0;
}

.section-title {
  margin: 0 0 10px 0;
  font-size: 24px;
  color: #333;
}

.section-description {
  margin: 0 0 30px 0;
  color: #666;
  font-size: 16px;
}

.settings-form {
  display: flex;
  flex-direction: column;
  gap: 25px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-label {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.form-input,
.form-textarea {
  padding: 12px 16px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s ease;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #007bff;
}

.form-textarea {
  resize: vertical;
  min-height: 100px;
}

.form-actions {
  display: flex;
  gap: 15px;
  margin-top: 10px;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #007bff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #545b62;
}

.btn-outline {
  background: transparent;
  color: #007bff;
  border: 2px solid #007bff;
}

.btn-outline:hover {
  background: #007bff;
  color: white;
}

.security-options {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.security-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
}

.security-info {
  flex: 1;
}

.security-title {
  margin: 0 0 5px 0;
  font-size: 18px;
  color: #333;
}

.security-description {
  margin: 0;
  color: #666;
  font-size: 14px;
}

.notification-options {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.notification-group {
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
}

.notification-group-title {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: #333;
}

.notification-items {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.notification-item {
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
}

.notification-item input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #007bff;
}

.notification-label {
  font-weight: 500;
  color: #333;
}

.appearance-options {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.appearance-group {
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
}

.appearance-group-title {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: #333;
}

.theme-options {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.theme-option {
  cursor: pointer;
}

.theme-option input[type="radio"] {
  display: none;
}

.theme-preview {
  width: 120px;
  height: 80px;
  border: 2px solid #ddd;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.theme-option input[type="radio"]:checked + .theme-preview {
  border-color: #007bff;
  background: #f8f9ff;
}

.theme-preview.light {
  background: white;
  color: #333;
}

.theme-preview.dark {
  background: #333;
  color: white;
}

.theme-preview.auto {
  background: linear-gradient(45deg, white 50%, #333 50%);
  color: #333;
}

.theme-name {
  font-weight: bold;
  font-size: 14px;
}

.language-select,
.timezone-select {
  padding: 10px 12px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  background: white;
  cursor: pointer;
  min-width: 200px;
}

.language-select:focus,
.timezone-select:focus {
  outline: none;
  border-color: #007bff;
}

.privacy-options {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.privacy-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
}

.privacy-info {
  flex: 1;
}

.privacy-title {
  margin: 0 0 5px 0;
  font-size: 18px;
  color: #333;
}

.privacy-description {
  margin: 0;
  color: #666;
  font-size: 14px;
}

.privacy-select {
  padding: 10px 12px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  background: white;
  cursor: pointer;
  min-width: 150px;
}

.privacy-select:focus {
  outline: none;
  border-color: #007bff;
}

.privacy-toggle {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 24px;
  cursor: pointer;
}

.privacy-toggle input[type="checkbox"] {
  opacity: 0;
  width: 0;
  height: 0;
}

.toggle-slider {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: #ccc;
  border-radius: 24px;
  transition: 0.2s;
}

.toggle-slider:before {
  position: absolute;
  content: "";
  height: 18px;
  width: 18px;
  left: 3px;
  bottom: 3px;
  background: white;
  border-radius: 50%;
  transition: 0.2s;
}

.privacy-toggle input:checked + .toggle-slider {
  background: #007bff;
}

.privacy-toggle input:checked + .toggle-slider:before {
  transform: translateX(26px);
}

.app-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 1024px) {
  .main-layout {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
    padding: 20px;
  }
  
  .sidebar-nav {
    flex-direction: row;
    flex-wrap: wrap;
    gap: 20px;
  }
  
  .nav-section {
    padding: 0;
    min-width: 200px;
  }
  
  .main-content {
    margin: 0;
    border-radius: 0;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    height: auto;
    padding: 20px;
  }

  .header-nav {
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
  }

  .main-content {
    padding: 20px;
  }

  .form-actions {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .security-item,
  .privacy-item {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }

  .theme-options {
    flex-direction: column;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .section-title {
    font-size: 20px;
  }

  .settings-form {
    gap: 20px;
  }

  .notification-options,
  .appearance-options,
  .privacy-options {
    gap: 20px;
  }

  .theme-preview {
    width: 100px;
    height: 60px;
  }
}
</style>

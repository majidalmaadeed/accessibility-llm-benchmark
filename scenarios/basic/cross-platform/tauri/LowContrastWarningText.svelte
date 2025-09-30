<script>
  import { onMount } from 'svelte';
  
  let sessionTime = 300; // 5 minutes in seconds
  let isWarningVisible = false;
  let warningInterval;
  
  onMount(() => {
    // Start session timer
    warningInterval = setInterval(() => {
      sessionTime -= 1;
      
      if (sessionTime <= 60 && !isWarningVisible) {
        isWarningVisible = true;
      }
      
      if (sessionTime <= 0) {
        clearInterval(warningInterval);
        logout();
      }
    }, 1000);
    
    return () => {
      if (warningInterval) {
        clearInterval(warningInterval);
      }
    };
  });
  
  function extendSession() {
    sessionTime = 300;
    isWarningVisible = false;
    alert('Session extended for 5 more minutes');
  }
  
  function logout() {
    alert('Session expired. You have been logged out.');
    // In a real app, this would redirect to login
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
</script>

<div class="dashboard">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Secure Dashboard</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Settings clicked')}>
          ⚙️ Settings
        </button>
        <button class="header-btn" on:click={() => alert('Profile clicked')}>
          👤 Profile
        </button>
        <button class="header-btn" on:click={logout}>
          🚪 Logout
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Welcome to Your Dashboard</h2>
      <p class="page-subtitle">Manage your account and preferences</p>
    </div>
    
    <div class="content-grid">
      <div class="content-card">
        <h3 class="card-title">Account Information</h3>
        <div class="card-content">
          <div class="info-item">
            <span class="info-label">Username:</span>
            <span class="info-value">john_doe</span>
          </div>
          <div class="info-item">
            <span class="info-label">Email:</span>
            <span class="info-value">john.doe@example.com</span>
          </div>
          <div class="info-item">
            <span class="info-label">Last Login:</span>
            <span class="info-value">2 hours ago</span>
          </div>
        </div>
      </div>
      
      <div class="content-card">
        <h3 class="card-title">Recent Activity</h3>
        <div class="card-content">
          <div class="activity-item">
            <span class="activity-icon">📊</span>
            <span class="activity-text">Viewed analytics report</span>
            <span class="activity-time">10 min ago</span>
          </div>
          <div class="activity-item">
            <span class="activity-icon">📝</span>
            <span class="activity-text">Updated profile settings</span>
            <span class="activity-time">1 hour ago</span>
          </div>
          <div class="activity-item">
            <span class="activity-icon">🔐</span>
            <span class="activity-text">Changed password</span>
            <span class="activity-time">2 hours ago</span>
          </div>
        </div>
      </div>
      
      <div class="content-card">
        <h3 class="card-title">Quick Actions</h3>
        <div class="card-content">
          <button class="action-btn" on:click={() => alert('Edit Profile clicked')}>
            ✏️ Edit Profile
          </button>
          <button class="action-btn" on:click={() => alert('Change Password clicked')}>
            🔐 Change Password
          </button>
          <button class="action-btn" on:click={() => alert('Download Data clicked')}>
            📥 Download Data
          </button>
        </div>
      </div>
    </div>
  </main>
  
  <!-- LOW CONTRAST WARNING TEXT - Session timeout warning with insufficient color contrast -->
  {#if isWarningVisible}
    <div class="session-warning">
      <div class="warning-content">
        <div class="warning-icon">⏰</div>
        <div class="warning-text">
          <div class="warning-title">Session Timeout Warning</div>
          <div class="warning-message">
            Your session will expire in {formatTime(sessionTime)}. Please save your work and refresh the page to extend your session.
          </div>
        </div>
        <div class="warning-actions">
          <button class="warning-btn primary" on:click={extendSession}>
            Extend Session
          </button>
          <button class="warning-btn secondary" on:click={logout}>
            Logout Now
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .dashboard {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .page-header {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .page-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
  }
  
  .page-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .content-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .content-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .card-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin: 0 0 20px 0;
  }
  
  .card-content {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }
  
  .info-item:last-child {
    border-bottom: none;
  }
  
  .info-label {
    font-weight: bold;
    color: #333;
  }
  
  .info-value {
    color: #666;
  }
  
  .activity-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }
  
  .activity-item:last-child {
    border-bottom: none;
  }
  
  .activity-icon {
    font-size: 20px;
  }
  
  .activity-text {
    flex: 1;
    color: #333;
  }
  
  .activity-time {
    color: #666;
    font-size: 14px;
  }
  
  .action-btn {
    width: 100%;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
    margin-bottom: 10px;
  }
  
  .action-btn:hover {
    background: #0056b3;
  }
  
  .action-btn:last-child {
    margin-bottom: 0;
  }
  
  .session-warning {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  
  .warning-content {
    background: white;
    border-radius: 12px;
    padding: 30px;
    max-width: 500px;
    width: 90%;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    text-align: center;
  }
  
  .warning-icon {
    font-size: 48px;
    margin-bottom: 20px;
  }
  
  .warning-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
  }
  
  .warning-message {
    font-size: 16px;
    color: #666;
    margin-bottom: 25px;
    line-height: 1.5;
  }
  
  .warning-actions {
    display: flex;
    gap: 15px;
    justify-content: center;
  }
  
  .warning-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: all 0.2s;
  }
  
  .warning-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .warning-btn.primary:hover {
    background: #0056b3;
  }
  
  .warning-btn.secondary {
    background: #6c757d;
    color: white;
  }
  
  .warning-btn.secondary:hover {
    background: #545b62;
  }
</style>

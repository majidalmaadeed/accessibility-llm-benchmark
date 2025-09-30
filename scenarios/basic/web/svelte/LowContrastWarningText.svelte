<script>
  let sessionTime = 1800; // 30 minutes in seconds
  let isWarningVisible = false;
  let isModalOpen = false;
  let timeRemaining = 0;
  let intervalId = null;

  $: minutes = Math.floor(sessionTime / 60);
  $: seconds = sessionTime % 60;

  function startSession() {
    sessionTime = 1800;
    isWarningVisible = false;
    isModalOpen = false;
    
    if (intervalId) {
      clearInterval(intervalId);
    }
    
    intervalId = setInterval(() => {
      sessionTime--;
      if (sessionTime <= 300 && !isWarningVisible) { // 5 minutes warning
        isWarningVisible = true;
      }
      if (sessionTime <= 0) {
        clearInterval(intervalId);
        showTimeoutModal();
      }
    }, 1000);
  }

  function extendSession() {
    sessionTime += 1800; // Add 30 minutes
    isWarningVisible = false;
    isModalOpen = false;
  }

  function logout() {
    clearInterval(intervalId);
    sessionTime = 0;
    isWarningVisible = false;
    isModalOpen = false;
    alert('You have been logged out due to inactivity.');
  }

  function showTimeoutModal() {
    isModalOpen = true;
    timeRemaining = 60; // 1 minute countdown
    
    const countdownInterval = setInterval(() => {
      timeRemaining--;
      if (timeRemaining <= 0) {
        clearInterval(countdownInterval);
        logout();
      }
    }, 1000);
  }

  function formatTime(totalSeconds) {
    const mins = Math.floor(totalSeconds / 60);
    const secs = totalSeconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }

  // Start session on component mount
  startSession();
</script>

<div class="session-manager">
  <header class="app-header">
    <h1>Secure Application</h1>
    <div class="session-info">
      <span class="session-timer">Session: {formatTime(sessionTime)}</span>
      <button on:click={logout} class="logout-btn">Logout</button>
    </div>
  </header>

  <main class="app-content">
    <div class="dashboard">
      <h2>Dashboard</h2>
      <p>Welcome to your secure dashboard. Your session will automatically expire for security reasons.</p>
      
      <div class="dashboard-cards">
        <div class="card">
          <h3>Recent Activity</h3>
          <ul>
            <li>Logged in at 9:30 AM</li>
            <li>Viewed profile at 9:45 AM</li>
            <li>Updated settings at 10:15 AM</li>
          </ul>
        </div>
        
        <div class="card">
          <h3>Security Status</h3>
          <div class="security-indicators">
            <div class="indicator">
              <span class="indicator-label">Two-Factor Auth:</span>
              <span class="indicator-value enabled">Enabled</span>
            </div>
            <div class="indicator">
              <span class="indicator-label">Last Login:</span>
              <span class="indicator-value">Today, 9:30 AM</span>
            </div>
            <div class="indicator">
              <span class="indicator-label">Session Status:</span>
              <span class="indicator-value {sessionTime > 300 ? 'active' : 'warning'}">
                {sessionTime > 300 ? 'Active' : 'Expiring Soon'}
              </span>
            </div>
          </div>
        </div>
        
        <div class="card">
          <h3>Quick Actions</h3>
          <div class="action-buttons">
            <button class="action-btn primary">View Profile</button>
            <button class="action-btn secondary">Settings</button>
            <button class="action-btn secondary">Help</button>
          </div>
        </div>
      </div>
    </div>
  </main>

  <!-- Session Warning Banner -->
  {#if isWarningVisible}
    <div class="session-warning">
      <div class="warning-content">
        <span class="warning-icon">⚠️</span>
        <div class="warning-text">
          <strong>Session Expiring Soon</strong>
          <p>Your session will expire in {formatTime(sessionTime)}. Click "Extend Session" to continue working.</p>
        </div>
        <div class="warning-actions">
          <button on:click={extendSession} class="extend-btn">Extend Session</button>
          <button on:click={logout} class="logout-btn-small">Logout Now</button>
        </div>
      </div>
    </div>
  {/if}

  <!-- Timeout Modal -->
  {#if isModalOpen}
    <div class="modal-overlay">
      <div class="timeout-modal">
        <div class="modal-header">
          <h3>Session Timeout</h3>
        </div>
        <div class="modal-content">
          <p>Your session has expired due to inactivity.</p>
          <p>You will be automatically logged out in {timeRemaining} seconds.</p>
          <div class="countdown-display">
            <div class="countdown-circle">
              <span class="countdown-number">{timeRemaining}</span>
            </div>
          </div>
        </div>
        <div class="modal-actions">
          <button on:click={extendSession} class="extend-btn">Extend Session</button>
          <button on:click={logout} class="logout-btn">Logout Now</button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .session-manager {
    min-height: 100vh;
    background: #f5f5f5;
    font-family: Arial, sans-serif;
  }

  .app-header {
    background: white;
    padding: 15px 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .app-header h1 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .session-info {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .session-timer {
    font-family: monospace;
    font-size: 16px;
    color: #666;
  }

  .logout-btn {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .app-content {
    padding: 30px;
  }

  .dashboard h2 {
    margin: 0 0 20px 0;
    color: #333;
    font-size: 28px;
  }

  .dashboard p {
    color: #666;
    font-size: 16px;
    margin-bottom: 30px;
  }

  .dashboard-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
  }

  .card {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  .card h3 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 18px;
  }

  .card ul {
    margin: 0;
    padding-left: 20px;
    color: #666;
  }

  .card li {
    margin-bottom: 5px;
  }

  .security-indicators {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .indicator {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .indicator-label {
    color: #666;
  }

  .indicator-value {
    font-weight: bold;
  }

  .indicator-value.enabled {
    color: #28a745;
  }

  .indicator-value.active {
    color: #28a745;
  }

  .indicator-value.warning {
    color: #ffc107;
  }

  .action-buttons {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .action-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
  }

  .action-btn.primary {
    background: #007bff;
    color: white;
  }

  .action-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .session-warning {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    background: #fff3cd;
    border-bottom: 1px solid #ffeaa7;
    z-index: 1000;
  }

  .warning-content {
    display: flex;
    align-items: center;
    padding: 15px 30px;
    gap: 15px;
  }

  .warning-icon {
    font-size: 24px;
  }

  .warning-text {
    flex: 1;
  }

  .warning-text strong {
    display: block;
    color: #856404;
    font-size: 16px;
    margin-bottom: 5px;
  }

  .warning-text p {
    margin: 0;
    color: #856404;
    font-size: 14px;
  }

  .warning-actions {
    display: flex;
    gap: 10px;
  }

  .extend-btn {
    background: #28a745;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
  }

  .logout-btn-small {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2000;
  }

  .timeout-modal {
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
    max-width: 400px;
    width: 90%;
  }

  .modal-header {
    padding: 20px 20px 0 20px;
  }

  .modal-header h3 {
    margin: 0;
    color: #333;
    font-size: 20px;
  }

  .modal-content {
    padding: 20px;
    text-align: center;
  }

  .modal-content p {
    margin: 0 0 15px 0;
    color: #666;
  }

  .countdown-display {
    margin: 20px 0;
  }

  .countdown-circle {
    width: 80px;
    height: 80px;
    border: 4px solid #dc3545;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto;
  }

  .countdown-number {
    font-size: 24px;
    font-weight: bold;
    color: #dc3545;
  }

  .modal-actions {
    padding: 0 20px 20px 20px;
    display: flex;
    gap: 10px;
    justify-content: center;
  }
</style>

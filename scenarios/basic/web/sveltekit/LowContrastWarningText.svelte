<script>
  let sessionTimeout = 300; // 5 minutes in seconds
  let timeRemaining = sessionTimeout;
  let isWarning = false;
  let isExpired = false;
  
  function startTimer() {
    const interval = setInterval(() => {
      timeRemaining--;
      
      if (timeRemaining <= 60 && timeRemaining > 0) {
        isWarning = true;
      } else if (timeRemaining <= 0) {
        isExpired = true;
        clearInterval(interval);
      }
    }, 1000);
  }
  
  function extendSession() {
    timeRemaining = sessionTimeout;
    isWarning = false;
    isExpired = false;
  }
  
  function logout() {
    // Handle logout
    console.log('User logged out');
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
  
  // Start timer when component mounts
  startTimer();
</script>

<div class="session-manager">
  <div class="session-status">
    <div class="status-indicator" class:warning={isWarning} class:expired={isExpired}>
      <div class="status-icon">
        {#if isExpired}
          ⚠️
        {:else if isWarning}
          ⏰
        {:else}
          ✅
        {/if}
      </div>
      <div class="status-text">
        {#if isExpired}
          Session Expired
        {:else if isWarning}
          Session Warning
        {:else}
          Session Active
        {/if}
      </div>
    </div>
    
    <div class="time-display">
      <span class="time-label">Time Remaining:</span>
      <span class="time-value" class:warning={isWarning} class:expired={isExpired}>
        {formatTime(timeRemaining)}
      </span>
    </div>
  </div>
  
  {#if isWarning && !isExpired}
    <div class="warning-banner">
      <div class="warning-content">
        <div class="warning-icon">⚠️</div>
        <div class="warning-message">
          <h3 class="warning-title">Session Timeout Warning</h3>
          <p class="warning-text">
            Your session will expire in {formatTime(timeRemaining)}. 
            Please save your work and click "Extend Session" to continue.
          </p>
        </div>
      </div>
      <div class="warning-actions">
        <button class="extend-btn" on:click={extendSession}>
          Extend Session
        </button>
        <button class="logout-btn" on:click={logout}>
          Logout Now
        </button>
      </div>
    </div>
  {/if}
  
  {#if isExpired}
    <div class="expired-banner">
      <div class="expired-content">
        <div class="expired-icon">🔒</div>
        <div class="expired-message">
          <h3 class="expired-title">Session Expired</h3>
          <p class="expired-text">
            Your session has expired due to inactivity. 
            Please log in again to continue.
          </p>
        </div>
      </div>
      <div class="expired-actions">
        <button class="login-btn" on:click={() => window.location.reload()}>
          Login Again
        </button>
      </div>
    </div>
  {/if}
  
  <div class="session-info">
    <div class="info-section">
      <h4 class="info-title">Session Information</h4>
      <div class="info-grid">
        <div class="info-item">
          <span class="info-label">Session ID:</span>
          <span class="info-value">sess_1234567890</span>
        </div>
        <div class="info-item">
          <span class="info-label">Started:</span>
          <span class="info-value">2:30 PM</span>
        </div>
        <div class="info-item">
          <span class="info-label">Last Activity:</span>
          <span class="info-value">2:45 PM</span>
        </div>
        <div class="info-item">
          <span class="info-label">IP Address:</span>
          <span class="info-value">192.168.1.100</span>
        </div>
      </div>
    </div>
    
    <div class="info-section">
      <h4 class="info-title">Security Settings</h4>
      <div class="settings-list">
        <div class="setting-item">
          <input type="checkbox" id="auto-extend" checked />
          <label for="auto-extend">Auto-extend session on activity</label>
        </div>
        <div class="setting-item">
          <input type="checkbox" id="remember-me" />
          <label for="remember-me">Remember me for 30 days</label>
        </div>
        <div class="setting-item">
          <input type="checkbox" id="email-notifications" />
          <label for="email-notifications">Email notifications for session events</label>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .session-manager {
    max-width: 800px;
    margin: 0 auto;
    padding: 30px;
    font-family: Arial, sans-serif;
  }
  
  .session-status {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }
  
  .status-indicator {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .status-icon {
    font-size: 24px;
  }
  
  .status-text {
    font-size: 18px;
    font-weight: bold;
    color: #28a745;
  }
  
  .status-indicator.warning .status-text {
    color: #ffc107;
  }
  
  .status-indicator.expired .status-text {
    color: #dc3545;
  }
  
  .time-display {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
  }
  
  .time-label {
    font-size: 14px;
    color: #666;
  }
  
  .time-value {
    font-size: 24px;
    font-weight: bold;
    color: #28a745;
  }
  
  .time-value.warning {
    color: #ffc107;
  }
  
  .time-value.expired {
    color: #dc3545;
  }
  
  .warning-banner {
    background: #fff3cd;
    border: 1px solid #ffeaa7;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 30px;
  }
  
  .warning-content {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
  }
  
  .warning-icon {
    font-size: 32px;
  }
  
  .warning-title {
    margin: 0 0 10px 0;
    font-size: 20px;
    color: #856404;
  }
  
  .warning-text {
    margin: 0;
    color: #856404;
    line-height: 1.5;
  }
  
  .warning-actions {
    display: flex;
    gap: 15px;
  }
  
  .extend-btn,
  .logout-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .extend-btn {
    background: #28a745;
    color: white;
  }
  
  .extend-btn:hover {
    background: #218838;
  }
  
  .logout-btn {
    background: #6c757d;
    color: white;
  }
  
  .logout-btn:hover {
    background: #545b62;
  }
  
  .expired-banner {
    background: #f8d7da;
    border: 1px solid #f5c6cb;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 30px;
  }
  
  .expired-content {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
  }
  
  .expired-icon {
    font-size: 32px;
  }
  
  .expired-title {
    margin: 0 0 10px 0;
    font-size: 20px;
    color: #721c24;
  }
  
  .expired-text {
    margin: 0;
    color: #721c24;
    line-height: 1.5;
  }
  
  .expired-actions {
    display: flex;
    gap: 15px;
  }
  
  .login-btn {
    padding: 12px 24px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .login-btn:hover {
    background: #0056b3;
  }
  
  .session-info {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
  }
  
  .info-section {
    background: white;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 20px;
  }
  
  .info-title {
    margin: 0 0 20px 0;
    font-size: 18px;
    color: #333;
    border-bottom: 2px solid #007bff;
    padding-bottom: 10px;
  }
  
  .info-grid {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .info-item:last-child {
    border-bottom: none;
  }
  
  .info-label {
    font-weight: bold;
    color: #666;
  }
  
  .info-value {
    color: #333;
    font-family: monospace;
  }
  
  .settings-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .setting-item {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .setting-item input[type="checkbox"] {
    width: 18px;
    height: 18px;
    accent-color: #007bff;
  }
  
  .setting-item label {
    color: #333;
    cursor: pointer;
  }
  
  @media (max-width: 768px) {
    .session-status {
      flex-direction: column;
      gap: 20px;
      text-align: center;
    }
    
    .time-display {
      align-items: center;
    }
    
    .warning-content,
    .expired-content {
      flex-direction: column;
      text-align: center;
    }
    
    .warning-actions,
    .expired-actions {
      justify-content: center;
    }
    
    .session-info {
      grid-template-columns: 1fr;
    }
    
    .info-item {
      flex-direction: column;
      align-items: flex-start;
      gap: 5px;
    }
  }
</style>

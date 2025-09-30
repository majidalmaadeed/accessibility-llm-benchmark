<script>
  import { onMount } from 'svelte';
  let notifications = [];
  let notificationCount = 0;
  function showToast(type, message) {
    notificationCount++;
    const notification = {
      id: notificationCount,
      type: type,
      message: message,
      timestamp: Date.now()
    };
    notifications = [notification, ...notifications];
    // Should implement auto-hide functionality with configurable duration
    // Basic auto-hide (5 seconds)
    setTimeout(() => {
      dismissToast(notification.id);
    }, 5000);
  }
  function dismissToast(id) {
    notifications = notifications.filter(n => n.id !== id);
  }
  function clearAllNotifications() {
    notifications = [];
  }
  function getIconForType(type) {
    const icons = {
      success: '✓',
      error: '✗',
      warning: '⚠',
      info: 'ℹ'
    };
    return icons[type] || '•';
  }
  function getColorForType(type) {
    const colors = {
      success: '#28a745',
      error: '#dc3545',
      warning: '#ffc107',
      info: '#17a2b8'
    };
    return colors[type] || '#666666';
  }
  function getBackgroundColorForType(type) {
    const colors = {
      success: 'rgba(40, 167, 69, 0.1)',
      error: 'rgba(220, 53, 69, 0.1)',
      warning: 'rgba(255, 193, 7, 0.1)',
      info: 'rgba(23, 162, 184, 0.1)'
    };
    return colors[type] || 'rgba(108, 117, 125, 0.1)';
  }
  function getBorderColorForType(type) {
    const colors = {
      success: 'rgba(40, 167, 69, 0.3)',
      error: 'rgba(220, 53, 69, 0.3)',
      warning: 'rgba(255, 193, 7, 0.3)',
      info: 'rgba(23, 162, 184, 0.3)'
    };
    return colors[type] || 'rgba(108, 117, 125, 0.3)';
  }
</script>
    </div>
  </div>
</div>
<!-- Toast Container -->
<div class="toast-container">
  {#each notifications as notification (notification.id)}
    <div 
      class="toast {notification.type}"
      style="
        --toast-color: {getColorForType(notification.type)};
        --toast-bg: {getBackgroundColorForType(notification.type)};
        --toast-border: {getBorderColorForType(notification.type)};
      "
    >
      <div class="toast-icon">{getIconForType(notification.type)}</div>
      <div class="toast-message">{notification.message}</div>
      <button 
        class="toast-dismiss" 
        on:click={() => dismissToast(notification.id)}
      >
        &times;
      </button>
    </div>
  {/each}
</div>
<style>
  .container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
  }
  .card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 30px;
  }
  h1 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
  }
  .description {
    color: #666;
    margin-bottom: 30px;
    font-size: 16px;
  }
  .notification-controls {
    display: flex;
    flex-direction: column;
    gap: 15px;
    margin-bottom: 30px;
  }
  .notification-btn {
    padding: 15px 20px;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    color: white;
  }
  .success-btn {
    background-color: #28a745;
  }
  .success-btn:hover {
    background-color: #218838;
  }
  .error-btn {
    background-color: #dc3545;
  }
  .error-btn:hover {
    background-color: #c82333;
  }
  .warning-btn {
    background-color: #ffc107;
    color: #212529;
  }
  .warning-btn:hover {
    background-color: #e0a800;
  }
  .info-btn {
    background-color: #17a2b8;
  }
  .info-btn:hover {
    background-color: #138496;
  }
  .clear-btn {
    background-color: #6c757d;
  }
  .clear-btn:hover {
    background-color: #5a6268;
  }
  .toast-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .toast {
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    padding: 15px 20px;
    min-width: 300px;
    max-width: 400px;
    display: flex;
    align-items: center;
    gap: 15px;
    animation: slideIn 0.3s ease-out;
    position: relative;
    border-left: 4px solid var(--toast-color);
  }
  .toast-icon {
    font-size: 20px;
    font-weight: bold;
    color: var(--toast-color);
  }
  .toast-message {
    flex: 1;
    font-size: 14px;
    font-weight: 500;
    color: var(--toast-color);
  }
  .toast-dismiss {
    background: none;
    border: none;
    font-size: 18px;
    font-weight: bold;
    color: #666;
    cursor: pointer;
    padding: 0;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    transition: background-color 0.3s;
  }
  .toast-dismiss:hover {
    background-color: rgba(0,0,0,0.1);
  }
  @keyframes slideIn {
    from {
      transform: translateX(100%);
      opacity: 0;
    }
    to {
      transform: translateX(0);
      opacity: 1;
    }
  }
    background-color: #e9ecef;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    padding: 20px;
    margin-top: 30px;
  }
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
  }
    margin-left: 20px;
    margin-bottom: 15px;
  }
    margin-bottom: 5px;
    color: #666;
  }
</style>

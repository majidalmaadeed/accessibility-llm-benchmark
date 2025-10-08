<template>
  <div class="main-container">
    <div class="main-content">
      <h1>Notification System Demo</h1>
      <p>Test different types of notifications and see how they behave.</p>
      
      <div class="demo-section">
        <h3>Trigger Notifications</h3>
        <div class="button-grid">
          <button @click="addNotification('success', 'Operation completed successfully!')" class="btn-success">
            Success Notification
          </button>
          
          <button @click="addNotification('error', 'Something went wrong. Please try again.')" class="btn-error">
            Error Notification
          </button>
          
          <button @click="addNotification('warning', 'Please review your input before proceeding.')" class="btn-warning">
            Warning Notification
          </button>
          
          <button @click="addNotification('info', 'New features are now available in your dashboard.')" class="btn-info">
            Info Notification
          </button>
          
          <button @click="handleLongMessage" class="btn-secondary">
            Long Message
          </button>
          
          <button @click="handleMultipleNotifications" class="btn-purple">
            Multiple Notifications
          </button>
        </div>

        <!-- Notification Display Area -->
        <div class="notifications-section">
          <h3>Active Notifications ({{ notifications.length }})</h3>
          <div v-if="notifications.length === 0" class="no-notifications">
            No active notifications
          </div>
        </div>

        <!-- Notification Settings -->
        <div class="settings-section">
          <h3>Notification Settings</h3>
          <div class="settings-grid">
            <label class="setting-item">
              <input type="checkbox" checked />
              Enable desktop notifications
            </label>
            <label class="setting-item">
              <input type="checkbox" checked />
              Play sound for notifications
            </label>
            <label class="setting-item">
              <input type="checkbox" />
              Show notification count in badge
            </label>
          </div>
        </div>
      </div>
    </div>

    <!-- Notification Display -->
    <div v-if="notifications.length > 0" class="notification-container">
      <div
        v-for="notification in notifications"
        :key="notification.id"
        :class="['notification', `notification-${notification.type}`]"
      >
        <div class="notification-content">
          <span class="notification-icon">{{ getNotificationIcon(notification.type) }}</span>
          <div class="notification-text">
            <div class="notification-title">
              {{ notification.type.charAt(0).toUpperCase() + notification.type.slice(1) }}
            </div>
            <div class="notification-message">{{ notification.message }}</div>
            <div class="notification-timestamp">{{ notification.timestamp.toLocaleTimeString() }}</div>
          </div>
        </div>
        <button @click="removeNotification(notification.id)" class="notification-close">×</button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'ToastNotificationIssues',
  setup() {
    const notifications = ref([])
    const notificationId = ref(1)

    const addNotification = (type, message, duration = 5000) => {
      const id = notificationId.value
      const newNotification = {
        id,
        type,
        message,
        duration,
        timestamp: new Date()
      }

      notifications.value.push(newNotification)
      notificationId.value++

      // Auto-remove notification after duration
      setTimeout(() => {
        removeNotification(id)
      }, duration)
    }

    const removeNotification = (id) => {
      notifications.value = notifications.value.filter(notification => notification.id !== id)
    }

    const getNotificationIcon = (type) => {
      switch (type) {
        case 'success':
          return '✅'
        case 'error':
          return '❌'
        case 'warning':
          return '⚠️'
        case 'info':
          return 'ℹ️'
        default:
          return '📢'
      }
    }

    const handleSuccessAction = () => {
      addNotification('success', 'Operation completed successfully!')
    }

    const handleErrorAction = () => {
      addNotification('error', 'Something went wrong. Please try again.')
    }

    const handleWarningAction = () => {
      addNotification('warning', 'Please review your input before proceeding.')
    }

    const handleInfoAction = () => {
      addNotification('info', 'New features are now available in your dashboard.')
    }

    const handleLongMessage = () => {
      addNotification('info', 'This is a very long notification message that contains multiple sentences and provides detailed information about what happened. It should be properly formatted and readable even when it spans multiple lines.')
    }

    const handleMultipleNotifications = () => {
      addNotification('success', 'First notification')
      setTimeout(() => addNotification('info', 'Second notification'), 200)
      setTimeout(() => addNotification('warning', 'Third notification'), 400)
    }

    return {
      notifications,
      addNotification,
      removeNotification,
      getNotificationIcon,
      handleLongMessage,
      handleMultipleNotifications
    }
  }
}
</script>

<style scoped>
.main-container {
  font-family: Arial, sans-serif;
  max-width: 1000px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.demo-section {
  margin-top: 30px;
}

.button-grid {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 30px;
}

.button-grid button {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}

.btn-success {
  background-color: #28a745;
  color: white;
}

.btn-success:hover {
  background-color: #218838;
}

.btn-error {
  background-color: #dc3545;
  color: white;
}

.btn-error:hover {
  background-color: #c82333;
}

.btn-warning {
  background-color: #ffc107;
  color: #212529;
}

.btn-warning:hover {
  background-color: #e0a800;
}

.btn-info {
  background-color: #17a2b8;
  color: white;
}

.btn-info:hover {
  background-color: #138496;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #5a6268;
}

.btn-purple {
  background-color: #6f42c1;
  color: white;
}

.btn-purple:hover {
  background-color: #5a32a3;
}

.notifications-section {
  margin-top: 20px;
}

.no-notifications {
  color: #666;
  font-style: italic;
}

.settings-section {
  margin-top: 40px;
  padding: 20px;
  background-color: #f8f9fa;
  border-radius: 4px;
}

.settings-grid {
  display: flex;
  gap: 20px;
  align-items: center;
  flex-wrap: wrap;
}

.setting-item {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

.notification-container {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 1000;
  max-height: 80vh;
  overflow-y: auto;
}

.notification {
  padding: 16px 20px;
  border-radius: 8px;
  margin-bottom: 10px;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  max-width: 400px;
  word-wrap: break-word;
}

.notification-success {
  background-color: #d4edda;
  border: 1px solid #c3e6cb;
  color: #155724;
}

.notification-error {
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
  color: #721c24;
}

.notification-warning {
  background-color: #fff3cd;
  border: 1px solid #ffeaa7;
  color: #856404;
}

.notification-info {
  background-color: #d1ecf1;
  border: 1px solid #bee5eb;
  color: #0c5460;
}

.notification-content {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  flex: 1;
}

.notification-icon {
  font-size: 16px;
  margin-top: 2px;
}

.notification-text {
  flex: 1;
}

.notification-title {
  font-weight: bold;
  margin-bottom: 4px;
}

.notification-message {
  font-size: 14px;
  line-height: 1.4;
}

.notification-timestamp {
  font-size: 12px;
  margin-top: 8px;
  opacity: 0.7;
}

.notification-close {
  background: none;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: inherit;
  opacity: 0.7;
  margin-left: 10px;
}

.notification-close:hover {
  opacity: 1;
}
</style>
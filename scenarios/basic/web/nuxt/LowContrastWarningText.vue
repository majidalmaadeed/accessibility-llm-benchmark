<template>
  <div class="user-dashboard">
    <header class="dashboard-header">
      <h1>User Dashboard</h1>
      <div class="user-info">
        <span class="welcome-text">Welcome back, {{ user.name }}!</span>
        <button class="logout-btn" @click="handleLogout">Logout</button>
      </div>
    </header>

    <div class="dashboard-content">
      <div class="alert-section">
        <div class="alert-banner warning">
          <div class="alert-icon">⚠️</div>
          <div class="alert-content">
            <h3>Session Expiring Soon</h3>
            <p>Your session will expire in {{ sessionTimeLeft }} minutes. Please save your work and refresh the page to continue.</p>
            <div class="alert-actions">
              <button class="alert-btn primary" @click="refreshSession">Refresh Session</button>
              <button class="alert-btn secondary" @click="dismissAlert">Dismiss</button>
            </div>
          </div>
        </div>

        <div class="alert-banner error">
          <div class="alert-icon">❌</div>
          <div class="alert-content">
            <h3>Payment Failed</h3>
            <p>Your last payment attempt was unsuccessful. Please update your payment method to continue using our services.</p>
            <div class="alert-actions">
              <button class="alert-btn primary" @click="updatePayment">Update Payment</button>
              <button class="alert-btn secondary" @click="dismissAlert">Later</button>
            </div>
          </div>
        </div>

        <div class="alert-banner info">
          <div class="alert-icon">ℹ️</div>
          <div class="alert-content">
            <h3>System Maintenance</h3>
            <p>We will be performing scheduled maintenance on Sunday from 2:00 AM to 4:00 AM EST. Some features may be temporarily unavailable.</p>
            <div class="alert-actions">
              <button class="alert-btn secondary" @click="dismissAlert">Got it</button>
            </div>
          </div>
        </div>
      </div>

      <div class="dashboard-grid">
        <div class="stats-section">
          <h2>Account Statistics</h2>
          <div class="stats-grid">
            <div class="stat-card">
              <div class="stat-icon">📊</div>
              <div class="stat-content">
                <div class="stat-number">{{ stats.totalOrders }}</div>
                <div class="stat-label">Total Orders</div>
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">💰</div>
              <div class="stat-content">
                <div class="stat-number">${{ stats.totalSpent }}</div>
                <div class="stat-label">Total Spent</div>
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">⭐</div>
              <div class="stat-content">
                <div class="stat-number">{{ stats.loyaltyPoints }}</div>
                <div class="stat-label">Loyalty Points</div>
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">🎁</div>
              <div class="stat-content">
                <div class="stat-number">{{ stats.rewardsEarned }}</div>
                <div class="stat-label">Rewards Earned</div>
              </div>
            </div>
          </div>
        </div>

        <div class="recent-activity">
          <h2>Recent Activity</h2>
          <div class="activity-list">
            <div
              v-for="activity in recentActivities"
              :key="activity.id"
              class="activity-item"
            >
              <div class="activity-icon">
                {{ activity.icon }}
              </div>
              <div class="activity-content">
                <p class="activity-text">{{ activity.text }}</p>
                <span class="activity-time">{{ activity.time }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="actions-grid">
          <button class="action-card" @click="navigateTo('/orders')">
            <div class="action-icon">📦</div>
            <div class="action-text">View Orders</div>
          </button>
          <button class="action-card" @click="navigateTo('/profile')">
            <div class="action-icon">👤</div>
            <div class="action-text">Edit Profile</div>
          </button>
          <button class="action-card" @click="navigateTo('/settings')">
            <div class="action-icon">⚙️</div>
            <div class="action-text">Settings</div>
          </button>
          <button class="action-card" @click="navigateTo('/support')">
            <div class="action-icon">💬</div>
            <div class="action-text">Support</div>
          </button>
        </div>
      </div>

      <div class="notifications-section">
        <h2>Notifications</h2>
        <div class="notifications-list">
          <div
            v-for="notification in notifications"
            :key="notification.id"
            class="notification-item"
            :class="{ unread: !notification.read }"
          >
            <div class="notification-icon">
              {{ notification.icon }}
            </div>
            <div class="notification-content">
              <h4 class="notification-title">{{ notification.title }}</h4>
              <p class="notification-message">{{ notification.message }}</p>
              <span class="notification-time">{{ notification.time }}</span>
            </div>
            <button 
              class="notification-dismiss"
              @click="dismissNotification(notification.id)"
            >
              ✕
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const user = ref({
  name: 'John Doe',
  email: 'john.doe@example.com'
})

const sessionTimeLeft = ref(5)
const sessionTimer = ref(null)

const stats = ref({
  totalOrders: 47,
  totalSpent: 2847.50,
  loyaltyPoints: 1250,
  rewardsEarned: 8
})

const recentActivities = ref([
  {
    id: 1,
    icon: '🛒',
    text: 'Order #12345 was delivered successfully',
    time: '2 hours ago'
  },
  {
    id: 2,
    icon: '💳',
    text: 'Payment of $89.99 was processed',
    time: '1 day ago'
  },
  {
    id: 3,
    icon: '⭐',
    text: 'You earned 50 loyalty points',
    time: '2 days ago'
  },
  {
    id: 4,
    icon: '📧',
    text: 'Password was updated successfully',
    time: '3 days ago'
  }
])

const notifications = ref([
  {
    id: 1,
    icon: '⚠️',
    title: 'Session Warning',
    message: 'Your session will expire soon. Please refresh to continue.',
    time: '5 minutes ago',
    read: false
  },
  {
    id: 2,
    icon: '💳',
    title: 'Payment Failed',
    message: 'Your payment method needs to be updated.',
    time: '1 hour ago',
    read: false
  },
  {
    id: 3,
    icon: '🎉',
    title: 'Welcome Bonus',
    message: 'You have received a 10% discount code!',
    time: '2 hours ago',
    read: true
  },
  {
    id: 4,
    icon: '📦',
    title: 'Order Shipped',
    message: 'Your order #12345 has been shipped.',
    time: '1 day ago',
    read: true
  }
])

const handleLogout = () => {
  alert('Logging out...')
}

const refreshSession = () => {
  sessionTimeLeft.value = 30
  alert('Session refreshed! You have 30 minutes remaining.')
}

const dismissAlert = () => {
  alert('Alert dismissed')
}

const updatePayment = () => {
  alert('Redirecting to payment settings...')
}

const dismissNotification = (id) => {
  const index = notifications.value.findIndex(n => n.id === id)
  if (index !== -1) {
    notifications.value.splice(index, 1)
  }
}

const navigateTo = (path) => {
  alert(`Navigating to ${path}`)
}

const startSessionTimer = () => {
  sessionTimer.value = setInterval(() => {
    if (sessionTimeLeft.value > 0) {
      sessionTimeLeft.value--
    } else {
      alert('Session expired! Please refresh the page.')
      clearInterval(sessionTimer.value)
    }
  }, 60000)
}

onMounted(() => {
  startSessionTimer()
})

onUnmounted(() => {
  if (sessionTimer.value) {
    clearInterval(sessionTimer.value)
  }
})
</script>

<style scoped>
.user-dashboard {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.dashboard-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 2px solid #e9ecef;
}

.dashboard-header h1 {
  margin: 0;
  font-size: 32px;
  color: #333;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 20px;
}

.welcome-text {
  font-size: 16px;
  color: #666;
}

.logout-btn {
  padding: 8px 16px;
  background: #dc3545;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.logout-btn:hover {
  background: #c82333;
}

.dashboard-content {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.alert-section {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.alert-banner {
  display: flex;
  gap: 15px;
  padding: 20px;
  border-radius: 8px;
  border-left: 4px solid;
}

.alert-banner.warning {
  background: #fff3cd;
  border-left-color: #ffc107;
  color: #856404;
}

.alert-banner.error {
  background: #f8d7da;
  border-left-color: #dc3545;
  color: #721c24;
}

.alert-banner.info {
  background: #d1ecf1;
  border-left-color: #17a2b8;
  color: #0c5460;
}

.alert-icon {
  font-size: 24px;
  flex-shrink: 0;
}

.alert-content {
  flex: 1;
}

.alert-content h3 {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
}

.alert-content p {
  margin: 0 0 15px 0;
  line-height: 1.5;
}

.alert-actions {
  display: flex;
  gap: 10px;
}

.alert-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.2s ease;
}

.alert-btn.primary {
  background: #007bff;
  color: white;
}

.alert-btn.primary:hover {
  background: #0056b3;
}

.alert-btn.secondary {
  background: #6c757d;
  color: white;
}

.alert-btn.secondary:hover {
  background: #545b62;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 30px;
}

.stats-section h2,
.recent-activity h2,
.quick-actions h2,
.notifications-section h2 {
  margin: 0 0 20px 0;
  font-size: 24px;
  color: #333;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.stat-card {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  gap: 15px;
}

.stat-icon {
  font-size: 32px;
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

.activity-list {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
}

.activity-item {
  display: flex;
  gap: 15px;
  padding: 15px 20px;
  border-bottom: 1px solid #eee;
}

.activity-item:last-child {
  border-bottom: none;
}

.activity-icon {
  font-size: 20px;
  flex-shrink: 0;
}

.activity-content {
  flex: 1;
}

.activity-text {
  margin: 0 0 5px 0;
  color: #333;
  line-height: 1.4;
}

.activity-time {
  font-size: 12px;
  color: #666;
}

.quick-actions {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 20px;
}

.action-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 20px;
  background: #f8f9fa;
  border: 1px solid #ddd;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-card:hover {
  background: #e9ecef;
  border-color: #007bff;
  transform: translateY(-2px);
}

.action-icon {
  font-size: 32px;
}

.action-text {
  font-size: 14px;
  font-weight: bold;
  color: #333;
  text-align: center;
}

.notifications-section {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.notifications-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.notification-item {
  display: flex;
  gap: 15px;
  padding: 15px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
  transition: all 0.2s ease;
}

.notification-item.unread {
  background: #e3f2fd;
  border-color: #2196f3;
}

.notification-icon {
  font-size: 20px;
  flex-shrink: 0;
}

.notification-content {
  flex: 1;
}

.notification-title {
  margin: 0 0 5px 0;
  font-size: 16px;
  color: #333;
}

.notification-message {
  margin: 0 0 5px 0;
  color: #666;
  line-height: 1.4;
}

.notification-time {
  font-size: 12px;
  color: #999;
}

.notification-dismiss {
  background: none;
  border: none;
  color: #999;
  cursor: pointer;
  font-size: 16px;
  padding: 5px;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.notification-dismiss:hover {
  background: #dc3545;
  color: white;
}

@media (max-width: 768px) {
  .dashboard-header {
    flex-direction: column;
    gap: 15px;
    align-items: flex-start;
  }

  .dashboard-grid {
    grid-template-columns: 1fr;
  }

  .stats-grid {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  }

  .actions-grid {
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  }

  .alert-banner {
    flex-direction: column;
    gap: 10px;
  }

  .alert-actions {
    flex-direction: column;
  }
}
</style>

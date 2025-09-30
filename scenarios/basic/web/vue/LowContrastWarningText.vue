<template>
  <div class="user-dashboard">
    <h1>User Dashboard</h1>
    <p>Welcome to your account dashboard.</p>
    
    <div class="account-info">
      <h2>Account Information</h2>
      <p><strong>Username:</strong> john.doe@example.com</p>
      <p><strong>Last Login:</strong> Today at 2:30 PM</p>
      <p><strong>Status:</strong> Active</p>
    </div>

    <!-- Session timeout warning with insufficient color contrast -->
    <div v-if="showWarning" class="session-warning">
      <strong>Session Timeout Warning:</strong> Your session will expire in 2 minutes due to inactivity. 
      Please save your work and refresh the page to continue.
    </div>

    <div class="recent-activity">
      <h2>Recent Activity</h2>
      <ul>
        <li>Updated profile information</li>
        <li>Changed password</li>
        <li>Downloaded monthly report</li>
      </ul>
    </div>

    <div class="action-buttons">
      <button class="btn-primary">View Profile</button>
      <button class="btn-secondary">Settings</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LowContrastWarningText',
  data() {
    return {
      showWarning: false
    }
  },
  mounted() {
    // Show warning after 5 seconds for demo
    setTimeout(() => {
      this.showWarning = true
    }, 5000)
  }
}
</script>

<style scoped>
.user-dashboard {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.account-info {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.account-info h2 {
  margin: 0 0 15px 0;
}

.session-warning {
  background: #f8f9fa;
  color: #6c757d;
  padding: 15px;
  border-radius: 4px;
  border: 1px solid #dee2e6;
  margin-bottom: 20px;
  font-size: 14px;
}

.recent-activity {
  background: #e3f2fd;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.recent-activity h2 {
  margin: 0 0 15px 0;
}

.recent-activity ul {
  margin: 0;
  padding-left: 20px;
}

.action-buttons {
  display: flex;
  gap: 10px;
  justify-content: center;
}

.btn-primary {
  background: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.btn-secondary {
  background: #6c757d;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}
</style>

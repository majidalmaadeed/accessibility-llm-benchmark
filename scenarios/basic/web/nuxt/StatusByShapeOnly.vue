<template>
  <div class="document-management-system">
    <header class="system-header">
      <div class="header-content">
        <h1 class="system-title">Document Management System</h1>
        <div class="user-info">
          <span class="user-name">John Smith</span>
          <span class="user-role">Project Manager</span>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="content-header">
        <h2 class="page-title">Document Approval Dashboard</h2>
        <div class="page-actions">
          <button class="action-btn primary">Upload Document</button>
          <button class="action-btn secondary">Export Report</button>
          <button class="action-btn secondary">Filter Documents</button>
        </div>
      </div>

      <div class="dashboard-grid">
        <div class="stats-cards">
          <div class="stat-card">
            <div class="stat-icon pending">●</div>
            <div class="stat-content">
              <div class="stat-number">24</div>
              <div class="stat-label">Pending Review</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon approved">●</div>
            <div class="stat-content">
              <div class="stat-number">156</div>
              <div class="stat-label">Approved</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon rejected">●</div>
            <div class="stat-content">
              <div class="stat-number">8</div>
              <div class="stat-label">Rejected</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon draft">●</div>
            <div class="stat-content">
              <div class="stat-number">12</div>
              <div class="stat-label">Draft</div>
            </div>
          </div>
        </div>

        <div class="documents-section">
          <div class="section-header">
            <h3 class="section-title">Recent Documents</h3>
            <div class="view-controls">
              <button class="view-btn active">List View</button>
              <button class="view-btn">Grid View</button>
              <button class="view-btn">Timeline</button>
            </div>
          </div>

          <div class="documents-list">
            <div
              v-for="document in documents"
              :key="document.id"
              class="document-item"
            >
              <div class="document-info">
                <div class="document-icon">
                  <img :src="document.icon" :alt="document.type" />
                </div>
                <div class="document-details">
                  <h4 class="document-title">{{ document.title }}</h4>
                  <div class="document-meta">
                    <span class="document-type">{{ document.type }}</span>
                    <span class="document-size">{{ document.size }}</span>
                    <span class="document-date">{{ document.date }}</span>
                    <span class="document-author">by {{ document.author }}</span>
                  </div>
                  <div class="document-description">{{ document.description }}</div>
                </div>
              </div>
              <div class="document-status">
                <div class="status-indicator" :class="document.status">
                  <div class="status-shape"></div>
                </div>
                <div class="status-actions">
                  <button class="status-btn" @click="viewDocument(document.id)">View</button>
                  <button class="status-btn" @click="downloadDocument(document.id)">Download</button>
                  <button class="status-btn" @click="shareDocument(document.id)">Share</button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="approval-workflow">
          <h3 class="section-title">Approval Workflow</h3>
          <div class="workflow-steps">
            <div
              v-for="(step, index) in workflowSteps"
              :key="step.id"
              class="workflow-step"
              :class="{ active: step.active, completed: step.completed }"
            >
              <div class="step-indicator">
                <div class="step-shape" :class="step.status"></div>
              </div>
              <div class="step-content">
                <h4 class="step-title">{{ step.title }}</h4>
                <p class="step-description">{{ step.description }}</p>
                <div class="step-meta">
                  <span class="step-assignee">{{ step.assignee }}</span>
                  <span class="step-deadline">{{ step.deadline }}</span>
                </div>
              </div>
              <div class="step-actions">
                <button class="step-btn approve" v-if="step.canApprove">Approve</button>
                <button class="step-btn reject" v-if="step.canReject">Reject</button>
                <button class="step-btn comment" v-if="step.canComment">Comment</button>
              </div>
            </div>
          </div>
        </div>

        <div class="notifications-panel">
          <h3 class="section-title">Notifications</h3>
          <div class="notifications-list">
            <div
              v-for="notification in notifications"
              :key="notification.id"
              class="notification-item"
            >
              <div class="notification-icon">
                <div class="notification-shape" :class="notification.type"></div>
              </div>
              <div class="notification-content">
                <h4 class="notification-title">{{ notification.title }}</h4>
                <p class="notification-message">{{ notification.message }}</p>
                <div class="notification-meta">
                  <span class="notification-time">{{ notification.time }}</span>
                  <span class="notification-priority" :class="notification.priority">
                    {{ notification.priority }}
                  </span>
                </div>
              </div>
              <div class="notification-actions">
                <button class="notification-btn">Mark Read</button>
                <button class="notification-btn">Dismiss</button>
              </div>
            </div>
          </div>
        </div>

        <div class="recent-activity">
          <h3 class="section-title">Recent Activity</h3>
          <div class="activity-timeline">
            <div
              v-for="activity in recentActivity"
              :key="activity.id"
              class="activity-item"
            >
              <div class="activity-indicator">
                <div class="activity-shape" :class="activity.action"></div>
              </div>
              <div class="activity-content">
                <h4 class="activity-title">{{ activity.title }}</h4>
                <p class="activity-description">{{ activity.description }}</p>
                <div class="activity-meta">
                  <span class="activity-user">{{ activity.user }}</span>
                  <span class="activity-time">{{ activity.time }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="quick-actions">
          <h3 class="section-title">Quick Actions</h3>
          <div class="actions-grid">
            <button class="quick-action-btn">
              <div class="action-icon upload">●</div>
              <span class="action-label">Upload Document</span>
            </button>
            <button class="quick-action-btn">
              <div class="action-icon create">●</div>
              <span class="action-label">Create Template</span>
            </button>
            <button class="quick-action-btn">
              <div class="action-icon review">●</div>
              <span class="action-label">Review Queue</span>
            </button>
            <button class="quick-action-btn">
              <div class="action-icon report">●</div>
              <span class="action-label">Generate Report</span>
            </button>
            <button class="quick-action-btn">
              <div class="action-icon settings">●</div>
              <span class="action-label">Settings</span>
            </button>
            <button class="quick-action-btn">
              <div class="action-icon help">●</div>
              <span class="action-label">Help & Support</span>
            </button>
          </div>
        </div>
      </div>

      <div class="bulk-actions">
        <div class="bulk-controls">
          <label class="bulk-checkbox">
            <input type="checkbox" v-model="selectAll" @change="toggleSelectAll" />
            <span class="checkbox-label">Select All Documents</span>
          </label>
          <div class="bulk-buttons">
            <button class="bulk-btn approve" :disabled="!hasSelection">Approve Selected</button>
            <button class="bulk-btn reject" :disabled="!hasSelection">Reject Selected</button>
            <button class="bulk-btn download" :disabled="!hasSelection">Download Selected</button>
            <button class="bulk-btn archive" :disabled="!hasSelection">Archive Selected</button>
          </div>
        </div>
      </div>
    </main>

    <footer class="system-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Document Management</h4>
          <ul class="footer-links">
            <li><a href="/documents">All Documents</a></li>
            <li><a href="/templates">Templates</a></li>
            <li><a href="/archives">Archives</a></li>
            <li><a href="/reports">Reports</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Workflow</h4>
          <ul class="footer-links">
            <li><a href="/approvals">Approvals</a></li>
            <li><a href="/reviews">Reviews</a></li>
            <li><a href="/notifications">Notifications</a></li>
            <li><a href="/settings">Settings</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Support</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact Support</a></li>
            <li><a href="/training">Training</a></li>
            <li><a href="/feedback">Feedback</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Document Management System. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const selectAll = ref(false)
const selectedDocuments = ref([])

const hasSelection = computed(() => selectedDocuments.value.length > 0)

const documents = ref([
  {
    id: 1,
    title: 'Q4 Financial Report',
    type: 'PDF',
    size: '2.4 MB',
    date: '2024-01-15',
    author: 'Sarah Johnson',
    description: 'Comprehensive financial analysis for Q4 2023 including revenue, expenses, and profit margins.',
    status: 'pending',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 2,
    title: 'Project Proposal Template',
    type: 'DOCX',
    size: '1.8 MB',
    date: '2024-01-14',
    author: 'Mike Chen',
    description: 'Standard template for new project proposals with sections for objectives, timeline, and budget.',
    status: 'approved',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 3,
    title: 'Security Audit Report',
    type: 'PDF',
    size: '3.2 MB',
    date: '2024-01-13',
    author: 'Alex Rodriguez',
    description: 'Detailed security assessment findings and recommendations for system improvements.',
    status: 'rejected',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 4,
    title: 'Meeting Minutes - Board Meeting',
    type: 'DOCX',
    size: '856 KB',
    date: '2024-01-12',
    author: 'Emma Davis',
    description: 'Official minutes from the quarterly board meeting covering strategic decisions and action items.',
    status: 'draft',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 5,
    title: 'Employee Handbook 2024',
    type: 'PDF',
    size: '4.1 MB',
    date: '2024-01-11',
    author: 'HR Department',
    description: 'Updated employee handbook with new policies, procedures, and company guidelines.',
    status: 'approved',
    icon: '/api/placeholder/40/40'
  }
])

const workflowSteps = ref([
  {
    id: 1,
    title: 'Initial Review',
    description: 'Document submitted for initial review and validation',
    assignee: 'Sarah Johnson',
    deadline: '2024-01-20',
    status: 'pending',
    active: true,
    completed: false,
    canApprove: true,
    canReject: true,
    canComment: true
  },
  {
    id: 2,
    title: 'Department Approval',
    description: 'Department head review and approval required',
    assignee: 'Mike Chen',
    deadline: '2024-01-22',
    status: 'pending',
    active: false,
    completed: false,
    canApprove: false,
    canReject: false,
    canComment: true
  },
  {
    id: 3,
    title: 'Final Approval',
    description: 'Executive approval for final processing',
    assignee: 'Alex Rodriguez',
    deadline: '2024-01-25',
    status: 'pending',
    active: false,
    completed: false,
    canApprove: false,
    canReject: false,
    canComment: true
  }
])

const notifications = ref([
  {
    id: 1,
    title: 'Document Approved',
    message: 'Q4 Financial Report has been approved by Sarah Johnson',
    time: '2 hours ago',
    type: 'success',
    priority: 'High'
  },
  {
    id: 2,
    title: 'Review Required',
    message: 'Project Proposal Template needs your review',
    time: '4 hours ago',
    type: 'warning',
    priority: 'Medium'
  },
  {
    id: 3,
    title: 'Document Rejected',
    message: 'Security Audit Report was rejected due to incomplete data',
    time: '1 day ago',
    type: 'error',
    priority: 'High'
  }
])

const recentActivity = ref([
  {
    id: 1,
    title: 'Document Uploaded',
    description: 'New document "Q4 Financial Report" uploaded by Sarah Johnson',
    user: 'Sarah Johnson',
    time: '2 hours ago',
    action: 'upload'
  },
  {
    id: 2,
    title: 'Document Approved',
    description: 'Project Proposal Template approved by Mike Chen',
    user: 'Mike Chen',
    time: '4 hours ago',
    action: 'approve'
  },
  {
    id: 3,
    title: 'Comment Added',
    description: 'New comment added to Security Audit Report',
    user: 'Alex Rodriguez',
    time: '6 hours ago',
    action: 'comment'
  }
])

const toggleSelectAll = () => {
  if (selectAll.value) {
    selectedDocuments.value = documents.value.map(doc => doc.id)
  } else {
    selectedDocuments.value = []
  }
}

const viewDocument = (id) => {
  console.log('Viewing document:', id)
}

const downloadDocument = (id) => {
  console.log('Downloading document:', id)
}

const shareDocument = (id) => {
  console.log('Sharing document:', id)
}
</script>

<style scoped>
.document-management-system {
  font-family: Arial, sans-serif;
  background: #f5f7fa;
  min-height: 100vh;
}

.system-header {
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

.system-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.user-info {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.user-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 2px;
}

.user-role {
  font-size: 14px;
  color: #666;
}

.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 30px 20px;
}

.content-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.page-title {
  margin: 0;
  font-size: 28px;
  color: #333;
}

.page-actions {
  display: flex;
  gap: 15px;
}

.action-btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn.primary {
  background: #007bff;
  color: white;
}

.action-btn.primary:hover {
  background: #0056b3;
}

.action-btn.secondary {
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.action-btn.secondary:hover {
  background: #e9ecef;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 20px;
  margin-bottom: 30px;
}

.stats-cards {
  grid-column: 1 / -1;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 20px;
}

.stat-card {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  font-size: 40px;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.stat-icon.pending {
  background: #fff3cd;
  color: #856404;
}

.stat-icon.approved {
  background: #d4edda;
  color: #155724;
}

.stat-icon.rejected {
  background: #f8d7da;
  color: #721c24;
}

.stat-icon.draft {
  background: #e2e3e5;
  color: #383d41;
}

.stat-number {
  font-size: 32px;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.stat-label {
  color: #666;
  font-size: 14px;
}

.documents-section {
  grid-column: 1 / 9;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  overflow: hidden;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 25px;
  border-bottom: 1px solid #eee;
}

.section-title {
  margin: 0;
  font-size: 20px;
  color: #333;
}

.view-controls {
  display: flex;
  gap: 5px;
}

.view-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  cursor: pointer;
  transition: all 0.2s ease;
}

.view-btn.active {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.documents-list {
  max-height: 600px;
  overflow-y: auto;
}

.document-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 25px;
  border-bottom: 1px solid #f0f0f0;
  transition: background-color 0.2s ease;
}

.document-item:hover {
  background: #f8f9fa;
}

.document-info {
  display: flex;
  align-items: center;
  gap: 20px;
  flex: 1;
}

.document-icon img {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.document-details {
  flex: 1;
}

.document-title {
  margin: 0 0 10px 0;
  font-size: 18px;
  color: #333;
}

.document-meta {
  display: flex;
  gap: 20px;
  margin-bottom: 8px;
  font-size: 14px;
  color: #666;
}

.document-description {
  color: #666;
  font-size: 14px;
  line-height: 1.4;
}

.document-status {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 15px;
}

.status-indicator {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.status-shape {
  width: 20px;
  height: 20px;
  border-radius: 50%;
}

.status-indicator.pending .status-shape {
  background: #ffc107;
}

.status-indicator.approved .status-shape {
  background: #28a745;
}

.status-indicator.rejected .status-shape {
  background: #dc3545;
}

.status-indicator.draft .status-shape {
  background: #6c757d;
}

.status-actions {
  display: flex;
  gap: 10px;
}

.status-btn {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  transition: all 0.2s ease;
}

.status-btn:hover {
  background: #f8f9fa;
}

.approval-workflow {
  grid-column: 9 / -1;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: 25px;
}

.workflow-steps {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.workflow-step {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 20px;
  border-radius: 8px;
  border: 1px solid #eee;
  transition: all 0.2s ease;
}

.workflow-step.active {
  border-color: #007bff;
  background: #f8f9ff;
}

.workflow-step.completed {
  border-color: #28a745;
  background: #f8fff9;
}

.step-indicator {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #f8f9fa;
}

.step-shape {
  width: 16px;
  height: 16px;
  border-radius: 50%;
}

.step-shape.pending {
  background: #ffc107;
}

.step-shape.approved {
  background: #28a745;
}

.step-shape.rejected {
  background: #dc3545;
}

.step-content {
  flex: 1;
}

.step-title {
  margin: 0 0 8px 0;
  font-size: 16px;
  color: #333;
}

.step-description {
  margin: 0 0 10px 0;
  color: #666;
  font-size: 14px;
}

.step-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
}

.step-actions {
  display: flex;
  gap: 8px;
}

.step-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.step-btn.approve {
  background: #28a745;
  color: white;
}

.step-btn.reject {
  background: #dc3545;
  color: white;
}

.step-btn.comment {
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.notifications-panel {
  grid-column: 1 / 5;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: 25px;
}

.notifications-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.notification-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 15px;
  border-radius: 6px;
  border: 1px solid #eee;
  transition: background-color 0.2s ease;
}

.notification-item:hover {
  background: #f8f9fa;
}

.notification-icon {
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #f8f9fa;
}

.notification-shape {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.notification-shape.success {
  background: #28a745;
}

.notification-shape.warning {
  background: #ffc107;
}

.notification-shape.error {
  background: #dc3545;
}

.notification-content {
  flex: 1;
}

.notification-title {
  margin: 0 0 5px 0;
  font-size: 14px;
  color: #333;
}

.notification-message {
  margin: 0 0 8px 0;
  color: #666;
  font-size: 12px;
}

.notification-meta {
  display: flex;
  gap: 10px;
  font-size: 11px;
}

.notification-priority {
  padding: 2px 6px;
  border-radius: 10px;
  font-weight: bold;
}

.notification-priority.High {
  background: #f8d7da;
  color: #721c24;
}

.notification-priority.Medium {
  background: #fff3cd;
  color: #856404;
}

.notification-actions {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.notification-btn {
  padding: 4px 8px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 3px;
  cursor: pointer;
  font-size: 10px;
  transition: all 0.2s ease;
}

.notification-btn:hover {
  background: #f8f9fa;
}

.recent-activity {
  grid-column: 5 / 9;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: 25px;
}

.activity-timeline {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.activity-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 15px;
  border-radius: 6px;
  border: 1px solid #eee;
  transition: background-color 0.2s ease;
}

.activity-item:hover {
  background: #f8f9fa;
}

.activity-indicator {
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #f8f9fa;
}

.activity-shape {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.activity-shape.upload {
  background: #007bff;
}

.activity-shape.approve {
  background: #28a745;
}

.activity-shape.comment {
  background: #ffc107;
}

.activity-content {
  flex: 1;
}

.activity-title {
  margin: 0 0 5px 0;
  font-size: 14px;
  color: #333;
}

.activity-description {
  margin: 0 0 8px 0;
  color: #666;
  font-size: 12px;
}

.activity-meta {
  display: flex;
  gap: 10px;
  font-size: 11px;
  color: #999;
}

.quick-actions {
  grid-column: 9 / -1;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: 25px;
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}

.quick-action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 20px;
  border: 1px solid #eee;
  background: white;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.quick-action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
}

.action-icon {
  font-size: 24px;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.action-icon.upload {
  background: #e3f2fd;
  color: #1976d2;
}

.action-icon.create {
  background: #f3e5f5;
  color: #7b1fa2;
}

.action-icon.review {
  background: #fff3e0;
  color: #f57c00;
}

.action-icon.report {
  background: #e8f5e8;
  color: #388e3c;
}

.action-icon.settings {
  background: #fce4ec;
  color: #c2185b;
}

.action-icon.help {
  background: #f1f8e9;
  color: #689f38;
}

.action-label {
  font-size: 12px;
  color: #333;
  font-weight: bold;
  text-align: center;
}

.bulk-actions {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.bulk-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.bulk-checkbox {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.checkbox-label {
  font-weight: bold;
  color: #333;
}

.bulk-buttons {
  display: flex;
  gap: 10px;
}

.bulk-btn {
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.bulk-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.bulk-btn.approve {
  background: #28a745;
  color: white;
}

.bulk-btn.reject {
  background: #dc3545;
  color: white;
}

.bulk-btn.download {
  background: #007bff;
  color: white;
}

.bulk-btn.archive {
  background: #6c757d;
  color: white;
}

.system-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 40px;
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
  margin: 0 0 15px 0;
  font-size: 16px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 8px;
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

@media (max-width: 1200px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  
  .documents-section,
  .approval-workflow,
  .notifications-panel,
  .recent-activity,
  .quick-actions {
    grid-column: 1 / -1;
  }
}

@media (max-width: 768px) {
  .content-header {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }

  .page-actions {
    flex-wrap: wrap;
    justify-content: center;
  }

  .document-item {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }

  .document-info {
    flex-direction: column;
    text-align: center;
  }

  .workflow-step {
    flex-direction: column;
    text-align: center;
  }

  .bulk-controls {
    flex-direction: column;
    gap: 15px;
  }

  .bulk-buttons {
    flex-wrap: wrap;
    justify-content: center;
  }
}
</style>

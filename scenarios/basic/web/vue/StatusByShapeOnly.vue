<template>
  <div class="document-management">
    <h1>Document Management System</h1>
    <p>Review and manage document approval status across your organization.</p>
    
    <div class="stats-section">
      <h2>Document Status Overview</h2>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon approved">●</div>
          <div class="stat-number">{{ approvedCount }}</div>
          <div class="stat-label">Approved</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon pending">■</div>
          <div class="stat-number">{{ pendingCount }}</div>
          <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon rejected">▲</div>
          <div class="stat-number">{{ rejectedCount }}</div>
          <div class="stat-label">Rejected</div>
        </div>
      </div>
    </div>

    <div class="table-container">
      <div class="table-header">
        <h2>Document List</h2>
        <p>Document approval status indicated by shape only</p>
      </div>
      
      <div class="table-content">
        <div class="document-list">
          <div 
            v-for="document in documents" 
            :key="document.id"
            class="document-item"
          >
            <!-- Document approval status indicated only by circle vs square shape -->
            <div class="status-indicator" :class="document.status">
              {{ getStatusIcon(document.status) }}
            </div>
            
            <div class="document-info">
              <h3>{{ document.name }}</h3>
              <p>Last modified: {{ document.lastModified }}</p>
            </div>
            
            <div class="document-actions">
              <button class="action-btn view">View</button>
              <button class="action-btn download">Download</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'StatusByShapeOnly',
  data() {
    return {
      documents: [
        { id: 1, name: 'Project Proposal.docx', status: 'approved', lastModified: '2024-01-15' },
        { id: 2, name: 'Budget Report.xlsx', status: 'pending', lastModified: '2024-01-14' },
        { id: 3, name: 'Meeting Notes.pdf', status: 'rejected', lastModified: '2024-01-13' },
        { id: 4, name: 'Contract Agreement.pdf', status: 'approved', lastModified: '2024-01-12' },
        { id: 5, name: 'Invoice Template.docx', status: 'pending', lastModified: '2024-01-11' }
      ]
    }
  },
  computed: {
    approvedCount() {
      return this.documents.filter(doc => doc.status === 'approved').length
    },
    pendingCount() {
      return this.documents.filter(doc => doc.status === 'pending').length
    },
    rejectedCount() {
      return this.documents.filter(doc => doc.status === 'rejected').length
    }
  },
  methods: {
    getStatusIcon(status) {
      switch (status) {
        case 'approved':
          return '●' // Circle
        case 'pending':
          return '■' // Square
        case 'rejected':
          return '▲' // Triangle
        default:
          return '●'
      }
    }
  }
}
</script>

<style scoped>
.document-management {
  max-width: 1000px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.stats-section {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 30px;
}

.stats-section h2 {
  margin: 0 0 15px 0;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-top: 15px;
}

.stat-card {
  background: white;
  padding: 15px;
  border-radius: 4px;
  text-align: center;
  border: 1px solid #e0e0e0;
}

.stat-icon {
  font-size: 24px;
  margin-bottom: 5px;
}

.stat-icon.approved {
  color: #4caf50;
}

.stat-icon.pending {
  color: #ff9800;
}

.stat-icon.rejected {
  color: #f44336;
}

.stat-number {
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

.table-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
  border: 1px solid #e0e0e0;
}

.table-header {
  background: #f8f9fa;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.table-header h2 {
  margin: 0;
  font-size: 20px;
}

.table-header p {
  margin: 5px 0 0 0;
  color: #666;
  font-size: 14px;
}

.table-content {
  padding: 20px;
}

.document-list {
  display: grid;
  gap: 15px;
}

.document-item {
  display: flex;
  align-items: center;
  padding: 15px;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  background: #fafafa;
}

.status-indicator {
  font-size: 24px;
  margin-right: 15px;
  min-width: 30px;
  text-align: center;
}

.status-indicator.approved {
  color: #4caf50;
}

.status-indicator.pending {
  color: #ff9800;
}

.status-indicator.rejected {
  color: #f44336;
}

.document-info {
  flex: 1;
}

.document-info h3 {
  margin: 0 0 5px 0;
  font-size: 16px;
  color: #333;
}

.document-info p {
  margin: 0;
  font-size: 14px;
  color: #666;
}

.document-actions {
  display: flex;
  gap: 10px;
  align-items: center;
}

.action-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.action-btn.view {
  background: #007bff;
  color: white;
}

.action-btn.download {
  background: #6c757d;
  color: white;
}
</style>

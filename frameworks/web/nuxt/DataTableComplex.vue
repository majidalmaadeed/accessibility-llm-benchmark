<template>
  <div class="data-table-container">
    <div class="table-header">
      <h2>Project Management Dashboard</h2>
      <div class="header-actions">
        <button 
          @click="showFilters = !showFilters"
          class="filter-toggle"
        >
          {{ showFilters ? 'Hide' : 'Show' }} Filters
        </button>
        <button 
          @click="handleExport('csv')"
          :disabled="isLoading"
          class="export-btn"
        >
          {{ isLoading ? 'Exporting...' : 'Export CSV' }}
        </button>
        <button 
          @click="handleExport('pdf')"
          :disabled="isLoading"
          class="export-btn"
        >
          {{ isLoading ? 'Exporting...' : 'Export PDF' }}
        </button>
      </div>
    </div>

    <div v-if="showFilters" class="filters-panel">
      <div class="filter-row">
        <div class="filter-group">
          <input
            v-model="filters.name"
            type="text"
            placeholder="Search by name..."
            class="filter-input"
          />
        </div>
        <div class="filter-group">
          <select v-model="filters.category" class="filter-select">
            <option value="">All Categories</option>
            <option v-for="category in categories" :key="category" :value="category">
              {{ category }}
            </option>
          </select>
        </div>
        <div class="filter-group">
          <select v-model="filters.status" class="filter-select">
            <option value="">All Statuses</option>
            <option v-for="status in statuses" :key="status" :value="status">
              {{ status }}
            </option>
          </select>
        </div>
        <div class="filter-group">
          <select v-model="filters.dateRange" class="filter-select">
            <option value="">All Time</option>
            <option value="7">Last 7 days</option>
            <option value="30">Last 30 days</option>
            <option value="90">Last 90 days</option>
          </select>
        </div>
      </div>
    </div>

    <div v-if="selectedRows.length > 0" class="bulk-actions">
      <span class="selected-count">
        {{ selectedRows.length }} item{{ selectedRows.length !== 1 ? 's' : '' }} selected
      </span>
      <div class="bulk-buttons">
        <button @click="handleBulkAction('Delete')" class="bulk-btn">
          Delete
        </button>
        <button @click="handleBulkAction('Archive')" class="bulk-btn">
          Archive
        </button>
        <button @click="handleBulkAction('Export')" class="bulk-btn">
          Export Selected
        </button>
      </div>
    </div>

    <div class="table-wrapper">
      <table class="data-table">
        <thead>
          <tr>
            <th class="checkbox-column">
              <input
                type="checkbox"
                :checked="selectedRows.length === paginatedData.length && paginatedData.length > 0"
                @change="handleSelectAll"
              />
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('name')"
            >
              Project Name
              <span v-if="sortConfig.key === 'name'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('category')"
            >
              Category
              <span v-if="sortConfig.key === 'category'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('status')"
            >
              Status
              <span v-if="sortConfig.key === 'status'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('priority')"
            >
              Priority
              <span v-if="sortConfig.key === 'priority'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('assignee')"
            >
              Assignee
              <span v-if="sortConfig.key === 'assignee'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('startDate')"
            >
              Start Date
              <span v-if="sortConfig.key === 'startDate'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th 
              class="sortable-header"
              @click="handleSort('progress')"
            >
              Progress
              <span v-if="sortConfig.key === 'progress'" class="sort-indicator">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th class="actions-column">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="item in paginatedData"
            :key="item.id"
            class="table-row"
            :class="{ 'selected-row': selectedRows.includes(item.id) }"
          >
            <td class="checkbox-column">
              <input
                type="checkbox"
                :checked="selectedRows.includes(item.id)"
                @change="handleSelectRow(item.id)"
              />
            </td>
            <td class="name-cell">
              <div class="project-name">{{ item.name }}</div>
              <div class="project-id">ID: {{ item.id }}</div>
            </td>
            <td class="category-cell">
              <span class="category-tag">{{ item.category }}</span>
            </td>
            <td class="status-cell">
              <span 
                class="status-badge"
                :style="{ backgroundColor: getStatusColor(item.status) }"
              >
                {{ item.status }}
              </span>
            </td>
            <td class="priority-cell">
              <span 
                class="priority-badge"
                :style="{ backgroundColor: getPriorityColor(item.priority) }"
              >
                {{ item.priority }}
              </span>
            </td>
            <td class="assignee-cell">
              <div class="assignee-info">
                <div class="assignee-name">{{ item.assignee }}</div>
              </div>
            </td>
            <td class="date-cell">
              <div class="date-info">
                <div class="start-date">{{ item.startDate }}</div>
                <div class="end-date">End: {{ item.endDate }}</div>
              </div>
            </td>
            <td class="progress-cell">
              <div class="progress-container">
                <div class="progress-bar">
                  <div 
                    class="progress-fill"
                    :style="{ width: item.progress + '%' }"
                  />
                </div>
                <span class="progress-text">{{ item.progress }}%</span>
              </div>
            </td>
            <td class="actions-cell">
              <div class="action-buttons">
                <button class="action-btn">Edit</button>
                <button class="action-btn">View</button>
                <button class="action-btn">Delete</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="table-footer">
      <div class="pagination-info">
        Showing {{ startIndex + 1 }} to {{ Math.min(startIndex + itemsPerPage, filteredData.length) }} of {{ filteredData.length }} entries
      </div>
      <div class="pagination">
        <button 
          @click="currentPage = Math.max(1, currentPage - 1)"
          :disabled="currentPage === 1"
          class="pagination-btn"
        >
          Previous
        </button>
        <button
          v-for="i in totalPages"
          :key="i"
          @click="currentPage = i"
          class="pagination-btn"
          :class="{ 'active-page': currentPage === i }"
        >
          {{ i }}
        </button>
        <button 
          @click="currentPage = Math.min(totalPages, currentPage + 1)"
          :disabled="currentPage === totalPages"
          class="pagination-btn"
        >
          Next
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DataTableComplex',
  data() {
    return {
      data: [],
      filteredData: [],
      sortConfig: { key: null, direction: 'asc' },
      filters: {
        name: '',
        category: '',
        status: '',
        dateRange: ''
      },
      selectedRows: [],
      currentPage: 1,
      itemsPerPage: 10,
      showFilters: false,
      isLoading: false,
      sampleData: [
        { id: 1, name: 'Project Alpha', category: 'Development', status: 'Active', priority: 'High', assignee: 'John Doe', startDate: '2024-01-15', endDate: '2024-03-15', progress: 75 },
        { id: 2, name: 'Project Beta', category: 'Design', status: 'Planning', priority: 'Medium', assignee: 'Jane Smith', startDate: '2024-02-01', endDate: '2024-04-01', progress: 25 },
        { id: 3, name: 'Project Gamma', category: 'Testing', status: 'Completed', priority: 'Low', assignee: 'Mike Johnson', startDate: '2024-01-01', endDate: '2024-01-31', progress: 100 },
        { id: 4, name: 'Project Delta', category: 'Development', status: 'Active', priority: 'High', assignee: 'Sarah Wilson', startDate: '2024-02-15', endDate: '2024-05-15', progress: 50 },
        { id: 5, name: 'Project Epsilon', category: 'Research', status: 'Planning', priority: 'Medium', assignee: 'David Brown', startDate: '2024-03-01', endDate: '2024-06-01', progress: 10 },
        { id: 6, name: 'Project Zeta', category: 'Development', status: 'On Hold', priority: 'Low', assignee: 'Lisa Davis', startDate: '2024-01-20', endDate: '2024-04-20', progress: 30 },
        { id: 7, name: 'Project Eta', category: 'Design', status: 'Active', priority: 'High', assignee: 'Tom Wilson', startDate: '2024-02-10', endDate: '2024-04-10', progress: 60 },
        { id: 8, name: 'Project Theta', category: 'Testing', status: 'Completed', priority: 'Medium', assignee: 'Anna Taylor', startDate: '2024-01-05', endDate: '2024-02-05', progress: 100 },
        { id: 9, name: 'Project Iota', category: 'Research', status: 'Planning', priority: 'High', assignee: 'Chris Lee', startDate: '2024-03-15', endDate: '2024-07-15', progress: 5 },
        { id: 10, name: 'Project Kappa', category: 'Development', status: 'Active', priority: 'Medium', assignee: 'Emma Garcia', startDate: '2024-02-20', endDate: '2024-05-20', progress: 40 }
      ]
    }
  },
  computed: {
    totalPages() {
      return Math.ceil(this.filteredData.length / this.itemsPerPage)
    },
    startIndex() {
      return (this.currentPage - 1) * this.itemsPerPage
    },
    paginatedData() {
      return this.filteredData.slice(this.startIndex, this.startIndex + this.itemsPerPage)
    },
    categories() {
      return [...new Set(this.data.map(item => item.category))]
    },
    statuses() {
      return [...new Set(this.data.map(item => item.status))]
    }
  },
  watch: {
    filters: {
      handler() {
        this.applyFilters()
      },
      deep: true
    }
  },
  mounted() {
    this.data = this.sampleData
    this.filteredData = this.sampleData
  },
  methods: {
    applyFilters() {
      let filtered = [...this.data]

      if (this.filters.name) {
        filtered = filtered.filter(item => 
          item.name.toLowerCase().includes(this.filters.name.toLowerCase())
        )
      }

      if (this.filters.category) {
        filtered = filtered.filter(item => item.category === this.filters.category)
      }

      if (this.filters.status) {
        filtered = filtered.filter(item => item.status === this.filters.status)
      }

      if (this.filters.dateRange) {
        const today = new Date()
        const days = parseInt(this.filters.dateRange)
        const cutoffDate = new Date(today.getTime() - (days * 24 * 60 * 60 * 1000))
        
        filtered = filtered.filter(item => {
          const startDate = new Date(item.startDate)
          return startDate >= cutoffDate
        })
      }

      this.filteredData = filtered
      this.currentPage = 1
    },
    handleSort(key) {
      let direction = 'asc'
      if (this.sortConfig.key === key && this.sortConfig.direction === 'asc') {
        direction = 'desc'
      }
      this.sortConfig = { key, direction }

      const sorted = [...this.filteredData].sort((a, b) => {
        if (a[key] < b[key]) {
          return direction === 'asc' ? -1 : 1
        }
        if (a[key] > b[key]) {
          return direction === 'asc' ? 1 : -1
        }
        return 0
      })

      this.filteredData = sorted
    },
    handleSelectRow(id) {
      if (this.selectedRows.includes(id)) {
        this.selectedRows = this.selectedRows.filter(rowId => rowId !== id)
      } else {
        this.selectedRows = [...this.selectedRows, id]
      }
    },
    handleSelectAll() {
      if (this.selectedRows.length === this.paginatedData.length) {
        this.selectedRows = []
      } else {
        this.selectedRows = this.paginatedData.map(item => item.id)
      }
    },
    handleBulkAction(action) {
      if (this.selectedRows.length === 0) return

      this.isLoading = true
      setTimeout(() => {
        console.log(`Bulk action: ${action} on rows:`, this.selectedRows)
        this.selectedRows = []
        this.isLoading = false
        alert(`Bulk action "${action}" completed for ${this.selectedRows.length} items`)
      }, 1000)
    },
    handleExport(format) {
      this.isLoading = true
      setTimeout(() => {
        console.log(`Exporting data as ${format}:`, this.filteredData)
        this.isLoading = false
        alert(`Data exported as ${format.toUpperCase()} successfully!`)
      }, 1500)
    },
    getStatusColor(status) {
      switch (status) {
        case 'Active': return '#4caf50'
        case 'Planning': return '#ff9800'
        case 'Completed': return '#2196f3'
        case 'On Hold': return '#f44336'
        default: return '#666'
      }
    },
    getPriorityColor(priority) {
      switch (priority) {
        case 'High': return '#f44336'
        case 'Medium': return '#ff9800'
        case 'Low': return '#4caf50'
        default: return '#666'
      }
    }
  }
}
</script>

<style scoped>
.data-table-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.table-header h2 {
  margin: 0;
  color: #333;
  font-size: 24px;
}

.header-actions {
  display: flex;
  gap: 10px;
  align-items: center;
}

.filter-toggle {
  padding: 8px 16px;
  background: #f5f5f5;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: all 0.3s ease;
}

.filter-toggle:hover {
  background: #e0e0e0;
  border-color: #4caf50;
}

.export-btn {
  padding: 8px 16px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.export-btn:hover:not(:disabled) {
  background: #45a049;
}

.export-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.filters-panel {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
}

.filter-row {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: 15px;
  align-items: end;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.filter-input,
.filter-select {
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s ease;
}

.filter-input:focus,
.filter-select:focus {
  outline: none;
  border-color: #4caf50;
}

.bulk-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  background: #e3f2fd;
  border: 1px solid #2196f3;
  border-radius: 6px;
  margin-bottom: 20px;
}

.selected-count {
  font-weight: 600;
  color: #1976d2;
}

.bulk-buttons {
  display: flex;
  gap: 10px;
}

.bulk-btn {
  padding: 6px 12px;
  background: white;
  border: 1px solid #2196f3;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  color: #1976d2;
  transition: all 0.3s ease;
}

.bulk-btn:hover {
  background: #2196f3;
  color: white;
}

.table-wrapper {
  overflow-x: auto;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 20px;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
}

.data-table th {
  background: #f8f9fa;
  padding: 15px 12px;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 2px solid #e0e0e0;
  font-size: 14px;
}

.sortable-header {
  cursor: pointer;
  user-select: none;
  transition: background-color 0.3s ease;
  position: relative;
}

.sortable-header:hover {
  background: #e9ecef;
}

.sort-indicator {
  margin-left: 8px;
  color: #4caf50;
  font-weight: bold;
}

.checkbox-column {
  width: 50px;
  text-align: center;
}

.actions-column {
  width: 150px;
  text-align: center;
}

.table-row {
  transition: background-color 0.3s ease;
}

.table-row:hover {
  background: #f8f9fa;
}

.selected-row {
  background: #e3f2fd;
}

.table-row td {
  padding: 12px;
  border-bottom: 1px solid #f0f0f0;
  font-size: 14px;
  vertical-align: middle;
}

.name-cell {
  min-width: 200px;
}

.project-name {
  font-weight: 600;
  color: #333;
  margin-bottom: 2px;
}

.project-id {
  font-size: 11px;
  color: #666;
}

.category-cell {
  min-width: 120px;
}

.category-tag {
  display: inline-block;
  padding: 4px 8px;
  background: #e9ecef;
  color: #495057;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.status-cell {
  min-width: 100px;
}

.status-badge {
  display: inline-block;
  padding: 4px 8px;
  color: white;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.priority-cell {
  min-width: 80px;
}

.priority-badge {
  display: inline-block;
  padding: 4px 8px;
  color: white;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.assignee-cell {
  min-width: 150px;
}

.assignee-name {
  font-weight: 500;
  color: #333;
}

.date-cell {
  min-width: 120px;
}

.start-date {
  font-weight: 500;
  color: #333;
  margin-bottom: 2px;
}

.end-date {
  font-size: 11px;
  color: #666;
}

.progress-cell {
  min-width: 120px;
}

.progress-container {
  display: flex;
  align-items: center;
  gap: 8px;
}

.progress-bar {
  flex: 1;
  height: 8px;
  background: #e0e0e0;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #4caf50, #8bc34a);
  transition: width 0.3s ease;
}

.progress-text {
  font-size: 11px;
  color: #666;
  font-weight: 600;
  min-width: 35px;
}

.actions-cell {
  text-align: center;
}

.action-buttons {
  display: flex;
  gap: 4px;
  justify-content: center;
}

.action-btn {
  padding: 4px 8px;
  background: #f5f5f5;
  border: 1px solid #ddd;
  border-radius: 3px;
  cursor: pointer;
  font-size: 11px;
  color: #666;
  transition: all 0.3s ease;
}

.action-btn:hover {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.table-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 0;
  border-top: 1px solid #e0e0e0;
}

.pagination-info {
  font-size: 14px;
  color: #666;
}

.pagination {
  display: flex;
  gap: 5px;
  align-items: center;
}

.pagination-btn {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  color: #333;
  transition: all 0.3s ease;
}

.pagination-btn:hover:not(:disabled) {
  background: #f5f5f5;
  border-color: #4caf50;
}

.pagination-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.active-page {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

@media (max-width: 1200px) {
  .filter-row {
    grid-template-columns: 1fr 1fr;
    gap: 10px;
  }
}

@media (max-width: 768px) {
  .data-table-container {
    padding: 15px;
  }
  
  .table-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .header-actions {
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .filter-row {
    grid-template-columns: 1fr;
    gap: 10px;
  }
  
  .bulk-actions {
    flex-direction: column;
    gap: 10px;
    align-items: stretch;
  }
  
  .bulk-buttons {
    justify-content: center;
  }
  
  .table-footer {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .pagination {
    justify-content: center;
  }
  
  .action-buttons {
    flex-direction: column;
    gap: 2px;
  }
}

@media (max-width: 480px) {
  .data-table-container {
    padding: 10px;
  }
  
  .table-wrapper {
    font-size: 12px;
  }
  
  .data-table th,
  .table-row td {
    padding: 8px 6px;
  }
  
  .pagination-btn {
    padding: 6px 8px;
    font-size: 12px;
  }
}
</style>

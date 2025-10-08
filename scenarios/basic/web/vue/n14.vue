<template>
  <div class="employee-directory">
    <h1>Employee Directory</h1>
    <p>View and manage employee information across all departments.</p>
    
    <div class="stats-section">
      <h2>Department Statistics</h2>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number">5</div>
          <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">4</div>
          <div class="stat-label">Departments</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">$73,600</div>
          <div class="stat-label">Average Salary</div>
        </div>
      </div>
    </div>

    <div class="table-container">
      <div class="table-header">
        <h2>Employee List</h2>
        <p>Click on column headers to sort the data</p>
      </div>
      
      <div class="table-wrapper">
        <table class="employee-table">
          <tbody>
            <!-- Using td elements instead of th for column headers -->
            <tr class="header-row">
              <td 
                v-for="header in headers" 
                :key="header.key"
                @click="handleSort(header.key)"
                class="sortable-header"
              >
                {{ header.label }} {{ sortField === header.key && (sortDirection === 'asc' ? '↑' : '↓') }}
              </td>
            </tr>
            <tr 
              v-for="(employee, index) in sortedEmployees" 
              :key="employee.id"
              :class="['data-row', { 'even': index % 2 === 0 }]"
            >
              <td>{{ employee.name }}</td>
              <td>
                <span class="department-badge">{{ employee.department }}</span>
              </td>
              <td>{{ employee.position }}</td>
              <td>${{ employee.salary.toLocaleString() }}</td>
              <td>
                <span class="status-badge">{{ employee.status }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MissingTableHeader',
  data() {
    return {
      employees: [
        { id: 1, name: 'John Smith', department: 'Engineering', position: 'Senior Developer', salary: 95000, status: 'Active' },
        { id: 2, name: 'Sarah Johnson', department: 'Marketing', position: 'Marketing Manager', salary: 78000, status: 'Active' },
        { id: 3, name: 'Mike Wilson', department: 'Sales', position: 'Sales Representative', salary: 65000, status: 'Active' },
        { id: 4, name: 'Emily Davis', department: 'HR', position: 'HR Specialist', salary: 60000, status: 'Active' },
        { id: 5, name: 'David Brown', department: 'Finance', position: 'Financial Analyst', salary: 70000, status: 'Active' }
      ],
      sortField: null,
      sortDirection: 'asc',
      headers: [
        { key: 'name', label: 'Name' },
        { key: 'department', label: 'Department' },
        { key: 'position', label: 'Position' },
        { key: 'salary', label: 'Salary' },
        { key: 'status', label: 'Status' }
      ]
    }
  },
  computed: {
    sortedEmployees() {
      if (!this.sortField) return this.employees
      
      return [...this.employees].sort((a, b) => {
        const aValue = a[this.sortField]
        const bValue = b[this.sortField]
        
        if (typeof aValue === 'string') {
          return this.sortDirection === 'asc' 
            ? aValue.localeCompare(bValue)
            : bValue.localeCompare(aValue)
        }
        
        return this.sortDirection === 'asc' ? aValue - bValue : bValue - aValue
      })
    }
  },
  methods: {
    handleSort(field) {
      if (this.sortField === field) {
        this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc'
      } else {
        this.sortField = field
        this.sortDirection = 'asc'
      }
    }
  }
}
</script>

<style scoped>
.employee-directory {
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

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 5px;
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

.table-wrapper {
  overflow-x: auto;
}

.employee-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}

.header-row {
  background: #e9ecef;
  border-bottom: 2px solid #dee2e6;
}

.sortable-header {
  padding: 12px 16px;
  font-weight: bold;
  cursor: pointer;
  user-select: none;
  border-right: 1px solid #dee2e6;
}

.data-row {
  border-bottom: 1px solid #e0e0e0;
}

.data-row.even {
  background: #f8f9fa;
}

.data-row td {
  padding: 12px 16px;
  border-right: 1px solid #e0e0e0;
}

.department-badge {
  background: #e3f2fd;
  color: #1976d2;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: bold;
}

.status-badge {
  background: #e8f5e8;
  color: #2e7d32;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: bold;
}
</style>

<template>
  <div class="data-table-container">
    <div class="table-header">
      <h2>Employee Management System</h2>
      <div class="bulk-actions">
        <button 
          @click="handleBulkAction('export')"
          :disabled="selectedRows.length === 0"
        >
          Export Selected
        </button>
        <button 
          @click="handleBulkAction('delete')"
          :disabled="selectedRows.length === 0"
          class="delete-btn"
        >
          Delete Selected
        </button>
      </div>
    </div>

    <div class="filters">
      <input
        type="text"
        placeholder="Search employees..."
        v-model="filters.search"
      />
      
      <select v-model="filters.department">
        <option value="">All Departments</option>
        <option v-for="dept in departments" :key="dept" :value="dept">{{ dept }}</option>
      </select>

      <select v-model="filters.status">
        <option value="">All Status</option>
        <option value="active">Active</option>
        <option value="inactive">Inactive</option>
      </select>
    </div>

    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>
              <input
                type="checkbox"
                :checked="selectedRows.length === paginatedEmployees.length && paginatedEmployees.length > 0"
                @change="handleSelectAll"
              />
            </th>
            <th @click="handleSort('name')">
              Name
              <span v-if="sortConfig.key === 'name'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th @click="handleSort('department')">
              Department
              <span v-if="sortConfig.key === 'department'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th @click="handleSort('position')">
              Position
              <span v-if="sortConfig.key === 'position'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th @click="handleSort('salary')">
              Salary
              <span v-if="sortConfig.key === 'salary'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th @click="handleSort('status')">
              Status
              <span v-if="sortConfig.key === 'status'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th @click="handleSort('startDate')">
              Start Date
              <span v-if="sortConfig.key === 'startDate'">
                {{ sortConfig.direction === 'asc' ? '↑' : '↓' }}
              </span>
            </th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="employee in paginatedEmployees" 
            :key="employee.id" 
            :class="{ selected: selectedRows.includes(employee.id) }"
          >
            <td>
              <input
                type="checkbox"
                :checked="selectedRows.includes(employee.id)"
                @change="handleSelectRow(employee.id)"
              />
            </td>
            <td>{{ employee.name }}</td>
            <td>{{ employee.department }}</td>
            <td>{{ employee.position }}</td>
            <td>${{ employee.salary.toLocaleString() }}</td>
            <td>
              <span :class="`status ${employee.status}`">
                {{ employee.status === 'active' ? '●' : '○' }}
              </span>
            </td>
            <td>{{ formatDate(employee.startDate) }}</td>
            <td>
              <button @click="editEmployee(employee.id)">Edit</button>
              <button @click="deleteEmployee(employee.id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination">
      <button 
        @click="currentPage = Math.max(1, currentPage - 1)"
        :disabled="currentPage === 1"
      >
        Previous
      </button>
      
      <span>
        Page {{ currentPage }} of {{ totalPages }} 
        ({{ filteredAndSortedEmployees.length }} total employees)
      </span>
      
      <button 
        @click="currentPage = Math.min(totalPages, currentPage + 1)"
        :disabled="currentPage === totalPages"
      >
        Next
      </button>
    </div>

    <div v-if="selectedRows.length > 0" class="selection-info">
      {{ selectedRows.length }} employee(s) selected
    </div>
  </div>
</template>

<script>
export default {
  name: 'DataTableComplex',
  data() {
    return {
      employees: [
        { id: 1, name: 'John Doe', department: 'Engineering', position: 'Senior Developer', salary: 95000, status: 'active', startDate: '2022-01-15' },
        { id: 2, name: 'Jane Smith', department: 'Marketing', position: 'Marketing Manager', salary: 78000, status: 'active', startDate: '2021-08-20' },
        { id: 3, name: 'Mike Johnson', department: 'Sales', position: 'Sales Representative', salary: 65000, status: 'inactive', startDate: '2023-03-10' },
        { id: 4, name: 'Sarah Wilson', department: 'HR', position: 'HR Specialist', salary: 72000, status: 'active', startDate: '2022-11-05' },
        { id: 5, name: 'David Brown', department: 'Engineering', position: 'Junior Developer', salary: 68000, status: 'active', startDate: '2023-06-01' },
        { id: 6, name: 'Lisa Davis', department: 'Finance', position: 'Financial Analyst', salary: 82000, status: 'active', startDate: '2021-12-15' },
        { id: 7, name: 'Tom Anderson', department: 'Sales', position: 'Sales Manager', salary: 88000, status: 'active', startDate: '2020-09-30' },
        { id: 8, name: 'Emma Taylor', department: 'Engineering', position: 'DevOps Engineer', salary: 92000, status: 'active', startDate: '2022-04-12' }
      ],
      sortConfig: { key: null, direction: 'asc' },
      filters: {
        department: '',
        status: '',
        search: ''
      },
      selectedRows: [],
      currentPage: 1,
      itemsPerPage: 5
    }
  },
  computed: {
    departments() {
      return [...new Set(this.employees.map(emp => emp.department))];
    },
    filteredAndSortedEmployees() {
      let filtered = this.employees.filter(emp => {
        const matchesDepartment = !this.filters.department || emp.department === this.filters.department;
        const matchesStatus = !this.filters.status || emp.status === this.filters.status;
        const matchesSearch = !this.filters.search || 
          emp.name.toLowerCase().includes(this.filters.search.toLowerCase()) ||
          emp.position.toLowerCase().includes(this.filters.search.toLowerCase());
        
        return matchesDepartment && matchesStatus && matchesSearch;
      });

      if (this.sortConfig.key) {
        filtered.sort((a, b) => {
          if (a[this.sortConfig.key] < b[this.sortConfig.key]) {
            return this.sortConfig.direction === 'asc' ? -1 : 1;
          }
          if (a[this.sortConfig.key] > b[this.sortConfig.key]) {
            return this.sortConfig.direction === 'asc' ? 1 : -1;
          }
          return 0;
        });
      }

      return filtered;
    },
    totalPages() {
      return Math.ceil(this.filteredAndSortedEmployees.length / this.itemsPerPage);
    },
    paginatedEmployees() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage;
      return this.filteredAndSortedEmployees.slice(startIndex, startIndex + this.itemsPerPage);
    }
  },
  methods: {
    handleSort(key) {
      this.sortConfig = {
        key,
        direction: this.sortConfig.key === key && this.sortConfig.direction === 'asc' ? 'desc' : 'asc'
      };
    },
    handleSelectRow(id) {
      if (this.selectedRows.includes(id)) {
        this.selectedRows = this.selectedRows.filter(rowId => rowId !== id);
      } else {
        this.selectedRows.push(id);
      }
    },
    handleSelectAll() {
      if (this.selectedRows.length === this.paginatedEmployees.length) {
        this.selectedRows = [];
      } else {
        this.selectedRows = this.paginatedEmployees.map(emp => emp.id);
      }
    },
    handleBulkAction(action) {
      if (this.selectedRows.length === 0) return;
      
      switch (action) {
        case 'delete':
          this.employees = this.employees.filter(emp => !this.selectedRows.includes(emp.id));
          this.selectedRows = [];
          break;
        case 'export':
          const selectedEmployees = this.employees.filter(emp => this.selectedRows.includes(emp.id));
          console.log('Exporting:', selectedEmployees);
          break;
      }
    },
    editEmployee(id) {
      console.log('Edit', id);
    },
    deleteEmployee(id) {
      console.log('Delete', id);
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString();
    }
  }
}
</script>

<style scoped>
.data-table-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.table-header h2 {
  margin: 0;
  color: #333;
  font-size: 24px;
}

.bulk-actions {
  display: flex;
  gap: 10px;
}

.bulk-actions button {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
}

.bulk-actions button:hover:not(:disabled) {
  background: #f5f5f5;
}

.bulk-actions button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.delete-btn {
  background: #ff4444 !important;
  color: white !important;
  border-color: #ff4444 !important;
}

.delete-btn:hover:not(:disabled) {
  background: #cc3333 !important;
}

.filters {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 6px;
}

.filters input,
.filters select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.filters input {
  flex: 1;
  min-width: 200px;
}

.table-wrapper {
  overflow-x: auto;
  border: 1px solid #ddd;
  border-radius: 6px;
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  background: white;
}

thead {
  background: #f8f9fa;
}

th {
  padding: 12px 8px;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 2px solid #ddd;
  cursor: pointer;
  user-select: none;
  position: relative;
}

th:hover {
  background: #e9ecef;
}

th span {
  margin-left: 5px;
  font-size: 12px;
  color: #666;
}

td {
  padding: 10px 8px;
  border-bottom: 1px solid #eee;
  vertical-align: middle;
}

tr:hover {
  background: #f8f9fa;
}

tr.selected {
  background: #e3f2fd;
}

tr.selected:hover {
  background: #bbdefb;
}

.status {
  font-size: 16px;
  margin-right: 5px;
}

.status.active {
  color: #4caf50;
}

.status.inactive {
  color: #f44336;
}

td button {
  padding: 4px 8px;
  margin: 0 2px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 3px;
  font-size: 12px;
}

td button:hover {
  background: #f5f5f5;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
}

.pagination button {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
}

.pagination button:hover:not(:disabled) {
  background: #f5f5f5;
}

.pagination button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination span {
  color: #666;
  font-size: 14px;
}

.selection-info {
  text-align: center;
  padding: 10px;
  background: #e3f2fd;
  color: #1976d2;
  border-radius: 4px;
  font-weight: 500;
}

@media (max-width: 768px) {
  .table-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .bulk-actions {
    justify-content: center;
  }
  
  .filters {
    flex-direction: column;
  }
  
  .filters input {
    min-width: auto;
  }
  
  .pagination {
    flex-direction: column;
    gap: 10px;
  }
}
</style>

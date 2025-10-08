<script>
  import { onMount } from 'svelte';
  
  let employees = [
    { id: 1, name: 'John Doe', department: 'Engineering', salary: 75000, startDate: '2020-01-15' },
    { id: 2, name: 'Jane Smith', department: 'Marketing', salary: 65000, startDate: '2019-03-22' },
    { id: 3, name: 'Mike Johnson', department: 'Sales', salary: 70000, startDate: '2021-06-10' },
    { id: 4, name: 'Sarah Wilson', department: 'Engineering', salary: 80000, startDate: '2018-09-05' },
    { id: 5, name: 'David Brown', department: 'HR', salary: 60000, startDate: '2022-02-14' },
    { id: 6, name: 'Lisa Davis', department: 'Marketing', salary: 68000, startDate: '2020-11-30' },
    { id: 7, name: 'Tom Anderson', department: 'Sales', salary: 72000, startDate: '2019-08-18' },
    { id: 8, name: 'Amy Taylor', department: 'Engineering', salary: 85000, startDate: '2017-12-03' }
  ];
  
  let sortField = 'name';
  let sortDirection = 'asc';
  let filteredEmployees = [...employees];
  
  function sortTable(field) {
    if (sortField === field) {
      sortDirection = sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      sortField = field;
      sortDirection = 'asc';
    }
    
    filteredEmployees.sort((a, b) => {
      let aVal = a[field];
      let bVal = b[field];
      
      if (typeof aVal === 'string') {
        aVal = aVal.toLowerCase();
        bVal = bVal.toLowerCase();
      }
      
      if (sortDirection === 'asc') {
        return aVal > bVal ? 1 : -1;
      } else {
        return aVal < bVal ? 1 : -1;
      }
    });
  }
  
  function filterByDepartment(department) {
    if (department === 'all') {
      filteredEmployees = [...employees];
    } else {
      filteredEmployees = employees.filter(emp => emp.department === department);
    }
  }
  
  function getDepartments() {
    return [...new Set(employees.map(emp => emp.department))];
  }
  
  function formatSalary(salary) {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0
    }).format(salary);
  }
  
  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }
</script>

<div class="employee-dashboard">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Employee Management</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Add Employee clicked')}>
          ➕ Add Employee
        </button>
        <button class="header-btn" on:click={() => alert('Export clicked')}>
          📊 Export
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Employee Directory</h2>
      <p class="page-subtitle">Manage and view employee information</p>
    </div>
    
    <div class="controls">
      <div class="filter-group">
        <label for="departmentFilter" class="filter-label">Filter by Department:</label>
        <select id="departmentFilter" class="filter-select" on:change={(e) => filterByDepartment(e.target.value)}>
          <option value="all">All Departments</option>
          {#each getDepartments() as dept}
            <option value={dept}>{dept}</option>
          {/each}
        </select>
      </div>
      
      <div class="stats">
        <div class="stat-item">
          <span class="stat-label">Total Employees:</span>
          <span class="stat-value">{filteredEmployees.length}</span>
        </div>
        <div class="stat-item">
          <span class="stat-label">Average Salary:</span>
          <span class="stat-value">
            {formatSalary(filteredEmployees.reduce((sum, emp) => sum + emp.salary, 0) / filteredEmployees.length)}
          </span>
        </div>
      </div>
    </div>
    
    <div class="table-container">
      
      <table class="employee-table">
        <thead>
          <tr class="table-row">
            
            <td class="table-cell header-cell" on:click={() => sortTable('name')}>
              <div class="header-content">
                <span>Name</span>
                <span class="sort-indicator">
                  {sortField === 'name' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕️'}
                </span>
              </div>
            </td>
            <td class="table-cell header-cell" on:click={() => sortTable('department')}>
              <div class="header-content">
                <span>Department</span>
                <span class="sort-indicator">
                  {sortField === 'department' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕️'}
                </span>
              </div>
            </td>
            <td class="table-cell header-cell" on:click={() => sortTable('salary')}>
              <div class="header-content">
                <span>Salary</span>
                <span class="sort-indicator">
                  {sortField === 'salary' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕️'}
                </span>
              </div>
            </td>
            <td class="table-cell header-cell" on:click={() => sortTable('startDate')}>
              <div class="header-content">
                <span>Start Date</span>
                <span class="sort-indicator">
                  {sortField === 'startDate' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕️'}
                </span>
              </div>
            </td>
            <td class="table-cell header-cell">
              <div class="header-content">
                <span>Actions</span>
                <span class="sort-indicator"></span>
              </div>
            </td>
          </tr>
        </thead>
        <tbody>
          {#each filteredEmployees as employee}
            <tr class="table-row">
              <td class="table-cell">
                <div class="employee-info">
                  <div class="employee-avatar">👤</div>
                  <div class="employee-details">
                    <div class="employee-name">{employee.name}</div>
                    <div class="employee-id">ID: {employee.id}</div>
                  </div>
                </div>
              </td>
              <td class="table-cell">
                <span class="department-badge department-{employee.department.toLowerCase()}">
                  {employee.department}
                </span>
              </td>
              <td class="table-cell">
                <span class="salary-amount">{formatSalary(employee.salary)}</span>
              </td>
              <td class="table-cell">
                <span class="start-date">{formatDate(employee.startDate)}</span>
              </td>
              <td class="table-cell">
                <div class="action-buttons">
                  <button class="action-btn edit" on:click={() => alert(`Edit ${employee.name}`)}>
                    ✏️
                  </button>
                  <button class="action-btn delete" on:click={() => alert(`Delete ${employee.name}`)}>
                    🗑️
                  </button>
                  <button class="action-btn view" on:click={() => alert(`View ${employee.name}`)}>
                    👁️
                  </button>
                </div>
              </td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </main>
</div>

<style>
  .employee-dashboard {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .page-header {
    text-align: center;
    margin-bottom: 30px;
  }
  
  .page-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .page-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .filter-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .filter-label {
    font-weight: bold;
    color: #333;
  }
  
  .filter-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
  }
  
  .stats {
    display: flex;
    gap: 30px;
  }
  
  .stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
  }
  
  .stat-label {
    font-size: 14px;
    color: #666;
  }
  
  .stat-value {
    font-size: 18px;
    font-weight: bold;
    color: #333;
  }
  
  .table-container {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .employee-table {
    width: 100%;
    border-collapse: collapse;
  }
  
  .table-row {
    border-bottom: 1px solid #eee;
  }
  
  .table-row:hover {
    background: #f8f9fa;
  }
  
  .table-cell {
    padding: 15px;
    text-align: left;
    vertical-align: middle;
  }
  
  .header-cell {
    background: #f8f9fa;
    font-weight: bold;
    color: #333;
    cursor: pointer;
    user-select: none;
  }
  
  .header-cell:hover {
    background: #e9ecef;
  }
  
  .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .sort-indicator {
    font-size: 12px;
    color: #666;
  }
  
  .employee-info {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  
  .employee-avatar {
    width: 40px;
    height: 40px;
    background: #007bff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 18px;
  }
  
  .employee-details {
    display: flex;
    flex-direction: column;
  }
  
  .employee-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
  }
  
  .employee-id {
    font-size: 12px;
    color: #666;
  }
  
  .department-badge {
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .department-engineering {
    background: #e3f2fd;
    color: #1976d2;
  }
  
  .department-marketing {
    background: #f3e5f5;
    color: #7b1fa2;
  }
  
  .department-sales {
    background: #e8f5e8;
    color: #388e3c;
  }
  
  .department-hr {
    background: #fff3e0;
    color: #f57c00;
  }
  
  .salary-amount {
    font-weight: bold;
    color: #333;
  }
  
  .start-date {
    color: #666;
  }
  
  .action-buttons {
    display: flex;
    gap: 8px;
  }
  
  .action-btn {
    background: none;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 6px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .action-btn.edit:hover {
    background: #e3f2fd;
    border-color: #1976d2;
  }
  
  .action-btn.delete:hover {
    background: #ffebee;
    border-color: #d32f2f;
  }
  
  .action-btn.view:hover {
    background: #e8f5e8;
    border-color: #388e3c;
  }
</style>

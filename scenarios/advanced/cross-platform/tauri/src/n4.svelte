<script>
  export let data
  
  let employees = []
  let filteredEmployees = []
  let searchTerm = ''
  let departmentFilter = ''
  let statusFilter = ''
  let sortColumn = ''
  let sortDirection = 'asc'
  let currentPage = 1
  let itemsPerPage = 10
  let selectedItems = new Set()
  
  $: {
    if (data) {
      employees = JSON.parse(data).employees || []
      filteredEmployees = employees
    }
  }
  
  $: {
    filteredEmployees = employees.filter(emp => {
      const matchesSearch = emp.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                           emp.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
                           emp.position.toLowerCase().includes(searchTerm.toLowerCase())
      const matchesDepartment = !departmentFilter || emp.department === departmentFilter
      const matchesStatus = !statusFilter || emp.status === statusFilter
      return matchesSearch && matchesDepartment && matchesStatus
    })
    
    if (sortColumn) {
      filteredEmployees.sort((a, b) => {
        let aVal = a[sortColumn]
        let bVal = b[sortColumn]
        
        if (typeof aVal === 'string') {
          return sortDirection === 'asc' ? aVal.localeCompare(bVal) : bVal.localeCompare(aVal)
        } else {
          return sortDirection === 'asc' ? aVal - bVal : bVal - aVal
        }
      })
    }
  }
  
  function sortTable(column) {
    if (sortColumn === column) {
      sortDirection = sortDirection === 'asc' ? 'desc' : 'asc'
    } else {
      sortColumn = column
      sortDirection = 'asc'
    }
  }
  
  function toggleSelectAll() {
    if (selectedItems.size === filteredEmployees.length) {
      selectedItems.clear()
    } else {
      selectedItems = new Set(filteredEmployees.map(emp => emp.id))
    }
  }
  
  function toggleSelectItem(id) {
    if (selectedItems.has(id)) {
      selectedItems.delete(id)
    } else {
      selectedItems.add(id)
    }
    selectedItems = selectedItems
  }
  
  function deleteSelected() {
    if (confirm(`Delete ${selectedItems.size} selected items?`)) {
      employees = employees.filter(emp => !selectedItems.has(emp.id))
      selectedItems.clear()
    }
  }
  
  function deleteEmployee(id) {
    if (confirm('Delete this employee?')) {
      employees = employees.filter(emp => emp.id !== id)
    }
  }
  
  function editEmployee(id) {
    alert(`Edit employee ${id}`)
  }
  
  function viewEmployee(id) {
    const emp = employees.find(e => e.id === id)
    alert(`Employee: ${emp.name}\nEmail: ${emp.email}\nDepartment: ${emp.department}`)
  }
  
  function addEmployee() {
    alert('Add new employee')
  }
  
  function exportData() {
    alert('Export data')
  }
  
  $: totalPages = Math.ceil(filteredEmployees.length / itemsPerPage)
  $: startIndex = (currentPage - 1) * itemsPerPage
  $: endIndex = Math.min(startIndex + itemsPerPage, filteredEmployees.length)
  $: pageEmployees = filteredEmployees.slice(startIndex, endIndex)
</script>

<div class="data-table-container">
  <div class="table-header">
    <h2>Employee Management System</h2>
    <div class="table-actions">
      <button class="btn btn-primary" on:click={addEmployee}>Add Employee</button>
      <button class="btn btn-secondary" on:click={exportData}>Export</button>
    </div>
  </div>
  
  <div class="filters">
    <div class="filter-group">
      <label>Search</label>
      <input type="text" bind:value={searchTerm} placeholder="Search employees...">
    </div>
    <div class="filter-group">
      <label>Department</label>
      <select bind:value={departmentFilter}>
        <option value="">All Departments</option>
        <option value="Engineering">Engineering</option>
        <option value="Marketing">Marketing</option>
        <option value="Sales">Sales</option>
        <option value="HR">HR</option>
      </select>
    </div>
    <div class="filter-group">
      <label>Status</label>
      <select bind:value={statusFilter}>
        <option value="">All Status</option>
        <option value="Active">Active</option>
        <option value="Inactive">Inactive</option>
      </select>
    </div>
  </div>
  
  {#if selectedItems.size > 0}
    <div class="bulk-actions">
      <span>{selectedItems.size} items selected</span>
      <button class="btn btn-danger" on:click={deleteSelected}>Delete Selected</button>
    </div>
  {/if}
  
  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>
            <input type="checkbox" 
                   checked={selectedItems.size === filteredEmployees.length && filteredEmployees.length > 0}
                   on:change={toggleSelectAll}>
          </th>
          <th on:click={() => sortTable('name')}>
            Name {sortColumn === 'name' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th on:click={() => sortTable('email')}>
            Email {sortColumn === 'email' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th on:click={() => sortTable('department')}>
            Department {sortColumn === 'department' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th on:click={() => sortTable('position')}>
            Position {sortColumn === 'position' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th on:click={() => sortTable('salary')}>
            Salary {sortColumn === 'salary' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th on:click={() => sortTable('status')}>
            Status {sortColumn === 'status' ? (sortDirection === 'asc' ? '↑' : '↓') : '↕'}
          </th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {#each pageEmployees as employee}
          <tr class={selectedItems.has(employee.id) ? 'selected' : ''}>
            <td>
              <input type="checkbox" 
                     checked={selectedItems.has(employee.id)}
                     on:change={() => toggleSelectItem(employee.id)}>
            </td>
            <td>{employee.name}</td>
            <td>{employee.email}</td>
            <td>{employee.department}</td>
            <td>{employee.position}</td>
            <td>${employee.salary.toLocaleString()}</td>
            <td>
              <span class="status status-{employee.status.toLowerCase()}">{employee.status}</span>
            </td>
            <td>
              <div class="action-buttons">
                <button class="btn btn-sm btn-primary" on:click={() => viewEmployee(employee.id)}>View</button>
                <button class="btn btn-sm btn-secondary" on:click={() => editEmployee(employee.id)}>Edit</button>
                <button class="btn btn-sm btn-danger" on:click={() => deleteEmployee(employee.id)}>Delete</button>
              </div>
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
  
  <div class="pagination">
    <div class="pagination-info">
      Showing {startIndex + 1} to {endIndex} of {filteredEmployees.length} entries
    </div>
    <div class="pagination-controls">
      <button class="btn btn-sm" 
              disabled={currentPage === 1}
              on:click={() => currentPage = Math.max(1, currentPage - 1)}>Previous</button>
      
      {#each Array(totalPages) as _, i}
        <button class="btn btn-sm {currentPage === i + 1 ? 'active' : ''}"
                on:click={() => currentPage = i + 1}>
          {i + 1}
        </button>
      {/each}
      
      <button class="btn btn-sm" 
              disabled={currentPage === totalPages}
              on:click={() => currentPage = Math.min(totalPages, currentPage + 1)}>Next</button>
    </div>
  </div>
</div>

<style>
  .data-table-container {
    padding: 20px;
  }
  
  .table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
  }
  
  .table-header h2 {
    margin: 0;
    color: #333;
  }
  
  .table-actions {
    display: flex;
    gap: 10px;
  }
  
  .filters {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 8px;
  }
  
  .filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  .filter-group label {
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }
  
  .filter-group input,
  .filter-group select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .bulk-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 15px;
    background: #e3f2fd;
    border-radius: 6px;
    margin-bottom: 15px;
  }
  
  .table-container {
    overflow-x: auto;
    margin-bottom: 20px;
  }
  
  table {
    width: 100%;
    border-collapse: collapse;
    background: white;
  }
  
  th {
    background: #f8f9fa;
    padding: 12px;
    text-align: left;
    font-weight: 600;
    color: #333;
    border-bottom: 2px solid #dee2e6;
    cursor: pointer;
    user-select: none;
  }
  
  th:hover {
    background: #e9ecef;
  }
  
  td {
    padding: 12px;
    border-bottom: 1px solid #dee2e6;
  }
  
  tr:hover {
    background: #f8f9fa;
  }
  
  tr.selected {
    background: #e3f2fd;
  }
  
  .status {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 600;
  }
  
  .status-active {
    background: #d4edda;
    color: #155724;
  }
  
  .status-inactive {
    background: #f8d7da;
    color: #721c24;
  }
  
  .action-buttons {
    display: flex;
    gap: 5px;
  }
  
  .pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0;
  }
  
  .pagination-info {
    color: #666;
    font-size: 14px;
  }
  
  .pagination-controls {
    display: flex;
    gap: 5px;
  }
  
  .btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.2s ease;
  }
  
  .btn:hover {
    background: #f8f9fa;
  }
  
  .btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  
  .btn-sm {
    padding: 6px 12px;
    font-size: 12px;
  }
  
  .btn-primary {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .btn-primary:hover {
    background: #0056b3;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
    border-color: #6c757d;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
  
  .btn-danger {
    background: #dc3545;
    color: white;
    border-color: #dc3545;
  }
  
  .btn-danger:hover {
    background: #c82333;
  }
  
  .btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
</style>

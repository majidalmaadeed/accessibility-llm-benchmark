<script>
  import { onMount } from 'svelte';
  
  let data = [];
  let filteredData = [];
  let sortColumn = '';
  let sortDirection = 'asc';
  let searchQuery = '';
  let selectedRows = new Set();
  let currentPage = 1;
  let itemsPerPage = 10;
  let showFilters = false;
  let columnFilters = {};
  let isLoading = false;
  
  const columns = [
    { key: 'id', label: 'ID', sortable: true, filterable: false },
    { key: 'name', label: 'Name', sortable: true, filterable: true },
    { key: 'email', label: 'Email', sortable: true, filterable: true },
    { key: 'department', label: 'Department', sortable: true, filterable: true },
    { key: 'position', label: 'Position', sortable: true, filterable: true },
    { key: 'salary', label: 'Salary', sortable: true, filterable: true },
    { key: 'status', label: 'Status', sortable: true, filterable: true },
    { key: 'joinDate', label: 'Join Date', sortable: true, filterable: true },
    { key: 'actions', label: 'Actions', sortable: false, filterable: false }
  ];
  
  const departments = ['Engineering', 'Marketing', 'Sales', 'HR', 'Finance'];
  const positions = ['Manager', 'Developer', 'Designer', 'Analyst', 'Coordinator'];
  const statuses = ['Active', 'Inactive', 'Pending', 'Terminated'];
  
  onMount(() => {
    loadData();
  });
  
  function loadData() {
    isLoading = true;
    setTimeout(() => {
      data = generateSampleData();
      filteredData = [...data];
      isLoading = false;
    }, 1000);
  }
  
  function generateSampleData() {
    const sampleData = [];
    for (let i = 1; i <= 100; i++) {
      sampleData.push({
        id: i,
        name: `Employee ${i}`,
        email: `employee${i}@company.com`,
        department: departments[Math.floor(Math.random() * departments.length)],
        position: positions[Math.floor(Math.random() * positions.length)],
        salary: Math.floor(Math.random() * 100000) + 40000,
        status: statuses[Math.floor(Math.random() * statuses.length)],
        joinDate: new Date(2020 + Math.floor(Math.random() * 4), Math.floor(Math.random() * 12), Math.floor(Math.random() * 28) + 1).toISOString().split('T')[0]
      });
    }
    return sampleData;
  }
  
  function handleSort(column) {
    if (!column.sortable) return;
    
    if (sortColumn === column.key) {
      sortDirection = sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      sortColumn = column.key;
      sortDirection = 'asc';
    }
    
    applyFiltersAndSort();
  }
  
  function handleSearch() {
    currentPage = 1;
    applyFiltersAndSort();
  }
  
  function applyFiltersAndSort() {
    let filtered = [...data];
    
    if (searchQuery) {
      const query = searchQuery.toLowerCase();
      filtered = filtered.filter(row => 
        Object.values(row).some(value => 
          String(value).toLowerCase().includes(query)
        )
      );
    }
    
    Object.entries(columnFilters).forEach(([column, value]) => {
      if (value) {
        filtered = filtered.filter(row => 
          String(row[column]).toLowerCase().includes(value.toLowerCase())
        );
      }
    });
    
    if (sortColumn) {
      filtered.sort((a, b) => {
        const aVal = a[sortColumn];
        const bVal = b[sortColumn];
        
        if (typeof aVal === 'number') {
          return sortDirection === 'asc' ? aVal - bVal : bVal - aVal;
        }
        
        const aStr = String(aVal).toLowerCase();
        const bStr = String(bVal).toLowerCase();
        
        if (sortDirection === 'asc') {
          return aStr.localeCompare(bStr);
        } else {
          return bStr.localeCompare(aStr);
        }
      });
    }
    
    filteredData = filtered;
  }
  
  function handleSelectAll() {
    if (selectedRows.size === paginatedData.length) {
      selectedRows.clear();
    } else {
      selectedRows.clear();
      paginatedData.forEach(row => selectedRows.add(row.id));
    }
  }
  
  function handleSelectRow(rowId) {
    if (selectedRows.has(rowId)) {
      selectedRows.delete(rowId);
    } else {
      selectedRows.add(rowId);
    }
    selectedRows = selectedRows;
  }
  
  function handleBulkAction(action) {
    if (selectedRows.size === 0) {
      alert('Please select rows first');
      return;
    }
    
    console.log(`Bulk action: ${action}`, Array.from(selectedRows));
    alert(`Performing ${action} on ${selectedRows.size} selected rows`);
  }
  
  function handleRowAction(action, rowId) {
    console.log(`Row action: ${action}`, rowId);
    alert(`Performing ${action} on row ${rowId}`);
  }
  
  function exportData(format) {
    console.log(`Exporting data as ${format}`);
    alert(`Data exported as ${format.toUpperCase()}`);
  }
  
  function clearFilters() {
    searchQuery = '';
    columnFilters = {};
    currentPage = 1;
    applyFiltersAndSort();
  }
  
  function goToPage(page) {
    currentPage = page;
  }
  
  function previousPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
  
  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }
  
  function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  }
  
  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US');
  }
  
  $: paginatedData = filteredData.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );
  
  $: totalPages = Math.ceil(filteredData.length / itemsPerPage);
  
  $: startItem = (currentPage - 1) * itemsPerPage + 1;
  $: endItem = Math.min(currentPage * itemsPerPage, filteredData.length);
  
  $: isAllSelected = paginatedData.length > 0 && selectedRows.size === paginatedData.length;
  $: isPartiallySelected = selectedRows.size > 0 && selectedRows.size < paginatedData.length;
</script>

<div class="data-table-container">
  <div class="table-header">
    <h2>Employee Data Table</h2>
    <div class="header-actions">
      <button 
        on:click={() => showFilters = !showFilters}
        class="filter-toggle-btn"
      >
        {showFilters ? 'Hide' : 'Show'} Filters
      </button>
      <button 
        on:click={() => exportData('csv')}
        class="export-btn"
      >
        Export CSV
      </button>
      <button 
        on:click={() => exportData('excel')}
        class="export-btn"
      >
        Export Excel
      </button>
    </div>
  </div>

  <div class="table-controls">
    <div class="search-section">
      <input
        type="text"
        bind:value={searchQuery}
        on:input={handleSearch}
        placeholder="Search all columns..."
        class="search-input"
      />
      <button 
        on:click={handleSearch}
        class="search-btn"
      >
        🔍
      </button>
    </div>
    
    <div class="pagination-info">
      Showing {startItem}-{endItem} of {filteredData.length} entries
    </div>
  </div>

  {#if showFilters}
    <div class="filters-panel">
      <div class="filter-row">
        {#each columns.filter(col => col.filterable) as column}
          <div class="filter-group">
            <label class="filter-label">{column.label}</label>
            <input
              type="text"
              bind:value={columnFilters[column.key]}
              on:input={applyFiltersAndSort}
              placeholder={`Filter by ${column.label.toLowerCase()}...`}
              class="filter-input"
            />
          </div>
        {/each}
      </div>
      <div class="filter-actions">
        <button 
          on:click={clearFilters}
          class="clear-filters-btn"
        >
          Clear All Filters
        </button>
      </div>
    </div>
  {/if}

  <div class="table-wrapper">
    <table class="data-table">
      <thead>
        <tr>
          <th class="select-column">
            <input
              type="checkbox"
              bind:checked={isAllSelected}
              on:change={handleSelectAll}
              class="select-all-checkbox"
            />
          </th>
          {#each columns as column}
            <th 
              class="sortable-column"
              class:sortable={column.sortable}
              on:click={() => handleSort(column)}
            >
              <div class="column-header">
                <span class="column-label">{column.label}</span>
                {#if column.sortable}
                  <span class="sort-indicator">
                    {#if sortColumn === column.key}
                      {sortDirection === 'asc' ? '↑' : '↓'}
                    {:else}
                      ↕
                    {/if}
                  </span>
                {/if}
              </div>
            </th>
          {/each}
        </tr>
      </thead>
      <tbody>
        {#if isLoading}
          <tr class="loading-row">
            <td colspan={columns.length + 1} class="loading-cell">
              <div class="loading-spinner"></div>
              <span>Loading data...</span>
            </td>
          </tr>
        {:else if paginatedData.length === 0}
          <tr class="no-data-row">
            <td colspan={columns.length + 1} class="no-data-cell">
              <div class="no-data-icon">📊</div>
              <h3>No data found</h3>
              <p>Try adjusting your search or filter criteria</p>
            </td>
          </tr>
        {:else}
          {#each paginatedData as row}
            <tr class="data-row" class:selected={selectedRows.has(row.id)}>
              <td class="select-cell">
                <input
                  type="checkbox"
                  checked={selectedRows.has(row.id)}
                  on:change={() => handleSelectRow(row.id)}
                  class="row-checkbox"
                />
              </td>
              <td class="data-cell">{row.id}</td>
              <td class="data-cell">{row.name}</td>
              <td class="data-cell">{row.email}</td>
              <td class="data-cell">{row.department}</td>
              <td class="data-cell">{row.position}</td>
              <td class="data-cell">{formatCurrency(row.salary)}</td>
              <td class="data-cell">
                <span class="status-badge" class:status-{row.status.toLowerCase()}>
                  {row.status}
                </span>
              </td>
              <td class="data-cell">{formatDate(row.joinDate)}</td>
              <td class="data-cell actions-cell">
                <div class="action-buttons">
                  <button 
                    on:click={() => handleRowAction('edit', row.id)}
                    class="action-btn edit-btn"
                    title="Edit"
                  >
                    ✏️
                  </button>
                  <button 
                    on:click={() => handleRowAction('view', row.id)}
                    class="action-btn view-btn"
                    title="View"
                  >
                    👁️
                  </button>
                  <button 
                    on:click={() => handleRowAction('delete', row.id)}
                    class="action-btn delete-btn"
                    title="Delete"
                  >
                    🗑️
                  </button>
                </div>
              </td>
            </tr>
          {/each}
        {/if}
      </tbody>
    </table>
  </div>

  {#if selectedRows.size > 0}
    <div class="bulk-actions">
      <div class="bulk-info">
        {selectedRows.size} row{selectedRows.size !== 1 ? 's' : ''} selected
      </div>
      <div class="bulk-buttons">
        <button 
          on:click={() => handleBulkAction('export')}
          class="bulk-btn export-btn"
        >
          Export Selected
        </button>
        <button 
          on:click={() => handleBulkAction('delete')}
          class="bulk-btn delete-btn"
        >
          Delete Selected
        </button>
        <button 
          on:click={() => handleBulkAction('update')}
          class="bulk-btn update-btn"
        >
          Update Selected
        </button>
      </div>
    </div>
  {/if}

  <div class="pagination">
    <div class="pagination-info">
      <span>Page {currentPage} of {totalPages}</span>
    </div>
    
    <div class="pagination-controls">
      <button 
        on:click={previousPage}
        disabled={currentPage === 1}
        class="page-btn"
      >
        ← Previous
      </button>
      
      <div class="page-numbers">
        {#each Array.from({length: Math.min(5, totalPages)}, (_, i) => {
          const start = Math.max(1, currentPage - 2);
          return start + i;
        }).filter(page => page <= totalPages) as page}
          <button 
            on:click={() => goToPage(page)}
            class="page-number"
            class:active={page === currentPage}
          >
            {page}
          </button>
        {/each}
      </div>
      
      <button 
        on:click={nextPage}
        disabled={currentPage === totalPages}
        class="page-btn"
      >
        Next →
      </button>
    </div>
    
    <div class="items-per-page">
      <label for="items-per-page">Items per page:</label>
      <select 
        id="items-per-page"
        bind:value={itemsPerPage}
        on:change={() => currentPage = 1}
        class="items-select"
      >
        <option value={5}>5</option>
        <option value={10}>10</option>
        <option value={25}>25</option>
        <option value={50}>50</option>
        <option value={100}>100</option>
      </select>
    </div>
  </div>
</div>

<style>
  .data-table-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
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
  }

  .filter-toggle-btn,
  .export-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .filter-toggle-btn:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .export-btn {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .export-btn:hover {
    background: #45a049;
  }

  .table-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .search-section {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .search-input {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    width: 300px;
  }

  .search-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .search-btn {
    padding: 10px 15px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
  }

  .search-btn:hover {
    background: #45a049;
  }

  .pagination-info {
    color: #666;
    font-size: 14px;
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
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 15px;
  }

  .filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }

  .filter-label {
    font-weight: 600;
    color: #333;
    font-size: 12px;
  }

  .filter-input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }

  .filter-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .filter-actions {
    display: flex;
    justify-content: flex-end;
  }

  .clear-filters-btn {
    padding: 8px 16px;
    background: #f44336;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }

  .clear-filters-btn:hover {
    background: #d32f2f;
  }

  .table-wrapper {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 20px;
  }

  .data-table {
    width: 100%;
    border-collapse: collapse;
  }

  .data-table th {
    background: #f8f9fa;
    padding: 15px 12px;
    text-align: left;
    font-weight: 600;
    color: #333;
    border-bottom: 2px solid #e0e0e0;
  }

  .sortable-column {
    cursor: pointer;
    user-select: none;
    transition: background-color 0.3s ease;
  }

  .sortable-column:hover {
    background: #e8f5e8;
  }

  .column-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .sort-indicator {
    font-size: 12px;
    color: #666;
  }

  .data-table td {
    padding: 12px;
    border-bottom: 1px solid #f0f0f0;
  }

  .data-row:hover {
    background: #f8f9fa;
  }

  .data-row.selected {
    background: #e8f5e8;
  }

  .select-column,
  .select-cell {
    width: 50px;
    text-align: center;
  }

  .select-all-checkbox,
  .row-checkbox {
    width: 16px;
    height: 16px;
    cursor: pointer;
  }

  .status-badge {
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
  }

  .status-badge.status-active {
    background: #e8f5e8;
    color: #4caf50;
  }

  .status-badge.status-inactive {
    background: #ffebee;
    color: #f44336;
  }

  .status-badge.status-pending {
    background: #fff3e0;
    color: #ff9800;
  }

  .status-badge.status-terminated {
    background: #f5f5f5;
    color: #666;
  }

  .actions-cell {
    width: 120px;
  }

  .action-buttons {
    display: flex;
    gap: 5px;
  }

  .action-btn {
    width: 28px;
    height: 28px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }

  .action-btn:hover {
    background: #f0f0f0;
  }

  .edit-btn:hover {
    background: #e3f2fd;
    border-color: #2196f3;
  }

  .view-btn:hover {
    background: #e8f5e8;
    border-color: #4caf50;
  }

  .delete-btn:hover {
    background: #ffebee;
    border-color: #f44336;
  }

  .loading-row,
  .no-data-row {
    text-align: center;
  }

  .loading-cell,
  .no-data-cell {
    padding: 60px 20px;
    color: #666;
  }

  .loading-spinner {
    width: 40px;
    height: 40px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #4caf50;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 15px;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .no-data-icon {
    font-size: 48px;
    margin-bottom: 15px;
  }

  .no-data-cell h3 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 18px;
  }

  .no-data-cell p {
    margin: 0;
    font-size: 14px;
  }

  .bulk-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    background: #e8f5e8;
    border: 1px solid #4caf50;
    border-radius: 6px;
    margin-bottom: 20px;
  }

  .bulk-info {
    font-weight: 600;
    color: #333;
  }

  .bulk-buttons {
    display: flex;
    gap: 10px;
  }

  .bulk-btn {
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .bulk-btn.export-btn {
    background: #4caf50;
    color: white;
  }

  .bulk-btn.export-btn:hover {
    background: #45a049;
  }

  .bulk-btn.delete-btn {
    background: #f44336;
    color: white;
  }

  .bulk-btn.delete-btn:hover {
    background: #d32f2f;
  }

  .bulk-btn.update-btn {
    background: #2196f3;
    color: white;
  }

  .bulk-btn.update-btn:hover {
    background: #1976d2;
  }

  .pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 0;
  }

  .pagination-controls {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .page-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .page-btn:hover:not(:disabled) {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .page-numbers {
    display: flex;
    gap: 5px;
  }

  .page-number {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }

  .page-number:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .page-number.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .items-per-page {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
  }

  .items-select {
    padding: 6px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    background: white;
    cursor: pointer;
  }

  .items-select:focus {
    outline: none;
    border-color: #4caf50;
  }

  @media (max-width: 1024px) {
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
    }
    
    .table-controls {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .search-section {
      justify-content: center;
    }
    
    .search-input {
      width: 100%;
    }
    
    .filter-row {
      grid-template-columns: 1fr;
    }
    
    .pagination {
      flex-direction: column;
      gap: 15px;
    }
  }

  @media (max-width: 768px) {
    .data-table-container {
      padding: 10px;
    }
    
    .table-wrapper {
      overflow-x: auto;
    }
    
    .data-table {
      min-width: 800px;
    }
    
    .bulk-actions {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .bulk-buttons {
      justify-content: center;
    }
    
    .pagination-controls {
      flex-wrap: wrap;
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .header-actions {
      flex-direction: column;
    }
    
    .search-section {
      flex-direction: column;
    }
    
    .bulk-buttons {
      flex-direction: column;
    }
    
    .page-numbers {
      flex-wrap: wrap;
      justify-content: center;
    }
  }
</style>

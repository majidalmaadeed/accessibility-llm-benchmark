<script>
  let selectedYear = '2024';
  let selectedQuarter = 'Q1';
  let sortBy = 'revenue';
  let sortOrder = 'desc';
  let currentPage = 1;
  const itemsPerPage = 10;

  const years = ['2024', '2023', '2022', '2021', '2020'];
  const quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

  const salesData = [
    {
      id: 1,
      region: 'North America',
      product: 'Software License',
      revenue: 1250000,
      units: 2500,
      growth: 12.5,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 2,
      region: 'Europe',
      product: 'Software License',
      revenue: 980000,
      units: 1960,
      growth: 8.3,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 3,
      region: 'Asia Pacific',
      product: 'Software License',
      revenue: 1450000,
      units: 2900,
      growth: 15.7,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 4,
      region: 'North America',
      product: 'Support Services',
      revenue: 320000,
      units: 800,
      growth: 5.2,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 5,
      region: 'Europe',
      product: 'Support Services',
      revenue: 280000,
      units: 700,
      growth: 3.8,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 6,
      region: 'Asia Pacific',
      product: 'Support Services',
      revenue: 380000,
      units: 950,
      growth: 9.1,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 7,
      region: 'North America',
      product: 'Consulting',
      revenue: 450000,
      units: 150,
      growth: 18.2,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 8,
      region: 'Europe',
      product: 'Consulting',
      revenue: 320000,
      units: 107,
      growth: 14.5,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 9,
      region: 'Asia Pacific',
      product: 'Consulting',
      revenue: 280000,
      units: 93,
      growth: 22.1,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 10,
      region: 'Latin America',
      product: 'Software License',
      revenue: 180000,
      units: 360,
      growth: 25.3,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 11,
      region: 'Latin America',
      product: 'Support Services',
      revenue: 45000,
      units: 113,
      growth: 12.8,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 12,
      region: 'Middle East & Africa',
      product: 'Software License',
      revenue: 120000,
      units: 240,
      growth: 8.7,
      quarter: 'Q1',
      year: '2024'
    }
  ];

  $: filteredData = salesData.filter(item => 
    item.year === selectedYear && item.quarter === selectedQuarter
  );

  $: sortedData = [...filteredData].sort((a, b) => {
    let aValue = a[sortBy];
    let bValue = b[sortBy];
    
    if (typeof aValue === 'string') {
      aValue = aValue.toLowerCase();
      bValue = bValue.toLowerCase();
    }
    
    if (sortOrder === 'asc') {
      return aValue > bValue ? 1 : -1;
    } else {
      return aValue < bValue ? 1 : -1;
    }
  });

  $: totalPages = Math.ceil(sortedData.length / itemsPerPage);
  $: paginatedData = sortedData.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  $: totalRevenue = filteredData.reduce((sum, item) => sum + item.revenue, 0);
  $: totalUnits = filteredData.reduce((sum, item) => sum + item.units, 0);
  $: averageGrowth = filteredData.reduce((sum, item) => sum + item.growth, 0) / filteredData.length;

  function handleSort(column) {
    if (sortBy === column) {
      sortOrder = sortOrder === 'asc' ? 'desc' : 'asc';
    } else {
      sortBy = column;
      sortOrder = 'asc';
    }
    currentPage = 1;
  }

  function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount);
  }

  function formatNumber(num) {
    return new Intl.NumberFormat('en-US').format(num);
  }

  function goToPage(page) {
    currentPage = page;
  }

  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }

  function prevPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
</script>

<div class="sales-dashboard">
  <header class="dashboard-header">
    <h1>Sales Performance Dashboard</h1>
    <p>Comprehensive view of sales data across all regions and products</p>
  </header>

  <div class="dashboard-controls">
    <div class="filter-controls">
      <div class="filter-group">
        <label for="year-select">Year:</label>
        <select id="year-select" bind:value={selectedYear} class="filter-select">
          {#each years as year}
            <option value={year}>{year}</option>
          {/each}
        </select>
      </div>

      <div class="filter-group">
        <label for="quarter-select">Quarter:</label>
        <select id="quarter-select" bind:value={selectedQuarter} class="filter-select">
          {#each quarters as quarter}
            <option value={quarter}>{quarter}</option>
          {/each}
        </select>
      </div>
    </div>

    <div class="view-controls">
      <button class="export-btn">Export Data</button>
      <button class="refresh-btn">Refresh</button>
    </div>
  </div>

  <div class="summary-cards">
    <div class="summary-card">
      <div class="card-icon">💰</div>
      <div class="card-content">
        <div class="card-title">Total Revenue</div>
        <div class="card-value">{formatCurrency(totalRevenue)}</div>
      </div>
    </div>

    <div class="summary-card">
      <div class="card-icon">📦</div>
      <div class="card-content">
        <div class="card-title">Total Units</div>
        <div class="card-value">{formatNumber(totalUnits)}</div>
      </div>
    </div>

    <div class="summary-card">
      <div class="card-icon">📈</div>
      <div class="card-content">
        <div class="card-title">Average Growth</div>
        <div class="card-value">{averageGrowth.toFixed(1)}%</div>
      </div>
    </div>

    <div class="summary-card">
      <div class="card-icon">📊</div>
      <div class="card-content">
        <div class="card-title">Data Points</div>
        <div class="card-value">{filteredData.length}</div>
      </div>
    </div>
  </div>

  <div class="data-table-container">
    <div class="table-header">
      <h3>Sales Data Table</h3>
      <p>Click column headers to sort data</p>
    </div>

    <div class="table-wrapper">
      <table class="data-table">
        <tbody>
          {#each paginatedData as item}
            <tr class="data-row">
              <td class="data-cell region">{item.region}</td>
              <td class="data-cell product">{item.product}</td>
              <td class="data-cell revenue">{formatCurrency(item.revenue)}</td>
              <td class="data-cell units">{formatNumber(item.units)}</td>
              <td class="data-cell growth {item.growth >= 0 ? 'positive' : 'negative'}">
                {item.growth >= 0 ? '+' : ''}{item.growth}%
              </td>
              <td class="data-cell quarter">{item.quarter}</td>
              <td class="data-cell year">{item.year}</td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>

    <div class="table-footer">
      <div class="pagination-info">
        Showing {((currentPage - 1) * itemsPerPage) + 1} to {Math.min(currentPage * itemsPerPage, sortedData.length)} of {sortedData.length} entries
      </div>

      {#if totalPages > 1}
        <div class="pagination">
          <button 
            class="page-btn" 
            on:click={prevPage} 
            disabled={currentPage === 1}
          >
            Previous
          </button>
          
          {#each Array(totalPages) as _, i}
            <button 
              class="page-btn {currentPage === i + 1 ? 'active' : ''}" 
              on:click={() => goToPage(i + 1)}
            >
              {i + 1}
            </button>
          {/each}
          
          <button 
            class="page-btn" 
            on:click={nextPage} 
            disabled={currentPage === totalPages}
          >
            Next
          </button>
        </div>
      {/if}
    </div>
  </div>

  <div class="chart-section">
    <h3>Revenue by Region</h3>
    <div class="chart-placeholder">
      <div class="chart-bars">
        {#each filteredData.reduce((acc, item) => {
          const existing = acc.find(r => r.region === item.region);
          if (existing) {
            existing.revenue += item.revenue;
          } else {
            acc.push({ region: item.region, revenue: item.revenue });
          }
          return acc;
        }, []) as regionData}
          <div class="chart-bar">
            <div class="bar-fill" style="height: {(regionData.revenue / totalRevenue) * 100}%"></div>
            <div class="bar-label">{regionData.region}</div>
            <div class="bar-value">{formatCurrency(regionData.revenue)}</div>
          </div>
        {/each}
      </div>
    </div>
  </div>
</div>

<style>
  .sales-dashboard {
    max-width: 1400px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .dashboard-header {
    text-align: center;
    margin-bottom: 30px;
  }

  .dashboard-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .dashboard-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .dashboard-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .filter-controls {
    display: flex;
    gap: 20px;
  }

  .filter-group {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .filter-group label {
    font-weight: bold;
    color: #333;
  }

  .filter-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
  }

  .view-controls {
    display: flex;
    gap: 10px;
  }

  .export-btn,
  .refresh-btn {
    padding: 8px 16px;
    border: 1px solid #007bff;
    border-radius: 4px;
    background: white;
    color: #007bff;
    cursor: pointer;
    font-weight: bold;
  }

  .export-btn:hover,
  .refresh-btn:hover {
    background: #007bff;
    color: white;
  }

  .summary-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .summary-card {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .card-icon {
    font-size: 32px;
  }

  .card-content {
    flex: 1;
  }

  .card-title {
    font-size: 14px;
    color: #666;
    margin-bottom: 5px;
  }

  .card-value {
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }

  .data-table-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    overflow: hidden;
  }

  .table-header {
    padding: 20px;
    border-bottom: 1px solid #eee;
  }

  .table-header h3 {
    margin: 0 0 5px 0;
    font-size: 20px;
    color: #333;
  }

  .table-header p {
    margin: 0;
    color: #666;
    font-size: 14px;
  }

  .table-wrapper {
    overflow-x: auto;
  }

  .data-table {
    width: 100%;
    border-collapse: collapse;
  }

  .data-row {
    border-bottom: 1px solid #eee;
    transition: background-color 0.2s ease;
  }

  .data-row:hover {
    background: #f8f9fa;
  }

  .data-row:last-child {
    border-bottom: none;
  }

  .data-cell {
    padding: 15px 12px;
    text-align: left;
    font-size: 14px;
  }

  .data-cell.region {
    font-weight: bold;
    color: #333;
    min-width: 120px;
  }

  .data-cell.product {
    color: #666;
    min-width: 140px;
  }

  .data-cell.revenue {
    font-weight: bold;
    color: #007bff;
    text-align: right;
    min-width: 100px;
  }

  .data-cell.units {
    text-align: right;
    min-width: 80px;
  }

  .data-cell.growth {
    text-align: right;
    font-weight: bold;
    min-width: 80px;
  }

  .data-cell.growth.positive {
    color: #28a745;
  }

  .data-cell.growth.negative {
    color: #dc3545;
  }

  .data-cell.quarter {
    text-align: center;
    min-width: 60px;
  }

  .data-cell.year {
    text-align: center;
    min-width: 60px;
  }

  .table-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-top: 1px solid #eee;
    background: #f8f9fa;
  }

  .pagination-info {
    color: #666;
    font-size: 14px;
  }

  .pagination {
    display: flex;
    gap: 5px;
  }

  .page-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.2s ease;
  }

  .page-btn:hover:not(:disabled) {
    background: #f8f9fa;
  }

  .page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }

  .page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .chart-section {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  .chart-section h3 {
    margin: 0 0 20px 0;
    font-size: 20px;
    color: #333;
  }

  .chart-placeholder {
    height: 300px;
    display: flex;
    align-items: end;
    justify-content: center;
    background: #f8f9fa;
    border-radius: 4px;
    padding: 20px;
  }

  .chart-bars {
    display: flex;
    align-items: end;
    gap: 20px;
    height: 100%;
  }

  .chart-bar {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    min-width: 80px;
  }

  .bar-fill {
    background: linear-gradient(to top, #007bff, #0056b3);
    width: 40px;
    border-radius: 4px 4px 0 0;
    margin-bottom: 10px;
    min-height: 20px;
  }

  .bar-label {
    font-size: 12px;
    color: #666;
    text-align: center;
    margin-bottom: 5px;
  }

  .bar-value {
    font-size: 11px;
    color: #333;
    font-weight: bold;
    text-align: center;
  }
</style>

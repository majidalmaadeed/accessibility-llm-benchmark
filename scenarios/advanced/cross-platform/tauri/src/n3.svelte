<script>
  export let data
  
  let dashboardData = null
  let selectedPeriod = '7d'
  let selectedMetric = 'sessions'
  
  $: {
    if (data) {
      dashboardData = JSON.parse(data)
    }
  }
  
  function exportData(type) {
    alert(`Exporting ${type} data...`)
  }
  
  function applyFilters() {
    alert('Applying filters...')
  }
</script>

<div class="dashboard-container">
  <div class="dashboard-header">
    <h2>Analytics Dashboard</h2>
    <p>Real-time insights and performance metrics</p>
  </div>
  
  <div class="dashboard-grid">
    <div class="widget revenue-widget">
      <div class="widget-header">
        <h3>Revenue Overview</h3>
        <div class="widget-controls">
          <select bind:value={selectedPeriod}>
            <option value="7d">Last 7 days</option>
            <option value="30d">Last 30 days</option>
            <option value="90d">Last 90 days</option>
            <option value="1y">Last year</option>
          </select>
          <button class="export-btn" on:click={() => exportData('revenue')}>Export</button>
        </div>
      </div>
      <div class="chart-container">
        <div class="chart-placeholder">📊 Revenue Chart</div>
      </div>
      <div class="legend">
        <div class="legend-item">
          <div class="legend-color" style="background: #007bff;"></div>
          <span>Total Revenue</span>
        </div>
        <div class="legend-item">
          <div class="legend-color" style="background: #28a745;"></div>
          <span>Recurring Revenue</span>
        </div>
        <div class="legend-item">
          <div class="legend-color" style="background: #ffc107;"></div>
          <span>One-time Revenue</span>
        </div>
      </div>
    </div>
    
    <div class="widget engagement-widget">
      <div class="widget-header">
        <h3>User Engagement</h3>
        <div class="widget-controls">
          <select bind:value={selectedMetric}>
            <option value="sessions">Sessions</option>
            <option value="pageviews">Page Views</option>
            <option value="bounce">Bounce Rate</option>
            <option value="duration">Avg Duration</option>
          </select>
          <button class="export-btn" on:click={() => exportData('engagement')}>Export</button>
        </div>
      </div>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-value">12,543</div>
          <div class="stat-label">Total Sessions</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">2:34</div>
          <div class="stat-label">Avg Duration</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">68%</div>
          <div class="stat-label">Bounce Rate</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">4.2</div>
          <div class="stat-label">Pages/Session</div>
        </div>
      </div>
      <div class="chart-container">
        <div class="chart-placeholder">📈 Engagement Chart</div>
      </div>
    </div>
    
    <div class="widget conversion-widget">
      <div class="widget-header">
        <h3>Conversion Funnel</h3>
        <div class="widget-controls">
          <button class="export-btn" on:click={() => exportData('funnel')}>Export</button>
        </div>
      </div>
      <div class="funnel-steps">
        <div class="funnel-step">
          <div class="step-label">Visitors</div>
          <div class="metric-value">10,000</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 100%;"></div>
          </div>
        </div>
        <div class="funnel-step">
          <div class="step-label">Product Views</div>
          <div class="metric-value">7,500</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 75%;"></div>
          </div>
        </div>
        <div class="funnel-step">
          <div class="step-label">Add to Cart</div>
          <div class="metric-value">2,250</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 30%;"></div>
          </div>
        </div>
        <div class="funnel-step">
          <div class="step-label">Checkout</div>
          <div class="metric-value">1,125</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 15%;"></div>
          </div>
        </div>
        <div class="funnel-step">
          <div class="step-label">Purchase</div>
          <div class="metric-value">900</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 12%;"></div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="widget pages-widget">
      <div class="widget-header">
        <h3>Top Performing Pages</h3>
        <div class="widget-controls">
          <select>
            <option value="all">All Pages</option>
            <option value="landing">Landing Pages</option>
            <option value="product">Product Pages</option>
            <option value="blog">Blog Posts</option>
          </select>
          <button class="export-btn" on:click={() => exportData('pages')}>Export</button>
        </div>
      </div>
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <label>Date Range</label>
            <input type="date" value="2024-01-01">
          </div>
          <div class="filter-group">
            <label>End Date</label>
            <input type="date" value="2024-12-31">
          </div>
          <div class="filter-group">
            <label>Sort By</label>
            <select>
              <option value="views">Page Views</option>
              <option value="conversion">Conversion Rate</option>
              <option value="bounce">Bounce Rate</option>
              <option value="duration">Avg Duration</option>
            </select>
          </div>
          <button class="apply-filters" on:click={applyFilters}>Apply Filters</button>
        </div>
      </div>
      <table class="data-table">
        <thead>
          <tr>
            <th>Page</th>
            <th>Views</th>
            <th>Conversion Rate</th>
            <th>Bounce Rate</th>
            <th>Avg Duration</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>/home</td>
            <td>15,432</td>
            <td>3.2%</td>
            <td>45%</td>
            <td>2:15</td>
          </tr>
          <tr>
            <td>/products/featured</td>
            <td>12,876</td>
            <td>5.8%</td>
            <td>38%</td>
            <td>3:42</td>
          </tr>
          <tr>
            <td>/blog/guide</td>
            <td>9,543</td>
            <td>2.1%</td>
            <td>52%</td>
            <td>4:18</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<style>
  .dashboard-container {
    padding: 20px;
  }
  
  .dashboard-header {
    margin-bottom: 20px;
  }
  
  .dashboard-header h2 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 24px;
  }
  
  .dashboard-header p {
    margin: 0;
    color: #666;
  }
  
  .dashboard-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: auto 1fr 1fr;
    gap: 20px;
  }
  
  .widget {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .widget-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
  }
  
  .widget-header h3 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }
  
  .widget-controls {
    display: flex;
    gap: 10px;
    align-items: center;
  }
  
  .widget-controls select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    cursor: pointer;
  }
  
  .export-btn {
    padding: 8px 16px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
  }
  
  .export-btn:hover {
    background: #0056b3;
  }
  
  .chart-container {
    position: relative;
    height: 300px;
    margin: 20px 0;
  }
  
  .chart-placeholder {
    width: 100%;
    height: 100%;
    background: #f8f9fa;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: #666;
  }
  
  .legend {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 15px;
  }
  
  .legend-item {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .legend-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
  }
  
  .legend-item span {
    font-size: 14px;
    color: #666;
  }
  
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 20px;
  }
  
  .stat-card {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    text-align: center;
  }
  
  .stat-value {
    font-size: 24px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 5px;
  }
  
  .stat-label {
    font-size: 14px;
    color: #666;
  }
  
  .funnel-steps {
    margin-top: 20px;
  }
  
  .funnel-step {
    margin-bottom: 20px;
  }
  
  .step-label {
    font-weight: 600;
    color: #333;
    margin-bottom: 5px;
  }
  
  .metric-value {
    font-size: 32px;
    font-weight: bold;
    color: #28a745;
    margin: 10px 0;
  }
  
  .progress-bar {
    width: 100%;
    height: 8px;
    background: #e9ecef;
    border-radius: 4px;
    overflow: hidden;
  }
  
  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #28a745, #20c997);
    transition: width 0.3s ease;
  }
  
  .filter-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .filter-row {
    display: flex;
    gap: 15px;
    align-items: center;
    flex-wrap: wrap;
  }
  
  .filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  .filter-group label {
    font-size: 12px;
    font-weight: 600;
    color: #666;
    text-transform: uppercase;
  }
  
  .filter-group input,
  .filter-group select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
  }
  
  .apply-filters {
    padding: 8px 16px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-left: auto;
  }
  
  .apply-filters:hover {
    background: #1e7e34;
  }
  
  .data-table {
    width: 100%;
    border-collapse: collapse;
  }
  
  .data-table th,
  .data-table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #eee;
  }
  
  .data-table th {
    background: #f8f9fa;
    font-weight: 600;
    color: #333;
  }
  
  .data-table tr:hover {
    background: #f8f9fa;
  }
</style>

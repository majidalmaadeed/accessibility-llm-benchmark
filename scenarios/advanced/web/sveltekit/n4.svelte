<script>
  import { onMount } from 'svelte';
  
  let selectedMetric = 'revenue';
  let selectedPeriod = '30d';
  let selectedChart = 'line';
  let showFilters = false;
  let isExporting = false;
  let tooltipData = null;
  let tooltipPosition = { x: 0, y: 0 };
  let chartCanvas;
  
  let metrics = {
    revenue: {
      value: 125430,
      change: 12.5,
      trend: 'up'
    },
    users: {
      value: 8942,
      change: 8.3,
      trend: 'up'
    },
    orders: {
      value: 1247,
      change: -2.1,
      trend: 'down'
    },
    conversion: {
      value: 3.24,
      change: 5.7,
      trend: 'up'
    }
  };
  
  let chartData = {
    '7d': [
      { date: '2024-01-01', revenue: 12000, users: 850, orders: 45 },
      { date: '2024-01-02', revenue: 13500, users: 920, orders: 52 },
      { date: '2024-01-03', revenue: 11800, users: 780, orders: 38 },
      { date: '2024-01-04', revenue: 14200, users: 1050, orders: 61 },
      { date: '2024-01-05', revenue: 15600, users: 1120, orders: 68 },
      { date: '2024-01-06', revenue: 13200, users: 980, orders: 48 },
      { date: '2024-01-07', revenue: 14800, users: 1080, orders: 55 }
    ],
    '30d': [
      { date: '2024-01-01', revenue: 12000, users: 850, orders: 45 },
      { date: '2024-01-02', revenue: 13500, users: 920, orders: 52 },
      { date: '2024-01-03', revenue: 11800, users: 780, orders: 38 },
      { date: '2024-01-04', revenue: 14200, users: 1050, orders: 61 },
      { date: '2024-01-05', revenue: 15600, users: 1120, orders: 68 },
      { date: '2024-01-06', revenue: 13200, users: 980, orders: 48 },
      { date: '2024-01-07', revenue: 14800, users: 1080, orders: 55 },
      { date: '2024-01-08', revenue: 16200, users: 1150, orders: 72 },
      { date: '2024-01-09', revenue: 13800, users: 950, orders: 49 },
      { date: '2024-01-10', revenue: 15400, users: 1100, orders: 66 },
      { date: '2024-01-11', revenue: 17000, users: 1200, orders: 78 },
      { date: '2024-01-12', revenue: 14600, users: 1020, orders: 58 },
      { date: '2024-01-13', revenue: 15800, users: 1140, orders: 71 },
      { date: '2024-01-14', revenue: 16400, users: 1180, orders: 75 },
      { date: '2024-01-15', revenue: 15200, users: 1080, orders: 63 },
      { date: '2024-01-16', revenue: 16800, users: 1160, orders: 73 },
      { date: '2024-01-17', revenue: 14400, users: 1000, orders: 56 },
      { date: '2024-01-18', revenue: 16000, users: 1120, orders: 69 },
      { date: '2024-01-19', revenue: 17600, users: 1240, orders: 82 },
      { date: '2024-01-20', revenue: 15000, users: 1060, orders: 61 },
      { date: '2024-01-21', revenue: 16600, users: 1140, orders: 70 },
      { date: '2024-01-22', revenue: 14200, users: 980, orders: 54 },
      { date: '2024-01-23', revenue: 15800, users: 1100, orders: 67 },
      { date: '2024-01-24', revenue: 17200, users: 1180, orders: 76 },
      { date: '2024-01-25', revenue: 14800, users: 1040, orders: 59 },
      { date: '2024-01-26', revenue: 16400, users: 1120, orders: 71 },
      { date: '2024-01-27', revenue: 18000, users: 1260, orders: 85 },
      { date: '2024-01-28', revenue: 15400, users: 1080, orders: 62 },
      { date: '2024-01-29', revenue: 17000, users: 1200, orders: 78 },
      { date: '2024-01-30', revenue: 14600, users: 1020, orders: 58 }
    ]
  };
  
  let legendItems = [
    { label: 'Revenue', color: '#4caf50', value: 'revenue' },
    { label: 'Users', color: '#2196f3', value: 'users' },
    { label: 'Orders', color: '#ff9800', value: 'orders' }
  ];
  
  onMount(() => {
    generateChart();
  });
  
  function generateChart() {
    if (!chartCanvas) return;
    
    const ctx = chartCanvas.getContext('2d');
    const width = chartCanvas.width;
    const height = chartCanvas.height;
    
    ctx.clearRect(0, 0, width, height);
    
    const padding = 40;
    const chartWidth = width - (padding * 2);
    const chartHeight = height - (padding * 2);
    
    const currentData = chartData[selectedPeriod];
    const maxValue = Math.max(...currentData.map(d => d[selectedMetric]));
    const minValue = Math.min(...currentData.map(d => d[selectedMetric]));
    
    const xStep = chartWidth / (currentData.length - 1);
    const yScale = chartHeight / (maxValue - minValue);
    
    ctx.strokeStyle = selectedMetric === 'revenue' ? '#4caf50' : 
                     selectedMetric === 'users' ? '#2196f3' : '#ff9800';
    ctx.lineWidth = 3;
    ctx.beginPath();
    
    currentData.forEach((point, index) => {
      const x = padding + (index * xStep);
      const y = padding + chartHeight - ((point[selectedMetric] - minValue) * yScale);
      
      if (index === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    });
    
    ctx.stroke();
    
    if (selectedChart === 'line') {
      ctx.fillStyle = ctx.strokeStyle + '20';
      ctx.beginPath();
      ctx.moveTo(padding, padding + chartHeight);
      
      currentData.forEach((point, index) => {
        const x = padding + (index * xStep);
        const y = padding + chartHeight - ((point[selectedMetric] - minValue) * yScale);
        ctx.lineTo(x, y);
      });
      
      ctx.lineTo(padding + chartWidth, padding + chartHeight);
      ctx.closePath();
      ctx.fill();
    }
    
    currentData.forEach((point, index) => {
      const x = padding + (index * xStep);
      const y = padding + chartHeight - ((point[selectedMetric] - minValue) * yScale);
      
      ctx.fillStyle = ctx.strokeStyle;
      ctx.beginPath();
      ctx.arc(x, y, 4, 0, 2 * Math.PI);
      ctx.fill();
    });
  }
  
  function handleChartClick(event) {
    const rect = chartCanvas.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    
    const padding = 40;
    const chartWidth = chartCanvas.width - (padding * 2);
    const xStep = chartWidth / (chartData[selectedPeriod].length - 1);
    const index = Math.round((x - padding) / xStep);
    
    if (index >= 0 && index < chartData[selectedPeriod].length) {
      const point = chartData[selectedPeriod][index];
      tooltipData = {
        date: point.date,
        value: point[selectedMetric],
        metric: selectedMetric
      };
      tooltipPosition = { x: event.clientX, y: event.clientY };
    }
  }
  
  function handleExport(format) {
    isExporting = true;
    setTimeout(() => {
      console.log(`Exporting chart as ${format}:`, chartData[selectedPeriod]);
      isExporting = false;
      alert(`Chart exported as ${format.toUpperCase()} successfully!`);
    }, 1500);
  }
  
  function formatValue(value, metric) {
    if (metric === 'revenue') {
      return `$${value.toLocaleString()}`;
    } else if (metric === 'conversion') {
      return `${value}%`;
    } else {
      return value.toLocaleString();
    }
  }
  
  function getTrendIcon(trend) {
    return trend === 'up' ? '↗' : '↘';
  }
  
  function getTrendColor(trend) {
    return trend === 'up' ? '#4caf50' : '#f44336';
  }
  
  $: currentData = chartData[selectedPeriod];
  $: currentMetric = metrics[selectedMetric];
  
  $: if (chartCanvas) {
    generateChart();
  }
</script>

<div class="dashboard-widget">
  <div class="widget-header">
    <h2>Analytics Dashboard</h2>
    <div class="header-controls">
      <button 
        on:click={() => showFilters = !showFilters}
        class="filter-toggle"
      >
        {showFilters ? 'Hide' : 'Show'} Filters
      </button>
      <button 
        on:click={() => handleExport('png')}
        disabled={isExporting}
        class="export-btn"
      >
        {isExporting ? 'Exporting...' : 'Export PNG'}
      </button>
      <button 
        on:click={() => handleExport('pdf')}
        disabled={isExporting}
        class="export-btn"
      >
        {isExporting ? 'Exporting...' : 'Export PDF'}
      </button>
    </div>
  </div>

  {#if showFilters}
    <div class="filters-panel">
      <div class="filter-row">
        <div class="filter-group">
          <label class="filter-label">Metric</label>
          <select bind:value={selectedMetric} class="filter-select">
            <option value="revenue">Revenue</option>
            <option value="users">Users</option>
            <option value="orders">Orders</option>
            <option value="conversion">Conversion Rate</option>
          </select>
        </div>
        <div class="filter-group">
          <label class="filter-label">Period</label>
          <select bind:value={selectedPeriod} class="filter-select">
            <option value="7d">Last 7 days</option>
            <option value="30d">Last 30 days</option>
            <option value="90d">Last 90 days</option>
          </select>
        </div>
        <div class="filter-group">
          <label class="filter-label">Chart Type</label>
          <select bind:value={selectedChart} class="filter-select">
            <option value="line">Line Chart</option>
            <option value="bar">Bar Chart</option>
            <option value="area">Area Chart</option>
          </select>
        </div>
      </div>
    </div>
  {/if}

  <div class="metrics-grid">
    {#each Object.entries(metrics) as [key, metric]}
      <div 
        class="metric-card"
        class:active={selectedMetric === key}
        on:click={() => selectedMetric = key}
      >
        <div class="metric-label">{key.charAt(0).toUpperCase() + key.slice(1)}</div>
        <div class="metric-value">
          {formatValue(metric.value, key)}
        </div>
        <div class="metric-change">
          <span 
            class="trend-icon"
            style="color: {getTrendColor(metric.trend)}"
          >
            {getTrendIcon(metric.trend)}
          </span>
          <span 
            class="change-value"
            style="color: {getTrendColor(metric.trend)}"
          >
            {Math.abs(metric.change)}%
          </span>
        </div>
      </div>
    {/each}
  </div>

  <div class="chart-container">
    <div class="chart-header">
      <h3>{selectedMetric.charAt(0).toUpperCase() + selectedMetric.slice(1)} Analytics</h3>
      <div class="chart-controls">
        <div class="legend">
          {#each legendItems as item}
            <div 
              class="legend-item"
              class:active={selectedMetric === item.value}
              on:click={() => selectedMetric = item.value}
            >
              <div 
                class="legend-color"
                style="background-color: {item.color}"
              ></div>
              <span class="legend-label">{item.label}</span>
            </div>
          {/each}
        </div>
      </div>
    </div>

    <div class="chart-wrapper">
      <canvas 
        bind:this={chartCanvas}
        width="800"
        height="400"
        on:click={handleChartClick}
        class="chart-canvas"
      ></canvas>
      
      {#if tooltipData}
        <div 
          class="chart-tooltip"
          style="left: {tooltipPosition.x + 10}px; top: {tooltipPosition.y - 10}px;"
        >
          <div class="tooltip-header">
            {tooltipData.date}
          </div>
          <div class="tooltip-content">
            <strong>{tooltipData.metric}:</strong> {formatValue(tooltipData.value, tooltipData.metric)}
          </div>
        </div>
      {/if}
    </div>
  </div>

  <div class="widget-footer">
    <div class="data-info">
      <span class="data-period">
        Showing data for {selectedPeriod === '7d' ? 'last 7 days' : selectedPeriod === '30d' ? 'last 30 days' : 'last 90 days'}
      </span>
      <span class="data-points">
        {currentData.length} data points
      </span>
    </div>
    <div class="refresh-info">
      <span class="last-updated">Last updated: {new Date().toLocaleTimeString()}</span>
      <button class="refresh-btn">Refresh</button>
    </div>
  </div>
</div>

<style>
  .dashboard-widget {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }

  .widget-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e0e0e0;
  }

  .widget-header h2 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .header-controls {
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
    margin-bottom: 25px;
  }

  .filter-row {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 20px;
    align-items: end;
  }

  .filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }

  .filter-label {
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .filter-select {
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    background: white;
    cursor: pointer;
    transition: border-color 0.3s ease;
  }

  .filter-select:focus {
    outline: none;
    border-color: #4caf50;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .metric-card {
    background: #f8f9fa;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
  }

  .metric-card:hover {
    border-color: #4caf50;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
  }

  .metric-card.active {
    border-color: #4caf50;
    background: #e8f5e8;
  }

  .metric-label {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 8px;
    font-weight: 600;
  }

  .metric-value {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
  }

  .metric-change {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
    font-size: 14px;
    font-weight: 600;
  }

  .trend-icon {
    font-size: 16px;
  }

  .change-value {
    font-size: 12px;
  }

  .chart-container {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
  }

  .chart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .chart-header h3 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }

  .chart-controls {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .legend {
    display: flex;
    gap: 15px;
  }

  .legend-item {
    display: flex;
    align-items: center;
    gap: 6px;
    cursor: pointer;
    padding: 4px 8px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
  }

  .legend-item:hover {
    background: #f0f0f0;
  }

  .legend-item.active {
    background: #e8f5e8;
  }

  .legend-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
  }

  .legend-label {
    font-size: 12px;
    color: #666;
    font-weight: 500;
  }

  .chart-wrapper {
    position: relative;
    background: #fafafa;
    border-radius: 6px;
    padding: 20px;
    overflow: hidden;
  }

  .chart-canvas {
    width: 100%;
    height: 400px;
    cursor: crosshair;
  }

  .chart-tooltip {
    position: fixed;
    background: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 12px;
    pointer-events: none;
    z-index: 1000;
  }

  .tooltip-header {
    font-weight: 600;
    margin-bottom: 2px;
  }

  .tooltip-content {
    font-size: 11px;
    opacity: 0.9;
  }

  .widget-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0;
    border-top: 1px solid #e0e0e0;
    font-size: 12px;
    color: #666;
  }

  .data-info {
    display: flex;
    gap: 20px;
  }

  .data-period,
  .data-points {
    font-weight: 500;
  }

  .refresh-info {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .last-updated {
    font-size: 11px;
  }

  .refresh-btn {
    padding: 4px 8px;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    font-size: 11px;
    color: #666;
    transition: all 0.3s ease;
  }

  .refresh-btn:hover {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  @media (max-width: 768px) {
    .dashboard-widget {
      padding: 15px;
    }
    
    .widget-header {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .header-controls {
      justify-content: center;
      flex-wrap: wrap;
    }
    
    .filter-row {
      grid-template-columns: 1fr;
      gap: 15px;
    }
    
    .metrics-grid {
      grid-template-columns: 1fr;
      gap: 15px;
    }
    
    .chart-header {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .chart-controls {
      justify-content: center;
    }
    
    .legend {
      flex-wrap: wrap;
      justify-content: center;
    }
    
    .widget-footer {
      flex-direction: column;
      gap: 10px;
      align-items: stretch;
    }
    
    .data-info {
      justify-content: center;
    }
    
    .refresh-info {
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .dashboard-widget {
      padding: 10px;
    }
    
    .chart-wrapper {
      padding: 10px;
    }
    
    .chart-canvas {
      height: 300px;
    }
    
    .metric-card {
      padding: 15px;
    }
    
    .metric-value {
      font-size: 20px;
    }
  }
</style>

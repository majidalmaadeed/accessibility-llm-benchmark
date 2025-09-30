<script>
  import { onMount, onDestroy } from 'svelte';
  
  let isLoading = false;
  let progress = 0;
  let loadingMessage = 'Loading...';
  let data = [];
  let loadingInterval;
  
  function startLoading() {
    isLoading = true;
    progress = 0;
    loadingMessage = 'Loading data...';
    
    // SILENT LOADING STATE - Content spinner without screen reader announcement
    loadingInterval = setInterval(() => {
      if (progress < 100) {
        progress += 2;
        updateLoadingMessage();
      } else {
        completeLoading();
      }
    }, 100);
  }
  
  function updateLoadingMessage() {
    if (progress < 30) {
      loadingMessage = 'Connecting to server...';
    } else if (progress < 60) {
      loadingMessage = 'Fetching data...';
    } else if (progress < 90) {
      loadingMessage = 'Processing results...';
    } else {
      loadingMessage = 'Finalizing...';
    }
  }
  
  function completeLoading() {
    isLoading = false;
    clearInterval(loadingInterval);
    data = generateSampleData();
    loadingMessage = 'Loading complete!';
  }
  
  function generateSampleData() {
    return [
      { id: 1, name: 'Project Alpha', status: 'Active', progress: 75 },
      { id: 2, name: 'Project Beta', status: 'Pending', progress: 25 },
      { id: 3, name: 'Project Gamma', status: 'Completed', progress: 100 },
      { id: 4, name: 'Project Delta', status: 'Active', progress: 50 },
      { id: 5, name: 'Project Epsilon', status: 'On Hold', progress: 10 }
    ];
  }
  
  function refreshData() {
    startLoading();
  }
  
  function exportData() {
    startLoading();
  }
  
  function generateReport() {
    startLoading();
  }
  
  onDestroy(() => {
    if (loadingInterval) {
      clearInterval(loadingInterval);
    }
  });
</script>

<div class="dashboard">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Data Dashboard</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={refreshData}>
          🔄 Refresh
        </button>
        <button class="header-btn" on:click={exportData}>
          📊 Export
        </button>
        <button class="header-btn" on:click={generateReport}>
          📋 Report
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Project Overview</h2>
      <p class="page-subtitle">Monitor and manage your projects</p>
    </div>
    
    <!-- SILENT LOADING STATE - Content spinner without screen reader announcement -->
    {#if isLoading}
      <div class="loading-overlay">
        <div class="loading-content">
          <div class="loading-spinner">⏳</div>
          <div class="loading-text">{loadingMessage}</div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: {progress}%"></div>
          </div>
          <div class="progress-text">{progress}%</div>
        </div>
      </div>
    {/if}
    
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon">📊</div>
        <div class="stat-content">
          <div class="stat-value">12</div>
          <div class="stat-label">Total Projects</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon">✅</div>
        <div class="stat-content">
          <div class="stat-value">8</div>
          <div class="stat-label">Completed</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon">⏳</div>
        <div class="stat-content">
          <div class="stat-value">3</div>
          <div class="stat-label">In Progress</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon">⏸️</div>
        <div class="stat-content">
          <div class="stat-value">1</div>
          <div class="stat-label">On Hold</div>
        </div>
      </div>
    </div>
    
    <div class="data-section">
      <div class="section-header">
        <h3 class="section-title">Recent Projects</h3>
        <div class="section-actions">
          <button class="action-btn" on:click={() => alert('Filter clicked')}>
            🔍 Filter
          </button>
          <button class="action-btn" on:click={() => alert('Sort clicked')}>
            ↕️ Sort
          </button>
        </div>
      </div>
      
      <div class="data-table">
        <div class="table-header">
          <div class="table-cell">Project Name</div>
          <div class="table-cell">Status</div>
          <div class="table-cell">Progress</div>
          <div class="table-cell">Actions</div>
        </div>
        
        {#each data as item}
          <div class="table-row">
            <div class="table-cell">
              <div class="project-info">
                <div class="project-icon">📁</div>
                <div class="project-name">{item.name}</div>
              </div>
            </div>
            <div class="table-cell">
              <span class="status-badge status-{item.status.toLowerCase().replace(' ', '-')}">
                {item.status}
              </span>
            </div>
            <div class="table-cell">
              <div class="progress-container">
                <div class="progress-bar-small">
                  <div class="progress-fill-small" style="width: {item.progress}%"></div>
                </div>
                <span class="progress-text">{item.progress}%</span>
              </div>
            </div>
            <div class="table-cell">
              <div class="action-buttons">
                <button class="action-btn-small" on:click={() => alert(`View ${item.name}`)}>
                  👁️
                </button>
                <button class="action-btn-small" on:click={() => alert(`Edit ${item.name}`)}>
                  ✏️
                </button>
                <button class="action-btn-small" on:click={() => alert(`Delete ${item.name}`)}>
                  🗑️
                </button>
              </div>
            </div>
          </div>
        {/each}
      </div>
    </div>
    
    <div class="activity-section">
      <h3 class="section-title">Recent Activity</h3>
      <div class="activity-list">
        <div class="activity-item">
          <div class="activity-icon">🔄</div>
          <div class="activity-content">
            <div class="activity-title">Data refreshed</div>
            <div class="activity-time">2 minutes ago</div>
          </div>
        </div>
        
        <div class="activity-item">
          <div class="activity-icon">📊</div>
          <div class="activity-content">
            <div class="activity-title">Report generated</div>
            <div class="activity-time">15 minutes ago</div>
          </div>
        </div>
        
        <div class="activity-item">
          <div class="activity-icon">📤</div>
          <div class="activity-content">
            <div class="activity-title">Data exported</div>
            <div class="activity-time">1 hour ago</div>
          </div>
        </div>
        
        <div class="activity-item">
          <div class="activity-icon">✅</div>
          <div class="activity-content">
            <div class="activity-title">Project completed</div>
            <div class="activity-time">2 hours ago</div>
          </div>
        </div>
      </div>
    </div>
  </main>
  
  <div class="status-bar">
    <div class="status-info">
      <span class="status-item">Ready</span>
      <span class="status-item">Last updated: {new Date().toLocaleTimeString()}</span>
    </div>
    <div class="status-actions">
      <button class="status-btn" on:click={() => alert('Settings clicked')}>
        ⚙️
      </button>
      <button class="status-btn" on:click={() => alert('Help clicked')}>
        ❓
      </button>
    </div>
  </div>
</div>

<style>
  .dashboard {
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
  
  .loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(248, 249, 250, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  
  .loading-content {
    background: white;
    border-radius: 12px;
    padding: 40px;
    text-align: center;
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
    max-width: 400px;
    width: 90%;
  }
  
  .loading-spinner {
    font-size: 48px;
    margin-bottom: 20px;
    animation: spin 1s linear infinite;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  .loading-text {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
  }
  
  .progress-bar {
    width: 100%;
    height: 8px;
    background: #e0e0e0;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 10px;
  }
  
  .progress-fill {
    height: 100%;
    background: #007bff;
    border-radius: 4px;
    transition: width 0.3s ease;
  }
  
  .progress-text {
    font-size: 14px;
    color: #666;
    font-weight: bold;
  }
  
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  
  .stat-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 20px;
  }
  
  .stat-icon {
    font-size: 36px;
  }
  
  .stat-content {
    display: flex;
    flex-direction: column;
  }
  
  .stat-value {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
  }
  
  .stat-label {
    font-size: 14px;
    color: #666;
    text-transform: uppercase;
  }
  
  .data-section {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
  
  .section-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .section-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .data-table {
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
  }
  
  .table-header {
    background: #f8f9fa;
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    font-weight: bold;
    color: #333;
  }
  
  .table-row {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    border-bottom: 1px solid #eee;
  }
  
  .table-row:hover {
    background: #f8f9fa;
  }
  
  .table-row:last-child {
    border-bottom: none;
  }
  
  .table-cell {
    padding: 15px;
    display: flex;
    align-items: center;
  }
  
  .project-info {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .project-icon {
    font-size: 20px;
  }
  
  .project-name {
    font-weight: bold;
    color: #333;
  }
  
  .status-badge {
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .status-active {
    background: #e3f2fd;
    color: #1976d2;
  }
  
  .status-pending {
    background: #fff3e0;
    color: #f57c00;
  }
  
  .status-completed {
    background: #e8f5e8;
    color: #388e3c;
  }
  
  .status-on-hold {
    background: #ffebee;
    color: #d32f2f;
  }
  
  .progress-container {
    display: flex;
    align-items: center;
    gap: 10px;
    width: 100%;
  }
  
  .progress-bar-small {
    flex: 1;
    height: 6px;
    background: #e0e0e0;
    border-radius: 3px;
    overflow: hidden;
  }
  
  .progress-fill-small {
    height: 100%;
    background: #007bff;
    border-radius: 3px;
    transition: width 0.3s ease;
  }
  
  .progress-text {
    font-size: 12px;
    color: #666;
    font-weight: bold;
    min-width: 35px;
  }
  
  .action-buttons {
    display: flex;
    gap: 5px;
  }
  
  .action-btn-small {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .action-btn-small:hover {
    background: #f8f9fa;
  }
  
  .activity-section {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .activity-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .activity-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }
  
  .activity-item:last-child {
    border-bottom: none;
  }
  
  .activity-icon {
    font-size: 20px;
  }
  
  .activity-content {
    flex: 1;
  }
  
  .activity-title {
    font-weight: bold;
    color: #333;
    margin-bottom: 2px;
  }
  
  .activity-time {
    font-size: 12px;
    color: #666;
  }
  
  .status-bar {
    background: #f8f9fa;
    border-top: 1px solid #ddd;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    color: #666;
  }
  
  .status-info {
    display: flex;
    gap: 20px;
  }
  
  .status-item {
    font-weight: bold;
  }
  
  .status-actions {
    display: flex;
    gap: 10px;
  }
  
  .status-btn {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .status-btn:hover {
    background: #f8f9fa;
  }
  
  @media (max-width: 768px) {
    .table-header,
    .table-row {
      grid-template-columns: 1fr;
      gap: 10px;
    }
    
    .table-cell {
      padding: 10px;
    }
    
    .stats-grid {
      grid-template-columns: 1fr;
    }
  }
</style>

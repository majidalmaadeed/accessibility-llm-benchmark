<script>
  let selectedPeriod = 'monthly';
  let selectedCategory = 'all';
  let sortBy = 'date';
  let viewMode = 'table';
  
  const salesData = [
    {
      id: 1,
      product: "Wireless Headphones",
      category: "Audio",
      date: "2024-01-15",
      quantity: 45,
      price: 199.99,
      total: 8999.55,
      region: "North America",
      salesRep: "John Smith",
      status: "Completed"
    },
    {
      id: 2,
      product: "Smart Watch",
      category: "Wearables",
      date: "2024-01-14",
      quantity: 23,
      price: 299.99,
      total: 6899.77,
      region: "Europe",
      salesRep: "Sarah Johnson",
      status: "Completed"
    },
    {
      id: 3,
      product: "Bluetooth Speaker",
      category: "Audio",
      date: "2024-01-13",
      quantity: 67,
      price: 149.99,
      total: 10049.33,
      region: "Asia",
      salesRep: "Mike Chen",
      status: "Pending"
    },
    {
      id: 4,
      product: "Gaming Mouse",
      category: "Gaming",
      date: "2024-01-12",
      quantity: 89,
      price: 79.99,
      total: 7119.11,
      region: "North America",
      salesRep: "Emily Davis",
      status: "Completed"
    },
    {
      id: 5,
      product: "Mechanical Keyboard",
      category: "Gaming",
      date: "2024-01-11",
      quantity: 34,
      price: 129.99,
      total: 4419.66,
      region: "Europe",
      salesRep: "David Wilson",
      status: "Completed"
    },
    {
      id: 6,
      product: "USB-C Hub",
      category: "Accessories",
      date: "2024-01-10",
      quantity: 156,
      price: 59.99,
      total: 9358.44,
      region: "Asia",
      salesRep: "Lisa Brown",
      status: "Completed"
    },
    {
      id: 7,
      product: "Wireless Earbuds",
      category: "Audio",
      date: "2024-01-09",
      quantity: 78,
      price: 89.99,
      total: 7019.22,
      region: "North America",
      salesRep: "Tom Anderson",
      status: "Pending"
    },
    {
      id: 8,
      product: "Fitness Tracker",
      category: "Wearables",
      date: "2024-01-08",
      quantity: 92,
      price: 79.99,
      total: 7359.08,
      region: "Europe",
      salesRep: "Anna Garcia",
      status: "Completed"
    },
    {
      id: 9,
      product: "Gaming Headset",
      category: "Gaming",
      date: "2024-01-07",
      quantity: 45,
      price: 159.99,
      total: 7199.55,
      region: "Asia",
      salesRep: "Kevin Lee",
      status: "Completed"
    },
    {
      id: 10,
      product: "Phone Case",
      category: "Accessories",
      date: "2024-01-06",
      quantity: 234,
      price: 29.99,
      total: 7017.66,
      region: "North America",
      salesRep: "Rachel Taylor",
      status: "Completed"
    }
  ];
  
  function filterData() {
    return salesData.filter(item => {
      if (selectedCategory === 'all') return true;
      return item.category === selectedCategory;
    });
  }
  
  function sortData(data) {
    return [...data].sort((a, b) => {
      switch(sortBy) {
        case 'product':
          return a.product.localeCompare(b.product);
        case 'quantity':
          return b.quantity - a.quantity;
        case 'total':
          return b.total - a.total;
        case 'date':
        default:
          return new Date(b.date) - new Date(a.date);
      }
    });
  }
  
  function getTotalSales(data) {
    return data.reduce((sum, item) => sum + item.total, 0);
  }
  
  function getTotalQuantity(data) {
    return data.reduce((sum, item) => sum + item.quantity, 0);
  }
  
  $: filteredData = sortData(filterData());
  $: totalSales = getTotalSales(filteredData);
  $: totalQuantity = getTotalQuantity(filteredData);
</script>

<div class="sales-dashboard">
  <header class="dashboard-header">
    <div class="header-content">
      <h1 class="dashboard-title">Sales Analytics Dashboard</h1>
      <p class="dashboard-subtitle">Comprehensive sales data and performance metrics</p>
    </div>
    
    <div class="period-selector">
      <button 
        class="period-btn" 
        class:active={selectedPeriod === 'weekly'}
        on:click={() => selectedPeriod = 'weekly'}
      >
        Weekly
      </button>
      <button 
        class="period-btn" 
        class:active={selectedPeriod === 'monthly'}
        on:click={() => selectedPeriod = 'monthly'}
      >
        Monthly
      </button>
      <button 
        class="period-btn" 
        class:active={selectedPeriod === 'yearly'}
        on:click={() => selectedPeriod = 'yearly'}
      >
        Yearly
      </button>
    </div>
  </header>

  <div class="dashboard-controls">
    <div class="control-group">
      <label class="control-label">Category Filter:</label>
      <select bind:value={selectedCategory} class="control-select">
        <option value="all">All Categories</option>
        <option value="Audio">Audio</option>
        <option value="Wearables">Wearables</option>
        <option value="Gaming">Gaming</option>
        <option value="Accessories">Accessories</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort By:</label>
      <select bind:value={sortBy} class="control-select">
        <option value="date">Date</option>
        <option value="product">Product</option>
        <option value="quantity">Quantity</option>
        <option value="total">Total Sales</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">View:</label>
      <div class="view-toggle">
        <button 
          class="view-btn" 
          class:active={viewMode === 'table'}
          on:click={() => viewMode = 'table'}
        >
          Table
        </button>
        <button 
          class="view-btn" 
          class:active={viewMode === 'cards'}
          on:click={() => viewMode = 'cards'}
        >
          Cards
        </button>
      </div>
    </div>
  </div>

  <div class="summary-cards">
    <div class="summary-card">
      <div class="card-icon">📊</div>
      <div class="card-content">
        <h3 class="card-title">Total Sales</h3>
        <p class="card-value">${totalSales.toLocaleString()}</p>
        <p class="card-change">+12.5% from last period</p>
      </div>
    </div>
    
    <div class="summary-card">
      <div class="card-icon">📦</div>
      <div class="card-content">
        <h3 class="card-title">Items Sold</h3>
        <p class="card-value">{totalQuantity.toLocaleString()}</p>
        <p class="card-change">+8.3% from last period</p>
      </div>
    </div>
    
    <div class="summary-card">
      <div class="card-icon">💰</div>
      <div class="card-content">
        <h3 class="card-title">Average Order</h3>
        <p class="card-value">${(totalSales / filteredData.length).toFixed(2)}</p>
        <p class="card-change">+5.2% from last period</p>
      </div>
    </div>
    
    <div class="summary-card">
      <div class="card-icon">✅</div>
      <div class="card-content">
        <h3 class="card-title">Completion Rate</h3>
        <p class="card-value">{((filteredData.filter(item => item.status === 'Completed').length / filteredData.length) * 100).toFixed(1)}%</p>
        <p class="card-change">+2.1% from last period</p>
      </div>
    </div>
  </div>

  <div class="data-section">
    <div class="section-header">
      <h2 class="section-title">Sales Transactions</h2>
      <div class="section-info">
        <span class="record-count">{filteredData.length} records</span>
        <span class="last-updated">Last updated: {new Date().toLocaleString()}</span>
      </div>
    </div>
    
    {#if viewMode === 'table'}
      <div class="table-container">
        <table class="sales-table">
          <tr class="table-row header-row">
            <td class="table-cell header-cell">Product</td>
            <td class="table-cell header-cell">Category</td>
            <td class="table-cell header-cell">Date</td>
            <td class="table-cell header-cell">Quantity</td>
            <td class="table-cell header-cell">Unit Price</td>
            <td class="table-cell header-cell">Total</td>
            <td class="table-cell header-cell">Region</td>
            <td class="table-cell header-cell">Sales Rep</td>
            <td class="table-cell header-cell">Status</td>
            <td class="table-cell header-cell">Actions</td>
          </tr>
          
          {#each filteredData as item (item.id)}
            <tr class="table-row data-row">
              <td class="table-cell data-cell product-cell">
                <div class="product-info">
                  <div class="product-name">{item.product}</div>
                  <div class="product-id">ID: {item.id}</div>
                </div>
              </td>
              <td class="table-cell data-cell">
                <span class="category-badge" class:audio={item.category === 'Audio'} class:wearables={item.category === 'Wearables'} class:gaming={item.category === 'Gaming'} class:accessories={item.category === 'Accessories'}>
                  {item.category}
                </span>
              </td>
              <td class="table-cell data-cell">
                <div class="date-info">
                  <div class="date-value">{new Date(item.date).toLocaleDateString()}</div>
                  <div class="date-time">{new Date(item.date).toLocaleTimeString()}</div>
                </div>
              </td>
              <td class="table-cell data-cell quantity-cell">
                <div class="quantity-display">
                  <span class="quantity-value">{item.quantity}</span>
                  <span class="quantity-unit">units</span>
                </div>
              </td>
              <td class="table-cell data-cell price-cell">
                <div class="price-display">
                  <span class="currency">$</span>
                  <span class="price-value">{item.price.toFixed(2)}</span>
                </div>
              </td>
              <td class="table-cell data-cell total-cell">
                <div class="total-display">
                  <span class="currency">$</span>
                  <span class="total-value">{item.total.toFixed(2)}</span>
                </div>
              </td>
              <td class="table-cell data-cell">
                <div class="region-info">
                  <span class="region-flag">🌍</span>
                  <span class="region-name">{item.region}</span>
                </div>
              </td>
              <td class="table-cell data-cell">
                <div class="salesrep-info">
                  <div class="salesrep-name">{item.salesRep}</div>
                  <div class="salesrep-email">{item.salesRep.toLowerCase().replace(' ', '.')}@company.com</div>
                </div>
              </td>
              <td class="table-cell data-cell">
                <span class="status-badge" class:completed={item.status === 'Completed'} class:pending={item.status === 'Pending'}>
                  {item.status}
                </span>
              </td>
              <td class="table-cell data-cell actions-cell">
                <div class="action-buttons">
                  <button class="action-btn view-btn">👁</button>
                  <button class="action-btn edit-btn">✏️</button>
                  <button class="action-btn delete-btn">🗑️</button>
                </div>
              </td>
            </tr>
          {/each}
        </table>
      </div>
    {:else}
      <div class="cards-container">
        {#each filteredData as item (item.id)}
          <div class="sales-card">
            <div class="card-header">
              <div class="product-info">
                <h3 class="product-name">{item.product}</h3>
                <span class="product-id">#{item.id}</span>
              </div>
              <span class="status-badge" class:completed={item.status === 'Completed'} class:pending={item.status === 'Pending'}>
                {item.status}
              </span>
            </div>
            
            <div class="card-body">
              <div class="info-grid">
                <div class="info-item">
                  <label class="info-label">Category:</label>
                  <span class="category-badge" class:audio={item.category === 'Audio'} class:wearables={item.category === 'Wearables'} class:gaming={item.category === 'Gaming'} class:accessories={item.category === 'Accessories'}>
                    {item.category}
                  </span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Date:</label>
                  <span class="info-value">{new Date(item.date).toLocaleDateString()}</span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Quantity:</label>
                  <span class="info-value">{item.quantity} units</span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Unit Price:</label>
                  <span class="info-value">${item.price.toFixed(2)}</span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Total:</label>
                  <span class="info-value total-value">${item.total.toFixed(2)}</span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Region:</label>
                  <span class="info-value">🌍 {item.region}</span>
                </div>
                
                <div class="info-item">
                  <label class="info-label">Sales Rep:</label>
                  <span class="info-value">{item.salesRep}</span>
                </div>
              </div>
            </div>
            
            <div class="card-footer">
              <div class="action-buttons">
                <button class="action-btn view-btn">View Details</button>
                <button class="action-btn edit-btn">Edit</button>
                <button class="action-btn delete-btn">Delete</button>
              </div>
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="export-section">
    <div class="export-controls">
      <h3 class="export-title">Export Data</h3>
      <p class="export-description">Download your sales data in various formats</p>
      <div class="export-buttons">
        <button class="export-btn csv-btn">Export as CSV</button>
        <button class="export-btn excel-btn">Export as Excel</button>
        <button class="export-btn pdf-btn">Export as PDF</button>
      </div>
    </div>
  </div>
</div>

<style>
  .sales-dashboard {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
  }
  
  .dashboard-header {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .header-content {
    flex: 1;
  }
  
  .dashboard-title {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }
  
  .dashboard-subtitle {
    margin: 0;
    font-size: 16px;
    color: #666;
  }
  
  .period-selector {
    display: flex;
    gap: 10px;
  }
  
  .period-btn {
    padding: 10px 20px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .period-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .period-btn:hover:not(.active) {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .dashboard-controls {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    display: flex;
    gap: 30px;
    align-items: center;
  }
  
  .control-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .control-label {
    font-weight: bold;
    color: #333;
    white-space: nowrap;
  }
  
  .control-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
    min-width: 150px;
  }
  
  .view-toggle {
    display: flex;
    gap: 5px;
  }
  
  .view-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .view-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .view-btn:hover:not(.active) {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .summary-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }
  
  .summary-card {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 20px;
  }
  
  .card-icon {
    font-size: 32px;
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
    border-radius: 50%;
  }
  
  .card-content {
    flex: 1;
  }
  
  .card-title {
    margin: 0 0 8px 0;
    font-size: 14px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .card-value {
    margin: 0 0 5px 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }
  
  .card-change {
    margin: 0;
    font-size: 12px;
    color: #28a745;
  }
  
  .data-section {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    overflow: hidden;
  }
  
  .section-header {
    padding: 25px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .section-title {
    margin: 0;
    font-size: 20px;
    color: #333;
  }
  
  .section-info {
    display: flex;
    gap: 20px;
    font-size: 14px;
    color: #666;
  }
  
  .table-container {
    overflow-x: auto;
  }
  
  .sales-table {
    width: 100%;
    border-collapse: collapse;
  }
  
  .table-row {
    border-bottom: 1px solid #eee;
  }
  
  .header-row {
    background: #f8f9fa;
  }
  
  .data-row:hover {
    background: #f8f9fa;
  }
  
  .table-cell {
    padding: 15px 12px;
    text-align: left;
    vertical-align: top;
  }
  
  .header-cell {
    font-weight: bold;
    color: #333;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .data-cell {
    font-size: 14px;
    color: #555;
  }
  
  .product-cell {
    min-width: 200px;
  }
  
  .product-info {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
  
  .product-name {
    font-weight: bold;
    color: #333;
  }
  
  .product-id {
    font-size: 12px;
    color: #666;
  }
  
  .category-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .category-badge.audio {
    background: #e3f2fd;
    color: #1976d2;
  }
  
  .category-badge.wearables {
    background: #f3e5f5;
    color: #7b1fa2;
  }
  
  .category-badge.gaming {
    background: #e8f5e8;
    color: #388e3c;
  }
  
  .category-badge.accessories {
    background: #fff3e0;
    color: #f57c00;
  }
  
  .date-info {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .date-value {
    font-weight: bold;
    color: #333;
  }
  
  .date-time {
    font-size: 12px;
    color: #666;
  }
  
  .quantity-display {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2px;
  }
  
  .quantity-value {
    font-weight: bold;
    color: #333;
    font-size: 16px;
  }
  
  .quantity-unit {
    font-size: 12px;
    color: #666;
  }
  
  .price-display,
  .total-display {
    display: flex;
    align-items: baseline;
    gap: 2px;
  }
  
  .currency {
    font-size: 12px;
    color: #666;
  }
  
  .price-value,
  .total-value {
    font-weight: bold;
    color: #333;
  }
  
  .total-value {
    font-size: 16px;
    color: #007bff;
  }
  
  .region-info {
    display: flex;
    align-items: center;
    gap: 5px;
  }
  
  .region-flag {
    font-size: 16px;
  }
  
  .region-name {
    font-weight: bold;
    color: #333;
  }
  
  .salesrep-info {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .salesrep-name {
    font-weight: bold;
    color: #333;
  }
  
  .salesrep-email {
    font-size: 12px;
    color: #666;
  }
  
  .status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .status-badge.completed {
    background: #d4edda;
    color: #155724;
  }
  
  .status-badge.pending {
    background: #fff3cd;
    color: #856404;
  }
  
  .actions-cell {
    min-width: 120px;
  }
  
  .action-buttons {
    display: flex;
    gap: 8px;
  }
  
  .action-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s ease;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .cards-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
    gap: 20px;
    padding: 25px;
  }
  
  .sales-card {
    background: white;
    border: 1px solid #eee;
    border-radius: 12px;
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .sales-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  }
  
  .card-header {
    padding: 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .card-body {
    padding: 20px;
  }
  
  .info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
  }
  
  .info-item {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
  
  .info-label {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .info-value {
    font-weight: bold;
    color: #333;
  }
  
  .total-value {
    color: #007bff;
    font-size: 18px;
  }
  
  .card-footer {
    padding: 20px;
    border-top: 1px solid #eee;
    background: #f8f9fa;
  }
  
  .export-section {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    text-align: center;
  }
  
  .export-title {
    margin: 0 0 10px 0;
    font-size: 20px;
    color: #333;
  }
  
  .export-description {
    margin: 0 0 25px 0;
    color: #666;
  }
  
  .export-buttons {
    display: flex;
    gap: 15px;
    justify-content: center;
  }
  
  .export-btn {
    padding: 12px 24px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .export-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .csv-btn:hover {
    background: #e8f5e8;
    border-color: #28a745;
    color: #28a745;
  }
  
  .excel-btn:hover {
    background: #e3f2fd;
    border-color: #1976d2;
    color: #1976d2;
  }
  
  .pdf-btn:hover {
    background: #ffebee;
    border-color: #dc3545;
    color: #dc3545;
  }
  
  @media (max-width: 768px) {
    .dashboard-header {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .period-selector {
      justify-content: center;
    }
    
    .dashboard-controls {
      flex-direction: column;
      gap: 20px;
    }
    
    .control-group {
      justify-content: space-between;
    }
    
    .summary-cards {
      grid-template-columns: 1fr;
    }
    
    .section-header {
      flex-direction: column;
      gap: 10px;
      align-items: stretch;
    }
    
    .section-info {
      justify-content: center;
    }
    
    .cards-container {
      grid-template-columns: 1fr;
    }
    
    .info-grid {
      grid-template-columns: 1fr;
    }
    
    .export-buttons {
      flex-direction: column;
    }
  }
</style>

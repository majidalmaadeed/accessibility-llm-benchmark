<template>
  <div class="data-visualization-dashboard">
    <header class="dashboard-header">
      <div class="header-content">
        <h1 class="dashboard-title">Analytics Dashboard</h1>
        <div class="header-actions">
          <button class="action-btn">Export Data</button>
          <button class="action-btn">Settings</button>
          <button class="action-btn">Help</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="dashboard-grid">
        <div class="metrics-section">
          <h2 class="section-title">Key Performance Indicators</h2>
          <div class="metrics-grid">
            <div class="metric-card">
              <div class="metric-header">
                <h3 class="metric-title">Total Revenue</h3>
                <div class="metric-icon" title="Revenue from all sources including subscriptions, one-time purchases, and partnerships">
                  <img src="/api/placeholder/20/20" alt="Revenue Icon" />
                </div>
              </div>
              <div class="metric-value">$2,847,392</div>
              <div class="metric-change positive">+12.5% from last month</div>
            </div>

            <div class="metric-card">
              <div class="metric-header">
                <h3 class="metric-title">Active Users</h3>
                <div class="metric-icon" title="Number of users who have logged in within the last 30 days">
                  <img src="/api/placeholder/20/20" alt="Users Icon" />
                </div>
              </div>
              <div class="metric-value">156,789</div>
              <div class="metric-change positive">+8.2% from last month</div>
            </div>

            <div class="metric-card">
              <div class="metric-header">
                <h3 class="metric-title">Conversion Rate</h3>
                <div class="metric-icon" title="Percentage of visitors who complete a desired action">
                  <img src="/api/placeholder/20/20" alt="Conversion Icon" />
                </div>
              </div>
              <div class="metric-value">3.24%</div>
              <div class="metric-change negative">-0.3% from last month</div>
            </div>

            <div class="metric-card">
              <div class="metric-header">
                <h3 class="metric-title">Average Order Value</h3>
                <div class="metric-icon" title="Average amount spent per transaction">
                  <img src="/api/placeholder/20/20" alt="Order Icon" />
                </div>
              </div>
              <div class="metric-value">$89.45</div>
              <div class="metric-change positive">+5.7% from last month</div>
            </div>
          </div>
        </div>

        <div class="charts-section">
          <div class="chart-container">
            <div class="chart-header">
              <h3 class="chart-title">Revenue Trends</h3>
              <div class="chart-controls">
                <button class="control-btn" title="View daily breakdown">Daily</button>
                <button class="control-btn active" title="View weekly breakdown">Weekly</button>
                <button class="control-btn" title="View monthly breakdown">Monthly</button>
                <button class="control-btn" title="View yearly breakdown">Yearly</button>
              </div>
            </div>
            <div class="chart-content">
              <div class="chart-placeholder">
                <img src="/api/placeholder/600/300" alt="Revenue Trends Chart" />
                <div class="chart-overlay">
                  <div class="chart-tooltip" title="Hover over data points for detailed information">
                    Interactive Chart
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="chart-container">
            <div class="chart-header">
              <h3 class="chart-title">User Acquisition</h3>
              <div class="chart-legend">
                <div class="legend-item">
                  <div class="legend-color organic"></div>
                  <span class="legend-label">Organic</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color paid"></div>
                  <span class="legend-label">Paid</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color referral"></div>
                  <span class="legend-label">Referral</span>
                </div>
              </div>
            </div>
            <div class="chart-content">
              <div class="chart-placeholder">
                <img src="/api/placeholder/600/300" alt="User Acquisition Chart" />
                <div class="chart-overlay">
                  <div class="chart-tooltip" title="Click on segments to see detailed breakdown">
                    Clickable Segments
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="data-table-section">
          <div class="table-header">
            <h3 class="table-title">Top Performing Products</h3>
            <div class="table-controls">
              <button class="table-btn" title="Sort by name">Name</button>
              <button class="table-btn" title="Sort by revenue">Revenue</button>
              <button class="table-btn" title="Sort by units sold">Units</button>
              <button class="table-btn" title="Sort by rating">Rating</button>
            </div>
          </div>
          <div class="table-container">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Product Name</th>
                  <th>Revenue</th>
                  <th>Units Sold</th>
                  <th>Rating</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="product in topProducts" :key="product.id">
                  <td>
                    <div class="product-info">
                      <img :src="product.image" :alt="product.name" class="product-image" />
                      <div class="product-details">
                        <div class="product-name">{{ product.name }}</div>
                        <div class="product-category">{{ product.category }}</div>
                      </div>
                    </div>
                  </td>
                  <td class="revenue-cell">${{ product.revenue.toLocaleString() }}</td>
                  <td class="units-cell">{{ product.units.toLocaleString() }}</td>
                  <td class="rating-cell">
                    <div class="rating-display">
                      <span class="rating-stars">{{ product.rating }}</span>
                      <div class="rating-icon" title="Based on {{ product.reviews }} customer reviews">
                        <img src="/api/placeholder/16/16" alt="Rating Icon" />
                      </div>
                    </div>
                  </td>
                  <td class="actions-cell">
                    <div class="action-buttons">
                      <button class="action-icon" title="View product details">View</button>
                      <button class="action-icon" title="Edit product information">Edit</button>
                      <button class="action-icon" title="View product analytics">Analytics</button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="filters-section">
          <h3 class="section-title">Data Filters</h3>
          <div class="filters-grid">
            <div class="filter-group">
              <label class="filter-label">Date Range</label>
              <select class="filter-select">
                <option value="7d">Last 7 days</option>
                <option value="30d" selected>Last 30 days</option>
                <option value="90d">Last 90 days</option>
                <option value="1y">Last year</option>
              </select>
            </div>
            
            <div class="filter-group">
              <label class="filter-label">Region</label>
              <select class="filter-select">
                <option value="all">All Regions</option>
                <option value="na">North America</option>
                <option value="eu">Europe</option>
                <option value="ap">Asia Pacific</option>
              </select>
            </div>
            
            <div class="filter-group">
              <label class="filter-label">Product Category</label>
              <select class="filter-select">
                <option value="all">All Categories</option>
                <option value="electronics">Electronics</option>
                <option value="clothing">Clothing</option>
                <option value="books">Books</option>
              </select>
            </div>
            
            <div class="filter-group">
              <label class="filter-label">Customer Segment</label>
              <select class="filter-select">
                <option value="all">All Segments</option>
                <option value="new">New Customers</option>
                <option value="returning">Returning Customers</option>
                <option value="vip">VIP Customers</option>
              </select>
            </div>
          </div>
          
          <div class="filter-actions">
            <button class="btn primary">Apply Filters</button>
            <button class="btn secondary">Reset</button>
            <button class="btn secondary" title="Save current filter configuration">Save Filters</button>
          </div>
        </div>

        <div class="insights-section">
          <h3 class="section-title">AI-Powered Insights</h3>
          <div class="insights-grid">
            <div class="insight-card">
              <div class="insight-header">
                <h4 class="insight-title">Revenue Optimization</h4>
                <div class="insight-icon" title="AI-generated recommendation based on historical data">
                  <img src="/api/placeholder/24/24" alt="AI Icon" />
                </div>
              </div>
              <p class="insight-text">
                Consider increasing prices by 5% for electronics category during Q4. 
                Historical data shows 15% higher conversion rates with minimal impact on volume.
              </p>
              <div class="insight-actions">
                <button class="insight-btn primary">Implement</button>
                <button class="insight-btn secondary">Learn More</button>
              </div>
            </div>

            <div class="insight-card">
              <div class="insight-header">
                <h4 class="insight-title">User Engagement</h4>
                <div class="insight-icon" title="Pattern detected in user behavior data">
                  <img src="/api/placeholder/24/24" alt="Engagement Icon" />
                </div>
              </div>
              <p class="insight-text">
                Users who engage with product videos are 3x more likely to convert. 
                Consider adding video content to underperforming product pages.
              </p>
              <div class="insight-actions">
                <button class="insight-btn primary">View Details</button>
                <button class="insight-btn secondary">Dismiss</button>
              </div>
            </div>

            <div class="insight-card">
              <div class="insight-header">
                <h4 class="insight-title">Seasonal Trends</h4>
                <div class="insight-icon" title="Seasonal pattern analysis based on multi-year data">
                  <img src="/api/placeholder/24/24" alt="Trends Icon" />
                </div>
              </div>
              <p class="insight-text">
                Prepare for 40% increase in clothing sales next month. 
                Historical data indicates strong seasonal demand for winter apparel.
              </p>
              <div class="insight-actions">
                <button class="insight-btn primary">Prepare Inventory</button>
                <button class="insight-btn secondary">View Forecast</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <footer class="dashboard-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Analytics</h4>
          <ul class="footer-links">
            <li><a href="/revenue">Revenue Analytics</a></li>
            <li><a href="/users">User Analytics</a></li>
            <li><a href="/products">Product Analytics</a></li>
            <li><a href="/conversion">Conversion Tracking</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Reports</h4>
          <ul class="footer-links">
            <li><a href="/daily">Daily Reports</a></li>
            <li><a href="/weekly">Weekly Reports</a></li>
            <li><a href="/monthly">Monthly Reports</a></li>
            <li><a href="/custom">Custom Reports</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Tools</h4>
          <ul class="footer-links">
            <li><a href="/export">Data Export</a></li>
            <li><a href="/api">API Access</a></li>
            <li><a href="/integrations">Integrations</a></li>
            <li><a href="/alerts">Alert Settings</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Support</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/documentation">Documentation</a></li>
            <li><a href="/contact">Contact Support</a></li>
            <li><a href="/feedback">Feedback</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 Analytics Dashboard. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
const topProducts = ref([
  {
    id: 1,
    name: 'Wireless Headphones Pro',
    category: 'Electronics',
    revenue: 125000,
    units: 2500,
    rating: 4.8,
    reviews: 1247,
    image: '/api/placeholder/40/40'
  },
  {
    id: 2,
    name: 'Smart Fitness Watch',
    category: 'Electronics',
    revenue: 98000,
    units: 1960,
    rating: 4.6,
    reviews: 892,
    image: '/api/placeholder/40/40'
  },
  {
    id: 3,
    name: 'Organic Cotton T-Shirt',
    category: 'Clothing',
    revenue: 45000,
    units: 9000,
    rating: 4.9,
    reviews: 2156,
    image: '/api/placeholder/40/40'
  },
  {
    id: 4,
    name: 'Programming Book Bundle',
    category: 'Books',
    revenue: 32000,
    units: 1600,
    rating: 4.7,
    reviews: 445,
    image: '/api/placeholder/40/40'
  },
  {
    id: 5,
    name: 'Smart Home Hub',
    category: 'Electronics',
    revenue: 28000,
    units: 560,
    rating: 4.4,
    reviews: 234,
    image: '/api/placeholder/40/40'
  }
])
</script>

<style scoped>
.data-visualization-dashboard {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.dashboard-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px;
}

.dashboard-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.action-btn {
  padding: 10px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 30px 20px;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 30px;
}

.section-title {
  margin: 0 0 20px 0;
  font-size: 20px;
  color: #333;
}

.metrics-section {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
}

.metric-card {
  padding: 25px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
  transition: transform 0.2s ease;
}

.metric-card:hover {
  transform: translateY(-2px);
}

.metric-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.metric-title {
  margin: 0;
  font-size: 16px;
  color: #666;
  font-weight: 500;
}

.metric-icon {
  width: 20px;
  height: 20px;
  cursor: help;
}

.metric-icon img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.metric-value {
  font-size: 32px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}

.metric-change {
  font-size: 14px;
  font-weight: 500;
}

.metric-change.positive {
  color: #28a745;
}

.metric-change.negative {
  color: #dc3545;
}

.charts-section {
  display: grid;
  grid-template-columns: 1fr;
  gap: 30px;
}

.chart-container {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.chart-title {
  margin: 0;
  font-size: 18px;
  color: #333;
}

.chart-controls {
  display: flex;
  gap: 8px;
}

.control-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s ease;
}

.control-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.control-btn.active {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.chart-legend {
  display: flex;
  gap: 20px;
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

.legend-color.organic {
  background: #007bff;
}

.legend-color.paid {
  background: #28a745;
}

.legend-color.referral {
  background: #ffc107;
}

.legend-label {
  font-size: 14px;
  color: #666;
}

.chart-content {
  position: relative;
}

.chart-placeholder {
  position: relative;
  width: 100%;
  height: 300px;
  background: #f8f9fa;
  border-radius: 8px;
  overflow: hidden;
}

.chart-placeholder img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.chart-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  justify-content: center;
}

.chart-tooltip {
  background: rgba(0,0,0,0.8);
  color: white;
  padding: 8px 16px;
  border-radius: 4px;
  font-size: 14px;
  cursor: help;
}

.data-table-section {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.table-title {
  margin: 0;
  font-size: 18px;
  color: #333;
}

.table-controls {
  display: flex;
  gap: 8px;
}

.table-btn {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  transition: all 0.2s ease;
}

.table-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.table-container {
  overflow-x: auto;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
}

.data-table th,
.data-table td {
  padding: 15px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.data-table th {
  background: #f8f9fa;
  font-weight: bold;
  color: #333;
}

.product-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.product-image {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.product-details {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.product-name {
  font-weight: bold;
  color: #333;
}

.product-category {
  font-size: 12px;
  color: #666;
}

.revenue-cell,
.units-cell {
  font-weight: bold;
  color: #333;
}

.rating-display {
  display: flex;
  align-items: center;
  gap: 8px;
}

.rating-stars {
  font-weight: bold;
  color: #333;
}

.rating-icon {
  width: 16px;
  height: 16px;
  cursor: help;
}

.rating-icon img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.actions-cell {
  text-align: center;
}

.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: center;
}

.action-icon {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  transition: all 0.2s ease;
}

.action-icon:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.filters-section {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.filters-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.filter-label {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.filter-select {
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.filter-select:focus {
  outline: none;
  border-color: #007bff;
}

.filter-actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn.primary {
  background: #007bff;
  color: white;
}

.btn.primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.btn.secondary {
  background: #6c757d;
  color: white;
}

.btn.secondary:hover {
  background: #545b62;
}

.insights-section {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.insights-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 20px;
}

.insight-card {
  padding: 25px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
  transition: transform 0.2s ease;
}

.insight-card:hover {
  transform: translateY(-2px);
}

.insight-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.insight-title {
  margin: 0;
  font-size: 16px;
  color: #333;
  font-weight: bold;
}

.insight-icon {
  width: 24px;
  height: 24px;
  cursor: help;
}

.insight-icon img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.insight-text {
  margin: 0 0 20px 0;
  color: #666;
  line-height: 1.5;
}

.insight-actions {
  display: flex;
  gap: 10px;
}

.insight-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.insight-btn.primary {
  background: #007bff;
  color: white;
}

.insight-btn.primary:hover {
  background: #0056b3;
}

.insight-btn.secondary {
  background: #6c757d;
  color: white;
}

.insight-btn.secondary:hover {
  background: #545b62;
}

.dashboard-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 1024px) {
  .charts-section {
    grid-template-columns: 1fr;
  }
  
  .filters-grid {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  }
  
  .insights-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    height: auto;
    padding: 20px;
  }

  .header-actions {
    flex-wrap: wrap;
    justify-content: center;
  }

  .main-content {
    padding: 20px;
  }

  .metrics-grid {
    grid-template-columns: 1fr;
  }

  .chart-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }

  .chart-controls {
    justify-content: center;
  }

  .table-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }

  .table-controls {
    justify-content: center;
  }

  .filter-actions {
    justify-content: center;
  }

  .insight-actions {
    flex-direction: column;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .section-title {
    font-size: 18px;
  }

  .metric-value {
    font-size: 24px;
  }

  .chart-placeholder {
    height: 200px;
  }

  .action-buttons {
    flex-direction: column;
  }

  .insight-card {
    padding: 20px;
  }
}
</style>

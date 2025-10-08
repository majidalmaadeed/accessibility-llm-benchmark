<template>
  <div class="data-dashboard">
    <header class="dashboard-header">
      <h1>Analytics Dashboard</h1>
      <div class="header-controls">
        <select v-model="selectedPeriod" class="period-select">
          <option value="7d">Last 7 Days</option>
          <option value="30d">Last 30 Days</option>
          <option value="90d">Last 90 Days</option>
          <option value="1y">Last Year</option>
        </select>
        <button class="export-btn">Export Data</button>
      </div>
    </header>

    <div class="dashboard-content">
      <div class="stats-overview">
        <div class="stat-card">
          <div class="stat-icon">👥</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.totalUsers }}</div>
            <div class="stat-label">Total Users</div>
            <div class="stat-change positive">+12.5%</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">📊</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.totalRevenue }}</div>
            <div class="stat-label">Revenue</div>
            <div class="stat-change positive">+8.3%</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">🛒</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.totalOrders }}</div>
            <div class="stat-label">Orders</div>
            <div class="stat-change negative">-2.1%</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">📈</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.conversionRate }}%</div>
            <div class="stat-label">Conversion Rate</div>
            <div class="stat-change positive">+1.2%</div>
          </div>
        </div>
      </div>

      <div class="data-tables">
        <div class="table-section">
          <h2>User Activity</h2>
          <div class="table-container">
            <table class="data-table">
              <tbody>
                <tr v-for="user in userActivity" :key="user.id" class="table-row">
                  <td class="user-info">
                    <div class="user-avatar">
                      <img :src="user.avatar" :alt="user.name" />
                    </div>
                    <div class="user-details">
                      <div class="user-name">{{ user.name }}</div>
                      <div class="user-email">{{ user.email }}</div>
                    </div>
                  </td>
                  <td class="activity-type">{{ user.activity }}</td>
                  <td class="activity-time">{{ formatTime(user.timestamp) }}</td>
                  <td class="activity-duration">{{ user.duration }}</td>
                  <td class="activity-status">
                    <span class="status-badge" :class="user.status">{{ user.status }}</span>
                  </td>
                  <td class="activity-actions">
                    <button class="action-btn">View</button>
                    <button class="action-btn">Edit</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="table-section">
          <h2>Sales Performance</h2>
          <div class="table-container">
            <table class="data-table">
              <tbody>
                <tr v-for="sale in salesData" :key="sale.id" class="table-row">
                  <td class="sale-id">#{{ sale.id }}</td>
                  <td class="sale-product">
                    <div class="product-info">
                      <img :src="sale.productImage" :alt="sale.productName" class="product-image" />
                      <span class="product-name">{{ sale.productName }}</span>
                    </div>
                  </td>
                  <td class="sale-customer">{{ sale.customer }}</td>
                  <td class="sale-amount">${{ sale.amount }}</td>
                  <td class="sale-quantity">{{ sale.quantity }}</td>
                  <td class="sale-date">{{ formatDate(sale.date) }}</td>
                  <td class="sale-status">
                    <span class="status-badge" :class="sale.status">{{ sale.status }}</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="table-section">
          <h2>Website Traffic</h2>
          <div class="table-container">
            <table class="data-table">
              <tbody>
                <tr v-for="page in trafficData" :key="page.id" class="table-row">
                  <td class="page-url">{{ page.url }}</td>
                  <td class="page-title">{{ page.title }}</td>
                  <td class="page-views">{{ page.views.toLocaleString() }}</td>
                  <td class="page-unique">{{ page.uniqueVisitors.toLocaleString() }}</td>
                  <td class="page-bounce">{{ page.bounceRate }}%</td>
                  <td class="page-time">{{ page.avgTimeOnPage }}</td>
                  <td class="page-source">{{ page.trafficSource }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="table-section">
          <h2>Product Inventory</h2>
          <div class="table-container">
            <table class="data-table">
              <tbody>
                <tr v-for="product in inventoryData" :key="product.id" class="table-row">
                  <td class="product-sku">{{ product.sku }}</td>
                  <td class="product-details">
                    <div class="product-info">
                      <img :src="product.image" :alt="product.name" class="product-image" />
                      <div class="product-text">
                        <div class="product-name">{{ product.name }}</div>
                        <div class="product-category">{{ product.category }}</div>
                      </div>
                    </div>
                  </td>
                  <td class="product-price">${{ product.price }}</td>
                  <td class="product-stock">{{ product.stock }}</td>
                  <td class="product-sold">{{ product.sold }}</td>
                  <td class="product-revenue">${{ product.revenue }}</td>
                  <td class="product-trend">
                    <span class="trend-indicator" :class="product.trend">
                      {{ product.trend === 'up' ? '↗️' : product.trend === 'down' ? '↘️' : '→' }}
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="table-section">
          <h2>Customer Support Tickets</h2>
          <div class="table-container">
            <table class="data-table">
              <tbody>
                <tr v-for="ticket in supportTickets" :key="ticket.id" class="table-row">
                  <td class="ticket-id">#{{ ticket.id }}</td>
                  <td class="ticket-subject">{{ ticket.subject }}</td>
                  <td class="ticket-customer">{{ ticket.customer }}</td>
                  <td class="ticket-priority">
                    <span class="priority-badge" :class="ticket.priority">{{ ticket.priority }}</span>
                  </td>
                  <td class="ticket-assignee">{{ ticket.assignee }}</td>
                  <td class="ticket-created">{{ formatDate(ticket.created) }}</td>
                  <td class="ticket-status">
                    <span class="status-badge" :class="ticket.status">{{ ticket.status }}</span>
                  </td>
                  <td class="ticket-actions">
                    <button class="action-btn">Reply</button>
                    <button class="action-btn">Close</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const selectedPeriod = ref('30d')

const stats = ref({
  totalUsers: '12,547',
  totalRevenue: '$45,230',
  totalOrders: '3,421',
  conversionRate: '3.2'
})

const userActivity = ref([
  {
    id: 1,
    name: 'John Doe',
    email: 'john.doe@example.com',
    avatar: '/api/placeholder/40/40',
    activity: 'Login',
    timestamp: '2024-01-15T10:30:00Z',
    duration: '2h 15m',
    status: 'active'
  },
  {
    id: 2,
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    avatar: '/api/placeholder/40/40',
    activity: 'Purchase',
    timestamp: '2024-01-15T09:45:00Z',
    duration: '45m',
    status: 'completed'
  },
  {
    id: 3,
    name: 'Mike Johnson',
    email: 'mike.johnson@example.com',
    avatar: '/api/placeholder/40/40',
    activity: 'Profile Update',
    timestamp: '2024-01-15T08:20:00Z',
    duration: '15m',
    status: 'pending'
  },
  {
    id: 4,
    name: 'Sarah Wilson',
    email: 'sarah.wilson@example.com',
    avatar: '/api/placeholder/40/40',
    activity: 'Logout',
    timestamp: '2024-01-15T07:15:00Z',
    duration: '1h 30m',
    status: 'completed'
  }
])

const salesData = ref([
  {
    id: 1001,
    productName: 'Wireless Headphones',
    productImage: '/api/placeholder/50/50',
    customer: 'John Doe',
    amount: 199.99,
    quantity: 1,
    date: '2024-01-15',
    status: 'completed'
  },
  {
    id: 1002,
    productName: 'Smart Watch',
    productImage: '/api/placeholder/50/50',
    customer: 'Jane Smith',
    amount: 299.99,
    quantity: 1,
    date: '2024-01-14',
    status: 'shipped'
  },
  {
    id: 1003,
    productName: 'Laptop Stand',
    productImage: '/api/placeholder/50/50',
    customer: 'Mike Johnson',
    amount: 49.99,
    quantity: 2,
    date: '2024-01-14',
    status: 'processing'
  },
  {
    id: 1004,
    productName: 'USB Cable',
    productImage: '/api/placeholder/50/50',
    customer: 'Sarah Wilson',
    amount: 12.99,
    quantity: 3,
    date: '2024-01-13',
    status: 'completed'
  }
])

const trafficData = ref([
  {
    id: 1,
    url: '/home',
    title: 'Homepage',
    views: 15420,
    uniqueVisitors: 12350,
    bounceRate: 35.2,
    avgTimeOnPage: '2m 30s',
    trafficSource: 'Direct'
  },
  {
    id: 2,
    url: '/products',
    title: 'Products Page',
    views: 8750,
    uniqueVisitors: 7200,
    bounceRate: 42.1,
    avgTimeOnPage: '3m 15s',
    trafficSource: 'Google'
  },
  {
    id: 3,
    url: '/about',
    title: 'About Us',
    views: 3200,
    uniqueVisitors: 2800,
    bounceRate: 28.5,
    avgTimeOnPage: '4m 10s',
    trafficSource: 'Social Media'
  },
  {
    id: 4,
    url: '/contact',
    title: 'Contact Page',
    views: 1800,
    uniqueVisitors: 1650,
    bounceRate: 55.3,
    avgTimeOnPage: '1m 45s',
    trafficSource: 'Email'
  }
])

const inventoryData = ref([
  {
    id: 1,
    sku: 'WH-001',
    name: 'Wireless Headphones',
    category: 'Electronics',
    image: '/api/placeholder/50/50',
    price: 199.99,
    stock: 45,
    sold: 23,
    revenue: 4597.77,
    trend: 'up'
  },
  {
    id: 2,
    sku: 'SW-002',
    name: 'Smart Watch',
    category: 'Electronics',
    image: '/api/placeholder/50/50',
    price: 299.99,
    stock: 12,
    sold: 8,
    revenue: 2399.92,
    trend: 'down'
  },
  {
    id: 3,
    sku: 'LS-003',
    name: 'Laptop Stand',
    category: 'Accessories',
    image: '/api/placeholder/50/50',
    price: 49.99,
    stock: 78,
    sold: 15,
    revenue: 749.85,
    trend: 'stable'
  },
  {
    id: 4,
    sku: 'UC-004',
    name: 'USB Cable',
    category: 'Accessories',
    image: '/api/placeholder/50/50',
    price: 12.99,
    stock: 200,
    sold: 45,
    revenue: 584.55,
    trend: 'up'
  }
])

const supportTickets = ref([
  {
    id: 1001,
    subject: 'Login Issues',
    customer: 'John Doe',
    priority: 'high',
    assignee: 'Support Team',
    created: '2024-01-15',
    status: 'open'
  },
  {
    id: 1002,
    subject: 'Refund Request',
    customer: 'Jane Smith',
    priority: 'medium',
    assignee: 'Sarah Wilson',
    created: '2024-01-14',
    status: 'in-progress'
  },
  {
    id: 1003,
    subject: 'Feature Request',
    customer: 'Mike Johnson',
    priority: 'low',
    assignee: 'Product Team',
    created: '2024-01-13',
    status: 'closed'
  },
  {
    id: 1004,
    subject: 'Billing Question',
    customer: 'Sarah Wilson',
    priority: 'medium',
    assignee: 'Billing Team',
    created: '2024-01-12',
    status: 'resolved'
  }
])

const formatTime = (timestamp) => {
  const date = new Date(timestamp)
  return date.toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit'
  })
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}
</script>

<style scoped>
.data-dashboard {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.dashboard-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 2px solid #e9ecef;
}

.dashboard-header h1 {
  margin: 0;
  font-size: 32px;
  color: #333;
}

.header-controls {
  display: flex;
  gap: 15px;
  align-items: center;
}

.period-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background: white;
  cursor: pointer;
}

.export-btn {
  padding: 8px 16px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.export-btn:hover {
  background: #0056b3;
}

.stats-overview {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.stat-card {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  font-size: 32px;
  opacity: 0.7;
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 5px;
}

.stat-change {
  font-size: 12px;
  font-weight: bold;
}

.stat-change.positive {
  color: #28a745;
}

.stat-change.negative {
  color: #dc3545;
}

.data-tables {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.table-section {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
}

.table-section h2 {
  margin: 0;
  padding: 20px 25px;
  background: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
  font-size: 20px;
  color: #333;
}

.table-container {
  overflow-x: auto;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
}

.table-row {
  border-bottom: 1px solid #e9ecef;
  transition: background-color 0.2s ease;
}

.table-row:hover {
  background: #f8f9fa;
}

.table-row:last-child {
  border-bottom: none;
}

.table-row td {
  padding: 15px 20px;
  vertical-align: middle;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-avatar img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.user-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 2px;
}

.user-email {
  font-size: 12px;
  color: #666;
}

.activity-type,
.activity-time,
.activity-duration {
  color: #666;
  font-size: 14px;
}

.status-badge {
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
}

.status-badge.active {
  background: #d4edda;
  color: #155724;
}

.status-badge.completed {
  background: #cce5ff;
  color: #004085;
}

.status-badge.pending {
  background: #fff3cd;
  color: #856404;
}

.status-badge.open {
  background: #f8d7da;
  color: #721c24;
}

.status-badge.in-progress {
  background: #d1ecf1;
  color: #0c5460;
}

.status-badge.closed {
  background: #e2e3e5;
  color: #383d41;
}

.status-badge.resolved {
  background: #d4edda;
  color: #155724;
}

.status-badge.shipped {
  background: #cce5ff;
  color: #004085;
}

.status-badge.processing {
  background: #fff3cd;
  color: #856404;
}

.action-btn {
  padding: 6px 12px;
  background: #f8f9fa;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: bold;
  margin-right: 5px;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #e9ecef;
  border-color: #007bff;
  color: #007bff;
}

.sale-id {
  font-weight: bold;
  color: #007bff;
}

.product-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.product-image {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.product-name {
  font-weight: bold;
  color: #333;
}

.product-category {
  font-size: 12px;
  color: #666;
}

.sale-amount {
  font-weight: bold;
  color: #28a745;
}

.page-url {
  font-family: monospace;
  color: #007bff;
  font-size: 12px;
}

.page-title {
  font-weight: bold;
  color: #333;
}

.page-views,
.page-unique {
  font-weight: bold;
  color: #333;
}

.page-bounce {
  color: #666;
}

.page-time {
  color: #666;
  font-size: 12px;
}

.page-source {
  color: #666;
  font-size: 12px;
}

.product-sku {
  font-family: monospace;
  color: #666;
  font-size: 12px;
}

.product-details {
  min-width: 200px;
}

.product-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.product-price {
  font-weight: bold;
  color: #28a745;
}

.product-stock {
  font-weight: bold;
  color: #333;
}

.product-sold {
  color: #666;
}

.product-revenue {
  font-weight: bold;
  color: #007bff;
}

.trend-indicator {
  font-size: 16px;
}

.trend-indicator.up {
  color: #28a745;
}

.trend-indicator.down {
  color: #dc3545;
}

.trend-indicator.stable {
  color: #6c757d;
}

.ticket-id {
  font-weight: bold;
  color: #007bff;
}

.ticket-subject {
  font-weight: bold;
  color: #333;
}

.ticket-customer {
  color: #666;
}

.priority-badge {
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
}

.priority-badge.high {
  background: #f8d7da;
  color: #721c24;
}

.priority-badge.medium {
  background: #fff3cd;
  color: #856404;
}

.priority-badge.low {
  background: #d4edda;
  color: #155724;
}

.ticket-assignee {
  color: #666;
  font-size: 12px;
}

.ticket-created {
  color: #666;
  font-size: 12px;
}

@media (max-width: 768px) {
  .dashboard-header {
    flex-direction: column;
    gap: 20px;
    align-items: flex-start;
  }

  .stats-overview {
    grid-template-columns: 1fr;
  }

  .table-container {
    font-size: 12px;
  }

  .table-row td {
    padding: 10px 15px;
  }

  .user-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 5px;
  }

  .product-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 5px;
  }
}
</style>

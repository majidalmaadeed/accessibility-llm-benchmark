<template>
  <div class="ecommerce-dashboard">
    <header class="dashboard-header">
      <div class="header-content">
        <div class="logo-section">
          <img src="/api/placeholder/40/40" alt="ShopLogo" class="site-logo" />
          <h1 class="site-title">E-Commerce Dashboard</h1>
        </div>
        
        <div class="header-actions">
          <button class="action-btn search">Search</button>
          <button class="action-btn notifications">Notifications</button>
          <button class="action-btn cart">Cart (3)</button>
          <button class="action-btn profile">Profile</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="content-container">
        <div class="page-header">
          <h2 class="page-title">Product Management</h2>
          <div class="page-actions">
            <button class="btn primary">Add Product</button>
            <button class="btn secondary">Import</button>
            <button class="btn secondary">Export</button>
            <button class="btn secondary">Bulk Edit</button>
            <button class="btn secondary">Delete Selected</button>
          </div>
        </div>

        <div class="filters-section">
          <div class="filter-group">
            <label class="filter-label">Category</label>
            <select class="filter-select">
              <option value="">All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="clothing">Clothing</option>
              <option value="books">Books</option>
              <option value="home">Home & Garden</option>
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Status</label>
            <select class="filter-select">
              <option value="">All Status</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
              <option value="draft">Draft</option>
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Price Range</label>
            <select class="filter-select">
              <option value="">All Prices</option>
              <option value="0-50">$0 - $50</option>
              <option value="50-100">$50 - $100</option>
              <option value="100-500">$100 - $500</option>
              <option value="500+">$500+</option>
            </select>
          </div>
          
          <div class="filter-actions">
            <button class="btn primary">Apply Filters</button>
            <button class="btn secondary">Clear</button>
          </div>
        </div>

        <div class="products-section">
          <div class="section-header">
            <h3 class="section-title">Products (1,247 items)</h3>
            <div class="view-controls">
              <button class="view-btn active">Grid</button>
              <button class="view-btn">List</button>
              <button class="view-btn">Table</button>
            </div>
          </div>

          <div class="products-grid">
            <div
              v-for="product in products"
              :key="product.id"
              class="product-card"
            >
              <div class="product-image">
                <img :src="product.image" :alt="product.name" />
                <div class="product-badge" v-if="product.badge">{{ product.badge }}</div>
                <div class="product-actions">
                  <button class="product-btn edit">Edit</button>
                  <button class="product-btn view">View</button>
                  <button class="product-btn duplicate">Duplicate</button>
                  <button class="product-btn delete">Delete</button>
                </div>
              </div>
              
              <div class="product-content">
                <h4 class="product-name">{{ product.name }}</h4>
                <p class="product-description">{{ product.description }}</p>
                
                <div class="product-meta">
                  <div class="product-price">${{ product.price }}</div>
                  <div class="product-stock" :class="product.stockStatus">
                    {{ product.stock }} in stock
                  </div>
                </div>
                
                <div class="product-stats">
                  <div class="stat-item">
                    <span class="stat-label">Views:</span>
                    <span class="stat-value">{{ product.views }}</span>
                  </div>
                  <div class="stat-item">
                    <span class="stat-label">Sales:</span>
                    <span class="stat-value">{{ product.sales }}</span>
                  </div>
                  <div class="stat-item">
                    <span class="stat-label">Rating:</span>
                    <span class="stat-value">{{ product.rating }}/5</span>
                  </div>
                </div>
                
                <div class="product-tags">
                  <span
                    v-for="tag in product.tags"
                    :key="tag"
                    class="product-tag"
                  >{{ tag }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="bulk-actions-panel">
          <div class="bulk-controls">
            <label class="bulk-checkbox">
              <input type="checkbox" v-model="selectAll" @change="toggleSelectAll" />
              <span class="checkbox-label">Select All ({{ selectedCount }} selected)</span>
            </label>
            
            <div class="bulk-buttons">
              <button class="bulk-btn primary">Edit Selected</button>
              <button class="bulk-btn secondary">Duplicate Selected</button>
              <button class="bulk-btn secondary">Change Status</button>
              <button class="bulk-btn secondary">Add Tags</button>
              <button class="bulk-btn danger">Delete Selected</button>
            </div>
          </div>
        </div>

        <div class="pagination-section">
          <div class="pagination-info">
            <span>Showing 1-20 of 1,247 products</span>
          </div>
          
          <div class="pagination-controls">
            <button class="pagination-btn prev">Previous</button>
            <button class="pagination-btn page active">1</button>
            <button class="pagination-btn page">2</button>
            <button class="pagination-btn page">3</button>
            <button class="pagination-btn page">4</button>
            <button class="pagination-btn page">5</button>
            <button class="pagination-btn next">Next</button>
          </div>
        </div>
      </div>
    </main>

    <footer class="dashboard-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Product Management</h4>
          <ul class="footer-links">
            <li><a href="/products">All Products</a></li>
            <li><a href="/categories">Categories</a></li>
            <li><a href="/inventory">Inventory</a></li>
            <li><a href="/analytics">Analytics</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Orders</h4>
          <ul class="footer-links">
            <li><a href="/orders">All Orders</a></li>
            <li><a href="/pending">Pending</a></li>
            <li><a href="/shipped">Shipped</a></li>
            <li><a href="/returns">Returns</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Customers</h4>
          <ul class="footer-links">
            <li><a href="/customers">All Customers</a></li>
            <li><a href="/segments">Segments</a></li>
            <li><a href="/reviews">Reviews</a></li>
            <li><a href="/support">Support</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Settings</h4>
          <ul class="footer-links">
            <li><a href="/general">General</a></li>
            <li><a href="/shipping">Shipping</a></li>
            <li><a href="/taxes">Taxes</a></li>
            <li><a href="/integrations">Integrations</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 E-Commerce Dashboard. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const selectAll = ref(false)
const selectedProducts = ref([])

const selectedCount = computed(() => selectedProducts.value.length)

const products = ref([
  {
    id: 1,
    name: 'Wireless Bluetooth Headphones',
    description: 'High-quality wireless headphones with noise cancellation',
    price: 199.99,
    image: '/api/placeholder/300/200',
    stock: 45,
    stockStatus: 'in-stock',
    views: 1250,
    sales: 89,
    rating: 4.5,
    tags: ['Electronics', 'Audio', 'Wireless'],
    badge: 'Best Seller'
  },
  {
    id: 2,
    name: 'Smart Fitness Watch',
    description: 'Advanced fitness tracking with heart rate monitoring',
    price: 299.99,
    image: '/api/placeholder/300/200',
    stock: 23,
    stockStatus: 'low-stock',
    views: 890,
    sales: 67,
    rating: 4.2,
    tags: ['Electronics', 'Fitness', 'Wearable']
  },
  {
    id: 3,
    name: 'Organic Cotton T-Shirt',
    description: 'Comfortable and sustainable cotton t-shirt',
    price: 29.99,
    image: '/api/placeholder/300/200',
    stock: 0,
    stockStatus: 'out-of-stock',
    views: 456,
    sales: 234,
    rating: 4.7,
    tags: ['Clothing', 'Organic', 'Sustainable']
  },
  {
    id: 4,
    name: 'Programming Book Collection',
    description: 'Complete set of programming books for developers',
    price: 149.99,
    image: '/api/placeholder/300/200',
    stock: 78,
    stockStatus: 'in-stock',
    views: 678,
    sales: 45,
    rating: 4.8,
    tags: ['Books', 'Programming', 'Education']
  },
  {
    id: 5,
    name: 'Smart Home Hub',
    description: 'Central control for all your smart home devices',
    price: 199.99,
    image: '/api/placeholder/300/200',
    stock: 12,
    stockStatus: 'low-stock',
    views: 345,
    sales: 23,
    rating: 4.1,
    tags: ['Electronics', 'Smart Home', 'Automation']
  },
  {
    id: 6,
    name: 'Yoga Mat Premium',
    description: 'Non-slip yoga mat for all fitness levels',
    price: 49.99,
    image: '/api/placeholder/300/200',
    stock: 156,
    stockStatus: 'in-stock',
    views: 789,
    sales: 123,
    rating: 4.6,
    tags: ['Fitness', 'Yoga', 'Exercise']
  }
])

const toggleSelectAll = () => {
  if (selectAll.value) {
    selectedProducts.value = products.value.map(product => product.id)
  } else {
    selectedProducts.value = []
  }
}
</script>

<style scoped>
.ecommerce-dashboard {
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

.logo-section {
  display: flex;
  align-items: center;
  gap: 15px;
}

.site-logo {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.site-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.header-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 4px;
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

.content-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 30px;
  border-bottom: 1px solid #eee;
}

.page-title {
  margin: 0;
  font-size: 28px;
  color: #333;
}

.page-actions {
  display: flex;
  gap: 8px;
}

.btn {
  padding: 10px 16px;
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
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.btn.secondary:hover {
  background: #e9ecef;
  border-color: #007bff;
  color: #007bff;
}

.filters-section {
  display: flex;
  gap: 20px;
  padding: 30px;
  border-bottom: 1px solid #eee;
  align-items: end;
  flex-wrap: wrap;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  min-width: 150px;
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
  gap: 8px;
}

.products-section {
  padding: 30px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.section-title {
  margin: 0;
  font-size: 20px;
  color: #333;
}

.view-controls {
  display: flex;
  gap: 4px;
}

.view-btn {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  cursor: pointer;
  font-size: 14px;
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

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.product-card {
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
  background: white;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.product-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #28a745;
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
}

.product-actions {
  position: absolute;
  top: 10px;
  right: 10px;
  display: flex;
  gap: 4px;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.product-card:hover .product-actions {
  opacity: 1;
}

.product-btn {
  padding: 6px 8px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 11px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.product-btn.edit {
  background: #007bff;
  color: white;
}

.product-btn.view {
  background: #28a745;
  color: white;
}

.product-btn.duplicate {
  background: #ffc107;
  color: #333;
}

.product-btn.delete {
  background: #dc3545;
  color: white;
}

.product-btn:hover {
  transform: scale(1.05);
}

.product-content {
  padding: 20px;
}

.product-name {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.product-description {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
  line-height: 1.4;
}

.product-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.product-price {
  font-size: 20px;
  font-weight: bold;
  color: #007bff;
}

.product-stock {
  font-size: 12px;
  font-weight: bold;
  padding: 4px 8px;
  border-radius: 12px;
}

.product-stock.in-stock {
  background: #d4edda;
  color: #155724;
}

.product-stock.low-stock {
  background: #fff3cd;
  color: #856404;
}

.product-stock.out-of-stock {
  background: #f8d7da;
  color: #721c24;
}

.product-stats {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
}

.stat-label {
  font-size: 11px;
  color: #666;
  text-transform: uppercase;
}

.stat-value {
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.product-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.product-tag {
  background: #f8f9fa;
  color: #666;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 500;
}

.bulk-actions-panel {
  background: #f8f9fa;
  padding: 20px 30px;
  border-top: 1px solid #eee;
}

.bulk-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 20px;
}

.bulk-checkbox {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.checkbox-label {
  font-weight: bold;
  color: #333;
}

.bulk-buttons {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.bulk-btn {
  padding: 8px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.bulk-btn.primary {
  background: #007bff;
  color: white;
}

.bulk-btn.secondary {
  background: #6c757d;
  color: white;
}

.bulk-btn.danger {
  background: #dc3545;
  color: white;
}

.bulk-btn:hover {
  transform: translateY(-1px);
}

.pagination-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-top: 1px solid #eee;
}

.pagination-info {
  color: #666;
  font-size: 14px;
}

.pagination-controls {
  display: flex;
  gap: 4px;
}

.pagination-btn {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s ease;
}

.pagination-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.pagination-btn.active {
  background: #007bff;
  color: white;
  border-color: #007bff;
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
  .products-grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
  
  .filters-section {
    flex-direction: column;
    align-items: stretch;
  }
  
  .filter-group {
    min-width: auto;
  }
  
  .bulk-controls {
    flex-direction: column;
    align-items: stretch;
  }
  
  .bulk-buttons {
    justify-content: center;
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

  .page-header {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }

  .page-actions {
    flex-wrap: wrap;
    justify-content: center;
  }

  .products-grid {
    grid-template-columns: 1fr;
  }

  .pagination-section {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }

  .pagination-controls {
    flex-wrap: wrap;
    justify-content: center;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .page-title {
    font-size: 24px;
  }

  .section-title {
    font-size: 18px;
  }

  .product-content {
    padding: 15px;
  }

  .product-name {
    font-size: 16px;
  }

  .product-stats {
    flex-direction: column;
    gap: 8px;
  }
}
</style>

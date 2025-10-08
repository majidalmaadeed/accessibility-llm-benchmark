<template>
  <div class="product-catalog">
    <header class="catalog-header">
      <h1>Product Catalog</h1>
      <p>Discover amazing products at great prices</p>
    </header>

    <div class="catalog-filters">
      <div class="filter-group">
        <label>Category:</label>
        <select v-model="selectedCategory" class="filter-select">
          <option value="all">All Categories</option>
          <option value="electronics">Electronics</option>
          <option value="clothing">Clothing</option>
          <option value="home">Home & Garden</option>
          <option value="sports">Sports</option>
        </select>
      </div>

      <div class="filter-group">
        <label>Sort by:</label>
        <select v-model="sortBy" class="filter-select">
          <option value="name">Name</option>
          <option value="price">Price</option>
          <option value="rating">Rating</option>
        </select>
      </div>

      <div class="search-group">
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Search products..."
          class="search-input"
        />
        <button class="search-btn">Search</button>
      </div>
    </div>

    <div class="products-grid">
      <div
        v-for="product in filteredProducts"
        :key="product.id"
        class="product-card"
      >
        <div class="product-image-container">
          <img
            :src="product.image"
            class="product-image"
          />
          <div v-if="product.discount" class="discount-badge">
            -{{ product.discount }}%
          </div>
          <div v-if="!product.inStock" class="out-of-stock-badge">
            Out of Stock
          </div>
        </div>

        <div class="product-content">
          <h3 class="product-name">{{ product.name }}</h3>
          <p class="product-description">{{ product.description }}</p>
          
          <div class="product-rating">
            <div class="stars">
              <span v-for="i in 5" :key="i" class="star">
                {{ i <= product.rating ? '★' : '☆' }}
              </span>
            </div>
            <span class="rating-text">({{ product.rating }})</span>
          </div>

          <div class="product-price">
            <span v-if="product.discount" class="original-price">
              ${{ product.originalPrice }}
            </span>
            <span class="current-price">
              ${{ product.price }}
            </span>
          </div>

          <div class="product-actions">
            <button 
              class="add-to-cart-btn"
              :disabled="!product.inStock"
            >
              {{ product.inStock ? 'Add to Cart' : 'Out of Stock' }}
            </button>
            <button class="wishlist-btn">❤️</button>
            <button class="quick-view-btn">👁️</button>
          </div>
        </div>
      </div>
    </div>

    <div class="featured-section">
      <h2>Featured Products</h2>
      <div class="featured-grid">
        <div class="featured-item">
          <img
            :src="featuredProducts[0].image"
            class="featured-image"
          />
          <div class="featured-content">
            <h3>{{ featuredProducts[0].name }}</h3>
            <p>{{ featuredProducts[0].description }}</p>
            <div class="featured-price">${{ featuredProducts[0].price }}</div>
          </div>
        </div>

        <div class="featured-item">
          <img
            :src="featuredProducts[1].image"
            class="featured-image"
          />
          <div class="featured-content">
            <h3>{{ featuredProducts[1].name }}</h3>
            <p>{{ featuredProducts[1].description }}</p>
            <div class="featured-price">${{ featuredProducts[1].price }}</div>
          </div>
        </div>
      </div>
    </div>

    <div class="banner-section">
      <div class="banner-content">
        <img
          :src="bannerImage"
          class="banner-image"
        />
        <div class="banner-text">
          <h2>Special Offer</h2>
          <p>Get 20% off on all electronics this week!</p>
          <button class="banner-btn">Shop Now</button>
        </div>
      </div>
    </div>

    <div class="testimonial-section">
      <h2>Customer Reviews</h2>
      <div class="testimonials-grid">
        <div
          v-for="testimonial in testimonials"
          :key="testimonial.id"
          class="testimonial-card"
        >
          <div class="testimonial-header">
            <img
              :src="testimonial.avatar"
              class="testimonial-avatar"
            />
            <div class="testimonial-info">
              <h4>{{ testimonial.name }}</h4>
              <div class="testimonial-rating">
                <span v-for="i in 5" :key="i" class="star">
                  {{ i <= testimonial.rating ? '★' : '☆' }}
                </span>
              </div>
            </div>
          </div>
          <p class="testimonial-text">{{ testimonial.text }}</p>
          <div class="testimonial-product">
            <img
              :src="testimonial.productImage"
              class="testimonial-product-image"
            />
            <span>{{ testimonial.productName }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const selectedCategory = ref('all')
const sortBy = ref('name')
const searchQuery = ref('')

const products = ref([
  {
    id: 1,
    name: 'Wireless Headphones',
    description: 'High-quality wireless headphones with noise cancellation',
    image: '/api/placeholder/300/300',
    price: 199.99,
    originalPrice: 249.99,
    rating: 4.5,
    category: 'electronics',
    inStock: true,
    discount: 20
  },
  {
    id: 2,
    name: 'Cotton T-Shirt',
    description: 'Comfortable cotton t-shirt in various colors',
    image: '/api/placeholder/300/300',
    price: 29.99,
    originalPrice: null,
    rating: 4.2,
    category: 'clothing',
    inStock: true,
    discount: 0
  },
  {
    id: 3,
    name: 'Smart Home Hub',
    description: 'Control all your smart devices from one place',
    image: '/api/placeholder/300/300',
    price: 149.99,
    originalPrice: null,
    rating: 4.7,
    category: 'electronics',
    inStock: false,
    discount: 0
  },
  {
    id: 4,
    name: 'Garden Tools Set',
    description: 'Complete set of professional garden tools',
    image: '/api/placeholder/300/300',
    price: 79.99,
    originalPrice: 99.99,
    rating: 4.3,
    category: 'home',
    inStock: true,
    discount: 20
  },
  {
    id: 5,
    name: 'Running Shoes',
    description: 'Lightweight running shoes for all terrains',
    image: '/api/placeholder/300/300',
    price: 129.99,
    originalPrice: null,
    rating: 4.6,
    category: 'sports',
    inStock: true,
    discount: 0
  },
  {
    id: 6,
    name: 'Coffee Maker',
    description: 'Automatic coffee maker with programmable features',
    image: '/api/placeholder/300/300',
    price: 89.99,
    originalPrice: 119.99,
    rating: 4.4,
    category: 'home',
    inStock: true,
    discount: 25
  }
])

const featuredProducts = ref([
  {
    name: 'Premium Laptop',
    description: 'High-performance laptop for professionals',
    image: '/api/placeholder/400/300',
    price: 1299.99
  },
  {
    name: 'Designer Watch',
    description: 'Elegant timepiece for any occasion',
    image: '/api/placeholder/400/300',
    price: 599.99
  }
])

const bannerImage = ref('/api/placeholder/1200/400')

const testimonials = ref([
  {
    id: 1,
    name: 'Sarah Johnson',
    avatar: '/api/placeholder/50/50',
    rating: 5,
    text: 'Amazing quality and fast shipping! Highly recommended.',
    productImage: '/api/placeholder/60/60',
    productName: 'Wireless Headphones'
  },
  {
    id: 2,
    name: 'Mike Chen',
    avatar: '/api/placeholder/50/50',
    rating: 4,
    text: 'Great product, exactly as described. Will buy again.',
    productImage: '/api/placeholder/60/60',
    productName: 'Smart Home Hub'
  },
  {
    id: 3,
    name: 'Emily Davis',
    avatar: '/api/placeholder/50/50',
    rating: 5,
    text: 'Excellent customer service and product quality.',
    productImage: '/api/placeholder/60/60',
    productName: 'Running Shoes'
  }
])

const filteredProducts = computed(() => {
  let filtered = products.value

  if (selectedCategory.value !== 'all') {
    filtered = filtered.filter(product => product.category === selectedCategory.value)
  }

  if (searchQuery.value) {
    filtered = filtered.filter(product => 
      product.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      product.description.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }

  return filtered.sort((a, b) => {
    switch(sortBy.value) {
      case 'name':
        return a.name.localeCompare(b.name)
      case 'price':
        return a.price - b.price
      case 'rating':
        return b.rating - a.rating
      default:
        return 0
    }
  })
})
</script>

<style scoped>
.product-catalog {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.catalog-header {
  text-align: center;
  margin-bottom: 40px;
}

.catalog-header h1 {
  margin: 0 0 10px 0;
  font-size: 32px;
  color: #333;
}

.catalog-header p {
  margin: 0;
  color: #666;
  font-size: 16px;
}

.catalog-filters {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  align-items: center;
  margin-bottom: 30px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.filter-group label {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.filter-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background: white;
  cursor: pointer;
}

.search-group {
  display: flex;
  gap: 10px;
  margin-left: auto;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  min-width: 200px;
}

.search-btn {
  padding: 8px 16px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.search-btn:hover {
  background: #0056b3;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.product-card {
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.product-image-container {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.discount-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background: #dc3545;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
}

.out-of-stock-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #6c757d;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
}

.product-content {
  padding: 20px;
}

.product-name {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.product-description {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
  line-height: 1.4;
}

.product-rating {
  display: flex;
  align-items: center;
  gap: 5px;
  margin-bottom: 15px;
}

.stars {
  color: #ffc107;
  font-size: 14px;
}

.rating-text {
  font-size: 12px;
  color: #666;
}

.product-price {
  margin-bottom: 15px;
}

.original-price {
  text-decoration: line-through;
  color: #999;
  font-size: 14px;
  margin-right: 10px;
}

.current-price {
  font-size: 20px;
  font-weight: bold;
  color: #333;
}

.product-actions {
  display: flex;
  gap: 10px;
}

.add-to-cart-btn {
  flex: 1;
  padding: 10px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.2s ease;
}

.add-to-cart-btn:hover:not(:disabled) {
  background: #0056b3;
}

.add-to-cart-btn:disabled {
  background: #6c757d;
  cursor: not-allowed;
}

.wishlist-btn,
.quick-view-btn {
  padding: 10px;
  background: #f8f9fa;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.2s ease;
}

.wishlist-btn:hover,
.quick-view-btn:hover {
  background: #e9ecef;
  border-color: #007bff;
}

.featured-section {
  margin-bottom: 40px;
}

.featured-section h2 {
  margin: 0 0 20px 0;
  font-size: 24px;
  color: #333;
  text-align: center;
}

.featured-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 20px;
}

.featured-item {
  display: flex;
  gap: 20px;
  padding: 20px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.featured-image {
  width: 150px;
  height: 150px;
  object-fit: cover;
  border-radius: 4px;
  flex-shrink: 0;
}

.featured-content {
  flex: 1;
}

.featured-content h3 {
  margin: 0 0 10px 0;
  font-size: 20px;
  color: #333;
}

.featured-content p {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.4;
}

.featured-price {
  font-size: 24px;
  font-weight: bold;
  color: #007bff;
}

.banner-section {
  margin-bottom: 40px;
}

.banner-content {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  height: 300px;
}

.banner-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.banner-text {
  position: absolute;
  top: 50%;
  left: 50px;
  transform: translateY(-50%);
  color: white;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.banner-text h2 {
  margin: 0 0 10px 0;
  font-size: 32px;
}

.banner-text p {
  margin: 0 0 20px 0;
  font-size: 18px;
}

.banner-btn {
  padding: 12px 24px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  font-size: 16px;
  transition: background-color 0.2s ease;
}

.banner-btn:hover {
  background: #0056b3;
}

.testimonial-section {
  background: #f8f9fa;
  padding: 40px;
  border-radius: 8px;
}

.testimonial-section h2 {
  margin: 0 0 30px 0;
  font-size: 24px;
  color: #333;
  text-align: center;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.testimonial-card {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.testimonial-header {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
}

.testimonial-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.testimonial-info h4 {
  margin: 0 0 5px 0;
  font-size: 16px;
  color: #333;
}

.testimonial-rating {
  color: #ffc107;
  font-size: 14px;
}

.testimonial-text {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.5;
  font-style: italic;
}

.testimonial-product {
  display: flex;
  align-items: center;
  gap: 10px;
  padding-top: 15px;
  border-top: 1px solid #eee;
}

.testimonial-product-image {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
}

.testimonial-product span {
  font-size: 14px;
  color: #666;
  font-weight: bold;
}

@media (max-width: 768px) {
  .catalog-filters {
    flex-direction: column;
    align-items: stretch;
  }

  .search-group {
    margin-left: 0;
  }

  .products-grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }

  .featured-grid {
    grid-template-columns: 1fr;
  }

  .featured-item {
    flex-direction: column;
  }

  .featured-image {
    width: 100%;
    height: 200px;
  }

  .banner-text {
    left: 20px;
    right: 20px;
  }

  .banner-text h2 {
    font-size: 24px;
  }

  .banner-text p {
    font-size: 16px;
  }
}
</style>

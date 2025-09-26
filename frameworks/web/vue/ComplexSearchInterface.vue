<template>
  <div class="search-interface">
    <div class="search-header">
      <h1>Product Search</h1>
      <div class="search-stats">
        {{ searchResults.length }} products found
        <span v-if="selectedItems.length > 0" class="selected-count">• {{ selectedItems.length }} selected</span>
      </div>
    </div>

    <div class="search-container">
      <div class="search-main">
        <form @submit.prevent="handleSearch" class="search-form">
          <div class="search-input-container">
            <input
              ref="searchInputRef"
              type="text"
              v-model="searchQuery"
              placeholder="Search for products..."
              class="search-input"
            />
            <button type="submit" class="search-btn">🔍</button>
            
            <div v-if="showSuggestions && suggestions.length > 0" class="search-suggestions">
              <div
                v-for="(suggestion, index) in suggestions"
                :key="index"
                class="suggestion-item"
                @click="handleSuggestionClick(suggestion)"
              >
                {{ suggestion }}
              </div>
            </div>
          </div>
        </form>

        <div class="search-controls">
          <div class="view-controls">
            <button 
              :class="{ active: viewMode === 'grid' }"
              @click="viewMode = 'grid'"
              title="Grid View"
            >
              ⊞
            </button>
            <button 
              :class="{ active: viewMode === 'list' }"
              @click="viewMode = 'list'"
              title="List View"
            >
              ☰
            </button>
          </div>

          <div class="sort-controls">
            <label>Sort by:</label>
            <select v-model="filters.sortBy">
              <option v-for="option in sortOptions" :key="option.id" :value="option.id">
                {{ option.name }}
              </option>
            </select>
          </div>

          <button 
            @click="showFilters = !showFilters"
            class="filters-toggle"
          >
            Filters {{ showFilters ? '▲' : '▼' }}
          </button>
        </div>

        <div v-if="showFilters" class="filters-panel">
          <div class="filter-group">
            <label>Category</label>
            <select v-model="filters.category">
              <option v-for="category in categories" :key="category.id" :value="category.id">
                {{ category.name }}
              </option>
            </select>
          </div>

          <div class="filter-group">
            <label>Brand</label>
            <select v-model="filters.brand">
              <option v-for="brand in brands" :key="brand.id" :value="brand.id">
                {{ brand.name }}
              </option>
            </select>
          </div>

          <div class="filter-group">
            <label>Price Range</label>
            <select v-model="filters.priceRange">
              <option v-for="range in priceRanges" :key="range.id" :value="range.id">
                {{ range.name }}
              </option>
            </select>
          </div>

          <div class="filter-group">
            <label>Rating</label>
            <select v-model="filters.rating">
              <option v-for="rating in ratings" :key="rating.id" :value="rating.id">
                {{ rating.name }}
              </option>
            </select>
          </div>

          <div class="filter-group">
            <label>Availability</label>
            <select v-model="filters.availability">
              <option value="all">All Items</option>
              <option value="in-stock">In Stock</option>
              <option value="limited">Limited Stock</option>
              <option value="out-of-stock">Out of Stock</option>
            </select>
          </div>

          <button @click="clearFilters" class="clear-filters-btn">
            Clear All Filters
          </button>
        </div>

        <div v-if="isLoading" class="loading-state">
          <div class="loading-spinner"></div>
          <span>Searching...</span>
        </div>

        <div v-else class="search-results">
          <div v-if="paginatedResults.length > 0" class="results-header">
            <label class="select-all-label">
              <input
                type="checkbox"
                :checked="selectedItems.length === paginatedResults.length && paginatedResults.length > 0"
                @change="handleSelectAll"
              />
              Select All
            </label>
          </div>

          <div :class="`results-grid ${viewMode}`">
            <div 
              v-for="product in paginatedResults" 
              :key="product.id" 
              :class="`product-card ${selectedItems.includes(product.id) ? 'selected' : ''}`"
            >
              <div class="product-checkbox">
                <input
                  type="checkbox"
                  :checked="selectedItems.includes(product.id)"
                  @change="handleItemSelect(product.id)"
                />
              </div>

              <div class="product-image">
                <img :src="product.image" :alt="product.name" />
                <div v-if="product.availability === 'limited'" class="availability-badge limited">Limited</div>
                <div v-if="product.availability === 'out-of-stock'" class="availability-badge out-of-stock">Out of Stock</div>
              </div>

              <div class="product-info">
                <h3 class="product-name">{{ product.name }}</h3>
                <div class="product-brand">{{ product.brand }}</div>
                <div class="product-rating">
                  <span class="stars">{{ renderStars(product.rating) }}</span>
                  <span class="rating-text">({{ product.reviews }})</span>
                </div>
                <div class="product-price">${{ product.price.toFixed(2) }}</div>
                <div class="product-description">{{ product.description }}</div>
              </div>

              <div class="product-actions">
                <button class="add-to-cart-btn">Add to Cart</button>
                <button class="wishlist-btn">♡</button>
              </div>
            </div>
          </div>

          <div v-if="totalPages > 1" class="pagination">
            <button 
              @click="currentPage = Math.max(1, currentPage - 1)"
              :disabled="currentPage === 1"
            >
              Previous
            </button>
            
            <button
              v-for="page in totalPages"
              :key="page"
              @click="currentPage = page"
              :class="{ active: currentPage === page }"
            >
              {{ page }}
            </button>
            
            <button 
              @click="currentPage = Math.min(totalPages, currentPage + 1)"
              :disabled="currentPage === totalPages"
            >
              Next
            </button>
          </div>
        </div>

        <div v-if="searchResults.length === 0 && !isLoading" class="no-results">
          <div class="no-results-icon">🔍</div>
          <h3>No products found</h3>
          <p>Try adjusting your search terms or filters</p>
          <button @click="clearFilters" class="clear-filters-btn">
            Clear All Filters
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ComplexSearchInterface',
  data() {
    return {
      searchQuery: '',
      searchResults: [],
      isLoading: false,
      filters: {
        category: 'all',
        priceRange: 'all',
        brand: 'all',
        rating: 'all',
        availability: 'all',
        sortBy: 'relevance'
      },
      showFilters: false,
      viewMode: 'grid',
      currentPage: 1,
      itemsPerPage: 12,
      selectedItems: [],
      showSuggestions: false,
      suggestions: [],
      sampleProducts: [
        {
          id: 1,
          name: 'Wireless Bluetooth Headphones',
          category: 'electronics',
          brand: 'TechSound',
          price: 99.99,
          rating: 4.5,
          reviews: 128,
          availability: 'in-stock',
          image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🎧',
          description: 'High-quality wireless headphones with noise cancellation'
        },
        {
          id: 2,
          name: 'Smart Fitness Watch',
          category: 'electronics',
          brand: 'FitTech',
          price: 199.99,
          rating: 4.2,
          reviews: 89,
          availability: 'in-stock',
          image: 'https://via.placeholder.com/200x200/2196f3/fff?text=⌚',
          description: 'Advanced fitness tracking with heart rate monitoring'
        },
        {
          id: 3,
          name: 'Organic Cotton T-Shirt',
          category: 'clothing',
          brand: 'EcoWear',
          price: 29.99,
          rating: 4.7,
          reviews: 256,
          availability: 'in-stock',
          image: 'https://via.placeholder.com/200x200/ff9800/fff?text=👕',
          description: 'Comfortable organic cotton t-shirt in various colors'
        },
        {
          id: 4,
          name: 'Stainless Steel Water Bottle',
          category: 'home',
          brand: 'HydroMax',
          price: 24.99,
          rating: 4.3,
          reviews: 167,
          availability: 'limited',
          image: 'https://via.placeholder.com/200x200/9c27b0/fff?text=🍶',
          description: 'Insulated stainless steel water bottle keeps drinks cold'
        },
        {
          id: 5,
          name: 'Wireless Charging Pad',
          category: 'electronics',
          brand: 'PowerUp',
          price: 39.99,
          rating: 4.1,
          reviews: 94,
          availability: 'in-stock',
          image: 'https://via.placeholder.com/200x200/f44336/fff?text=🔋',
          description: 'Fast wireless charging pad compatible with all devices'
        },
        {
          id: 6,
          name: 'Yoga Mat Premium',
          category: 'sports',
          brand: 'FlexFit',
          price: 49.99,
          rating: 4.6,
          reviews: 203,
          availability: 'in-stock',
          image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🧘',
          description: 'Non-slip premium yoga mat for all fitness levels'
        }
      ],
      categories: [
        { id: 'all', name: 'All Categories' },
        { id: 'electronics', name: 'Electronics' },
        { id: 'clothing', name: 'Clothing' },
        { id: 'home', name: 'Home & Garden' },
        { id: 'sports', name: 'Sports & Fitness' },
        { id: 'books', name: 'Books' }
      ],
      brands: [
        { id: 'all', name: 'All Brands' },
        { id: 'TechSound', name: 'TechSound' },
        { id: 'FitTech', name: 'FitTech' },
        { id: 'EcoWear', name: 'EcoWear' },
        { id: 'HydroMax', name: 'HydroMax' },
        { id: 'PowerUp', name: 'PowerUp' },
        { id: 'FlexFit', name: 'FlexFit' }
      ],
      priceRanges: [
        { id: 'all', name: 'All Prices' },
        { id: '0-25', name: 'Under $25' },
        { id: '25-50', name: '$25 - $50' },
        { id: '50-100', name: '$50 - $100' },
        { id: '100-200', name: '$100 - $200' },
        { id: '200+', name: 'Over $200' }
      ],
      ratings: [
        { id: 'all', name: 'All Ratings' },
        { id: '4.5+', name: '4.5+ Stars' },
        { id: '4+', name: '4+ Stars' },
        { id: '3+', name: '3+ Stars' },
        { id: '2+', name: '2+ Stars' }
      ],
      sortOptions: [
        { id: 'relevance', name: 'Relevance' },
        { id: 'price-low', name: 'Price: Low to High' },
        { id: 'price-high', name: 'Price: High to Low' },
        { id: 'rating', name: 'Customer Rating' },
        { id: 'newest', name: 'Newest First' },
        { id: 'name', name: 'Name A-Z' }
      ],
      searchSuggestions: [
        'wireless headphones', 'smart watch', 'fitness tracker', 'bluetooth speaker',
        'phone case', 'laptop stand', 'wireless charger', 'yoga mat', 'water bottle',
        'organic cotton', 'stainless steel', 'premium quality'
      ]
    }
  },
  computed: {
    totalPages() {
      return Math.ceil(this.searchResults.length / this.itemsPerPage);
    },
    paginatedResults() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage;
      return this.searchResults.slice(startIndex, startIndex + this.itemsPerPage);
    }
  },
  watch: {
    searchQuery() {
      if (this.searchQuery.length > 2) {
        const filteredSuggestions = this.searchSuggestions.filter(suggestion =>
          suggestion.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
        this.suggestions = filteredSuggestions.slice(0, 5);
        this.showSuggestions = true;
      } else {
        this.showSuggestions = false;
      }
    },
    filters: {
      handler() {
        this.currentPage = 1;
        this.performSearch();
      },
      deep: true
    },
    currentPage() {
      this.performSearch();
    }
  },
  mounted() {
    this.performSearch();
  },
  methods: {
    performSearch() {
      this.isLoading = true;
      
      setTimeout(() => {
        let filteredProducts = [...this.sampleProducts];

        if (this.searchQuery.trim()) {
          filteredProducts = filteredProducts.filter(product =>
            product.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
            product.description.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
            product.brand.toLowerCase().includes(this.searchQuery.toLowerCase())
          );
        }

        if (this.filters.category !== 'all') {
          filteredProducts = filteredProducts.filter(product => product.category === this.filters.category);
        }

        if (this.filters.brand !== 'all') {
          filteredProducts = filteredProducts.filter(product => product.brand === this.filters.brand);
        }

        if (this.filters.priceRange !== 'all') {
          const [min, max] = this.filters.priceRange.split('-').map(Number);
          filteredProducts = filteredProducts.filter(product => {
            if (this.filters.priceRange === '200+') {
              return product.price > 200;
            }
            return product.price >= min && product.price <= max;
          });
        }

        if (this.filters.rating !== 'all') {
          const minRating = parseFloat(this.filters.rating);
          filteredProducts = filteredProducts.filter(product => product.rating >= minRating);
        }

        if (this.filters.availability !== 'all') {
          filteredProducts = filteredProducts.filter(product => product.availability === this.filters.availability);
        }

        switch (this.filters.sortBy) {
          case 'price-low':
            filteredProducts.sort((a, b) => a.price - b.price);
            break;
          case 'price-high':
            filteredProducts.sort((a, b) => b.price - a.price);
            break;
          case 'rating':
            filteredProducts.sort((a, b) => b.rating - a.rating);
            break;
          case 'newest':
            filteredProducts.sort((a, b) => b.id - a.id);
            break;
          case 'name':
            filteredProducts.sort((a, b) => a.name.localeCompare(b.name));
            break;
        }

        this.searchResults = filteredProducts;
        this.isLoading = false;
      }, 500);
    },
    handleSearch() {
      this.currentPage = 1;
      this.performSearch();
    },
    handleSuggestionClick(suggestion) {
      this.searchQuery = suggestion;
      this.showSuggestions = false;
      this.currentPage = 1;
      this.performSearch();
    },
    handleItemSelect(itemId) {
      if (this.selectedItems.includes(itemId)) {
        this.selectedItems = this.selectedItems.filter(id => id !== itemId);
      } else {
        this.selectedItems.push(itemId);
      }
    },
    handleSelectAll() {
      const currentPageItems = this.paginatedResults.map(item => item.id);
      if (this.selectedItems.length === currentPageItems.length) {
        this.selectedItems = this.selectedItems.filter(id => !currentPageItems.includes(id));
      } else {
        this.selectedItems = [...this.selectedItems, ...currentPageItems.filter(id => !this.selectedItems.includes(id))];
      }
    },
    clearFilters() {
      this.filters = {
        category: 'all',
        priceRange: 'all',
        brand: 'all',
        rating: 'all',
        availability: 'all',
        sortBy: 'relevance'
      };
      this.searchQuery = '';
      this.currentPage = 1;
    },
    renderStars(rating) {
      const stars = [];
      const fullStars = Math.floor(rating);
      const hasHalfStar = rating % 1 !== 0;

      for (let i = 0; i < fullStars; i++) {
        stars.push('★');
      }
      if (hasHalfStar) {
        stars.push('☆');
      }
      while (stars.length < 5) {
        stars.push('☆');
      }
      return stars.join('');
    }
  }
}
</script>

<style scoped>
.search-interface {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.search-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.search-header h1 {
  margin: 0;
  color: #333;
  font-size: 28px;
}

.search-stats {
  color: #666;
  font-size: 14px;
}

.selected-count {
  color: #4caf50;
  font-weight: 600;
}

.search-container {
  display: flex;
  gap: 20px;
}

.search-main {
  flex: 1;
}

.search-form {
  margin-bottom: 20px;
}

.search-input-container {
  position: relative;
  display: flex;
  align-items: center;
}

.search-input {
  flex: 1;
  padding: 12px 16px;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  font-size: 16px;
  outline: none;
  transition: border-color 0.3s ease;
}

.search-input:focus {
  border-color: #4caf50;
}

.search-btn {
  position: absolute;
  right: 8px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  padding: 8px 12px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

.search-btn:hover {
  background: #45a049;
}

.search-suggestions {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #e0e0e0;
  border-top: none;
  border-radius: 0 0 8px 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 100;
  max-height: 200px;
  overflow-y: auto;
}

.suggestion-item {
  padding: 10px 16px;
  cursor: pointer;
  border-bottom: 1px solid #f0f0f0;
  transition: background-color 0.3s ease;
}

.suggestion-item:hover {
  background: #f8f9fa;
}

.suggestion-item:last-child {
  border-bottom: none;
}

.search-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.view-controls {
  display: flex;
  gap: 5px;
  background: white;
  border-radius: 6px;
  padding: 4px;
}

.view-controls button {
  padding: 8px 12px;
  border: none;
  background: transparent;
  cursor: pointer;
  border-radius: 4px;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

.view-controls button.active {
  background: #4caf50;
  color: white;
}

.view-controls button:hover:not(.active) {
  background: #e9ecef;
}

.sort-controls {
  display: flex;
  align-items: center;
  gap: 8px;
}

.sort-controls label {
  font-size: 14px;
  color: #666;
  font-weight: 500;
}

.sort-controls select {
  padding: 6px 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.filters-toggle {
  padding: 8px 16px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: all 0.3s ease;
}

.filters-toggle:hover {
  background: #f5f5f5;
  border-color: #4caf50;
}

.filters-panel {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
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
  letter-spacing: 0.5px;
}

.filter-group select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.filter-group select:focus {
  outline: none;
  border-color: #4caf50;
}

.clear-filters-btn {
  grid-column: 1 / -1;
  justify-self: start;
  padding: 8px 16px;
  background: #f44336;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: background-color 0.3s ease;
}

.clear-filters-btn:hover {
  background: #d32f2f;
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  color: #666;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(76, 175, 80, 0.3);
  border-top: 4px solid #4caf50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 15px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.search-results {
  background: white;
  border-radius: 8px;
  overflow: hidden;
}

.results-header {
  padding: 15px 20px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.select-all-label {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  font-weight: 500;
}

.results-grid {
  padding: 20px;
}

.results-grid.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
}

.results-grid.list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.product-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
}

.product-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.product-card.selected {
  border-color: #4caf50;
  box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
}

.product-checkbox {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 10;
}

.product-checkbox input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
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
  transition: transform 0.3s ease;
}

.product-card:hover .product-image img {
  transform: scale(1.05);
}

.availability-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 10px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.availability-badge.limited {
  background: #ff9800;
  color: white;
}

.availability-badge.out-of-stock {
  background: #f44336;
  color: white;
}

.product-info {
  padding: 15px;
}

.product-name {
  margin: 0 0 5px 0;
  font-size: 16px;
  font-weight: 600;
  color: #333;
  line-height: 1.3;
}

.product-brand {
  font-size: 12px;
  color: #666;
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.product-rating {
  display: flex;
  align-items: center;
  gap: 5px;
  margin-bottom: 8px;
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
  font-size: 18px;
  font-weight: 700;
  color: #4caf50;
  margin-bottom: 8px;
}

.product-description {
  font-size: 12px;
  color: #666;
  line-height: 1.4;
  margin-bottom: 15px;
}

.product-actions {
  display: flex;
  gap: 8px;
  padding: 0 15px 15px;
}

.add-to-cart-btn {
  flex: 1;
  padding: 8px 12px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.add-to-cart-btn:hover {
  background: #45a049;
}

.wishlist-btn {
  padding: 8px 12px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  color: #666;
  transition: all 0.3s ease;
}

.wishlist-btn:hover {
  background: #f5f5f5;
  color: #f44336;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  padding: 20px;
  background: #f8f9fa;
  border-top: 1px solid #e0e0e0;
}

.pagination button {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  transition: all 0.3s ease;
}

.pagination button:hover:not(:disabled) {
  background: #f5f5f5;
  border-color: #4caf50;
}

.pagination button.active {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.pagination button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.no-results {
  text-align: center;
  padding: 60px 20px;
  color: #666;
}

.no-results-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.no-results h3 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 20px;
}

.no-results p {
  margin: 0 0 20px 0;
  font-size: 14px;
}

@media (max-width: 768px) {
  .search-interface {
    padding: 15px;
  }
  
  .search-header {
    flex-direction: column;
    gap: 10px;
    align-items: stretch;
  }
  
  .search-controls {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .view-controls {
    justify-content: center;
  }
  
  .sort-controls {
    justify-content: center;
  }
  
  .filters-panel {
    grid-template-columns: 1fr;
    gap: 15px;
  }
  
  .results-grid.grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 15px;
  }
  
  .pagination {
    flex-wrap: wrap;
    gap: 5px;
  }
}

@media (max-width: 480px) {
  .search-input {
    font-size: 14px;
    padding: 10px 14px;
  }
  
  .results-grid.grid {
    grid-template-columns: 1fr;
  }
  
  .product-actions {
    flex-direction: column;
  }
  
  .pagination button {
    padding: 6px 10px;
    font-size: 12px;
  }
}
</style>

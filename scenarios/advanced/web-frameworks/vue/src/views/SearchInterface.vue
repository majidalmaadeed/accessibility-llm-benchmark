<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Complex Search Interface</h1>
      <p class="page-subtitle">
        Complex search and filtering interface
      </p>
    </div>

    <div class="card">
      <div style="display: flex; gap: 1rem; margin-bottom: 1rem">
        <div style="flex: 1; position: relative">
          <input
            type="text"
            class="form-control"
            placeholder="Search products, categories, or descriptions..."
            v-model="searchQuery"
            @keypress.enter="performSearch"
          />
          <div
            v-if="suggestions.length > 0"
            style="position: absolute; top: 100%; left: 0; right: 0; background: white; border: 1px solid #ddd; borderTop: none; borderRadius: 0 0 4px 4px; zIndex: 1000; maxHeight: 200px; overflowY: auto"
          >
            <div
              v-for="(suggestion, index) in suggestions"
              :key="index"
              style="padding: 0.75rem; cursor: pointer; borderBottom: 1px solid #eee"
              @click="handleSuggestionClick(suggestion)"
              @mouseenter="$event.target.style.backgroundColor = '#f5f5f5'"
              @mouseleave="$event.target.style.backgroundColor = 'white'"
            >
              <div style="fontWeight: 600">{{ suggestion.title }}</div>
              <div style="fontSize: 0.9rem; color: #666">{{ suggestion.category }}</div>
            </div>
          </div>
        </div>
        <button class="btn" @click="performSearch" :disabled="isSearching">
          {{ isSearching ? 'Searching...' : 'Search' }}
        </button>
        <button class="btn btn-secondary" @click="showFilters = !showFilters">
          {{ showFilters ? 'Hide Filters' : 'Show Filters' }}
        </button>
      </div>

      <div v-if="searchHistory.length > 0" style="margin-bottom: 1rem">
        <div style="fontSize: 0.9rem; color: #666; marginBottom: 0.5rem">Recent searches:</div>
        <div style="display: flex; gap: 0.5rem; flexWrap: wrap">
          <button
            v-for="(query, index) in searchHistory"
            :key="index"
            class="btn btn-secondary"
            @click="handleHistoryClick(query)"
            style="fontSize: 0.8rem; padding: 0.25rem 0.5rem"
          >
            {{ query }}
          </button>
        </div>
      </div>
    </div>

    <div v-if="showFilters" class="card">
      <h2>Search Filters</h2>
      <div class="search-filters">
        <div class="form-group">
          <label class="form-label">Category</label>
          <select class="form-control" v-model="filters.category">
            <option value="all">All Categories</option>
            <option value="electronics">Electronics</option>
            <option value="appliances">Appliances</option>
            <option value="sports">Sports</option>
            <option value="furniture">Furniture</option>
            <option value="clothing">Clothing</option>
            <option value="books">Books</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Date Range</label>
          <select class="form-control" v-model="filters.dateRange">
            <option value="all">All Time</option>
            <option value="today">Today</option>
            <option value="week">This Week</option>
            <option value="month">This Month</option>
            <option value="year">This Year</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Price Range</label>
          <select class="form-control" v-model="filters.priceRange">
            <option value="all">All Prices</option>
            <option value="0-50">$0 - $50</option>
            <option value="50-100">$50 - $100</option>
            <option value="100-200">$100 - $200</option>
            <option value="200+">$200+</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Rating</label>
          <select class="form-control" v-model="filters.rating">
            <option value="all">All Ratings</option>
            <option value="4">4+ stars & up</option>
            <option value="3">3+ stars & up</option>
            <option value="2">2+ stars & up</option>
            <option value="1">1+ stars & up</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Availability</label>
          <select class="form-control" v-model="filters.availability">
            <option value="all">All Items</option>
            <option value="available">In Stock</option>
            <option value="out-of-stock">Out of Stock</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Sort By</label>
          <select class="form-control" v-model="filters.sortBy">
            <option value="relevance">Relevance</option>
            <option value="price-low">Price: Low to High</option>
            <option value="price-high">Price: High to Low</option>
            <option value="rating">Rating</option>
            <option value="newest">Newest First</option>
            <option value="oldest">Oldest First</option>
          </select>
        </div>
      </div>
      <div class="form-actions">
        <button class="btn btn-secondary" @click="clearFilters">
          Clear Filters
        </button>
        <button class="btn" @click="performSearch">
          Apply Filters
        </button>
      </div>
    </div>

    <div class="card">
      <div style="display: flex; justifyContent: space-between; alignItems: center; margin-bottom: 1rem">
        <h2>Search Results</h2>
        <div style="color: #666">
          {{ searchResults.length }} result{{ searchResults.length !== 1 ? 's' : '' }} found
        </div>
      </div>

      <div v-if="isSearching" class="loading">
        <div class="spinner"></div>
      </div>
      <div v-else-if="searchResults.length === 0" style="text-align: center; padding: 2rem; color: #666">
        <div style="font-size: 3rem; margin-bottom: 1rem">🔍</div>
        <p>No results found. Try adjusting your search or filters.</p>
      </div>
      <div v-else class="search-results">
        <div
          v-for="item in searchResults"
          :key="item.id"
          class="search-result-item"
        >
          <div style="display: flex; justifyContent: space-between; alignItems: flex-start">
            <div style="flex: 1">
              <h3 style="margin: 0 0 0.5rem 0; color: #333">{{ item.title }}</h3>
              <p style="margin: 0 0 0.5rem 0; color: #666">{{ item.description }}</p>
              <div style="display: flex; gap: 1rem; fontSize: 0.9rem; color: #666">
                <span>Category: {{ item.category }}</span>
                <span>Price: ${{ item.price }}</span>
                <span>Rating: {{ item.rating }} ⭐</span>
                <span>Date: {{ new Date(item.date).toLocaleDateString() }}</span>
                <span :style="{ color: item.available ? '#28a745' : '#dc3545' }">
                  {{ item.available ? 'In Stock' : 'Out of Stock' }}
                </span>
              </div>
            </div>
            <div style="display: flex; gap: 0.5rem; marginLeft: 1rem">
              <button class="btn" style="fontSize: 0.8rem; padding: 0.5rem 1rem">
                View Details
              </button>
              <button class="btn btn-secondary" style="fontSize: 0.8rem; padding: 0.5rem 1rem">
                Add to Cart
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SearchInterface',
  data() {
    return {
      searchQuery: '',
      searchResults: [],
      filters: {
        category: 'all',
        dateRange: 'all',
        priceRange: 'all',
        rating: 'all',
        availability: 'all',
        sortBy: 'relevance'
      },
      isSearching: false,
      searchHistory: [],
      suggestions: [],
      showFilters: false,
      mockData: [
        { id: 1, title: 'Wireless Headphones', category: 'electronics', price: 99.99, rating: 4.5, date: '2024-01-15', available: true, description: 'High-quality wireless headphones with noise cancellation' },
        { id: 2, title: 'Smart Watch', category: 'electronics', price: 199.99, rating: 4.2, date: '2024-01-14', available: true, description: 'Advanced smartwatch with health monitoring features' },
        { id: 3, title: 'Coffee Maker', category: 'appliances', price: 79.99, rating: 4.7, date: '2024-01-13', available: false, description: 'Programmable coffee maker with multiple brewing options' },
        { id: 4, title: 'Running Shoes', category: 'sports', price: 129.99, rating: 4.3, date: '2024-01-12', available: true, description: 'Comfortable running shoes for all terrains' },
        { id: 5, title: 'Laptop Stand', category: 'electronics', price: 49.99, rating: 4.1, date: '2024-01-11', available: true, description: 'Adjustable laptop stand for better ergonomics' }
      ]
    }
  },
  watch: {
    searchQuery(newVal) {
      if (newVal.length > 2) {
        const filtered = this.mockData.filter(item =>
          item.title.toLowerCase().includes(newVal.toLowerCase()) ||
          item.description.toLowerCase().includes(newVal.toLowerCase()) ||
          item.category.toLowerCase().includes(newVal.toLowerCase())
        )
        this.suggestions = filtered.slice(0, 5)
      } else {
        this.suggestions = []
      }
    }
  },
  methods: {
    performSearch() {
      if (!this.searchQuery.trim()) return

      this.isSearching = true
      this.searchHistory = [this.searchQuery, ...this.searchHistory.filter(item => item !== this.searchQuery)].slice(0, 10)

      setTimeout(() => {
        let results = [...this.mockData]

        if (this.searchQuery) {
          results = results.filter(item =>
            item.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
            item.description.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
            item.category.toLowerCase().includes(this.searchQuery.toLowerCase())
          )
        }

        if (this.filters.category !== 'all') {
          results = results.filter(item => item.category === this.filters.category)
        }

        if (this.filters.availability !== 'all') {
          const isAvailable = this.filters.availability === 'available'
          results = results.filter(item => item.available === isAvailable)
        }

        if (this.filters.rating !== 'all') {
          const minRating = parseFloat(this.filters.rating)
          results = results.filter(item => item.rating >= minRating)
        }

        this.searchResults = results
        this.isSearching = false
      }, 1000)
    },
    clearFilters() {
      this.filters = {
        category: 'all',
        dateRange: 'all',
        priceRange: 'all',
        rating: 'all',
        availability: 'all',
        sortBy: 'relevance'
      }
    },
    handleSuggestionClick(suggestion) {
      this.searchQuery = suggestion.title
      this.suggestions = []
    },
    handleHistoryClick(query) {
      this.searchQuery = query
    }
  }
}
</script>

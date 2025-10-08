<template>
  <div class="search-interface">
    <div class="search-header">
      <h1>Advanced Search</h1>
      <div class="search-stats">
        <span class="result-count">{{ totalResults }} results found</span>
        <span class="search-time">in {{ searchTime }}ms</span>
      </div>
    </div>

    <div class="search-container">
      <div class="search-sidebar">
        <div class="search-filters">
          <h3>Filters</h3>
          
          <div class="filter-section">
            <h4>Categories</h4>
            <div class="filter-options">
              <label 
                v-for="category in categories"
                :key="category.value"
                class="filter-option"
              >
                <input
                  v-model="selectedCategories"
                  type="checkbox"
                  :value="category.value"
                />
                <span class="filter-label">{{ category.label }}</span>
                <span class="filter-count">({{ category.count }})</span>
              </label>
            </div>
          </div>

          <div class="filter-section">
            <h4>Price Range</h4>
            <div class="price-range">
              <input
                v-model.number="priceRange.min"
                type="number"
                placeholder="Min"
                class="price-input"
              />
              <span class="price-separator">to</span>
              <input
                v-model.number="priceRange.max"
                type="number"
                placeholder="Max"
                class="price-input"
              />
            </div>
            <div class="price-slider">
              <input
                type="range"
                min="0"
                max="1000"
                v-model="priceRange.max"
                class="range-slider"
              />
            </div>
          </div>

          <div class="filter-section">
            <h4>Date Range</h4>
            <div class="date-range">
              <input
                v-model="dateRange.start"
                type="date"
                class="date-input"
              />
              <span class="date-separator">to</span>
              <input
                v-model="dateRange.end"
                type="date"
                class="date-input"
              />
            </div>
          </div>

          <div class="filter-section">
            <h4>Rating</h4>
            <div class="rating-filter">
              <label 
                v-for="rating in ratingOptions"
                :key="rating.value"
                class="rating-option"
              >
                <input
                  v-model="selectedRating"
                  type="radio"
                  :value="rating.value"
                  name="rating"
                />
                <div class="stars">
                  <span 
                    v-for="i in 5"
                    :key="i"
                    class="star"
                    :class="{ filled: i <= rating.value }"
                  >
                    ★
                  </span>
                </div>
                <span class="rating-text">{{ rating.label }}</span>
              </label>
            </div>
          </div>

          <div class="filter-section">
            <h4>Location</h4>
            <select v-model="selectedLocation" class="location-select">
              <option value="">All Locations</option>
              <option
                v-for="location in locations"
                :key="location.value"
                :value="location.value"
              >
                {{ location.label }} ({{ location.count }})
              </option>
            </select>
          </div>

          <div class="filter-actions">
            <button 
              @click="clearFilters"
              class="clear-filters-btn"
            >
              Clear All
            </button>
            <button 
              @click="applyFilters"
              class="apply-filters-btn"
            >
              Apply Filters
            </button>
          </div>
        </div>
      </div>

      <div class="search-main">
        <div class="search-bar">
          <div class="search-input-container">
            <input
              v-model="searchQuery"
              @keyup.enter="performSearch"
              type="text"
              placeholder="Search for anything..."
              class="search-input"
            />
            <button 
              @click="performSearch"
              class="search-btn"
            >
              🔍
            </button>
          </div>
          
          <div class="search-suggestions" v-if="showSuggestions && suggestions.length > 0">
            <div 
              v-for="suggestion in suggestions"
              :key="suggestion"
              @click="selectSuggestion(suggestion)"
              class="suggestion-item"
            >
              {{ suggestion }}
            </div>
          </div>
        </div>

        <div class="search-controls">
          <div class="sort-controls">
            <label class="sort-label">Sort by:</label>
            <select v-model="sortBy" @change="performSearch" class="sort-select">
              <option value="relevance">Relevance</option>
              <option value="price-asc">Price: Low to High</option>
              <option value="price-desc">Price: High to Low</option>
              <option value="date-asc">Date: Oldest First</option>
              <option value="date-desc">Date: Newest First</option>
              <option value="rating">Rating</option>
              <option value="name">Name A-Z</option>
            </select>
          </div>

          <div class="view-controls">
            <button 
              @click="setViewMode('grid')"
              :class="{ active: viewMode === 'grid' }"
              class="view-btn"
              title="Grid View"
            >
              ⊞
            </button>
            <button 
              @click="setViewMode('list')"
              :class="{ active: viewMode === 'list' }"
              class="view-btn"
              title="List View"
            >
              ☰
            </button>
            <button 
              @click="setViewMode('compact')"
              :class="{ active: viewMode === 'compact' }"
              class="view-btn"
              title="Compact View"
            >
              ⋮
            </button>
          </div>
        </div>

        <div class="search-results">
          <div v-if="isLoading" class="loading-state">
            <div class="loading-spinner"></div>
            <p>Searching...</p>
          </div>

          <div v-else-if="searchResults.length === 0" class="no-results">
            <div class="no-results-icon">🔍</div>
            <h3>No results found</h3>
            <p>Try adjusting your search terms or filters</p>
            <button @click="clearFilters" class="clear-search-btn">
              Clear all filters
            </button>
          </div>

          <div v-else class="results-container">
            <div 
              v-for="result in paginatedResults"
              :key="result.id"
              class="result-item"
              :class="viewMode"
            >
              <div class="result-image">
                <img :src="result.image" :alt="result.title" />
                <div class="result-badges">
                  <span 
                    v-if="result.isNew"
                    class="badge new"
                  >
                    New
                  </span>
                  <span 
                    v-if="result.isFeatured"
                    class="badge featured"
                  >
                    Featured
                  </span>
                  <span 
                    v-if="result.discount"
                    class="badge discount"
                  >
                    -{{ result.discount }}%
                  </span>
                </div>
              </div>

              <div class="result-content">
                <h3 class="result-title">{{ result.title }}</h3>
                <p class="result-description">{{ result.description }}</p>
                
                <div class="result-meta">
                  <div class="result-category">{{ result.category }}</div>
                  <div class="result-location">{{ result.location }}</div>
                  <div class="result-date">{{ formatDate(result.date) }}</div>
                </div>

                <div class="result-rating">
                  <div class="stars">
                    <span 
                      v-for="i in 5"
                      :key="i"
                      class="star"
                      :class="{ filled: i <= result.rating }"
                    >
                      ★
                    </span>
                  </div>
                  <span class="rating-value">{{ result.rating }}/5</span>
                  <span class="rating-count">({{ result.reviewCount }} reviews)</span>
                </div>

                <div class="result-price">
                  <span class="current-price">${{ result.price }}</span>
                  <span v-if="result.originalPrice" class="original-price">
                    ${{ result.originalPrice }}
                  </span>
                </div>

                <div class="result-actions">
                  <button 
                    @click="viewDetails(result)"
                    class="view-btn"
                  >
                    View Details
                  </button>
                  <button 
                    @click="addToFavorites(result)"
                    :class="{ active: result.isFavorite }"
                    class="favorite-btn"
                  >
                    {{ result.isFavorite ? '❤️' : '🤍' }}
                  </button>
                  <button 
                    @click="shareResult(result)"
                    class="share-btn"
                  >
                    Share
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div v-if="searchResults.length > 0" class="pagination">
            <button 
              @click="previousPage"
              :disabled="currentPage === 1"
              class="page-btn"
            >
              ← Previous
            </button>
            
            <div class="page-numbers">
              <button 
                v-for="page in visiblePages"
                :key="page"
                @click="goToPage(page)"
                :class="{ active: page === currentPage }"
                class="page-number"
              >
                {{ page }}
              </button>
            </div>
            
            <button 
              @click="nextPage"
              :disabled="currentPage === totalPages"
              class="page-btn"
            >
              Next →
            </button>
          </div>
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
      filteredResults: [],
      totalResults: 0,
      searchTime: 0,
      isLoading: false,
      showSuggestions: false,
      suggestions: [],
      selectedCategories: [],
      priceRange: { min: 0, max: 1000 },
      dateRange: { start: '', end: '' },
      selectedRating: 0,
      selectedLocation: '',
      sortBy: 'relevance',
      viewMode: 'grid',
      currentPage: 1,
      resultsPerPage: 12,
      categories: [
        { value: 'electronics', label: 'Electronics', count: 245 },
        { value: 'clothing', label: 'Clothing', count: 189 },
        { value: 'books', label: 'Books', count: 156 },
        { value: 'home', label: 'Home & Garden', count: 134 },
        { value: 'sports', label: 'Sports', count: 98 },
        { value: 'toys', label: 'Toys', count: 76 }
      ],
      ratingOptions: [
        { value: 0, label: 'Any Rating' },
        { value: 4, label: '4+ Stars' },
        { value: 3, label: '3+ Stars' },
        { value: 2, label: '2+ Stars' },
        { value: 1, label: '1+ Stars' }
      ],
      locations: [
        { value: 'us', label: 'United States', count: 456 },
        { value: 'uk', label: 'United Kingdom', count: 234 },
        { value: 'ca', label: 'Canada', count: 189 },
        { value: 'au', label: 'Australia', count: 123 },
        { value: 'de', label: 'Germany', count: 98 }
      ],
      sampleResults: [
        {
          id: 1,
          title: 'Wireless Bluetooth Headphones',
          description: 'High-quality wireless headphones with noise cancellation and 30-hour battery life.',
          category: 'electronics',
          location: 'us',
          price: 199.99,
          originalPrice: 249.99,
          rating: 4.5,
          reviewCount: 128,
          date: '2024-01-15',
          image: 'https://via.placeholder.com/200x200/4caf50/fff?text=Headphones',
          isNew: true,
          isFeatured: false,
          discount: 20,
          isFavorite: false
        },
        {
          id: 2,
          title: 'Smart Fitness Watch',
          description: 'Advanced fitness tracking with heart rate monitor, GPS, and water resistance.',
          category: 'electronics',
          location: 'uk',
          price: 299.99,
          originalPrice: null,
          rating: 4.8,
          reviewCount: 89,
          date: '2024-01-12',
          image: 'https://via.placeholder.com/200x200/2196f3/fff?text=Watch',
          isNew: false,
          isFeatured: true,
          discount: 0,
          isFavorite: true
        },
        {
          id: 3,
          title: 'Organic Cotton T-Shirt',
          description: 'Comfortable and sustainable organic cotton t-shirt in various colors.',
          category: 'clothing',
          location: 'ca',
          price: 24.99,
          originalPrice: 29.99,
          rating: 4.2,
          reviewCount: 67,
          date: '2024-01-10',
          image: 'https://via.placeholder.com/200x200/ff9800/fff?text=T-Shirt',
          isNew: false,
          isFeatured: false,
          discount: 17,
          isFavorite: false
        }
      ]
    }
  },
  computed: {
    paginatedResults() {
      const start = (this.currentPage - 1) * this.resultsPerPage
      const end = start + this.resultsPerPage
      return this.filteredResults.slice(start, end)
    },
    totalPages() {
      return Math.ceil(this.filteredResults.length / this.resultsPerPage)
    },
    visiblePages() {
      const pages = []
      const start = Math.max(1, this.currentPage - 2)
      const end = Math.min(this.totalPages, this.currentPage + 2)
      
      for (let i = start; i <= end; i++) {
        pages.push(i)
      }
      return pages
    }
  },
  watch: {
    searchQuery() {
      this.generateSuggestions()
    }
  },
  methods: {
    performSearch() {
      this.isLoading = true
      const startTime = Date.now()
      
      setTimeout(() => {
        this.searchResults = [...this.sampleResults]
        this.applyFilters()
        this.searchTime = Date.now() - startTime
        this.isLoading = false
        this.showSuggestions = false
      }, 800)
    },
    generateSuggestions() {
      if (this.searchQuery.length < 2) {
        this.suggestions = []
        this.showSuggestions = false
        return
      }
      
      const allSuggestions = [
        'wireless headphones',
        'smart watch',
        'laptop computer',
        'gaming console',
        'fitness tracker',
        'bluetooth speaker',
        'tablet computer',
        'smartphone case',
        'wireless charger',
        'camera lens'
      ]
      
      this.suggestions = allSuggestions.filter(suggestion =>
        suggestion.toLowerCase().includes(this.searchQuery.toLowerCase())
      ).slice(0, 5)
      
      this.showSuggestions = this.suggestions.length > 0
    },
    selectSuggestion(suggestion) {
      this.searchQuery = suggestion
      this.showSuggestions = false
      this.performSearch()
    },
    applyFilters() {
      let results = [...this.searchResults]
      
      if (this.selectedCategories.length > 0) {
        results = results.filter(result => 
          this.selectedCategories.includes(result.category)
        )
      }
      
      if (this.priceRange.min > 0 || this.priceRange.max < 1000) {
        results = results.filter(result => 
          result.price >= this.priceRange.min && result.price <= this.priceRange.max
        )
      }
      
      if (this.selectedRating > 0) {
        results = results.filter(result => result.rating >= this.selectedRating)
      }
      
      if (this.selectedLocation) {
        results = results.filter(result => result.location === this.selectedLocation)
      }
      
      this.sortResults(results)
      this.filteredResults = results
      this.totalResults = results.length
      this.currentPage = 1
    },
    sortResults(results) {
      switch (this.sortBy) {
        case 'price-asc':
          results.sort((a, b) => a.price - b.price)
          break
        case 'price-desc':
          results.sort((a, b) => b.price - a.price)
          break
        case 'date-asc':
          results.sort((a, b) => new Date(a.date) - new Date(b.date))
          break
        case 'date-desc':
          results.sort((a, b) => new Date(b.date) - new Date(a.date))
          break
        case 'rating':
          results.sort((a, b) => b.rating - a.rating)
          break
        case 'name':
          results.sort((a, b) => a.title.localeCompare(b.title))
          break
        default:
          break
      }
    },
    clearFilters() {
      this.selectedCategories = []
      this.priceRange = { min: 0, max: 1000 }
      this.dateRange = { start: '', end: '' }
      this.selectedRating = 0
      this.selectedLocation = ''
      this.searchQuery = ''
      this.applyFilters()
    },
    setViewMode(mode) {
      this.viewMode = mode
    },
    viewDetails(result) {
      console.log('Viewing details for:', result.title)
      alert(`Viewing details for: ${result.title}`)
    },
    addToFavorites(result) {
      result.isFavorite = !result.isFavorite
      console.log('Toggled favorite for:', result.title)
    },
    shareResult(result) {
      console.log('Sharing:', result.title)
      alert(`Sharing: ${result.title}`)
    },
    previousPage() {
      if (this.currentPage > 1) {
        this.currentPage--
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++
      }
    },
    goToPage(page) {
      this.currentPage = page
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
      })
    }
  }
}
</script>

<style scoped>
.search-interface {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.search-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.search-header h1 {
  margin: 0;
  color: #333;
  font-size: 28px;
}

.search-stats {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #666;
}

.result-count {
  font-weight: 600;
  color: #4caf50;
}

.search-container {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 30px;
}

.search-sidebar {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  height: fit-content;
}

.search-filters h3 {
  margin: 0 0 20px 0;
  color: #333;
  font-size: 18px;
}

.filter-section {
  margin-bottom: 25px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.filter-section:last-child {
  border-bottom: none;
  margin-bottom: 0;
}

.filter-section h4 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 14px;
  font-weight: 600;
}

.filter-options {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.filter-option {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 14px;
}

.filter-label {
  color: #333;
}

.filter-count {
  color: #666;
  font-size: 12px;
}

.price-range {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.price-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.price-input:focus {
  outline: none;
  border-color: #4caf50;
}

.price-separator {
  color: #666;
  font-size: 14px;
}

.price-slider {
  margin-top: 10px;
}

.range-slider {
  width: 100%;
  height: 4px;
  border-radius: 2px;
  background: #ddd;
  outline: none;
  cursor: pointer;
}

.range-slider::-webkit-slider-thumb {
  appearance: none;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: #4caf50;
  cursor: pointer;
}

.date-range {
  display: flex;
  align-items: center;
  gap: 10px;
}

.date-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.date-input:focus {
  outline: none;
  border-color: #4caf50;
}

.date-separator {
  color: #666;
  font-size: 14px;
}

.rating-filter {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.rating-option {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  font-size: 14px;
}

.stars {
  display: flex;
  gap: 2px;
}

.star {
  color: #ddd;
  font-size: 16px;
}

.star.filled {
  color: #ffc107;
}

.rating-text {
  color: #333;
}

.location-select {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.location-select:focus {
  outline: none;
  border-color: #4caf50;
}

.filter-actions {
  display: flex;
  gap: 10px;
  margin-top: 20px;
}

.clear-filters-btn,
.apply-filters-btn {
  flex: 1;
  padding: 10px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.clear-filters-btn {
  background: #f5f5f5;
  color: #666;
}

.clear-filters-btn:hover {
  background: #e0e0e0;
}

.apply-filters-btn {
  background: #4caf50;
  color: white;
}

.apply-filters-btn:hover {
  background: #45a049;
}

.search-main {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.search-bar {
  position: relative;
}

.search-input-container {
  display: flex;
  background: white;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
  transition: border-color 0.3s ease;
}

.search-input-container:focus-within {
  border-color: #4caf50;
}

.search-input {
  flex: 1;
  padding: 15px 20px;
  border: none;
  outline: none;
  font-size: 16px;
  color: #333;
}

.search-input::placeholder {
  color: #999;
}

.search-btn {
  padding: 15px 20px;
  background: #4caf50;
  color: white;
  border: none;
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
  z-index: 10;
}

.suggestion-item {
  padding: 12px 20px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: background-color 0.3s ease;
}

.suggestion-item:hover {
  background: #f8f9fa;
}

.search-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 0;
  border-bottom: 1px solid #e0e0e0;
}

.sort-controls {
  display: flex;
  align-items: center;
  gap: 10px;
}

.sort-label {
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.sort-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.sort-select:focus {
  outline: none;
  border-color: #4caf50;
}

.view-controls {
  display: flex;
  gap: 5px;
}

.view-btn {
  width: 36px;
  height: 36px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.view-btn:hover {
  background: #f0f0f0;
  border-color: #4caf50;
}

.view-btn.active {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.search-results {
  min-height: 400px;
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
  border: 4px solid #f3f3f3;
  border-top: 4px solid #4caf50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
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

.clear-search-btn {
  padding: 10px 20px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.clear-search-btn:hover {
  background: #45a049;
}

.results-container {
  display: grid;
  gap: 20px;
}

.results-container.grid {
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
}

.results-container.list {
  grid-template-columns: 1fr;
}

.results-container.compact {
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
}

.result-item {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
  transition: all 0.3s ease;
  cursor: pointer;
}

.result-item:hover {
  border-color: #4caf50;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
}

.result-item.list {
  display: flex;
  gap: 20px;
}

.result-item.compact {
  padding: 10px;
}

.result-image {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
}

.result-item.list .result-image {
  width: 200px;
  height: 150px;
  flex-shrink: 0;
}

.result-item.compact .result-image {
  height: 120px;
}

.result-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.result-badges {
  position: absolute;
  top: 10px;
  left: 10px;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.badge {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 10px;
  font-weight: 600;
  color: white;
}

.badge.new {
  background: #4caf50;
}

.badge.featured {
  background: #ff9800;
}

.badge.discount {
  background: #f44336;
}

.result-content {
  padding: 20px;
}

.result-item.compact .result-content {
  padding: 10px 0;
}

.result-title {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 18px;
  font-weight: 600;
  line-height: 1.4;
}

.result-item.compact .result-title {
  font-size: 14px;
  margin-bottom: 5px;
}

.result-description {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
  line-height: 1.5;
}

.result-item.compact .result-description {
  font-size: 12px;
  margin-bottom: 10px;
}

.result-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 12px;
  color: #999;
}

.result-item.compact .result-meta {
  flex-direction: column;
  gap: 5px;
}

.result-rating {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 15px;
}

.result-item.compact .result-rating {
  margin-bottom: 10px;
}

.rating-value {
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.rating-count {
  color: #666;
  font-size: 12px;
}

.result-price {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
}

.current-price {
  font-size: 20px;
  font-weight: bold;
  color: #4caf50;
}

.result-item.compact .current-price {
  font-size: 16px;
}

.original-price {
  font-size: 16px;
  color: #999;
  text-decoration: line-through;
}

.result-item.compact .original-price {
  font-size: 14px;
}

.result-actions {
  display: flex;
  gap: 10px;
}

.result-item.compact .result-actions {
  flex-direction: column;
  gap: 5px;
}

.view-btn,
.favorite-btn,
.share-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.result-item.compact .view-btn,
.result-item.compact .favorite-btn,
.result-item.compact .share-btn {
  padding: 6px 12px;
  font-size: 11px;
}

.view-btn {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.view-btn:hover {
  background: #45a049;
}

.favorite-btn {
  background: white;
  color: #666;
}

.favorite-btn:hover {
  background: #f0f0f0;
  border-color: #4caf50;
}

.favorite-btn.active {
  background: #f44336;
  color: white;
  border-color: #f44336;
}

.share-btn {
  background: white;
  color: #666;
}

.share-btn:hover {
  background: #f0f0f0;
  border-color: #4caf50;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  margin-top: 40px;
  padding: 20px 0;
}

.page-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.page-btn:hover:not(:disabled) {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.page-numbers {
  display: flex;
  gap: 5px;
}

.page-number {
  width: 40px;
  height: 40px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.page-number:hover {
  background: #f0f0f0;
  border-color: #4caf50;
}

.page-number.active {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

@media (max-width: 1024px) {
  .search-container {
    grid-template-columns: 250px 1fr;
    gap: 20px;
  }
  
  .results-container.grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
}

@media (max-width: 768px) {
  .search-interface {
    padding: 15px;
  }
  
  .search-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .search-stats {
    justify-content: center;
  }
  
  .search-container {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .search-sidebar {
    order: 2;
  }
  
  .search-main {
    order: 1;
  }
  
  .search-controls {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .sort-controls {
    justify-content: center;
  }
  
  .view-controls {
    justify-content: center;
  }
  
  .results-container.grid {
    grid-template-columns: 1fr;
  }
  
  .result-item.list {
    flex-direction: column;
  }
  
  .result-item.list .result-image {
    width: 100%;
    height: 200px;
  }
  
  .pagination {
    flex-wrap: wrap;
  }
}

@media (max-width: 480px) {
  .search-interface {
    padding: 10px;
  }
  
  .search-input-container {
    flex-direction: column;
  }
  
  .search-input {
    padding: 12px 15px;
    font-size: 14px;
  }
  
  .search-btn {
    padding: 12px 15px;
    font-size: 14px;
  }
  
  .filter-actions {
    flex-direction: column;
  }
  
  .result-actions {
    flex-direction: column;
  }
  
  .page-numbers {
    flex-wrap: wrap;
    justify-content: center;
  }
}
</style>

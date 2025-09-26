<template>
  <div class="search-container">
    <div class="main-content">
      <h1>Search Interface</h1>
      <p>Search for content using the input field below. Suggestions will appear as you type.</p>
      
      <div class="search-section">
        <div class="search-input-container">
          <label for="search-input" class="search-label">
            Search for content:
          </label>
          <div class="input-wrapper">
            <input
              id="search-input"
              v-model="query"
              type="text"
              placeholder="Type to search..."
              @keydown="handleKeyDown"
              @input="handleInput"
              class="search-input"
              :aria-expanded="showSuggestions"
              aria-haspopup="listbox"
              aria-autocomplete="list"
              :aria-activedescendant="showSuggestions ? `suggestion-${activeSuggestionIndex}` : undefined"
            />
            
            <!-- Suggestions Dropdown - MISSING ARIA ATTRIBUTES -->
            <div
              v-if="showSuggestions && suggestions.length > 0"
              class="suggestions-dropdown"
              role="listbox"
              aria-label="Search suggestions"
            >
              <div
                v-for="(suggestion, index) in suggestions"
                :key="suggestion.id"
                :id="`suggestion-${index}`"
                @click="handleSuggestionClick(suggestion)"
                class="suggestion-item"
                :class="{ 'active': index === activeSuggestionIndex }"
                role="option"
                :aria-selected="index === activeSuggestionIndex"
              >
                <div class="suggestion-title">{{ suggestion.title }}</div>
                <div class="suggestion-meta">{{ suggestion.category }} • {{ suggestion.author }}</div>
              </div>
            </div>
          </div>
        </div>
        
        <button
          @click="handleSearch"
          :disabled="isLoading || !query.trim()"
          class="search-button"
          :class="{ 'loading': isLoading }"
        >
          {{ isLoading ? 'Searching...' : 'Search' }}
        </button>
      </div>

      <!-- Results Area - MISSING LIVE REGION -->
      <div class="results-section">
        <h2>Search Results</h2>
        <div v-if="isLoading" class="loading-state">
          <div class="loading-text">Searching...</div>
        </div>
        <div v-else-if="results.length > 0" class="results-content">
          <div class="results-count">
            Found {{ results.length }} result{{ results.length !== 1 ? 's' : '' }}
          </div>
          <div class="results-grid">
            <div
              v-for="result in results"
              :key="result.id"
              class="result-card"
            >
              <h3 class="result-title">{{ result.title }}</h3>
              <p class="result-category">Category: {{ result.category }}</p>
              <p class="result-author">Author: {{ result.author }}</p>
            </div>
          </div>
        </div>
        <div v-else-if="query" class="no-results">
          <div class="no-results-text">No results found for "{{ query }}"</div>
        </div>
        <div v-else class="empty-state">
          <div class="empty-text">Enter a search term to find content</div>
        </div>
      </div>
    </div>

    <div class="accessibility-info">
      <h3>Accessibility Issues:</h3>
      <ul>
        <li><strong>Missing live region:</strong> No announcements when search results change</li>
        <li><strong>Incomplete ARIA attributes:</strong> Suggestions lack proper aria-activedescendant</li>
        <li><strong>No keyboard navigation:</strong> Arrow keys don't navigate through suggestions</li>
        <li><strong>Missing announcements:</strong> Screen readers don't announce result count changes</li>
        <li><strong>No loading state announcement:</strong> Loading state not announced to screen readers</li>
        <li><strong>Missing suggestion selection:</strong> No aria-selected state management</li>
      </ul>
      
      <h3>How to Fix:</h3>
      <ul>
        <li>Add <code>aria-live="polite"</code> region for result announcements</li>
        <li>Implement <code>aria-activedescendant</code> for suggestion navigation</li>
        <li>Add arrow key navigation (Up/Down) through suggestions</li>
        <li>Announce result count changes ("Found X results")</li>
        <li>Add loading state announcements</li>
        <li>Implement proper <code>aria-selected</code> state management</li>
      </ul>
    </div>
  </div>
</template>

<script>
import { ref, computed, watch } from 'vue'

export default {
  name: 'SearchWithSilentUpdates',
  setup() {
    const query = ref('')
    const suggestions = ref([])
    const results = ref([])
    const isLoading = ref(false)
    const showSuggestions = ref(false)
    const activeSuggestionIndex = ref(-1)

    const mockData = [
      { id: 1, title: 'React Development Guide', category: 'Books', author: 'John Doe' },
      { id: 2, title: 'Vue.js Tutorial', category: 'Books', author: 'Jane Smith' },
      { id: 3, title: 'Angular Framework', category: 'Books', author: 'Bob Johnson' },
      { id: 4, title: 'JavaScript Fundamentals', category: 'Books', author: 'Alice Brown' },
      { id: 5, title: 'React Components', category: 'Tutorials', author: 'Charlie Wilson' },
      { id: 6, title: 'Vue Components', category: 'Tutorials', author: 'Diana Lee' },
      { id: 7, title: 'Angular Services', category: 'Tutorials', author: 'Eve Davis' },
      { id: 8, title: 'JavaScript ES6', category: 'Tutorials', author: 'Frank Miller' }
    ]

    const handleInput = () => {
      if (query.value.length > 1) {
        const filtered = mockData.filter(item =>
          item.title.toLowerCase().includes(query.value.toLowerCase()) ||
          item.category.toLowerCase().includes(query.value.toLowerCase()) ||
          item.author.toLowerCase().includes(query.value.toLowerCase())
        )
        suggestions.value = filtered.slice(0, 5)
        showSuggestions.value = true
        activeSuggestionIndex.value = -1
      } else {
        suggestions.value = []
        showSuggestions.value = false
        activeSuggestionIndex.value = -1
      }
    }

    const handleSearch = async () => {
      isLoading.value = true
      // Simulate API call
      setTimeout(() => {
        const filtered = mockData.filter(item =>
          item.title.toLowerCase().includes(query.value.toLowerCase()) ||
          item.category.toLowerCase().includes(query.value.toLowerCase()) ||
          item.author.toLowerCase().includes(query.value.toLowerCase())
        )
        results.value = filtered
        isLoading.value = false
        showSuggestions.value = false
        activeSuggestionIndex.value = -1
        
        // MISSING: Screen reader announcement of results
        // Should announce "Found X results" or "No results found"
      }, 1000)
    }

    const handleSuggestionClick = (suggestion) => {
      query.value = suggestion.title
      showSuggestions.value = false
      activeSuggestionIndex.value = -1
      handleSearch()
    }

    const handleKeyDown = (e) => {
      if (e.key === 'Enter') {
        if (showSuggestions.value && activeSuggestionIndex.value >= 0) {
          e.preventDefault()
          handleSuggestionClick(suggestions.value[activeSuggestionIndex.value])
        } else {
          handleSearch()
        }
      } else if (e.key === 'Escape') {
        showSuggestions.value = false
        activeSuggestionIndex.value = -1
      } else if (e.key === 'ArrowDown') {
        e.preventDefault()
        if (showSuggestions.value) {
          activeSuggestionIndex.value = Math.min(activeSuggestionIndex.value + 1, suggestions.value.length - 1)
        }
      } else if (e.key === 'ArrowUp') {
        e.preventDefault()
        if (showSuggestions.value) {
          activeSuggestionIndex.value = Math.max(activeSuggestionIndex.value - 1, -1)
        }
      }
    }

    return {
      query,
      suggestions,
      results,
      isLoading,
      showSuggestions,
      activeSuggestionIndex,
      handleInput,
      handleSearch,
      handleSuggestionClick,
      handleKeyDown
    }
  }
}
</script>

<style scoped>
.search-container {
  font-family: Arial, sans-serif;
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.search-section {
  margin-bottom: 30px;
}

.search-input-container {
  margin-bottom: 20px;
}

.search-label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
}

.input-wrapper {
  position: relative;
}

.search-input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.search-input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.suggestions-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 2px solid #007bff;
  border-top: none;
  border-radius: 0 0 4px 4px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 1000;
  max-height: 200px;
  overflow-y: auto;
}

.suggestion-item {
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid #eee;
  font-size: 14px;
}

.suggestion-item:hover,
.suggestion-item.active {
  background-color: #f8f9fa;
}

.suggestion-item:last-child {
  border-bottom: none;
}

.suggestion-title {
  font-weight: bold;
  color: #333;
}

.suggestion-meta {
  color: #666;
  font-size: 12px;
}

.search-button {
  background-color: #007bff;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}

.search-button:hover:not(:disabled) {
  background-color: #0056b3;
}

.search-button:disabled,
.search-button.loading {
  background-color: #6c757d;
  cursor: not-allowed;
}

.results-section h2 {
  margin-top: 0;
  color: #333;
}

.loading-state,
.no-results,
.empty-state {
  text-align: center;
  padding: 20px;
}

.loading-text,
.no-results-text,
.empty-text {
  font-size: 18px;
  color: #666;
}

.results-count {
  margin-bottom: 16px;
  font-size: 14px;
  color: #666;
}

.results-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.result-card {
  background: #f8f9fa;
  padding: 16px;
  border-radius: 4px;
  border: 1px solid #ddd;
}

.result-title {
  margin: 0 0 8px 0;
  color: #333;
}

.result-category,
.result-author {
  margin: 0 0 4px 0;
  color: #666;
  font-size: 14px;
}

.accessibility-info {
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}

.accessibility-info h3 {
  margin-top: 0;
}

.accessibility-info ul {
  margin-bottom: 20px;
}

.accessibility-info li {
  margin-bottom: 8px;
}
</style>
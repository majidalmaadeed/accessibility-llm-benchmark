<script>
  import { onMount } from 'svelte';
  
  let searchQuery = '';
  let searchResults = [];
  let filteredResults = [];
  let totalResults = 0;
  let searchTime = 0;
  let isLoading = false;
  let showSuggestions = false;
  let suggestions = [];
  let selectedCategories = [];
  let priceRange = { min: 0, max: 1000 };
  let dateRange = { start: '', end: '' };
  let selectedRating = 0;
  let selectedLocation = '';
  let sortBy = 'relevance';
  let viewMode = 'grid';
  let currentPage = 1;
  let resultsPerPage = 12;
  
  let categories = [
    { value: 'restaurant', label: 'Restaurants', count: 45 },
    { value: 'hotel', label: 'Hotels', count: 23 },
    { value: 'attraction', label: 'Attractions', count: 18 },
    { value: 'shopping', label: 'Shopping', count: 32 },
    { value: 'entertainment', label: 'Entertainment', count: 15 }
  ];
  
  let ratingOptions = [
    { value: 0, label: 'Any Rating' },
    { value: 4, label: '4+ Stars' },
    { value: 3, label: '3+ Stars' },
    { value: 2, label: '2+ Stars' },
    { value: 1, label: '1+ Stars' }
  ];
  
  let locations = [
    { value: 'us', label: 'United States', count: 456 },
    { value: 'uk', label: 'United Kingdom', count: 234 },
    { value: 'ca', label: 'Canada', count: 189 },
    { value: 'au', label: 'Australia', count: 123 },
    { value: 'de', label: 'Germany', count: 98 }
  ];
  
  let sampleResults = [
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
  ];
  
  onMount(() => {
    // Initialize search
  });
  
  function performSearch() {
    if (searchQuery.trim()) {
      isLoading = true;
      const startTime = Date.now();
      
      setTimeout(() => {
        searchResults = [...sampleResults];
        applyFilters();
        searchTime = Date.now() - startTime;
        isLoading = false;
        showSuggestions = false;
      }, 800);
    }
  }
  
  function generateSuggestions() {
    if (searchQuery.length < 2) {
      suggestions = [];
      showSuggestions = false;
      return;
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
    ];
    
    suggestions = allSuggestions.filter(suggestion =>
      suggestion.toLowerCase().includes(searchQuery.toLowerCase())
    ).slice(0, 5);
    
    showSuggestions = suggestions.length > 0;
  }
  
  function selectSuggestion(suggestion) {
    searchQuery = suggestion;
    showSuggestions = false;
    performSearch();
  }
  
  function applyFilters() {
    let results = [...searchResults];
    
    if (selectedCategories.length > 0) {
      results = results.filter(result => 
        selectedCategories.includes(result.category)
      );
    }
    
    if (priceRange.min > 0 || priceRange.max < 1000) {
      results = results.filter(result => 
        result.price >= priceRange.min && result.price <= priceRange.max
      );
    }
    
    if (selectedRating > 0) {
      results = results.filter(result => result.rating >= selectedRating);
    }
    
    if (selectedLocation) {
      results = results.filter(result => result.location === selectedLocation);
    }
    
    sortResults(results);
    filteredResults = results;
    totalResults = results.length;
    currentPage = 1;
  }
  
  function sortResults(results) {
    switch (sortBy) {
      case 'price-asc':
        results.sort((a, b) => a.price - b.price);
        break;
      case 'price-desc':
        results.sort((a, b) => b.price - a.price);
        break;
      case 'date-asc':
        results.sort((a, b) => new Date(a.date) - new Date(b.date));
        break;
      case 'date-desc':
        results.sort((a, b) => new Date(b.date) - new Date(a.date));
        break;
      case 'rating':
        results.sort((a, b) => b.rating - a.rating);
        break;
      case 'name':
        results.sort((a, b) => a.title.localeCompare(b.title));
        break;
      default:
        break;
    }
  }
  
  function setViewMode(mode) {
    viewMode = mode;
  }
  
  function viewDetails(result) {
    console.log('Viewing details for:', result.title);
    alert(`Viewing details for: ${result.title}`);
  }
  
  function addToFavorites(result) {
    result.isFavorite = !result.isFavorite;
    console.log('Toggled favorite for:', result.title);
  }
  
  function shareResult(result) {
    console.log('Sharing:', result.title);
    alert(`Sharing: ${result.title}`);
  }
  
  function previousPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
  
  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }
  
  function goToPage(page) {
    currentPage = page;
  }
  
  function formatPrice(price) {
    return `$${price.toFixed(2)}`;
  }
  
  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }
  
  $: paginatedResults = filteredResults.slice(
    (currentPage - 1) * resultsPerPage,
    currentPage * resultsPerPage
  );
  
  $: totalPages = Math.ceil(filteredResults.length / resultsPerPage);
  
  $: startItem = (currentPage - 1) * resultsPerPage + 1;
  $: endItem = Math.min(currentPage * resultsPerPage, filteredResults.length);
  
  $: if (searchQuery) {
    generateSuggestions();
  }
</script>

<div class="search-interface">
  <div class="search-header">
    <h1>Advanced Search</h1>
    <div class="search-stats">
      <span class="result-count">{totalResults} results found</span>
      <span class="search-time">in {searchTime}ms</span>
    </div>
  </div>

  <div class="search-container">
    <div class="search-sidebar">
      <div class="search-filters">
        <h3>Filters</h3>
        
        <div class="filter-section">
          <h4>Categories</h4>
          <div class="filter-options">
            {#each categories as category}
              <label class="filter-option">
                <input
                  bind:group={selectedCategories}
                  type="checkbox"
                  value={category.value}
                />
                <span class="filter-label">{category.label}</span>
                <span class="filter-count">({category.count})</span>
              </label>
            {/each}
          </div>
        </div>

        <div class="filter-section">
          <h4>Price Range</h4>
          <div class="price-range">
            <input
              bind:value={priceRange.min}
              type="number"
              placeholder="Min"
              class="price-input"
            />
            <span class="price-separator">to</span>
            <input
              bind:value={priceRange.max}
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
              bind:value={priceRange.max}
              class="range-slider"
            />
          </div>
        </div>

        <div class="filter-section">
          <h4>Date Range</h4>
          <div class="date-range">
            <input
              bind:value={dateRange.start}
              type="date"
              class="date-input"
            />
            <span class="date-separator">to</span>
            <input
              bind:value={dateRange.end}
              type="date"
              class="date-input"
            />
          </div>
        </div>

        <div class="filter-section">
          <h4>Rating</h4>
          <div class="rating-filter">
            {#each ratingOptions as rating}
              <label class="rating-option">
                <input
                  bind:group={selectedRating}
                  type="radio"
                  value={rating.value}
                  name="rating"
                />
                <div class="stars">
                  {#each Array.from({length: 5}, (_, i) => i + 1) as i}
                    <span 
                      class="star"
                      class:filled={i <= rating.value}
                    >
                      ★
                    </span>
                  {/each}
                </div>
                <span class="rating-text">{rating.label}</span>
              </label>
            {/each}
          </div>
        </div>

        <div class="filter-section">
          <h4>Location</h4>
          <select bind:value={selectedLocation} class="location-select">
            <option value="">All Locations</option>
            {#each locations as location}
              <option value={location.value}>
                {location.label} ({location.count})
              </option>
            {/each}
          </select>
        </div>

        <div class="filter-actions">
          <button 
            on:click={() => {
              selectedCategories = [];
              priceRange = { min: 0, max: 1000 };
              dateRange = { start: '', end: '' };
              selectedRating = 0;
              selectedLocation = '';
              applyFilters();
            }}
            class="clear-filters-btn"
          >
            Clear All
          </button>
          <button 
            on:click={applyFilters}
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
            bind:value={searchQuery}
            on:keyup={(e) => e.key === 'Enter' && performSearch()}
            type="text"
            placeholder="Search for anything..."
            class="search-input"
          />
          <button 
            on:click={performSearch}
            class="search-btn"
          >
            🔍
          </button>
        </div>
        
        {#if showSuggestions && suggestions.length > 0}
          <div class="search-suggestions">
            {#each suggestions as suggestion}
              <div 
                on:click={() => selectSuggestion(suggestion)}
                class="suggestion-item"
              >
                {suggestion}
              </div>
            {/each}
          </div>
        {/if}
      </div>

      <div class="search-controls">
        <div class="sort-controls">
          <label class="sort-label">Sort by:</label>
          <select bind:value={sortBy} on:change={performSearch} class="sort-select">
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
            on:click={() => setViewMode('grid')}
            class="view-btn"
            class:active={viewMode === 'grid'}
            title="Grid View"
          >
            ⊞
          </button>
          <button 
            on:click={() => setViewMode('list')}
            class="view-btn"
            class:active={viewMode === 'list'}
            title="List View"
          >
            ☰
          </button>
          <button 
            on:click={() => setViewMode('compact')}
            class="view-btn"
            class:active={viewMode === 'compact'}
            title="Compact View"
          >
            ⋮
          </button>
        </div>
      </div>

      <div class="search-results">
        {#if isLoading}
          <div class="loading-state">
            <div class="loading-spinner"></div>
            <p>Searching...</p>
          </div>
        {:else if filteredResults.length === 0}
          <div class="no-results">
            <div class="no-results-icon">🔍</div>
            <h3>No results found</h3>
            <p>Try adjusting your search terms or filters</p>
            <button 
              on:click={() => {
                selectedCategories = [];
                priceRange = { min: 0, max: 1000 };
                dateRange = { start: '', end: '' };
                selectedRating = 0;
                selectedLocation = '';
                applyFilters();
              }}
              class="clear-search-btn"
            >
              Clear all filters
            </button>
          </div>
        {:else}
          <div class="results-container" class:grid={viewMode === 'grid'} class:list={viewMode === 'list'} class:compact={viewMode === 'compact'}>
            {#each paginatedResults as result}
              <div class="result-item" class:grid={viewMode === 'grid'} class:list={viewMode === 'list'} class:compact={viewMode === 'compact'}>
                <div class="result-image">
                  <img src={result.image} alt={result.title} />
                  <div class="result-badges">
                    {#if result.isNew}
                      <span class="badge new">New</span>
                    {/if}
                    {#if result.isFeatured}
                      <span class="badge featured">Featured</span>
                    {/if}
                    {#if result.discount}
                      <span class="badge discount">-{result.discount}%</span>
                    {/if}
                  </div>
                </div>

                <div class="result-content">
                  <h3 class="result-title">{result.title}</h3>
                  <p class="result-description">{result.description}</p>
                  
                  <div class="result-meta">
                    <div class="result-category">{result.category}</div>
                    <div class="result-location">{result.location}</div>
                    <div class="result-date">{formatDate(result.date)}</div>
                  </div>

                  <div class="result-rating">
                    <div class="stars">
                      {#each Array.from({length: 5}, (_, i) => i + 1) as i}
                        <span 
                          class="star"
                          class:filled={i <= result.rating}
                        >
                          ★
                        </span>
                      {/each}
                    </div>
                    <span class="rating-value">{result.rating}/5</span>
                    <span class="rating-count">({result.reviewCount} reviews)</span>
                  </div>

                  <div class="result-price">
                    <span class="current-price">{formatPrice(result.price)}</span>
                    {#if result.originalPrice}
                      <span class="original-price">{formatPrice(result.originalPrice)}</span>
                    {/if}
                  </div>

                  <div class="result-actions">
                    <button 
                      on:click={() => viewDetails(result)}
                      class="view-btn"
                    >
                      View Details
                    </button>
                    <button 
                      on:click={() => addToFavorites(result)}
                      class="favorite-btn"
                      class:active={result.isFavorite}
                    >
                      {result.isFavorite ? '❤️' : '🤍'}
                    </button>
                    <button 
                      on:click={() => shareResult(result)}
                      class="share-btn"
                    >
                      Share
                    </button>
                  </div>
                </div>
              </div>
            {/each}
          </div>
        {/if}

        {#if filteredResults.length > 0}
          <div class="pagination">
            <button 
              on:click={previousPage}
              disabled={currentPage === 1}
              class="page-btn"
            >
              ← Previous
            </button>
            
            <div class="page-numbers">
              {#each Array.from({length: Math.min(5, totalPages)}, (_, i) => {
                const start = Math.max(1, currentPage - 2);
                return start + i;
              }).filter(page => page <= totalPages) as page}
                <button 
                  on:click={() => goToPage(page)}
                  class="page-number"
                  class:active={page === currentPage}
                >
                  {page}
                </button>
              {/each}
            </div>
            
            <button 
              on:click={nextPage}
              disabled={currentPage === totalPages}
              class="page-btn"
            >
              Next →
            </button>
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>

<style>
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
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e0e0e0;
  }

  .search-header h1 {
    margin: 0;
    color: #333;
    font-size: 24px;
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
    gap: 8px;
    cursor: pointer;
    font-size: 14px;
  }

  .stars {
    display: flex;
    gap: 1px;
  }

  .star {
    color: #ddd;
    font-size: 12px;
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

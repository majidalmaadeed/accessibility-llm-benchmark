<script>
  import { onMount } from 'svelte';
  
  let searchQuery = '';
  let searchResults = [];
  let filteredResults = [];
  let isLoading = false;
  let showFilters = false;
  let showSortOptions = false;
  let currentPage = 1;
  let itemsPerPage = 10;
  let selectedCategory = 'all';
  let selectedDateRange = 'all';
  let selectedSort = 'relevance';
  let selectedView = 'list';
  let searchHistory = [];
  let suggestions = [];
  let showSuggestions = false;
  let selectedSuggestion = -1;

  const sampleData = [
    {
      id: 1,
      title: 'Advanced React Patterns',
      description: 'Learn advanced React patterns including hooks, context, and performance optimization techniques.',
      category: 'tutorial',
      author: 'John Smith',
      date: '2024-01-15',
      tags: ['react', 'javascript', 'frontend'],
      rating: 4.8,
      views: 1250,
      type: 'article'
    },
    {
      id: 2,
      title: 'Building Scalable APIs',
      description: 'Comprehensive guide to building RESTful APIs that can handle millions of requests.',
      category: 'guide',
      author: 'Sarah Johnson',
      date: '2024-01-10',
      tags: ['api', 'backend', 'scalability'],
      rating: 4.6,
      views: 890,
      type: 'video'
    },
    {
      id: 3,
      title: 'CSS Grid Mastery',
      description: 'Master CSS Grid layout with practical examples and real-world applications.',
      category: 'tutorial',
      author: 'Mike Chen',
      date: '2024-01-08',
      tags: ['css', 'grid', 'layout'],
      rating: 4.9,
      views: 2100,
      type: 'article'
    },
    {
      id: 4,
      title: 'Database Optimization',
      description: 'Techniques for optimizing database performance and query efficiency.',
      category: 'guide',
      author: 'Emily Davis',
      date: '2024-01-05',
      tags: ['database', 'sql', 'performance'],
      rating: 4.7,
      views: 1560,
      type: 'tutorial'
    },
    {
      id: 5,
      title: 'Machine Learning Basics',
      description: 'Introduction to machine learning concepts and practical implementations.',
      category: 'course',
      author: 'Dr. Alex Wilson',
      date: '2024-01-12',
      tags: ['ml', 'ai', 'python'],
      rating: 4.5,
      views: 3200,
      type: 'course'
    },
    {
      id: 6,
      title: 'Docker Containerization',
      description: 'Complete guide to containerizing applications with Docker.',
      category: 'tutorial',
      author: 'Tom Brown',
      date: '2024-01-03',
      tags: ['docker', 'containers', 'devops'],
      rating: 4.4,
      views: 980,
      type: 'video'
    },
    {
      id: 7,
      title: 'GraphQL Fundamentals',
      description: 'Learn GraphQL from basics to advanced query optimization.',
      category: 'guide',
      author: 'Lisa Garcia',
      date: '2024-01-18',
      tags: ['graphql', 'api', 'query'],
      rating: 4.8,
      views: 1450,
      type: 'article'
    },
    {
      id: 8,
      title: 'Security Best Practices',
      description: 'Essential security practices for web applications and APIs.',
      category: 'guide',
      author: 'Security Expert',
      date: '2024-01-20',
      tags: ['security', 'web', 'best-practices'],
      rating: 4.9,
      views: 2800,
      type: 'tutorial'
    }
  ];

  const categories = [
    { value: 'all', label: 'All Categories' },
    { value: 'tutorial', label: 'Tutorials' },
    { value: 'guide', label: 'Guides' },
    { value: 'course', label: 'Courses' },
    { value: 'article', label: 'Articles' }
  ];

  const dateRanges = [
    { value: 'all', label: 'All Time' },
    { value: 'today', label: 'Today' },
    { value: 'week', label: 'This Week' },
    { value: 'month', label: 'This Month' },
    { value: 'year', label: 'This Year' }
  ];

  const sortOptions = [
    { value: 'relevance', label: 'Relevance' },
    { value: 'date', label: 'Date' },
    { value: 'rating', label: 'Rating' },
    { value: 'views', label: 'Views' },
    { value: 'title', label: 'Title' }
  ];

  const viewOptions = [
    { value: 'list', label: 'List View', icon: '📋' },
    { value: 'grid', label: 'Grid View', icon: '⊞' },
    { value: 'compact', label: 'Compact View', icon: '☰' }
  ];

  $: totalPages = Math.ceil(filteredResults.length / itemsPerPage);
  $: startIndex = (currentPage - 1) * itemsPerPage;
  $: paginatedResults = filteredResults.slice(startIndex, startIndex + itemsPerPage);

  onMount(() => {
    loadSearchHistory();
    performSearch();
  });

  $: performSearch();
  $: applyFilters();

  function loadSearchHistory() {
    const saved = localStorage.getItem('searchHistory');
    if (saved) {
      searchHistory = JSON.parse(saved);
    }
  }

  function saveSearchHistory() {
    localStorage.setItem('searchHistory', JSON.stringify(searchHistory));
  }

  function performSearch() {
    if (!searchQuery.trim()) {
      searchResults = sampleData;
      applyFilters();
      return;
    }

    isLoading = true;
    
    setTimeout(() => {
      const query = searchQuery.toLowerCase();
      const results = sampleData.filter(item => 
        item.title.toLowerCase().includes(query) ||
        item.description.toLowerCase().includes(query) ||
        item.author.toLowerCase().includes(query) ||
        item.tags.some(tag => tag.toLowerCase().includes(query))
      );
      
      searchResults = results;
      applyFilters();
      isLoading = false;
      
      if (searchQuery.trim() && !searchHistory.includes(searchQuery)) {
        searchHistory.unshift(searchQuery);
        searchHistory = searchHistory.slice(0, 10);
        saveSearchHistory();
      }
    }, 500);
  }

  function applyFilters() {
    let filtered = [...searchResults];

    if (selectedCategory !== 'all') {
      filtered = filtered.filter(item => item.category === selectedCategory);
    }

    if (selectedDateRange !== 'all') {
      const now = new Date();
      const filterDate = new Date();
      
      switch (selectedDateRange) {
        case 'today':
          filterDate.setDate(now.getDate() - 1);
          break;
        case 'week':
          filterDate.setDate(now.getDate() - 7);
          break;
        case 'month':
          filterDate.setMonth(now.getMonth() - 1);
          break;
        case 'year':
          filterDate.setFullYear(now.getFullYear() - 1);
          break;
      }
      
      filtered = filtered.filter(item => new Date(item.date) >= filterDate);
    }

    filtered = sortResults(filtered);
    filteredResults = filtered;
    currentPage = 1;
  }

  function sortResults(results) {
    return results.sort((a, b) => {
      switch (selectedSort) {
        case 'date':
          return new Date(b.date) - new Date(a.date);
        case 'rating':
          return b.rating - a.rating;
        case 'views':
          return b.views - a.views;
        case 'title':
          return a.title.localeCompare(b.title);
        case 'relevance':
        default:
          return 0;
      }
    });
  }

  function handleSearch() {
    performSearch();
  }

  function handleKeydown(event) {
    if (event.key === 'Enter') {
      handleSearch();
    } else if (event.key === 'ArrowDown') {
      event.preventDefault();
      selectedSuggestion = Math.min(selectedSuggestion + 1, suggestions.length - 1);
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
      selectedSuggestion = Math.max(selectedSuggestion - 1, -1);
    } else if (event.key === 'Escape') {
      showSuggestions = false;
      selectedSuggestion = -1;
    }
  }

  function handleSuggestionClick(suggestion) {
    searchQuery = suggestion;
    showSuggestions = false;
    performSearch();
  }

  function handleHistoryClick(historyItem) {
    searchQuery = historyItem;
    showSuggestions = false;
    performSearch();
  }

  function clearSearch() {
    searchQuery = '';
    searchResults = sampleData;
    applyFilters();
  }

  function clearFilters() {
    selectedCategory = 'all';
    selectedDateRange = 'all';
    selectedSort = 'relevance';
    applyFilters();
  }

  function handlePageChange(page) {
    currentPage = page;
  }

  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString();
  }

  function getRatingStars(rating) {
    const stars = Math.floor(rating);
    const hasHalfStar = rating % 1 >= 0.5;
    return '★'.repeat(stars) + (hasHalfStar ? '☆' : '') + '☆'.repeat(5 - stars - (hasHalfStar ? 1 : 0));
  }

  function getTypeIcon(type) {
    switch (type) {
      case 'video': return '🎥';
      case 'article': return '📄';
      case 'course': return '🎓';
      case 'tutorial': return '📚';
      default: return '📄';
    }
  }

  function getCategoryColor(category) {
    switch (category) {
      case 'tutorial': return '#4caf50';
      case 'guide': return '#2196f3';
      case 'course': return '#ff9800';
      case 'article': return '#9c27b0';
      default: return '#666';
    }
  }
</script>

<div class="search-interface">
  <div class="search-header">
    <h1>Advanced Search</h1>
    <div class="search-stats">
      {filteredResults.length} result{filteredResults.length !== 1 ? 's' : ''} found
    </div>
  </div>

  <div class="search-container">
    <div class="search-input-container">
      <div class="search-input-wrapper">
        <input
          type="text"
          bind:value={searchQuery}
          on:input={() => {
            showSuggestions = searchQuery.length > 0;
            selectedSuggestion = -1;
          }}
          on:keydown={handleKeydown}
          on:focus={() => showSuggestions = searchQuery.length > 0}
          on:blur={() => setTimeout(() => showSuggestions = false, 200)}
          placeholder="Search for tutorials, guides, courses..."
          class="search-input"
        />
        <button 
          on:click={handleSearch}
          disabled={isLoading}
          class="search-btn"
        >
          {isLoading ? '⏳' : '🔍'}
        </button>
        {#if searchQuery}
          <button 
            on:click={clearSearch}
            class="clear-btn"
          >
            ✕
          </button>
        {/if}
      </div>

      {#if showSuggestions}
        <div class="suggestions-dropdown">
          {#if searchHistory.length > 0}
            <div class="suggestions-section">
              <div class="suggestions-header">Recent Searches</div>
              {#each searchHistory.slice(0, 5) as historyItem}
                <div 
                  class="suggestion-item"
                  on:click={() => handleHistoryClick(historyItem)}
                >
                  🕒 {historyItem}
                </div>
              {/each}
            </div>
          {/if}
          
          {#if suggestions.length > 0}
            <div class="suggestions-section">
              <div class="suggestions-header">Suggestions</div>
              {#each suggestions as suggestion, index}
                <div 
                  class="suggestion-item"
                  class:selected={selectedSuggestion === index}
                  on:click={() => handleSuggestionClick(suggestion)}
                >
                  💡 {suggestion}
                </div>
              {/each}
            </div>
          {/if}
        </div>
      {/if}
    </div>

    <div class="search-controls">
      <div class="control-group">
        <button 
          on:click={() => showFilters = !showFilters}
          class="control-btn"
        >
          {showFilters ? 'Hide' : 'Show'} Filters
        </button>
        <button 
          on:click={() => showSortOptions = !showSortOptions}
          class="control-btn"
        >
          Sort: {sortOptions.find(s => s.value === selectedSort)?.label}
        </button>
        <button 
          on:click={clearFilters}
          class="control-btn secondary"
        >
          Clear Filters
        </button>
      </div>

      <div class="view-controls">
        {#each viewOptions as view}
          <button 
            on:click={() => selectedView = view.value}
            class="view-btn"
            class:active={selectedView === view.value}
            title={view.label}
          >
            {view.icon}
          </button>
        {/each}
      </div>
    </div>

    {#if showFilters}
      <div class="filters-panel">
        <div class="filter-row">
          <div class="filter-group">
            <label class="filter-label">Category</label>
            <select bind:value={selectedCategory} class="filter-select">
              {#each categories as category}
                <option value={category.value}>{category.label}</option>
              {/each}
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Date Range</label>
            <select bind:value={selectedDateRange} class="filter-select">
              {#each dateRanges as range}
                <option value={range.value}>{range.label}</option>
              {/each}
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Sort By</label>
            <select bind:value={selectedSort} class="filter-select">
              {#each sortOptions as option}
                <option value={option.value}>{option.label}</option>
              {/each}
            </select>
          </div>
        </div>
      </div>
    {/if}

    {#if showSortOptions}
      <div class="sort-panel">
        <div class="sort-options">
          {#each sortOptions as option}
            <button 
              on:click={() => { selectedSort = option.value; showSortOptions = false; }}
              class="sort-option"
              class:active={selectedSort === option.value}
            >
              {option.label}
            </button>
          {/each}
        </div>
      </div>
    {/if}
  </div>

  <div class="search-results">
    {#if isLoading}
      <div class="loading-state">
        <div class="loading-spinner"></div>
        <span>Searching...</span>
      </div>
    {:else if paginatedResults.length === 0}
      <div class="no-results">
        <div class="no-results-icon">🔍</div>
        <h3>No results found</h3>
        <p>Try adjusting your search terms or filters</p>
      </div>
    {:else}
      <div class="results-container" class:grid-view={selectedView === 'grid'} class:compact-view={selectedView === 'compact'}>
        {#each paginatedResults as result}
          <div class="result-item">
            <div class="result-header">
              <div class="result-type">
                <span class="type-icon">{getTypeIcon(result.type)}</span>
                <span class="type-label">{result.type}</span>
              </div>
              <div 
                class="result-category"
                style="background-color: {getCategoryColor(result.category)}"
              >
                {result.category}
              </div>
            </div>
            
            <div class="result-content">
              <h3 class="result-title">{result.title}</h3>
              <p class="result-description">{result.description}</p>
              
              <div class="result-meta">
                <div class="result-author">
                  <span class="author-label">By:</span>
                  <span class="author-name">{result.author}</span>
                </div>
                <div class="result-date">{formatDate(result.date)}</div>
                <div class="result-rating">
                  <span class="rating-stars">{getRatingStars(result.rating)}</span>
                  <span class="rating-value">{result.rating}</span>
                </div>
                <div class="result-views">
                  <span class="views-count">{result.views} views</span>
                </div>
              </div>
              
              <div class="result-tags">
                {#each result.tags as tag}
                  <span class="result-tag">#{tag}</span>
                {/each}
              </div>
            </div>
            
            <div class="result-actions">
              <button class="action-btn primary">View</button>
              <button class="action-btn secondary">Save</button>
              <button class="action-btn secondary">Share</button>
            </div>
          </div>
        {/each}
      </div>

      {#if totalPages > 1}
        <div class="pagination">
          <button 
            on:click={() => handlePageChange(currentPage - 1)}
            disabled={currentPage === 1}
            class="pagination-btn"
          >
            Previous
          </button>
          
          {#each Array(totalPages) as _, i}
            <button
              on:click={() => handlePageChange(i + 1)}
              class="pagination-btn"
              class:active={currentPage === i + 1}
            >
              {i + 1}
            </button>
          {/each}
          
          <button 
            on:click={() => handlePageChange(currentPage + 1)}
            disabled={currentPage === totalPages}
            class="pagination-btn"
          >
            Next
          </button>
        </div>
      {/if}
    {/if}
  </div>
</div>

<style>
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
    color: #666;
    font-size: 14px;
    font-weight: 500;
  }

  .search-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 30px;
  }

  .search-input-container {
    position: relative;
    margin-bottom: 20px;
  }

  .search-input-wrapper {
    display: flex;
    align-items: center;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
    transition: border-color 0.3s ease;
  }

  .search-input-wrapper:focus-within {
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

  .search-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .search-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .clear-btn {
    padding: 15px 20px;
    background: #f5f5f5;
    color: #666;
    border: none;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
  }

  .clear-btn:hover {
    background: #e0e0e0;
  }

  .suggestions-dropdown {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 100;
    max-height: 300px;
    overflow-y: auto;
  }

  .suggestions-section {
    border-bottom: 1px solid #f0f0f0;
  }

  .suggestions-section:last-child {
    border-bottom: none;
  }

  .suggestions-header {
    padding: 10px 15px;
    background: #f8f9fa;
    font-weight: 600;
    color: #333;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .suggestion-item {
    padding: 12px 15px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    font-size: 14px;
    color: #333;
  }

  .suggestion-item:hover,
  .suggestion-item.selected {
    background: #f0f8ff;
  }

  .search-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .control-group {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .control-btn {
    padding: 8px 16px;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: all 0.3s ease;
  }

  .control-btn:hover {
    background: #e0e0e0;
    border-color: #4caf50;
  }

  .control-btn.secondary {
    background: #ffebee;
    border-color: #f44336;
    color: #f44336;
  }

  .control-btn.secondary:hover {
    background: #f44336;
    color: white;
  }

  .view-controls {
    display: flex;
    gap: 5px;
  }

  .view-btn {
    padding: 8px 12px;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.3s ease;
  }

  .view-btn:hover {
    background: #e0e0e0;
  }

  .view-btn.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .filters-panel {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
  }

  .filter-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
  }

  .filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }

  .filter-label {
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .filter-select {
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    background: white;
    cursor: pointer;
    transition: border-color 0.3s ease;
  }

  .filter-select:focus {
    outline: none;
    border-color: #4caf50;
  }

  .sort-panel {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
  }

  .sort-options {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .sort-option {
    padding: 8px 16px;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: all 0.3s ease;
  }

  .sort-option:hover {
    background: #f0f0f0;
  }

  .sort-option.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .search-results {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .loading-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px;
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

  .no-results {
    text-align: center;
    padding: 60px;
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
    margin: 0;
    font-size: 14px;
  }

  .results-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .results-container.grid-view {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
  }

  .results-container.compact-view {
    gap: 10px;
  }

  .result-item {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    transition: all 0.3s ease;
  }

  .result-item:hover {
    border-color: #4caf50;
    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
  }

  .result-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }

  .result-type {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    color: #666;
  }

  .type-icon {
    font-size: 14px;
  }

  .result-category {
    padding: 4px 8px;
    border-radius: 4px;
    color: white;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .result-content {
    margin-bottom: 15px;
  }

  .result-title {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 18px;
    font-weight: 600;
    line-height: 1.4;
  }

  .result-description {
    margin: 0 0 15px 0;
    color: #666;
    font-size: 14px;
    line-height: 1.5;
  }

  .result-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 10px;
    font-size: 12px;
    color: #666;
  }

  .result-author {
    display: flex;
    align-items: center;
    gap: 4px;
  }

  .author-label {
    font-weight: 600;
  }

  .author-name {
    color: #333;
  }

  .result-date {
    color: #999;
  }

  .result-rating {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .rating-stars {
    color: #ff9800;
    font-size: 14px;
  }

  .rating-value {
    font-weight: 600;
    color: #333;
  }

  .views-count {
    color: #999;
  }

  .result-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
  }

  .result-tag {
    padding: 2px 6px;
    background: #f0f0f0;
    color: #666;
    border-radius: 3px;
    font-size: 11px;
    font-weight: 500;
  }

  .result-actions {
    display: flex;
    gap: 10px;
  }

  .action-btn {
    padding: 6px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .action-btn.primary {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .action-btn.primary:hover {
    background: #45a049;
  }

  .action-btn.secondary {
    background: white;
    color: #666;
  }

  .action-btn.secondary:hover {
    background: #f0f0f0;
    color: #333;
  }

  .pagination {
    display: flex;
    justify-content: center;
    gap: 5px;
    margin-top: 30px;
  }

  .pagination-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
    border-radius: 4px;
    font-size: 14px;
    color: #333;
    transition: all 0.3s ease;
  }

  .pagination-btn:hover:not(:disabled) {
    background: #f5f5f5;
    border-color: #4caf50;
  }

  .pagination-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .pagination-btn.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
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
    
    .search-controls {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: center;
      flex-wrap: wrap;
    }
    
    .view-controls {
      justify-content: center;
    }
    
    .filter-row {
      grid-template-columns: 1fr;
      gap: 15px;
    }
    
    .results-container.grid-view {
      grid-template-columns: 1fr;
    }
    
    .result-meta {
      flex-direction: column;
      gap: 8px;
    }
    
    .result-actions {
      flex-direction: column;
    }
  }

  @media (max-width: 480px) {
    .search-interface {
      padding: 10px;
    }
    
    .search-container {
      padding: 15px;
    }
    
    .search-results {
      padding: 15px;
    }
    
    .result-item {
      padding: 15px;
    }
    
    .result-title {
      font-size: 16px;
    }
    
    .result-description {
      font-size: 13px;
    }
    
    .pagination {
      flex-wrap: wrap;
    }
  }
</style>

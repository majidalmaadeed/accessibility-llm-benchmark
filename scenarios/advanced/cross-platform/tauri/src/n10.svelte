<script>
  export let data
  
  let searchData = null
  let searchQuery = ''
  let selectedCategory = ''
  let selectedBrand = ''
  let minPrice = ''
  let maxPrice = ''
  let selectedRating = ''
  let sortBy = 'relevance'
  let currentView = 'grid'
  let currentPage = 1
  let itemsPerPage = 12
  let filteredProducts = []
  let showSuggestions = false
  
  $: {
    if (data) {
      searchData = JSON.parse(data)
      filteredProducts = searchData.products || []
    }
  }
  
  $: {
    filteredProducts = (searchData?.products || []).filter(product => {
      const matchesSearch = !searchQuery || 
        product.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.brand.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.category.toLowerCase().includes(searchQuery.toLowerCase())
      
      const matchesCategory = !selectedCategory || product.category === selectedCategory
      const matchesBrand = !selectedBrand || product.brand === selectedBrand
      const matchesRating = !selectedRating || Math.floor(product.rating) >= parseInt(selectedRating)
      
      let matchesPrice = true
      if (minPrice) {
        matchesPrice = matchesPrice && product.price >= parseFloat(minPrice)
      }
      if (maxPrice) {
        matchesPrice = matchesPrice && product.price <= parseFloat(maxPrice)
      }
      
      return matchesSearch && matchesCategory && matchesBrand && matchesRating && matchesPrice
    })
    
    if (sortBy === 'price-low') {
      filteredProducts.sort((a, b) => a.price - b.price)
    } else if (sortBy === 'price-high') {
      filteredProducts.sort((a, b) => b.price - a.price)
    } else if (sortBy === 'rating') {
      filteredProducts.sort((a, b) => b.rating - a.rating)
    }
  }
  
  $: totalPages = Math.ceil(filteredProducts.length / itemsPerPage)
  $: startIndex = (currentPage - 1) * itemsPerPage
  $: endIndex = Math.min(startIndex + itemsPerPage, filteredProducts.length)
  $: pageProducts = filteredProducts.slice(startIndex, endIndex)
  
  function handleSearch() {
    if (searchQuery.length > 2) {
      showSuggestions = true
    } else {
      showSuggestions = false
    }
  }
  
  function performSearch() {
    showSuggestions = false
    currentPage = 1
  }
  
  function clearFilters() {
    searchQuery = ''
    selectedCategory = ''
    selectedBrand = ''
    minPrice = ''
    maxPrice = ''
    selectedRating = ''
    sortBy = 'relevance'
    currentPage = 1
  }
  
  function setView(view) {
    currentView = view
  }
  
  function changePage(page) {
    currentPage = page
  }
  
  function viewProduct(id) {
    alert(`Viewing product ${id}`)
  }
  
  function addToCart(id) {
    alert(`Added product ${id} to cart`)
  }
  
  function buyNow(id) {
    alert(`Buying product ${id} now`)
  }
  
  function getStars(rating) {
    const fullStars = Math.floor(rating)
    const hasHalfStar = rating % 1 !== 0
    let stars = '★'.repeat(fullStars)
    if (hasHalfStar) stars += '☆'
    stars += '☆'.repeat(5 - fullStars - (hasHalfStar ? 1 : 0))
    return stars
  }
</script>

<div class="search-container">
  <div class="search-header">
    <h1>Product Search</h1>
    <p>Find the perfect products for your needs</p>
    
    <div class="search-bar-container">
      <input type="text" 
             bind:value={searchQuery}
             on:input={handleSearch}
             on:keyup={(e) => e.key === 'Enter' && performSearch()}
             placeholder="Search for products, brands, or categories...">
      <button class="search-btn" on:click={performSearch}>🔍</button>
      {#if showSuggestions}
        <div class="suggestions">
          <div class="suggestion-item" on:click={() => { searchQuery = 'iPhone'; performSearch(); }}>iPhone 15 Pro</div>
          <div class="suggestion-item" on:click={() => { searchQuery = 'Samsung'; performSearch(); }}>Samsung Galaxy</div>
          <div class="suggestion-item" on:click={() => { searchQuery = 'MacBook'; performSearch(); }}>MacBook Pro</div>
        </div>
      {/if}
    </div>
    
    <div class="search-suggestions">
      <div class="search-suggestion" on:click={() => { searchQuery = 'laptop'; performSearch(); }}>Laptops</div>
      <div class="search-suggestion" on:click={() => { searchQuery = 'smartphone'; performSearch(); }}>Smartphones</div>
      <div class="search-suggestion" on:click={() => { searchQuery = 'headphones'; performSearch(); }}>Headphones</div>
      <div class="search-suggestion" on:click={() => { searchQuery = 'camera'; performSearch(); }}>Cameras</div>
      <div class="search-suggestion" on:click={() => { searchQuery = 'tablet'; performSearch(); }}>Tablets</div>
    </div>
  </div>
  
  <div class="search-content">
    <div class="filters-sidebar">
      <h3>Filters</h3>
      
      <div class="filter-group">
        <label>Category</label>
        <select bind:value={selectedCategory}>
          <option value="">All Categories</option>
          {#each searchData?.filters?.categories || [] as category}
            <option value={category}>{category}</option>
          {/each}
        </select>
      </div>
      
      <div class="filter-group">
        <label>Brand</label>
        <select bind:value={selectedBrand}>
          <option value="">All Brands</option>
          {#each searchData?.filters?.brands || [] as brand}
            <option value={brand}>{brand}</option>
          {/each}
        </select>
      </div>
      
      <div class="filter-group">
        <label>Price Range</label>
        <div class="price-range">
          <input type="number" bind:value={minPrice} placeholder="Min">
          <span>-</span>
          <input type="number" bind:value={maxPrice} placeholder="Max">
        </div>
      </div>
      
      <div class="filter-group">
        <label>Rating</label>
        <select bind:value={selectedRating}>
          <option value="">All Ratings</option>
          <option value="5">5 Stars</option>
          <option value="4">4+ Stars</option>
          <option value="3">3+ Stars</option>
        </select>
      </div>
      
      <button class="clear-filters" on:click={clearFilters}>Clear All Filters</button>
    </div>
    
    <div class="search-results">
      <div class="results-header">
        <div class="results-count">Showing {startIndex + 1}-{endIndex} of {filteredProducts.length} results</div>
        <div class="sort-controls">
          <span>Sort by:</span>
          <select bind:value={sortBy}>
            <option value="relevance">Relevance</option>
            <option value="price-low">Price: Low to High</option>
            <option value="price-high">Price: High to Low</option>
            <option value="rating">Rating</option>
            <option value="newest">Newest</option>
            <option value="popularity">Popularity</option>
          </select>
          <div class="view-toggle">
            <button class="view-btn" class:active={currentView === 'grid'} on:click={() => setView('grid')}>⊞</button>
            <button class="view-btn" class:active={currentView === 'list'} on:click={() => setView('list')}>☰</button>
          </div>
        </div>
      </div>
      
      {#if currentView === 'grid'}
        <div class="results-grid">
          {#each pageProducts as product}
            <div class="product-card" on:click={() => viewProduct(product.id)}>
              <div class="product-image">{product.image}</div>
              <div class="product-info">
                <div class="product-brand">{product.brand}</div>
                <div class="product-title">{product.title}</div>
                <div class="product-price">${product.price}</div>
                <div class="product-rating">
                  <span class="stars">{getStars(product.rating)}</span>
                  <span class="rating-text">({product.rating})</span>
                </div>
                <div class="product-actions">
                  <button class="action-btn" on:click|stopPropagation={() => addToCart(product.id)}>Add to Cart</button>
                  <button class="action-btn primary" on:click|stopPropagation={() => buyNow(product.id)}>Buy Now</button>
                </div>
              </div>
            </div>
          {/each}
        </div>
      {:else}
        <div class="results-list">
          {#each pageProducts as product}
            <div class="product-item" on:click={() => viewProduct(product.id)}>
              <div class="product-image">{product.image}</div>
              <div class="product-info">
                <div class="product-brand">{product.brand}</div>
                <div class="product-title">{product.title}</div>
                <div class="product-price">${product.price}</div>
                <div class="product-rating">
                  <span class="stars">{getStars(product.rating)}</span>
                  <span class="rating-text">({product.rating})</span>
                </div>
              </div>
              <div class="product-actions">
                <button class="action-btn" on:click|stopPropagation={() => addToCart(product.id)}>Add to Cart</button>
                <button class="action-btn primary" on:click|stopPropagation={() => buyNow(product.id)}>Buy Now</button>
              </div>
            </div>
          {/each}
        </div>
      {/if}
      
      {#if totalPages > 1}
        <div class="pagination">
          <button class="pagination-btn" 
                  disabled={currentPage === 1}
                  on:click={() => changePage(currentPage - 1)}>Previous</button>
          
          {#each Array(totalPages) as _, i}
            <button class="pagination-btn" 
                    class:active={currentPage === i + 1}
                    on:click={() => changePage(i + 1)}>
              {i + 1}
            </button>
          {/each}
          
          <button class="pagination-btn" 
                  disabled={currentPage === totalPages}
                  on:click={() => changePage(currentPage + 1)}>Next</button>
        </div>
      {/if}
    </div>
  </div>
</div>

<style>
  .search-container {
    max-width: 1400px;
    margin: 0 auto;
  }
  
  .search-header {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .search-header h1 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 24px;
  }
  
  .search-header p {
    margin: 0 0 20px 0;
    color: #666;
  }
  
  .search-bar-container {
    position: relative;
    margin-bottom: 20px;
  }
  
  .search-bar-container input {
    width: 100%;
    padding: 15px 50px 15px 20px;
    border: 2px solid #e9ecef;
    border-radius: 25px;
    font-size: 16px;
    outline: none;
  }
  
  .search-bar-container input:focus {
    border-color: #007bff;
  }
  
  .search-btn {
    position: absolute;
    right: 5px;
    top: 50%;
    transform: translateY(-50%);
    width: 40px;
    height: 40px;
    border: none;
    background: #007bff;
    color: white;
    border-radius: 50%;
    cursor: pointer;
    font-size: 16px;
  }
  
  .search-btn:hover {
    background: #0056b3;
  }
  
  .suggestions {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    border: 1px solid #ddd;
    border-radius: 0 0 25px 25px;
    max-height: 200px;
    overflow-y: auto;
    z-index: 1000;
  }
  
  .suggestion-item {
    padding: 10px 20px;
    cursor: pointer;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .suggestion-item:hover {
    background: #f8f9fa;
  }
  
  .suggestion-item:last-child {
    border-bottom: none;
  }
  
  .search-suggestions {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .search-suggestion {
    padding: 6px 12px;
    background: #f8f9fa;
    border: 1px solid #e9ecef;
    border-radius: 15px;
    cursor: pointer;
    font-size: 12px;
    color: #666;
  }
  
  .search-suggestion:hover {
    background: #e9ecef;
  }
  
  .search-content {
    display: grid;
    grid-template-columns: 300px 1fr;
    gap: 20px;
  }
  
  .filters-sidebar {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    height: fit-content;
  }
  
  .filters-sidebar h3 {
    margin: 0 0 20px 0;
    color: #333;
    font-size: 18px;
  }
  
  .filter-group {
    margin-bottom: 20px;
  }
  
  .filter-group label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: 600;
    color: #333;
  }
  
  .filter-group select,
  .filter-group input {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .price-range {
    display: flex;
    gap: 10px;
    align-items: center;
  }
  
  .price-range input {
    flex: 1;
  }
  
  .clear-filters {
    width: 100%;
    padding: 10px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    margin-top: 20px;
  }
  
  .clear-filters:hover {
    background: #e9ecef;
  }
  
  .search-results {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .results-header {
    padding: 20px;
    border-bottom: 1px solid #f0f0f0;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .results-count {
    font-size: 16px;
    color: #666;
  }
  
  .sort-controls {
    display: flex;
    gap: 10px;
    align-items: center;
  }
  
  .sort-controls select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .view-toggle {
    display: flex;
    gap: 5px;
  }
  
  .view-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
  }
  
  .view-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .view-btn:hover {
    background: #f8f9fa;
  }
  
  .results-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    padding: 20px;
  }
  
  .results-list {
    padding: 20px;
  }
  
  .product-card {
    border: 1px solid #f0f0f0;
    border-radius: 8px;
    overflow: hidden;
    transition: all 0.3s ease;
    cursor: pointer;
  }
  
  .product-card:hover {
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transform: translateY(-2px);
  }
  
  .product-image {
    width: 100%;
    height: 200px;
    background: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 48px;
    color: #ccc;
  }
  
  .product-info {
    padding: 15px;
  }
  
  .product-brand {
    font-size: 12px;
    color: #666;
    margin-bottom: 8px;
  }
  
  .product-title {
    font-size: 16px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
    line-height: 1.4;
  }
  
  .product-price {
    font-size: 18px;
    font-weight: 600;
    color: #007bff;
    margin-bottom: 8px;
  }
  
  .product-rating {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-bottom: 10px;
  }
  
  .stars {
    color: #ffc107;
  }
  
  .rating-text {
    font-size: 12px;
    color: #666;
  }
  
  .product-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .action-btn.primary {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .action-btn.primary:hover {
    background: #0056b3;
  }
  
  .product-item {
    display: flex;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
  }
  
  .product-item:hover {
    background: #f8f9fa;
  }
  
  .product-item .product-image {
    width: 100px;
    height: 100px;
    margin-right: 15px;
  }
  
  .product-item .product-info {
    flex: 1;
    padding: 0;
  }
  
  .product-item .product-actions {
    flex-direction: column;
    gap: 5px;
  }
  
  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    border-top: 1px solid #f0f0f0;
  }
  
  .pagination-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 5px;
  }
  
  .pagination-btn:hover {
    background: #f8f9fa;
  }
  
  .pagination-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .pagination-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
</style>

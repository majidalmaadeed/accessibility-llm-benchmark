<script>
  let selectedCategory = 'all';
  let sortBy = 'popularity';
  let viewMode = 'grid';
  let showFilters = false;
  let isLoading = false;
  let loadingMessage = '';
  
  const products = [
    {
      id: 1,
      name: "Wireless Headphones",
      price: 199.99,
      originalPrice: 249.99,
      category: "audio",
      image: "/api/placeholder/300/300",
      description: "High-quality wireless headphones with noise cancellation",
      rating: 4.5,
      reviews: 128,
      inStock: true,
      isNew: true,
      discount: 20,
      popularity: 95
    },
    {
      id: 2,
      name: "Smart Watch",
      price: 299.99,
      originalPrice: 399.99,
      category: "wearables",
      image: "/api/placeholder/300/300",
      description: "Advanced fitness tracking smartwatch",
      rating: 4.8,
      reviews: 89,
      inStock: true,
      isNew: false,
      discount: 25,
      popularity: 88
    },
    {
      id: 3,
      name: "Bluetooth Speaker",
      price: 149.99,
      originalPrice: 199.99,
      category: "audio",
      image: "/api/placeholder/300/300",
      description: "Portable Bluetooth speaker with 360-degree sound",
      rating: 4.3,
      reviews: 156,
      inStock: true,
      isNew: false,
      discount: 25,
      popularity: 82
    },
    {
      id: 4,
      name: "Gaming Mouse",
      price: 79.99,
      originalPrice: 99.99,
      category: "gaming",
      image: "/api/placeholder/300/300",
      description: "Precision gaming mouse with customizable RGB lighting",
      rating: 4.6,
      reviews: 203,
      inStock: false,
      isNew: true,
      discount: 20,
      popularity: 91
    },
    {
      id: 5,
      name: "Mechanical Keyboard",
      price: 129.99,
      originalPrice: 159.99,
      category: "gaming",
      image: "/api/placeholder/300/300",
      description: "Mechanical keyboard with Cherry MX switches",
      rating: 4.7,
      reviews: 92,
      inStock: true,
      isNew: false,
      discount: 19,
      popularity: 85
    },
    {
      id: 6,
      name: "USB-C Hub",
      price: 59.99,
      originalPrice: 79.99,
      category: "accessories",
      image: "/api/placeholder/300/300",
      description: "Multi-port USB-C hub with HDMI and USB 3.0",
      rating: 4.2,
      reviews: 67,
      inStock: true,
      isNew: true,
      discount: 25,
      popularity: 78
    }
  ];
  
  function filterProducts() {
    return products.filter(product => {
      if (selectedCategory === 'all') return true;
      return product.category === selectedCategory;
    });
  }
  
  function sortProducts(products) {
    return [...products].sort((a, b) => {
      switch(sortBy) {
        case 'name':
          return a.name.localeCompare(b.name);
        case 'price':
          return a.price - b.price;
        case 'rating':
          return b.rating - a.rating;
        case 'popularity':
        default:
          return b.popularity - a.popularity;
      }
    });
  }
  
  function simulateLoading(message) {
    isLoading = true;
    loadingMessage = message;
    
    setTimeout(() => {
      isLoading = false;
      loadingMessage = '';
    }, 2000);
  }
  
  function handleCategoryChange() {
    simulateLoading('Loading products...');
  }
  
  function handleSortChange() {
    simulateLoading('Sorting products...');
  }
  
  function handleViewChange() {
    simulateLoading('Changing view...');
  }
  
  function handleSearch() {
    simulateLoading('Searching products...');
  }
  
  function handleFilter() {
    simulateLoading('Applying filters...');
  }
  
  $: filteredProducts = sortProducts(filterProducts());
</script>

<div class="ecommerce-platform">
  <header class="platform-header">
    <div class="header-content">
      <h1 class="platform-title">TechStore</h1>
      <p class="platform-subtitle">Your one-stop shop for the latest technology</p>
    </div>
    
    <div class="header-actions">
      <button class="header-btn search-btn" on:click={handleSearch}>🔍</button>
      <button class="header-btn wishlist-btn">♡ 0</button>
      <button class="header-btn cart-btn">🛒 0</button>
      <button class="header-btn account-btn">👤</button>
    </div>
  </header>

  <nav class="main-navigation">
    <a href="#" class="nav-link">Home</a>
    <a href="#" class="nav-link">Audio</a>
    <a href="#" class="nav-link">Wearables</a>
    <a href="#" class="nav-link">Gaming</a>
    <a href="#" class="nav-link">Accessories</a>
    <a href="#" class="nav-link">Deals</a>
    <a href="#" class="nav-link">Support</a>
  </nav>

  <div class="platform-controls">
    <div class="control-group">
      <label class="control-label">Category:</label>
      <select bind:value={selectedCategory} on:change={handleCategoryChange} class="control-select">
        <option value="all">All Products</option>
        <option value="audio">Audio</option>
        <option value="wearables">Wearables</option>
        <option value="gaming">Gaming</option>
        <option value="accessories">Accessories</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort by:</label>
      <select bind:value={sortBy} on:change={handleSortChange} class="control-select">
        <option value="popularity">Popularity</option>
        <option value="name">Name</option>
        <option value="price">Price</option>
        <option value="rating">Rating</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">View:</label>
      <div class="view-toggle">
        <button 
          class="view-btn" 
          class:active={viewMode === 'grid'}
          on:click={() => { viewMode = 'grid'; handleViewChange(); }}
        >
          Grid
        </button>
        <button 
          class="view-btn" 
          class:active={viewMode === 'list'}
          on:click={() => { viewMode = 'list'; handleViewChange(); }}
        >
          List
        </button>
      </div>
    </div>
    
    <div class="control-group">
      <button class="filter-btn" on:click={handleFilter}>Apply Filters</button>
    </div>
  </div>

  {#if isLoading}
    <div class="loading-overlay">
      <div class="loading-spinner"></div>
      <div class="loading-text">{loadingMessage}</div>
    </div>
  {/if}

  <div class="products-section">
    <div class="section-header">
      <h2 class="section-title">Featured Products</h2>
      <div class="section-info">
        <span class="products-count">{filteredProducts.length} products</span>
        <span class="last-updated">Updated daily</span>
      </div>
    </div>
    
    {#if viewMode === 'grid'}
      <div class="products-grid">
        {#each filteredProducts as product (product.id)}
          <div class="product-card">
            <div class="card-header">
              {#if product.isNew}
                <div class="product-badge new-badge">NEW</div>
              {/if}
              {#if product.discount > 0}
                <div class="product-badge discount-badge">-{product.discount}%</div>
              {/if}
              <div class="product-actions">
                <button class="action-btn wishlist-btn">♡</button>
                <button class="action-btn compare-btn">⚖</button>
                <button class="action-btn quick-view-btn">👁</button>
              </div>
            </div>
            
            <div class="product-image-container">
              <img 
                src={product.image} 
                alt={product.name}
                class="product-image"
              />
              {#if !product.inStock}
                <div class="out-of-stock-overlay">
                  <span class="out-of-stock-text">Out of Stock</span>
                </div>
              {/if}
            </div>
            
            <div class="product-info">
              <h3 class="product-name">{product.name}</h3>
              <p class="product-description">{product.description}</p>
              
              <div class="product-rating">
                <div class="stars">
                  {#each Array(5) as _, i}
                    <span class="star" class:filled={i < Math.floor(product.rating)}>★</span>
                  {/each}
                </div>
                <span class="rating-value">{product.rating}</span>
                <span class="reviews-count">({product.reviews})</span>
              </div>
              
              <div class="product-pricing">
                <div class="price-row">
                  <span class="current-price">${product.price}</span>
                  {#if product.originalPrice > product.price}
                    <span class="original-price">${product.originalPrice}</span>
                  {/if}
                </div>
                {#if product.discount > 0}
                  <div class="savings">You save ${(product.originalPrice - product.price).toFixed(2)}</div>
                {/if}
              </div>
              
              <div class="product-availability">
                {#if product.inStock}
                  <span class="in-stock">✓ In Stock</span>
                {:else}
                  <span class="out-of-stock">✗ Out of Stock</span>
                {/if}
              </div>
              
              <div class="product-actions-bottom">
                <button 
                  class="add-to-cart-btn" 
                  disabled={!product.inStock}
                >
                  {product.inStock ? 'Add to Cart' : 'Notify When Available'}
                </button>
                <button class="buy-now-btn" disabled={!product.inStock}>
                  Buy Now
                </button>
                <button class="wishlist-btn">
                  Wishlist
                </button>
              </div>
            </div>
          </div>
        {/each}
      </div>
    {:else}
      <div class="products-list">
        {#each filteredProducts as product (product.id)}
          <div class="product-list-item">
            <div class="list-image-container">
              <img 
                src={product.image} 
                alt={product.name}
                class="list-image"
              />
              {#if product.isNew}
                <div class="list-badge new-badge">NEW</div>
              {/if}
              {#if product.discount > 0}
                <div class="list-badge discount-badge">-{product.discount}%</div>
              {/if}
            </div>
            
            <div class="list-product-info">
              <div class="list-header">
                <h3 class="list-product-name">{product.name}</h3>
                <div class="list-actions">
                  <button class="list-action-btn wishlist">♡</button>
                  <button class="list-action-btn compare">⚖</button>
                  <button class="list-action-btn quick-view">👁</button>
                </div>
              </div>
              
              <p class="list-product-description">{product.description}</p>
              
              <div class="list-details">
                <div class="list-rating">
                  <div class="stars">
                    {#each Array(5) as _, i}
                      <span class="star" class:filled={i < Math.floor(product.rating)}>★</span>
                    {/each}
                  </div>
                  <span class="rating-value">{product.rating}</span>
                  <span class="reviews-count">({product.reviews} reviews)</span>
                </div>
                
                <div class="list-pricing">
                  <div class="price-row">
                    <span class="current-price">${product.price}</span>
                    {#if product.originalPrice > product.price}
                      <span class="original-price">${product.originalPrice}</span>
                    {/if}
                  </div>
                  {#if product.discount > 0}
                    <div class="savings">Save ${(product.originalPrice - product.price).toFixed(2)}</div>
                  {/if}
                </div>
                
                <div class="list-availability">
                  {#if product.inStock}
                    <span class="in-stock">✓ In Stock</span>
                  {:else}
                    <span class="out-of-stock">✗ Out of Stock</span>
                  {/if}
                </div>
              </div>
            </div>
            
            <div class="list-actions-bottom">
              <button 
                class="list-add-to-cart" 
                disabled={!product.inStock}
              >
                {product.inStock ? 'Add to Cart' : 'Notify When Available'}
              </button>
              <button 
                class="list-buy-now" 
                disabled={!product.inStock}
              >
                Buy Now
              </button>
              <button class="list-wishlist">
                Wishlist
              </button>
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="newsletter-section">
    <div class="newsletter-content">
      <h3 class="newsletter-title">Stay Updated</h3>
      <p class="newsletter-description">Get the latest deals and product updates</p>
      <form class="newsletter-form">
        <input type="email" placeholder="Enter your email address" class="newsletter-input" />
        <button type="submit" class="newsletter-btn">Subscribe</button>
      </form>
      <p class="newsletter-note">Join 50,000+ subscribers for the best deals</p>
    </div>
  </div>
</div>

<style>
  .ecommerce-platform {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
    position: relative;
  }
  
  .platform-header {
    background: white;
    padding: 20px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    text-align: center;
    margin-bottom: 20px;
  }
  
  .platform-title {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }
  
  .platform-subtitle {
    margin: 0;
    font-size: 16px;
    color: #666;
  }
  
  .header-actions {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .main-navigation {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    gap: 30px;
  }
  
  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    padding: 10px 15px;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .nav-link:hover {
    background: #f8f9fa;
    color: #007bff;
  }
  
  .platform-controls {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    gap: 30px;
    align-items: center;
  }
  
  .control-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .control-label {
    font-weight: bold;
    color: #333;
    white-space: nowrap;
  }
  
  .control-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
    min-width: 150px;
  }
  
  .view-toggle {
    display: flex;
    gap: 5px;
  }
  
  .view-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
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
  
  .filter-btn {
    padding: 8px 16px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .filter-btn:hover {
    background: #0056b3;
  }
  
  .loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }
  
  .loading-spinner {
    width: 50px;
    height: 50px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #007bff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 20px;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  .loading-text {
    color: white;
    font-size: 18px;
    font-weight: bold;
  }
  
  .products-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
  }
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
  }
  
  .section-title {
    margin: 0;
    font-size: 24px;
    color: #333;
  }
  
  .section-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
  }
  
  .products-count {
    font-weight: bold;
    color: #333;
  }
  
  .last-updated {
    font-size: 14px;
    color: #666;
  }
  
  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .product-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .product-card:hover {
    transform: translateY(-4px);
  }
  
  .card-header {
    position: relative;
    height: 250px;
    overflow: hidden;
  }
  
  .product-image-container {
    position: relative;
    width: 100%;
    height: 100%;
  }
  
  .product-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .product-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    color: white;
  }
  
  .new-badge {
    background: #28a745;
  }
  
  .discount-badge {
    background: #dc3545;
  }
  
  .product-actions {
    position: absolute;
    top: 15px;
    right: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    opacity: 0;
    transition: opacity 0.2s ease;
  }
  
  .product-card:hover .product-actions {
    opacity: 1;
  }
  
  .action-btn {
    width: 35px;
    height: 35px;
    border: none;
    border-radius: 50%;
    background: rgba(255,255,255,0.9);
    color: #333;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
  }
  
  .action-btn:hover {
    background: #007bff;
    color: white;
  }
  
  .out-of-stock-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .out-of-stock-text {
    color: white;
    font-weight: bold;
    font-size: 18px;
  }
  
  .product-info {
    padding: 25px;
  }
  
  .product-name {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
    font-weight: bold;
  }
  
  .product-description {
    margin: 0 0 15px 0;
    color: #666;
    line-height: 1.5;
  }
  
  .product-rating {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
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
  
  .rating-value {
    font-weight: bold;
    color: #333;
  }
  
  .reviews-count {
    color: #666;
    font-size: 14px;
  }
  
  .product-pricing {
    margin-bottom: 15px;
  }
  
  .price-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 5px;
  }
  
  .current-price {
    font-size: 24px;
    font-weight: bold;
    color: #007bff;
  }
  
  .original-price {
    font-size: 16px;
    color: #999;
    text-decoration: line-through;
  }
  
  .savings {
    color: #28a745;
    font-size: 14px;
    font-weight: bold;
  }
  
  .product-availability {
    margin-bottom: 20px;
  }
  
  .in-stock {
    color: #28a745;
    font-weight: bold;
  }
  
  .out-of-stock {
    color: #dc3545;
    font-weight: bold;
  }
  
  .product-actions-bottom {
    display: flex;
    gap: 10px;
  }
  
  .add-to-cart-btn,
  .buy-now-btn,
  .wishlist-btn {
    flex: 1;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 14px;
  }
  
  .add-to-cart-btn {
    background: #f8f9fa;
    color: #333;
    border: 1px solid #ddd;
  }
  
  .add-to-cart-btn:hover:not(:disabled) {
    background: #e9ecef;
  }
  
  .add-to-cart-btn:disabled {
    background: #f8f9fa;
    color: #999;
    cursor: not-allowed;
  }
  
  .buy-now-btn {
    background: #007bff;
    color: white;
  }
  
  .buy-now-btn:hover:not(:disabled) {
    background: #0056b3;
  }
  
  .buy-now-btn:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }
  
  .wishlist-btn {
    background: #6c757d;
    color: white;
  }
  
  .wishlist-btn:hover {
    background: #545b62;
  }
  
  .products-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .product-list-item {
    display: flex;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .product-list-item:hover {
    transform: translateY(-2px);
  }
  
  .list-image-container {
    position: relative;
    width: 200px;
    height: 150px;
    overflow: hidden;
  }
  
  .list-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .list-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 10px;
    font-weight: bold;
    color: white;
  }
  
  .list-product-info {
    flex: 1;
    padding: 20px;
  }
  
  .list-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;
  }
  
  .list-product-name {
    margin: 0;
    font-size: 20px;
    color: #333;
    font-weight: bold;
  }
  
  .list-actions {
    display: flex;
    gap: 8px;
  }
  
  .list-action-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s ease;
  }
  
  .list-action-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .list-product-description {
    margin: 0 0 15px 0;
    color: #666;
    line-height: 1.5;
  }
  
  .list-details {
    display: flex;
    gap: 30px;
    margin-bottom: 20px;
  }
  
  .list-rating {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .list-pricing {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  .list-availability {
    display: flex;
    align-items: center;
  }
  
  .list-actions-bottom {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 20px;
    justify-content: center;
  }
  
  .list-add-to-cart,
  .list-buy-now,
  .list-wishlist {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 14px;
  }
  
  .list-add-to-cart {
    background: #f8f9fa;
    color: #333;
    border: 1px solid #ddd;
  }
  
  .list-add-to-cart:hover:not(:disabled) {
    background: #e9ecef;
  }
  
  .list-add-to-cart:disabled {
    background: #f8f9fa;
    color: #999;
    cursor: not-allowed;
  }
  
  .list-buy-now {
    background: #007bff;
    color: white;
  }
  
  .list-buy-now:hover:not(:disabled) {
    background: #0056b3;
  }
  
  .list-buy-now:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }
  
  .list-wishlist {
    background: #6c757d;
    color: white;
  }
  
  .list-wishlist:hover {
    background: #545b62;
  }
  
  .newsletter-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 50px 20px;
    text-align: center;
    margin: 50px 0;
  }
  
  .newsletter-content {
    max-width: 600px;
    margin: 0 auto;
  }
  
  .newsletter-title {
    margin: 0 0 15px 0;
    font-size: 28px;
    font-weight: bold;
  }
  
  .newsletter-description {
    margin: 0 0 30px 0;
    font-size: 16px;
    opacity: 0.9;
  }
  
  .newsletter-form {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
  }
  
  .newsletter-input {
    flex: 1;
    padding: 15px 20px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
  }
  
  .newsletter-input:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(255,255,255,0.3);
  }
  
  .newsletter-btn {
    padding: 15px 30px;
    background: #ff6b6b;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .newsletter-btn:hover {
    background: #ff5252;
    transform: translateY(-2px);
  }
  
  .newsletter-note {
    margin: 0;
    font-size: 14px;
    opacity: 0.8;
  }
  
  @media (max-width: 768px) {
    .platform-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: space-between;
    }
    
    .main-navigation {
      flex-wrap: wrap;
      gap: 15px;
    }
    
    .products-grid {
      grid-template-columns: 1fr;
    }
    
    .product-list-item {
      flex-direction: column;
    }
    
    .list-image-container {
      width: 100%;
      height: 200px;
    }
    
    .list-details {
      flex-direction: column;
      gap: 15px;
    }
    
    .list-actions-bottom {
      flex-direction: row;
    }
    
    .newsletter-form {
      flex-direction: column;
    }
    
    .newsletter-btn {
      width: 100%;
    }
  }
</style>

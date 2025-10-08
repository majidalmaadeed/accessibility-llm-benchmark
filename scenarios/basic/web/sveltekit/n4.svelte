<script>
  let selectedCategory = 'all';
  let sortBy = 'price';
  let viewMode = 'grid';
  let showFilters = false;
  
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
      discount: 20
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
      discount: 25
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
      discount: 25
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
      discount: 20
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
      discount: 19
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
      discount: 25
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
        case 'rating':
          return b.rating - a.rating;
        case 'price':
        default:
          return a.price - b.price;
      }
    });
  }
  
  $: filteredProducts = sortProducts(filterProducts());
</script>

<div class="product-catalog">
  <header class="catalog-header">
    <div class="header-content">
      <h1 class="catalog-title">Tech Store</h1>
      <p class="catalog-subtitle">Discover amazing deals on the latest technology</p>
    </div>
    
    <div class="sale-banner">
      <div class="banner-content">
        <div class="banner-text">
          <span class="banner-title">MEGA SALE!</span>
          <span class="banner-subtitle">Up to 50% OFF Everything</span>
        </div>
        <div class="banner-timer">
          <span class="timer-text">Ends in:</span>
          <span class="timer-value">23:59:45</span>
        </div>
      </div>
    </div>
  </header>

  <div class="catalog-controls">
    <div class="controls-left">
      <button 
        class="filter-toggle-btn" 
        on:click={() => showFilters = !showFilters}
      >
        {showFilters ? 'Hide' : 'Show'} Filters
      </button>
      
      <div class="view-toggle">
        <button 
          class="view-btn" 
          class:active={viewMode === 'grid'}
          on:click={() => viewMode = 'grid'}
        >
          Grid
        </button>
        <button 
          class="view-btn" 
          class:active={viewMode === 'list'}
          on:click={() => viewMode = 'list'}
        >
          List
        </button>
      </div>
    </div>
    
    <div class="controls-right">
      <div class="sort-control">
        <label class="sort-label">Sort by:</label>
        <select bind:value={sortBy} class="sort-select">
          <option value="price">Price</option>
          <option value="name">Name</option>
          <option value="rating">Rating</option>
        </select>
      </div>
    </div>
  </div>

  {#if showFilters}
    <div class="filters-panel">
      <div class="filter-section">
        <h3 class="filter-title">Category</h3>
        <div class="filter-options">
          <label class="filter-option">
            <input type="radio" bind:group={selectedCategory} value="all" />
            <span class="option-text">All Products</span>
            <span class="option-count">({products.length})</span>
          </label>
          <label class="filter-option">
            <input type="radio" bind:group={selectedCategory} value="audio" />
            <span class="option-text">Audio</span>
            <span class="option-count">({products.filter(p => p.category === 'audio').length})</span>
          </label>
          <label class="filter-option">
            <input type="radio" bind:group={selectedCategory} value="wearables" />
            <span class="option-text">Wearables</span>
            <span class="option-count">({products.filter(p => p.category === 'wearables').length})</span>
          </label>
          <label class="filter-option">
            <input type="radio" bind:group={selectedCategory} value="gaming" />
            <span class="option-text">Gaming</span>
            <span class="option-count">({products.filter(p => p.category === 'gaming').length})</span>
          </label>
          <label class="filter-option">
            <input type="radio" bind:group={selectedCategory} value="accessories" />
            <span class="option-text">Accessories</span>
            <span class="option-count">({products.filter(p => p.category === 'accessories').length})</span>
          </label>
        </div>
      </div>
      
      <div class="filter-section">
        <h3 class="filter-title">Price Range</h3>
        <div class="price-range">
          <input type="range" min="0" max="500" value="500" class="price-slider" />
          <div class="price-labels">
            <span class="price-min">$0</span>
            <span class="price-max">$500+</span>
          </div>
        </div>
      </div>
      
      <div class="filter-section">
        <h3 class="filter-title">Availability</h3>
        <div class="filter-options">
          <label class="filter-option">
            <input type="checkbox" />
            <span class="option-text">In Stock Only</span>
          </label>
          <label class="filter-option">
            <input type="checkbox" />
            <span class="option-text">New Arrivals</span>
          </label>
          <label class="filter-option">
            <input type="checkbox" />
            <span class="option-text">On Sale</span>
          </label>
        </div>
      </div>
    </div>
  {/if}

  <div class="products-section">
    <div class="section-header">
      <h2 class="section-title">Featured Products</h2>
      <div class="results-info">
        <span class="results-count">{filteredProducts.length} products</span>
        <span class="results-sort">Sorted by {sortBy}</span>
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
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="newsletter-section">
    <div class="newsletter-content">
      <h3 class="newsletter-title">Stay Updated with Our Deals!</h3>
      <p class="newsletter-description">Get exclusive access to flash sales and limited-time offers</p>
      <form class="newsletter-form">
        <input type="email" placeholder="Enter your email address" class="newsletter-input" />
        <button type="submit" class="newsletter-btn">Subscribe Now</button>
      </form>
      <p class="newsletter-note">Join 50,000+ subscribers for the best deals</p>
    </div>
  </div>
</div>

<style>
  .product-catalog {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .catalog-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px 0;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    position: relative;
    z-index: 2;
  }
  
  .catalog-title {
    margin: 0 0 10px 0;
    font-size: 36px;
    font-weight: bold;
  }
  
  .catalog-subtitle {
    margin: 0;
    font-size: 18px;
    opacity: 0.9;
  }
  
  .sale-banner {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, #ff6b6b, #ffa500, #ff6b6b, #ffa500);
    background-size: 400% 400%;
    animation: flash 0.2s infinite;
    z-index: 1;
  }
  
  @keyframes flash {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }
  
  .banner-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    z-index: 3;
  }
  
  .banner-text {
    display: flex;
    flex-direction: column;
    gap: 5px;
    margin-bottom: 20px;
  }
  
  .banner-title {
    font-size: 48px;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    animation: pulse 1s infinite;
  }
  
  .banner-subtitle {
    font-size: 24px;
    font-weight: bold;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
  }
  
  @keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
  }
  
  .banner-timer {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
  }
  
  .timer-text {
    font-size: 16px;
    opacity: 0.9;
  }
  
  .timer-value {
    font-size: 32px;
    font-weight: bold;
    font-family: 'Courier New', monospace;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
    animation: blink 1s infinite;
  }
  
  @keyframes blink {
    0%, 50% { opacity: 1; }
    51%, 100% { opacity: 0.7; }
  }
  
  .catalog-controls {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin: 20px auto;
  }
  
  .controls-left {
    display: flex;
    align-items: center;
    gap: 20px;
  }
  
  .filter-toggle-btn {
    padding: 10px 20px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .filter-toggle-btn:hover {
    background: #0056b3;
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
  
  .controls-right {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .sort-control {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .sort-label {
    font-weight: bold;
    color: #333;
  }
  
  .sort-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
  }
  
  .filters-panel {
    max-width: 1200px;
    margin: 0 auto 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 25px;
  }
  
  .filter-section {
    margin-bottom: 25px;
  }
  
  .filter-section:last-child {
    margin-bottom: 0;
  }
  
  .filter-title {
    margin: 0 0 15px 0;
    font-size: 16px;
    font-weight: bold;
    color: #333;
  }
  
  .filter-options {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .filter-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
  }
  
  .filter-option input[type="radio"],
  .filter-option input[type="checkbox"] {
    margin: 0;
  }
  
  .option-text {
    font-weight: 500;
    color: #333;
  }
  
  .option-count {
    color: #666;
    font-size: 14px;
  }
  
  .price-range {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .price-slider {
    width: 100%;
    height: 6px;
    border-radius: 3px;
    background: #ddd;
    outline: none;
    cursor: pointer;
  }
  
  .price-labels {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
    color: #666;
  }
  
  .products-section {
    max-width: 1200px;
    margin: 0 auto;
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
  
  .results-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
  }
  
  .results-count {
    font-weight: bold;
    color: #333;
  }
  
  .results-sort {
    font-size: 14px;
    color: #666;
    text-transform: capitalize;
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
  .buy-now-btn {
    flex: 1;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
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
  .list-buy-now {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
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
  
  .newsletter-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 50px 20px;
    text-align: center;
    margin-top: 50px;
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
    .catalog-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .controls-left,
    .controls-right {
      justify-content: center;
    }
    
    .banner-title {
      font-size: 36px;
    }
    
    .banner-subtitle {
      font-size: 18px;
    }
    
    .timer-value {
      font-size: 24px;
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

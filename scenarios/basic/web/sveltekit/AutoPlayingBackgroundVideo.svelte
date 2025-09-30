<script>
  let selectedCategory = 'all';
  let sortBy = 'popularity';
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
  
  $: filteredProducts = sortProducts(filterProducts());
</script>

<div class="hero-showcase">
  <div class="hero-section">
    <div class="hero-video-container">
      <video 
        class="hero-video" 
        autoplay 
        muted 
        loop 
        playsinline
      >
        <source src="/api/placeholder/video/tech-showcase.mp4" type="video/mp4" />
        Your browser does not support the video tag.
      </video>
      <div class="hero-overlay"></div>
    </div>
    
    <div class="hero-content">
      <div class="hero-text">
        <h1 class="hero-title">Discover Amazing Technology</h1>
        <p class="hero-subtitle">Explore our collection of cutting-edge gadgets and innovative solutions</p>
        <div class="hero-actions">
          <button class="hero-btn primary">Shop Now</button>
          <button class="hero-btn secondary">Learn More</button>
        </div>
      </div>
      
      <div class="hero-features">
        <div class="feature-item">
          <div class="feature-icon">🚀</div>
          <h3 class="feature-title">Innovation</h3>
          <p class="feature-description">Latest technology trends</p>
        </div>
        <div class="feature-item">
          <div class="feature-icon">⚡</div>
          <h3 class="feature-title">Performance</h3>
          <p class="feature-description">High-quality products</p>
        </div>
        <div class="feature-item">
          <div class="feature-icon">🔒</div>
          <h3 class="feature-title">Reliability</h3>
          <p class="feature-description">Trusted by millions</p>
        </div>
      </div>
    </div>
  </div>

  <div class="showcase-controls">
    <div class="control-group">
      <label class="control-label">Category:</label>
      <select bind:value={selectedCategory} class="control-select">
        <option value="all">All Products</option>
        <option value="audio">Audio</option>
        <option value="wearables">Wearables</option>
        <option value="gaming">Gaming</option>
        <option value="accessories">Accessories</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort by:</label>
      <select bind:value={sortBy} class="control-select">
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
  </div>

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

  <div class="video-showcase-section">
    <div class="video-showcase-content">
      <h3 class="video-title">See Our Products in Action</h3>
      <p class="video-description">Watch our latest product demonstrations and reviews</p>
      <div class="video-grid">
        <div class="video-item">
          <div class="video-thumbnail">
            <video 
              class="showcase-video" 
              autoplay 
              muted 
              loop 
              playsinline
            >
              <source src="/api/placeholder/video/headphones-demo.mp4" type="video/mp4" />
            </video>
            <div class="play-overlay">
              <div class="play-button">▶</div>
            </div>
          </div>
          <h4 class="video-item-title">Wireless Headphones Demo</h4>
          <p class="video-item-description">See the amazing sound quality and comfort</p>
        </div>
        
        <div class="video-item">
          <div class="video-thumbnail">
            <video 
              class="showcase-video" 
              autoplay 
              muted 
              loop 
              playsinline
            >
              <source src="/api/placeholder/video/smartwatch-demo.mp4" type="video/mp4" />
            </video>
            <div class="play-overlay">
              <div class="play-button">▶</div>
            </div>
          </div>
          <h4 class="video-item-title">Smart Watch Features</h4>
          <p class="video-item-description">Explore all the amazing features and capabilities</p>
        </div>
        
        <div class="video-item">
          <div class="video-thumbnail">
            <video 
              class="showcase-video" 
              autoplay 
              muted 
              loop 
              playsinline
            >
              <source src="/api/placeholder/video/speaker-demo.mp4" type="video/mp4" />
            </video>
            <div class="play-overlay">
              <div class="play-button">▶</div>
            </div>
          </div>
          <h4 class="video-item-title">Bluetooth Speaker Test</h4>
          <p class="video-item-description">Experience the powerful 360-degree sound</p>
        </div>
      </div>
    </div>
  </div>

  <div class="newsletter-section">
    <div class="newsletter-content">
      <h3 class="newsletter-title">Stay Updated with Latest Tech</h3>
      <p class="newsletter-description">Get the latest product updates and exclusive offers</p>
      <form class="newsletter-form">
        <input type="email" placeholder="Enter your email address" class="newsletter-input" />
        <button type="submit" class="newsletter-btn">Subscribe</button>
      </form>
      <p class="newsletter-note">Join 50,000+ tech enthusiasts</p>
    </div>
  </div>
</div>

<style>
  .hero-showcase {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .hero-section {
    position: relative;
    height: 100vh;
    overflow: hidden;
  }
  
  .hero-video-container {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
  }
  
  .hero-video {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 100%);
    z-index: 2;
  }
  
  .hero-content {
    position: relative;
    z-index: 3;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: white;
    padding: 0 20px;
  }
  
  .hero-text {
    max-width: 800px;
    margin-bottom: 60px;
  }
  
  .hero-title {
    margin: 0 0 20px 0;
    font-size: 48px;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
  }
  
  .hero-subtitle {
    margin: 0 0 40px 0;
    font-size: 20px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  }
  
  .hero-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
  }
  
  .hero-btn {
    padding: 15px 30px;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 16px;
  }
  
  .hero-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .hero-btn.primary:hover {
    background: #0056b3;
    transform: translateY(-2px);
  }
  
  .hero-btn.secondary {
    background: transparent;
    color: white;
    border: 2px solid white;
  }
  
  .hero-btn.secondary:hover {
    background: white;
    color: #333;
  }
  
  .hero-features {
    display: flex;
    gap: 40px;
    max-width: 800px;
  }
  
  .feature-item {
    text-align: center;
  }
  
  .feature-icon {
    font-size: 48px;
    margin-bottom: 15px;
  }
  
  .feature-title {
    margin: 0 0 10px 0;
    font-size: 18px;
    font-weight: bold;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  }
  
  .feature-description {
    margin: 0;
    font-size: 14px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  }
  
  .showcase-controls {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin: 30px auto;
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
  
  .video-showcase-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .video-showcase-content {
    padding: 40px;
    text-align: center;
  }
  
  .video-title {
    margin: 0 0 15px 0;
    font-size: 28px;
    color: #333;
  }
  
  .video-description {
    margin: 0 0 40px 0;
    color: #666;
    font-size: 16px;
  }
  
  .video-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .video-item {
    text-align: left;
  }
  
  .video-thumbnail {
    position: relative;
    height: 200px;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 20px;
  }
  
  .showcase-video {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .play-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.3);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s ease;
  }
  
  .video-thumbnail:hover .play-overlay {
    opacity: 1;
  }
  
  .play-button {
    width: 60px;
    height: 60px;
    background: rgba(255,255,255,0.9);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: #333;
    cursor: pointer;
  }
  
  .video-item-title {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
    font-weight: bold;
  }
  
  .video-item-description {
    margin: 0;
    color: #666;
    line-height: 1.5;
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
    .hero-title {
      font-size: 36px;
    }
    
    .hero-subtitle {
      font-size: 18px;
    }
    
    .hero-actions {
      flex-direction: column;
      gap: 15px;
    }
    
    .hero-features {
      flex-direction: column;
      gap: 20px;
    }
    
    .showcase-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: space-between;
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
    
    .video-grid {
      grid-template-columns: 1fr;
    }
    
    .newsletter-form {
      flex-direction: column;
    }
    
    .newsletter-btn {
      width: 100%;
    }
  }
</style>

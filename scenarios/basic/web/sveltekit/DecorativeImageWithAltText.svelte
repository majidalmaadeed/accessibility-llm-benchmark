<script>
  let selectedCategory = 'all';
  let sortBy = 'name';
  let viewMode = 'grid';
  
  const products = [
    {
      id: 1,
      name: "Wireless Headphones",
      price: 199.99,
      category: "audio",
      image: "/api/placeholder/300/300",
      description: "High-quality wireless headphones with noise cancellation"
    },
    {
      id: 2,
      name: "Smart Watch",
      price: 299.99,
      category: "wearables",
      image: "/api/placeholder/300/300",
      description: "Advanced fitness tracking smartwatch"
    },
    {
      id: 3,
      name: "Bluetooth Speaker",
      price: 149.99,
      category: "audio",
      image: "/api/placeholder/300/300",
      description: "Portable Bluetooth speaker with 360-degree sound"
    },
    {
      id: 4,
      name: "Gaming Mouse",
      price: 79.99,
      category: "gaming",
      image: "/api/placeholder/300/300",
      description: "Precision gaming mouse with customizable RGB lighting"
    },
    {
      id: 5,
      name: "Mechanical Keyboard",
      price: 129.99,
      category: "gaming",
      image: "/api/placeholder/300/300",
      description: "Mechanical keyboard with Cherry MX switches"
    },
    {
      id: 6,
      name: "USB-C Hub",
      price: 59.99,
      category: "accessories",
      image: "/api/placeholder/300/300",
      description: "Multi-port USB-C hub with HDMI and USB 3.0"
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
        case 'price':
          return a.price - b.price;
        case 'name':
        default:
          return a.name.localeCompare(b.name);
      }
    });
  }
  
  $: filteredProducts = sortProducts(filterProducts());
</script>

<div class="product-showcase">
  <header class="showcase-header">
    <div class="header-content">
      <h1 class="showcase-title">Tech Store</h1>
      <p class="showcase-subtitle">Discover the latest in technology</p>
    </div>
    
    <div class="decorative-banner">
      <img src="/api/placeholder/1200/200" alt="Decorative banner with geometric patterns and tech elements" />
    </div>
  </header>

  <div class="showcase-controls">
    <div class="filter-section">
      <label class="filter-label">Category:</label>
      <select bind:value={selectedCategory} class="filter-select">
        <option value="all">All Products</option>
        <option value="audio">Audio</option>
        <option value="wearables">Wearables</option>
        <option value="gaming">Gaming</option>
        <option value="accessories">Accessories</option>
      </select>
    </div>
    
    <div class="sort-section">
      <label class="sort-label">Sort by:</label>
      <select bind:value={sortBy} class="sort-select">
        <option value="name">Name</option>
        <option value="price">Price</option>
      </select>
    </div>
    
    <div class="view-section">
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

  <div class="products-section">
    <div class="section-header">
      <h2 class="section-title">Featured Products</h2>
      <div class="results-count">{filteredProducts.length} products found</div>
    </div>
    
    {#if viewMode === 'grid'}
      <div class="products-grid">
        {#each filteredProducts as product (product.id)}
          <div class="product-card">
            <div class="product-image-container">
              <img 
                src={product.image} 
                alt={product.name}
                class="product-image"
              />
              <div class="product-badge">New</div>
              <div class="product-actions">
                <button class="action-btn wishlist">♡</button>
                <button class="action-btn quick-view">👁</button>
                <button class="action-btn compare">⚖</button>
              </div>
            </div>
            
            <div class="product-info">
              <h3 class="product-name">{product.name}</h3>
              <p class="product-description">{product.description}</p>
              
              <div class="product-rating">
                <div class="stars">★★★★☆</div>
                <span class="rating-count">(24 reviews)</span>
              </div>
              
              <div class="product-price">
                <span class="current-price">${product.price}</span>
                <span class="original-price">$249.99</span>
                <span class="discount">20% OFF</span>
              </div>
              
              <div class="product-availability">
                <span class="availability-status">In Stock</span>
                <span class="stock-count">12 available</span>
              </div>
              
              <div class="product-actions-bottom">
                <button class="add-to-cart-btn">Add to Cart</button>
                <button class="buy-now-btn">Buy Now</button>
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
            </div>
            
            <div class="list-product-info">
              <h3 class="list-product-name">{product.name}</h3>
              <p class="list-product-description">{product.description}</p>
              
              <div class="list-product-details">
                <div class="list-rating">
                  <span class="list-stars">★★★★☆</span>
                  <span class="list-rating-count">(24 reviews)</span>
                </div>
                
                <div class="list-price">
                  <span class="list-current-price">${product.price}</span>
                  <span class="list-original-price">$249.99</span>
                </div>
                
                <div class="list-availability">
                  <span class="list-stock">In Stock (12 available)</span>
                </div>
              </div>
            </div>
            
            <div class="list-actions">
              <button class="list-action-btn wishlist">♡</button>
              <button class="list-action-btn compare">⚖</button>
              <button class="list-add-to-cart">Add to Cart</button>
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="decorative-section">
    <div class="decorative-content">
      <h3 class="decorative-title">Why Choose Our Store?</h3>
      <div class="decorative-features">
        <div class="decorative-feature">
          <div class="feature-icon">
            <img src="/api/placeholder/60/60" alt="Decorative icon representing quality assurance" />
          </div>
          <h4>Quality Guaranteed</h4>
          <p>All products are tested and certified</p>
        </div>
        
        <div class="decorative-feature">
          <div class="feature-icon">
            <img src="/api/placeholder/60/60" alt="Decorative icon representing fast shipping" />
          </div>
          <h4>Fast Shipping</h4>
          <p>Free shipping on orders over $50</p>
        </div>
        
        <div class="decorative-feature">
          <div class="feature-icon">
            <img src="/api/placeholder/60/60" alt="Decorative icon representing customer support" />
          </div>
          <h4>24/7 Support</h4>
          <p>Round-the-clock customer assistance</p>
        </div>
      </div>
    </div>
    
    <div class="decorative-banner-large">
      <img src="/api/placeholder/800/300" alt="Decorative banner with abstract tech patterns and gradient background" />
    </div>
  </div>

  <div class="newsletter-section">
    <div class="newsletter-content">
      <h3 class="newsletter-title">Stay Updated</h3>
      <p class="newsletter-description">Subscribe to our newsletter for the latest deals and product updates</p>
      <form class="newsletter-form">
        <input type="email" placeholder="Enter your email" class="newsletter-input" />
        <button type="submit" class="newsletter-btn">Subscribe</button>
      </form>
    </div>
    
    <div class="newsletter-decoration">
      <img src="/api/placeholder/400/200" alt="Decorative newsletter illustration with email and notification icons" />
    </div>
  </div>
</div>

<style>
  .product-showcase {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .showcase-header {
    background: white;
    padding: 40px 0;
    text-align: center;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    margin-bottom: 30px;
  }
  
  .showcase-title {
    margin: 0 0 10px 0;
    font-size: 36px;
    color: #333;
  }
  
  .showcase-subtitle {
    margin: 0;
    font-size: 18px;
    color: #666;
  }
  
  .decorative-banner {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .decorative-banner img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 12px;
  }
  
  .showcase-controls {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }
  
  .filter-section,
  .sort-section {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .filter-label,
  .sort-label {
    font-weight: bold;
    color: #333;
  }
  
  .filter-select,
  .sort-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
  }
  
  .view-section {
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
    margin: 0 auto;
    padding: 0 20px;
    margin-bottom: 50px;
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
  
  .results-count {
    color: #666;
    font-size: 14px;
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
  
  .product-image-container {
    position: relative;
    height: 250px;
    overflow: hidden;
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
    background: #28a745;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
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
    color: #ffc107;
    font-size: 16px;
  }
  
  .rating-count {
    color: #666;
    font-size: 12px;
  }
  
  .product-price {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
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
  
  .discount {
    background: #dc3545;
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: bold;
  }
  
  .product-availability {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
  
  .availability-status {
    color: #28a745;
    font-weight: bold;
  }
  
  .stock-count {
    color: #666;
    font-size: 12px;
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
  
  .add-to-cart-btn:hover {
    background: #e9ecef;
  }
  
  .buy-now-btn {
    background: #007bff;
    color: white;
  }
  
  .buy-now-btn:hover {
    background: #0056b3;
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
    width: 200px;
    height: 150px;
    overflow: hidden;
  }
  
  .list-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .list-product-info {
    flex: 1;
    padding: 20px;
  }
  
  .list-product-name {
    margin: 0 0 10px 0;
    font-size: 20px;
    color: #333;
    font-weight: bold;
  }
  
  .list-product-description {
    margin: 0 0 15px 0;
    color: #666;
    line-height: 1.5;
  }
  
  .list-product-details {
    display: flex;
    gap: 30px;
  }
  
  .list-rating {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .list-stars {
    color: #ffc107;
    font-size: 16px;
  }
  
  .list-rating-count {
    color: #666;
    font-size: 12px;
  }
  
  .list-price {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .list-current-price {
    font-size: 20px;
    font-weight: bold;
    color: #007bff;
  }
  
  .list-original-price {
    font-size: 14px;
    color: #999;
    text-decoration: line-through;
  }
  
  .list-availability {
    display: flex;
    align-items: center;
  }
  
  .list-stock {
    color: #28a745;
    font-weight: bold;
  }
  
  .list-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 20px;
    justify-content: center;
  }
  
  .list-action-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 50%;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
  }
  
  .list-action-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .list-add-to-cart {
    padding: 10px 20px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .list-add-to-cart:hover {
    background: #0056b3;
  }
  
  .decorative-section {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    margin-bottom: 50px;
  }
  
  .decorative-content {
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }
  
  .decorative-title {
    text-align: center;
    margin: 0 0 40px 0;
    font-size: 28px;
    color: #333;
  }
  
  .decorative-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .decorative-feature {
    text-align: center;
  }
  
  .feature-icon {
    margin-bottom: 20px;
  }
  
  .feature-icon img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 50%;
  }
  
  .decorative-feature h4 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }
  
  .decorative-feature p {
    margin: 0;
    color: #666;
  }
  
  .decorative-banner-large {
    text-align: center;
  }
  
  .decorative-banner-large img {
    width: 100%;
    max-width: 800px;
    height: 300px;
    object-fit: cover;
    border-radius: 12px;
  }
  
  .newsletter-section {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .newsletter-content {
    padding: 40px;
    text-align: center;
  }
  
  .newsletter-title {
    margin: 0 0 15px 0;
    font-size: 24px;
    color: #333;
  }
  
  .newsletter-description {
    margin: 0 0 30px 0;
    color: #666;
    font-size: 16px;
  }
  
  .newsletter-form {
    display: flex;
    gap: 15px;
    max-width: 400px;
    margin: 0 auto;
  }
  
  .newsletter-input {
    flex: 1;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
  }
  
  .newsletter-input:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .newsletter-btn {
    padding: 12px 24px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .newsletter-btn:hover {
    background: #0056b3;
  }
  
  .newsletter-decoration {
    text-align: center;
    padding: 20px;
  }
  
  .newsletter-decoration img {
    width: 100%;
    max-width: 400px;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
  }
  
  @media (max-width: 768px) {
    .showcase-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .filter-section,
    .sort-section {
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
    
    .list-product-details {
      flex-direction: column;
      gap: 15px;
    }
    
    .list-actions {
      flex-direction: row;
      justify-content: space-between;
    }
    
    .newsletter-form {
      flex-direction: column;
    }
    
    .newsletter-btn {
      width: 100%;
    }
  }
</style>

<script>
  let products = [
    {
      id: 1,
      name: "Wireless Headphones",
      price: 199.99,
      image: "/api/placeholder/300/300",
      description: "High-quality wireless headphones with noise cancellation"
    },
    {
      id: 2,
      name: "Smart Watch",
      price: 299.99,
      image: "/api/placeholder/300/300",
      description: "Advanced fitness tracking smartwatch with heart rate monitoring"
    },
    {
      id: 3,
      name: "Bluetooth Speaker",
      price: 149.99,
      image: "/api/placeholder/300/300",
      description: "Portable Bluetooth speaker with 360-degree sound"
    },
    {
      id: 4,
      name: "Gaming Mouse",
      price: 79.99,
      image: "/api/placeholder/300/300",
      description: "Precision gaming mouse with customizable RGB lighting"
    },
    {
      id: 5,
      name: "Mechanical Keyboard",
      price: 129.99,
      image: "/api/placeholder/300/300",
      description: "Mechanical keyboard with Cherry MX switches"
    },
    {
      id: 6,
      name: "USB-C Hub",
      price: 59.99,
      image: "/api/placeholder/300/300",
      description: "Multi-port USB-C hub with HDMI and USB 3.0"
    }
  ];
  
  let selectedCategory = "all";
  let sortBy = "name";
  let viewMode = "grid";
  
  function filterProducts() {
    return products.filter(product => {
      if (selectedCategory === "all") return true;
      return product.category === selectedCategory;
    });
  }
  
  function sortProducts(products) {
    return [...products].sort((a, b) => {
      switch(sortBy) {
        case "price":
          return a.price - b.price;
        case "name":
        default:
          return a.name.localeCompare(b.name);
      }
    });
  }
  
  $: filteredProducts = sortProducts(filterProducts());
</script>

<div class="product-catalog">
  <header class="catalog-header">
    <h1 class="catalog-title">Electronics Store</h1>
    <p class="catalog-subtitle">Discover the latest in technology and gadgets</p>
  </header>
  
  <div class="catalog-controls">
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
    <div class="products-header">
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
              
              <div class="product-options">
                <div class="color-options">
                  <span class="option-label">Color:</span>
                  <div class="color-swatches">
                    <div class="color-swatch black"></div>
                    <div class="color-swatch white"></div>
                    <div class="color-swatch blue"></div>
                  </div>
                </div>
                
                <div class="size-options">
                  <span class="option-label">Size:</span>
                  <select class="size-select">
                    <option value="s">S</option>
                    <option value="m">M</option>
                    <option value="l">L</option>
                    <option value="xl">XL</option>
                  </select>
                </div>
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
  
  <div class="pagination">
    <button class="page-btn prev">Previous</button>
    <button class="page-btn active">1</button>
    <button class="page-btn">2</button>
    <button class="page-btn">3</button>
    <button class="page-btn next">Next</button>
  </div>
</div>

<style>
  .product-catalog {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
    font-family: Arial, sans-serif;
  }
  
  .catalog-header {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .catalog-title {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }
  
  .catalog-subtitle {
    margin: 0;
    font-size: 16px;
    color: #666;
  }
  
  .catalog-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
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
    margin-bottom: 40px;
  }
  
  .products-header {
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
  
  .product-options {
    margin-bottom: 20px;
  }
  
  .color-options,
  .size-options {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
  }
  
  .option-label {
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }
  
  .color-swatches {
    display: flex;
    gap: 8px;
  }
  
  .color-swatch {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 2px solid #ddd;
    cursor: pointer;
  }
  
  .color-swatch.black {
    background: #333;
  }
  
  .color-swatch.white {
    background: #fff;
  }
  
  .color-swatch.blue {
    background: #007bff;
  }
  
  .size-select {
    padding: 4px 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
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
  
  .pagination {
    display: flex;
    justify-content: center;
    gap: 10px;
  }
  
  .page-btn {
    padding: 10px 15px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    border-radius: 4px;
    transition: all 0.2s ease;
  }
  
  .page-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  @media (max-width: 768px) {
    .catalog-controls {
      flex-direction: column;
      gap: 15px;
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
  }
</style>

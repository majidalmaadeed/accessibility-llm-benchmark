<script>
  let hoveredItem = null;
  let showTooltip = false;
  let tooltipContent = '';
  let tooltipPosition = { x: 0, y: 0 };

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 99.99,
      category: 'Electronics',
      description: 'High-quality wireless headphones with noise cancellation',
      features: ['Noise Cancellation', '30-hour battery', 'Quick Charge'],
      rating: 4.5,
      reviews: 128,
      inStock: true
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: 249.99,
      category: 'Electronics',
      description: 'Advanced smartwatch with health monitoring features',
      features: ['Heart Rate Monitor', 'GPS Tracking', 'Water Resistant'],
      rating: 4.3,
      reviews: 89,
      inStock: true
    },
    {
      id: 3,
      name: 'Coffee Maker',
      price: 149.99,
      category: 'Appliances',
      description: 'Programmable coffee maker with built-in grinder',
      features: ['Programmable Timer', 'Built-in Grinder', '12-cup Capacity'],
      rating: 4.7,
      reviews: 203,
      inStock: false
    },
    {
      id: 4,
      name: 'Running Shoes',
      price: 129.99,
      category: 'Sports',
      description: 'Lightweight running shoes with superior cushioning',
      features: ['Lightweight Design', 'Superior Cushioning', 'Breathable Material'],
      rating: 4.4,
      reviews: 156,
      inStock: true
    }
  ];

  function handleMouseEnter(event, product) {
    hoveredItem = product.id;
    showTooltip = true;
    tooltipContent = product.description;
    
    const rect = event.target.getBoundingClientRect();
    tooltipPosition = {
      x: rect.left + rect.width / 2,
      y: rect.top - 10
    };
  }

  function handleMouseLeave() {
    hoveredItem = null;
    showTooltip = false;
  }

  function handleAction(action, product) {
    alert(`${action} action performed on "${product.name}"`);
  }
</script>

<div class="product-showcase">
  <header class="showcase-header">
    <h1>Product Showcase</h1>
    <p>Hover over products to see detailed information</p>
  </header>

  <div class="products-grid">
    {#each products as product}
      <div class="product-card">
        <div class="product-image">
          <img src="/images/{product.name.toLowerCase().replace(/\s+/g, '-')}.jpg" alt="{product.name}" />
          {#if !product.inStock}
            <div class="out-of-stock-badge">Out of Stock</div>
          {/if}
        </div>

        <div class="product-info">
          <h3 class="product-name">{product.name}</h3>
          
          <div class="product-rating">
            <div class="stars">
              {#each Array(5) as _, i}
                <span class="star {i < Math.floor(product.rating) ? 'filled' : ''}">★</span>
              {/each}
            </div>
            <span class="rating-text">{product.rating} ({product.reviews} reviews)</span>
          </div>

          <div class="product-price">${product.price}</div>

          <div class="product-actions">
            <button 
              class="action-btn primary" 
              on:click={() => handleAction('Add to Cart', product)}
              disabled={!product.inStock}
            >
              {product.inStock ? 'Add to Cart' : 'Out of Stock'}
            </button>
            
            <button 
              class="action-btn secondary" 
              on:click={() => handleAction('Quick View', product)}
            >
              Quick View
            </button>
            
            <button 
              class="action-btn secondary" 
              on:click={() => handleAction('Add to Wishlist', product)}
            >
              ♥
            </button>
          </div>
        </div>

        <div class="product-features">
          <h4>Key Features:</h4>
          <ul>
            {#each product.features as feature}
              <li>{feature}</li>
            {/each}
          </ul>
        </div>

        <div class="help-section">
          <button 
            class="help-btn" 
            on:mouseenter={(e) => handleMouseEnter(e, product)}
            on:mouseleave={handleMouseLeave}
            on:focus={(e) => handleMouseEnter(e, product)}
            on:blur={handleMouseLeave}
          >
            ?
          </button>
          <span class="help-text">Hover for more info</span>
        </div>
      </div>
    {/each}
  </div>

  {#if showTooltip && hoveredItem}
    <div 
      class="tooltip" 
      style="left: {tooltipPosition.x}px; top: {tooltipPosition.y}px;"
    >
      <div class="tooltip-content">
        {tooltipContent}
      </div>
      <div class="tooltip-arrow"></div>
    </div>
  {/if}

  <div class="showcase-info">
    <h3>About This Showcase</h3>
    <p>
      This product showcase demonstrates various interactive elements. 
      Hover over the help buttons (?) to see additional information about each product.
    </p>
    <div class="info-tips">
      <div class="tip-item">
        <span class="tip-icon">💡</span>
        <span class="tip-text">Hover over help buttons for product details</span>
      </div>
      <div class="tip-item">
        <span class="tip-icon">🛒</span>
        <span class="tip-text">Click "Add to Cart" to purchase items</span>
      </div>
      <div class="tip-item">
        <span class="tip-icon">❤️</span>
        <span class="tip-text">Add items to your wishlist for later</span>
      </div>
    </div>
  </div>
</div>

<style>
  .product-showcase {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .showcase-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .showcase-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .showcase-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
    margin-bottom: 40px;
  }

  .product-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    position: relative;
  }

  .product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  }

  .product-image {
    position: relative;
    height: 200px;
    overflow: hidden;
  }

  .product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .out-of-stock-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background: #dc3545;
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: bold;
  }

  .product-info {
    padding: 20px;
  }

  .product-name {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }

  .product-rating {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
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
    font-size: 14px;
    color: #666;
  }

  .product-price {
    font-size: 24px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 15px;
  }

  .product-actions {
    display: flex;
    gap: 8px;
    margin-bottom: 15px;
  }

  .action-btn {
    flex: 1;
    padding: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .action-btn.primary {
    background: #007bff;
    color: white;
  }

  .action-btn.primary:hover:not(:disabled) {
    background: #0056b3;
  }

  .action-btn.primary:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }

  .action-btn.secondary {
    background: #f8f9fa;
    color: #666;
    border: 1px solid #ddd;
  }

  .action-btn.secondary:hover {
    background: #e9ecef;
    color: #333;
  }

  .product-features {
    padding: 0 20px 20px 20px;
  }

  .product-features h4 {
    margin: 0 0 10px 0;
    font-size: 14px;
    color: #333;
  }

  .product-features ul {
    margin: 0;
    padding-left: 20px;
    color: #666;
    font-size: 14px;
  }

  .product-features li {
    margin-bottom: 4px;
  }

  .help-section {
    position: absolute;
    top: 10px;
    left: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
  }

  .help-btn {
    width: 24px;
    height: 24px;
    border: 2px solid #007bff;
    background: white;
    color: #007bff;
    border-radius: 50%;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
  }

  .help-btn:hover,
  .help-btn:focus {
    background: #007bff;
    color: white;
  }

  .help-text {
    font-size: 10px;
    color: #666;
    text-align: center;
    white-space: nowrap;
  }

  .tooltip {
    position: fixed;
    z-index: 1000;
    pointer-events: none;
    transform: translateX(-50%);
  }

  .tooltip-content {
    background: #333;
    color: white;
    padding: 12px 16px;
    border-radius: 6px;
    font-size: 14px;
    max-width: 250px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  }

  .tooltip-arrow {
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    width: 0;
    height: 0;
    border-left: 6px solid transparent;
    border-right: 6px solid transparent;
    border-top: 6px solid #333;
  }

  .showcase-info {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 8px;
    text-align: center;
  }

  .showcase-info h3 {
    margin: 0 0 15px 0;
    font-size: 24px;
    color: #333;
  }

  .showcase-info p {
    margin: 0 0 25px 0;
    color: #666;
    font-size: 16px;
    line-height: 1.5;
  }

  .info-tips {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }

  .tip-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 15px;
    background: white;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .tip-icon {
    font-size: 20px;
  }

  .tip-text {
    color: #333;
    font-size: 14px;
  }

  @media (max-width: 768px) {
    .products-grid {
      grid-template-columns: 1fr;
    }

    .product-actions {
      flex-direction: column;
    }

    .help-section {
      position: static;
      flex-direction: row;
      justify-content: center;
      margin-top: 15px;
    }

    .tooltip {
      position: relative;
      transform: none;
      margin-top: 10px;
    }

    .tooltip-arrow {
      display: none;
    }
  }
</style>

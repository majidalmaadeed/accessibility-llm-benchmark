<script>
  let selectedCategory = 'all';
  let searchTerm = '';
  let sortBy = 'name';
  let viewMode = 'grid';

  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'home', name: 'Home & Garden' },
    { id: 'sports', name: 'Sports' }
  ];

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 99.99,
      category: 'electronics',
      image: 'headphones.jpg',
      rating: 4.5,
      reviews: 128,
      inStock: true
    },
    {
      id: 2,
      name: 'Cotton T-Shirt',
      price: 24.99,
      category: 'clothing',
      image: 'tshirt.jpg',
      rating: 4.2,
      reviews: 89,
      inStock: true
    },
    {
      id: 3,
      name: 'Coffee Maker',
      price: 149.99,
      category: 'home',
      image: 'coffeemaker.jpg',
      rating: 4.7,
      reviews: 203,
      inStock: false
    },
    {
      id: 4,
      name: 'Running Shoes',
      price: 129.99,
      category: 'sports',
      image: 'shoes.jpg',
      rating: 4.4,
      reviews: 156,
      inStock: true
    },
    {
      id: 5,
      name: 'Smartphone Case',
      price: 19.99,
      category: 'electronics',
      image: 'phonecase.jpg',
      rating: 4.1,
      reviews: 67,
      inStock: true
    },
    {
      id: 6,
      name: 'Garden Tools Set',
      price: 79.99,
      category: 'home',
      image: 'gardentools.jpg',
      rating: 4.6,
      reviews: 94,
      inStock: true
    }
  ];

  $: filteredProducts = products.filter(product => {
    const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  $: sortedProducts = [...filteredProducts].sort((a, b) => {
    switch(sortBy) {
      case 'price-low':
        return a.price - b.price;
      case 'price-high':
        return b.price - a.price;
      case 'rating':
        return b.rating - a.rating;
      case 'name':
      default:
        return a.name.localeCompare(b.name);
    }
  });

  function addToCart(product) {
    alert(`Added ${product.name} to cart!`);
  }

  function toggleWishlist(product) {
    alert(`${product.name} added to wishlist!`);
  }
</script>

<div class="product-catalog">
  <header class="catalog-header">
    <h1>Product Catalog</h1>
    <p>Discover amazing products at great prices</p>
  </header>

  <div class="catalog-controls">
    <div class="search-section">
      <input 
        type="text" 
        placeholder="Search products..." 
        bind:value={searchTerm}
        class="search-input"
      />
    </div>

    <div class="filter-section">
      <select bind:value={selectedCategory} class="category-filter">
        {#each categories as category}
          <option value={category.id}>{category.name}</option>
        {/each}
      </select>

      <select bind:value={sortBy} class="sort-filter">
        <option value="name">Sort by Name</option>
        <option value="price-low">Price: Low to High</option>
        <option value="price-high">Price: High to Low</option>
        <option value="rating">Highest Rated</option>
      </select>

      <div class="view-toggle">
        <button 
          class="view-btn {viewMode === 'grid' ? 'active' : ''}" 
          on:click={() => viewMode = 'grid'}
        >
          Grid
        </button>
        <button 
          class="view-btn {viewMode === 'list' ? 'active' : ''}" 
          on:click={() => viewMode = 'list'}
        >
          List
        </button>
      </div>
    </div>
  </div>

  <div class="results-info">
    <p>Showing {sortedProducts.length} products</p>
  </div>

  <div class="products-container {viewMode}">
    {#each sortedProducts as product}
      <div class="product-card">
        <div class="product-image-container">
          <img 
            src="/images/{product.image}" 
            class="product-image"
          />
          {#if !product.inStock}
            <div class="out-of-stock-badge">Out of Stock</div>
          {/if}
          <button 
            class="wishlist-btn" 
            on:click={() => toggleWishlist(product)}
            title="Add to Wishlist"
          >
            ♥
          </button>
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

          <div class="product-price">
            <span class="current-price">${product.price}</span>
            {#if product.price > 50}
              <span class="original-price">${(product.price * 1.2).toFixed(2)}</span>
            {/if}
          </div>

          <div class="product-actions">
            <button 
              class="add-to-cart-btn" 
              on:click={() => addToCart(product)}
              disabled={!product.inStock}
            >
              {product.inStock ? 'Add to Cart' : 'Out of Stock'}
            </button>
            <button class="quick-view-btn">Quick View</button>
          </div>
        </div>
      </div>
    {/each}
  </div>

  {#if sortedProducts.length === 0}
    <div class="no-results">
      <h3>No products found</h3>
      <p>Try adjusting your search or filter criteria</p>
    </div>
  {/if}
</div>

<style>
  .product-catalog {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .catalog-header {
    text-align: center;
    margin-bottom: 30px;
  }

  .catalog-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .catalog-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .catalog-controls {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .search-section {
    display: flex;
    justify-content: center;
  }

  .search-input {
    width: 100%;
    max-width: 400px;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
  }

  .filter-section {
    display: flex;
    gap: 15px;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
  }

  .category-filter,
  .sort-filter {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
  }

  .view-toggle {
    display: flex;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
  }

  .view-btn {
    padding: 8px 16px;
    border: none;
    background: white;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .view-btn.active {
    background: #007bff;
    color: white;
  }

  .results-info {
    margin-bottom: 20px;
    color: #666;
  }

  .products-container.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
  }

  .products-container.list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .products-container.list .product-card {
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  .products-container.list .product-image-container {
    width: 120px;
    height: 120px;
    flex-shrink: 0;
  }

  .products-container.list .product-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .product-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .product-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(0,0,0,0.15);
  }

  .product-image-container {
    position: relative;
    height: 200px;
    overflow: hidden;
  }

  .product-image {
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

  .wishlist-btn {
    position: absolute;
    top: 10px;
    left: 10px;
    background: rgba(255,255,255,0.9);
    border: none;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    cursor: pointer;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .product-info {
    padding: 15px;
  }

  .product-name {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: #333;
    line-height: 1.4;
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
    font-size: 14px;
  }

  .star.filled {
    color: #ffc107;
  }

  .rating-text {
    font-size: 12px;
    color: #666;
  }

  .product-price {
    margin-bottom: 15px;
  }

  .current-price {
    font-size: 18px;
    font-weight: bold;
    color: #007bff;
  }

  .original-price {
    font-size: 14px;
    color: #999;
    text-decoration: line-through;
    margin-left: 8px;
  }

  .product-actions {
    display: flex;
    gap: 8px;
  }

  .add-to-cart-btn {
    flex: 1;
    background: #007bff;
    color: white;
    border: none;
    padding: 10px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
  }

  .add-to-cart-btn:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }

  .quick-view-btn {
    background: #6c757d;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
  }

  .no-results {
    text-align: center;
    padding: 40px;
    color: #666;
  }

  .no-results h3 {
    margin: 0 0 10px 0;
    font-size: 24px;
  }
</style>

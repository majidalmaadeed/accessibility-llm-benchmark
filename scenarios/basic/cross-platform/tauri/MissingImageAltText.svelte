<script>
  import { onMount } from 'svelte';
  
  let products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 99.99,
      image: 'headphones.jpg',
      description: 'High-quality wireless headphones with noise cancellation'
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: 199.99,
      image: 'smartwatch.jpg',
      description: 'Advanced smartwatch with health monitoring features'
    },
    {
      id: 3,
      name: 'Bluetooth Speaker',
      price: 79.99,
      image: 'speaker.jpg',
      description: 'Portable Bluetooth speaker with excellent sound quality'
    },
    {
      id: 4,
      name: 'Gaming Mouse',
      price: 59.99,
      image: 'mouse.jpg',
      description: 'Precision gaming mouse with customizable buttons'
    }
  ];
  
  let cart = [];
  let cartCount = 0;
  
  function addToCart(product) {
    cart.push(product);
    cartCount = cart.length;
    alert(`${product.name} added to cart!`);
  }
  
  function viewProduct(product) {
    alert(`Viewing product: ${product.name}`);
  }
</script>

<div class="ecommerce-page">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">TechStore</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Search clicked')}>
          🔍 Search
        </button>
        <button class="header-btn" on:click={() => alert('Cart clicked')}>
          🛒 Cart ({cartCount})
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Featured Products</h2>
      <p class="page-subtitle">Discover our latest collection</p>
    </div>
    
    <div class="products-grid">
      {#each products as product}
        <div class="product-card">
          <div class="product-image-container">
            <!-- MISSING IMAGE ALT TEXT - Product image in e-commerce card without alternative text -->
            <img src={product.image} class="product-image" />
            <div class="product-overlay">
              <button class="overlay-btn" on:click={() => viewProduct(product)}>
                👁️ Quick View
              </button>
            </div>
          </div>
          
          <div class="product-info">
            <h3 class="product-name">{product.name}</h3>
            <p class="product-description">{product.description}</p>
            <div class="product-price">${product.price}</div>
            <button class="add-to-cart-btn" on:click={() => addToCart(product)}>
              Add to Cart
            </button>
          </div>
        </div>
      {/each}
    </div>
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <p>&copy; 2024 TechStore. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .ecommerce-page {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .page-header {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .page-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
  }
  
  .page-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 30px;
  }
  
  .product-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.2s, box-shadow 0.2s;
  }
  
  .product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
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
    transition: transform 0.2s;
  }
  
  .product-card:hover .product-image {
    transform: scale(1.05);
  }
  
  .product-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s;
  }
  
  .product-card:hover .product-overlay {
    opacity: 1;
  }
  
  .overlay-btn {
    background: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    color: #333;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s;
  }
  
  .overlay-btn:hover {
    background: #f8f9fa;
  }
  
  .product-info {
    padding: 20px;
  }
  
  .product-name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .product-description {
    font-size: 14px;
    color: #666;
    margin: 0 0 15px 0;
    line-height: 1.4;
  }
  
  .product-price {
    font-size: 20px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 15px;
  }
  
  .add-to-cart-btn {
    width: 100%;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .add-to-cart-btn:hover {
    background: #0056b3;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 20px 0;
    text-align: center;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
</style>

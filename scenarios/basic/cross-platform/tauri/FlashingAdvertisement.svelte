<script>
  import { onMount, onDestroy } from 'svelte';
  
  let flashInterval;
  let isFlashing = true;
  let flashCount = 0;
  let maxFlashes = 10;
  
  onMount(() => {
    startFlashing();
  });
  
  onDestroy(() => {
    if (flashInterval) {
      clearInterval(flashInterval);
    }
  });
  
  function startFlashing() {
    // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
    flashInterval = setInterval(() => {
      isFlashing = !isFlashing;
      flashCount++;
      
      if (flashCount >= maxFlashes) {
        stopFlashing();
      }
    }, 200); // 5 times per second
  }
  
  function stopFlashing() {
    if (flashInterval) {
      clearInterval(flashInterval);
      flashInterval = null;
    }
    isFlashing = false;
  }
  
  function handleAdClick() {
    alert('Advertisement clicked! Redirecting to sale page...');
  }
  
  function closeAd() {
    stopFlashing();
  }
</script>

<div class="website">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">ShoppingSite</h1>
      <nav class="nav">
        <a href="#" class="nav-link">Home</a>
        <a href="#" class="nav-link">Products</a>
        <a href="#" class="nav-link">About</a>
        <a href="#" class="nav-link">Contact</a>
      </nav>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Search clicked')}>
          🔍 Search
        </button>
        <button class="header-btn" on:click={() => alert('Cart clicked')}>
          🛒 Cart
        </button>
      </div>
    </div>
  </header>
  
  <!-- FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second -->
  <div class="advertisement-banner {isFlashing ? 'flashing' : ''}" on:click={handleAdClick}>
    <div class="ad-content">
      <div class="ad-icon">🔥</div>
      <div class="ad-text">
        <div class="ad-title">MEGA SALE!</div>
        <div class="ad-subtitle">Up to 70% OFF on all items</div>
        <div class="ad-description">Limited time offer - Don't miss out!</div>
      </div>
      <div class="ad-actions">
        <button class="ad-cta">Shop Now</button>
        <button class="ad-close" on:click={closeAd}>×</button>
      </div>
    </div>
  </div>
  
  <main class="main-content">
    <div class="hero-section">
      <div class="hero-content">
        <h2 class="hero-title">Welcome to Our Store</h2>
        <p class="hero-subtitle">Discover amazing products at great prices</p>
        <button class="hero-cta" on:click={() => alert('Shop Now clicked')}>
          Start Shopping
        </button>
      </div>
    </div>
    
    <div class="products-section">
      <h3 class="section-title">Featured Products</h3>
      <div class="products-grid">
        <div class="product-card">
          <div class="product-image">📱</div>
          <div class="product-info">
            <h4 class="product-name">Smartphone</h4>
            <p class="product-price">$299.99</p>
            <button class="product-btn">Add to Cart</button>
          </div>
        </div>
        
        <div class="product-card">
          <div class="product-image">💻</div>
          <div class="product-info">
            <h4 class="product-name">Laptop</h4>
            <p class="product-price">$899.99</p>
            <button class="product-btn">Add to Cart</button>
          </div>
        </div>
        
        <div class="product-card">
          <div class="product-image">🎧</div>
          <div class="product-info">
            <h4 class="product-name">Headphones</h4>
            <p class="product-price">$149.99</p>
            <button class="product-btn">Add to Cart</button>
          </div>
        </div>
        
        <div class="product-card">
          <div class="product-image">⌚</div>
          <div class="product-info">
            <h4 class="product-name">Smart Watch</h4>
            <p class="product-price">$199.99</p>
            <button class="product-btn">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
    
    <div class="newsletter-section">
      <div class="newsletter-content">
        <h3 class="newsletter-title">Stay Updated</h3>
        <p class="newsletter-subtitle">Get the latest deals and product updates</p>
        <div class="newsletter-form">
          <input type="email" placeholder="Enter your email" class="newsletter-input" />
          <button class="newsletter-btn">Subscribe</button>
        </div>
      </div>
    </div>
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">Company</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">About Us</a></li>
          <li><a href="#" class="footer-link">Careers</a></li>
          <li><a href="#" class="footer-link">Press</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Support</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Help Center</a></li>
          <li><a href="#" class="footer-link">Contact Us</a></li>
          <li><a href="#" class="footer-link">Shipping Info</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Legal</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Privacy Policy</a></li>
          <li><a href="#" class="footer-link">Terms of Service</a></li>
          <li><a href="#" class="footer-link">Cookie Policy</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 ShoppingSite. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .website {
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
  
  .nav {
    display: flex;
    gap: 30px;
  }
  
  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
  }
  
  .nav-link:hover {
    color: #007bff;
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
  
  /* FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second */
  .advertisement-banner {
    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
    color: white;
    padding: 15px 0;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s;
    position: relative;
    overflow: hidden;
  }
  
  .advertisement-banner.flashing {
    animation: flash 0.2s infinite;
  }
  
  @keyframes flash {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.3; }
  }
  
  .advertisement-banner:hover {
    background: linear-gradient(135deg, #ff5252 0%, #d63031 100%);
  }
  
  .ad-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 20px;
  }
  
  .ad-icon {
    font-size: 32px;
    animation: bounce 1s infinite;
  }
  
  @keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
  }
  
  .ad-text {
    flex: 1;
    text-align: center;
  }
  
  .ad-title {
    font-size: 28px;
    font-weight: bold;
    margin: 0 0 5px 0;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
  }
  
  .ad-subtitle {
    font-size: 18px;
    margin: 0 0 5px 0;
    opacity: 0.9;
  }
  
  .ad-description {
    font-size: 14px;
    margin: 0;
    opacity: 0.8;
  }
  
  .ad-actions {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .ad-cta {
    background: white;
    color: #ff6b6b;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .ad-cta:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .ad-close {
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
    padding: 5px;
    border-radius: 50%;
    transition: all 0.2s;
  }
  
  .ad-close:hover {
    background: rgba(255, 255, 255, 0.2);
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .hero-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 80px 0;
    text-align: center;
    margin: 30px 0;
    border-radius: 12px;
  }
  
  .hero-content {
    max-width: 600px;
    margin: 0 auto;
  }
  
  .hero-title {
    font-size: 48px;
    font-weight: bold;
    margin: 0 0 20px 0;
  }
  
  .hero-subtitle {
    font-size: 24px;
    margin: 0 0 30px 0;
    opacity: 0.9;
  }
  
  .hero-cta {
    background: white;
    color: #667eea;
    border: none;
    padding: 15px 30px;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .hero-cta:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .products-section {
    margin: 60px 0;
  }
  
  .section-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin: 0 0 40px 0;
  }
  
  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .product-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.2s;
  }
  
  .product-card:hover {
    transform: translateY(-4px);
  }
  
  .product-image {
    font-size: 48px;
    margin-bottom: 15px;
  }
  
  .product-name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .product-price {
    font-size: 20px;
    font-weight: bold;
    color: #007bff;
    margin: 0 0 15px 0;
  }
  
  .product-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .product-btn:hover {
    background: #0056b3;
  }
  
  .newsletter-section {
    background: #333;
    color: white;
    padding: 60px 0;
    text-align: center;
    margin: 60px 0;
    border-radius: 12px;
  }
  
  .newsletter-content {
    max-width: 500px;
    margin: 0 auto;
  }
  
  .newsletter-title {
    font-size: 28px;
    font-weight: bold;
    margin: 0 0 10px 0;
  }
  
  .newsletter-subtitle {
    font-size: 16px;
    margin: 0 0 30px 0;
    opacity: 0.9;
  }
  
  .newsletter-form {
    display: flex;
    gap: 10px;
  }
  
  .newsletter-input {
    flex: 1;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
  }
  
  .newsletter-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .newsletter-btn:hover {
    background: #0056b3;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 40px 0 20px 0;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 40px;
  }
  
  .footer-title {
    font-size: 18px;
    font-weight: bold;
    margin: 0 0 15px 0;
  }
  
  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .footer-links li {
    margin-bottom: 8px;
  }
  
  .footer-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .footer-link:hover {
    color: white;
  }
  
  .footer-bottom {
    border-top: 1px solid #555;
    margin-top: 30px;
    padding-top: 20px;
    text-align: center;
    color: #ccc;
  }
</style>

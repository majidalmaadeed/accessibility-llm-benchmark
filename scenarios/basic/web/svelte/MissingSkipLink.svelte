<script>
  let currentSection = 'hero';
  let isMenuOpen = false;
  let searchTerm = '';
  let selectedCategory = 'all';

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
      inStock: true
    },
    {
      id: 2,
      name: 'Cotton T-Shirt',
      price: 24.99,
      category: 'clothing',
      image: 'tshirt.jpg',
      rating: 4.2,
      inStock: true
    },
    {
      id: 3,
      name: 'Coffee Maker',
      price: 149.99,
      category: 'home',
      image: 'coffeemaker.jpg',
      rating: 4.7,
      inStock: false
    },
    {
      id: 4,
      name: 'Running Shoes',
      price: 129.99,
      category: 'sports',
      image: 'shoes.jpg',
      rating: 4.4,
      inStock: true
    }
  ];

  $: filteredProducts = products.filter(product => {
    const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  function scrollToSection(sectionId) {
    currentSection = sectionId;
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  }

  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }

  function handleAction(action, product) {
    alert(`${action} action performed on "${product.name}"`);
  }

  function handleSearch() {
    scrollToSection('products');
  }
</script>

<div class="ecommerce-site">
  <header class="site-header">
    <div class="header-top">
      <div class="container">
        <div class="header-info">
          <span class="phone">📞 +1 (555) 123-4567</span>
          <span class="email">✉️ support@example.com</span>
          <span class="hours">🕒 Mon-Fri 9AM-6PM</span>
        </div>
        <div class="header-actions">
          <button class="header-btn">Account</button>
          <button class="header-btn">Wishlist</button>
          <button class="header-btn">Cart (0)</button>
        </div>
      </div>
    </div>

    <div class="header-main">
      <div class="container">
        <div class="logo-section">
          <h1 class="site-logo">ShopHub</h1>
          <p class="site-tagline">Your One-Stop Shopping Destination</p>
        </div>

        <div class="search-section">
          <div class="search-bar">
            <input 
              type="text" 
              placeholder="Search for products..." 
              bind:value={searchTerm}
              class="search-input"
            />
            <button class="search-btn" on:click={handleSearch}>Search</button>
          </div>
        </div>

        <div class="header-cta">
          <button class="cta-btn primary">Sign Up</button>
          <button class="cta-btn secondary">Login</button>
        </div>
      </div>
    </div>

    <nav class="main-navigation">
      <div class="container">
        <button class="mobile-menu-btn" on:click={toggleMenu}>
          ☰ Menu
        </button>
        
        <ul class="nav-list {isMenuOpen ? 'open' : ''}">
          <li class="nav-item">
            <button class="nav-link" on:click={() => scrollToSection('hero')}>
              Home
            </button>
          </li>
          <li class="nav-item">
            <button class="nav-link" on:click={() => scrollToSection('products')}>
              Products
            </button>
          </li>
          <li class="nav-item">
            <button class="nav-link" on:click={() => scrollToSection('features')}>
              Features
            </button>
          </li>
          <li class="nav-item">
            <button class="nav-link" on:click={() => scrollToSection('about')}>
              About
            </button>
          </li>
          <li class="nav-item">
            <button class="nav-link" on:click={() => scrollToSection('contact')}>
              Contact
            </button>
          </li>
        </ul>
      </div>
    </nav>
  </header>

  <main class="site-main">
    <section id="hero" class="hero-section">
      <div class="hero-content">
        <h2 class="hero-title">Welcome to ShopHub</h2>
        <p class="hero-description">
          Discover amazing products at unbeatable prices. 
          Shop with confidence and enjoy fast, reliable delivery.
        </p>
        <div class="hero-actions">
          <button class="hero-btn primary" on:click={() => scrollToSection('products')}>
            Shop Now
          </button>
          <button class="hero-btn secondary" on:click={() => scrollToSection('features')}>
            Learn More
          </button>
        </div>
      </div>
      <div class="hero-image">
        <div class="image-placeholder">
          <h3>Featured Products</h3>
          <p>Discover our best-selling items</p>
        </div>
      </div>
    </section>

    <section id="products" class="products-section">
      <div class="container">
        <h2 class="section-title">Our Products</h2>
        <p class="section-description">Browse our carefully curated selection of quality products</p>

        <div class="product-filters">
          <select bind:value={selectedCategory} class="category-filter">
            {#each categories as category}
              <option value={category.id}>{category.name}</option>
            {/each}
          </select>
        </div>

        <div class="products-grid">
          {#each filteredProducts as product}
            <div class="product-card">
              <div class="product-image">
                <img src="/images/{product.image}" alt="{product.name}" />
                {#if !product.inStock}
                  <div class="out-of-stock-badge">Out of Stock</div>
                {/if}
              </div>
              
              <div class="product-info">
                <h3 class="product-name">{product.name}</h3>
                <div class="product-rating">
                  {#each Array(5) as _, i}
                    <span class="star {i < Math.floor(product.rating) ? 'filled' : ''}">★</span>
                  {/each}
                  <span class="rating-text">{product.rating}</span>
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
                    on:click={() => handleAction('View Details', product)}
                  >
                    View Details
                  </button>
                </div>
              </div>
            </div>
          {/each}
        </div>
      </div>
    </section>

    <section id="features" class="features-section">
      <div class="container">
        <h2 class="section-title">Why Choose ShopHub?</h2>
        <p class="section-description">We're committed to providing the best shopping experience</p>

        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">🚚</div>
            <h3 class="feature-title">Free Shipping</h3>
            <p class="feature-description">Free delivery on orders over $50</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3 class="feature-title">Secure Payment</h3>
            <p class="feature-description">Your payment information is always safe</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">↩️</div>
            <h3 class="feature-title">Easy Returns</h3>
            <p class="feature-description">30-day return policy for all items</p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">💬</div>
            <h3 class="feature-title">24/7 Support</h3>
            <p class="feature-description">Our team is here to help you anytime</p>
          </div>
        </div>
      </div>
    </section>

    <section id="about" class="about-section">
      <div class="container">
        <div class="about-content">
          <h2 class="section-title">About ShopHub</h2>
          <p class="about-description">
            Founded in 2020, ShopHub has been revolutionizing the online shopping experience. 
            We believe that everyone deserves access to quality products at affordable prices.
          </p>
          <div class="about-stats">
            <div class="stat-item">
              <div class="stat-number">50K+</div>
              <div class="stat-label">Happy Customers</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">10K+</div>
              <div class="stat-label">Products</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">99%</div>
              <div class="stat-label">Satisfaction Rate</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section id="contact" class="contact-section">
      <div class="container">
        <h2 class="section-title">Get in Touch</h2>
        <p class="section-description">Have questions? We'd love to hear from you</p>

        <div class="contact-content">
          <div class="contact-info">
            <div class="contact-item">
              <div class="contact-icon">📍</div>
              <div class="contact-details">
                <h4>Address</h4>
                <p>123 Commerce Street<br>New York, NY 10001</p>
              </div>
            </div>
            
            <div class="contact-item">
              <div class="contact-icon">📞</div>
              <div class="contact-details">
                <h4>Phone</h4>
                <p>+1 (555) 123-4567</p>
              </div>
            </div>
            
            <div class="contact-item">
              <div class="contact-icon">✉️</div>
              <div class="contact-details">
                <h4>Email</h4>
                <p>support@shophub.com</p>
              </div>
            </div>
          </div>

          <div class="contact-form">
            <form>
              <div class="form-group">
                <input type="text" placeholder="Your Name" class="form-input" />
              </div>
              <div class="form-group">
                <input type="email" placeholder="Your Email" class="form-input" />
              </div>
              <div class="form-group">
                <textarea placeholder="Your Message" class="form-textarea" rows="5"></textarea>
              </div>
              <button type="submit" class="submit-btn">Send Message</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="site-footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h4>ShopHub</h4>
          <p>Your trusted online shopping partner</p>
          <div class="social-links">
            <button class="social-btn">📘</button>
            <button class="social-btn">🐦</button>
            <button class="social-btn">📷</button>
            <button class="social-btn">💼</button>
          </div>
        </div>
        
        <div class="footer-section">
          <h4>Quick Links</h4>
          <ul>
            <li><button class="footer-link" on:click={() => scrollToSection('products')}>Products</button></li>
            <li><button class="footer-link" on:click={() => scrollToSection('about')}>About Us</button></li>
            <li><button class="footer-link" on:click={() => scrollToSection('contact')}>Contact</button></li>
            <li><button class="footer-link">FAQ</button></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Customer Service</h4>
          <ul>
            <li><button class="footer-link">Shipping Info</button></li>
            <li><button class="footer-link">Returns</button></li>
            <li><button class="footer-link">Size Guide</button></li>
            <li><button class="footer-link">Track Order</button></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Newsletter</h4>
          <p>Subscribe for updates and special offers</p>
          <div class="newsletter-form">
            <input type="email" placeholder="Enter your email" class="newsletter-input" />
            <button class="newsletter-btn">Subscribe</button>
          </div>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 ShopHub. All rights reserved.</p>
        <div class="footer-links">
          <button class="footer-link">Privacy Policy</button>
          <button class="footer-link">Terms of Service</button>
          <button class="footer-link">Cookie Policy</button>
        </div>
      </div>
    </div>
  </footer>
</div>

<style>
  .ecommerce-site {
    font-family: Arial, sans-serif;
    line-height: 1.6;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .site-header {
    background: white;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
  }

  .header-top {
    background: #f8f9fa;
    padding: 8px 0;
    font-size: 14px;
  }

  .header-info {
    display: flex;
    gap: 20px;
    color: #666;
  }

  .header-actions {
    display: flex;
    gap: 15px;
  }

  .header-btn {
    background: none;
    border: none;
    color: #666;
    cursor: pointer;
    font-size: 14px;
  }

  .header-btn:hover {
    color: #007bff;
  }

  .header-main {
    padding: 20px 0;
  }

  .header-main .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 30px;
  }

  .logo-section h1 {
    margin: 0;
    font-size: 32px;
    color: #007bff;
    font-weight: bold;
  }

  .site-tagline {
    margin: 0;
    color: #666;
    font-size: 14px;
  }

  .search-section {
    flex: 1;
    max-width: 500px;
  }

  .search-bar {
    display: flex;
    border: 2px solid #ddd;
    border-radius: 25px;
    overflow: hidden;
  }

  .search-input {
    flex: 1;
    padding: 12px 20px;
    border: none;
    font-size: 16px;
  }

  .search-input:focus {
    outline: none;
  }

  .search-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 12px 24px;
    cursor: pointer;
    font-weight: bold;
  }

  .search-btn:hover {
    background: #0056b3;
  }

  .header-cta {
    display: flex;
    gap: 10px;
  }

  .cta-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
  }

  .cta-btn.primary {
    background: #007bff;
    color: white;
  }

  .cta-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .main-navigation {
    background: #333;
  }

  .mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    color: white;
    padding: 15px;
    cursor: pointer;
    font-size: 16px;
  }

  .nav-list {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
  }

  .nav-item {
    margin: 0;
  }

  .nav-link {
    display: block;
    padding: 15px 25px;
    background: none;
    border: none;
    color: white;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.2s ease;
  }

  .nav-link:hover {
    background: #555;
  }

  .site-main {
    min-height: 100vh;
  }

  .hero-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 80px 0;
    display: flex;
    align-items: center;
    min-height: 500px;
  }

  .hero-content {
    flex: 1;
    max-width: 600px;
    margin-right: 40px;
  }

  .hero-title {
    margin: 0 0 20px 0;
    font-size: 48px;
    font-weight: bold;
  }

  .hero-description {
    margin: 0 0 30px 0;
    font-size: 20px;
    line-height: 1.5;
  }

  .hero-actions {
    display: flex;
    gap: 20px;
  }

  .hero-btn {
    padding: 15px 30px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .hero-btn.primary {
    background: white;
    color: #667eea;
  }

  .hero-btn.primary:hover {
    background: #f8f9fa;
  }

  .hero-btn.secondary {
    background: rgba(255,255,255,0.2);
    color: white;
    border: 2px solid white;
  }

  .hero-btn.secondary:hover {
    background: white;
    color: #667eea;
  }

  .hero-image {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .image-placeholder {
    width: 100%;
    height: 300px;
    background: rgba(255,255,255,0.1);
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
  }

  .image-placeholder h3 {
    margin: 0 0 10px 0;
    font-size: 24px;
  }

  .image-placeholder p {
    margin: 0;
    font-size: 16px;
    opacity: 0.8;
  }

  .products-section,
  .features-section,
  .about-section,
  .contact-section {
    padding: 80px 0;
  }

  .products-section {
    background: #f8f9fa;
  }

  .section-title {
    text-align: center;
    margin: 0 0 20px 0;
    font-size: 36px;
    color: #333;
  }

  .section-description {
    text-align: center;
    margin: 0 0 40px 0;
    font-size: 18px;
    color: #666;
  }

  .product-filters {
    display: flex;
    justify-content: center;
    margin-bottom: 40px;
  }

  .category-filter {
    padding: 10px 20px;
    border: 2px solid #ddd;
    border-radius: 6px;
    background: white;
    font-size: 16px;
  }

  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 30px;
  }

  .product-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }

  .product-card:hover {
    transform: translateY(-5px);
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
    gap: 5px;
    margin-bottom: 10px;
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
    margin-left: 5px;
  }

  .product-price {
    font-size: 24px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 15px;
  }

  .product-actions {
    display: flex;
    gap: 10px;
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

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }

  .feature-card {
    text-align: center;
    padding: 30px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }

  .feature-icon {
    font-size: 48px;
    margin-bottom: 20px;
  }

  .feature-title {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }

  .feature-description {
    margin: 0;
    color: #666;
    line-height: 1.5;
  }

  .about-content {
    text-align: center;
    max-width: 800px;
    margin: 0 auto;
  }

  .about-description {
    margin: 0 0 40px 0;
    font-size: 18px;
    color: #666;
    line-height: 1.6;
  }

  .about-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 30px;
  }

  .stat-item {
    text-align: center;
  }

  .stat-number {
    font-size: 36px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 10px;
  }

  .stat-label {
    font-size: 16px;
    color: #666;
  }

  .contact-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
    align-items: start;
  }

  .contact-item {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
  }

  .contact-icon {
    font-size: 24px;
    color: #007bff;
  }

  .contact-details h4 {
    margin: 0 0 5px 0;
    font-size: 18px;
    color: #333;
  }

  .contact-details p {
    margin: 0;
    color: #666;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-input,
  .form-textarea {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
  }

  .form-input:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #007bff;
  }

  .submit-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
  }

  .submit-btn:hover {
    background: #0056b3;
  }

  .site-footer {
    background: #333;
    color: white;
    padding: 40px 0 20px 0;
  }

  .footer-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    margin-bottom: 30px;
  }

  .footer-section h4 {
    margin: 0 0 15px 0;
    font-size: 18px;
  }

  .footer-section p {
    margin: 0 0 15px 0;
    color: #ccc;
  }

  .footer-section ul {
    list-style: none;
    margin: 0;
    padding: 0;
  }

  .footer-section li {
    margin-bottom: 8px;
  }

  .footer-link {
    background: none;
    border: none;
    color: #ccc;
    cursor: pointer;
    text-decoration: none;
  }

  .footer-link:hover {
    color: white;
  }

  .social-links {
    display: flex;
    gap: 10px;
  }

  .social-btn {
    background: #555;
    border: none;
    border-radius: 4px;
    padding: 8px;
    cursor: pointer;
    font-size: 16px;
  }

  .social-btn:hover {
    background: #666;
  }

  .newsletter-form {
    display: flex;
    gap: 10px;
  }

  .newsletter-input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #555;
    border-radius: 4px;
    background: #444;
    color: white;
  }

  .newsletter-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .newsletter-btn:hover {
    background: #0056b3;
  }

  .footer-bottom {
    border-top: 1px solid #555;
    padding-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
  }

  .footer-bottom p {
    margin: 0;
    color: #ccc;
  }

  .footer-links {
    display: flex;
    gap: 20px;
  }

  @media (max-width: 768px) {
    .mobile-menu-btn {
      display: block;
    }

    .nav-list {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      right: 0;
      background: #333;
      flex-direction: column;
    }

    .nav-list.open {
      display: flex;
    }

    .header-main .container {
      flex-direction: column;
      gap: 20px;
    }

    .hero-section {
      flex-direction: column;
      text-align: center;
    }

    .hero-content {
      margin-right: 0;
      margin-bottom: 30px;
    }

    .contact-content {
      grid-template-columns: 1fr;
    }

    .footer-bottom {
      flex-direction: column;
      text-align: center;
    }
  }
</style>

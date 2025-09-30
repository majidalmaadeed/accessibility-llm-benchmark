<script>
  let currentLanguage = 'en';
  let selectedContent = 'home';
  
  const content = {
    en: {
      title: "Welcome to Our Website",
      subtitle: "Discover amazing products and services",
      description: "We offer a wide range of high-quality products and services to meet all your needs. Our team is dedicated to providing excellent customer service and innovative solutions.",
      features: [
        "Premium Quality Products",
        "24/7 Customer Support", 
        "Fast and Secure Delivery",
        "Money-back Guarantee"
      ],
      cta: "Get Started Today"
    },
    fr: {
      title: "Bienvenue sur Notre Site Web",
      subtitle: "Découvrez des produits et services incroyables",
      description: "Nous offrons une large gamme de produits et services de haute qualité pour répondre à tous vos besoins. Notre équipe se consacre à fournir un excellent service client et des solutions innovantes.",
      features: [
        "Produits de Qualité Premium",
        "Support Client 24/7",
        "Livraison Rapide et Sécurisée", 
        "Garantie de Remboursement"
      ],
      cta: "Commencez Aujourd'hui"
    },
    es: {
      title: "Bienvenido a Nuestro Sitio Web",
      subtitle: "Descubre productos y servicios increíbles",
      description: "Ofrecemos una amplia gama de productos y servicios de alta calidad para satisfacer todas sus necesidades. Nuestro equipo se dedica a brindar un excelente servicio al cliente y soluciones innovadoras.",
      features: [
        "Productos de Calidad Premium",
        "Soporte al Cliente 24/7",
        "Entrega Rápida y Segura",
        "Garantía de Devolución de Dinero"
      ],
      cta: "Comienza Hoy"
    },
    de: {
      title: "Willkommen auf unserer Website",
      subtitle: "Entdecken Sie erstaunliche Produkte und Dienstleistungen",
      description: "Wir bieten eine breite Palette hochwertiger Produkte und Dienstleistungen, um all Ihre Bedürfnisse zu erfüllen. Unser Team ist darauf spezialisiert, exzellenten Kundenservice und innovative Lösungen zu bieten.",
      features: [
        "Premium-Qualitätsprodukte",
        "24/7 Kundensupport",
        "Schnelle und sichere Lieferung",
        "Geld-zurück-Garantie"
      ],
      cta: "Jetzt Starten"
    }
  };
  
  function changeLanguage(lang) {
    currentLanguage = lang;
  }
  
  function changeContent(contentType) {
    selectedContent = contentType;
  }
  
  $: currentText = content[currentLanguage];
</script>

<div class="multilingual-website">
  <header class="site-header">
    <div class="header-content">
      <div class="logo-section">
        <img src="/api/placeholder/50/50" alt="Company Logo" class="site-logo" />
        <h1 class="site-title">GlobalTech Solutions</h1>
      </div>
      
      <nav class="main-navigation">
        <ul class="nav-menu">
          <li class="nav-item">
            <a href="/home" class="nav-link" class:active={selectedContent === 'home'} on:click={() => changeContent('home')}>
              Home
            </a>
          </li>
          <li class="nav-item">
            <a href="/about" class="nav-link" class:active={selectedContent === 'about'} on:click={() => changeContent('about')}>
              About
            </a>
          </li>
          <li class="nav-item">
            <a href="/products" class="nav-link" class:active={selectedContent === 'products'} on:click={() => changeContent('products')}>
              Products
            </a>
          </li>
          <li class="nav-item">
            <a href="/services" class="nav-link" class:active={selectedContent === 'services'} on:click={() => changeContent('services')}>
              Services
            </a>
          </li>
          <li class="nav-item">
            <a href="/contact" class="nav-link" class:active={selectedContent === 'contact'} on:click={() => changeContent('contact')}>
              Contact
            </a>
          </li>
        </ul>
      </nav>
      
      <div class="language-selector">
        <select bind:value={currentLanguage} class="language-select">
          <option value="en">English</option>
          <option value="fr">Français</option>
          <option value="es">Español</option>
          <option value="de">Deutsch</option>
        </select>
      </div>
    </div>
  </header>

  <main class="main-content">
    <div class="hero-section">
      <div class="hero-content">
        <h2 class="hero-title">{currentText.title}</h2>
        <p class="hero-subtitle">{currentText.subtitle}</p>
        <p class="hero-description">{currentText.description}</p>
        
        <div class="hero-actions">
          <button class="cta-button primary">{currentText.cta}</button>
          <button class="cta-button secondary">Learn More</button>
        </div>
      </div>
      
      <div class="hero-image">
        <img src="/api/placeholder/600/400" alt="Hero Image" />
      </div>
    </div>

    <div class="features-section">
      <h3 class="section-title">Why Choose Us</h3>
      <div class="features-grid">
        {#each currentText.features as feature, index}
          <div class="feature-card">
            <div class="feature-icon">
              <img src="/api/placeholder/60/60" alt="Feature Icon" />
            </div>
            <h4 class="feature-title">{feature}</h4>
            <p class="feature-description">
              {#if currentLanguage === 'en'}
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              {:else if currentLanguage === 'fr'}
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              {:else if currentLanguage === 'es'}
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              {:else if currentLanguage === 'de'}
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              {/if}
            </p>
          </div>
        {/each}
      </div>
    </div>

    <div class="content-section">
      {#if selectedContent === 'home'}
        <div class="home-content">
          <h3 class="content-title">Welcome to Our Platform</h3>
          <div class="content-grid">
            <div class="content-card">
              <img src="/api/placeholder/300/200" alt="Product Showcase" />
              <h4>Our Products</h4>
              <p>Discover our innovative product range designed to meet modern needs.</p>
            </div>
            <div class="content-card">
              <img src="/api/placeholder/300/200" alt="Service Overview" />
              <h4>Our Services</h4>
              <p>Professional services tailored to your business requirements.</p>
            </div>
            <div class="content-card">
              <img src="/api/placeholder/300/200" alt="Support Team" />
              <h4>Support Team</h4>
              <p>24/7 customer support to help you succeed.</p>
            </div>
          </div>
        </div>
      {:else if selectedContent === 'about'}
        <div class="about-content">
          <h3 class="content-title">About Our Company</h3>
          <div class="about-text">
            <p>Founded in 2010, we have been at the forefront of technological innovation, providing cutting-edge solutions to businesses worldwide.</p>
            <p>Our mission is to empower organizations with the tools and technologies they need to thrive in the digital age.</p>
          </div>
        </div>
      {:else if selectedContent === 'products'}
        <div class="products-content">
          <h3 class="content-title">Our Products</h3>
          <div class="products-grid">
            <div class="product-item">
              <img src="/api/placeholder/250/200" alt="Product 1" />
              <h4>Product A</h4>
              <p>Advanced solution for modern businesses</p>
            </div>
            <div class="product-item">
              <img src="/api/placeholder/250/200" alt="Product 2" />
              <h4>Product B</h4>
              <p>Innovative technology for growth</p>
            </div>
            <div class="product-item">
              <img src="/api/placeholder/250/200" alt="Product 3" />
              <h4>Product C</h4>
              <p>Scalable solutions for enterprises</p>
            </div>
          </div>
        </div>
      {:else if selectedContent === 'services'}
        <div class="services-content">
          <h3 class="content-title">Our Services</h3>
          <div class="services-list">
            <div class="service-item">
              <h4>Consulting</h4>
              <p>Strategic guidance for digital transformation</p>
            </div>
            <div class="service-item">
              <h4>Implementation</h4>
              <p>Professional deployment of our solutions</p>
            </div>
            <div class="service-item">
              <h4>Support</h4>
              <p>Ongoing maintenance and technical support</p>
            </div>
          </div>
        </div>
      {:else if selectedContent === 'contact'}
        <div class="contact-content">
          <h3 class="content-title">Contact Us</h3>
          <div class="contact-info">
            <div class="contact-item">
              <h4>Email</h4>
              <p>info@globaltech.com</p>
            </div>
            <div class="contact-item">
              <h4>Phone</h4>
              <p>+1 (555) 123-4567</p>
            </div>
            <div class="contact-item">
              <h4>Address</h4>
              <p>123 Business Street, City, State 12345</p>
            </div>
          </div>
        </div>
      {/if}
    </div>
  </main>

  <footer class="site-footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4>Company</h4>
        <ul class="footer-links">
          <li><a href="/about">About Us</a></li>
          <li><a href="/careers">Careers</a></li>
          <li><a href="/press">Press</a></li>
          <li><a href="/blog">Blog</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4>Products</h4>
        <ul class="footer-links">
          <li><a href="/products">All Products</a></li>
          <li><a href="/pricing">Pricing</a></li>
          <li><a href="/features">Features</a></li>
          <li><a href="/integrations">Integrations</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4>Support</h4>
        <ul class="footer-links">
          <li><a href="/help">Help Center</a></li>
          <li><a href="/contact">Contact Support</a></li>
          <li><a href="/status">System Status</a></li>
          <li><a href="/api">API Documentation</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4>Legal</h4>
        <ul class="footer-links">
          <li><a href="/privacy">Privacy Policy</a></li>
          <li><a href="/terms">Terms of Service</a></li>
          <li><a href="/cookies">Cookie Policy</a></li>
          <li><a href="/gdpr">GDPR</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 GlobalTech Solutions. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .multilingual-website {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .site-header {
    background: white;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 100;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 70px;
  }
  
  .logo-section {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .site-logo {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 4px;
  }
  
  .site-title {
    margin: 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }
  
  .main-navigation {
    display: flex;
  }
  
  .nav-menu {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
    gap: 30px;
  }
  
  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s ease;
    padding: 10px 0;
  }
  
  .nav-link:hover,
  .nav-link.active {
    color: #007bff;
  }
  
  .language-selector {
    display: flex;
    align-items: center;
  }
  
  .language-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
    font-size: 14px;
  }
  
  .language-select:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
  }
  
  .hero-section {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: center;
    margin-bottom: 80px;
    background: white;
    padding: 60px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  }
  
  .hero-title {
    margin: 0 0 20px 0;
    font-size: 36px;
    font-weight: bold;
    color: #333;
    line-height: 1.2;
  }
  
  .hero-subtitle {
    margin: 0 0 20px 0;
    font-size: 20px;
    color: #666;
  }
  
  .hero-description {
    margin: 0 0 30px 0;
    font-size: 16px;
    color: #666;
    line-height: 1.6;
  }
  
  .hero-actions {
    display: flex;
    gap: 20px;
  }
  
  .cta-button {
    padding: 15px 30px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
    font-size: 16px;
    transition: all 0.2s ease;
    cursor: pointer;
    border: none;
  }
  
  .cta-button.primary {
    background: #007bff;
    color: white;
  }
  
  .cta-button.primary:hover {
    background: #0056b3;
    transform: translateY(-2px);
  }
  
  .cta-button.secondary {
    background: transparent;
    color: #007bff;
    border: 2px solid #007bff;
  }
  
  .cta-button.secondary:hover {
    background: #007bff;
    color: white;
  }
  
  .hero-image img {
    width: 100%;
    height: 400px;
    object-fit: cover;
    border-radius: 8px;
  }
  
  .features-section {
    margin-bottom: 80px;
  }
  
  .section-title {
    text-align: center;
    margin: 0 0 50px 0;
    font-size: 32px;
    color: #333;
  }
  
  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .feature-card {
    background: white;
    padding: 40px 30px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    transition: transform 0.2s ease;
  }
  
  .feature-card:hover {
    transform: translateY(-5px);
  }
  
  .feature-icon {
    margin-bottom: 25px;
  }
  
  .feature-icon img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 50%;
  }
  
  .feature-title {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
    font-weight: bold;
  }
  
  .feature-description {
    margin: 0;
    color: #666;
    line-height: 1.6;
  }
  
  .content-section {
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    margin-bottom: 40px;
  }
  
  .content-title {
    margin: 0 0 30px 0;
    font-size: 28px;
    color: #333;
  }
  
  .content-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .content-card {
    text-align: center;
  }
  
  .content-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .content-card h4 {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }
  
  .content-card p {
    margin: 0;
    color: #666;
    line-height: 1.6;
  }
  
  .about-text p {
    margin-bottom: 20px;
    color: #666;
    line-height: 1.6;
  }
  
  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .product-item {
    text-align: center;
  }
  
  .product-item img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .product-item h4 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }
  
  .product-item p {
    margin: 0;
    color: #666;
  }
  
  .services-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .service-item {
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }
  
  .service-item h4 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }
  
  .service-item p {
    margin: 0;
    color: #666;
  }
  
  .contact-info {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 30px;
  }
  
  .contact-item h4 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }
  
  .contact-item p {
    margin: 0;
    color: #666;
  }
  
  .site-footer {
    background: #333;
    color: white;
    padding: 60px 0 20px;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    margin-bottom: 40px;
  }
  
  .footer-section h4 {
    margin: 0 0 20px 0;
    font-size: 18px;
    color: white;
  }
  
  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .footer-links li {
    margin-bottom: 10px;
  }
  
  .footer-links a {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s ease;
  }
  
  .footer-links a:hover {
    color: white;
  }
  
  .footer-bottom {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #555;
    color: #ccc;
  }
  
  @media (max-width: 768px) {
    .header-content {
      flex-direction: column;
      height: auto;
      padding: 20px;
    }
    
    .nav-menu {
      flex-wrap: wrap;
      gap: 15px;
    }
    
    .hero-section {
      grid-template-columns: 1fr;
      text-align: center;
      padding: 40px 20px;
    }
    
    .hero-title {
      font-size: 28px;
    }
    
    .hero-actions {
      flex-direction: column;
      align-items: center;
    }
    
    .content-grid,
    .products-grid {
      grid-template-columns: 1fr;
    }
    
    .footer-content {
      grid-template-columns: 1fr;
      text-align: center;
    }
  }
</style>

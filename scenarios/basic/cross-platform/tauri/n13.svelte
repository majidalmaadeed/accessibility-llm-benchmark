<script>
  import { onMount } from 'svelte';
  
  let currentSection = 'home';
  let isMenuOpen = false;
  
  function scrollToSection(sectionId) {
    currentSection = sectionId;
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
    isMenuOpen = false;
  }
  
  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
  
  function handleKeydown(event) {
    if (event.key === 'Escape' && isMenuOpen) {
      isMenuOpen = false;
    }
  }
  
  onMount(() => {
    document.addEventListener('keydown', handleKeydown);
    return () => {
      document.removeEventListener('keydown', handleKeydown);
    };
  });
</script>

<div class="website">
  
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Company Website</h1>
      <nav class="nav" class:open={isMenuOpen}>
        <button class="menu-toggle" on:click={toggleMenu} aria-label="Toggle menu">
          ☰
        </button>
        <ul class="nav-list">
          <li class="nav-item">
            <a href="#home" class="nav-link" on:click|preventDefault={() => scrollToSection('home')}>
              Home
            </a>
          </li>
          <li class="nav-item">
            <a href="#about" class="nav-link" on:click|preventDefault={() => scrollToSection('about')}>
              About
            </a>
          </li>
          <li class="nav-item">
            <a href="#services" class="nav-link" on:click|preventDefault={() => scrollToSection('services')}>
              Services
            </a>
          </li>
          <li class="nav-item">
            <a href="#portfolio" class="nav-link" on:click|preventDefault={() => scrollToSection('portfolio')}>
              Portfolio
            </a>
          </li>
          <li class="nav-item">
            <a href="#contact" class="nav-link" on:click|preventDefault={() => scrollToSection('contact')}>
              Contact
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </header>
  
  <main class="main-content">
    <section id="home" class="hero-section">
      <div class="hero-content">
        <h2 class="hero-title">Welcome to Our Company</h2>
        <p class="hero-subtitle">We provide innovative solutions for your business needs</p>
        <div class="hero-actions">
          <button class="hero-btn primary" on:click={() => scrollToSection('services')}>
            Our Services
          </button>
          <button class="hero-btn secondary" on:click={() => scrollToSection('contact')}>
            Get in Touch
          </button>
        </div>
      </div>
    </section>
    
    <section id="about" class="about-section">
      <div class="container">
        <h2 class="section-title">About Us</h2>
        <div class="about-content">
          <div class="about-text">
            <p class="about-description">
              We are a leading company in the industry, providing innovative solutions and exceptional service to our clients. 
              With over 10 years of experience, we have built a reputation for excellence and reliability.
            </p>
            <p class="about-description">
              Our team of experts is dedicated to delivering high-quality products and services that meet the unique needs 
              of each client. We believe in building long-term relationships based on trust and mutual success.
            </p>
          </div>
          <div class="about-stats">
            <div class="stat-item">
              <div class="stat-number">500+</div>
              <div class="stat-label">Projects Completed</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">50+</div>
              <div class="stat-label">Happy Clients</div>
            </div>
            <div class="stat-item">
              <div class="stat-number">10+</div>
              <div class="stat-label">Years Experience</div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <section id="services" class="services-section">
      <div class="container">
        <h2 class="section-title">Our Services</h2>
        <div class="services-grid">
          <div class="service-card">
            <div class="service-icon">🚀</div>
            <h3 class="service-title">Web Development</h3>
            <p class="service-description">
              Custom web applications built with modern technologies and best practices.
            </p>
            <button class="service-btn">Learn More</button>
          </div>
          
          <div class="service-card">
            <div class="service-icon">📱</div>
            <h3 class="service-title">Mobile Apps</h3>
            <p class="service-description">
              Native and cross-platform mobile applications for iOS and Android.
            </p>
            <button class="service-btn">Learn More</button>
          </div>
          
          <div class="service-card">
            <div class="service-icon">☁️</div>
            <h3 class="service-title">Cloud Solutions</h3>
            <p class="service-description">
              Scalable cloud infrastructure and migration services for your business.
            </p>
            <button class="service-btn">Learn More</button>
          </div>
          
          <div class="service-card">
            <div class="service-icon">🔒</div>
            <h3 class="service-title">Security</h3>
            <p class="service-description">
              Comprehensive security solutions to protect your data and systems.
            </p>
            <button class="service-btn">Learn More</button>
          </div>
        </div>
      </div>
    </section>
    
    <section id="portfolio" class="portfolio-section">
      <div class="container">
        <h2 class="section-title">Our Portfolio</h2>
        <div class="portfolio-grid">
          <div class="portfolio-item">
            <div class="portfolio-image">🖼️</div>
            <div class="portfolio-content">
              <h3 class="portfolio-title">E-commerce Platform</h3>
              <p class="portfolio-description">
                A comprehensive e-commerce solution with advanced features and analytics.
              </p>
              <button class="portfolio-btn">View Project</button>
            </div>
          </div>
          
          <div class="portfolio-item">
            <div class="portfolio-image">🖼️</div>
            <div class="portfolio-content">
              <h3 class="portfolio-title">Mobile Banking App</h3>
              <p class="portfolio-description">
                Secure mobile banking application with biometric authentication.
              </p>
              <button class="portfolio-btn">View Project</button>
            </div>
          </div>
          
          <div class="portfolio-item">
            <div class="portfolio-image">🖼️</div>
            <div class="portfolio-content">
              <h3 class="portfolio-title">Data Analytics Dashboard</h3>
              <p class="portfolio-description">
                Real-time analytics dashboard with interactive visualizations.
              </p>
              <button class="portfolio-btn">View Project</button>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <section id="contact" class="contact-section">
      <div class="container">
        <h2 class="section-title">Contact Us</h2>
        <div class="contact-content">
          <div class="contact-info">
            <h3 class="contact-title">Get in Touch</h3>
            <p class="contact-description">
              Ready to start your next project? We'd love to hear from you.
            </p>
            <div class="contact-details">
              <div class="contact-item">
                <span class="contact-icon">📧</span>
                <span class="contact-text">info@company.com</span>
              </div>
              <div class="contact-item">
                <span class="contact-icon">📞</span>
                <span class="contact-text">+1 (555) 123-4567</span>
              </div>
              <div class="contact-item">
                <span class="contact-icon">📍</span>
                <span class="contact-text">123 Business St, City, State 12345</span>
              </div>
            </div>
          </div>
          
          <div class="contact-form">
            <form>
              <div class="form-group">
                <label for="name" class="form-label">Name</label>
                <input type="text" id="name" class="form-input" placeholder="Your name" />
              </div>
              <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" class="form-input" placeholder="Your email" />
              </div>
              <div class="form-group">
                <label for="message" class="form-label">Message</label>
                <textarea id="message" class="form-textarea" placeholder="Your message" rows="5"></textarea>
              </div>
              <button type="submit" class="form-btn">Send Message</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  </main>
  
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h4 class="footer-title">Company</h4>
          <ul class="footer-links">
            <li><a href="#" class="footer-link">About Us</a></li>
            <li><a href="#" class="footer-link">Our Team</a></li>
            <li><a href="#" class="footer-link">Careers</a></li>
            <li><a href="#" class="footer-link">News</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Services</h4>
          <ul class="footer-links">
            <li><a href="#" class="footer-link">Web Development</a></li>
            <li><a href="#" class="footer-link">Mobile Apps</a></li>
            <li><a href="#" class="footer-link">Cloud Solutions</a></li>
            <li><a href="#" class="footer-link">Security</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Support</h4>
          <ul class="footer-links">
            <li><a href="#" class="footer-link">Help Center</a></li>
            <li><a href="#" class="footer-link">Documentation</a></li>
            <li><a href="#" class="footer-link">Contact Support</a></li>
            <li><a href="#" class="footer-link">Status</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Legal</h4>
          <ul class="footer-links">
            <li><a href="#" class="footer-link">Privacy Policy</a></li>
            <li><a href="#" class="footer-link">Terms of Service</a></li>
            <li><a href="#" class="footer-link">Cookie Policy</a></li>
            <li><a href="#" class="footer-link">GDPR</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 Company Website. All rights reserved.</p>
      </div>
    </div>
  </footer>
</div>

<style>
  .website {
    min-height: 100vh;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
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
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .nav {
    position: relative;
  }
  
  .menu-toggle {
    display: none;
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    padding: 8px;
  }
  
  .nav-list {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
    gap: 30px;
  }
  
  .nav-item {
    margin: 0;
  }
  
  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
    padding: 8px 0;
  }
  
  .nav-link:hover {
    color: #007bff;
  }
  
  .main-content {
    width: 100%;
  }
  
  .hero-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 100px 0;
    text-align: center;
  }
  
  .hero-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 0 20px;
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
  
  .hero-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
  }
  
  .hero-btn {
    padding: 15px 30px;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .hero-btn.primary {
    background: white;
    color: #667eea;
  }
  
  .hero-btn.primary:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .hero-btn.secondary {
    background: transparent;
    color: white;
    border: 2px solid white;
  }
  
  .hero-btn.secondary:hover {
    background: white;
    color: #667eea;
  }
  
  .about-section {
    padding: 80px 0;
    background: #f8f9fa;
  }
  
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .section-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin: 0 0 50px 0;
  }
  
  .about-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
    align-items: center;
  }
  
  .about-description {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0 0 20px 0;
  }
  
  .about-stats {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
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
    font-size: 14px;
    color: #666;
    text-transform: uppercase;
  }
  
  .services-section {
    padding: 80px 0;
    background: white;
  }
  
  .services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .service-card {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    transition: transform 0.2s;
  }
  
  .service-card:hover {
    transform: translateY(-4px);
  }
  
  .service-icon {
    font-size: 48px;
    margin-bottom: 20px;
  }
  
  .service-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 15px 0;
  }
  
  .service-description {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0 0 20px 0;
  }
  
  .service-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .service-btn:hover {
    background: #0056b3;
  }
  
  .portfolio-section {
    padding: 80px 0;
    background: #f8f9fa;
  }
  
  .portfolio-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .portfolio-item {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.2s;
  }
  
  .portfolio-item:hover {
    transform: translateY(-4px);
  }
  
  .portfolio-image {
    height: 200px;
    background: #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 48px;
  }
  
  .portfolio-content {
    padding: 20px;
  }
  
  .portfolio-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .portfolio-description {
    font-size: 14px;
    color: #666;
    line-height: 1.6;
    margin: 0 0 15px 0;
  }
  
  .portfolio-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .portfolio-btn:hover {
    background: #0056b3;
  }
  
  .contact-section {
    padding: 80px 0;
    background: white;
  }
  
  .contact-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
  }
  
  .contact-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 15px 0;
  }
  
  .contact-description {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0 0 30px 0;
  }
  
  .contact-details {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .contact-item {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .contact-icon {
    font-size: 20px;
  }
  
  .contact-text {
    color: #333;
  }
  
  .contact-form {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 12px;
  }
  
  .form-group {
    margin-bottom: 20px;
  }
  
  .form-label {
    display: block;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
  }
  
  .form-input,
  .form-textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    box-sizing: border-box;
  }
  
  .form-input:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .form-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .form-btn:hover {
    background: #0056b3;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 40px 0 20px 0;
  }
  
  .footer-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 40px;
    margin-bottom: 30px;
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
    padding-top: 20px;
    text-align: center;
    color: #ccc;
  }
  
  @media (max-width: 768px) {
    .menu-toggle {
      display: block;
    }
    
    .nav-list {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      right: 0;
      background: white;
      flex-direction: column;
      padding: 20px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    
    .nav.open .nav-list {
      display: flex;
    }
    
    .about-content {
      grid-template-columns: 1fr;
    }
    
    .contact-content {
      grid-template-columns: 1fr;
    }
    
    .hero-actions {
      flex-direction: column;
      align-items: center;
    }
  }
</style>

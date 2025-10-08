<script>
  import { onMount } from 'svelte';
  
  let currentLanguage = 'en';
  let content = {
    en: {
      title: 'Welcome to Our Website',
      subtitle: 'Discover amazing features and services',
      description: 'This is a sample website with mixed language content to demonstrate accessibility issues.',
      button: 'Learn More',
      footer: 'All rights reserved'
    },
    fr: {
      title: 'Bienvenue sur Notre Site Web',
      subtitle: 'Découvrez des fonctionnalités et services incroyables',
      description: 'Ceci est un site web d\'exemple avec du contenu multilingue pour démontrer les problèmes d\'accessibilité.',
      button: 'En Savoir Plus',
      footer: 'Tous droits réservés'
    }
  };
  
  function switchLanguage() {
    currentLanguage = currentLanguage === 'en' ? 'fr' : 'en';
  }
  
  function handleAction() {
    alert('Action performed!');
  }
</script>


<div class="website">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">MultiLang Site</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={switchLanguage}>
          {currentLanguage === 'en' ? '🇫🇷 Français' : '🇺🇸 English'}
        </button>
        <button class="header-btn" on:click={() => alert('Menu clicked')}>
          ☰ Menu
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <section class="hero">
      <div class="hero-content">
        <h2 class="hero-title">{content[currentLanguage].title}</h2>
        <p class="hero-subtitle">{content[currentLanguage].subtitle}</p>
        <p class="hero-description">{content[currentLanguage].description}</p>
        <button class="cta-button" on:click={handleAction}>
          {content[currentLanguage].button}
        </button>
      </div>
    </section>
    
    <section class="features">
      <div class="features-grid">
        <div class="feature-card">
          <div class="feature-icon">🚀</div>
          <h3 class="feature-title">
            {currentLanguage === 'en' ? 'Fast Performance' : 'Performance Rapide'}
          </h3>
          <p class="feature-description">
            {currentLanguage === 'en' 
              ? 'Our platform delivers lightning-fast performance for all users.' 
              : 'Notre plateforme offre des performances ultra-rapides pour tous les utilisateurs.'
            }
          </p>
        </div>
        
        <div class="feature-card">
          <div class="feature-icon">🔒</div>
          <h3 class="feature-title">
            {currentLanguage === 'en' ? 'Secure & Reliable' : 'Sécurisé et Fiable'}
          </h3>
          <p class="feature-description">
            {currentLanguage === 'en' 
              ? 'Enterprise-grade security with 99.9% uptime guarantee.' 
              : 'Sécurité de niveau entreprise avec une garantie de disponibilité de 99,9%.'
            }
          </p>
        </div>
        
        <div class="feature-card">
          <div class="feature-icon">📱</div>
          <h3 class="feature-title">
            {currentLanguage === 'en' ? 'Mobile Ready' : 'Prêt Mobile'}
          </h3>
          <p class="feature-description">
            {currentLanguage === 'en' 
              ? 'Fully responsive design that works on all devices.' 
              : 'Design entièrement responsive qui fonctionne sur tous les appareils.'
            }
          </p>
        </div>
      </div>
    </section>
    
    <section class="content-section">
      <div class="content-wrapper">
        <h3 class="section-title">
          {currentLanguage === 'en' ? 'About Our Service' : 'À Propos de Notre Service'}
        </h3>
        <div class="content-text">
          <p>
            {currentLanguage === 'en' 
              ? 'We provide comprehensive solutions for businesses of all sizes. Our team of experts is dedicated to delivering exceptional results that exceed expectations.' 
              : 'Nous fournissons des solutions complètes pour les entreprises de toutes tailles. Notre équipe d\'experts se consacre à fournir des résultats exceptionnels qui dépassent les attentes.'
            }
          </p>
          <p>
            {currentLanguage === 'en' 
              ? 'With over 10 years of experience in the industry, we have helped thousands of clients achieve their goals and grow their businesses.' 
              : 'Avec plus de 10 ans d\'expérience dans l\'industrie, nous avons aidé des milliers de clients à atteindre leurs objectifs et à développer leurs entreprises.'
            }
          </p>
        </div>
      </div>
    </section>
    
    <section class="contact-section">
      <div class="contact-wrapper">
        <h3 class="section-title">
          {currentLanguage === 'en' ? 'Get In Touch' : 'Contactez-Nous'}
        </h3>
        <div class="contact-info">
          <div class="contact-item">
            <span class="contact-label">
              {currentLanguage === 'en' ? 'Email:' : 'Email:'}
            </span>
            <span class="contact-value">contact@example.com</span>
          </div>
          <div class="contact-item">
            <span class="contact-label">
              {currentLanguage === 'en' ? 'Phone:' : 'Téléphone:'}
            </span>
            <span class="contact-value">+1 (555) 123-4567</span>
          </div>
          <div class="contact-item">
            <span class="contact-label">
              {currentLanguage === 'en' ? 'Address:' : 'Adresse:'}
            </span>
            <span class="contact-value">
              {currentLanguage === 'en' 
                ? '123 Business St, City, State 12345' 
                : '123 Rue des Affaires, Ville, État 12345'
              }
            </span>
          </div>
        </div>
      </div>
    </section>
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <p>&copy; 2024 MultiLang Site. {content[currentLanguage].footer}.</p>
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
    padding: 0 20px;
  }
  
  .hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 80px 0;
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
    margin: 0 0 20px 0;
    opacity: 0.9;
  }
  
  .hero-description {
    font-size: 18px;
    margin: 0 0 30px 0;
    opacity: 0.8;
    line-height: 1.6;
  }
  
  .cta-button {
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
  
  .cta-button:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .features {
    padding: 80px 0;
  }
  
  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 40px;
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
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 15px 0;
  }
  
  .feature-description {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0;
  }
  
  .content-section {
    padding: 80px 0;
    background: white;
  }
  
  .content-wrapper {
    max-width: 800px;
    margin: 0 auto;
    text-align: center;
  }
  
  .section-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 30px 0;
  }
  
  .content-text {
    font-size: 18px;
    color: #666;
    line-height: 1.8;
  }
  
  .content-text p {
    margin: 0 0 20px 0;
  }
  
  .contact-section {
    padding: 80px 0;
    background: #f8f9fa;
  }
  
  .contact-wrapper {
    max-width: 600px;
    margin: 0 auto;
    text-align: center;
  }
  
  .contact-info {
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 30px;
  }
  
  .contact-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .contact-label {
    font-weight: bold;
    color: #333;
  }
  
  .contact-value {
    color: #666;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 30px 0;
    text-align: center;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
</style>

import { useState } from 'react';

export default function MissingLanguageAttribute() {
  const [selectedLanguage, setSelectedLanguage] = useState('en');
  const [currentPage, setCurrentPage] = useState('home');
  const [user] = useState({
    name: 'Jean Dupont',
    email: 'jean.dupont@email.com',
    preferences: {
      language: 'fr',
      theme: 'light',
      notifications: true
    }
  });

  const languages = [
    { code: 'en', name: 'English', flag: '🇺🇸' },
    { code: 'fr', name: 'Français', flag: '🇫🇷' },
    { code: 'es', name: 'Español', flag: '🇪🇸' },
    { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
    { code: 'it', name: 'Italiano', flag: '🇮🇹' }
  ];

  const content = {
    en: {
      title: 'Welcome to Our Platform',
      subtitle: 'Your gateway to digital excellence',
      description: 'Discover amazing features and connect with users worldwide.',
      features: {
        title: 'Key Features',
        items: [
          'Advanced Analytics',
          'Real-time Collaboration',
          'Secure Data Storage',
          'Mobile Responsive Design'
        ]
      },
      navigation: {
        home: 'Home',
        about: 'About',
        services: 'Services',
        contact: 'Contact'
      },
      buttons: {
        getStarted: 'Get Started',
        learnMore: 'Learn More',
        contactUs: 'Contact Us'
      }
    },
    fr: {
      title: 'Bienvenue sur Notre Plateforme',
      subtitle: 'Votre passerelle vers l\'excellence numérique',
      description: 'Découvrez des fonctionnalités incroyables et connectez-vous avec des utilisateurs du monde entier.',
      features: {
        title: 'Fonctionnalités Clés',
        items: [
          'Analyses Avancées',
          'Collaboration en Temps Réel',
          'Stockage de Données Sécurisé',
          'Design Responsive Mobile'
        ]
      },
      navigation: {
        home: 'Accueil',
        about: 'À Propos',
        services: 'Services',
        contact: 'Contact'
      },
      buttons: {
        getStarted: 'Commencer',
        learnMore: 'En Savoir Plus',
        contactUs: 'Nous Contacter'
      }
    },
    es: {
      title: 'Bienvenido a Nuestra Plataforma',
      subtitle: 'Tu puerta de entrada a la excelencia digital',
      description: 'Descubre características increíbles y conéctate con usuarios de todo el mundo.',
      features: {
        title: 'Características Clave',
        items: [
          'Análisis Avanzados',
          'Colaboración en Tiempo Real',
          'Almacenamiento Seguro de Datos',
          'Diseño Responsivo Móvil'
        ]
      },
      navigation: {
        home: 'Inicio',
        about: 'Acerca de',
        services: 'Servicios',
        contact: 'Contacto'
      },
      buttons: {
        getStarted: 'Comenzar',
        learnMore: 'Saber Más',
        contactUs: 'Contáctanos'
      }
    }
  };

  const currentContent = content[selectedLanguage] || content.en;

  const changeLanguage = (langCode) => {
    setSelectedLanguage(langCode);
  };

  const navigateTo = (page) => {
    setCurrentPage(page);
  };

  const handleAction = (action) => {
    alert(`${action} action performed in ${languages.find(l => l.code === selectedLanguage)?.name}`);
  };

  return (
    <div className="multilingual-app">
      <header className="app-header">
        <div className="header-content">
          <div className="logo-section">
            <h1 className="app-title">{currentContent.title}</h1>
            <p className="app-subtitle">{currentContent.subtitle}</p>
          </div>
          
          <div className="header-controls">
            <div className="language-selector">
              <label htmlFor="language-select">Language:</label>
              <select 
                id="language-select" 
                value={selectedLanguage} 
                onChange={(e) => changeLanguage(e.target.value)}
                className="language-dropdown"
              >
                {languages.map(lang => (
                  <option key={lang.code} value={lang.code}>
                    {lang.flag} {lang.name}
                  </option>
                ))}
              </select>
            </div>
            
            <div className="user-info">
              <span className="user-name">{user.name}</span>
              <button className="user-menu-btn">👤</button>
            </div>
          </div>
        </div>

        <nav className="main-navigation">
          <ul className="nav-list">
            <li className="nav-item">
              <button 
                className={`nav-link ${currentPage === 'home' ? 'active' : ''}`}
                onClick={() => navigateTo('home')}
              >
                {currentContent.navigation.home}
              </button>
            </li>
            <li className="nav-item">
              <button 
                className={`nav-link ${currentPage === 'about' ? 'active' : ''}`}
                onClick={() => navigateTo('about')}
              >
                {currentContent.navigation.about}
              </button>
            </li>
            <li className="nav-item">
              <button 
                className={`nav-link ${currentPage === 'services' ? 'active' : ''}`}
                onClick={() => navigateTo('services')}
              >
                {currentContent.navigation.services}
              </button>
            </li>
            <li className="nav-item">
              <button 
                className={`nav-link ${currentPage === 'contact' ? 'active' : ''}`}
                onClick={() => navigateTo('contact')}
              >
                {currentContent.navigation.contact}
              </button>
            </li>
          </ul>
        </nav>
      </header>

      <main className="app-main">
        <div className="hero-section">
          <div className="hero-content">
            <h2 className="hero-title">{currentContent.title}</h2>
            <p className="hero-description">{currentContent.description}</p>
            
            <div className="hero-actions">
              <button 
                className="cta-button primary" 
                onClick={() => handleAction('Get Started')}
              >
                {currentContent.buttons.getStarted}
              </button>
              <button 
                className="cta-button secondary" 
                onClick={() => handleAction('Learn More')}
              >
                {currentContent.buttons.learnMore}
              </button>
            </div>
          </div>
          
          <div className="hero-image">
            <div className="image-placeholder">
              <h3>Platform Preview</h3>
              <p>Interactive dashboard and features</p>
            </div>
          </div>
        </div>

        <section className="features-section">
          <h3 className="section-title">{currentContent.features.title}</h3>
          
          <div className="features-grid">
            {currentContent.features.items.map((feature, index) => (
              <div key={index} className="feature-card">
                <div className="feature-icon">
                  {index === 0 && '📊'}
                  {index === 1 && '🤝'}
                  {index === 2 && '🔒'}
                  {index === 3 && '📱'}
                </div>
                <h4 className="feature-title">{feature}</h4>
                <p className="feature-description">
                  {selectedLanguage === 'en' && 'Comprehensive solution for your business needs.'}
                  {selectedLanguage === 'fr' && 'Solution complète pour vos besoins commerciaux.'}
                  {selectedLanguage === 'es' && 'Solución integral para las necesidades de su negocio.'}
                </p>
              </div>
            ))}
          </div>
        </section>

        <section className="content-section">
          <div className="content-tabs">
            <button 
              className={`tab-button ${currentPage === 'home' ? 'active' : ''}`}
              onClick={() => navigateTo('home')}
            >
              {currentContent.navigation.home}
            </button>
            <button 
              className={`tab-button ${currentPage === 'about' ? 'active' : ''}`}
              onClick={() => navigateTo('about')}
            >
              {currentContent.navigation.about}
            </button>
            <button 
              className={`tab-button ${currentPage === 'services' ? 'active' : ''}`}
              onClick={() => navigateTo('services')}
            >
              {currentContent.navigation.services}
            </button>
          </div>

          <div className="tab-content">
            {currentPage === 'home' && (
              <div className="tab-panel">
                <h4>Dashboard Overview</h4>
                <p>Welcome to your personalized dashboard. Here you can manage all your activities and monitor your progress.</p>
                <div className="dashboard-stats">
                  <div className="stat-item">
                    <span className="stat-number">1,247</span>
                    <span className="stat-label">Active Users</span>
                  </div>
                  <div className="stat-item">
                    <span className="stat-number">89%</span>
                    <span className="stat-label">Satisfaction Rate</span>
                  </div>
                  <div className="stat-item">
                    <span className="stat-number">24/7</span>
                    <span className="stat-label">Support Available</span>
                  </div>
                </div>
              </div>
            )}
            {currentPage === 'about' && (
              <div className="tab-panel">
                <h4>About Our Company</h4>
                <p>We are a leading technology company dedicated to providing innovative solutions for businesses worldwide.</p>
                <ul className="about-list">
                  <li>Founded in 2010</li>
                  <li>500+ employees globally</li>
                  <li>Serving 10,000+ clients</li>
                  <li>ISO 27001 certified</li>
                </ul>
              </div>
            )}
            {currentPage === 'services' && (
              <div className="tab-panel">
                <h4>Our Services</h4>
                <p>We offer a comprehensive range of services to help your business grow and succeed.</p>
                <div className="services-list">
                  <div className="service-item">Web Development</div>
                  <div className="service-item">Mobile Applications</div>
                  <div className="service-item">Cloud Solutions</div>
                  <div className="service-item">Data Analytics</div>
                </div>
              </div>
            )}
          </div>
        </section>
      </main>

      <footer className="app-footer">
        <div className="footer-content">
          <div className="footer-section">
            <h5>Company</h5>
            <ul>
              <li>About Us</li>
              <li>Careers</li>
              <li>Press</li>
              <li>Blog</li>
            </ul>
          </div>
          
          <div className="footer-section">
            <h5>Support</h5>
            <ul>
              <li>Help Center</li>
              <li>Documentation</li>
              <li>API Reference</li>
              <li>Status</li>
            </ul>
          </div>
          
          <div className="footer-section">
            <h5>Legal</h5>
            <ul>
              <li>Privacy Policy</li>
              <li>Terms of Service</li>
              <li>Cookie Policy</li>
              <li>GDPR</li>
            </ul>
          </div>
          
          <div className="footer-section">
            <h5>Connect</h5>
            <div className="social-links">
              <button className="social-btn">📘</button>
              <button className="social-btn">🐦</button>
              <button className="social-btn">💼</button>
              <button className="social-btn">📷</button>
            </div>
          </div>
        </div>
        
        <div className="footer-bottom">
          <p>&copy; 2024 Our Platform. All rights reserved.</p>
          <button 
            className="contact-btn" 
            onClick={() => handleAction('Contact Us')}
          >
            {currentContent.buttons.contactUs}
          </button>
        </div>
      </footer>

      <style jsx>{`
        .multilingual-app {
          min-height: 100vh;
          font-family: Arial, sans-serif;
          background: #f8f9fa;
        }

        .app-header {
          background: white;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 20px 30px;
        }

        .logo-section h1 {
          margin: 0 0 5px 0;
          font-size: 28px;
          color: #333;
        }

        .logo-section p {
          margin: 0;
          color: #666;
          font-size: 14px;
        }

        .header-controls {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .language-selector {
          display: flex;
          align-items: center;
          gap: 8px;
        }

        .language-selector label {
          font-size: 14px;
          color: #666;
        }

        .language-dropdown {
          padding: 6px 10px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
        }

        .user-info {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .user-name {
          font-size: 14px;
          color: #333;
        }

        .user-menu-btn {
          background: none;
          border: none;
          font-size: 18px;
          cursor: pointer;
          padding: 5px;
        }

        .main-navigation {
          background: #f8f9fa;
          border-top: 1px solid #eee;
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
          cursor: pointer;
          font-size: 16px;
          color: #666;
          transition: background-color 0.2s ease, color 0.2s ease;
        }

        .nav-link:hover {
          background: #e9ecef;
          color: #333;
        }

        .nav-link.active {
          background: #007bff;
          color: white;
        }

        .app-main {
          max-width: 1200px;
          margin: 0 auto;
          padding: 40px 20px;
        }

        .hero-section {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 40px;
          align-items: center;
          margin-bottom: 60px;
        }

        .hero-content h2 {
          margin: 0 0 15px 0;
          font-size: 36px;
          color: #333;
          line-height: 1.2;
        }

        .hero-description {
          margin: 0 0 30px 0;
          font-size: 18px;
          color: #666;
          line-height: 1.5;
        }

        .hero-actions {
          display: flex;
          gap: 15px;
        }

        .cta-button {
          padding: 12px 24px;
          border: none;
          border-radius: 6px;
          font-size: 16px;
          font-weight: bold;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .cta-button.primary {
          background: #007bff;
          color: white;
        }

        .cta-button.primary:hover {
          background: #0056b3;
        }

        .cta-button.secondary {
          background: #6c757d;
          color: white;
        }

        .cta-button.secondary:hover {
          background: #545b62;
        }

        .hero-image {
          display: flex;
          justify-content: center;
          align-items: center;
        }

        .image-placeholder {
          width: 100%;
          height: 300px;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          border-radius: 8px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          color: white;
          text-align: center;
        }

        .image-placeholder h3 {
          margin: 0 0 10px 0;
          font-size: 24px;
        }

        .image-placeholder p {
          margin: 0;
          font-size: 16px;
          opacity: 0.9;
        }

        .features-section {
          margin-bottom: 60px;
        }

        .section-title {
          text-align: center;
          margin: 0 0 40px 0;
          font-size: 28px;
          color: #333;
        }

        .features-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 30px;
        }

        .feature-card {
          background: white;
          padding: 30px;
          border-radius: 8px;
          text-align: center;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          transition: transform 0.2s ease;
        }

        .feature-card:hover {
          transform: translateY(-5px);
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

        .content-section {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          overflow: hidden;
        }

        .content-tabs {
          display: flex;
          border-bottom: 1px solid #eee;
        }

        .tab-button {
          flex: 1;
          padding: 15px 20px;
          background: none;
          border: none;
          cursor: pointer;
          font-size: 16px;
          color: #666;
          transition: background-color 0.2s ease, color 0.2s ease;
        }

        .tab-button:hover {
          background: #f8f9fa;
          color: #333;
        }

        .tab-button.active {
          background: #007bff;
          color: white;
        }

        .tab-content {
          padding: 30px;
        }

        .tab-panel h4 {
          margin: 0 0 15px 0;
          font-size: 20px;
          color: #333;
        }

        .tab-panel p {
          margin: 0 0 20px 0;
          color: #666;
          line-height: 1.5;
        }

        .dashboard-stats {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
          gap: 20px;
          margin-top: 20px;
        }

        .stat-item {
          text-align: center;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 6px;
        }

        .stat-number {
          display: block;
          font-size: 24px;
          font-weight: bold;
          color: #007bff;
          margin-bottom: 5px;
        }

        .stat-label {
          font-size: 14px;
          color: #666;
        }

        .about-list {
          margin: 0;
          padding-left: 20px;
          color: #666;
        }

        .about-list li {
          margin-bottom: 8px;
        }

        .services-list {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 15px;
          margin-top: 20px;
        }

        .service-item {
          padding: 15px;
          background: #f8f9fa;
          border-radius: 6px;
          text-align: center;
          color: #333;
          font-weight: bold;
        }

        .app-footer {
          background: #333;
          color: white;
          margin-top: 60px;
        }

        .footer-content {
          max-width: 1200px;
          margin: 0 auto;
          padding: 40px 20px;
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 30px;
        }

        .footer-section h5 {
          margin: 0 0 15px 0;
          font-size: 16px;
        }

        .footer-section ul {
          list-style: none;
          margin: 0;
          padding: 0;
        }

        .footer-section li {
          margin-bottom: 8px;
          color: #ccc;
          cursor: pointer;
        }

        .footer-section li:hover {
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

        .footer-bottom {
          border-top: 1px solid #555;
          padding: 20px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          max-width: 1200px;
          margin: 0 auto;
        }

        .footer-bottom p {
          margin: 0;
          color: #ccc;
        }

        .contact-btn {
          background: #007bff;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
        }

        .contact-btn:hover {
          background: #0056b3;
        }

        @media (max-width: 768px) {
          .header-content {
            flex-direction: column;
            gap: 20px;
          }

          .hero-section {
            grid-template-columns: 1fr;
            text-align: center;
          }

          .hero-content {
            margin-bottom: 30px;
          }

          .footer-bottom {
            flex-direction: column;
            text-align: center;
            gap: 20px;
          }
        }
      `}</style>
    </div>
  );
}

import { useState, useEffect } from 'react';

export default function AutoPlayingBackgroundVideo() {
  const [isPlaying, setIsPlaying] = useState(true);
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [isScrolled, setIsScrolled] = useState(false);

  const slides = [
    {
      id: 1,
      title: 'Revolutionary Technology',
      subtitle: 'Experience the future today',
      description: 'Discover cutting-edge solutions that transform how you work and live',
      videoUrl: '/api/placeholder/1920/1080',
      ctaText: 'Explore Now',
      ctaLink: '/technology'
    },
    {
      id: 2,
      title: 'Innovation at Scale',
      subtitle: 'Building tomorrow\'s world',
      description: 'Join thousands of companies already using our platform',
      videoUrl: '/api/placeholder/1920/1080',
      ctaText: 'Get Started',
      ctaLink: '/get-started'
    },
    {
      id: 3,
      title: 'Global Impact',
      subtitle: 'Making a difference worldwide',
      description: 'See how we\'re changing lives across the globe',
      videoUrl: '/api/placeholder/1920/1080',
      ctaText: 'Learn More',
      ctaLink: '/impact'
    }
  ];

  const navigationItems = [
    { name: 'Products', href: '/products' },
    { name: 'Solutions', href: '/solutions' },
    { name: 'Resources', href: '/resources' },
    { name: 'Company', href: '/company' },
    { name: 'Contact', href: '/contact' }
  ];

  const features = [
    {
      icon: '⚡',
      title: 'Lightning Fast',
      description: 'Optimized for speed and performance'
    },
    {
      icon: '🔒',
      title: 'Secure',
      description: 'Enterprise-grade security features'
    },
    {
      icon: '📱',
      title: 'Mobile Ready',
      description: 'Works seamlessly on all devices'
    },
    {
      icon: '🌍',
      title: 'Global',
      description: 'Available worldwide with local support'
    }
  ];

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentSlide((prev) => (prev + 1) % slides.length);
    }, 5000);

    return () => clearInterval(interval);
  }, [slides.length]);

  const handleVideoToggle = () => {
    setIsPlaying(!isPlaying);
  };

  const handleSlideChange = (index) => {
    setCurrentSlide(index);
  };

  const handleSearch = (e) => {
    e.preventDefault();
    alert(`Searching for: ${searchTerm}`);
  };

  const currentSlideData = slides[currentSlide];

  return (
    <div className="hero-section">
      <header className={`main-header ${isScrolled ? 'scrolled' : ''}`}>
        <div className="header-container">
          <div className="logo">
            <h1>TechVision</h1>
          </div>

          <nav className={`main-nav ${isMenuOpen ? 'open' : ''}`}>
            <ul className="nav-list">
              {navigationItems.map((item, index) => (
                <li key={index} className="nav-item">
                  <a href={item.href} className="nav-link">
                    {item.name}
                  </a>
                </li>
              ))}
            </ul>
          </nav>

          <div className="header-actions">
            <div className={`search-container ${isSearchOpen ? 'open' : ''}`}>
              <form onSubmit={handleSearch} className="search-form">
                <input
                  type="text"
                  placeholder="Search..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="search-input"
                />
                <button type="submit" className="search-btn">
                  🔍
                </button>
              </form>
            </div>

            <button 
              className="menu-toggle"
              onClick={() => setIsMenuOpen(!isMenuOpen)}
            >
              ☰
            </button>
          </div>
        </div>
      </header>

      <div className="hero-content">
        <div className="hero-video-container">
          <video
            className="hero-video"
            autoPlay
            muted
            loop
            playsInline
            poster={currentSlideData.videoUrl}
          >
            <source src={currentSlideData.videoUrl} type="video/mp4" />
          </video>

          <div className="video-overlay">
            <div className="video-controls">
              <button 
                className="play-pause-btn"
                onClick={handleVideoToggle}
              >
                {isPlaying ? '⏸️' : '▶️'}
              </button>
            </div>
          </div>
        </div>

        <div className="hero-text">
          <div className="hero-badge">
            <span className="badge-text">New Release</span>
          </div>

          <h2 className="hero-title">
            {currentSlideData.title}
          </h2>

          <h3 className="hero-subtitle">
            {currentSlideData.subtitle}
          </h3>

          <p className="hero-description">
            {currentSlideData.description}
          </p>

          <div className="hero-actions">
            <a 
              href={currentSlideData.ctaLink} 
              className="cta-button primary"
            >
              {currentSlideData.ctaText}
            </a>
            <a 
              href="/demo" 
              className="cta-button secondary"
            >
              Watch Demo
            </a>
          </div>
        </div>

        <div className="slide-indicators">
          {slides.map((_, index) => (
            <button
              key={index}
              className={`indicator ${index === currentSlide ? 'active' : ''}`}
              onClick={() => handleSlideChange(index)}
            />
          ))}
        </div>
      </div>

      <div className="features-section">
        <div className="features-container">
          <h3 className="features-title">Why Choose Us</h3>
          <div className="features-grid">
            {features.map((feature, index) => (
              <div key={index} className="feature-card">
                <div className="feature-icon">{feature.icon}</div>
                <h4 className="feature-title">{feature.title}</h4>
                <p className="feature-description">{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="stats-section">
        <div className="stats-container">
          <div className="stat-item">
            <div className="stat-number">10M+</div>
            <div className="stat-label">Active Users</div>
          </div>
          <div className="stat-item">
            <div className="stat-number">99.9%</div>
            <div className="stat-label">Uptime</div>
          </div>
          <div className="stat-item">
            <div className="stat-number">150+</div>
            <div className="stat-label">Countries</div>
          </div>
          <div className="stat-item">
            <div className="stat-number">24/7</div>
            <div className="stat-label">Support</div>
          </div>
        </div>
      </div>

      <footer className="main-footer">
        <div className="footer-container">
          <div className="footer-content">
            <div className="footer-section">
              <h4>Company</h4>
              <ul>
                <li><a href="/about">About Us</a></li>
                <li><a href="/careers">Careers</a></li>
                <li><a href="/press">Press</a></li>
                <li><a href="/blog">Blog</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Products</h4>
              <ul>
                <li><a href="/features">Features</a></li>
                <li><a href="/pricing">Pricing</a></li>
                <li><a href="/integrations">Integrations</a></li>
                <li><a href="/api">API</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Support</h4>
              <ul>
                <li><a href="/help">Help Center</a></li>
                <li><a href="/contact">Contact</a></li>
                <li><a href="/status">Status</a></li>
                <li><a href="/community">Community</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Legal</h4>
              <ul>
                <li><a href="/privacy">Privacy</a></li>
                <li><a href="/terms">Terms</a></li>
                <li><a href="/cookies">Cookies</a></li>
                <li><a href="/security">Security</a></li>
              </ul>
            </div>
          </div>
          <div className="footer-bottom">
            <p>&copy; 2024 TechVision. All rights reserved.</p>
          </div>
        </div>
      </footer>

      <style jsx>{`
        .hero-section {
          position: relative;
          min-height: 100vh;
          overflow: hidden;
        }

        .main-header {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          z-index: 1000;
          background: rgba(255, 255, 255, 0.95);
          backdrop-filter: blur(10px);
          transition: all 0.3s ease;
        }

        .main-header.scrolled {
          background: rgba(255, 255, 255, 0.98);
          box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .header-container {
          max-width: 1200px;
          margin: 0 auto;
          padding: 0 20px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          height: 70px;
        }

        .logo h1 {
          margin: 0;
          font-size: 24px;
          font-weight: bold;
          color: #333;
        }

        .main-nav {
          display: flex;
          align-items: center;
        }

        .nav-list {
          display: flex;
          list-style: none;
          margin: 0;
          padding: 0;
          gap: 30px;
        }

        .nav-link {
          text-decoration: none;
          color: #333;
          font-weight: 500;
          transition: color 0.2s ease;
        }

        .nav-link:hover {
          color: #007bff;
        }

        .header-actions {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .search-container {
          position: relative;
        }

        .search-form {
          display: flex;
          align-items: center;
        }

        .search-input {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 20px;
          width: 200px;
          transition: width 0.3s ease;
        }

        .search-container.open .search-input {
          width: 300px;
        }

        .search-btn {
          background: none;
          border: none;
          cursor: pointer;
          font-size: 16px;
          margin-left: 5px;
        }

        .menu-toggle {
          display: none;
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
        }

        .hero-content {
          position: relative;
          height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .hero-video-container {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          z-index: -1;
        }

        .hero-video {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .video-overlay {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: linear-gradient(
            45deg,
            rgba(0,0,0,0.7) 0%,
            rgba(0,0,0,0.3) 50%,
            rgba(0,0,0,0.7) 100%
          );
        }

        .video-controls {
          position: absolute;
          bottom: 30px;
          right: 30px;
        }

        .play-pause-btn {
          background: rgba(255, 255, 255, 0.9);
          border: none;
          border-radius: 50%;
          width: 50px;
          height: 50px;
          cursor: pointer;
          font-size: 20px;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .hero-text {
          text-align: center;
          color: white;
          max-width: 800px;
          padding: 0 20px;
          z-index: 10;
        }

        .hero-badge {
          display: inline-block;
          background: rgba(0, 123, 255, 0.9);
          color: white;
          padding: 8px 16px;
          border-radius: 20px;
          font-size: 14px;
          font-weight: bold;
          margin-bottom: 20px;
        }

        .hero-title {
          font-size: 48px;
          font-weight: bold;
          margin: 0 0 20px 0;
          line-height: 1.2;
        }

        .hero-subtitle {
          font-size: 24px;
          margin: 0 0 20px 0;
          opacity: 0.9;
        }

        .hero-description {
          font-size: 18px;
          margin: 0 0 40px 0;
          opacity: 0.8;
          line-height: 1.6;
        }

        .hero-actions {
          display: flex;
          gap: 20px;
          justify-content: center;
          flex-wrap: wrap;
        }

        .cta-button {
          display: inline-block;
          padding: 15px 30px;
          border-radius: 30px;
          text-decoration: none;
          font-weight: bold;
          font-size: 16px;
          transition: all 0.3s ease;
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
          color: white;
          border: 2px solid white;
        }

        .cta-button.secondary:hover {
          background: white;
          color: #333;
        }

        .slide-indicators {
          position: absolute;
          bottom: 50px;
          left: 50%;
          transform: translateX(-50%);
          display: flex;
          gap: 10px;
        }

        .indicator {
          width: 12px;
          height: 12px;
          border-radius: 50%;
          border: 2px solid white;
          background: transparent;
          cursor: pointer;
          transition: all 0.3s ease;
        }

        .indicator.active {
          background: white;
        }

        .features-section {
          padding: 80px 20px;
          background: #f8f9fa;
        }

        .features-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .features-title {
          text-align: center;
          font-size: 36px;
          margin-bottom: 60px;
          color: #333;
        }

        .features-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 40px;
        }

        .feature-card {
          text-align: center;
          padding: 30px;
          background: white;
          border-radius: 8px;
          box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .feature-icon {
          font-size: 48px;
          margin-bottom: 20px;
        }

        .feature-title {
          font-size: 20px;
          margin-bottom: 15px;
          color: #333;
        }

        .feature-description {
          color: #666;
          line-height: 1.6;
        }

        .stats-section {
          padding: 60px 20px;
          background: #007bff;
          color: white;
        }

        .stats-container {
          max-width: 1200px;
          margin: 0 auto;
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 40px;
        }

        .stat-item {
          text-align: center;
        }

        .stat-number {
          font-size: 48px;
          font-weight: bold;
          margin-bottom: 10px;
        }

        .stat-label {
          font-size: 16px;
          opacity: 0.9;
        }

        .main-footer {
          background: #333;
          color: white;
          padding: 60px 20px 20px;
        }

        .footer-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .footer-content {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 40px;
          margin-bottom: 40px;
        }

        .footer-section h4 {
          margin-bottom: 20px;
          color: white;
        }

        .footer-section ul {
          list-style: none;
          padding: 0;
          margin: 0;
        }

        .footer-section li {
          margin-bottom: 10px;
        }

        .footer-section a {
          color: #ccc;
          text-decoration: none;
          transition: color 0.2s ease;
        }

        .footer-section a:hover {
          color: white;
        }

        .footer-bottom {
          text-align: center;
          padding-top: 20px;
          border-top: 1px solid #555;
          color: #ccc;
        }

        @media (max-width: 768px) {
          .main-nav {
            display: none;
          }

          .menu-toggle {
            display: block;
          }

          .hero-title {
            font-size: 36px;
          }

          .hero-subtitle {
            font-size: 20px;
          }

          .hero-actions {
            flex-direction: column;
            align-items: center;
          }

          .cta-button {
            width: 100%;
            max-width: 300px;
          }
        }
      `}</style>
    </div>
  );
}

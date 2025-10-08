<template>
  <div class="landing-page">
    <div class="hero-section">
      <div class="video-background">
        <video
          autoplay
          muted
          loop
          playsinline
          class="background-video"
        >
          <source src="/api/video/hero-background.mp4" type="video/mp4" />
          <source src="/api/video/hero-background.webm" type="video/webm" />
        </video>
        <div class="video-overlay"></div>
      </div>
      
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">Transform Your Business</h1>
          <p class="hero-subtitle">
            Discover innovative solutions that drive growth and efficiency
          </p>
          <div class="hero-actions">
            <button class="cta-button primary">Get Started</button>
            <button class="cta-button secondary">Watch Demo</button>
          </div>
        </div>
        
        <div class="hero-stats">
          <div class="stat-item">
            <div class="stat-number">10,000+</div>
            <div class="stat-label">Happy Customers</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">99.9%</div>
            <div class="stat-label">Uptime</div>
          </div>
          <div class="stat-item">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Support</div>
          </div>
        </div>
      </div>
    </div>

    <div class="features-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">Why Choose Us</h2>
          <p class="section-description">
            We provide cutting-edge solutions that help businesses thrive in the digital age
          </p>
        </div>
        
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">
              <img src="/api/placeholder/60/60" alt="Innovation" />
            </div>
            <h3 class="feature-title">Innovation</h3>
            <p class="feature-description">
              Stay ahead with our latest technology and innovative approaches to problem-solving.
            </p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">
              <img src="/api/placeholder/60/60" alt="Reliability" />
            </div>
            <h3 class="feature-title">Reliability</h3>
            <p class="feature-description">
              Count on our robust infrastructure and proven track record of delivering results.
            </p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">
              <img src="/api/placeholder/60/60" alt="Security" />
            </div>
            <h3 class="feature-title">Security</h3>
            <p class="feature-description">
              Your data is protected with enterprise-grade security measures and compliance standards.
            </p>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">
              <img src="/api/placeholder/60/60" alt="Support" />
            </div>
            <h3 class="feature-title">Support</h3>
            <p class="feature-description">
              Get help when you need it with our dedicated support team and comprehensive resources.
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="testimonials-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">What Our Customers Say</h2>
          <p class="section-description">
            Don't just take our word for it - hear from our satisfied customers
          </p>
        </div>
        
        <div class="testimonials-grid">
          <div class="testimonial-card">
            <div class="testimonial-content">
              <div class="quote-icon">"</div>
              <p class="testimonial-text">
                This platform has revolutionized how we manage our operations. The results speak for themselves.
              </p>
            </div>
            <div class="testimonial-author">
              <img src="/api/placeholder/50/50" alt="Sarah Johnson" class="author-image" />
              <div class="author-info">
                <div class="author-name">Sarah Johnson</div>
                <div class="author-title">CEO, TechCorp</div>
              </div>
            </div>
          </div>
          
          <div class="testimonial-card">
            <div class="testimonial-content">
              <div class="quote-icon">"</div>
              <p class="testimonial-text">
                Outstanding service and support. Our team productivity has increased by 40% since implementation.
              </p>
            </div>
            <div class="testimonial-author">
              <img src="/api/placeholder/50/50" alt="Mike Chen" class="author-image" />
              <div class="author-info">
                <div class="author-name">Mike Chen</div>
                <div class="author-title">CTO, InnovateLab</div>
              </div>
            </div>
          </div>
          
          <div class="testimonial-card">
            <div class="testimonial-content">
              <div class="quote-icon">"</div>
              <p class="testimonial-text">
                The best investment we've made for our business. Highly recommend to anyone looking to scale.
              </p>
            </div>
            <div class="testimonial-author">
              <img src="/api/placeholder/50/50" alt="Emma Davis" class="author-image" />
              <div class="author-info">
                <div class="author-name">Emma Davis</div>
                <div class="author-title">Founder, StartupXYZ</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="pricing-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">Choose Your Plan</h2>
          <p class="section-description">
            Flexible pricing options to fit your business needs
          </p>
        </div>
        
        <div class="pricing-grid">
          <div class="pricing-card">
            <div class="plan-header">
              <h3 class="plan-name">Starter</h3>
              <div class="plan-price">
                <span class="currency">$</span>
                <span class="amount">29</span>
                <span class="period">/month</span>
              </div>
            </div>
            <div class="plan-features">
              <ul class="features-list">
                <li>Up to 5 users</li>
                <li>10GB storage</li>
                <li>Basic support</li>
                <li>Standard features</li>
              </ul>
            </div>
            <button class="plan-button">Get Started</button>
          </div>
          
          <div class="pricing-card featured">
            <div class="plan-badge">Most Popular</div>
            <div class="plan-header">
              <h3 class="plan-name">Professional</h3>
              <div class="plan-price">
                <span class="currency">$</span>
                <span class="amount">79</span>
                <span class="period">/month</span>
              </div>
            </div>
            <div class="plan-features">
              <ul class="features-list">
                <li>Up to 25 users</li>
                <li>100GB storage</li>
                <li>Priority support</li>
                <li>Advanced features</li>
                <li>API access</li>
              </ul>
            </div>
            <button class="plan-button">Get Started</button>
          </div>
          
          <div class="pricing-card">
            <div class="plan-header">
              <h3 class="plan-name">Enterprise</h3>
              <div class="plan-price">
                <span class="currency">$</span>
                <span class="amount">199</span>
                <span class="period">/month</span>
              </div>
            </div>
            <div class="plan-features">
              <ul class="features-list">
                <li>Unlimited users</li>
                <li>Unlimited storage</li>
                <li>24/7 support</li>
                <li>All features</li>
                <li>Custom integrations</li>
                <li>Dedicated manager</li>
              </ul>
            </div>
            <button class="plan-button">Contact Sales</button>
          </div>
        </div>
      </div>
    </div>

    <div class="cta-section">
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">Ready to Get Started?</h2>
          <p class="cta-description">
            Join thousands of businesses that trust us with their success
          </p>
          <div class="cta-actions">
            <button class="cta-button primary large">Start Free Trial</button>
            <button class="cta-button secondary large">Schedule Demo</button>
          </div>
        </div>
      </div>
    </div>

    <footer class="site-footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-section">
            <h4 class="footer-title">Product</h4>
            <ul class="footer-links">
              <li><a href="/features">Features</a></li>
              <li><a href="/pricing">Pricing</a></li>
              <li><a href="/integrations">Integrations</a></li>
              <li><a href="/api">API</a></li>
            </ul>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">Company</h4>
            <ul class="footer-links">
              <li><a href="/about">About Us</a></li>
              <li><a href="/careers">Careers</a></li>
              <li><a href="/blog">Blog</a></li>
              <li><a href="/press">Press</a></li>
            </ul>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">Support</h4>
            <ul class="footer-links">
              <li><a href="/help">Help Center</a></li>
              <li><a href="/contact">Contact</a></li>
              <li><a href="/status">Status</a></li>
              <li><a href="/security">Security</a></li>
            </ul>
          </div>
          
          <div class="footer-section">
            <h4 class="footer-title">Connect</h4>
            <ul class="footer-links">
              <li><a href="/twitter">Twitter</a></li>
              <li><a href="/linkedin">LinkedIn</a></li>
              <li><a href="/github">GitHub</a></li>
              <li><a href="/youtube">YouTube</a></li>
            </ul>
          </div>
        </div>
        
        <div class="footer-bottom">
          <p>&copy; 2024 Company Name. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
// No JavaScript needed for this component
</script>

<style scoped>
.landing-page {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
}

.hero-section {
  position: relative;
  height: 100vh;
  min-height: 600px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.video-background {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.background-video {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.video-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    135deg,
    rgba(0, 0, 0, 0.7) 0%,
    rgba(0, 0, 0, 0.3) 50%,
    rgba(0, 0, 0, 0.7) 100%
  );
  z-index: 2;
}

.hero-content {
  position: relative;
  z-index: 3;
  text-align: center;
  color: white;
  max-width: 800px;
  padding: 0 20px;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: bold;
  margin: 0 0 20px 0;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.hero-subtitle {
  font-size: 1.25rem;
  margin: 0 0 40px 0;
  opacity: 0.9;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.hero-actions {
  display: flex;
  gap: 20px;
  justify-content: center;
  margin-bottom: 60px;
}

.cta-button {
  padding: 15px 30px;
  border: none;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
}

.cta-button.primary {
  background: #007bff;
  color: white;
}

.cta-button.primary:hover {
  background: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

.cta-button.secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.cta-button.secondary:hover {
  background: white;
  color: #333;
  transform: translateY(-2px);
}

.cta-button.large {
  padding: 18px 36px;
  font-size: 1.1rem;
}

.hero-stats {
  display: flex;
  gap: 60px;
  justify-content: center;
  flex-wrap: wrap;
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 2.5rem;
  font-weight: bold;
  margin-bottom: 8px;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.stat-label {
  font-size: 1rem;
  opacity: 0.9;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.section-header {
  text-align: center;
  margin-bottom: 60px;
}

.section-title {
  font-size: 2.5rem;
  font-weight: bold;
  margin: 0 0 20px 0;
  color: #333;
}

.section-description {
  font-size: 1.125rem;
  color: #666;
  margin: 0;
  max-width: 600px;
  margin: 0 auto;
}

.features-section {
  padding: 100px 0;
  background: #f8f9fa;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 40px;
}

.feature-card {
  background: white;
  padding: 40px 30px;
  border-radius: 12px;
  text-align: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
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
  font-size: 1.5rem;
  font-weight: bold;
  margin: 0 0 15px 0;
  color: #333;
}

.feature-description {
  color: #666;
  line-height: 1.6;
  margin: 0;
}

.testimonials-section {
  padding: 100px 0;
  background: white;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 40px;
}

.testimonial-card {
  background: #f8f9fa;
  padding: 40px 30px;
  border-radius: 12px;
  text-align: center;
  position: relative;
}

.quote-icon {
  font-size: 4rem;
  color: #007bff;
  font-weight: bold;
  margin-bottom: 20px;
  opacity: 0.3;
}

.testimonial-text {
  font-size: 1.125rem;
  color: #333;
  line-height: 1.6;
  margin: 0 0 30px 0;
  font-style: italic;
}

.testimonial-author {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 15px;
}

.author-image {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.author-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 2px;
}

.author-title {
  font-size: 0.875rem;
  color: #666;
}

.pricing-section {
  padding: 100px 0;
  background: #f8f9fa;
}

.pricing-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  max-width: 1000px;
  margin: 0 auto;
}

.pricing-card {
  background: white;
  border-radius: 12px;
  padding: 40px 30px;
  text-align: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  position: relative;
  transition: transform 0.3s ease;
}

.pricing-card:hover {
  transform: translateY(-5px);
}

.pricing-card.featured {
  border: 2px solid #007bff;
  transform: scale(1.05);
}

.plan-badge {
  position: absolute;
  top: -15px;
  left: 50%;
  transform: translateX(-50%);
  background: #007bff;
  color: white;
  padding: 8px 20px;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: bold;
}

.plan-header {
  margin-bottom: 30px;
}

.plan-name {
  font-size: 1.5rem;
  font-weight: bold;
  margin: 0 0 15px 0;
  color: #333;
}

.plan-price {
  display: flex;
  align-items: baseline;
  justify-content: center;
  gap: 5px;
}

.currency {
  font-size: 1.5rem;
  color: #666;
}

.amount {
  font-size: 3rem;
  font-weight: bold;
  color: #333;
}

.period {
  font-size: 1rem;
  color: #666;
}

.features-list {
  list-style: none;
  padding: 0;
  margin: 0 0 30px 0;
}

.features-list li {
  padding: 10px 0;
  border-bottom: 1px solid #eee;
  color: #666;
}

.features-list li:last-child {
  border-bottom: none;
}

.plan-button {
  width: 100%;
  padding: 15px;
  border: none;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
}

.pricing-card:not(.featured) .plan-button {
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.pricing-card:not(.featured) .plan-button:hover {
  background: #e9ecef;
}

.pricing-card.featured .plan-button {
  background: #007bff;
  color: white;
}

.pricing-card.featured .plan-button:hover {
  background: #0056b3;
}

.cta-section {
  padding: 100px 0;
  background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
  color: white;
}

.cta-content {
  text-align: center;
  max-width: 600px;
  margin: 0 auto;
}

.cta-title {
  font-size: 2.5rem;
  font-weight: bold;
  margin: 0 0 20px 0;
}

.cta-description {
  font-size: 1.125rem;
  margin: 0 0 40px 0;
  opacity: 0.9;
}

.cta-actions {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
}

.cta-section .cta-button.primary {
  background: white;
  color: #007bff;
}

.cta-section .cta-button.primary:hover {
  background: #f8f9fa;
  transform: translateY(-2px);
}

.cta-section .cta-button.secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.cta-section .cta-button.secondary:hover {
  background: white;
  color: #007bff;
}

.site-footer {
  background: #333;
  color: white;
  padding: 60px 0 20px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

.footer-title {
  font-size: 1.125rem;
  font-weight: bold;
  margin: 0 0 20px 0;
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
  .hero-title {
    font-size: 2.5rem;
  }

  .hero-actions {
    flex-direction: column;
    align-items: center;
  }

  .hero-stats {
    gap: 30px;
  }

  .stat-number {
    font-size: 2rem;
  }

  .section-title {
    font-size: 2rem;
  }

  .features-grid,
  .testimonials-grid,
  .pricing-grid {
    grid-template-columns: 1fr;
  }

  .pricing-card.featured {
    transform: none;
  }

  .cta-actions {
    flex-direction: column;
    align-items: center;
  }

  .cta-button {
    width: 100%;
    max-width: 300px;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 2rem;
  }

  .hero-subtitle {
    font-size: 1rem;
  }

  .section-title {
    font-size: 1.75rem;
  }

  .cta-title {
    font-size: 2rem;
  }
}
</style>

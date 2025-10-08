<template>
  <div class="news-website">
    <header class="site-header">
      <div class="header-content">
        <div class="logo-section">
          <img src="/api/placeholder/150/50" alt="News Today" class="site-logo" />
          <h1 class="site-title">News Today</h1>
        </div>
        
        <nav class="main-navigation">
          <ul class="nav-menu">
            <li class="nav-item">
              <a href="/home" class="nav-link">Home</a>
            </li>
            <li class="nav-item">
              <a href="/politics" class="nav-link">Politics</a>
            </li>
            <li class="nav-item">
              <a href="/business" class="nav-link">Business</a>
            </li>
            <li class="nav-item">
              <a href="/technology" class="nav-link">Technology</a>
            </li>
            <li class="nav-item">
              <a href="/sports" class="nav-link">Sports</a>
            </li>
            <li class="nav-item">
              <a href="/entertainment" class="nav-link">Entertainment</a>
            </li>
            <li class="nav-item">
              <a href="/health" class="nav-link">Health</a>
            </li>
            <li class="nav-item">
              <a href="/world" class="nav-link">World</a>
            </li>
          </ul>
        </nav>
        
        <div class="header-actions">
          <button class="search-btn">
            <img src="/api/placeholder/20/20" alt="Search" />
          </button>
          <button class="menu-btn">
            <img src="/api/placeholder/20/20" alt="Menu" />
          </button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="content-container">
        <div class="hero-section">
          <div class="hero-article">
            <div class="hero-image">
              <img src="/api/placeholder/800/400" alt="Breaking News Story" />
              <div class="hero-badge">Breaking</div>
            </div>
            <div class="hero-content">
              <div class="hero-meta">
                <span class="hero-category">Politics</span>
                <span class="hero-date">January 15, 2024</span>
                <span class="hero-read-time">5 min read</span>
              </div>
              <h2 class="hero-title">
                Major Policy Changes Announced in Government Address
              </h2>
              <p class="hero-excerpt">
                Significant policy updates were revealed today during a comprehensive government address, 
                affecting multiple sectors and millions of citizens nationwide.
              </p>
              <div class="hero-author">
                <img src="/api/placeholder/40/40" alt="Sarah Johnson" class="author-avatar" />
                <div class="author-info">
                  <div class="author-name">Sarah Johnson</div>
                  <div class="author-title">Senior Political Reporter</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="content-layout">
          <div class="main-articles">
            <section class="latest-news">
              <h2 class="section-title">Latest News</h2>
              <div class="articles-grid">
                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="Technology Innovation" />
                    <div class="card-category">Technology</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">New AI Technology Revolutionizes Healthcare</h3>
                    <p class="card-excerpt">
                      Revolutionary artificial intelligence system shows promising results in early disease detection.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Mike Chen</span>
                      <span class="card-time">2 hours ago</span>
                    </div>
                  </div>
                </article>

                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="Economic Growth" />
                    <div class="card-category">Business</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">Stock Market Reaches New All-Time High</h3>
                    <p class="card-excerpt">
                      Market indices show strong performance with technology stocks leading the gains.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Emma Davis</span>
                      <span class="card-time">4 hours ago</span>
                    </div>
                  </div>
                </article>

                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="Sports Championship" />
                    <div class="card-category">Sports</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">Championship Game Sets Viewership Records</h3>
                    <p class="card-excerpt">
                      Historic matchup draws millions of viewers worldwide in record-breaking broadcast.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Alex Rodriguez</span>
                      <span class="card-time">6 hours ago</span>
                    </div>
                  </div>
                </article>

                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="Climate Research" />
                    <div class="card-category">Health</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">New Study Links Air Quality to Longevity</h3>
                    <p class="card-excerpt">
                      Comprehensive research reveals significant correlation between air quality and life expectancy.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Dr. Lisa Wang</span>
                      <span class="card-time">8 hours ago</span>
                    </div>
                  </div>
                </article>

                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="Entertainment Awards" />
                    <div class="card-category">Entertainment</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">Awards Season Brings Surprising Winners</h3>
                    <p class="card-excerpt">
                      Unexpected victories and memorable moments highlight this year's entertainment awards.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Jessica Brown</span>
                      <span class="card-time">10 hours ago</span>
                    </div>
                  </div>
                </article>

                <article class="article-card">
                  <div class="card-image">
                    <img src="/api/placeholder/300/200" alt="International Relations" />
                    <div class="card-category">World</div>
                  </div>
                  <div class="card-content">
                    <h3 class="card-title">International Summit Addresses Global Challenges</h3>
                    <p class="card-excerpt">
                      World leaders convene to discuss pressing issues affecting international cooperation.
                    </p>
                    <div class="card-meta">
                      <span class="card-author">Robert Smith</span>
                      <span class="card-time">12 hours ago</span>
                    </div>
                  </div>
                </article>
              </div>
            </section>

            <section class="featured-stories">
              <h2 class="section-title">Featured Stories</h2>
              <div class="featured-grid">
                <div class="featured-article large">
                  <div class="featured-image">
                    <img src="/api/placeholder/600/300" alt="Climate Change Research" />
                    <div class="featured-category">Environment</div>
                  </div>
                  <div class="featured-content">
                    <h3 class="featured-title">Climate Research Reveals Urgent Action Needed</h3>
                    <p class="featured-excerpt">
                      Comprehensive study shows accelerating climate change impacts requiring immediate global response.
                    </p>
                    <div class="featured-meta">
                      <span class="featured-author">Dr. Maria Garcia</span>
                      <span class="featured-time">1 day ago</span>
                    </div>
                  </div>
                </div>

                <div class="featured-article">
                  <div class="featured-image">
                    <img src="/api/placeholder/300/200" alt="Space Exploration" />
                    <div class="featured-category">Science</div>
                  </div>
                  <div class="featured-content">
                    <h3 class="featured-title">Mars Mission Returns Groundbreaking Data</h3>
                    <p class="featured-excerpt">
                      Latest findings from Mars exploration provide new insights into planetary science.
                    </p>
                    <div class="featured-meta">
                      <span class="featured-author">Dr. James Wilson</span>
                      <span class="featured-time">2 days ago</span>
                    </div>
                  </div>
                </div>

                <div class="featured-article">
                  <div class="featured-image">
                    <img src="/api/placeholder/300/200" alt="Economic Analysis" />
                    <div class="featured-category">Economy</div>
                  </div>
                  <div class="featured-content">
                    <h3 class="featured-title">Economic Indicators Show Mixed Signals</h3>
                    <p class="featured-excerpt">
                      Latest economic data presents complex picture of current market conditions.
                    </p>
                    <div class="featured-meta">
                      <span class="featured-author">Jennifer Lee</span>
                      <span class="featured-time">3 days ago</span>
                    </div>
                  </div>
                </div>
              </div>
            </section>
          </div>

          <aside class="sidebar">
            <div class="sidebar-widget">
              <h3 class="widget-title">Trending Topics</h3>
              <div class="trending-list">
                <div class="trending-item">
                  <span class="trending-rank">1</span>
                  <span class="trending-topic">Climate Change</span>
                </div>
                <div class="trending-item">
                  <span class="trending-rank">2</span>
                  <span class="trending-topic">Artificial Intelligence</span>
                </div>
                <div class="trending-item">
                  <span class="trending-rank">3</span>
                  <span class="trending-topic">Global Economy</span>
                </div>
                <div class="trending-item">
                  <span class="trending-rank">4</span>
                  <span class="trending-topic">Space Exploration</span>
                </div>
                <div class="trending-item">
                  <span class="trending-rank">5</span>
                  <span class="trending-topic">Healthcare Innovation</span>
                </div>
              </div>
            </div>

            <div class="sidebar-widget">
              <h3 class="widget-title">Weather</h3>
              <div class="weather-widget">
                <div class="weather-location">New York, NY</div>
                <div class="weather-temp">72°F</div>
                <div class="weather-condition">Partly Cloudy</div>
                <div class="weather-details">
                  <div class="weather-item">
                    <span class="weather-label">Humidity:</span>
                    <span class="weather-value">65%</span>
                  </div>
                  <div class="weather-item">
                    <span class="weather-label">Wind:</span>
                    <span class="weather-value">8 mph</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="sidebar-widget">
              <h3 class="widget-title">Newsletter</h3>
              <div class="newsletter-widget">
                <p class="newsletter-text">
                  Get the latest news delivered to your inbox
                </p>
                <form class="newsletter-form">
                  <input 
                    type="email" 
                    placeholder="Enter your email" 
                    class="newsletter-input"
                  />
                  <button type="submit" class="newsletter-btn">Subscribe</button>
                </form>
              </div>
            </div>

            <div class="sidebar-widget">
              <h3 class="widget-title">Most Read</h3>
              <div class="most-read-list">
                <div class="most-read-item">
                  <div class="read-rank">1</div>
                  <div class="read-content">
                    <h4 class="read-title">Major Policy Changes Announced</h4>
                    <div class="read-meta">Politics • 2 hours ago</div>
                  </div>
                </div>
                <div class="most-read-item">
                  <div class="read-rank">2</div>
                  <div class="read-content">
                    <h4 class="read-title">AI Technology Revolutionizes Healthcare</h4>
                    <div class="read-meta">Technology • 4 hours ago</div>
                  </div>
                </div>
                <div class="most-read-item">
                  <div class="read-rank">3</div>
                  <div class="read-content">
                    <h4 class="read-title">Stock Market Reaches New High</h4>
                    <div class="read-meta">Business • 6 hours ago</div>
                  </div>
                </div>
              </div>
            </div>
          </aside>
        </div>
      </div>
    </main>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4 class="footer-title">News Categories</h4>
          <ul class="footer-links">
            <li><a href="/politics">Politics</a></li>
            <li><a href="/business">Business</a></li>
            <li><a href="/technology">Technology</a></li>
            <li><a href="/sports">Sports</a></li>
            <li><a href="/entertainment">Entertainment</a></li>
            <li><a href="/health">Health</a></li>
            <li><a href="/world">World</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Company</h4>
          <ul class="footer-links">
            <li><a href="/about">About Us</a></li>
            <li><a href="/careers">Careers</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/advertise">Advertise</a></li>
            <li><a href="/press">Press</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Support</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/privacy">Privacy Policy</a></li>
            <li><a href="/terms">Terms of Service</a></li>
            <li><a href="/cookies">Cookie Policy</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4 class="footer-title">Connect</h4>
          <ul class="footer-links">
            <li><a href="/twitter">Twitter</a></li>
            <li><a href="/facebook">Facebook</a></li>
            <li><a href="/instagram">Instagram</a></li>
            <li><a href="/youtube">YouTube</a></li>
            <li><a href="/rss">RSS</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 News Today. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
// No JavaScript needed for this component
</script>

<style scoped>
.news-website {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
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
  height: 80px;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 15px;
}

.site-logo {
  height: 50px;
  width: auto;
}

.site-title {
  margin: 0;
  font-size: 28px;
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
  font-size: 16px;
  transition: color 0.2s ease;
  padding: 10px 0;
}

.nav-link:hover {
  color: #007bff;
}

.header-actions {
  display: flex;
  gap: 15px;
}

.search-btn,
.menu-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.search-btn:hover,
.menu-btn:hover {
  background: #f8f9fa;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
}

.hero-section {
  margin-bottom: 50px;
}

.hero-article {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.hero-image {
  position: relative;
  height: 400px;
  overflow: hidden;
}

.hero-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-badge {
  position: absolute;
  top: 20px;
  left: 20px;
  background: #dc3545;
  color: white;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: bold;
  text-transform: uppercase;
}

.hero-content {
  padding: 40px;
}

.hero-meta {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
  font-size: 14px;
  color: #666;
}

.hero-category {
  background: #007bff;
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-weight: bold;
}

.hero-title {
  margin: 0 0 20px 0;
  font-size: 36px;
  font-weight: bold;
  color: #333;
  line-height: 1.2;
}

.hero-excerpt {
  margin: 0 0 30px 0;
  font-size: 18px;
  color: #666;
  line-height: 1.6;
}

.hero-author {
  display: flex;
  align-items: center;
  gap: 15px;
}

.author-avatar {
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
  font-size: 14px;
  color: #666;
}

.content-layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
}

.section-title {
  margin: 0 0 30px 0;
  font-size: 24px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-bottom: 50px;
}

.article-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
}

.article-card:hover {
  transform: translateY(-4px);
}

.card-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-category {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #007bff;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
}

.card-content {
  padding: 25px;
}

.card-title {
  margin: 0 0 15px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.card-excerpt {
  margin: 0 0 20px 0;
  color: #666;
  line-height: 1.5;
}

.card-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
}

.featured-stories {
  margin-bottom: 50px;
}

.featured-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: 20px;
}

.featured-article {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
}

.featured-article:hover {
  transform: translateY(-4px);
}

.featured-article.large {
  grid-row: 1 / 3;
}

.featured-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.featured-article.large .featured-image {
  height: 300px;
}

.featured-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.featured-category {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #28a745;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
}

.featured-content {
  padding: 25px;
}

.featured-title {
  margin: 0 0 15px 0;
  font-size: 20px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.featured-article.large .featured-title {
  font-size: 24px;
}

.featured-excerpt {
  margin: 0 0 20px 0;
  color: #666;
  line-height: 1.5;
}

.featured-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
}

.sidebar {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.sidebar-widget {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.widget-title {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

.trending-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.trending-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 10px;
  border-radius: 6px;
  transition: background-color 0.2s ease;
}

.trending-item:hover {
  background: #f8f9fa;
}

.trending-rank {
  width: 25px;
  height: 25px;
  background: #007bff;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 12px;
}

.trending-topic {
  font-weight: 500;
  color: #333;
}

.weather-widget {
  text-align: center;
}

.weather-location {
  font-size: 16px;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.weather-temp {
  font-size: 36px;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 5px;
}

.weather-condition {
  color: #666;
  margin-bottom: 20px;
}

.weather-details {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.weather-item {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
}

.weather-label {
  color: #666;
}

.weather-value {
  color: #333;
  font-weight: 500;
}

.newsletter-widget {
  text-align: center;
}

.newsletter-text {
  margin: 0 0 20px 0;
  color: #666;
  font-size: 14px;
}

.newsletter-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.newsletter-input {
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.newsletter-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 10px;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.newsletter-btn:hover {
  background: #0056b3;
}

.most-read-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.most-read-item {
  display: flex;
  gap: 15px;
  padding: 10px;
  border-radius: 6px;
  transition: background-color 0.2s ease;
}

.most-read-item:hover {
  background: #f8f9fa;
}

.read-rank {
  width: 25px;
  height: 25px;
  background: #28a745;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 12px;
  flex-shrink: 0;
}

.read-content {
  flex: 1;
}

.read-title {
  margin: 0 0 5px 0;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.read-meta {
  font-size: 12px;
  color: #666;
}

.site-footer {
  background: #333;
  color: white;
  padding: 60px 0 20px;
  margin-top: 50px;
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

.footer-title {
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

@media (max-width: 1024px) {
  .content-layout {
    grid-template-columns: 1fr;
  }
  
  .featured-grid {
    grid-template-columns: 1fr;
  }
  
  .featured-article.large {
    grid-row: auto;
  }
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
    justify-content: center;
  }

  .hero-title {
    font-size: 28px;
  }

  .articles-grid {
    grid-template-columns: 1fr;
  }

  .featured-grid {
    grid-template-columns: 1fr;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 24px;
  }

  .hero-content {
    padding: 25px;
  }

  .section-title {
    font-size: 20px;
  }
}
</style>

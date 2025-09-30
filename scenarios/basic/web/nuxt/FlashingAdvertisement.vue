<template>
  <div class="news-website">
    <header class="site-header">
      <div class="header-content">
        <h1 class="site-title">Daily News</h1>
        <nav class="main-navigation">
          <ul class="nav-list">
            <li><a href="#" class="nav-link">Home</a></li>
            <li><a href="#" class="nav-link">Politics</a></li>
            <li><a href="#" class="nav-link">Business</a></li>
            <li><a href="#" class="nav-link">Technology</a></li>
            <li><a href="#" class="nav-link">Sports</a></li>
            <li><a href="#" class="nav-link">Entertainment</a></li>
          </ul>
        </nav>
      </div>
    </header>

    <main class="main-content">
      <div class="content-layout">
        <div class="main-articles">
          <section class="hero-article">
            <div class="article-image">
              <img src="/api/placeholder/800/400" alt="Breaking news story" />
              <div class="article-badge">Breaking News</div>
            </div>
            <div class="article-content">
              <h2 class="article-title">Major Economic Summit Concludes with Historic Agreement</h2>
              <p class="article-excerpt">
                World leaders reach unprecedented consensus on climate change and economic cooperation, 
                marking a new era in international diplomacy.
              </p>
              <div class="article-meta">
                <span class="article-author">Sarah Johnson</span>
                <span class="article-date">2 hours ago</span>
                <span class="article-views">12.5K views</span>
              </div>
            </div>
          </section>

          <section class="article-grid">
            <article
              v-for="article in articles"
              :key="article.id"
              class="article-card"
            >
              <div class="card-image">
                <img :src="article.image" :alt="article.title" />
                <div class="card-category">{{ article.category }}</div>
              </div>
              <div class="card-content">
                <h3 class="card-title">{{ article.title }}</h3>
                <p class="card-excerpt">{{ article.excerpt }}</p>
                <div class="card-meta">
                  <span class="card-author">{{ article.author }}</span>
                  <span class="card-time">{{ article.time }}</span>
                </div>
              </div>
            </article>
          </section>
        </div>

        <aside class="sidebar">
          <div class="sidebar-section">
            <h3>Trending Now</h3>
            <div class="trending-list">
              <div
                v-for="(trend, index) in trendingTopics"
                :key="trend.id"
                class="trending-item"
              >
                <span class="trend-number">{{ index + 1 }}</span>
                <span class="trend-text">{{ trend.topic }}</span>
                <span class="trend-count">{{ trend.count }}</span>
              </div>
            </div>
          </div>

          <div class="sidebar-section">
            <h3>Weather</h3>
            <div class="weather-widget">
              <div class="weather-current">
                <div class="weather-temp">72°F</div>
                <div class="weather-desc">Partly Cloudy</div>
                <div class="weather-location">New York, NY</div>
              </div>
              <div class="weather-forecast">
                <div class="forecast-item">
                  <span class="forecast-day">Today</span>
                  <span class="forecast-temp">72°F</span>
                </div>
                <div class="forecast-item">
                  <span class="forecast-day">Tomorrow</span>
                  <span class="forecast-temp">68°F</span>
                </div>
                <div class="forecast-item">
                  <span class="forecast-day">Wednesday</span>
                  <span class="forecast-temp">75°F</span>
                </div>
              </div>
            </div>
          </div>

          <div class="sidebar-section">
            <h3>Stock Market</h3>
            <div class="stock-widget">
              <div class="stock-item">
                <span class="stock-symbol">AAPL</span>
                <span class="stock-price">$150.25</span>
                <span class="stock-change positive">+2.5%</span>
              </div>
              <div class="stock-item">
                <span class="stock-symbol">GOOGL</span>
                <span class="stock-price">$2,850.30</span>
                <span class="stock-change negative">-1.2%</span>
              </div>
              <div class="stock-item">
                <span class="stock-symbol">MSFT</span>
                <span class="stock-price">$350.75</span>
                <span class="stock-change positive">+0.8%</span>
              </div>
            </div>
          </div>
        </aside>
      </div>

      <div class="advertisement-section">
        <div class="ad-banner">
          <div class="ad-content">
            <h3>Special Offer!</h3>
            <p>Get 50% off on all subscriptions</p>
            <button class="ad-button">Subscribe Now</button>
          </div>
        </div>
      </div>

      <div class="newsletter-section">
        <div class="newsletter-content">
          <h2>Stay Updated</h2>
          <p>Get the latest news delivered to your inbox</p>
          <form class="newsletter-form">
            <input type="email" placeholder="Enter your email" class="newsletter-input" />
            <button type="submit" class="newsletter-btn">Subscribe</button>
          </form>
        </div>
      </div>
    </main>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>News Categories</h4>
          <ul class="footer-links">
            <li><a href="#">Politics</a></li>
            <li><a href="#">Business</a></li>
            <li><a href="#">Technology</a></li>
            <li><a href="#">Sports</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Company</h4>
          <ul class="footer-links">
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Privacy Policy</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Follow Us</h4>
          <div class="social-links">
            <a href="#" class="social-link">📘</a>
            <a href="#" class="social-link">🐦</a>
            <a href="#" class="social-link">📷</a>
            <a href="#" class="social-link">📺</a>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Daily News. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const articles = ref([
  {
    id: 1,
    title: 'Tech Giants Report Record Quarterly Earnings',
    excerpt: 'Major technology companies exceed expectations with strong Q4 performance.',
    image: '/api/placeholder/400/250',
    category: 'Technology',
    author: 'Mike Chen',
    time: '3 hours ago'
  },
  {
    id: 2,
    title: 'Olympic Games Preparations Enter Final Phase',
    excerpt: 'Host city completes infrastructure projects ahead of international competition.',
    image: '/api/placeholder/400/250',
    category: 'Sports',
    author: 'David Wilson',
    time: '5 hours ago'
  },
  {
    id: 3,
    title: 'Climate Change Summit Reaches New Agreement',
    excerpt: 'International leaders commit to ambitious carbon reduction targets.',
    image: '/api/placeholder/400/250',
    category: 'Politics',
    author: 'Emily Davis',
    time: '6 hours ago'
  },
  {
    id: 4,
    title: 'New Medical Breakthrough in Cancer Treatment',
    excerpt: 'Researchers announce promising results from latest clinical trials.',
    image: '/api/placeholder/400/250',
    category: 'Health',
    author: 'Dr. Sarah Johnson',
    time: '8 hours ago'
  }
])

const trendingTopics = ref([
  { id: 1, topic: 'Economic Summit', count: '125K' },
  { id: 2, topic: 'Tech Earnings', count: '98K' },
  { id: 3, topic: 'Olympic Games', count: '87K' },
  { id: 4, topic: 'Climate Agreement', count: '76K' },
  { id: 5, topic: 'Medical Breakthrough', count: '65K' }
])
</script>

<style scoped>
.news-website {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  background: #f5f5f5;
}

.site-header {
  background: #1a1a1a;
  color: white;
  padding: 20px 0;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.site-title {
  margin: 0;
  font-size: 28px;
  font-weight: bold;
}

.main-navigation {
  display: flex;
}

.nav-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 30px;
}

.nav-link {
  color: white;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
}

.nav-link:hover {
  color: #007bff;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.content-layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
  margin-bottom: 40px;
}

.hero-article {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  margin-bottom: 30px;
}

.article-image {
  position: relative;
  height: 400px;
  overflow: hidden;
}

.article-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.article-badge {
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

.article-content {
  padding: 30px;
}

.article-title {
  margin: 0 0 15px 0;
  font-size: 28px;
  font-weight: bold;
  color: #333;
  line-height: 1.2;
}

.article-excerpt {
  margin: 0 0 20px 0;
  font-size: 16px;
  color: #666;
  line-height: 1.6;
}

.article-meta {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #999;
}

.article-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.article-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
}

.article-card:hover {
  transform: translateY(-2px);
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
  padding: 20px;
}

.card-title {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.card-excerpt {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.5;
  font-size: 14px;
}

.card-meta {
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

.sidebar-section {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.sidebar-section h3 {
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

.trend-number {
  background: #007bff;
  color: white;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: bold;
}

.trend-text {
  flex: 1;
  font-weight: 500;
  color: #333;
}

.trend-count {
  font-size: 12px;
  color: #666;
}

.weather-widget {
  text-align: center;
}

.weather-current {
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

.weather-temp {
  font-size: 36px;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.weather-desc {
  font-size: 16px;
  color: #666;
  margin-bottom: 5px;
}

.weather-location {
  font-size: 14px;
  color: #999;
}

.weather-forecast {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.forecast-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
}

.forecast-item:last-child {
  border-bottom: none;
}

.forecast-day {
  font-size: 14px;
  color: #333;
}

.forecast-temp {
  font-size: 14px;
  font-weight: bold;
  color: #007bff;
}

.stock-widget {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.stock-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  background: #f8f9fa;
  border-radius: 6px;
}

.stock-symbol {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.stock-price {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.stock-change {
  font-size: 12px;
  font-weight: bold;
}

.stock-change.positive {
  color: #28a745;
}

.stock-change.negative {
  color: #dc3545;
}

.advertisement-section {
  margin: 40px 0;
}

.ad-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 40px;
  border-radius: 8px;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.ad-banner::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
  animation: flash 2s infinite;
}

@keyframes flash {
  0%, 100% { opacity: 0; }
  50% { opacity: 1; }
}

.ad-content {
  position: relative;
  z-index: 1;
}

.ad-content h3 {
  margin: 0 0 10px 0;
  font-size: 24px;
  font-weight: bold;
}

.ad-content p {
  margin: 0 0 20px 0;
  font-size: 16px;
  opacity: 0.9;
}

.ad-button {
  background: white;
  color: #667eea;
  border: none;
  padding: 12px 24px;
  border-radius: 25px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.ad-button:hover {
  background: #f8f9fa;
  transform: translateY(-2px);
}

.newsletter-section {
  background: #333;
  color: white;
  padding: 40px;
  border-radius: 8px;
  text-align: center;
  margin: 40px 0;
}

.newsletter-content h2 {
  margin: 0 0 10px 0;
  font-size: 24px;
}

.newsletter-content p {
  margin: 0 0 20px 0;
  opacity: 0.9;
}

.newsletter-form {
  display: flex;
  max-width: 400px;
  margin: 0 auto;
  gap: 10px;
}

.newsletter-input {
  flex: 1;
  padding: 12px 16px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
}

.newsletter-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.newsletter-btn:hover {
  background: #0056b3;
}

.site-footer {
  background: #1a1a1a;
  color: white;
  padding: 40px 0 20px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin-bottom: 30px;
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

.social-links {
  display: flex;
  gap: 15px;
}

.social-link {
  display: inline-block;
  font-size: 24px;
  text-decoration: none;
  transition: transform 0.2s ease;
}

.social-link:hover {
  transform: scale(1.1);
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #333;
  color: #ccc;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 20px;
  }

  .nav-list {
    flex-wrap: wrap;
    gap: 15px;
  }

  .content-layout {
    grid-template-columns: 1fr;
  }

  .article-grid {
    grid-template-columns: 1fr;
  }

  .newsletter-form {
    flex-direction: column;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}
</style>

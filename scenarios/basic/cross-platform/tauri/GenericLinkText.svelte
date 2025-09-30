<script>
  import { onMount } from 'svelte';
  
  let articles = [
    {
      id: 1,
      title: 'The Future of Web Development: Trends and Predictions',
      excerpt: 'Explore the latest trends in web development and what to expect in the coming years...',
      category: 'Technology',
      readTime: '5 min read',
      date: '2024-01-15'
    },
    {
      id: 2,
      title: 'Understanding Accessibility in Modern Web Applications',
      excerpt: 'Learn about the importance of accessibility and how to implement it in your projects...',
      category: 'Accessibility',
      readTime: '8 min read',
      date: '2024-01-12'
    },
    {
      id: 3,
      title: 'Building Scalable React Applications: Best Practices',
      excerpt: 'Discover the best practices for building large-scale React applications that can grow with your business...',
      category: 'React',
      readTime: '12 min read',
      date: '2024-01-10'
    },
    {
      id: 4,
      title: 'CSS Grid vs Flexbox: When to Use Each',
      excerpt: 'A comprehensive comparison of CSS Grid and Flexbox to help you choose the right layout method...',
      category: 'CSS',
      readTime: '6 min read',
      date: '2024-01-08'
    },
    {
      id: 5,
      title: 'JavaScript Performance Optimization Techniques',
      excerpt: 'Learn how to optimize your JavaScript code for better performance and user experience...',
      category: 'JavaScript',
      readTime: '10 min read',
      date: '2024-01-05'
    },
    {
      id: 6,
      title: 'The Complete Guide to TypeScript for Beginners',
      excerpt: 'Everything you need to know to get started with TypeScript and build type-safe applications...',
      category: 'TypeScript',
      readTime: '15 min read',
      date: '2024-01-03'
    }
  ];
  
  let selectedCategory = 'all';
  let filteredArticles = [...articles];
  
  function filterByCategory(category) {
    selectedCategory = category;
    if (category === 'all') {
      filteredArticles = [...articles];
    } else {
      filteredArticles = articles.filter(article => article.category === category);
    }
  }
  
  function getCategories() {
    return ['all', ...new Set(articles.map(article => article.category))];
  }
  
  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }
  
  function handleArticleClick(article) {
    alert(`Opening article: ${article.title}`);
  }
</script>

<div class="blog-page">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">TechBlog</h1>
      <nav class="nav">
        <a href="#" class="nav-link">Home</a>
        <a href="#" class="nav-link">Categories</a>
        <a href="#" class="nav-link">About</a>
        <a href="#" class="nav-link">Contact</a>
      </nav>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Search clicked')}>
          🔍 Search
        </button>
        <button class="header-btn" on:click={() => alert('Subscribe clicked')}>
          📧 Subscribe
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Latest Articles</h2>
      <p class="page-subtitle">Stay updated with the latest trends and insights</p>
    </div>
    
    <div class="filter-section">
      <div class="filter-group">
        <label for="categoryFilter" class="filter-label">Filter by Category:</label>
        <select id="categoryFilter" class="filter-select" on:change={(e) => filterByCategory(e.target.value)}>
          {#each getCategories() as category}
            <option value={category} selected={category === selectedCategory}>
              {category === 'all' ? 'All Categories' : category}
            </option>
          {/each}
        </select>
      </div>
      
      <div class="stats">
        <span class="stat-text">Showing {filteredArticles.length} articles</span>
      </div>
    </div>
    
    <div class="articles-grid">
      {#each filteredArticles as article}
        <article class="article-card">
          <div class="article-header">
            <div class="article-category">{article.category}</div>
            <div class="article-meta">
              <span class="article-date">{formatDate(article.date)}</span>
              <span class="article-read-time">{article.readTime}</span>
            </div>
          </div>
          
          <div class="article-content">
            <h3 class="article-title">{article.title}</h3>
            <p class="article-excerpt">{article.excerpt}</p>
          </div>
          
          <div class="article-footer">
            <div class="article-actions">
              <button class="action-btn bookmark" on:click={() => alert(`Bookmark ${article.title}`)}>
                🔖 Bookmark
              </button>
              <button class="action-btn share" on:click={() => alert(`Share ${article.title}`)}>
                📤 Share
              </button>
            </div>
            
            <!-- GENERIC LINK TEXT - "Read more" link without context about destination -->
            <a href="#" class="read-more-link" on:click|preventDefault={() => handleArticleClick(article)}>
              Read more
            </a>
          </div>
        </article>
      {/each}
    </div>
    
    <div class="pagination">
      <button class="pagination-btn" disabled>Previous</button>
      <div class="pagination-pages">
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn">4</button>
        <button class="page-btn">5</button>
      </div>
      <button class="pagination-btn">Next</button>
    </div>
  </main>
  
  <aside class="sidebar">
    <div class="sidebar-section">
      <h3 class="sidebar-title">Popular Tags</h3>
      <div class="tags">
        <span class="tag">JavaScript</span>
        <span class="tag">React</span>
        <span class="tag">CSS</span>
        <span class="tag">Accessibility</span>
        <span class="tag">Performance</span>
        <span class="tag">TypeScript</span>
      </div>
    </div>
    
    <div class="sidebar-section">
      <h3 class="sidebar-title">Recent Posts</h3>
      <div class="recent-posts">
        {#each articles.slice(0, 3) as article}
          <div class="recent-post">
            <h4 class="recent-post-title">
              <!-- GENERIC LINK TEXT - "Read more" link without context about destination -->
              <a href="#" class="recent-post-link" on:click|preventDefault={() => handleArticleClick(article)}>
                {article.title}
              </a>
            </h4>
            <div class="recent-post-meta">
              <span class="recent-post-date">{formatDate(article.date)}</span>
              <span class="recent-post-category">{article.category}</span>
            </div>
          </div>
        {/each}
      </div>
    </div>
    
    <div class="sidebar-section">
      <h3 class="sidebar-title">Newsletter</h3>
      <div class="newsletter-signup">
        <p class="newsletter-text">Get the latest articles delivered to your inbox</p>
        <div class="newsletter-form">
          <input type="email" placeholder="Enter your email" class="newsletter-input" />
          <button class="newsletter-btn">Subscribe</button>
        </div>
      </div>
    </div>
  </aside>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">About</h4>
        <p class="footer-text">TechBlog is your source for the latest in web development, technology trends, and programming insights.</p>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Quick Links</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Home</a></li>
          <li><a href="#" class="footer-link">Categories</a></li>
          <li><a href="#" class="footer-link">About</a></li>
          <li><a href="#" class="footer-link">Contact</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Follow Us</h4>
        <div class="social-links">
          <a href="#" class="social-link">Twitter</a>
          <a href="#" class="social-link">LinkedIn</a>
          <a href="#" class="social-link">GitHub</a>
        </div>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 TechBlog. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .blog-page {
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
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
    display: grid;
    grid-template-columns: 1fr 300px;
    gap: 40px;
  }
  
  .page-header {
    text-align: center;
    margin-bottom: 40px;
    grid-column: 1 / -1;
  }
  
  .page-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .page-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    grid-column: 1 / -1;
  }
  
  .filter-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .filter-label {
    font-weight: bold;
    color: #333;
  }
  
  .filter-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
  }
  
  .stats {
    color: #666;
  }
  
  .articles-grid {
    display: grid;
    gap: 30px;
  }
  
  .article-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.2s, box-shadow 0.2s;
  }
  
  .article-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  }
  
  .article-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .article-category {
    background: #007bff;
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .article-meta {
    display: flex;
    gap: 15px;
    font-size: 14px;
    color: #666;
  }
  
  .article-content {
    margin-bottom: 20px;
  }
  
  .article-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 15px 0;
    line-height: 1.3;
  }
  
  .article-excerpt {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0;
  }
  
  .article-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid #eee;
    padding-top: 15px;
  }
  
  .article-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    background: none;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 6px 12px;
    color: #666;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
    color: #333;
  }
  
  .read-more-link {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
    font-size: 16px;
    transition: color 0.2s;
  }
  
  .read-more-link:hover {
    color: #0056b3;
    text-decoration: underline;
  }
  
  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-top: 40px;
    grid-column: 1 / -1;
  }
  
  .pagination-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .pagination-btn:hover:not(:disabled) {
    background: #f8f9fa;
  }
  
  .pagination-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  
  .pagination-pages {
    display: flex;
    gap: 5px;
  }
  
  .page-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .page-btn:hover {
    background: #f8f9fa;
  }
  
  .page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .sidebar {
    display: flex;
    flex-direction: column;
    gap: 30px;
  }
  
  .sidebar-section {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .sidebar-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0 0 20px 0;
  }
  
  .tags {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .tag {
    background: #f8f9fa;
    color: #333;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .tag:hover {
    background: #007bff;
    color: white;
  }
  
  .recent-posts {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .recent-post {
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
  }
  
  .recent-post:last-child {
    border-bottom: none;
    padding-bottom: 0;
  }
  
  .recent-post-title {
    font-size: 16px;
    font-weight: bold;
    margin: 0 0 8px 0;
  }
  
  .recent-post-link {
    color: #333;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .recent-post-link:hover {
    color: #007bff;
  }
  
  .recent-post-meta {
    display: flex;
    gap: 10px;
    font-size: 12px;
    color: #666;
  }
  
  .newsletter-signup {
    text-align: center;
  }
  
  .newsletter-text {
    font-size: 14px;
    color: #666;
    margin: 0 0 15px 0;
  }
  
  .newsletter-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .newsletter-input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
  }
  
  .newsletter-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 10px;
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
    margin-top: 60px;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
  }
  
  .footer-title {
    font-size: 18px;
    font-weight: bold;
    margin: 0 0 15px 0;
  }
  
  .footer-text {
    color: #ccc;
    line-height: 1.6;
    margin: 0;
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
  
  .social-links {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .social-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .social-link:hover {
    color: white;
  }
  
  .footer-bottom {
    border-top: 1px solid #555;
    margin-top: 30px;
    padding-top: 20px;
    text-align: center;
    color: #ccc;
  }
  
  @media (max-width: 768px) {
    .main-content {
      grid-template-columns: 1fr;
    }
    
    .filter-section {
      flex-direction: column;
      gap: 15px;
    }
  }
</style>

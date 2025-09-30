<script>
  let selectedCategory = 'all';
  let sortBy = 'date';
  let viewMode = 'grid';
  let showFilters = false;
  
  const articles = [
    {
      id: 1,
      title: "The Future of Web Development: Trends to Watch in 2024",
      excerpt: "Explore the latest trends in web development including AI integration, performance optimization, and modern frameworks.",
      category: "Technology",
      author: "Sarah Johnson",
      date: "2024-01-15",
      readTime: "8 min read",
      image: "/api/placeholder/400/250",
      featured: true,
      tags: ["Web Development", "AI", "Trends"]
    },
    {
      id: 2,
      title: "Building Accessible User Interfaces: A Complete Guide",
      excerpt: "Learn how to create inclusive user interfaces that work for everyone, including users with disabilities.",
      category: "Accessibility",
      author: "Mike Chen",
      date: "2024-01-14",
      readTime: "12 min read",
      image: "/api/placeholder/400/250",
      featured: false,
      tags: ["Accessibility", "UI/UX", "Inclusive Design"]
    },
    {
      id: 3,
      title: "JavaScript Performance Optimization Techniques",
      excerpt: "Discover advanced techniques to optimize JavaScript performance and improve user experience.",
      category: "Programming",
      author: "Emily Davis",
      date: "2024-01-13",
      readTime: "10 min read",
      image: "/api/placeholder/400/250",
      featured: true,
      tags: ["JavaScript", "Performance", "Optimization"]
    },
    {
      id: 4,
      title: "CSS Grid vs Flexbox: When to Use Which",
      excerpt: "A comprehensive comparison of CSS Grid and Flexbox to help you choose the right layout method.",
      category: "CSS",
      author: "David Wilson",
      date: "2024-01-12",
      readTime: "6 min read",
      image: "/api/placeholder/400/250",
      featured: false,
      tags: ["CSS", "Layout", "Grid", "Flexbox"]
    },
    {
      id: 5,
      title: "React Hooks: Advanced Patterns and Best Practices",
      excerpt: "Master advanced React Hooks patterns and learn best practices for building scalable applications.",
      category: "React",
      author: "Lisa Brown",
      date: "2024-01-11",
      readTime: "15 min read",
      image: "/api/placeholder/400/250",
      featured: true,
      tags: ["React", "Hooks", "Best Practices"]
    },
    {
      id: 6,
      title: "Database Design Principles for Modern Applications",
      excerpt: "Essential database design principles to build scalable and maintainable applications.",
      category: "Database",
      author: "Tom Anderson",
      date: "2024-01-10",
      readTime: "14 min read",
      image: "/api/placeholder/400/250",
      featured: false,
      tags: ["Database", "Design", "Scalability"]
    },
    {
      id: 7,
      title: "Microservices Architecture: Benefits and Challenges",
      excerpt: "Understanding microservices architecture, its benefits, and common challenges in implementation.",
      category: "Architecture",
      author: "Anna Garcia",
      date: "2024-01-09",
      readTime: "11 min read",
      image: "/api/placeholder/400/250",
      featured: false,
      tags: ["Microservices", "Architecture", "Scalability"]
    },
    {
      id: 8,
      title: "Testing Strategies for Frontend Applications",
      excerpt: "Comprehensive guide to testing frontend applications with modern tools and techniques.",
      category: "Testing",
      author: "Kevin Lee",
      date: "2024-01-08",
      readTime: "9 min read",
      image: "/api/placeholder/400/250",
      featured: true,
      tags: ["Testing", "Frontend", "Quality Assurance"]
    }
  ];
  
  function filterArticles() {
    return articles.filter(article => {
      if (selectedCategory === 'all') return true;
      return article.category === selectedCategory;
    });
  }
  
  function sortArticles(articles) {
    return [...articles].sort((a, b) => {
      switch(sortBy) {
        case 'title':
          return a.title.localeCompare(b.title);
        case 'author':
          return a.author.localeCompare(b.author);
        case 'date':
        default:
          return new Date(b.date) - new Date(a.date);
      }
    });
  }
  
  $: filteredArticles = sortArticles(filterArticles());
</script>

<div class="blog-platform">
  <header class="blog-header">
    <div class="header-content">
      <h1 class="blog-title">Tech Blog</h1>
      <p class="blog-subtitle">Insights, tutorials, and best practices for developers</p>
    </div>
    
    <nav class="main-navigation">
      <a href="#" class="nav-link">Home</a>
      <a href="#" class="nav-link">Categories</a>
      <a href="#" class="nav-link">Authors</a>
      <a href="#" class="nav-link">About</a>
      <a href="#" class="nav-link">Contact</a>
    </nav>
  </header>

  <div class="blog-controls">
    <div class="control-group">
      <label class="control-label">Category:</label>
      <select bind:value={selectedCategory} class="control-select">
        <option value="all">All Categories</option>
        <option value="Technology">Technology</option>
        <option value="Accessibility">Accessibility</option>
        <option value="Programming">Programming</option>
        <option value="CSS">CSS</option>
        <option value="React">React</option>
        <option value="Database">Database</option>
        <option value="Architecture">Architecture</option>
        <option value="Testing">Testing</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort by:</label>
      <select bind:value={sortBy} class="control-select">
        <option value="date">Date</option>
        <option value="title">Title</option>
        <option value="author">Author</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">View:</label>
      <div class="view-toggle">
        <button 
          class="view-btn" 
          class:active={viewMode === 'grid'}
          on:click={() => viewMode = 'grid'}
        >
          Grid
        </button>
        <button 
          class="view-btn" 
          class:active={viewMode === 'list'}
          on:click={() => viewMode = 'list'}
        >
          List
        </button>
      </div>
    </div>
  </div>

  <div class="featured-section">
    <h2 class="section-title">Featured Articles</h2>
    <div class="featured-articles">
      {#each articles.filter(article => article.featured).slice(0, 3) as article (article.id)}
        <div class="featured-article">
          <div class="featured-image">
            <img src={article.image} alt={article.title} />
            <div class="featured-badge">Featured</div>
          </div>
          <div class="featured-content">
            <div class="article-meta">
              <span class="article-category">{article.category}</span>
              <span class="article-date">{new Date(article.date).toLocaleDateString()}</span>
            </div>
            <h3 class="featured-title">{article.title}</h3>
            <p class="featured-excerpt">{article.excerpt}</p>
            <div class="article-footer">
              <div class="author-info">
                <span class="author-name">By {article.author}</span>
                <span class="read-time">{article.readTime}</span>
              </div>
              <a href="#" class="read-more">Read more</a>
            </div>
          </div>
        </div>
      {/each}
    </div>
  </div>

  <div class="articles-section">
    <div class="section-header">
      <h2 class="section-title">All Articles</h2>
      <div class="section-info">
        <span class="articles-count">{filteredArticles.length} articles</span>
        <span class="last-updated">Updated daily</span>
      </div>
    </div>
    
    {#if viewMode === 'grid'}
      <div class="articles-grid">
        {#each filteredArticles as article (article.id)}
          <article class="article-card">
            <div class="card-image">
              <img src={article.image} alt={article.title} />
              {#if article.featured}
                <div class="featured-badge">Featured</div>
              {/if}
            </div>
            
            <div class="card-content">
              <div class="article-meta">
                <span class="article-category">{article.category}</span>
                <span class="article-date">{new Date(article.date).toLocaleDateString()}</span>
              </div>
              
              <h3 class="article-title">{article.title}</h3>
              <p class="article-excerpt">{article.excerpt}</p>
              
              <div class="article-tags">
                {#each article.tags as tag (tag)}
                  <span class="tag">{tag}</span>
                {/each}
              </div>
              
              <div class="article-footer">
                <div class="author-info">
                  <span class="author-name">By {article.author}</span>
                  <span class="read-time">{article.readTime}</span>
                </div>
                <div class="article-actions">
                  <a href="#" class="action-link">Read more</a>
                  <a href="#" class="action-link">Share</a>
                  <a href="#" class="action-link">Bookmark</a>
                </div>
              </div>
            </div>
          </article>
        {/each}
      </div>
    {:else}
      <div class="articles-list">
        {#each filteredArticles as article (article.id)}
          <article class="article-list-item">
            <div class="list-image">
              <img src={article.image} alt={article.title} />
              {#if article.featured}
                <div class="featured-badge">Featured</div>
              {/if}
            </div>
            
            <div class="list-content">
              <div class="article-meta">
                <span class="article-category">{article.category}</span>
                <span class="article-date">{new Date(article.date).toLocaleDateString()}</span>
                <span class="read-time">{article.readTime}</span>
              </div>
              
              <h3 class="article-title">{article.title}</h3>
              <p class="article-excerpt">{article.excerpt}</p>
              
              <div class="article-tags">
                {#each article.tags as tag (tag)}
                  <span class="tag">{tag}</span>
                {/each}
              </div>
              
              <div class="article-footer">
                <div class="author-info">
                  <span class="author-name">By {article.author}</span>
                </div>
                <div class="article-actions">
                  <a href="#" class="action-link">Read more</a>
                  <a href="#" class="action-link">Share</a>
                  <a href="#" class="action-link">Bookmark</a>
                </div>
              </div>
            </div>
          </article>
        {/each}
      </div>
    {/if}
  </div>

  <div class="newsletter-section">
    <div class="newsletter-content">
      <h3 class="newsletter-title">Stay Updated</h3>
      <p class="newsletter-description">Get the latest articles and tutorials delivered to your inbox</p>
      <form class="newsletter-form">
        <input type="email" placeholder="Enter your email address" class="newsletter-input" />
        <button type="submit" class="newsletter-btn">Subscribe</button>
      </form>
      <p class="newsletter-note">Join 10,000+ developers who read our weekly newsletter</p>
    </div>
  </div>

  <footer class="blog-footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">Tech Blog</h4>
        <p class="footer-description">Your source for the latest in web development, programming, and technology trends.</p>
        <div class="social-links">
          <a href="#" class="social-link">Twitter</a>
          <a href="#" class="social-link">LinkedIn</a>
          <a href="#" class="social-link">GitHub</a>
          <a href="#" class="social-link">YouTube</a>
        </div>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Categories</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Technology</a></li>
          <li><a href="#" class="footer-link">Programming</a></li>
          <li><a href="#" class="footer-link">CSS</a></li>
          <li><a href="#" class="footer-link">React</a></li>
          <li><a href="#" class="footer-link">Accessibility</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Resources</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Tutorials</a></li>
          <li><a href="#" class="footer-link">Documentation</a></li>
          <li><a href="#" class="footer-link">Code Examples</a></li>
          <li><a href="#" class="footer-link">Best Practices</a></li>
          <li><a href="#" class="footer-link">Tools</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Connect</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">About Us</a></li>
          <li><a href="#" class="footer-link">Contact</a></li>
          <li><a href="#" class="footer-link">Privacy Policy</a></li>
          <li><a href="#" class="footer-link">Terms of Service</a></li>
          <li><a href="#" class="footer-link">RSS Feed</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p class="copyright">© 2024 Tech Blog. All rights reserved.</p>
      <div class="footer-meta">
        <a href="#" class="footer-meta-link">Sitemap</a>
        <a href="#" class="footer-meta-link">RSS</a>
        <a href="#" class="footer-meta-link">API</a>
      </div>
    </div>
  </footer>
</div>

<style>
  .blog-platform {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .blog-header {
    background: white;
    padding: 30px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    text-align: center;
    margin-bottom: 30px;
  }
  
  .blog-title {
    margin: 0 0 10px 0;
    font-size: 36px;
    color: #333;
  }
  
  .blog-subtitle {
    margin: 0;
    font-size: 18px;
    color: #666;
  }
  
  .main-navigation {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    gap: 30px;
  }
  
  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    padding: 10px 15px;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .nav-link:hover {
    background: #f8f9fa;
    color: #007bff;
  }
  
  .blog-controls {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    gap: 30px;
    align-items: center;
  }
  
  .control-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .control-label {
    font-weight: bold;
    color: #333;
    white-space: nowrap;
  }
  
  .control-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
    min-width: 150px;
  }
  
  .view-toggle {
    display: flex;
    gap: 5px;
  }
  
  .view-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .view-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .view-btn:hover:not(.active) {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .featured-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
  }
  
  .section-title {
    margin: 0 0 30px 0;
    font-size: 24px;
    color: #333;
  }
  
  .featured-articles {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
  }
  
  .featured-article {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .featured-article:hover {
    transform: translateY(-4px);
  }
  
  .featured-image {
    position: relative;
    height: 200px;
    overflow: hidden;
  }
  
  .featured-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .featured-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    background: #007bff;
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
  }
  
  .featured-content {
    padding: 25px;
  }
  
  .article-meta {
    display: flex;
    gap: 15px;
    margin-bottom: 15px;
    font-size: 14px;
  }
  
  .article-category {
    color: #007bff;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .article-date {
    color: #666;
  }
  
  .featured-title {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
    font-weight: bold;
    line-height: 1.3;
  }
  
  .featured-excerpt {
    margin: 0 0 20px 0;
    color: #666;
    line-height: 1.6;
  }
  
  .article-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .author-info {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .author-name {
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }
  
  .read-time {
    color: #666;
    font-size: 12px;
  }
  
  .read-more {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
    padding: 8px 16px;
    border: 1px solid #007bff;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .read-more:hover {
    background: #007bff;
    color: white;
  }
  
  .articles-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
  }
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
  }
  
  .section-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
  }
  
  .articles-count {
    font-weight: bold;
    color: #333;
  }
  
  .last-updated {
    font-size: 14px;
    color: #666;
  }
  
  .articles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 30px;
  }
  
  .article-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
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
  
  .card-content {
    padding: 25px;
  }
  
  .article-title {
    margin: 0 0 15px 0;
    font-size: 18px;
    color: #333;
    font-weight: bold;
    line-height: 1.3;
  }
  
  .article-excerpt {
    margin: 0 0 15px 0;
    color: #666;
    line-height: 1.6;
  }
  
  .article-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-bottom: 20px;
  }
  
  .tag {
    background: #f8f9fa;
    color: #666;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 500;
  }
  
  .article-actions {
    display: flex;
    gap: 15px;
  }
  
  .action-link {
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: color 0.2s ease;
  }
  
  .action-link:hover {
    color: #0056b3;
    text-decoration: underline;
  }
  
  .articles-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .article-list-item {
    display: flex;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .article-list-item:hover {
    transform: translateY(-2px);
  }
  
  .list-image {
    position: relative;
    width: 200px;
    height: 150px;
    overflow: hidden;
  }
  
  .list-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .list-content {
    flex: 1;
    padding: 25px;
  }
  
  .list-content .article-meta {
    margin-bottom: 15px;
  }
  
  .list-content .article-title {
    font-size: 20px;
    margin-bottom: 15px;
  }
  
  .list-content .article-excerpt {
    margin-bottom: 20px;
  }
  
  .list-content .article-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .newsletter-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 50px 20px;
    text-align: center;
    margin: 50px 0;
  }
  
  .newsletter-content {
    max-width: 600px;
    margin: 0 auto;
  }
  
  .newsletter-title {
    margin: 0 0 15px 0;
    font-size: 28px;
    font-weight: bold;
  }
  
  .newsletter-description {
    margin: 0 0 30px 0;
    font-size: 16px;
    opacity: 0.9;
  }
  
  .newsletter-form {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
  }
  
  .newsletter-input {
    flex: 1;
    padding: 15px 20px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
  }
  
  .newsletter-input:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(255,255,255,0.3);
  }
  
  .newsletter-btn {
    padding: 15px 30px;
    background: #ff6b6b;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .newsletter-btn:hover {
    background: #ff5252;
    transform: translateY(-2px);
  }
  
  .newsletter-note {
    margin: 0;
    font-size: 14px;
    opacity: 0.8;
  }
  
  .blog-footer {
    background: #333;
    color: white;
    padding: 50px 0 20px;
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
    font-weight: bold;
  }
  
  .footer-description {
    margin: 0 0 20px 0;
    color: #ccc;
    line-height: 1.6;
  }
  
  .social-links {
    display: flex;
    gap: 15px;
  }
  
  .social-link {
    color: #ccc;
    text-decoration: none;
    padding: 8px 12px;
    border: 1px solid #555;
    border-radius: 4px;
    transition: all 0.2s ease;
  }
  
  .social-link:hover {
    color: white;
    border-color: #007bff;
    background: #007bff;
  }
  
  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .footer-links li {
    margin-bottom: 10px;
  }
  
  .footer-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s ease;
  }
  
  .footer-link:hover {
    color: white;
  }
  
  .footer-bottom {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    border-top: 1px solid #555;
    padding-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .copyright {
    margin: 0;
    color: #ccc;
  }
  
  .footer-meta {
    display: flex;
    gap: 20px;
  }
  
  .footer-meta-link {
    color: #ccc;
    text-decoration: none;
    font-size: 14px;
    transition: color 0.2s ease;
  }
  
  .footer-meta-link:hover {
    color: white;
  }
  
  @media (max-width: 768px) {
    .blog-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: space-between;
    }
    
    .main-navigation {
      flex-wrap: wrap;
      gap: 15px;
    }
    
    .featured-articles {
      grid-template-columns: 1fr;
    }
    
    .articles-grid {
      grid-template-columns: 1fr;
    }
    
    .article-list-item {
      flex-direction: column;
    }
    
    .list-image {
      width: 100%;
      height: 200px;
    }
    
    .list-content .article-footer {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .newsletter-form {
      flex-direction: column;
    }
    
    .newsletter-btn {
      width: 100%;
    }
    
    .footer-content {
      grid-template-columns: 1fr;
      gap: 30px;
    }
    
    .footer-bottom {
      flex-direction: column;
      gap: 15px;
      text-align: center;
    }
  }
</style>

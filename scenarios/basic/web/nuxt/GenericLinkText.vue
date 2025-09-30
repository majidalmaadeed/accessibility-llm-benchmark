<template>
  <div class="blog-website">
    <header class="site-header">
      <div class="header-content">
        <h1 class="site-title">Tech Blog</h1>
        <nav class="main-navigation">
          <ul class="nav-list">
            <li><a href="/home" class="nav-link">Home</a></li>
            <li><a href="/articles" class="nav-link">Articles</a></li>
            <li><a href="/tutorials" class="nav-link">Tutorials</a></li>
            <li><a href="/reviews" class="nav-link">Reviews</a></li>
            <li><a href="/about" class="nav-link">About</a></li>
            <li><a href="/contact" class="nav-link">Contact</a></li>
          </ul>
        </nav>
      </div>
    </header>

    <main class="main-content">
      <div class="hero-section">
        <div class="hero-content">
          <h2 class="hero-title">Latest Technology Insights</h2>
          <p class="hero-description">
            Stay updated with the latest trends, tutorials, and insights from the world of technology.
          </p>
          <div class="hero-actions">
            <a href="/subscribe" class="cta-button primary">Subscribe</a>
            <a href="/latest" class="cta-button secondary">Read Latest</a>
          </div>
        </div>
        <div class="hero-image">
          <img src="/api/placeholder/600/400" alt="Technology and innovation concept" />
        </div>
      </div>

      <div class="content-layout">
        <div class="main-articles">
          <section class="featured-article">
            <div class="article-image">
              <img src="/api/placeholder/800/400" alt="Artificial Intelligence in Modern Development" />
              <div class="article-badge">Featured</div>
            </div>
            <div class="article-content">
              <div class="article-meta">
                <span class="article-category">Artificial Intelligence</span>
                <span class="article-date">January 15, 2024</span>
                <span class="article-read-time">8 min read</span>
              </div>
              <h2 class="article-title">The Future of AI in Software Development</h2>
              <p class="article-excerpt">
                Explore how artificial intelligence is revolutionizing the way we write, test, and deploy software applications. 
                From automated code generation to intelligent debugging, AI is transforming every aspect of development.
              </p>
              <div class="article-author">
                <img src="/api/placeholder/40/40" alt="Sarah Johnson" class="author-avatar" />
                <div class="author-info">
                  <div class="author-name">Sarah Johnson</div>
                  <div class="author-title">Senior Developer</div>
                </div>
              </div>
              <div class="article-actions">
                <a href="/article/ai-software-development" class="read-more">Read More</a>
                <a href="/share" class="share-link">Share</a>
                <a href="/bookmark" class="bookmark-link">Bookmark</a>
              </div>
            </div>
          </section>

          <section class="articles-grid">
            <h3 class="section-title">Recent Articles</h3>
            <div class="articles-list">
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
                  <div class="card-meta">
                    <span class="card-date">{{ article.date }}</span>
                    <span class="card-read-time">{{ article.readTime }}</span>
                  </div>
                  <h4 class="card-title">{{ article.title }}</h4>
                  <p class="card-excerpt">{{ article.excerpt }}</p>
                  <div class="card-author">
                    <img :src="article.author.avatar" :alt="article.author.name" class="author-avatar" />
                    <span class="author-name">{{ article.author.name }}</span>
                  </div>
                  <div class="card-actions">
                    <a :href="`/article/${article.slug}`" class="read-link">Read More</a>
                    <a href="/like" class="like-link">Like</a>
                    <a href="/comment" class="comment-link">Comment</a>
                  </div>
                </div>
              </article>
            </div>
          </section>
        </div>

        <aside class="sidebar">
          <div class="sidebar-widget">
            <h3>Popular Tags</h3>
            <div class="tags-list">
              <a href="/tag/javascript" class="tag-link">JavaScript</a>
              <a href="/tag/react" class="tag-link">React</a>
              <a href="/tag/nodejs" class="tag-link">Node.js</a>
              <a href="/tag/python" class="tag-link">Python</a>
              <a href="/tag/ai" class="tag-link">AI</a>
              <a href="/tag/webdev" class="tag-link">Web Development</a>
              <a href="/tag/mobile" class="tag-link">Mobile</a>
              <a href="/tag/cloud" class="tag-link">Cloud</a>
            </div>
          </div>

          <div class="sidebar-widget">
            <h3>Newsletter</h3>
            <div class="newsletter-widget">
              <p>Get the latest articles delivered to your inbox</p>
              <form class="newsletter-form">
                <input type="email" placeholder="Enter your email" class="newsletter-input" />
                <button type="submit" class="newsletter-btn">Subscribe</button>
              </form>
            </div>
          </div>

          <div class="sidebar-widget">
            <h3>Related Articles</h3>
            <div class="related-articles">
              <div
                v-for="related in relatedArticles"
                :key="related.id"
                class="related-item"
              >
                <img :src="related.image" :alt="related.title" class="related-image" />
                <div class="related-content">
                  <h4 class="related-title">{{ related.title }}</h4>
                  <div class="related-meta">
                    <span class="related-date">{{ related.date }}</span>
                    <span class="related-views">{{ related.views }} views</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="sidebar-widget">
            <h3>Follow Us</h3>
            <div class="social-links">
              <a href="/twitter" class="social-link">Twitter</a>
              <a href="/linkedin" class="social-link">LinkedIn</a>
              <a href="/github" class="social-link">GitHub</a>
              <a href="/youtube" class="social-link">YouTube</a>
            </div>
          </div>
        </aside>
      </div>

      <div class="pagination-section">
        <div class="pagination">
          <a href="/page/1" class="page-link prev">Previous</a>
          <a href="/page/1" class="page-link">1</a>
          <a href="/page/2" class="page-link active">2</a>
          <a href="/page/3" class="page-link">3</a>
          <a href="/page/4" class="page-link">4</a>
          <a href="/page/5" class="page-link">5</a>
          <a href="/page/3" class="page-link next">Next</a>
        </div>
      </div>
    </main>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Categories</h4>
          <ul class="footer-links">
            <li><a href="/web-development">Web Development</a></li>
            <li><a href="/mobile-development">Mobile Development</a></li>
            <li><a href="/artificial-intelligence">Artificial Intelligence</a></li>
            <li><a href="/cloud-computing">Cloud Computing</a></li>
            <li><a href="/cybersecurity">Cybersecurity</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Resources</h4>
          <ul class="footer-links">
            <li><a href="/tutorials">Tutorials</a></li>
            <li><a href="/documentation">Documentation</a></li>
            <li><a href="/code-samples">Code Samples</a></li>
            <li><a href="/tools">Tools</a></li>
            <li><a href="/books">Recommended Books</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Community</h4>
          <ul class="footer-links">
            <li><a href="/forums">Forums</a></li>
            <li><a href="/discord">Discord</a></li>
            <li><a href="/slack">Slack</a></li>
            <li><a href="/meetups">Meetups</a></li>
            <li><a href="/contribute">Contribute</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>About</h4>
          <ul class="footer-links">
            <li><a href="/about-us">About Us</a></li>
            <li><a href="/team">Our Team</a></li>
            <li><a href="/careers">Careers</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/privacy">Privacy Policy</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Tech Blog. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const articles = ref([
  {
    id: 1,
    title: 'Building Scalable React Applications',
    excerpt: 'Learn best practices for creating maintainable and scalable React applications with modern patterns and tools.',
    image: '/api/placeholder/400/250',
    category: 'React',
    date: 'Jan 14, 2024',
    readTime: '6 min',
    author: {
      name: 'Mike Chen',
      avatar: '/api/placeholder/30/30'
    },
    slug: 'scalable-react-applications'
  },
  {
    id: 2,
    title: 'Introduction to Machine Learning with Python',
    excerpt: 'A comprehensive guide to getting started with machine learning using Python and popular libraries.',
    image: '/api/placeholder/400/250',
    category: 'Python',
    date: 'Jan 13, 2024',
    readTime: '12 min',
    author: {
      name: 'Dr. Sarah Wilson',
      avatar: '/api/placeholder/30/30'
    },
    slug: 'machine-learning-python'
  },
  {
    id: 3,
    title: 'Docker for Developers: Complete Guide',
    excerpt: 'Master containerization with Docker and learn how to streamline your development workflow.',
    image: '/api/placeholder/400/250',
    category: 'DevOps',
    date: 'Jan 12, 2024',
    readTime: '10 min',
    author: {
      name: 'Alex Rodriguez',
      avatar: '/api/placeholder/30/30'
    },
    slug: 'docker-developers-guide'
  },
  {
    id: 4,
    title: 'Advanced CSS Techniques for Modern Web Design',
    excerpt: 'Explore cutting-edge CSS features and techniques to create stunning, responsive web designs.',
    image: '/api/placeholder/400/250',
    category: 'CSS',
    date: 'Jan 11, 2024',
    readTime: '8 min',
    author: {
      name: 'Emma Davis',
      avatar: '/api/placeholder/30/30'
    },
    slug: 'advanced-css-techniques'
  }
])

const relatedArticles = ref([
  {
    id: 1,
    title: 'Vue.js vs React: Which Should You Choose?',
    image: '/api/placeholder/80/60',
    date: 'Jan 10, 2024',
    views: '2.5K'
  },
  {
    id: 2,
    title: 'TypeScript Best Practices for Large Projects',
    image: '/api/placeholder/80/60',
    date: 'Jan 9, 2024',
    views: '1.8K'
  },
  {
    id: 3,
    title: 'Building RESTful APIs with Node.js',
    image: '/api/placeholder/80/60',
    date: 'Jan 8, 2024',
    views: '3.2K'
  }
])
</script>

<style scoped>
.blog-website {
  font-family: Arial, sans-serif;
  line-height: 1.6;
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
  height: 70px;
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

.nav-list {
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
}

.nav-link:hover {
  color: #007bff;
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
  margin-bottom: 60px;
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

.hero-description {
  margin: 0 0 30px 0;
  font-size: 18px;
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

.content-layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
  margin-bottom: 40px;
}

.featured-article {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  margin-bottom: 40px;
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
  background: #ff6b6b;
  color: white;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: bold;
  text-transform: uppercase;
}

.article-content {
  padding: 40px;
}

.article-meta {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
  font-size: 14px;
  color: #666;
}

.article-category {
  background: #e3f2fd;
  color: #1976d2;
  padding: 4px 12px;
  border-radius: 12px;
  font-weight: bold;
}

.article-title {
  margin: 0 0 20px 0;
  font-size: 32px;
  font-weight: bold;
  color: #333;
  line-height: 1.2;
}

.article-excerpt {
  margin: 0 0 30px 0;
  font-size: 18px;
  color: #666;
  line-height: 1.6;
}

.article-author {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 30px;
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

.article-actions {
  display: flex;
  gap: 20px;
}

.read-more,
.share-link,
.bookmark-link {
  padding: 10px 20px;
  border-radius: 6px;
  text-decoration: none;
  font-weight: bold;
  transition: all 0.2s ease;
}

.read-more {
  background: #007bff;
  color: white;
}

.read-more:hover {
  background: #0056b3;
}

.share-link,
.bookmark-link {
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.share-link:hover,
.bookmark-link:hover {
  background: #e9ecef;
}

.section-title {
  margin: 0 0 30px 0;
  font-size: 24px;
  color: #333;
}

.articles-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
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

.card-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
  font-size: 12px;
  color: #999;
}

.card-title {
  margin: 0 0 15px 0;
  font-size: 20px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.card-excerpt {
  margin: 0 0 20px 0;
  color: #666;
  line-height: 1.5;
}

.card-author {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
}

.card-author .author-avatar {
  width: 30px;
  height: 30px;
}

.card-author .author-name {
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.card-actions {
  display: flex;
  gap: 15px;
}

.read-link,
.like-link,
.comment-link {
  padding: 8px 16px;
  border-radius: 4px;
  text-decoration: none;
  font-size: 14px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.read-link {
  background: #007bff;
  color: white;
}

.read-link:hover {
  background: #0056b3;
}

.like-link,
.comment-link {
  background: #f8f9fa;
  color: #333;
  border: 1px solid #ddd;
}

.like-link:hover,
.comment-link:hover {
  background: #e9ecef;
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

.sidebar-widget h3 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

.tags-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.tag-link {
  background: #f8f9fa;
  color: #333;
  padding: 6px 12px;
  border-radius: 15px;
  text-decoration: none;
  font-size: 12px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.tag-link:hover {
  background: #007bff;
  color: white;
}

.newsletter-widget p {
  margin: 0 0 15px 0;
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

.related-articles {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.related-item {
  display: flex;
  gap: 15px;
  padding: 10px;
  border-radius: 6px;
  transition: background-color 0.2s ease;
}

.related-item:hover {
  background: #f8f9fa;
}

.related-image {
  width: 80px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  flex-shrink: 0;
}

.related-content {
  flex: 1;
}

.related-title {
  margin: 0 0 8px 0;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.related-meta {
  display: flex;
  gap: 10px;
  font-size: 12px;
  color: #666;
}

.social-links {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.social-link {
  color: #333;
  text-decoration: none;
  padding: 8px 0;
  border-bottom: 1px solid #eee;
  transition: color 0.2s ease;
}

.social-link:hover {
  color: #007bff;
}

.pagination-section {
  display: flex;
  justify-content: center;
  margin: 40px 0;
}

.pagination {
  display: flex;
  gap: 5px;
}

.page-link {
  padding: 10px 15px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  text-decoration: none;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.page-link:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.page-link.active {
  background: #007bff;
  color: white;
  border-color: #007bff;
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

  .nav-list {
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

  .content-layout {
    grid-template-columns: 1fr;
  }

  .articles-list {
    grid-template-columns: 1fr;
  }

  .article-actions {
    flex-direction: column;
  }

  .card-actions {
    flex-direction: column;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}
</style>

import { useState } from 'react';

export default function GenericLinkText() {
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState('date');
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 6;

  const categories = [
    { id: 'all', name: 'All Articles' },
    { id: 'technology', name: 'Technology' },
    { id: 'business', name: 'Business' },
    { id: 'lifestyle', name: 'Lifestyle' },
    { id: 'health', name: 'Health' },
    { id: 'education', name: 'Education' }
  ];

  const articles = [
    {
      id: 1,
      title: 'The Future of Artificial Intelligence in Healthcare',
      excerpt: 'Exploring how AI is revolutionizing medical diagnosis and treatment.',
      category: 'technology',
      author: 'Dr. Sarah Johnson',
      publishDate: '2024-01-15',
      readTime: '8 min read',
      image: 'ai-healthcare.jpg',
      views: 1247,
      likes: 89
    },
    {
      id: 2,
      title: 'Sustainable Business Practices for Modern Companies',
      excerpt: 'How companies can implement eco-friendly strategies while maintaining profitability.',
      category: 'business',
      author: 'Michael Chen',
      publishDate: '2024-01-14',
      readTime: '6 min read',
      image: 'sustainable-business.jpg',
      views: 892,
      likes: 67
    },
    {
      id: 3,
      title: 'Mindfulness and Mental Health in the Digital Age',
      excerpt: 'Practical techniques for maintaining mental wellness in our connected world.',
      category: 'lifestyle',
      author: 'Emma Rodriguez',
      publishDate: '2024-01-13',
      readTime: '5 min read',
      image: 'mindfulness.jpg',
      views: 1563,
      likes: 124
    },
    {
      id: 4,
      title: 'Nutrition Science: Debunking Common Myths',
      excerpt: 'Evidence-based insights into healthy eating and nutrition misconceptions.',
      category: 'health',
      author: 'Dr. James Wilson',
      publishDate: '2024-01-12',
      readTime: '7 min read',
      image: 'nutrition-myths.jpg',
      views: 743,
      likes: 56
    },
    {
      id: 5,
      title: 'Online Learning: The New Era of Education',
      excerpt: 'How digital platforms are transforming traditional educational methods.',
      category: 'education',
      author: 'Professor Lisa Kim',
      publishDate: '2024-01-11',
      readTime: '9 min read',
      image: 'online-learning.jpg',
      views: 2105,
      likes: 178
    },
    {
      id: 6,
      title: 'Cybersecurity Best Practices for Small Businesses',
      excerpt: 'Essential security measures every small business should implement.',
      category: 'technology',
      author: 'Alex Thompson',
      publishDate: '2024-01-10',
      readTime: '6 min read',
      image: 'cybersecurity.jpg',
      views: 934,
      likes: 72
    },
    {
      id: 7,
      title: 'The Psychology of Consumer Behavior',
      excerpt: 'Understanding what drives purchasing decisions in the modern marketplace.',
      category: 'business',
      author: 'Dr. Maria Garcia',
      publishDate: '2024-01-09',
      readTime: '8 min read',
      image: 'consumer-psychology.jpg',
      views: 1187,
      likes: 95
    },
    {
      id: 8,
      title: 'Home Workout Routines for Busy Professionals',
      excerpt: 'Effective exercise strategies that fit into a hectic work schedule.',
      category: 'lifestyle',
      author: 'Fitness Coach Tom',
      publishDate: '2024-01-08',
      readTime: '4 min read',
      image: 'home-workouts.jpg',
      views: 1456,
      likes: 103
    }
  ];

  const filteredArticles = articles.filter(article => {
    const matchesCategory = selectedCategory === 'all' || article.category === selectedCategory;
    const matchesSearch = article.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         article.excerpt.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         article.author.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const sortedArticles = [...filteredArticles].sort((a, b) => {
    switch(sortBy) {
      case 'views':
        return b.views - a.views;
      case 'likes':
        return b.likes - a.likes;
      case 'title':
        return a.title.localeCompare(b.title);
      case 'date':
      default:
        return new Date(b.publishDate) - new Date(a.publishDate);
    }
  });

  const totalPages = Math.ceil(sortedArticles.length / itemsPerPage);
  const paginatedArticles = sortedArticles.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  const getCategoryColor = (category) => {
    const colors = {
      technology: '#007bff',
      business: '#28a745',
      lifestyle: '#ffc107',
      health: '#dc3545',
      education: '#6f42c1'
    };
    return colors[category] || '#6c757d';
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const handleAction = (action, article) => {
    alert(`${action} action performed on "${article.title}"`);
  };

  const goToPage = (page) => {
    setCurrentPage(page);
  };

  const nextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const prevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <div className="blog-platform">
      <header className="blog-header">
        <h1>Knowledge Hub</h1>
        <p>Discover insights, trends, and expert perspectives across various topics</p>
      </header>

      <div className="blog-controls">
        <div className="search-section">
          <input 
            type="text" 
            placeholder="Search articles, authors, or topics..." 
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filter-section">
          <select 
            value={selectedCategory} 
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="category-filter"
          >
            {categories.map(category => (
              <option key={category.id} value={category.id}>
                {category.name}
              </option>
            ))}
          </select>

          <select 
            value={sortBy} 
            onChange={(e) => setSortBy(e.target.value)}
            className="sort-filter"
          >
            <option value="date">Latest First</option>
            <option value="views">Most Viewed</option>
            <option value="likes">Most Liked</option>
            <option value="title">Alphabetical</option>
          </select>
        </div>
      </div>

      <div className="blog-stats">
        <div className="stat-card">
          <div className="stat-number">{articles.length}</div>
          <div className="stat-label">Total Articles</div>
        </div>
        <div className="stat-card">
          <div className="stat-number">{articles.reduce((sum, article) => sum + article.views, 0).toLocaleString()}</div>
          <div className="stat-label">Total Views</div>
        </div>
        <div className="stat-card">
          <div className="stat-number">{articles.reduce((sum, article) => sum + article.likes, 0).toLocaleString()}</div>
          <div className="stat-label">Total Likes</div>
        </div>
        <div className="stat-card">
          <div className="stat-number">{new Set(articles.map(a => a.author)).size}</div>
          <div className="stat-label">Contributors</div>
        </div>
      </div>

      <div className="articles-grid">
        {paginatedArticles.map(article => (
          <article key={article.id} className="article-card">
            <div className="article-image">
              <img src={`/images/${article.image}`} alt="Article image" />
              <div 
                className="category-badge" 
                style={{ backgroundColor: getCategoryColor(article.category) }}
              >
                {article.category}
              </div>
            </div>

            <div className="article-content">
              <h2 className="article-title">{article.title}</h2>
              <p className="article-excerpt">{article.excerpt}</p>
              
              <div className="article-meta">
                <div className="author-info">
                  <span className="author-name">{article.author}</span>
                  <span className="publish-date">{formatDate(article.publishDate)}</span>
                </div>
                <div className="article-stats">
                  <span className="read-time">{article.readTime}</span>
                  <span className="views">👁️ {article.views}</span>
                  <span className="likes">❤️ {article.likes}</span>
                </div>
              </div>

              <div className="article-actions">
                <button 
                  className="action-btn primary" 
                  onClick={() => handleAction('Read More', article)}
                >
                  Read More
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Share', article)}
                >
                  Share
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Bookmark', article)}
                >
                  Bookmark
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Like', article)}
                >
                  Like
                </button>
              </div>
            </div>
          </article>
        ))}
      </div>

      {sortedArticles.length === 0 && (
        <div className="no-results">
          <h3>No articles found</h3>
          <p>Try adjusting your search or filter criteria</p>
        </div>
      )}

      {totalPages > 1 && (
        <div className="pagination">
          <button 
            className="page-btn" 
            onClick={prevPage} 
            disabled={currentPage === 1}
          >
            Previous
          </button>
          
          {Array(totalPages).fill(0).map((_, i) => (
            <button 
              key={i}
              className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
              onClick={() => goToPage(i + 1)}
            >
              {i + 1}
            </button>
          ))}
          
          <button 
            className="page-btn" 
            onClick={nextPage} 
            disabled={currentPage === totalPages}
          >
            Next
          </button>
        </div>
      )}

      <div className="newsletter-section">
        <div className="newsletter-content">
          <h3>Stay Updated</h3>
          <p>Get the latest articles delivered to your inbox</p>
          <div className="newsletter-form">
            <input type="email" placeholder="Enter your email address" className="email-input" />
            <button className="subscribe-btn">Subscribe</button>
          </div>
        </div>
      </div>

      <style jsx>{`
        .blog-platform {
          max-width: 1200px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .blog-header {
          text-align: center;
          margin-bottom: 40px;
        }

        .blog-header h1 {
          margin: 0 0 10px 0;
          font-size: 36px;
          color: #333;
        }

        .blog-header p {
          margin: 0;
          color: #666;
          font-size: 18px;
        }

        .blog-controls {
          display: flex;
          flex-direction: column;
          gap: 20px;
          margin-bottom: 30px;
          padding: 25px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .search-section {
          display: flex;
          justify-content: center;
        }

        .search-input {
          width: 100%;
          max-width: 500px;
          padding: 15px 20px;
          border: 2px solid #ddd;
          border-radius: 25px;
          font-size: 16px;
          transition: border-color 0.2s ease;
        }

        .search-input:focus {
          outline: none;
          border-color: #007bff;
        }

        .filter-section {
          display: flex;
          gap: 20px;
          align-items: center;
          justify-content: center;
          flex-wrap: wrap;
        }

        .category-filter,
        .sort-filter {
          padding: 10px 15px;
          border: 2px solid #ddd;
          border-radius: 6px;
          background: white;
          font-size: 14px;
          min-width: 150px;
        }

        .blog-stats {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 20px;
          margin-bottom: 40px;
        }

        .stat-card {
          background: white;
          padding: 25px;
          border-radius: 8px;
          text-align: center;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .stat-number {
          font-size: 28px;
          font-weight: bold;
          color: #007bff;
          margin-bottom: 5px;
        }

        .stat-label {
          font-size: 14px;
          color: #666;
        }

        .articles-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
          gap: 30px;
          margin-bottom: 40px;
        }

        .article-card {
          background: white;
          border-radius: 12px;
          box-shadow: 0 4px 12px rgba(0,0,0,0.1);
          overflow: hidden;
          transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .article-card:hover {
          transform: translateY(-5px);
          box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }

        .article-image {
          position: relative;
          height: 200px;
          overflow: hidden;
        }

        .article-image img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .category-badge {
          position: absolute;
          top: 15px;
          left: 15px;
          color: white;
          padding: 6px 12px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .article-content {
          padding: 25px;
        }

        .article-title {
          margin: 0 0 15px 0;
          font-size: 20px;
          color: #333;
          line-height: 1.3;
        }

        .article-excerpt {
          margin: 0 0 20px 0;
          color: #666;
          line-height: 1.5;
          font-size: 14px;
        }

        .article-meta {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
          padding-bottom: 15px;
          border-bottom: 1px solid #eee;
        }

        .author-info {
          display: flex;
          flex-direction: column;
          gap: 4px;
        }

        .author-name {
          font-weight: bold;
          color: #333;
          font-size: 14px;
        }

        .publish-date {
          color: #666;
          font-size: 12px;
        }

        .article-stats {
          display: flex;
          gap: 15px;
          font-size: 12px;
          color: #666;
        }

        .article-actions {
          display: flex;
          gap: 10px;
          flex-wrap: wrap;
        }

        .action-btn {
          padding: 8px 16px;
          border: none;
          border-radius: 20px;
          cursor: pointer;
          font-size: 12px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
        }

        .action-btn.primary:hover {
          background: #0056b3;
        }

        .action-btn.secondary {
          background: #f8f9fa;
          color: #666;
          border: 1px solid #ddd;
        }

        .action-btn.secondary:hover {
          background: #e9ecef;
          color: #333;
        }

        .no-results {
          text-align: center;
          padding: 60px 20px;
          color: #666;
        }

        .no-results h3 {
          margin: 0 0 10px 0;
          font-size: 24px;
        }

        .pagination {
          display: flex;
          justify-content: center;
          gap: 8px;
          margin: 40px 0;
        }

        .page-btn {
          padding: 10px 16px;
          border: 2px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 6px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .page-btn:hover:not(:disabled) {
          border-color: #007bff;
          color: #007bff;
        }

        .page-btn.active {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .page-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .newsletter-section {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          padding: 40px;
          border-radius: 12px;
          text-align: center;
        }

        .newsletter-content h3 {
          margin: 0 0 10px 0;
          font-size: 28px;
        }

        .newsletter-content p {
          margin: 0 0 25px 0;
          font-size: 16px;
          opacity: 0.9;
        }

        .newsletter-form {
          display: flex;
          gap: 15px;
          max-width: 400px;
          margin: 0 auto;
        }

        .email-input {
          flex: 1;
          padding: 12px 16px;
          border: none;
          border-radius: 25px;
          font-size: 16px;
        }

        .email-input:focus {
          outline: none;
        }

        .subscribe-btn {
          background: white;
          color: #667eea;
          border: none;
          padding: 12px 24px;
          border-radius: 25px;
          font-weight: bold;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .subscribe-btn:hover {
          background: #f8f9fa;
        }
      `}</style>
    </div>
  );
}

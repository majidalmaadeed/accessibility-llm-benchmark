import React, { useState, useEffect } from 'react';

const AutoRefreshContentDisruption = () => {
  const [articles, setArticles] = useState([]);
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [lastUpdate, setLastUpdate] = useState(new Date());
  const [showNotification, setShowNotification] = useState(false);

  const mockArticles = [
    {
      id: 1,
      title: 'Breaking: New Technology Breakthrough Announced',
      summary: 'Scientists have made a significant discovery that could revolutionize the industry.',
      timestamp: new Date(Date.now() - 300000),
      category: 'Technology',
      read: false
    },
    {
      id: 2,
      title: 'Market Update: Stock Prices Reach New High',
      summary: 'The stock market has reached unprecedented levels with significant gains.',
      timestamp: new Date(Date.now() - 600000),
      category: 'Finance',
      read: false
    },
    {
      id: 3,
      title: 'Weather Alert: Severe Storm Warning',
      summary: 'Meteorologists are warning of severe weather conditions in the region.',
      timestamp: new Date(Date.now() - 900000),
      category: 'Weather',
      read: false
    },
    {
      id: 4,
      title: 'Sports: Championship Game Results',
      summary: 'The final game of the season has concluded with surprising results.',
      timestamp: new Date(Date.now() - 1200000),
      category: 'Sports',
      read: false
    }
  ];

  useEffect(() => {
    // Initial load
    setArticles(mockArticles);
    
    // Auto-refresh every 30 seconds
    const refreshInterval = setInterval(() => {
      refreshContent();
    }, 30000);

    return () => clearInterval(refreshInterval);
  }, []);

  const refreshContent = async () => {
    setIsRefreshing(true);
    
    // Simulate API call
    setTimeout(() => {
      // Simulate new articles being added
      const newArticles = [...mockArticles];
      const randomIndex = Math.floor(Math.random() * newArticles.length);
      const updatedArticle = {
        ...newArticles[randomIndex],
        title: newArticles[randomIndex].title + ' (Updated)',
        timestamp: new Date()
      };
      newArticles[randomIndex] = updatedArticle;
      
      setArticles(newArticles);
      setLastUpdate(new Date());
      setIsRefreshing(false);
      
      // Show notification
      setShowNotification(true);
      setTimeout(() => setShowNotification(false), 5000);
      
      // MISSING: Screen reader announcement of content changes
      // Should announce "Content updated" or "New articles available"
    }, 1000);
  };

  const handleManualRefresh = () => {
    refreshContent();
  };

  const markAsRead = (articleId) => {
    setArticles(prevArticles =>
      prevArticles.map(article =>
        article.id === articleId ? { ...article, read: true } : article
      )
    );
  };

  const formatTimestamp = (timestamp) => {
    const now = new Date();
    const diff = now - timestamp;
    const minutes = Math.floor(diff / 60000);
    
    if (minutes < 1) return 'Just now';
    if (minutes < 60) return `${minutes} minute${minutes !== 1 ? 's' : ''} ago`;
    const hours = Math.floor(minutes / 60);
    return `${hours} hour${hours !== 1 ? 's' : ''} ago`;
  };

  return (
    <div className="news-container">
      <div className="main-content">
        <h1>News Feed</h1>
        <p>Stay updated with the latest news and articles.</p>
        
        {/* Header with Refresh Controls */}
        <div className="header">
          <div className="header-info">
            <h2>Latest News</h2>
            <p className="last-updated">Last updated: {formatTimestamp(lastUpdate)}</p>
          </div>
          
          <button
            onClick={handleManualRefresh}
            disabled={isRefreshing}
            className={`refresh-button ${isRefreshing ? 'loading' : ''}`}
          >
            <span>{isRefreshing ? '⟳' : '⟳'}</span>
            {isRefreshing ? 'Refreshing...' : 'Refresh'}
          </button>
        </div>

        {/* Update Notification - MISSING PROPER ARIA ATTRIBUTES */}
        {showNotification && (
          <div
            className="notification"
            role="alert"
            aria-live="polite"
          >
            <span>✓ Content has been updated with new articles</span>
            <button
              onClick={() => setShowNotification(false)}
              className="dismiss-button"
              aria-label="Dismiss notification"
            >
              ×
            </button>
          </div>
        )}

        {/* Articles List */}
        <div className="articles-section">
          {articles.map((article) => (
            <article
              key={article.id}
              className={`article-card ${article.read ? 'read' : ''}`}
            >
              <div className="article-header">
                <div className="article-content">
                  <h3 className="article-title">{article.title}</h3>
                  <p className="article-summary">{article.summary}</p>
                  <div className="article-meta">
                    <span>Category: {article.category}</span>
                    <span>{formatTimestamp(article.timestamp)}</span>
                  </div>
                </div>
                
                {!article.read && (
                  <button
                    onClick={() => markAsRead(article.id)}
                    className="mark-read-button"
                  >
                    Mark as Read
                  </button>
                )}
              </div>
            </article>
          ))}
        </div>

        {/* Auto-refresh Indicator */}
        <div className="auto-refresh-indicator">
          <span>Auto-refreshing every 30 seconds</span>
          {isRefreshing && (
            <span className="refreshing-indicator">• Refreshing now...</span>
          )}
        </div>
      </div>

      <div className="accessibility-info">
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Content disruption:</strong> Auto-refresh interrupts user reading without warning</li>
          <li><strong>Missing announcements:</strong> Screen readers don't announce content updates</li>
          <li><strong>No user control:</strong> Users can't disable auto-refresh or control timing</li>
          <li><strong>Focus disruption:</strong> Page refreshes can move focus unexpectedly</li>
          <li><strong>Missing live regions:</strong> Dynamic content changes not properly announced</li>
          <li><strong>No pause mechanism:</strong> No way to pause auto-refresh during reading</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>aria-live="polite"</code> regions for content announcements</li>
          <li>Provide user control to disable/pause auto-refresh</li>
          <li>Announce updates without disrupting current reading</li>
          <li>Add <code>aria-atomic="false"</code> for granular updates</li>
          <li>Implement focus management during content updates</li>
          <li>Provide clear indicators of auto-refresh status</li>
        </ul>
      </div>

      <style jsx>{`
        .news-container {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background-color: #f5f5f5;
        }

        .main-content {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
          padding-bottom: 15px;
          border-bottom: 1px solid #eee;
        }

        .header-info h2 {
          margin: 0 0 5px 0;
          color: #333;
        }

        .last-updated {
          margin: 0;
          color: #666;
          font-size: 14px;
        }

        .refresh-button {
          background: #007bff;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
          font-size: 14px;
          display: flex;
          align-items: center;
          gap: 8px;
        }

        .refresh-button:hover:not(:disabled) {
          background: #0056b3;
        }

        .refresh-button:disabled,
        .refresh-button.loading {
          background: #6c757d;
          cursor: not-allowed;
        }

        .notification {
          background: #d4edda;
          border: 1px solid #c3e6cb;
          color: #155724;
          padding: 12px 16px;
          border-radius: 4px;
          margin-bottom: 20px;
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .dismiss-button {
          background: none;
          border: none;
          color: #155724;
          cursor: pointer;
          font-size: 18px;
          padding: 0;
          margin-left: 10px;
        }

        .articles-section {
          margin-bottom: 20px;
        }

        .article-card {
          border: 1px solid #ddd;
          border-radius: 8px;
          padding: 20px;
          margin-bottom: 16px;
          background: white;
          border-left: 4px solid #007bff;
          transition: all 0.3s ease;
        }

        .article-card.read {
          background: #f8f9fa;
          border-left-color: #28a745;
        }

        .article-header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 10px;
        }

        .article-content {
          flex: 1;
        }

        .article-title {
          margin: 0 0 8px 0;
          color: #333;
          font-size: 18px;
          font-weight: bold;
        }

        .article-card.read .article-title {
          font-weight: normal;
        }

        .article-summary {
          margin: 0 0 8px 0;
          color: #666;
          font-size: 14px;
          line-height: 1.4;
        }

        .article-meta {
          display: flex;
          gap: 16px;
          font-size: 12px;
          color: #999;
        }

        .mark-read-button {
          background: #28a745;
          color: white;
          border: none;
          padding: 4px 8px;
          border-radius: 4px;
          cursor: pointer;
          font-size: 12px;
          margin-left: 10px;
        }

        .auto-refresh-indicator {
          text-align: center;
          padding: 10px;
          background: #f8f9fa;
          border-radius: 4px;
          font-size: 12px;
          color: #666;
        }

        .refreshing-indicator {
          margin-left: 10px;
          color: #007bff;
        }

        .accessibility-info {
          margin-top: 30px;
          padding: 20px;
          background-color: #e9ecef;
          border-radius: 4px;
        }

        .accessibility-info h3 {
          margin-top: 0;
        }

        .accessibility-info ul {
          margin-bottom: 20px;
        }

        .accessibility-info li {
          margin-bottom: 8px;
        }
      `}</style>
    </div>
  );
};

export default AutoRefreshContentDisruption;
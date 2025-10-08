'use client';

import React, { useState, useEffect, useRef } from 'react';

const AutoRefreshContentDisruption = () => {
  const [articles, setArticles] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [lastUpdate, setLastUpdate] = useState(new Date());
  const [autoRefresh, setAutoRefresh] = useState(true);
  const [refreshInterval, setRefreshInterval] = useState(30);
  const intervalRef = useRef(null);
  const [userReadingArticle, setUserReadingArticle] = useState(null);

  const mockArticles = [
    { id: 1, title: 'Breaking: New Technology Breakthrough', content: 'Scientists have made a significant discovery...', timestamp: new Date(), category: 'Technology' },
    { id: 2, title: 'Market Update: Stock Prices Rise', content: 'The stock market showed positive trends today...', timestamp: new Date(), category: 'Finance' },
    { id: 3, title: 'Sports: Championship Game Results', content: 'The final game ended with an unexpected victory...', timestamp: new Date(), category: 'Sports' },
    { id: 4, title: 'Health: New Study on Nutrition', content: 'Recent research reveals important findings...', timestamp: new Date(), category: 'Health' },
    { id: 5, title: 'Entertainment: Award Show Highlights', content: 'The annual awards ceremony featured many surprises...', timestamp: new Date(), category: 'Entertainment' }
  ];

  const fetchArticles = async () => {
    setIsLoading(true);
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // Simulate new articles being added
    const newArticles = [...mockArticles];
    if (Math.random() > 0.7) {
      const newArticle = {
        id: Date.now(),
        title: `Breaking News Update ${new Date().getHours()}:${new Date().getMinutes()}`,
        content: 'This is a new breaking news article that just came in...',
        timestamp: new Date(),
        category: 'Breaking'
      };
      newArticles.unshift(newArticle);
    }
    
    setArticles(newArticles);
    setLastUpdate(new Date());
    setIsLoading(false);
  };

  const handleRefresh = () => {
    fetchArticles();
  };

  const handleArticleClick = (articleId) => {
    setUserReadingArticle(articleId);
  };

  const handleCloseArticle = () => {
    setUserReadingArticle(null);
  };

  // Auto-refresh setup
  useEffect(() => {
    if (autoRefresh) {
      intervalRef.current = setInterval(() => {
        fetchArticles();
      }, refreshInterval * 1000);
    } else {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    }

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    };
  }, [autoRefresh, refreshInterval]);

  // Initial load
  useEffect(() => {
    fetchArticles();
  }, []);

  const selectedArticle = articles.find(a => a.id === userReadingArticle);

  return (
    <div className="main-container">
      <div className="main-content">
        <div className="header">
          <div>
            <h1>News Feed</h1>
            <p>Stay updated with the latest news and articles.</p>
          </div>
          <div className="header-controls">
            <button onClick={handleRefresh} disabled={isLoading} className="refresh-button">
              {isLoading ? 'Refreshing...' : 'Refresh Now'}
            </button>
            <div className="last-update">
              Last updated: {lastUpdate.toLocaleTimeString()}
            </div>
          </div>
        </div>

        {/* Auto-refresh Controls */}
        <div className="auto-refresh-controls">
          <label className="control-label">
            <input type="checkbox" checked={autoRefresh} onChange={(e) => setAutoRefresh(e.target.checked)} />
            Auto-refresh every
          </label>
          <select value={refreshInterval} onChange={(e) => setRefreshInterval(Number(e.target.value))} className="interval-select">
            <option value={10}>10 seconds</option>
            <option value={30}>30 seconds</option>
            <option value={60}>1 minute</option>
            <option value={300}>5 minutes</option>
          </select>
          {autoRefresh && (
            <span className="next-refresh">
              Next refresh in: {refreshInterval}s
            </span>
          )}
        </div>

        {/* Update Notification */}
        {isLoading && (
          <div className="update-notification">
            <strong>🔄 Updating content...</strong> New articles are being loaded.
          </div>
        )}

        {/* Articles List */}
        <div className="articles-section">
          {articles.map((article) => (
            <div key={article.id} onClick={() => handleArticleClick(article.id)} className="article-item">
              <div className="article-header">
                <h3>{article.title}</h3>
                <span className="category-badge">{article.category}</span>
              </div>
              <p className="article-preview">{article.content.substring(0, 150)}...</p>
              <div className="article-timestamp">{article.timestamp.toLocaleString()}</div>
            </div>
          ))}
        </div>

        {/* Article Detail Modal */}
        {userReadingArticle && (
          <div className="modal-overlay" onClick={handleCloseArticle}>
            <div className="modal-content" onClick={(e) => e.stopPropagation()}>
              {selectedArticle && (
                <div className="article-detail">
                  <div className="modal-header">
                    <h2>{selectedArticle.title}</h2>
                    <button onClick={handleCloseArticle} className="close-button">×</button>
                  </div>
                  <div className="article-meta">
                    <span className="category-badge">{selectedArticle.category}</span>
                    <span className="timestamp">{selectedArticle.timestamp.toLocaleString()}</span>
                  </div>
                  <div className="article-content">
                    <p>{selectedArticle.content}</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                    <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                  </div>
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      <style jsx>{`
        .main-container {
          font-family: Arial, sans-serif;
          max-width: 1000px;
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
        }

        .header-controls {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .refresh-button {
          background-color: #007bff;
          color: white;
          padding: 8px 16px;
          border: none;
          border-radius: 4px;
          font-size: 14px;
          cursor: pointer;
        }

        .refresh-button:disabled {
          background-color: #6c757d;
          cursor: not-allowed;
        }

        .last-update {
          font-size: 12px;
          color: #666;
        }

        .auto-refresh-controls {
          padding: 15px;
          background-color: #e3f2fd;
          border-radius: 4px;
          margin-bottom: 20px;
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .control-label {
          display: flex;
          align-items: center;
          gap: 5px;
          cursor: pointer;
        }

        .interval-select {
          padding: 4px 8px;
          border: 1px solid #ddd;
          border-radius: 4px;
        }

        .next-refresh {
          font-size: 12px;
          color: #666;
        }

        .update-notification {
          padding: 10px 15px;
          background-color: #d4edda;
          border: 1px solid #c3e6cb;
          border-radius: 4px;
          margin-bottom: 20px;
          color: #155724;
        }

        .articles-section {
          margin-top: 20px;
        }

        .article-item {
          padding: 20px;
          border: 1px solid #ddd;
          border-radius: 8px;
          margin-bottom: 16px;
          background-color: #fafafa;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .article-item:hover {
          background-color: #f0f0f0;
        }

        .article-header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 8px;
        }

        .article-header h3 {
          margin: 0;
          color: #333;
          font-size: 18px;
        }

        .category-badge {
          font-size: 12px;
          color: #666;
          background-color: #e9ecef;
          padding: 2px 8px;
          border-radius: 12px;
        }

        .article-preview {
          margin: 0 0 8px 0;
          color: #666;
          line-height: 1.5;
        }

        .article-timestamp {
          font-size: 12px;
          color: #999;
        }

        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 1000;
        }

        .modal-content {
          background: white;
          padding: 30px;
          border-radius: 8px;
          max-width: 600px;
          width: 90%;
          max-height: 80%;
          overflow: auto;
        }

        .modal-header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 20px;
        }

        .modal-header h2 {
          margin: 0;
          color: #333;
        }

        .close-button {
          background: none;
          border: none;
          font-size: 24px;
          cursor: pointer;
          color: #666;
        }

        .article-meta {
          margin-bottom: 15px;
        }

        .timestamp {
          margin-left: 10px;
          font-size: 12px;
          color: #999;
        }

        .article-content {
          line-height: 1.6;
          color: #333;
        }
      `}</style>
    </div>
  );
};

export default AutoRefreshContentDisruption;
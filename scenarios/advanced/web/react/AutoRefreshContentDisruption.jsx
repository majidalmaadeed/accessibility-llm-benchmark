import React, { useState, useEffect, useRef } from 'react';

const AutoRefreshContentDisruption = () => {
  const [articles, setArticles] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [lastUpdate, setLastUpdate] = useState(new Date());
  const [autoRefresh, setAutoRefresh] = useState(true);
  const [refreshInterval, setRefreshInterval] = useState(30); // seconds
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

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '1000px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
          <div>
            <h1>News Feed</h1>
            <p>Stay updated with the latest news and articles.</p>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <button
              onClick={handleRefresh}
              disabled={isLoading}
              style={{
                backgroundColor: isLoading ? '#6c757d' : '#007bff',
                color: 'white',
                padding: '8px 16px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: isLoading ? 'not-allowed' : 'pointer'
              }}
            >
              {isLoading ? 'Refreshing...' : 'Refresh Now'}
            </button>
            <div style={{ fontSize: '12px', color: '#666' }}>
              Last updated: {lastUpdate.toLocaleTimeString()}
            </div>
          </div>
        </div>

        {/* Auto-refresh Controls */}
        <div style={{ 
          padding: '15px', 
          backgroundColor: '#e3f2fd', 
          borderRadius: '4px', 
          marginBottom: '20px',
          display: 'flex',
          alignItems: 'center',
          gap: '15px'
        }}>
          <label style={{ display: 'flex', alignItems: 'center', gap: '5px', cursor: 'pointer' }}>
            <input
              type="checkbox"
              checked={autoRefresh}
              onChange={(e) => setAutoRefresh(e.target.checked)}
            />
            Auto-refresh every
          </label>
          <select
            value={refreshInterval}
            onChange={(e) => setRefreshInterval(Number(e.target.value))}
            style={{ padding: '4px 8px', border: '1px solid #ddd', borderRadius: '4px' }}
          >
            <option value={10}>10 seconds</option>
            <option value={30}>30 seconds</option>
            <option value={60}>1 minute</option>
            <option value={300}>5 minutes</option>
          </select>
          {autoRefresh && (
            <span style={{ fontSize: '12px', color: '#666' }}>
              Next refresh in: {refreshInterval}s
            </span>
          )}
        </div>

        {/* Update Notification */}
        {isLoading && (
          <div style={{
            padding: '10px 15px',
            backgroundColor: '#d4edda',
            border: '1px solid #c3e6cb',
            borderRadius: '4px',
            marginBottom: '20px',
            color: '#155724'
          }}>
            <strong>🔄 Updating content...</strong> New articles are being loaded.
          </div>
        )}

        {/* Articles List */}
        <div style={{ marginTop: '20px' }}>
          {articles.map((article, index) => (
            <div
              key={article.id}
              style={{
                padding: '20px',
                border: '1px solid #ddd',
                borderRadius: '8px',
                marginBottom: '16px',
                backgroundColor: '#fafafa',
                cursor: 'pointer',
                transition: 'background-color 0.2s ease'
              }}
              onClick={() => handleArticleClick(article.id)}
              onMouseEnter={(e) => e.target.style.backgroundColor = '#f0f0f0'}
              onMouseLeave={(e) => e.target.style.backgroundColor = '#fafafa'}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                <h3 style={{ margin: 0, color: '#333', fontSize: '18px' }}>{article.title}</h3>
                <span style={{ 
                  fontSize: '12px', 
                  color: '#666',
                  backgroundColor: '#e9ecef',
                  padding: '2px 8px',
                  borderRadius: '12px'
                }}>
                  {article.category}
                </span>
              </div>
              <p style={{ margin: '0 0 8px 0', color: '#666', lineHeight: '1.5' }}>
                {article.content.substring(0, 150)}...
              </p>
              <div style={{ fontSize: '12px', color: '#999' }}>
                {article.timestamp.toLocaleString()}
              </div>
            </div>
          ))}
        </div>

        {/* Article Detail Modal */}
        {userReadingArticle && (
          <div style={{
            position: 'fixed',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 1000
          }}>
            <div style={{
              background: 'white',
              padding: '30px',
              borderRadius: '8px',
              maxWidth: '600px',
              width: '90%',
              maxHeight: '80%',
              overflow: 'auto'
            }}>
              {(() => {
                const article = articles.find(a => a.id === userReadingArticle);
                return article ? (
                  <>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '20px' }}>
                      <h2 style={{ margin: 0, color: '#333' }}>{article.title}</h2>
                      <button
                        onClick={handleCloseArticle}
                        style={{
                          background: 'none',
                          border: 'none',
                          fontSize: '24px',
                          cursor: 'pointer',
                          color: '#666'
                        }}
                      >
                        ×
                      </button>
                    </div>
                    <div style={{ marginBottom: '15px' }}>
                      <span style={{ 
                        fontSize: '12px', 
                        color: '#666',
                        backgroundColor: '#e9ecef',
                        padding: '4px 8px',
                        borderRadius: '12px'
                      }}>
                        {article.category}
                      </span>
                      <span style={{ marginLeft: '10px', fontSize: '12px', color: '#999' }}>
                        {article.timestamp.toLocaleString()}
                      </span>
                    </div>
                    <div style={{ lineHeight: '1.6', color: '#333' }}>
                      <p>{article.content}</p>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                    </div>
                  </>
                ) : null;
              })()}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default AutoRefreshContentDisruption;
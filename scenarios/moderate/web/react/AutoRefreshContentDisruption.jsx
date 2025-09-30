import React, { useState, useEffect } from 'react';
const AutoRefreshContentDisruption = () => {
  const [articles, setArticles] = useState([]);
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [lastUpdate, setLastUpdate] = useState(new Date());
  const [showNotification, setShowNotification] = useState(false);
  const mockArticles = [
    {
      id: 1,
      summary: 'Scientists have made a significant discovery that could revolutionize the industry.',
      timestamp: new Date(Date.now() - 300000), // 5 minutes ago
      category: 'Technology',
      read: false
    },
    {
      id: 2,
      title: 'Market Update: Stock Prices Reach New High',
      summary: 'The stock market has reached unprecedented levels with significant gains.',
      timestamp: new Date(Date.now() - 600000), // 10 minutes ago
      category: 'Finance',
      read: false
    },
    {
      id: 3,
      title: 'Weather Alert: Severe Storm Warning',
      summary: 'Meteorologists are warning of severe weather conditions in the region.',
      timestamp: new Date(Date.now() - 900000), // 15 minutes ago
      category: 'Weather',
      read: false
    },
    {
      id: 4,
      title: 'Sports: Championship Game Results',
      summary: 'The final game of the season has concluded with surprising results.',
      timestamp: new Date(Date.now() - 1200000), // 20 minutes ago
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
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>News Feed</h1>
        <p>Stay updated with the latest news and articles.</p>
        {/* Header with Refresh Controls */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px', paddingBottom: '15px', borderBottom: '1px solid #eee' }}>
          <div>
            <h2 style={{ margin: '0 0 5px 0', color: '#333' }}>Latest News</h2>
            <p style={{ margin: '0', color: '#666', fontSize: '14px' }}>
              Last updated: {formatTimestamp(lastUpdate)}
            </p>
          </div>
          <button
            onClick={handleManualRefresh}
            disabled={isRefreshing}
            style={{
              background: isRefreshing ? '#6c757d' : '#007bff',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: isRefreshing ? 'not-allowed' : 'pointer',
              fontSize: '14px',
              display: 'flex',
              alignItems: 'center',
              gap: '8px'
            }}
          >
            {isRefreshing ? (
              <>
                <span>⟳</span>
                Refreshing...
              </>
            ) : (
              <>
                <span>⟳</span>
                Refresh
              </>
            )}
          </button>
        </div>
        {}
        {showNotification && (
          <div
            style={{
              background: '#d4edda',
              border: '1px solid #c3e6cb',
              color: '#155724',
              padding: '12px 16px',
              borderRadius: '4px',
              marginBottom: '20px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}
          >
            <span>✓ Content has been updated with new articles</span>
            <button
              onClick={() => setShowNotification(false)}
              style={{
                background: 'none',
                border: 'none',
                color: '#155724',
                cursor: 'pointer',
                fontSize: '18px',
                padding: '0',
                marginLeft: '10px'
              }}
            >
              ×
            </button>
          </div>
        )}
        {/* Articles List */}
        <div style={{ marginBottom: '20px' }}>
          {articles.map((article, index) => (
            <article
              key={article.id}
              style={{
                border: '1px solid #ddd',
                borderRadius: '8px',
                padding: '20px',
                marginBottom: '16px',
                background: article.read ? '#f8f9fa' : 'white',
                borderLeft: article.read ? '4px solid #28a745' : '4px solid #007bff',
                transition: 'all 0.3s ease'
              }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '10px' }}>
                <div style={{ flex: 1 }}>
                  <h3 style={{ 
                    margin: '0 0 8px 0', 
                    color: '#333',
                    fontSize: '18px',
                    fontWeight: article.read ? 'normal' : 'bold'
                  }}>
                    {article.title}
                  </h3>
                  <p style={{ 
                    margin: '0 0 8px 0', 
                    color: '#666', 
                    fontSize: '14px',
                    lineHeight: '1.4'
                  }}>
                    {article.summary}
                  </p>
                  <div style={{ display: 'flex', gap: '16px', fontSize: '12px', color: '#999' }}>
                    <span>Category: {article.category}</span>
                    <span>{formatTimestamp(article.timestamp)}</span>
                  </div>
                </div>
                {!article.read && (
                  <button
                    onClick={() => markAsRead(article.id)}
                    style={{
                      background: '#28a745',
                      color: 'white',
                      border: 'none',
                      padding: '4px 8px',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '12px',
                      marginLeft: '10px'
                    }}
                  >
                    Mark as Read
                  </button>
                )}
              </div>
            </article>
          ))}
        </div>
        {/* Auto-refresh Indicator */}
        <div style={{ 
          textAlign: 'center', 
          padding: '10px', 
          background: '#f8f9fa', 
          borderRadius: '4px',
          fontSize: '12px',
          color: '#666'
        }}>
          <span>Auto-refreshing every 30 seconds</span>
          {isRefreshing && (
            <span style={{ marginLeft: '10px', color: '#007bff' }}>
              • Refreshing now...
            </span>
          )}
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default AutoRefreshContentDisruption;
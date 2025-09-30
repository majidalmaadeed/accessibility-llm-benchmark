import { useState, useEffect } from 'react';

export default function SilentLoadingState() {
  const [isLoading, setIsLoading] = useState(false);
  const [data, setData] = useState([]);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [sortBy, setSortBy] = useState('name');

  const categories = [
    { id: 'all', name: 'All Items' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'books', name: 'Books' },
    { id: 'home', name: 'Home & Garden' }
  ];

  const sampleData = [
    { id: 1, name: 'Wireless Headphones', category: 'electronics', price: 199.99, rating: 4.5, inStock: true },
    { id: 2, name: 'Cotton T-Shirt', category: 'clothing', price: 29.99, rating: 4.2, inStock: true },
    { id: 3, name: 'Programming Book', category: 'books', price: 49.99, rating: 4.8, inStock: false },
    { id: 4, name: 'Smart Home Hub', category: 'electronics', price: 149.99, rating: 4.7, inStock: true },
    { id: 5, name: 'Garden Tools Set', category: 'home', price: 79.99, rating: 4.3, inStock: true },
    { id: 6, name: 'Running Shoes', category: 'clothing', price: 129.99, rating: 4.6, inStock: true },
    { id: 7, name: 'Cookbook Collection', category: 'books', price: 39.99, rating: 4.4, inStock: true },
    { id: 8, name: 'LED Desk Lamp', category: 'electronics', price: 89.99, rating: 4.1, inStock: false }
  ];

  const loadData = async () => {
    setIsLoading(true);
    setError(null);
    
    try {
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      let filteredData = sampleData;
      
      if (selectedCategory !== 'all') {
        filteredData = filteredData.filter(item => item.category === selectedCategory);
      }
      
      if (searchQuery) {
        filteredData = filteredData.filter(item => 
          item.name.toLowerCase().includes(searchQuery.toLowerCase())
        );
      }
      
      filteredData.sort((a, b) => {
        switch(sortBy) {
          case 'name':
            return a.name.localeCompare(b.name);
          case 'price':
            return a.price - b.price;
          case 'rating':
            return b.rating - a.rating;
          default:
            return 0;
        }
      });
      
      setData(filteredData);
    } catch (err) {
      setError('Failed to load data. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    loadData();
  }, [selectedCategory, searchQuery, sortBy]);

  const handleSearch = (e) => {
    e.preventDefault();
    setCurrentPage(1);
  };

  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    setCurrentPage(1);
  };

  const handleSortChange = (sort) => {
    setSortBy(sort);
    setCurrentPage(1);
  };

  const handleRefresh = () => {
    loadData();
  };

  const handleRetry = () => {
    loadData();
  };

  const formatPrice = (price) => {
    return `$${price.toFixed(2)}`;
  };

  const renderStars = (rating) => {
    const stars = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;

    for (let i = 0; i < fullStars; i++) {
      stars.push('★');
    }
    if (hasHalfStar) {
      stars.push('☆');
    }
    while (stars.length < 5) {
      stars.push('☆');
    }
    return stars.join('');
  };

  return (
    <div className="product-catalog">
      <header className="catalog-header">
        <h1>Product Catalog</h1>
        <p>Browse and discover amazing products</p>
      </header>

      <div className="catalog-controls">
        <div className="search-section">
          <form onSubmit={handleSearch} className="search-form">
            <input
              type="text"
              placeholder="Search products..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="search-input"
            />
            <button type="submit" className="search-btn">Search</button>
          </form>
        </div>

        <div className="filter-section">
          <div className="filter-group">
            <label>Category:</label>
            <select 
              value={selectedCategory} 
              onChange={(e) => handleCategoryChange(e.target.value)}
              className="filter-select"
            >
              {categories.map(category => (
                <option key={category.id} value={category.id}>
                  {category.name}
                </option>
              ))}
            </select>
          </div>

          <div className="filter-group">
            <label>Sort by:</label>
            <select 
              value={sortBy} 
              onChange={(e) => handleSortChange(e.target.value)}
              className="filter-select"
            >
              <option value="name">Name</option>
              <option value="price">Price</option>
              <option value="rating">Rating</option>
            </select>
          </div>

          <button 
            className="refresh-btn"
            onClick={handleRefresh}
            disabled={isLoading}
          >
            {isLoading ? 'Refreshing...' : 'Refresh'}
          </button>
        </div>
      </div>

      <div className="catalog-content">
        {isLoading && (
          <div className="loading-overlay">
            <div className="loading-spinner"></div>
            <p>Loading products...</p>
          </div>
        )}

        {error && (
          <div className="error-message">
            <div className="error-icon">⚠️</div>
            <div className="error-content">
              <h3>Something went wrong</h3>
              <p>{error}</p>
              <button className="retry-btn" onClick={handleRetry}>
                Try Again
              </button>
            </div>
          </div>
        )}

        {!isLoading && !error && data.length === 0 && (
          <div className="empty-state">
            <div className="empty-icon">📦</div>
            <h3>No products found</h3>
            <p>Try adjusting your search or filter criteria</p>
            <button className="clear-filters-btn" onClick={() => {
              setSearchQuery('');
              setSelectedCategory('all');
            }}>
              Clear Filters
            </button>
          </div>
        )}

        {!isLoading && !error && data.length > 0 && (
          <div className="products-grid">
            {data.map(item => (
              <div key={item.id} className="product-card">
                <div className="product-image">
                  <div className="image-placeholder">
                    {item.category === 'electronics' && '📱'}
                    {item.category === 'clothing' && '👕'}
                    {item.category === 'books' && '📚'}
                    {item.category === 'home' && '🏠'}
                  </div>
                  {!item.inStock && (
                    <div className="out-of-stock-badge">Out of Stock</div>
                  )}
                </div>

                <div className="product-info">
                  <h3 className="product-name">{item.name}</h3>
                  
                  <div className="product-rating">
                    <span className="stars">{renderStars(item.rating)}</span>
                    <span className="rating-text">({item.rating})</span>
                  </div>

                  <div className="product-price">
                    {formatPrice(item.price)}
                  </div>

                  <div className="product-actions">
                    <button 
                      className="action-btn primary"
                      disabled={!item.inStock}
                    >
                      {item.inStock ? 'Add to Cart' : 'Out of Stock'}
                    </button>
                    <button className="action-btn secondary">
                      View Details
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="catalog-footer">
        <div className="results-info">
          <span>
            {isLoading ? 'Loading...' : `${data.length} products found`}
          </span>
        </div>

        <div className="pagination">
          <button 
            className="page-btn"
            disabled={currentPage === 1}
            onClick={() => setCurrentPage(currentPage - 1)}
          >
            Previous
          </button>
          
          <span className="page-info">
            Page {currentPage} of 3
          </span>
          
          <button 
            className="page-btn"
            disabled={currentPage === 3}
            onClick={() => setCurrentPage(currentPage + 1)}
          >
            Next
          </button>
        </div>
      </div>

      <style jsx>{`
        .product-catalog {
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .catalog-header {
          text-align: center;
          margin-bottom: 30px;
        }

        .catalog-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .catalog-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .catalog-controls {
          display: flex;
          flex-wrap: wrap;
          gap: 20px;
          align-items: center;
          justify-content: space-between;
          margin-bottom: 30px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .search-section {
          flex: 1;
          min-width: 300px;
        }

        .search-form {
          display: flex;
          gap: 10px;
        }

        .search-input {
          flex: 1;
          padding: 10px 15px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 14px;
        }

        .search-btn {
          padding: 10px 20px;
          background: #007bff;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .search-btn:hover {
          background: #0056b3;
        }

        .filter-section {
          display: flex;
          gap: 20px;
          align-items: center;
          flex-wrap: wrap;
        }

        .filter-group {
          display: flex;
          flex-direction: column;
          gap: 5px;
        }

        .filter-group label {
          font-size: 12px;
          font-weight: bold;
          color: #666;
        }

        .filter-select {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
          cursor: pointer;
        }

        .refresh-btn {
          padding: 8px 16px;
          background: #6c757d;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .refresh-btn:hover:not(:disabled) {
          background: #545b62;
        }

        .refresh-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .catalog-content {
          position: relative;
          min-height: 400px;
        }

        .loading-overlay {
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(255, 255, 255, 0.9);
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          z-index: 10;
        }

        .loading-spinner {
          width: 40px;
          height: 40px;
          border: 4px solid #f3f3f3;
          border-top: 4px solid #007bff;
          border-radius: 50%;
          animation: spin 1s linear infinite;
          margin-bottom: 20px;
        }

        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }

        .error-message {
          display: flex;
          align-items: center;
          gap: 20px;
          padding: 30px;
          background: #f8d7da;
          border: 1px solid #f5c6cb;
          border-radius: 8px;
          color: #721c24;
        }

        .error-icon {
          font-size: 48px;
        }

        .error-content h3 {
          margin: 0 0 10px 0;
          font-size: 18px;
        }

        .error-content p {
          margin: 0 0 15px 0;
        }

        .retry-btn {
          padding: 8px 16px;
          background: #dc3545;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .retry-btn:hover {
          background: #c82333;
        }

        .empty-state {
          text-align: center;
          padding: 60px 20px;
          color: #666;
        }

        .empty-icon {
          font-size: 64px;
          margin-bottom: 20px;
        }

        .empty-state h3 {
          margin: 0 0 10px 0;
          font-size: 24px;
          color: #333;
        }

        .empty-state p {
          margin: 0 0 20px 0;
          font-size: 16px;
        }

        .clear-filters-btn {
          padding: 10px 20px;
          background: #007bff;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .clear-filters-btn:hover {
          background: #0056b3;
        }

        .products-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
          gap: 20px;
        }

        .product-card {
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          overflow: hidden;
          transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .product-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .product-image {
          position: relative;
          height: 200px;
          background: #f8f9fa;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .image-placeholder {
          font-size: 48px;
        }

        .out-of-stock-badge {
          position: absolute;
          top: 10px;
          right: 10px;
          background: #dc3545;
          color: white;
          padding: 4px 8px;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }

        .product-info {
          padding: 20px;
        }

        .product-name {
          margin: 0 0 10px 0;
          font-size: 16px;
          font-weight: bold;
          color: #333;
        }

        .product-rating {
          display: flex;
          align-items: center;
          gap: 5px;
          margin-bottom: 10px;
        }

        .stars {
          color: #ffc107;
          font-size: 14px;
        }

        .rating-text {
          font-size: 12px;
          color: #666;
        }

        .product-price {
          font-size: 18px;
          font-weight: bold;
          color: #333;
          margin-bottom: 15px;
        }

        .product-actions {
          display: flex;
          gap: 10px;
        }

        .action-btn {
          flex: 1;
          padding: 10px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
        }

        .action-btn.primary:hover:not(:disabled) {
          background: #0056b3;
        }

        .action-btn.primary:disabled {
          background: #6c757d;
          cursor: not-allowed;
        }

        .action-btn.secondary {
          background: #6c757d;
          color: white;
        }

        .action-btn.secondary:hover {
          background: #545b62;
        }

        .catalog-footer {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-top: 30px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .results-info {
          font-size: 14px;
          color: #666;
        }

        .pagination {
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .page-btn {
          padding: 8px 16px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .page-btn:hover:not(:disabled) {
          border-color: #007bff;
          color: #007bff;
        }

        .page-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .page-info {
          font-size: 14px;
          color: #666;
        }

        @media (max-width: 768px) {
          .catalog-controls {
            flex-direction: column;
            align-items: stretch;
          }

          .search-section {
            min-width: auto;
          }

          .filter-section {
            justify-content: center;
          }

          .products-grid {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
          }

          .catalog-footer {
            flex-direction: column;
            gap: 15px;
            text-align: center;
          }
        }
      `}</style>
    </div>
  );
}

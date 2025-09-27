import React, { useState, useEffect } from 'react';

const SearchInterface = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [filters, setFilters] = useState({
    category: 'all',
    dateRange: 'all',
    priceRange: 'all',
    rating: 'all',
    availability: 'all',
    sortBy: 'relevance'
  });
  const [isSearching, setIsSearching] = useState(false);
  const [searchHistory, setSearchHistory] = useState([]);
  const [suggestions, setSuggestions] = useState([]);
  const [showFilters, setShowFilters] = useState(false);

  const mockData = [
    { id: 1, title: 'Wireless Headphones', category: 'electronics', price: 99.99, rating: 4.5, date: '2024-01-15', available: true, description: 'High-quality wireless headphones with noise cancellation' },
    { id: 2, title: 'Smart Watch', category: 'electronics', price: 199.99, rating: 4.2, date: '2024-01-14', available: true, description: 'Advanced smartwatch with health monitoring features' },
    { id: 3, title: 'Coffee Maker', category: 'appliances', price: 79.99, rating: 4.7, date: '2024-01-13', available: false, description: 'Programmable coffee maker with multiple brewing options' },
    { id: 4, title: 'Running Shoes', category: 'sports', price: 129.99, rating: 4.3, date: '2024-01-12', available: true, description: 'Comfortable running shoes for all terrains' },
    { id: 5, title: 'Laptop Stand', category: 'electronics', price: 49.99, rating: 4.1, date: '2024-01-11', available: true, description: 'Adjustable laptop stand for better ergonomics' },
    { id: 6, title: 'Yoga Mat', category: 'sports', price: 29.99, rating: 4.6, date: '2024-01-10', available: true, description: 'Non-slip yoga mat for home workouts' },
    { id: 7, title: 'Blender', category: 'appliances', price: 89.99, rating: 4.4, date: '2024-01-09', available: true, description: 'High-speed blender for smoothies and food prep' },
    { id: 8, title: 'Desk Lamp', category: 'furniture', price: 39.99, rating: 4.0, date: '2024-01-08', available: true, description: 'LED desk lamp with adjustable brightness' },
    { id: 9, title: 'Water Bottle', category: 'sports', price: 19.99, rating: 4.8, date: '2024-01-07', available: true, description: 'Insulated water bottle keeps drinks cold for 24 hours' },
    { id: 10, title: 'Phone Case', category: 'electronics', price: 24.99, rating: 4.2, date: '2024-01-06', available: false, description: 'Protective phone case with wireless charging support' }
  ];

  const categories = ['all', 'electronics', 'appliances', 'sports', 'furniture', 'clothing', 'books'];
  const dateRanges = ['all', 'today', 'week', 'month', 'year'];
  const priceRanges = ['all', '0-50', '50-100', '100-200', '200+'];
  const ratings = ['all', '4+', '3+', '2+', '1+'];
  const availabilityOptions = ['all', 'available', 'out-of-stock'];
  const sortOptions = ['relevance', 'price-low', 'price-high', 'rating', 'newest', 'oldest'];

  useEffect(() => {
    if (searchQuery.length > 2) {
      const filtered = mockData.filter(item =>
        item.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.category.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setSuggestions(filtered.slice(0, 5));
    } else {
      setSuggestions([]);
    }
  }, [searchQuery]);

  const performSearch = () => {
    if (!searchQuery.trim()) return;

    setIsSearching(true);
    setSearchHistory(prev => {
      const newHistory = [searchQuery, ...prev.filter(item => item !== searchQuery)];
      return newHistory.slice(0, 10);
    });

    setTimeout(() => {
      let results = [...mockData];

      // Apply text search
      if (searchQuery) {
        results = results.filter(item =>
          item.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
          item.category.toLowerCase().includes(searchQuery.toLowerCase())
        );
      }

      // Apply filters
      if (filters.category !== 'all') {
        results = results.filter(item => item.category === filters.category);
      }

      if (filters.dateRange !== 'all') {
        const now = new Date();
        const filterDate = new Date();
        switch (filters.dateRange) {
          case 'today':
            filterDate.setDate(now.getDate() - 1);
            break;
          case 'week':
            filterDate.setDate(now.getDate() - 7);
            break;
          case 'month':
            filterDate.setMonth(now.getMonth() - 1);
            break;
          case 'year':
            filterDate.setFullYear(now.getFullYear() - 1);
            break;
        }
        results = results.filter(item => new Date(item.date) >= filterDate);
      }

      if (filters.priceRange !== 'all') {
        const [min, max] = filters.priceRange.split('-').map(Number);
        results = results.filter(item => {
          if (max) {
            return item.price >= min && item.price <= max;
          } else {
            return item.price >= min;
          }
        });
      }

      if (filters.rating !== 'all') {
        const minRating = parseFloat(filters.rating);
        results = results.filter(item => item.rating >= minRating);
      }

      if (filters.availability !== 'all') {
        const isAvailable = filters.availability === 'available';
        results = results.filter(item => item.available === isAvailable);
      }

      // Apply sorting
      switch (filters.sortBy) {
        case 'price-low':
          results.sort((a, b) => a.price - b.price);
          break;
        case 'price-high':
          results.sort((a, b) => b.price - a.price);
          break;
        case 'rating':
          results.sort((a, b) => b.rating - a.rating);
          break;
        case 'newest':
          results.sort((a, b) => new Date(b.date) - new Date(a.date));
          break;
        case 'oldest':
          results.sort((a, b) => new Date(a.date) - new Date(b.date));
          break;
        default:
          // Keep original order for relevance
          break;
      }

      setSearchResults(results);
      setIsSearching(false);
    }, 1000);
  };

  const clearFilters = () => {
    setFilters({
      category: 'all',
      dateRange: 'all',
      priceRange: 'all',
      rating: 'all',
      availability: 'all',
      sortBy: 'relevance'
    });
  };

  const handleFilterChange = (filterType, value) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value
    }));
  };

  const handleSuggestionClick = (suggestion) => {
    setSearchQuery(suggestion.title);
    setSuggestions([]);
  };

  const handleHistoryClick = (query) => {
    setSearchQuery(query);
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Complex Search Interface</h1>
        <p className="page-subtitle">
          Complex search and filtering interface
        </p>
      </div>

      <div className="card">
        <div style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }}>
          <div style={{ flex: 1, position: 'relative' }}>
            <input
              type="text"
              className="form-control"
              placeholder="Search products, categories, or descriptions..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && performSearch()}
            />
            {suggestions.length > 0 && (
              <div style={{
                position: 'absolute',
                top: '100%',
                left: 0,
                right: 0,
                backgroundColor: 'white',
                border: '1px solid #ddd',
                borderTop: 'none',
                borderRadius: '0 0 4px 4px',
                zIndex: 1000,
                maxHeight: '200px',
                overflowY: 'auto'
              }}>
                {suggestions.map((suggestion, index) => (
                  <div
                    key={index}
                    style={{
                      padding: '0.75rem',
                      cursor: 'pointer',
                      borderBottom: '1px solid #eee'
                    }}
                    onClick={() => handleSuggestionClick(suggestion)}
                    onMouseEnter={(e) => e.target.style.backgroundColor = '#f5f5f5'}
                    onMouseLeave={(e) => e.target.style.backgroundColor = 'white'}
                  >
                    <div style={{ fontWeight: '600' }}>{suggestion.title}</div>
                    <div style={{ fontSize: '0.9rem', color: '#666' }}>{suggestion.category}</div>
                  </div>
                ))}
              </div>
            )}
          </div>
          <button className="btn" onClick={performSearch} disabled={isSearching}>
            {isSearching ? 'Searching...' : 'Search'}
          </button>
          <button className="btn btn-secondary" onClick={() => setShowFilters(!showFilters)}>
            {showFilters ? 'Hide Filters' : 'Show Filters'}
          </button>
        </div>

        {searchHistory.length > 0 && (
          <div style={{ marginBottom: '1rem' }}>
            <div style={{ fontSize: '0.9rem', color: '#666', marginBottom: '0.5rem' }}>Recent searches:</div>
            <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
              {searchHistory.map((query, index) => (
                <button
                  key={index}
                  className="btn btn-secondary"
                  onClick={() => handleHistoryClick(query)}
                  style={{ fontSize: '0.8rem', padding: '0.25rem 0.5rem' }}
                >
                  {query}
                </button>
              ))}
            </div>
          </div>
        )}
      </div>

      {showFilters && (
        <div className="card">
          <h2>Search Filters</h2>
          <div className="search-filters">
            <div className="form-group">
              <label className="form-label">Category</label>
              <select
                className="form-control"
                value={filters.category}
                onChange={(e) => handleFilterChange('category', e.target.value)}
              >
                {categories.map(cat => (
                  <option key={cat} value={cat}>
                    {cat === 'all' ? 'All Categories' : cat.charAt(0).toUpperCase() + cat.slice(1)}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Date Range</label>
              <select
                className="form-control"
                value={filters.dateRange}
                onChange={(e) => handleFilterChange('dateRange', e.target.value)}
              >
                {dateRanges.map(range => (
                  <option key={range} value={range}>
                    {range === 'all' ? 'All Time' : range.charAt(0).toUpperCase() + range.slice(1)}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Price Range</label>
              <select
                className="form-control"
                value={filters.priceRange}
                onChange={(e) => handleFilterChange('priceRange', e.target.value)}
              >
                {priceRanges.map(range => (
                  <option key={range} value={range}>
                    {range === 'all' ? 'All Prices' : `$${range}`}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Rating</label>
              <select
                className="form-control"
                value={filters.rating}
                onChange={(e) => handleFilterChange('rating', e.target.value)}
              >
                {ratings.map(rating => (
                  <option key={rating} value={rating}>
                    {rating === 'all' ? 'All Ratings' : `${rating} stars & up`}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Availability</label>
              <select
                className="form-control"
                value={filters.availability}
                onChange={(e) => handleFilterChange('availability', e.target.value)}
              >
                {availabilityOptions.map(option => (
                  <option key={option} value={option}>
                    {option === 'all' ? 'All Items' : option === 'available' ? 'In Stock' : 'Out of Stock'}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Sort By</label>
              <select
                className="form-control"
                value={filters.sortBy}
                onChange={(e) => handleFilterChange('sortBy', e.target.value)}
              >
                {sortOptions.map(option => (
                  <option key={option} value={option}>
                    {option === 'relevance' ? 'Relevance' : 
                     option === 'price-low' ? 'Price: Low to High' :
                     option === 'price-high' ? 'Price: High to Low' :
                     option === 'rating' ? 'Rating' :
                     option === 'newest' ? 'Newest First' :
                     option === 'oldest' ? 'Oldest First' : option}
                  </option>
                ))}
              </select>
            </div>
          </div>
          <div className="form-actions">
            <button className="btn btn-secondary" onClick={clearFilters}>
              Clear Filters
            </button>
            <button className="btn" onClick={performSearch}>
              Apply Filters
            </button>
          </div>
        </div>
      )}

      <div className="card">
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
          <h2>Search Results</h2>
          <div style={{ color: '#666' }}>
            {searchResults.length} result{searchResults.length !== 1 ? 's' : ''} found
          </div>
        </div>

        {isSearching ? (
          <div className="loading">
            <div className="spinner"></div>
          </div>
        ) : searchResults.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '2rem', color: '#666' }}>
            <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🔍</div>
            <p>No results found. Try adjusting your search or filters.</p>
          </div>
        ) : (
          <div className="search-results">
            {searchResults.map(item => (
              <div key={item.id} className="search-result-item">
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                  <div style={{ flex: 1 }}>
                    <h3 style={{ margin: '0 0 0.5rem 0', color: '#333' }}>{item.title}</h3>
                    <p style={{ margin: '0 0 0.5rem 0', color: '#666' }}>{item.description}</p>
                    <div style={{ display: 'flex', gap: '1rem', fontSize: '0.9rem', color: '#666' }}>
                      <span>Category: {item.category}</span>
                      <span>Price: ${item.price}</span>
                      <span>Rating: {item.rating} ⭐</span>
                      <span>Date: {new Date(item.date).toLocaleDateString()}</span>
                      <span style={{ color: item.available ? '#28a745' : '#dc3545' }}>
                        {item.available ? 'In Stock' : 'Out of Stock'}
                      </span>
                    </div>
                  </div>
                  <div style={{ display: 'flex', gap: '0.5rem', marginLeft: '1rem' }}>
                    <button className="btn" style={{ fontSize: '0.8rem', padding: '0.5rem 1rem' }}>
                      View Details
                    </button>
                    <button className="btn btn-secondary" style={{ fontSize: '0.8rem', padding: '0.5rem 1rem' }}>
                      Add to Cart
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default SearchInterface;

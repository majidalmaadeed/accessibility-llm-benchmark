import React, { useState, useEffect, useRef } from 'react';
import './ComplexSearchInterface.css';

const ComplexSearchInterface = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [filters, setFilters] = useState({
    category: 'all',
    priceRange: 'all',
    brand: 'all',
    rating: 'all',
    availability: 'all',
    sortBy: 'relevance'
  });
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState('grid'); // grid, list
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(12);
  const [selectedItems, setSelectedItems] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [suggestions, setSuggestions] = useState([]);
  const searchInputRef = useRef(null);

  // Sample product data
  const sampleProducts = [
    {
      id: 1,
      name: 'Wireless Bluetooth Headphones',
      category: 'electronics',
      brand: 'TechSound',
      price: 99.99,
      rating: 4.5,
      reviews: 128,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🎧',
      description: 'High-quality wireless headphones with noise cancellation'
    },
    {
      id: 2,
      name: 'Smart Fitness Watch',
      category: 'electronics',
      brand: 'FitTech',
      price: 199.99,
      rating: 4.2,
      reviews: 89,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/2196f3/fff?text=⌚',
      description: 'Advanced fitness tracking with heart rate monitoring'
    },
    {
      id: 3,
      name: 'Organic Cotton T-Shirt',
      category: 'clothing',
      brand: 'EcoWear',
      price: 29.99,
      rating: 4.7,
      reviews: 256,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/ff9800/fff?text=👕',
      description: 'Comfortable organic cotton t-shirt in various colors'
    },
    {
      id: 4,
      name: 'Stainless Steel Water Bottle',
      category: 'home',
      brand: 'HydroMax',
      price: 24.99,
      rating: 4.3,
      reviews: 167,
      availability: 'limited',
      image: 'https://via.placeholder.com/200x200/9c27b0/fff?text=🍶',
      description: 'Insulated stainless steel water bottle keeps drinks cold'
    },
    {
      id: 5,
      name: 'Wireless Charging Pad',
      category: 'electronics',
      brand: 'PowerUp',
      price: 39.99,
      rating: 4.1,
      reviews: 94,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/f44336/fff?text=🔋',
      description: 'Fast wireless charging pad compatible with all devices'
    },
    {
      id: 6,
      name: 'Yoga Mat Premium',
      category: 'sports',
      brand: 'FlexFit',
      price: 49.99,
      rating: 4.6,
      reviews: 203,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🧘',
      description: 'Non-slip premium yoga mat for all fitness levels'
    }
  ];

  const categories = [
    { id: 'all', name: 'All Categories' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'home', name: 'Home & Garden' },
    { id: 'sports', name: 'Sports & Fitness' },
    { id: 'books', name: 'Books' }
  ];

  const brands = [
    { id: 'all', name: 'All Brands' },
    { id: 'TechSound', name: 'TechSound' },
    { id: 'FitTech', name: 'FitTech' },
    { id: 'EcoWear', name: 'EcoWear' },
    { id: 'HydroMax', name: 'HydroMax' },
    { id: 'PowerUp', name: 'PowerUp' },
    { id: 'FlexFit', name: 'FlexFit' }
  ];

  const priceRanges = [
    { id: 'all', name: 'All Prices' },
    { id: '0-25', name: 'Under $25' },
    { id: '25-50', name: '$25 - $50' },
    { id: '50-100', name: '$50 - $100' },
    { id: '100-200', name: '$100 - $200' },
    { id: '200+', name: 'Over $200' }
  ];

  const ratings = [
    { id: 'all', name: 'All Ratings' },
    { id: '4.5+', name: '4.5+ Stars' },
    { id: '4+', name: '4+ Stars' },
    { id: '3+', name: '3+ Stars' },
    { id: '2+', name: '2+ Stars' }
  ];

  const sortOptions = [
    { id: 'relevance', name: 'Relevance' },
    { id: 'price-low', name: 'Price: Low to High' },
    { id: 'price-high', name: 'Price: High to Low' },
    { id: 'rating', name: 'Customer Rating' },
    { id: 'newest', name: 'Newest First' },
    { id: 'name', name: 'Name A-Z' }
  ];

  // Search suggestions
  const searchSuggestions = [
    'wireless headphones', 'smart watch', 'fitness tracker', 'bluetooth speaker',
    'phone case', 'laptop stand', 'wireless charger', 'yoga mat', 'water bottle',
    'organic cotton', 'stainless steel', 'premium quality'
  ];

  useEffect(() => {
    performSearch();
  }, [filters, currentPage]);

  useEffect(() => {
    if (searchQuery.length > 2) {
      const filteredSuggestions = searchSuggestions.filter(suggestion =>
        suggestion.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setSuggestions(filteredSuggestions.slice(0, 5));
      setShowSuggestions(true);
    } else {
      setShowSuggestions(false);
    }
  }, [searchQuery]);

  const performSearch = () => {
    setIsLoading(true);
    
    // Simulate API call
    setTimeout(() => {
      let filteredProducts = [...sampleProducts];

      // Apply search query filter
      if (searchQuery.trim()) {
        filteredProducts = filteredProducts.filter(product =>
          product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
          product.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().includes(searchQuery.toLowerCase())
        );
      }

      // Apply category filter
      if (filters.category !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.category === filters.category);
      }

      // Apply brand filter
      if (filters.brand !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.brand === filters.brand);
      }

      // Apply price range filter
      if (filters.priceRange !== 'all') {
        const [min, max] = filters.priceRange.split('-').map(Number);
        filteredProducts = filteredProducts.filter(product => {
          if (filters.priceRange === '200+') {
            return product.price > 200;
          }
          return product.price >= min && product.price <= max;
        });
      }

      // Apply rating filter
      if (filters.rating !== 'all') {
        const minRating = parseFloat(filters.rating);
        filteredProducts = filteredProducts.filter(product => product.rating >= minRating);
      }

      // Apply availability filter
      if (filters.availability !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.availability === filters.availability);
      }

      // Apply sorting
      switch (filters.sortBy) {
        case 'price-low':
          filteredProducts.sort((a, b) => a.price - b.price);
          break;
        case 'price-high':
          filteredProducts.sort((a, b) => b.price - a.price);
          break;
        case 'rating':
          filteredProducts.sort((a, b) => b.rating - a.rating);
          break;
        case 'newest':
          filteredProducts.sort((a, b) => b.id - a.id);
          break;
        case 'name':
          filteredProducts.sort((a, b) => a.name.localeCompare(b.name));
          break;
        default:
          // Keep original order for relevance
          break;
      }

      setSearchResults(filteredProducts);
      setIsLoading(false);
    }, 500);
  };

  const handleSearch = (e) => {
    e.preventDefault();
    setCurrentPage(1);
    performSearch();
  };

  const handleFilterChange = (filterType, value) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value
    }));
    setCurrentPage(1);
  };

  const handleSuggestionClick = (suggestion) => {
    setSearchQuery(suggestion);
    setShowSuggestions(false);
    setCurrentPage(1);
    performSearch();
  };

  const handleItemSelect = (itemId) => {
    setSelectedItems(prev => 
      prev.includes(itemId) 
        ? prev.filter(id => id !== itemId)
        : [...prev, itemId]
    );
  };

  const handleSelectAll = () => {
    const currentPageItems = paginatedResults.map(item => item.id);
    setSelectedItems(prev => 
      prev.length === currentPageItems.length 
        ? prev.filter(id => !currentPageItems.includes(id))
        : [...prev, ...currentPageItems.filter(id => !prev.includes(id))]
    );
  };

  const clearFilters = () => {
    setFilters({
      category: 'all',
      priceRange: 'all',
      brand: 'all',
      rating: 'all',
      availability: 'all',
      sortBy: 'relevance'
    });
    setSearchQuery('');
    setCurrentPage(1);
  };

  const totalPages = Math.ceil(searchResults.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedResults = searchResults.slice(startIndex, startIndex + itemsPerPage);

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
    <div className="search-interface">
      <div className="search-header">
        <h1>Product Search</h1>
        <div className="search-stats">
          {searchResults.length} products found
          {selectedItems.length > 0 && (
            <span className="selected-count">• {selectedItems.length} selected</span>
          )}
        </div>
      </div>

      <div className="search-container">
        <div className="search-main">
          <form onSubmit={handleSearch} className="search-form">
            <div className="search-input-container">
              <input
                ref={searchInputRef}
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Search for products..."
                className="search-input"
              />
              <button type="submit" className="search-btn">
                🔍
              </button>
              
              {showSuggestions && suggestions.length > 0 && (
                <div className="search-suggestions">
                  {suggestions.map((suggestion, index) => (
                    <div
                      key={index}
                      className="suggestion-item"
                      onClick={() => handleSuggestionClick(suggestion)}
                    >
                      {suggestion}
                    </div>
                  ))}
                </div>
              )}
            </div>
          </form>

          <div className="search-controls">
            <div className="view-controls">
              <button 
                className={viewMode === 'grid' ? 'active' : ''}
                onClick={() => setViewMode('grid')}
                title="Grid View"
              >
                ⊞
              </button>
              <button 
                className={viewMode === 'list' ? 'active' : ''}
                onClick={() => setViewMode('list')}
                title="List View"
              >
                ☰
              </button>
            </div>

            <div className="sort-controls">
              <label>Sort by:</label>
              <select
                value={filters.sortBy}
                onChange={(e) => handleFilterChange('sortBy', e.target.value)}
              >
                {sortOptions.map(option => (
                  <option key={option.id} value={option.id}>
                    {option.name}
                  </option>
                ))}
              </select>
            </div>

            <button 
              onClick={() => setShowFilters(!showFilters)}
              className="filters-toggle"
            >
              Filters {showFilters ? '▲' : '▼'}
            </button>
          </div>

          {showFilters && (
            <div className="filters-panel">
              <div className="filter-group">
                <label>Category</label>
                <select
                  value={filters.category}
                  onChange={(e) => handleFilterChange('category', e.target.value)}
                >
                  {categories.map(category => (
                    <option key={category.id} value={category.id}>
                      {category.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="filter-group">
                <label>Brand</label>
                <select
                  value={filters.brand}
                  onChange={(e) => handleFilterChange('brand', e.target.value)}
                >
                  {brands.map(brand => (
                    <option key={brand.id} value={brand.id}>
                      {brand.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="filter-group">
                <label>Price Range</label>
                <select
                  value={filters.priceRange}
                  onChange={(e) => handleFilterChange('priceRange', e.target.value)}
                >
                  {priceRanges.map(range => (
                    <option key={range.id} value={range.id}>
                      {range.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="filter-group">
                <label>Rating</label>
                <select
                  value={filters.rating}
                  onChange={(e) => handleFilterChange('rating', e.target.value)}
                >
                  {ratings.map(rating => (
                    <option key={rating.id} value={rating.id}>
                      {rating.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="filter-group">
                <label>Availability</label>
                <select
                  value={filters.availability}
                  onChange={(e) => handleFilterChange('availability', e.target.value)}
                >
                  <option value="all">All Items</option>
                  <option value="in-stock">In Stock</option>
                  <option value="limited">Limited Stock</option>
                  <option value="out-of-stock">Out of Stock</option>
                </select>
              </div>

              <button onClick={clearFilters} className="clear-filters-btn">
                Clear All Filters
              </button>
            </div>
          )}

          {isLoading ? (
            <div className="loading-state">
              <div className="loading-spinner"></div>
              <span>Searching...</span>
            </div>
          ) : (
            <div className="search-results">
              {paginatedResults.length > 0 && (
                <div className="results-header">
                  <label className="select-all-label">
                    <input
                      type="checkbox"
                      checked={selectedItems.length === paginatedResults.length && paginatedResults.length > 0}
                      onChange={handleSelectAll}
                    />
                    Select All
                  </label>
                </div>
              )}

              <div className={`results-grid ${viewMode}`}>
                {paginatedResults.map(product => (
                  <div 
                    key={product.id} 
                    className={`product-card ${selectedItems.includes(product.id) ? 'selected' : ''}`}
                  >
                    <div className="product-checkbox">
                      <input
                        type="checkbox"
                        checked={selectedItems.includes(product.id)}
                        onChange={() => handleItemSelect(product.id)}
                      />
                    </div>

                    <div className="product-image">
                      <img src={product.image} alt={product.name} />
                      {product.availability === 'limited' && (
                        <div className="availability-badge limited">Limited</div>
                      )}
                      {product.availability === 'out-of-stock' && (
                        <div className="availability-badge out-of-stock">Out of Stock</div>
                      )}
                    </div>

                    <div className="product-info">
                      <h3 className="product-name">{product.name}</h3>
                      <div className="product-brand">{product.brand}</div>
                      <div className="product-rating">
                        <span className="stars">{renderStars(product.rating)}</span>
                        <span className="rating-text">({product.reviews})</span>
                      </div>
                      <div className="product-price">${product.price.toFixed(2)}</div>
                      <div className="product-description">{product.description}</div>
                    </div>

                    <div className="product-actions">
                      <button className="add-to-cart-btn">Add to Cart</button>
                      <button className="wishlist-btn">♡</button>
                    </div>
                  </div>
                ))}
              </div>

              {totalPages > 1 && (
                <div className="pagination">
                  <button 
                    onClick={() => setCurrentPage(prev => Math.max(1, prev - 1))}
                    disabled={currentPage === 1}
                  >
                    Previous
                  </button>
                  
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
                    <button
                      key={page}
                      onClick={() => setCurrentPage(page)}
                      className={currentPage === page ? 'active' : ''}
                    >
                      {page}
                    </button>
                  ))}
                  
                  <button 
                    onClick={() => setCurrentPage(prev => Math.min(totalPages, prev + 1))}
                    disabled={currentPage === totalPages}
                  >
                    Next
                  </button>
                </div>
              )}
            </div>
          )}

          {searchResults.length === 0 && !isLoading && (
            <div className="no-results">
              <div className="no-results-icon">🔍</div>
              <h3>No products found</h3>
              <p>Try adjusting your search terms or filters</p>
              <button onClick={clearFilters} className="clear-filters-btn">
                Clear All Filters
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default ComplexSearchInterface;

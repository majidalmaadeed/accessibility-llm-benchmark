'use client';

import React, { useState, useEffect, useRef } from 'react';

const SearchWithSilentUpdates = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const [results, setResults] = useState([]);
  const [isSearching, setIsSearching] = useState(false);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const searchTimeoutRef = useRef(null);

  const mockSuggestions = [
    'JavaScript tutorial',
    'React components',
    'CSS animations',
    'Node.js backend',
    'Python programming',
    'Web accessibility',
    'Database design',
    'API development'
  ];

  const mockResults = [
    { id: 1, title: 'JavaScript Tutorial for Beginners', category: 'Programming', rating: 4.8 },
    { id: 2, title: 'Advanced React Patterns', category: 'Web Development', rating: 4.9 },
    { id: 3, title: 'CSS Grid Layout Guide', category: 'Design', rating: 4.7 },
    { id: 4, title: 'Node.js Server Setup', category: 'Backend', rating: 4.6 },
    { id: 5, title: 'Python Data Analysis', category: 'Data Science', rating: 4.8 }
  ];

  const handleSearchChange = (e) => {
    const query = e.target.value;
    setSearchQuery(query);
    
    if (query.length > 0) {
      setShowSuggestions(true);
      const filteredSuggestions = mockSuggestions.filter(suggestion =>
        suggestion.toLowerCase().includes(query.toLowerCase())
      );
      setSuggestions(filteredSuggestions);
    } else {
      setShowSuggestions(false);
      setSuggestions([]);
    }
  };

  const handleSearch = async (query = searchQuery) => {
    if (!query.trim()) {
      setResults([]);
      return;
    }

    setIsSearching(true);
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 800));
    
    const filteredResults = mockResults.filter(result =>
      result.title.toLowerCase().includes(query.toLowerCase()) ||
      result.category.toLowerCase().includes(query.toLowerCase())
    );
    
    setResults(filteredResults);
    setIsSearching(false);
    setShowSuggestions(false);
  };

  const handleSuggestionClick = (suggestion) => {
    setSearchQuery(suggestion);
    setShowSuggestions(false);
    handleSearch(suggestion);
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      handleSearch();
    } else if (e.key === 'Escape') {
      setShowSuggestions(false);
    }
  };

  // Auto-search with debounce
  useEffect(() => {
    if (searchTimeoutRef.current) {
      clearTimeout(searchTimeoutRef.current);
    }

    if (searchQuery.length > 2) {
      searchTimeoutRef.current = setTimeout(() => {
        handleSearch();
      }, 500);
    } else {
      setResults([]);
    }

    return () => {
      if (searchTimeoutRef.current) {
        clearTimeout(searchTimeoutRef.current);
      }
    };
  }, [searchQuery]);

  return (
    <div className="main-container">
      <div className="main-content">
        <h1>Search Knowledge Base</h1>
        <p>Find articles, tutorials, and resources by typing your search query.</p>
        
        <div className="search-section">
          <div className="search-input-container">
            <input
              type="text"
              value={searchQuery}
              onChange={handleSearchChange}
              onKeyDown={handleKeyDown}
              placeholder="Search for articles, tutorials..."
              className="search-input"
            />
            <button onClick={() => handleSearch()} className="search-button">
              🔍
            </button>
          </div>

          {/* Search Suggestions */}
          {showSuggestions && suggestions.length > 0 && (
            <div className="suggestions-dropdown">
              {suggestions.map((suggestion, index) => (
                <div
                  key={index}
                  onClick={() => handleSuggestionClick(suggestion)}
                  className="suggestion-item"
                >
                  {suggestion}
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Search Status */}
        {isSearching && (
          <div className="search-status">
            <div className="status-message">
              Searching...
            </div>
          </div>
        )}

        {/* Search Results */}
        {results.length > 0 && !isSearching && (
          <div className="results-section">
            <h3>Search Results ({results.length} found)</h3>
            <div className="results-list">
              {results.map((result) => (
                <div key={result.id} className="result-item">
                  <h4>{result.title}</h4>
                  <p>Category: {result.category}</p>
                  <div className="rating">
                    <span>Rating:</span>
                    <span className="stars">⭐ {result.rating}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {searchQuery && results.length === 0 && !isSearching && (
          <div className="no-results">
            <p>No results found for "{searchQuery}"</p>
            <p>Try different keywords or check your spelling.</p>
          </div>
        )}
      </div>

      <style jsx>{`
        .main-container {
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

        .search-section {
          margin-top: 30px;
          position: relative;
        }

        .search-input-container {
          position: relative;
        }

        .search-input {
          width: 100%;
          padding: 12px 40px 12px 16px;
          border: 2px solid #ddd;
          border-radius: 8px;
          font-size: 16px;
          box-sizing: border-box;
        }

        .search-input:focus {
          border-color: #007bff;
          outline: none;
        }

        .search-button {
          position: absolute;
          right: 8px;
          top: 50%;
          transform: translateY(-50%);
          background: none;
          border: none;
          cursor: pointer;
          font-size: 18px;
          color: #666;
        }

        .suggestions-dropdown {
          position: absolute;
          top: 100%;
          left: 0;
          right: 0;
          background: white;
          border: 1px solid #ddd;
          border-radius: 0 0 8px 8px;
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
          z-index: 1000;
          max-height: 200px;
          overflow-y: auto;
        }

        .suggestion-item {
          padding: 12px 16px;
          cursor: pointer;
          border-bottom: 1px solid #eee;
        }

        .suggestion-item:hover {
          background-color: #f8f9fa;
        }

        .suggestion-item:last-child {
          border-bottom: none;
        }

        .search-status {
          margin-top: 20px;
          text-align: center;
        }

        .status-message {
          display: inline-block;
          padding: 10px 20px;
          background-color: #e3f2fd;
          border-radius: 4px;
        }

        .results-section {
          margin-top: 30px;
        }

        .results-section h3 {
          margin-bottom: 16px;
        }

        .results-list {
          margin-top: 20px;
        }

        .result-item {
          padding: 20px;
          border: 1px solid #ddd;
          border-radius: 8px;
          margin-bottom: 16px;
          background-color: #fafafa;
        }

        .result-item h4 {
          margin: 0 0 8px 0;
          color: #333;
        }

        .result-item p {
          margin: 0 0 8px 0;
          color: #666;
        }

        .rating {
          display: flex;
          align-items: center;
          gap: 8px;
        }

        .stars {
          color: #ffc107;
        }

        .no-results {
          margin-top: 30px;
          text-align: center;
          padding: 40px;
          color: #666;
        }
      `}</style>
    </div>
  );
};

export default SearchWithSilentUpdates;
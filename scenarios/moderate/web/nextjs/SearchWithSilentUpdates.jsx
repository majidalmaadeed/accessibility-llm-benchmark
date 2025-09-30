import React, { useState, useEffect } from 'react';
const SearchWithSilentUpdates = () => {
  const [query, setQuery] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const [results, setResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const mockData = [
    { id: 1, title: 'React Development Guide', category: 'Books', author: 'John Doe' },
    { id: 2, title: 'Vue.js Tutorial', category: 'Books', author: 'Jane Smith' },
    { id: 3, title: 'Angular Framework', category: 'Books', author: 'Bob Johnson' },
    { id: 4, title: 'JavaScript Fundamentals', category: 'Books', author: 'Alice Brown' },
    { id: 5, title: 'React Components', category: 'Tutorials', author: 'Charlie Wilson' },
    { id: 6, title: 'Vue Components', category: 'Tutorials', author: 'Diana Lee' },
    { id: 7, title: 'Angular Services', category: 'Tutorials', author: 'Eve Davis' },
    { id: 8, title: 'JavaScript ES6', category: 'Tutorials', author: 'Frank Miller' }
  ];
  useEffect(() => {
    if (query.length > 1) {
      const filtered = mockData.filter(item =>
        item.title.toLowerCase().includes(query.toLowerCase()) ||
        item.category.toLowerCase().includes(query.toLowerCase()) ||
        item.author.toLowerCase().includes(query.toLowerCase())
      );
      setSuggestions(filtered.slice(0, 5));
      setShowSuggestions(true);
    } else {
      setSuggestions([]);
      setShowSuggestions(false);
    }
  }, [query]);
  const handleSearch = async () => {
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      const filtered = mockData.filter(item =>
        item.title.toLowerCase().includes(query.toLowerCase()) ||
        item.category.toLowerCase().includes(query.toLowerCase()) ||
        item.author.toLowerCase().includes(query.toLowerCase())
      );
      setResults(filtered);
      setIsLoading(false);
      setShowSuggestions(false);
    }, 1000);
  };
  const handleSuggestionClick = (suggestion) => {
    setQuery(suggestion.title);
    setShowSuggestions(false);
    handleSearch();
  };
  const handleKeyDown = (e) => {
    if (e.key === 'Enter') {
      handleSearch();
    } else if (e.key === 'Escape') {
      setShowSuggestions(false);
    }
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Search Interface</h1>
        <p>Search for content using the input field below. Suggestions will appear as you type.</p>
        <div style={{ marginBottom: '30px' }}>
          <div style={{ position: 'relative', marginBottom: '20px' }}>
              Search for content:
            <input
              type="text"
              id="search-input"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="Type to search..."
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '2px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            {}
            {showSuggestions && suggestions.length > 0 && (
              <div
                style={{
                  position: 'absolute',
                  top: '100%',
                  left: 0,
                  right: 0,
                  background: 'white',
                  border: '2px solid #007bff',
                  borderTop: 'none',
                  borderRadius: '0 0 4px 4px',
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                  zIndex: 1000,
                  maxHeight: '200px',
                  overflowY: 'auto'
                }}
              >
                {suggestions.map((suggestion, index) => (
                  <div
                    key={suggestion.id}
                    id={`suggestion-${index}`}
                    onClick={() => handleSuggestionClick(suggestion)}
                    style={{
                      padding: '12px 16px',
                      cursor: 'pointer',
                      borderBottom: '1px solid #eee',
                      fontSize: '14px'
                    }}
                    onMouseEnter={(e) => e.target.style.backgroundColor = '#f8f9fa'}
                    onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
                  >
                    <div style={{ fontWeight: 'bold', color: '#333' }}>{suggestion.title}</div>
                    <div style={{ color: '#666', fontSize: '12px' }}>{suggestion.category} • {suggestion.author}</div>
                  </div>
                ))}
              </div>
            )}
          </div>
          <button
            onClick={handleSearch}
            disabled={isLoading || !query.trim()}
            style={{
              backgroundColor: isLoading ? '#6c757d' : '#007bff',
              color: 'white',
              padding: '12px 24px',
              border: 'none',
              borderRadius: '4px',
              fontSize: '16px',
              cursor: isLoading ? 'not-allowed' : 'pointer'
            }}
          >
            {isLoading ? 'Searching...' : 'Search'}
          </button>
        </div>
        {}
        <div>
          <h2>Search Results</h2>
          {isLoading ? (
            <div style={{ textAlign: 'center', padding: '20px' }}>
              <div style={{ fontSize: '18px', color: '#666' }}>Searching...</div>
            </div>
          ) : results.length > 0 ? (
            <div>
              <div style={{ marginBottom: '16px', fontSize: '14px', color: '#666' }}>
                Found {results.length} result{results.length !== 1 ? 's' : ''}
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                {results.map((result) => (
                  <div
                    key={result.id}
                    style={{
                      background: '#f8f9fa',
                      padding: '16px',
                      borderRadius: '4px',
                      border: '1px solid #ddd'
                    }}
                  >
                    <h3 style={{ margin: '0 0 8px 0', color: '#333' }}>{result.title}</h3>
                    <p style={{ margin: '0 0 4px 0', color: '#666', fontSize: '14px' }}>
                      Category: {result.category}
                    </p>
                    <p style={{ margin: '0', color: '#666', fontSize: '14px' }}>
                      Author: {result.author}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          ) : query ? (
            <div style={{ textAlign: 'center', padding: '20px' }}>
              <div style={{ fontSize: '18px', color: '#666' }}>No results found for "{query}"</div>
            </div>
          ) : (
            <div style={{ textAlign: 'center', padding: '20px' }}>
              <div style={{ fontSize: '18px', color: '#666' }}>Enter a search term to find content</div>
            </div>
          )}
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default SearchWithSilentUpdates;
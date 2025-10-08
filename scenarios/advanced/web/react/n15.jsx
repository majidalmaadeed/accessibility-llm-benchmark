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
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Search Knowledge Base</h1>
        <p>Find articles, tutorials, and resources by typing your search query.</p>
        
        <div style={{ marginTop: '30px', position: 'relative' }}>
          <div style={{ position: 'relative' }}>
            <input
              type="text"
              value={searchQuery}
              onChange={handleSearchChange}
              onKeyDown={handleKeyDown}
              placeholder="Search for articles, tutorials..."
              style={{
                width: '100%',
                padding: '12px 40px 12px 16px',
                border: '2px solid #ddd',
                borderRadius: '8px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <button
              onClick={() => handleSearch()}
              style={{
                position: 'absolute',
                right: '8px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                fontSize: '18px',
                color: '#666'
              }}
            >
              🔍
            </button>
          </div>

          {/* Search Suggestions */}
          {showSuggestions && suggestions.length > 0 && (
            <div style={{
              position: 'absolute',
              top: '100%',
              left: 0,
              right: 0,
              background: 'white',
              border: '1px solid #ddd',
              borderRadius: '0 0 8px 8px',
              boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
              zIndex: 1000,
              maxHeight: '200px',
              overflowY: 'auto'
            }}>
              {suggestions.map((suggestion, index) => (
                <div
                  key={index}
                  onClick={() => handleSuggestionClick(suggestion)}
                  style={{
                    padding: '12px 16px',
                    cursor: 'pointer',
                    borderBottom: index < suggestions.length - 1 ? '1px solid #eee' : 'none'
                  }}
                  onMouseEnter={(e) => e.target.style.backgroundColor = '#f8f9fa'}
                  onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
                >
                  {suggestion}
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Search Status */}
        {isSearching && (
          <div style={{ marginTop: '20px', textAlign: 'center' }}>
            <div style={{ display: 'inline-block', padding: '10px 20px', backgroundColor: '#e3f2fd', borderRadius: '4px' }}>
              Searching...
            </div>
          </div>
        )}

        {/* Search Results */}
        {results.length > 0 && !isSearching && (
          <div style={{ marginTop: '30px' }}>
            <h3>Search Results ({results.length} found)</h3>
            <div style={{ marginTop: '20px' }}>
              {results.map((result) => (
                <div key={result.id} style={{
                  padding: '20px',
                  border: '1px solid #ddd',
                  borderRadius: '8px',
                  marginBottom: '16px',
                  backgroundColor: '#fafafa'
                }}>
                  <h4 style={{ margin: '0 0 8px 0', color: '#333' }}>{result.title}</h4>
                  <p style={{ margin: '0 0 8px 0', color: '#666' }}>Category: {result.category}</p>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <span style={{ color: '#666' }}>Rating:</span>
                    <span style={{ color: '#ffc107' }}>⭐ {result.rating}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {searchQuery && results.length === 0 && !isSearching && (
          <div style={{ marginTop: '30px', textAlign: 'center', padding: '40px', color: '#666' }}>
            <p>No results found for "{searchQuery}"</p>
            <p>Try different keywords or check your spelling.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default SearchWithSilentUpdates;
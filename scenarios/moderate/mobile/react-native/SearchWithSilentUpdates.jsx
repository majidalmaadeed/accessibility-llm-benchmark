import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
  ScrollView,
  ActivityIndicator,
  Alert,
} from 'react-native';

const SearchWithSilentUpdates = () => {
  const [query, setQuery] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const [results, setResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [activeSuggestionIndex, setActiveSuggestionIndex] = useState(-1);

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

  const handleInput = (text) => {
    setQuery(text);
    if (text.length > 1) {
      const filtered = mockData.filter(item =>
        item.title.toLowerCase().includes(text.toLowerCase()) ||
        item.category.toLowerCase().includes(text.toLowerCase()) ||
        item.author.toLowerCase().includes(text.toLowerCase())
      );
      setSuggestions(filtered.slice(0, 5));
      setShowSuggestions(true);
      setActiveSuggestionIndex(-1);
    } else {
      setSuggestions([]);
      setShowSuggestions(false);
      setActiveSuggestionIndex(-1);
    }
  };

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
      setActiveSuggestionIndex(-1);
      
      // MISSING: Screen reader announcement of results
      // Should announce "Found X results" or "No results found"
    }, 1000);
  };

  const handleSuggestionClick = (suggestion) => {
    setQuery(suggestion.title);
    setShowSuggestions(false);
    setActiveSuggestionIndex(-1);
    handleSearch();
  };

  const renderSuggestion = ({ item, index }) => (
    <TouchableOpacity
      style={[
        styles.suggestionItem,
        index === activeSuggestionIndex && styles.activeSuggestion
      ]}
      onPress={() => handleSuggestionClick(item)}
      accessible={true}
      accessibilityLabel={`${item.title}, ${item.category}, ${item.author}`}
      accessibilityHint="Tap to select this suggestion"
      accessibilityRole="button"
    >
      <Text style={styles.suggestionTitle}>{item.title}</Text>
      <Text style={styles.suggestionMeta}>{item.category} • {item.author}</Text>
    </TouchableOpacity>
  );

  const renderResult = ({ item }) => (
    <View style={styles.resultCard}>
      <Text style={styles.resultTitle}>{item.title}</Text>
      <Text style={styles.resultCategory}>Category: {item.category}</Text>
      <Text style={styles.resultAuthor}>Author: {item.author}</Text>
    </View>
  );

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.contentContainer}>
      <View style={styles.mainContent}>
        <Text style={styles.title}>Search Interface</Text>
        <Text style={styles.subtitle}>
          Search for content using the input field below. Suggestions will appear as you type.
        </Text>
        
        {/* Search Input Section */}
        <View style={styles.searchSection}>
          <Text style={styles.label}>Search for content:</Text>
          
          <View style={styles.inputContainer}>
            <TextInput
              style={styles.searchInput}
              value={query}
              onChangeText={handleInput}
              placeholder="Type to search..."
              placeholderTextColor="#999"
              accessible={true}
              accessibilityLabel="Search input field"
              accessibilityHint="Enter search terms to find content"
              accessibilityValue={query || "Empty"}
              onSubmitEditing={handleSearch}
              returnKeyType="search"
            />
            
            {/* Suggestions Dropdown - MISSING ARIA ATTRIBUTES */}
            {showSuggestions && suggestions.length > 0 && (
              <View style={styles.suggestionsContainer}>
                <FlatList
                  data={suggestions}
                  renderItem={renderSuggestion}
                  keyExtractor={(item) => item.id.toString()}
                  style={styles.suggestionsList}
                  accessible={true}
                  accessibilityLabel="Search suggestions"
                  accessibilityRole="list"
                />
              </View>
            )}
          </View>
          
          <TouchableOpacity
            style={[styles.searchButton, isLoading && styles.searchButtonDisabled]}
            onPress={handleSearch}
            disabled={isLoading || !query.trim()}
            accessible={true}
            accessibilityLabel="Search button"
            accessibilityHint="Tap to search for content"
            accessibilityRole="button"
          >
            {isLoading ? (
              <ActivityIndicator color="#fff" size="small" />
            ) : (
              <Text style={styles.searchButtonText}>Search</Text>
            )}
          </TouchableOpacity>
        </View>

        {/* Results Section - MISSING LIVE REGION */}
        <View style={styles.resultsSection}>
          <Text style={styles.resultsTitle}>Search Results</Text>
          
          {isLoading ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator size="large" color="#007bff" />
              <Text style={styles.loadingText}>Searching...</Text>
            </View>
          ) : results.length > 0 ? (
            <View style={styles.resultsContent}>
              <Text style={styles.resultsCount}>
                Found {results.length} result{results.length !== 1 ? 's' : ''}
              </Text>
              <FlatList
                data={results}
                renderItem={renderResult}
                keyExtractor={(item) => item.id.toString()}
                style={styles.resultsList}
                scrollEnabled={false}
                accessible={true}
                accessibilityLabel="Search results"
                accessibilityRole="list"
              />
            </View>
          ) : query ? (
            <View style={styles.noResultsContainer}>
              <Text style={styles.noResultsText}>No results found for "{query}"</Text>
            </View>
          ) : (
            <View style={styles.emptyContainer}>
              <Text style={styles.emptyText}>Enter a search term to find content</Text>
            </View>
          )}
        </View>
      </View>

      <View style={styles.accessibilityInfo}>
        <Text style={styles.infoTitle}>Accessibility Issues:</Text>
        <View style={styles.issueList}>
          <Text style={styles.issueItem}>• Missing live region: No announcements when search results change</Text>
          <Text style={styles.issueItem}>• Incomplete ARIA attributes: Suggestions lack proper aria-activedescendant</Text>
          <Text style={styles.issueItem}>• No keyboard navigation: Arrow keys don't navigate through suggestions</Text>
          <Text style={styles.issueItem}>• Missing announcements: Screen readers don't announce result count changes</Text>
          <Text style={styles.issueItem}>• No loading state announcement: Loading state not announced to screen readers</Text>
          <Text style={styles.issueItem}>• Missing suggestion selection: No aria-selected state management</Text>
        </View>
        
        <Text style={styles.infoTitle}>How to Fix:</Text>
        <View style={styles.fixList}>
          <Text style={styles.fixItem}>• Add aria-live="polite" region for result announcements</Text>
          <Text style={styles.fixItem}>• Implement aria-activedescendant for suggestion navigation</Text>
          <Text style={styles.fixItem}>• Add arrow key navigation (Up/Down) through suggestions</Text>
          <Text style={styles.fixItem}>• Announce result count changes ("Found X results")</Text>
          <Text style={styles.fixItem}>• Add loading state announcements</Text>
          <Text style={styles.fixItem}>• Implement proper aria-selected state management</Text>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  contentContainer: {
    padding: 20,
  },
  mainContent: {
    backgroundColor: 'white',
    padding: 30,
    borderRadius: 8,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 10,
    elevation: 4,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 30,
    lineHeight: 24,
  },
  bold: {
    fontWeight: 'bold',
  },
  searchSection: {
    marginBottom: 30,
  },
  label: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  inputContainer: {
    position: 'relative',
    marginBottom: 20,
  },
  searchInput: {
    borderWidth: 2,
    borderColor: '#ddd',
    borderRadius: 4,
    padding: 12,
    fontSize: 16,
    backgroundColor: 'white',
  },
  suggestionsContainer: {
    position: 'absolute',
    top: '100%',
    left: 0,
    right: 0,
    backgroundColor: 'white',
    borderWidth: 2,
    borderColor: '#007bff',
    borderTopWidth: 0,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
    zIndex: 1000,
    maxHeight: 200,
  },
  suggestionsList: {
    maxHeight: 200,
  },
  suggestionItem: {
    padding: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  activeSuggestion: {
    backgroundColor: '#f8f9fa',
  },
  suggestionTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
  },
  suggestionMeta: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
  searchButton: {
    backgroundColor: '#007bff',
    padding: 12,
    borderRadius: 4,
    alignItems: 'center',
    justifyContent: 'center',
    minHeight: 48,
  },
  searchButtonDisabled: {
    backgroundColor: '#6c757d',
  },
  searchButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  resultsSection: {
    marginBottom: 20,
  },
  resultsTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  loadingContainer: {
    alignItems: 'center',
    padding: 20,
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
    marginTop: 10,
  },
  resultsContent: {
    marginBottom: 16,
  },
  resultsCount: {
    fontSize: 14,
    color: '#666',
    marginBottom: 16,
  },
  resultsList: {
    maxHeight: 300,
  },
  resultCard: {
    backgroundColor: '#f8f9fa',
    padding: 16,
    borderRadius: 4,
    borderWidth: 1,
    borderColor: '#ddd',
    marginBottom: 12,
  },
  resultTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 8,
  },
  resultCategory: {
    fontSize: 12,
    color: '#666',
    marginBottom: 4,
  },
  resultAuthor: {
    fontSize: 12,
    color: '#666',
  },
  noResultsContainer: {
    alignItems: 'center',
    padding: 20,
  },
  noResultsText: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
  },
  emptyContainer: {
    alignItems: 'center',
    padding: 20,
  },
  emptyText: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
  },
  accessibilityInfo: {
    backgroundColor: '#e9ecef',
    padding: 20,
    borderRadius: 4,
  },
  infoTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  issueList: {
    marginBottom: 20,
  },
  issueItem: {
    fontSize: 14,
    color: '#333',
    marginBottom: 8,
    lineHeight: 20,
  },
  fixList: {
    marginBottom: 0,
  },
  fixItem: {
    fontSize: 14,
    color: '#333',
    marginBottom: 8,
    lineHeight: 20,
  },
});

export default SearchWithSilentUpdates;
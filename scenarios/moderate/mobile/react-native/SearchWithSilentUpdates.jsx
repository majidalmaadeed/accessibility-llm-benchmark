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
          <View style={styles.inputContainer}>
            <TextInput
              style={styles.searchInput}
              value={query}
              onChangeText={handleInput}
              placeholder="Type to search..."
              placeholderTextColor="#999"
              accessible={true}
              onSubmitEditing={handleSearch}
              returnKeyType="search"
            />
            {}
            {showSuggestions && suggestions.length > 0 && (
              <View style={styles.suggestionsContainer}>
                <FlatList
                  data={suggestions}
                  renderItem={renderSuggestion}
                  keyExtractor={(item) => item.id.toString()}
                  style={styles.suggestionsList}
                  accessible={true}
                />
              </View>
            )}
          </View>
          <TouchableOpacity
            style={[styles.searchButton, isLoading && styles.searchButtonDisabled]}
            onPress={handleSearch}
            disabled={isLoading || !query.trim()}
            accessible={true}
          >
            {isLoading ? (
              <ActivityIndicator color="#fff" size="small" />
            ) : (
              <Text style={styles.searchButtonText}>Search</Text>
            )}
          </TouchableOpacity>
        </View>
        {}
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
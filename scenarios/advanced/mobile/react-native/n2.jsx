import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Modal,
  Alert,
  Dimensions,
  FlatList,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const ComplexSearchInterface = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedFilters, setSelectedFilters] = useState(new Set());
  const [sortOption, setSortOption] = useState('relevance');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [showFilters, setShowFilters] = useState(false);
  const [searchHistory, setSearchHistory] = useState([]);
  const [showHistory, setShowHistory] = useState(false);
  const [selectedResult, setSelectedResult] = useState(null);
  const [viewMode, setViewMode] = useState('list'); // list, grid, compact
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [priceRange, setPriceRange] = useState({ min: 0, max: 1000 });
  const [dateRange, setDateRange] = useState({ start: '', end: '' });
  const [showAdvancedFilters, setShowAdvancedFilters] = useState(false);

  const categories = [
    'All', 'Documents', 'Images', 'Videos', 'Audio', 'Web Pages', 
    'News', 'Products', 'People', 'Locations'
  ];

  const sortOptions = [
    { value: 'relevance', label: 'Relevance' },
    { value: 'date', label: 'Date' },
    { value: 'name', label: 'Name' },
    { value: 'size', label: 'Size' },
    { value: 'type', label: 'Type' },
    { value: 'rating', label: 'Rating' },
  ];

  const viewModes = [
    { value: 'list', label: 'List', icon: 'list' },
    { value: 'grid', label: 'Grid', icon: 'grid' },
    { value: 'compact', label: 'Compact', icon: 'menu' },
  ];

  const filters = [
    { id: 'recent', name: 'Recent', type: 'date' },
    { id: 'large', name: 'Large Files', type: 'size' },
    { id: 'images', name: 'Images Only', type: 'type' },
    { id: 'videos', name: 'Videos Only', type: 'type' },
    { id: 'documents', name: 'Documents Only', type: 'type' },
    { id: 'free', name: 'Free', type: 'price' },
    { id: 'premium', name: 'Premium', type: 'price' },
  ];

  const sampleResults = [
    {
      id: '1',
      title: 'React Native Development Guide',
      description: 'Comprehensive guide to building mobile apps with React Native',
      type: 'document',
      category: 'Documents',
      size: '2.5 MB',
      date: '2024-01-15',
      rating: 4.8,
      price: 0,
      image: '📄',
      url: 'https://example.com/react-native-guide',
    },
    {
      id: '2',
      title: 'Mobile UI Design Patterns',
      description: 'Best practices for mobile user interface design',
      type: 'image',
      category: 'Images',
      size: '1.2 MB',
      date: '2024-01-14',
      rating: 4.6,
      price: 29.99,
      image: '🖼️',
      url: 'https://example.com/ui-patterns',
    },
    {
      id: '3',
      title: 'JavaScript Tutorial Series',
      description: 'Complete JavaScript tutorial for beginners',
      type: 'video',
      category: 'Videos',
      size: '150 MB',
      date: '2024-01-13',
      rating: 4.9,
      price: 49.99,
      image: '🎥',
      url: 'https://example.com/js-tutorial',
    },
    {
      id: '4',
      title: 'Web Development News',
      description: 'Latest news and updates in web development',
      type: 'news',
      category: 'News',
      size: '500 KB',
      date: '2024-01-12',
      rating: 4.3,
      price: 0,
      image: '📰',
      url: 'https://example.com/web-news',
    },
    {
      id: '5',
      title: 'E-commerce Product Catalog',
      description: 'Complete product catalog for online store',
      type: 'product',
      category: 'Products',
      size: '5.8 MB',
      date: '2024-01-11',
      rating: 4.5,
      price: 99.99,
      image: '🛍️',
      url: 'https://example.com/product-catalog',
    },
  ];

  useEffect(() => {
    if (searchQuery.trim()) {
      performSearch();
    } else {
      setSearchResults([]);
    }
  }, [searchQuery, selectedFilters, sortOption, selectedCategory, priceRange, dateRange]);

  const performSearch = async () => {
    setIsLoading(true);
    
    // Simulate API call
    setTimeout(() => {
      let filteredResults = [...sampleResults];
      
      // Apply search query filter
      if (searchQuery.trim()) {
        filteredResults = filteredResults.filter(result =>
          result.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
          result.description.toLowerCase().includes(searchQuery.toLowerCase())
        );
      }
      
      // Apply category filter
      if (selectedCategory !== 'All') {
        filteredResults = filteredResults.filter(result =>
          result.category === selectedCategory
        );
      }
      
      // Apply price range filter
      filteredResults = filteredResults.filter(result =>
        result.price >= priceRange.min && result.price <= priceRange.max
      );
      
      // Apply selected filters
      selectedFilters.forEach(filterId => {
        const filter = filters.find(f => f.id === filterId);
        if (filter) {
          switch (filter.type) {
            case 'type':
              filteredResults = filteredResults.filter(result =>
                result.type === filterId.slice(0, -1) // Remove 's' from 'images', 'videos', etc.
              );
              break;
            case 'price':
              if (filterId === 'free') {
                filteredResults = filteredResults.filter(result => result.price === 0);
              } else if (filterId === 'premium') {
                filteredResults = filteredResults.filter(result => result.price > 0);
              }
              break;
            case 'size':
              if (filterId === 'large') {
                filteredResults = filteredResults.filter(result => 
                  parseFloat(result.size) > 1 // Files larger than 1 MB
                );
              }
              break;
            case 'date':
              if (filterId === 'recent') {
                const recentDate = new Date();
                recentDate.setDate(recentDate.getDate() - 7);
                filteredResults = filteredResults.filter(result =>
                  new Date(result.date) > recentDate
                );
              }
              break;
          }
        }
      });
      
      // Apply sorting
      filteredResults.sort((a, b) => {
        switch (sortOption) {
          case 'date':
            return new Date(b.date) - new Date(a.date);
          case 'name':
            return a.title.localeCompare(b.title);
          case 'size':
            return parseFloat(b.size) - parseFloat(a.size);
          case 'type':
            return a.type.localeCompare(b.type);
          case 'rating':
            return b.rating - a.rating;
          default:
            return 0; // relevance - keep original order
        }
      });
      
      setSearchResults(filteredResults);
      setTotalPages(Math.ceil(filteredResults.length / 10));
      setCurrentPage(1);
      setIsLoading(false);
    }, 1000);
  };

  const handleSearch = () => {
    if (searchQuery.trim()) {
      // Add to search history
      if (!searchHistory.includes(searchQuery)) {
        setSearchHistory(prev => [searchQuery, ...prev.slice(0, 9)]);
      }
      performSearch();
    }
  };

  const handleFilterToggle = (filterId) => {
    const newFilters = new Set(selectedFilters);
    if (newFilters.has(filterId)) {
      newFilters.delete(filterId);
    } else {
      newFilters.add(filterId);
    }
    setSelectedFilters(newFilters);
  };

  const clearFilters = () => {
    setSelectedFilters(new Set());
    setSelectedCategory('All');
    setPriceRange({ min: 0, max: 1000 });
    setDateRange({ start: '', end: '' });
  };

  const handleResultPress = (result) => {
    setSelectedResult(result);
    Alert.alert(
      result.title,
      `${result.description}\n\nType: ${result.type}\nSize: ${result.size}\nDate: ${result.date}\nRating: ${result.rating}/5\nPrice: $${result.price}`,
      [
        { text: 'Close', style: 'cancel' },
        { text: 'Open', onPress: () => console.log('Opening:', result.url) },
      ]
    );
  };

  const renderSearchBar = () => (
    <View style={styles.searchContainer}>
      <View style={styles.searchInputContainer}>
        <Ionicons name="search" size={20} color="#666" style={styles.searchIcon} />
        <TextInput
          style={styles.searchInput}
          placeholder="Search for anything..."
          value={searchQuery}
          onChangeText={setSearchQuery}
          onSubmitEditing={handleSearch}
          placeholderTextColor="#999"
        />
        {searchQuery.length > 0 && (
          <TouchableOpacity
            onPress={() => setSearchQuery('')}
            style={styles.clearButton}
          >
            <Ionicons name="close-circle" size={20} color="#666" />
          </TouchableOpacity>
        )}
      </View>
      
      <TouchableOpacity
        style={styles.searchButton}
        onPress={handleSearch}
      >
        <Ionicons name="search" size={20} color="#fff" />
      </TouchableOpacity>
    </View>
  );

  const renderFilters = () => (
    <View style={styles.filtersContainer}>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        <View style={styles.filtersContent}>
          <TouchableOpacity
            style={styles.filterChip}
            onPress={() => setShowFilters(true)}
          >
            <Ionicons name="filter" size={16} color="#007AFF" />
            <Text style={styles.filterChipText}>Filters</Text>
            {selectedFilters.size > 0 && (
              <View style={styles.filterBadge}>
                <Text style={styles.filterBadgeText}>{selectedFilters.size}</Text>
              </View>
            )}
          </TouchableOpacity>

          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {filters.map((filter) => (
              <TouchableOpacity
                key={filter.id}
                style={[
                  styles.filterChip,
                  selectedFilters.has(filter.id) && styles.filterChipActive,
                ]}
                onPress={() => handleFilterToggle(filter.id)}
              >
                <Text
                  style={[
                    styles.filterChipText,
                    selectedFilters.has(filter.id) && styles.filterChipTextActive,
                  ]}
                >
                  {filter.name}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      </ScrollView>
    </View>
  );

  const renderSortAndView = () => (
    <View style={styles.sortViewContainer}>
      <View style={styles.sortContainer}>
        <Text style={styles.sortLabel}>Sort by:</Text>
        <TouchableOpacity
          style={styles.sortButton}
          onPress={() => setShowSortModal(true)}
        >
          <Text style={styles.sortButtonText}>
            {sortOptions.find(opt => opt.value === sortOption)?.label}
          </Text>
          <Ionicons name="chevron-down" size={16} color="#666" />
        </TouchableOpacity>
      </View>

      <View style={styles.viewModeContainer}>
        {viewModes.map((mode) => (
          <TouchableOpacity
            key={mode.value}
            style={[
              styles.viewModeButton,
              viewMode === mode.value && styles.viewModeButtonActive,
            ]}
            onPress={() => setViewMode(mode.value)}
          >
            <Ionicons
              name={mode.icon}
              size={16}
              color={viewMode === mode.value ? '#fff' : '#666'}
            />
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );

  const renderResults = () => {
    if (isLoading) {
      return (
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingText}>Searching...</Text>
        </View>
      );
    }

    if (searchResults.length === 0 && searchQuery.trim()) {
      return (
        <View style={styles.emptyContainer}>
          <Ionicons name="search" size={64} color="#ccc" />
          <Text style={styles.emptyTitle}>No results found</Text>
          <Text style={styles.emptySubtitle}>
            Try adjusting your search terms or filters
          </Text>
          <TouchableOpacity
            style={styles.clearFiltersButton}
            onPress={clearFilters}
          >
            <Text style={styles.clearFiltersButtonText}>Clear all filters</Text>
          </TouchableOpacity>
        </View>
      );
    }

    return (
      <FlatList
        data={searchResults}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => renderResultItem(item)}
        style={styles.resultsList}
        showsVerticalScrollIndicator={false}
      />
    );
  };

  const renderResultItem = (item) => (
    <TouchableOpacity
      style={styles.resultItem}
      onPress={() => handleResultPress(item)}
    >
      <View style={styles.resultImage}>
        <Text style={styles.resultImageText}>{item.image}</Text>
      </View>
      
      <View style={styles.resultContent}>
        <Text style={styles.resultTitle} numberOfLines={2}>
          {item.title}
        </Text>
        <Text style={styles.resultDescription} numberOfLines={2}>
          {item.description}
        </Text>
        
        <View style={styles.resultMeta}>
          <View style={styles.resultMetaItem}>
            <Ionicons name="folder" size={12} color="#666" />
            <Text style={styles.resultMetaText}>{item.category}</Text>
          </View>
          <View style={styles.resultMetaItem}>
            <Ionicons name="time" size={12} color="#666" />
            <Text style={styles.resultMetaText}>{item.date}</Text>
          </View>
          <View style={styles.resultMetaItem}>
            <Ionicons name="star" size={12} color="#FFD700" />
            <Text style={styles.resultMetaText}>{item.rating}</Text>
          </View>
          <View style={styles.resultMetaItem}>
            <Ionicons name="document" size={12} color="#666" />
            <Text style={styles.resultMetaText}>{item.size}</Text>
          </View>
        </View>
        
        {item.price > 0 && (
          <Text style={styles.resultPrice}>${item.price}</Text>
        )}
      </View>
      
      <TouchableOpacity style={styles.resultAction}>
        <Ionicons name="chevron-forward" size={20} color="#ccc" />
      </TouchableOpacity>
    </TouchableOpacity>
  );

  const renderAdvancedFilters = () => (
    <Modal
      visible={showFilters}
      animationType="slide"
      onRequestClose={() => setShowFilters(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowFilters(false)}>
            <Text style={styles.modalCancelText}>Cancel</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Filters</Text>
          <TouchableOpacity onPress={clearFilters}>
            <Text style={styles.modalClearText}>Clear All</Text>
          </TouchableOpacity>
        </View>

        <ScrollView style={styles.modalContent}>
          <View style={styles.filterSection}>
            <Text style={styles.filterSectionTitle}>Category</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {categories.map((category) => (
                <TouchableOpacity
                  key={category}
                  style={[
                    styles.categoryChip,
                    selectedCategory === category && styles.categoryChipActive,
                  ]}
                  onPress={() => setSelectedCategory(category)}
                >
                  <Text
                    style={[
                      styles.categoryChipText,
                      selectedCategory === category && styles.categoryChipTextActive,
                    ]}
                  >
                    {category}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>

          <View style={styles.filterSection}>
            <Text style={styles.filterSectionTitle}>Price Range</Text>
            <View style={styles.priceRangeContainer}>
              <TextInput
                style={styles.priceInput}
                placeholder="Min"
                value={priceRange.min.toString()}
                onChangeText={(text) => setPriceRange(prev => ({ ...prev, min: parseFloat(text) || 0 }))}
                keyboardType="numeric"
              />
              <Text style={styles.priceRangeText}>to</Text>
              <TextInput
                style={styles.priceInput}
                placeholder="Max"
                value={priceRange.max.toString()}
                onChangeText={(text) => setPriceRange(prev => ({ ...prev, max: parseFloat(text) || 1000 }))}
                keyboardType="numeric"
              />
            </View>
          </View>

          <View style={styles.filterSection}>
            <Text style={styles.filterSectionTitle}>Date Range</Text>
            <View style={styles.dateRangeContainer}>
              <TextInput
                style={styles.dateInput}
                placeholder="Start Date (YYYY-MM-DD)"
                value={dateRange.start}
                onChangeText={(text) => setDateRange(prev => ({ ...prev, start: text }))}
              />
              <Text style={styles.dateRangeText}>to</Text>
              <TextInput
                style={styles.dateInput}
                placeholder="End Date (YYYY-MM-DD)"
                value={dateRange.end}
                onChangeText={(text) => setDateRange(prev => ({ ...prev, end: text }))}
              />
            </View>
          </View>
        </ScrollView>

        <View style={styles.modalFooter}>
          <TouchableOpacity
            style={styles.applyButton}
            onPress={() => setShowFilters(false)}
          >
            <Text style={styles.applyButtonText}>Apply Filters</Text>
          </TouchableOpacity>
        </View>
      </View>
    </Modal>
  );

  const [showSortModal, setShowSortModal] = useState(false);

  const renderSortModal = () => (
    <Modal
      visible={showSortModal}
      animationType="fade"
      transparent={true}
      onRequestClose={() => setShowSortModal(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.sortModalContent}>
          <Text style={styles.sortModalTitle}>Sort by</Text>
          {sortOptions.map((option) => (
            <TouchableOpacity
              key={option.value}
              style={styles.sortOption}
              onPress={() => {
                setSortOption(option.value);
                setShowSortModal(false);
              }}
            >
              <Text style={styles.sortOptionText}>{option.label}</Text>
              {sortOption === option.value && (
                <Ionicons name="checkmark" size={20} color="#007AFF" />
              )}
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </Modal>
  );

  return (
    <View style={styles.container}>
      {renderSearchBar()}
      {renderFilters()}
      {renderSortAndView()}
      {renderResults()}
      {renderAdvancedFilters()}
      {renderSortModal()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  searchContainer: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
    gap: 12,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    paddingHorizontal: 12,
  },
  searchIcon: {
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    paddingVertical: 12,
    fontSize: 16,
    color: '#333',
  },
  clearButton: {
    padding: 4,
  },
  searchButton: {
    backgroundColor: '#007AFF',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  filtersContainer: {
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  filtersContent: {
    flexDirection: 'row',
    padding: 16,
    gap: 8,
  },
  filterChip: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
    paddingVertical: 6,
    backgroundColor: '#f0f0f0',
    borderRadius: 16,
    gap: 4,
  },
  filterChipActive: {
    backgroundColor: '#007AFF',
  },
  filterChipText: {
    fontSize: 14,
    color: '#666',
  },
  filterChipTextActive: {
    color: '#fff',
  },
  filterBadge: {
    backgroundColor: '#FF3B30',
    borderRadius: 8,
    minWidth: 16,
    height: 16,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 4,
  },
  filterBadgeText: {
    color: '#fff',
    fontSize: 10,
    fontWeight: 'bold',
  },
  sortViewContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  sortContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  sortLabel: {
    fontSize: 14,
    color: '#666',
  },
  sortButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
    paddingVertical: 6,
    backgroundColor: '#f0f0f0',
    borderRadius: 6,
    gap: 4,
  },
  sortButtonText: {
    fontSize: 14,
    color: '#333',
  },
  viewModeContainer: {
    flexDirection: 'row',
    gap: 4,
  },
  viewModeButton: {
    width: 32,
    height: 32,
    borderRadius: 6,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  viewModeButtonActive: {
    backgroundColor: '#007AFF',
  },
  resultsList: {
    flex: 1,
  },
  resultItem: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
    alignItems: 'center',
  },
  resultImage: {
    width: 48,
    height: 48,
    borderRadius: 8,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  resultImageText: {
    fontSize: 24,
  },
  resultContent: {
    flex: 1,
  },
  resultTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  resultDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8,
  },
  resultMeta: {
    flexDirection: 'row',
    gap: 12,
    marginBottom: 4,
  },
  resultMetaItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  resultMetaText: {
    fontSize: 12,
    color: '#666',
  },
  resultPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  resultAction: {
    padding: 8,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 16,
    marginBottom: 8,
  },
  emptySubtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    marginBottom: 24,
  },
  clearFiltersButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
  },
  clearFiltersButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
  },
  modalContainer: {
    flex: 1,
    backgroundColor: '#fff',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  modalCancelText: {
    fontSize: 16,
    color: '#666',
  },
  modalClearText: {
    fontSize: 16,
    color: '#007AFF',
  },
  modalContent: {
    flex: 1,
    padding: 16,
  },
  filterSection: {
    marginBottom: 24,
  },
  filterSectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  categoryChip: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    marginRight: 8,
  },
  categoryChipActive: {
    backgroundColor: '#007AFF',
  },
  categoryChipText: {
    fontSize: 14,
    color: '#666',
  },
  categoryChipTextActive: {
    color: '#fff',
  },
  priceRangeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  priceInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 8,
    fontSize: 16,
  },
  priceRangeText: {
    fontSize: 14,
    color: '#666',
  },
  dateRangeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  dateInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 8,
    fontSize: 16,
  },
  dateRangeText: {
    fontSize: 14,
    color: '#666',
  },
  modalFooter: {
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
  applyButton: {
    backgroundColor: '#007AFF',
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: 'center',
  },
  applyButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  sortModalContent: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    width: width - 40,
  },
  sortModalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  sortOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  sortOptionText: {
    fontSize: 16,
    color: '#333',
  },
});

export default ComplexSearchInterface;

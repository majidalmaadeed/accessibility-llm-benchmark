import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  ActivityIndicator,
  Alert,
} from 'react-native';

const SilentLoadingState = () => {
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const [searchQuery, setSearchQuery] = useState('');
  const [filter, setFilter] = useState('all');
  const [sortBy, setSortBy] = useState('name');

  const mockData = [
    {
      id: 1,
      name: 'Wireless Headphones',
      category: 'electronics',
      price: 99.99,
      rating: 4.5,
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      description: 'High-quality wireless headphones with noise cancellation'
    },
    {
      id: 2,
      name: 'Smart Watch',
      category: 'electronics',
      price: 299.99,
      rating: 4.8,
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      description: 'Advanced smartwatch with health monitoring features'
    },
    {
      id: 3,
      name: 'Laptop Stand',
      category: 'accessories',
      price: 49.99,
      rating: 4.2,
      image: 'https://via.placeholder.com/150x150',
      inStock: false,
      description: 'Adjustable laptop stand for better ergonomics'
    },
    {
      id: 4,
      name: 'Bluetooth Speaker',
      category: 'electronics',
      price: 79.99,
      rating: 4.6,
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      description: 'Portable Bluetooth speaker with excellent sound quality'
    },
    {
      id: 5,
      name: 'Phone Case',
      category: 'accessories',
      price: 19.99,
      rating: 4.3,
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      description: 'Protective phone case with wireless charging support'
    },
    {
      id: 6,
      name: 'USB Cable',
      category: 'accessories',
      price: 9.99,
      rating: 4.1,
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      description: 'High-speed USB-C cable for fast charging and data transfer'
    }
  ];

  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'accessories', name: 'Accessories' }
  ];

  const sortOptions = [
    { id: 'name', name: 'Name' },
    { id: 'price', name: 'Price' },
    { id: 'rating', name: 'Rating' },
    { id: 'newest', name: 'Newest' }
  ];

  // Simulate API call
  const fetchData = async (page = 1, reset = false) => {
    setLoading(true);
    
    // SILENT LOADING STATE - No screen reader announcement
    // Just shows spinner without announcing loading state to assistive technology
    
    try {
      // Simulate network delay
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      const startIndex = (page - 1) * 3;
      const endIndex = startIndex + 3;
      const newData = mockData.slice(startIndex, endIndex);
      
      if (reset) {
        setData(newData);
        setCurrentPage(1);
      } else {
        setData(prev => [...prev, ...newData]);
        setCurrentPage(page);
      }
      
      setHasMore(endIndex < mockData.length);
    } catch (error) {
      Alert.alert('Error', 'Failed to load data. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleRefresh = async () => {
    setRefreshing(true);
    await fetchData(1, true);
    setRefreshing(false);
  };

  const handleLoadMore = () => {
    if (!loading && hasMore) {
      fetchData(currentPage + 1);
    }
  };

  const handleSearch = async () => {
    setLoading(true);
    // Simulate search delay
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    const filtered = mockData.filter(item => 
      item.name.toLowerCase().includes(searchQuery.toLowerCase()) &&
      (filter === 'all' || item.category === filter)
    );
    
    setData(filtered);
    setLoading(false);
  };

  const handleFilterChange = async (newFilter) => {
    setFilter(newFilter);
    setLoading(true);
    
    // Simulate filter delay
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    const filtered = mockData.filter(item => 
      newFilter === 'all' || item.category === newFilter
    );
    
    setData(filtered);
    setLoading(false);
  };

  const handleSortChange = async (newSort) => {
    setSortBy(newSort);
    setLoading(true);
    
    // Simulate sort delay
    await new Promise(resolve => setTimeout(resolve, 800));
    
    const sorted = [...data].sort((a, b) => {
      switch (newSort) {
        case 'name':
          return a.name.localeCompare(b.name);
        case 'price':
          return a.price - b.price;
        case 'rating':
          return b.rating - a.rating;
        case 'newest':
          return b.id - a.id;
        default:
          return 0;
      }
    });
    
    setData(sorted);
    setLoading(false);
  };

  useEffect(() => {
    fetchData(1, true);
  }, []);

  const renderProductCard = (product) => (
    <View key={product.id} style={styles.productCard}>
      <Image
        source={{ uri: product.image }}
        style={styles.productImage}
        accessibilityLabel={`Product image of ${product.name}`}
      />
      
      <View style={styles.productInfo}>
        <Text style={styles.productName}>{product.name}</Text>
        <Text style={styles.productDescription}>{product.description}</Text>
        
        <View style={styles.productMeta}>
          <Text style={styles.productPrice}>${product.price}</Text>
          <View style={styles.ratingContainer}>
            <Text style={styles.rating}>★ {product.rating}</Text>
          </View>
        </View>
        
        <View style={styles.productActions}>
          <TouchableOpacity 
            style={[styles.actionButton, !product.inStock && styles.disabledButton]}
            disabled={!product.inStock}
          >
            <Text style={[styles.actionButtonText, !product.inStock && styles.disabledButtonText]}>
              {product.inStock ? 'Add to Cart' : 'Out of Stock'}
            </Text>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.wishlistButton}>
            <Text style={styles.wishlistText}>♡</Text>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Product Catalog</Text>
        <Text style={styles.headerSubtitle}>Discover amazing products</Text>
      </View>

      {/* Search and Filters */}
      <View style={styles.searchContainer}>
        <View style={styles.searchBar}>
          <Text style={styles.searchIcon}>🔍</Text>
          <Text style={styles.searchInput}>Search products...</Text>
        </View>
        
        <View style={styles.filterContainer}>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {categories.map((category) => (
              <TouchableOpacity
                key={category.id}
                style={[
                  styles.filterButton,
                  filter === category.id && styles.activeFilterButton
                ]}
                onPress={() => handleFilterChange(category.id)}
              >
                <Text style={[
                  styles.filterButtonText,
                  filter === category.id && styles.activeFilterButtonText
                ]}>
                  {category.name}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
        
        <View style={styles.sortContainer}>
          <Text style={styles.sortLabel}>Sort by:</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {sortOptions.map((option) => (
              <TouchableOpacity
                key={option.id}
                style={[
                  styles.sortButton,
                  sortBy === option.id && styles.activeSortButton
                ]}
                onPress={() => handleSortChange(option.id)}
              >
                <Text style={[
                  styles.sortButtonText,
                  sortBy === option.id && styles.activeSortButtonText
                ]}>
                  {option.name}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      </View>

      {/* Loading State - SILENT (No screen reader announcement) */}
      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#2196F3" />
          <Text style={styles.loadingText}>Loading products...</Text>
          {}
        </View>
      )}

      {/* Products Grid */}
      {!loading && (
        <View style={styles.productsContainer}>
          <Text style={styles.resultsText}>
            {data.length} products found
          </Text>
          
          <View style={styles.productsGrid}>
            {data.map(renderProductCard)}
          </View>
        </View>
      )}

      {/* Load More Button */}
      {!loading && hasMore && (
        <View style={styles.loadMoreContainer}>
          <TouchableOpacity
            style={styles.loadMoreButton}
            onPress={handleLoadMore}
          >
            <Text style={styles.loadMoreText}>Load More Products</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* Empty State */}
      {!loading && data.length === 0 && (
        <View style={styles.emptyContainer}>
          <Text style={styles.emptyIcon}>📦</Text>
          <Text style={styles.emptyTitle}>No Products Found</Text>
          <Text style={styles.emptyDescription}>
            Try adjusting your search or filter criteria
          </Text>
          <TouchableOpacity
            style={styles.refreshButton}
            onPress={handleRefresh}
          >
            <Text style={styles.refreshButtonText}>Refresh</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* Footer */}
      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Showing {data.length} of {mockData.length} products
        </Text>
        <TouchableOpacity
          style={styles.refreshButton}
          onPress={handleRefresh}
        >
          <Text style={styles.refreshButtonText}>Refresh All</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    backgroundColor: '#2196F3',
    padding: 24,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#E3F2FD',
  },
  searchContainer: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F5F5F5',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    marginBottom: 16,
  },
  searchIcon: {
    fontSize: 16,
    marginRight: 8,
    color: '#7F8C8D',
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    color: '#7F8C8D',
  },
  filterContainer: {
    marginBottom: 16,
  },
  filterButton: {
    paddingVertical: 8,
    paddingHorizontal: 16,
    marginRight: 8,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
  },
  activeFilterButton: {
    backgroundColor: '#2196F3',
  },
  filterButtonText: {
    fontSize: 14,
    color: '#7F8C8D',
    fontWeight: '500',
  },
  activeFilterButtonText: {
    color: '#FFFFFF',
  },
  sortContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  sortLabel: {
    fontSize: 14,
    color: '#2C3E50',
    marginRight: 12,
    fontWeight: '500',
  },
  sortButton: {
    paddingVertical: 6,
    paddingHorizontal: 12,
    marginRight: 8,
    borderRadius: 16,
    backgroundColor: '#F5F5F5',
  },
  activeSortButton: {
    backgroundColor: '#4CAF50',
  },
  sortButtonText: {
    fontSize: 12,
    color: '#7F8C8D',
    fontWeight: '500',
  },
  activeSortButtonText: {
    color: '#FFFFFF',
  },
  loadingContainer: {
    padding: 48,
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#7F8C8D',
  },
  productsContainer: {
    padding: 16,
  },
  resultsText: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 16,
  },
  productsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  productCard: {
    width: '48%',
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 12,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  productImage: {
    width: '100%',
    height: 120,
    borderRadius: 8,
    marginBottom: 12,
  },
  productInfo: {
    flex: 1,
  },
  productName: {
    fontSize: 14,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 4,
  },
  productDescription: {
    fontSize: 12,
    color: '#7F8C8D',
    marginBottom: 8,
    lineHeight: 16,
  },
  productMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  productPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#4CAF50',
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  rating: {
    fontSize: 12,
    color: '#FFC107',
  },
  productActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  actionButton: {
    flex: 1,
    backgroundColor: '#4CAF50',
    paddingVertical: 8,
    borderRadius: 6,
    alignItems: 'center',
    marginRight: 8,
  },
  actionButtonText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '500',
  },
  disabledButton: {
    backgroundColor: '#BDBDBD',
  },
  disabledButtonText: {
    color: '#757575',
  },
  wishlistButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
  },
  wishlistText: {
    fontSize: 16,
    color: '#7F8C8D',
  },
  loadMoreContainer: {
    padding: 16,
    alignItems: 'center',
  },
  loadMoreButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  loadMoreText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  emptyContainer: {
    padding: 48,
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  emptyIcon: {
    fontSize: 48,
    marginBottom: 16,
  },
  emptyTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginBottom: 8,
  },
  emptyDescription: {
    fontSize: 14,
    color: '#7F8C8D',
    textAlign: 'center',
    marginBottom: 24,
  },
  refreshButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 6,
  },
  refreshButtonText: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: '500',
  },
  footer: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  footerText: {
    fontSize: 14,
    color: '#7F8C8D',
  },
});

export default SilentLoadingState;

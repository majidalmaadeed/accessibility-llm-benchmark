import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  TextInput,
  Alert,
} from 'react-native';

const InsufficientButtonSpacing = () => {
  const [selectedItems, setSelectedItems] = useState(new Set());
  const [searchQuery, setSearchQuery] = useState('');
  const [filter, setFilter] = useState('all');

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 99.99,
      category: 'electronics',
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      rating: 4.5
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: 299.99,
      category: 'electronics',
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      rating: 4.8
    },
    {
      id: 3,
      name: 'Laptop Stand',
      price: 49.99,
      category: 'accessories',
      image: 'https://via.placeholder.com/150x150',
      inStock: false,
      rating: 4.2
    },
    {
      id: 4,
      name: 'Bluetooth Speaker',
      price: 79.99,
      category: 'electronics',
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      rating: 4.6
    },
    {
      id: 5,
      name: 'Phone Case',
      price: 19.99,
      category: 'accessories',
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      rating: 4.3
    },
    {
      id: 6,
      name: 'USB Cable',
      price: 9.99,
      category: 'accessories',
      image: 'https://via.placeholder.com/150x150',
      inStock: true,
      rating: 4.1
    }
  ];

  const categories = [
    { id: 'all', name: 'All' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'accessories', name: 'Accessories' }
  ];

  const filteredProducts = products.filter(product => {
    const matchesCategory = filter === 'all' || product.category === filter;
    const matchesSearch = product.name.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const handleItemSelect = (itemId) => {
    const newSelected = new Set(selectedItems);
    if (newSelected.has(itemId)) {
      newSelected.delete(itemId);
    } else {
      newSelected.add(itemId);
    }
    setSelectedItems(newSelected);
  };

  const handleBulkAction = (action) => {
    if (selectedItems.size === 0) {
      Alert.alert('No Selection', 'Please select items first');
      return;
    }
    
    Alert.alert('Bulk Action', `${action} ${selectedItems.size} item(s)`);
  };

  const handleAddToCart = (product) => {
    Alert.alert('Added to Cart', `${product.name} added to cart`);
  };

  const handleWishlist = (product) => {
    Alert.alert('Added to Wishlist', `${product.name} added to wishlist`);
  };

  const handleShare = (product) => {
    Alert.alert('Share', `Sharing ${product.name}`);
  };

  const handleQuickView = (product) => {
    Alert.alert('Quick View', `Viewing details for ${product.name}`);
  };

  const formatPrice = (price) => {
    return `$${price.toFixed(2)}`;
  };

  const renderStars = (rating) => {
    const stars = [];
    for (let i = 1; i <= 5; i++) {
      stars.push(
        <Text key={i} style={styles.star}>
          {i <= rating ? '★' : '☆'}
        </Text>
      );
    }
    return stars;
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Product Manager</Text>
        <Text style={styles.headerSubtitle}>Manage your product inventory</Text>
      </View>

      {/* Search and Filter */}
      <View style={styles.searchContainer}>
        <TextInput
          style={styles.searchInput}
          placeholder="Search products..."
          value={searchQuery}
          onChangeText={setSearchQuery}
        />
        <View style={styles.filterButtons}>
          {categories.map((category) => (
            <TouchableOpacity
              key={category.id}
              style={[
                styles.filterButton,
                filter === category.id && styles.activeFilterButton
              ]}
              onPress={() => setFilter(category.id)}
            >
              <Text style={[
                styles.filterButtonText,
                filter === category.id && styles.activeFilterButtonText
              ]}>
                {category.name}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Bulk Actions - INSUFFICIENT BUTTON SPACING (2px apart instead of 44px minimum) */}
      {selectedItems.size > 0 && (
        <View style={styles.bulkActionsContainer}>
          <Text style={styles.bulkActionsText}>
            {selectedItems.size} item(s) selected
          </Text>
          <View style={styles.bulkActions}>
            <TouchableOpacity 
              style={styles.bulkActionButton}
              onPress={() => handleBulkAction('Delete')}
            >
              <Text style={styles.bulkActionText}>Delete</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={styles.bulkActionButton}
              onPress={() => handleBulkAction('Export')}
            >
              <Text style={styles.bulkActionText}>Export</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={styles.bulkActionButton}
              onPress={() => handleBulkAction('Archive')}
            >
              <Text style={styles.bulkActionText}>Archive</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={styles.bulkActionButton}
              onPress={() => handleBulkAction('Duplicate')}
            >
              <Text style={styles.bulkActionText}>Duplicate</Text>
            </TouchableOpacity>
          </View>
        </View>
      )}

      {/* Products Grid */}
      <View style={styles.productsContainer}>
        <Text style={styles.sectionTitle}>Products ({filteredProducts.length})</Text>
        
        <View style={styles.productsGrid}>
          {filteredProducts.map((product) => (
            <View key={product.id} style={styles.productCard}>
              {/* Selection Checkbox */}
              <TouchableOpacity
                style={styles.selectionCheckbox}
                onPress={() => handleItemSelect(product.id)}
              >
                <View style={[
                  styles.checkbox,
                  selectedItems.has(product.id) && styles.checkedBox
                ]}>
                  {selectedItems.has(product.id) && (
                    <Text style={styles.checkmark}>✓</Text>
                  )}
                </View>
              </TouchableOpacity>

              {/* Product Image */}
              <View style={styles.productImageContainer}>
                <Image
                  source={{ uri: product.image }}
                  style={styles.productImage}
                  accessibilityLabel={`Product image of ${product.name}`}
                />
                {!product.inStock && (
                  <View style={styles.outOfStockOverlay}>
                    <Text style={styles.outOfStockText}>Out of Stock</Text>
                  </View>
                )}
              </View>

              {/* Product Info */}
              <View style={styles.productInfo}>
                <Text style={styles.productName} numberOfLines={2}>
                  {product.name}
                </Text>
                
                <View style={styles.ratingContainer}>
                  <View style={styles.stars}>
                    {renderStars(Math.floor(product.rating))}
                  </View>
                  <Text style={styles.ratingText}>{product.rating}</Text>
                </View>

                <Text style={styles.productPrice}>{formatPrice(product.price)}</Text>
                <Text style={styles.productCategory}>{product.category}</Text>
              </View>

              {/* Action Buttons - INSUFFICIENT SPACING (2px apart) */}
              <View style={styles.actionButtonsContainer}>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => handleAddToCart(product)}
                >
                  <Text style={styles.actionButtonText}>Add to Cart</Text>
                </TouchableOpacity>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => handleWishlist(product)}
                >
                  <Text style={styles.actionButtonText}>Wishlist</Text>
                </TouchableOpacity>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => handleShare(product)}
                >
                  <Text style={styles.actionButtonText}>Share</Text>
                </TouchableOpacity>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => handleQuickView(product)}
                >
                  <Text style={styles.actionButtonText}>Quick View</Text>
                </TouchableOpacity>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => Alert.alert('Edit', `Edit ${product.name}`)}
                >
                  <Text style={styles.actionButtonText}>Edit</Text>
                </TouchableOpacity>
                <TouchableOpacity 
                  style={styles.actionButton}
                  onPress={() => Alert.alert('Delete', `Delete ${product.name}`)}
                >
                  <Text style={styles.actionButtonText}>Delete</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))}
        </View>
      </View>

      {/* Footer Actions - INSUFFICIENT SPACING */}
      <View style={styles.footerActions}>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Save Changes</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Cancel</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Reset</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Export All</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Import</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.footerButton}>
          <Text style={styles.footerButtonText}>Settings</Text>
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
    backgroundColor: '#2C3E50',
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
    color: '#BDC3C7',
  },
  searchContainer: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  searchInput: {
    height: 44,
    borderWidth: 1,
    borderColor: '#BDBDBD',
    borderRadius: 8,
    paddingHorizontal: 16,
    fontSize: 16,
    marginBottom: 16,
  },
  filterButtons: {
    flexDirection: 'row',
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
  bulkActionsContainer: {
    backgroundColor: '#E8F4FD',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#BBDEFB',
  },
  bulkActionsText: {
    fontSize: 14,
    color: '#1976D2',
    marginBottom: 12,
    fontWeight: '500',
  },
  bulkActions: {
    flexDirection: 'row',
    // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
    gap: 2,
  },
  bulkActionButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 8,
    paddingHorizontal: 12,
    borderRadius: 6,
    flex: 1,
    alignItems: 'center',
  },
  bulkActionText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '500',
  },
  productsContainer: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2C3E50',
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
    position: 'relative',
  },
  selectionCheckbox: {
    position: 'absolute',
    top: 8,
    right: 8,
    zIndex: 1,
  },
  checkbox: {
    width: 20,
    height: 20,
    borderWidth: 2,
    borderColor: '#BDBDBD',
    borderRadius: 4,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  checkedBox: {
    backgroundColor: '#2196F3',
    borderColor: '#2196F3',
  },
  checkmark: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  productImageContainer: {
    height: 120,
    backgroundColor: '#F5F5F5',
    borderRadius: 8,
    marginBottom: 12,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  productImage: {
    width: 100,
    height: 100,
    borderRadius: 8,
  },
  outOfStockOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 8,
  },
  outOfStockText: {
    color: '#FFFFFF',
    fontWeight: 'bold',
    fontSize: 12,
  },
  productInfo: {
    marginBottom: 12,
  },
  productName: {
    fontSize: 14,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 4,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  stars: {
    flexDirection: 'row',
    marginRight: 4,
  },
  star: {
    fontSize: 12,
    color: '#FFC107',
  },
  ratingText: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  productPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#4CAF50',
    marginBottom: 2,
  },
  productCategory: {
    fontSize: 12,
    color: '#7F8C8D',
    textTransform: 'capitalize',
  },
  actionButtonsContainer: {
    // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
    gap: 2,
  },
  actionButton: {
    backgroundColor: '#F5F5F5',
    paddingVertical: 6,
    paddingHorizontal: 8,
    borderRadius: 4,
    marginBottom: 2,
    alignItems: 'center',
  },
  actionButtonText: {
    fontSize: 10,
    color: '#2196F3',
    fontWeight: '500',
  },
  footerActions: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    flexDirection: 'row',
    // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
    gap: 2,
  },
  footerButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 10,
    paddingHorizontal: 12,
    borderRadius: 6,
    flex: 1,
    alignItems: 'center',
  },
  footerButtonText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '500',
  },
});

export default InsufficientButtonSpacing;

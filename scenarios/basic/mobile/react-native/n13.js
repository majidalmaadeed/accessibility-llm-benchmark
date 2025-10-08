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

const MissingSkipLink = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [cartItems, setCartItems] = useState(0);

  const categories = [
    { id: 'all', name: 'All Products', icon: '🏠' },
    { id: 'electronics', name: 'Electronics', icon: '📱' },
    { id: 'clothing', name: 'Clothing', icon: '👕' },
    { id: 'home', name: 'Home & Garden', icon: '🏡' },
    { id: 'sports', name: 'Sports', icon: '⚽' },
    { id: 'books', name: 'Books', icon: '📚' },
    { id: 'beauty', name: 'Beauty', icon: '💄' },
    { id: 'toys', name: 'Toys', icon: '🧸' }
  ];

  const products = [
    {
      id: 1,
      name: 'Wireless Bluetooth Headphones',
      price: 99.99,
      originalPrice: 149.99,
      category: 'electronics',
      rating: 4.5,
      reviews: 128,
      image: 'https://via.placeholder.com/200x200',
      inStock: true
    },
    {
      id: 2,
      name: 'Organic Cotton T-Shirt',
      price: 24.99,
      originalPrice: 34.99,
      category: 'clothing',
      rating: 4.2,
      reviews: 89,
      image: 'https://via.placeholder.com/200x200',
      inStock: true
    },
    {
      id: 3,
      name: 'Smart Home Security Camera',
      price: 199.99,
      originalPrice: 249.99,
      category: 'home',
      rating: 4.7,
      reviews: 256,
      image: 'https://via.placeholder.com/200x200',
      inStock: false
    },
    {
      id: 4,
      name: 'Yoga Mat Premium',
      price: 49.99,
      originalPrice: 69.99,
      category: 'sports',
      rating: 4.6,
      reviews: 156,
      image: 'https://via.placeholder.com/200x200',
      inStock: true
    },
    {
      id: 5,
      name: 'Programming Fundamentals Book',
      price: 39.99,
      originalPrice: 49.99,
      category: 'books',
      rating: 4.4,
      reviews: 78,
      image: 'https://via.placeholder.com/200x200',
      inStock: true
    },
    {
      id: 6,
      name: 'Anti-Aging Face Cream',
      price: 79.99,
      originalPrice: 99.99,
      category: 'beauty',
      rating: 4.3,
      reviews: 203,
      image: 'https://via.placeholder.com/200x200',
      inStock: true
    }
  ];

  const filteredProducts = products.filter(product => {
    const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
    const matchesSearch = product.name.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const handleAddToCart = (product) => {
    setCartItems(prev => prev + 1);
    Alert.alert('Added to Cart', `${product.name} has been added to your cart`);
  };

  const handleSearch = () => {
    console.log('Searching for:', searchQuery);
  };

  const handleCategorySelect = (categoryId) => {
    setSelectedCategory(categoryId);
  };

  const formatPrice = (price) => {
    return `$${price.toFixed(2)}`;
  };

  const calculateSavings = (original, current) => {
    return original - current;
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
      {/* Header - NO SKIP LINK TO MAIN CONTENT */}
      <View style={styles.header}>
        <View style={styles.headerTop}>
          <Text style={styles.logo}>ShopMart</Text>
          <View style={styles.headerActions}>
            <TouchableOpacity style={styles.headerButton}>
              <Text style={styles.headerButtonText}>🔍</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.headerButton}>
              <Text style={styles.headerButtonText}>👤</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.cartButton}>
              <Text style={styles.cartIcon}>🛒</Text>
              {cartItems > 0 && (
                <View style={styles.cartBadge}>
                  <Text style={styles.cartBadgeText}>{cartItems}</Text>
                </View>
              )}
            </TouchableOpacity>
          </View>
        </View>
        
        <Text style={styles.headerSubtitle}>Your one-stop shopping destination</Text>
      </View>

      {/* Search Bar */}
      <View style={styles.searchContainer}>
        <View style={styles.searchBar}>
          <TextInput
            style={styles.searchInput}
            placeholder="Search products..."
            value={searchQuery}
            onChangeText={setSearchQuery}
            onSubmitEditing={handleSearch}
          />
          <TouchableOpacity style={styles.searchButton} onPress={handleSearch}>
            <Text style={styles.searchButtonText}>Search</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Category Navigation */}
      <View style={styles.categoriesContainer}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {categories.map((category) => (
            <TouchableOpacity
              key={category.id}
              style={[
                styles.categoryButton,
                selectedCategory === category.id && styles.activeCategoryButton
              ]}
              onPress={() => handleCategorySelect(category.id)}
            >
              <Text style={styles.categoryIcon}>{category.icon}</Text>
              <Text style={[
                styles.categoryText,
                selectedCategory === category.id && styles.activeCategoryText
              ]}>
                {category.name}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Main Content - NO SKIP LINK TO REACH HERE */}
      <View style={styles.mainContent}>
        <Text style={styles.sectionTitle}>
          {selectedCategory === 'all' ? 'All Products' : 
           categories.find(c => c.id === selectedCategory)?.name}
        </Text>
        <Text style={styles.resultsCount}>
          {filteredProducts.length} products found
        </Text>

        {/* Products Grid */}
        <View style={styles.productsGrid}>
          {filteredProducts.map((product) => (
            <View key={product.id} style={styles.productCard}>
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
                <View style={styles.discountBadge}>
                  <Text style={styles.discountText}>
                    {Math.round(((product.originalPrice - product.price) / product.originalPrice) * 100)}% OFF
                  </Text>
                </View>
              </View>

              <View style={styles.productInfo}>
                <Text style={styles.productName} numberOfLines={2}>
                  {product.name}
                </Text>
                
                <View style={styles.ratingContainer}>
                  <View style={styles.stars}>
                    {renderStars(Math.floor(product.rating))}
                  </View>
                  <Text style={styles.ratingText}>
                    {product.rating} ({product.reviews})
                  </Text>
                </View>

                <View style={styles.priceContainer}>
                  <Text style={styles.currentPrice}>{formatPrice(product.price)}</Text>
                  <Text style={styles.originalPrice}>{formatPrice(product.originalPrice)}</Text>
                  <Text style={styles.savingsText}>
                    Save {formatPrice(calculateSavings(product.originalPrice, product.price))}
                  </Text>
                </View>

                <TouchableOpacity 
                  style={[
                    styles.addToCartButton,
                    !product.inStock && styles.disabledButton
                  ]}
                  onPress={() => product.inStock && handleAddToCart(product)}
                  disabled={!product.inStock}
                >
                  <Text style={[
                    styles.addToCartText,
                    !product.inStock && styles.disabledButtonText
                  ]}>
                    {product.inStock ? 'Add to Cart' : 'Out of Stock'}
                  </Text>
                </TouchableOpacity>
              </View>
            </View>
          ))}
        </View>
      </View>

      {/* Footer */}
      <View style={styles.footer}>
        <View style={styles.footerSection}>
          <Text style={styles.footerTitle}>Customer Service</Text>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Help Center</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Contact Us</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Shipping Info</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Returns</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.footerSection}>
          <Text style={styles.footerTitle}>Company</Text>
          <TouchableOpacity>
            <Text style={styles.footerLink}>About Us</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Careers</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Press</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Investor Relations</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.footerSection}>
          <Text style={styles.footerTitle}>Legal</Text>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Privacy Policy</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Terms of Service</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Cookie Policy</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Accessibility</Text>
          </TouchableOpacity>
        </View>
      </View>

      <View style={styles.footerBottom}>
        <Text style={styles.footerBottomText}>
          © 2024 ShopMart. All rights reserved.
        </Text>
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
    padding: 16,
    paddingTop: 48,
  },
  headerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  logo: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
  },
  headerActions: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  headerButton: {
    padding: 8,
    marginLeft: 8,
  },
  headerButtonText: {
    fontSize: 20,
    color: '#FFFFFF',
  },
  cartButton: {
    position: 'relative',
    padding: 8,
    marginLeft: 8,
  },
  cartIcon: {
    fontSize: 20,
    color: '#FFFFFF',
  },
  cartBadge: {
    position: 'absolute',
    top: 0,
    right: 0,
    backgroundColor: '#FF5722',
    borderRadius: 10,
    minWidth: 20,
    height: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },
  cartBadgeText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  headerSubtitle: {
    fontSize: 14,
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
  },
  searchInput: {
    flex: 1,
    height: 44,
    borderWidth: 1,
    borderColor: '#BDBDBD',
    borderRadius: 8,
    paddingHorizontal: 16,
    fontSize: 16,
    marginRight: 12,
  },
  searchButton: {
    backgroundColor: '#2196F3',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
  },
  searchButtonText: {
    color: '#FFFFFF',
    fontWeight: '600',
  },
  categoriesContainer: {
    backgroundColor: '#FFFFFF',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  categoryButton: {
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    marginHorizontal: 4,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
  },
  activeCategoryButton: {
    backgroundColor: '#2196F3',
  },
  categoryIcon: {
    fontSize: 20,
    marginBottom: 4,
  },
  categoryText: {
    fontSize: 12,
    color: '#666666',
    fontWeight: '500',
  },
  activeCategoryText: {
    color: '#FFFFFF',
  },
  mainContent: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginBottom: 8,
  },
  resultsCount: {
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
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  productImageContainer: {
    position: 'relative',
    height: 150,
    backgroundColor: '#F5F5F5',
    borderTopLeftRadius: 12,
    borderTopRightRadius: 12,
  },
  productImage: {
    width: '100%',
    height: 150,
    borderTopLeftRadius: 12,
    borderTopRightRadius: 12,
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
    borderTopLeftRadius: 12,
    borderTopRightRadius: 12,
  },
  outOfStockText: {
    color: '#FFFFFF',
    fontWeight: 'bold',
    fontSize: 16,
  },
  discountBadge: {
    position: 'absolute',
    top: 8,
    right: 8,
    backgroundColor: '#FF5722',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4,
  },
  discountText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  productInfo: {
    padding: 12,
  },
  productName: {
    fontSize: 14,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 8,
    lineHeight: 18,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  stars: {
    flexDirection: 'row',
    marginRight: 6,
  },
  star: {
    fontSize: 12,
    color: '#FFC107',
  },
  ratingText: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  priceContainer: {
    marginBottom: 12,
  },
  currentPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#4CAF50',
  },
  originalPrice: {
    fontSize: 12,
    color: '#7F8C8D',
    textDecorationLine: 'line-through',
  },
  savingsText: {
    fontSize: 10,
    color: '#4CAF50',
  },
  addToCartButton: {
    backgroundColor: '#4CAF50',
    paddingVertical: 8,
    borderRadius: 6,
    alignItems: 'center',
  },
  addToCartText: {
    color: '#FFFFFF',
    fontWeight: '600',
    fontSize: 14,
  },
  disabledButton: {
    backgroundColor: '#BDBDBD',
  },
  disabledButtonText: {
    color: '#757575',
  },
  footer: {
    backgroundColor: '#2C3E50',
    padding: 24,
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  footerSection: {
    flex: 1,
  },
  footerTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 12,
  },
  footerLink: {
    fontSize: 14,
    color: '#BDC3C7',
    marginBottom: 8,
  },
  footerBottom: {
    backgroundColor: '#34495E',
    padding: 16,
    alignItems: 'center',
  },
  footerBottomText: {
    color: '#BDC3C7',
    fontSize: 14,
  },
});

export default MissingSkipLink;

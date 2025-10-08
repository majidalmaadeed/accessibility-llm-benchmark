import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Animated,
} from 'react-native';

const FlashingAdvertisement = () => {
  const [flashState, setFlashState] = useState(true);
  const [flashCount, setFlashCount] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setFlashState(prev => !prev);
      if (flashState) {
        setFlashCount(prev => prev + 1);
      }
    }, 200); // Flash every 200ms (5 times per second)

    return () => clearInterval(interval);
  }, [flashState]);

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: '$99.99',
      originalPrice: '$149.99',
      rating: 4.5,
      reviews: 128
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: '$299.99',
      originalPrice: '$399.99',
      rating: 4.8,
      reviews: 256
    },
    {
      id: 3,
      name: 'Bluetooth Speaker',
      price: '$79.99',
      originalPrice: '$99.99',
      rating: 4.3,
      reviews: 89
    }
  ];

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

  const calculateSavings = (originalPrice, currentPrice) => {
    const original = parseFloat(originalPrice.replace('$', ''));
    const current = parseFloat(currentPrice.replace('$', ''));
    const savings = original - current;
    return `$${savings.toFixed(2)}`;
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Electronics Store</Text>
        <Text style={styles.headerSubtitle}>Best deals on tech products</Text>
      </View>

      {/* Flashing Sale Banner - FLASHING 5 TIMES PER SECOND */}
      <View style={[
        styles.banner,
        { backgroundColor: flashState ? '#FF5722' : '#FF9800' } // FLASHING: Alternates between colors
      ]}>
        <Text style={styles.bannerIcon}>🔥</Text>
        <Text style={styles.bannerText}>FLASH SALE!</Text>
        <Text style={styles.bannerDiscount}>Up to 50% OFF!</Text>
        <Text style={styles.flashCount}>Flashes: {flashCount}</Text>
      </View>

      {/* Products List */}
      <View style={styles.productsContainer}>
        {products.map((product) => (
          <View key={product.id} style={styles.productCard}>
            {/* Product Image */}
            <View style={styles.productImageContainer}>
              <Image
                source={{ uri: 'https://via.placeholder.com/200x150' }}
                style={styles.productImage}
                accessibilityLabel={`Product image of ${product.name}`}
              />
            </View>

            <View style={styles.productInfo}>
              <Text style={styles.productName}>{product.name}</Text>
              
              {/* Rating */}
              <View style={styles.ratingContainer}>
                <View style={styles.stars}>
                  {renderStars(Math.floor(product.rating))}
                </View>
                <Text style={styles.ratingText}>
                  {product.rating} ({product.reviews})
                </Text>
              </View>

              {/* Price */}
              <View style={styles.priceContainer}>
                <Text style={styles.currentPrice}>{product.price}</Text>
                <Text style={styles.originalPrice}>{product.originalPrice}</Text>
                <View style={styles.savingsBadge}>
                  <Text style={styles.savingsText}>
                    Save {calculateSavings(product.originalPrice, product.price)}
                  </Text>
                </View>
              </View>

              {/* Action Buttons */}
              <View style={styles.buttonContainer}>
                <TouchableOpacity style={styles.addToCartButton}>
                  <Text style={styles.addToCartIcon}>🛒</Text>
                  <Text style={styles.addToCartText}>Add to Cart</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.wishlistButton}>
                  <Text style={styles.wishlistIcon}>♡</Text>
                  <Text style={styles.wishlistText}>Wishlist</Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        ))}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    backgroundColor: '#2196F3',
    padding: 32,
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
    color: '#FFFFFF',
    opacity: 0.9,
  },
  banner: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    margin: 16,
    borderRadius: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  bannerIcon: {
    fontSize: 20,
    marginRight: 12,
  },
  bannerText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginRight: 12,
  },
  bannerDiscount: {
    fontSize: 16,
    color: '#FFFFFF',
    flex: 1,
  },
  flashCount: {
    fontSize: 12,
    color: '#FFFFFF',
    opacity: 0.7,
  },
  productsContainer: {
    padding: 16,
  },
  productCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  productImageContainer: {
    height: 150,
    backgroundColor: '#E0E0E0',
    borderRadius: 8,
    marginBottom: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  productImage: {
    width: 200,
    height: 150,
    borderRadius: 8,
  },
  productInfo: {
    flex: 1,
  },
  productName: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  stars: {
    flexDirection: 'row',
    marginRight: 8,
  },
  star: {
    fontSize: 16,
    color: '#FFC107',
  },
  ratingText: {
    fontSize: 14,
    color: '#666666',
  },
  priceContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  currentPrice: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#4CAF50',
    marginRight: 8,
  },
  originalPrice: {
    fontSize: 16,
    color: '#666666',
    textDecorationLine: 'line-through',
    marginRight: 8,
  },
  savingsBadge: {
    backgroundColor: '#4CAF50',
    opacity: 0.1,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 4,
  },
  savingsText: {
    fontSize: 12,
    color: '#4CAF50',
  },
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  addToCartButton: {
    flex: 1,
    backgroundColor: '#4CAF50',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    borderRadius: 8,
    marginRight: 8,
  },
  addToCartIcon: {
    fontSize: 16,
    marginRight: 4,
  },
  addToCartText: {
    color: '#FFFFFF',
    fontWeight: '600',
  },
  wishlistButton: {
    flex: 1,
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: '#2196F3',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    borderRadius: 8,
  },
  wishlistIcon: {
    fontSize: 16,
    marginRight: 4,
  },
  wishlistText: {
    color: '#2196F3',
    fontWeight: '600',
  },
});

export default FlashingAdvertisement;

import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
} from 'react-native';

const DecorativeImageWithAltText = () => {
  const products = [
    {
      id: 1,
      name: 'Premium Headphones',
      price: '$199.99',
      description: 'High-quality wireless headphones with noise cancellation',
      rating: 4.8,
      reviews: 324
    },
    {
      id: 2,
      name: 'Smart Watch',
      price: '$299.99',
      description: 'Advanced fitness tracking and health monitoring',
      rating: 4.6,
      reviews: 156
    },
    {
      id: 3,
      name: 'Bluetooth Speaker',
      price: '$89.99',
      description: 'Portable speaker with excellent sound quality',
      rating: 4.4,
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

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Product Catalog</Text>
        <Text style={styles.headerSubtitle}>Discover our latest products</Text>
      </View>

      {/* Products List */}
      <View style={styles.productsContainer}>
        {products.map((product) => (
          <View key={product.id} style={styles.productCard}>
            {/* Product Image with Decorative Border */}
            <View style={styles.imageContainer}>
              {/* Main product image placeholder */}
              <Image
                source={{ uri: 'https://via.placeholder.com/200x150' }}
                style={styles.productImage}
                accessibilityLabel={`Product image of ${product.name}`}
              />
              
              {/* Decorative border images - UNNECESSARY DESCRIPTIVE ALT TEXT */}
              <View style={styles.decorativeContainer}>
                {/* Decorative corner ornaments - UNNECESSARY DESCRIPTIVE ALT TEXT */}
                <Image
                  source={{ uri: 'https://via.placeholder.com/16x16/FFC107/FFFFFF?text=★' }}
                  style={styles.decorativeStar}
                  accessibilityLabel="Decorative star ornament in the top left corner of the product image border" // UNNECESSARY: Too descriptive for decorative element
                />
                <Image
                  source={{ uri: 'https://via.placeholder.com/16x16/FFC107/FFFFFF?text=★' }}
                  style={[styles.decorativeStar, styles.topRight]}
                  accessibilityLabel="Decorative star ornament in the top right corner of the product image border" // UNNECESSARY: Too descriptive for decorative element
                />
                <Image
                  source={{ uri: 'https://via.placeholder.com/16x16/FFC107/FFFFFF?text=★' }}
                  style={[styles.decorativeStar, styles.bottomLeft]}
                  accessibilityLabel="Decorative star ornament in the bottom left corner of the product image border" // UNNECESSARY: Too descriptive for decorative element
                />
                <Image
                  source={{ uri: 'https://via.placeholder.com/16x16/FFC107/FFFFFF?text=★' }}
                  style={[styles.decorativeStar, styles.bottomRight]}
                  accessibilityLabel="Decorative star ornament in the bottom right corner of the product image border" // UNNECESSARY: Too descriptive for decorative element
                />
              </View>
            </View>

            <View style={styles.productInfo}>
              <Text style={styles.productName}>{product.name}</Text>
              
              <Text style={styles.productDescription}>{product.description}</Text>
              
              {/* Rating */}
              <View style={styles.ratingContainer}>
                <View style={styles.stars}>
                  {renderStars(Math.floor(product.rating))}
                </View>
                <Text style={styles.ratingText}>
                  {product.rating} ({product.reviews} reviews)
                </Text>
              </View>

              {/* Price and Action */}
              <View style={styles.priceActionContainer}>
                <Text style={styles.productPrice}>{product.price}</Text>
                <TouchableOpacity style={styles.addToCartButton}>
                  <Text style={styles.addToCartIcon}>🛒</Text>
                  <Text style={styles.addToCartText}>Add to Cart</Text>
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
    backgroundColor: '#4CAF50',
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
  productsContainer: {
    padding: 16,
  },
  productCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  imageContainer: {
    height: 200,
    backgroundColor: '#E0E0E0',
    borderRadius: 8,
    marginBottom: 12,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  productImage: {
    width: 200,
    height: 150,
    borderRadius: 8,
  },
  decorativeContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
  },
  decorativeStar: {
    width: 16,
    height: 16,
    position: 'absolute',
    opacity: 0.3,
  },
  topRight: {
    top: 8,
    right: 8,
  },
  bottomLeft: {
    bottom: 8,
    left: 8,
  },
  bottomRight: {
    bottom: 8,
    right: 8,
  },
  productInfo: {
    flex: 1,
  },
  productName: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  productDescription: {
    fontSize: 14,
    color: '#666666',
    lineHeight: 20,
    marginBottom: 8,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
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
  priceActionContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  productPrice: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#4CAF50',
  },
  addToCartButton: {
    backgroundColor: '#4CAF50',
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 8,
  },
  addToCartIcon: {
    fontSize: 16,
    marginRight: 4,
  },
  addToCartText: {
    color: '#FFFFFF',
    fontWeight: '600',
  },
});

export default DecorativeImageWithAltText;

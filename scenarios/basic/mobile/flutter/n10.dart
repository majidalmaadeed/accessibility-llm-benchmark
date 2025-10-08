import 'package:flutter/material.dart';

class MissingImageAltText extends StatefulWidget {
  const MissingImageAltText({Key? key}) : super(key: key);

  @override
  State<MissingImageAltText> createState() => _MissingImageAltTextState();
}

class _MissingImageAltTextState extends State<MissingImageAltText> {
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Wireless Bluetooth Headphones',
      'price': 99.99,
      'originalPrice': 149.99,
      'rating': 4.5,
      'reviews': 128,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Electronics',
      'inStock': true,
      'description': 'High-quality wireless headphones with noise cancellation and premium sound quality.'
    },
    {
      'id': 2,
      'name': 'Smart Fitness Watch',
      'price': 299.99,
      'originalPrice': 399.99,
      'rating': 4.8,
      'reviews': 256,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Wearables',
      'inStock': true,
      'description': 'Advanced fitness tracking with heart rate monitoring and GPS capabilities.'
    },
    {
      'id': 3,
      'name': 'Portable Bluetooth Speaker',
      'price': 79.99,
      'originalPrice': 99.99,
      'rating': 4.3,
      'reviews': 89,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Audio',
      'inStock': false,
      'description': 'Compact speaker with 360-degree sound and waterproof design.'
    },
    {
      'id': 4,
      'name': 'Wireless Charging Pad',
      'price': 49.99,
      'originalPrice': 69.99,
      'rating': 4.2,
      'reviews': 156,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Accessories',
      'inStock': true,
      'description': 'Fast wireless charging pad compatible with all Qi-enabled devices.'
    },
    {
      'id': 5,
      'name': 'USB-C Cable Set',
      'price': 19.99,
      'originalPrice': 29.99,
      'rating': 4.1,
      'reviews': 203,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Cables',
      'inStock': true,
      'description': 'High-speed USB-C cables for fast charging and data transfer.'
    },
    {
      'id': 6,
      'name': 'Phone Case with Stand',
      'price': 24.99,
      'originalPrice': 34.99,
      'rating': 4.4,
      'reviews': 78,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Cases',
      'inStock': true,
      'description': 'Protective phone case with built-in kickstand and wireless charging support.'
    }
  ];

  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Electronics', 'Wearables', 'Audio', 'Accessories', 'Cables', 'Cases'];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedCategory == 'All' 
        ? products 
        : products.where((p) => p['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('TechStore'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Cart functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue[100],
                    checkmarkColor: Colors.blue[700],
                  ),
                );
              },
            ),
          ),
          
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final discount = ((product['originalPrice'] - product['price']) / product['originalPrice'] * 100).round();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Container
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.grey[200],
              ),
              child: Stack(
                children: [
                  // Product Image - MISSING IMAGE ALT TEXT
                  Center(
                    child: Image.network(
                      product['image'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,No semantic label or alt text for screen readers
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  
                  // Discount Badge
                  if (discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$discount% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  
                  // Out of Stock Overlay
                  if (!product['inStock'])
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  
                  // Wishlist Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Wishlist functionality
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Product Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < product['rating'].floor() ? Icons.star : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '${product['rating']} (${product['reviews']})',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (product['originalPrice'] > product['price']) ...[
                        const SizedBox(width: 8),
                        Text(
                          '\$${product['originalPrice']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product['inStock'] ? () {
                        // Add to cart functionality
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: product['inStock'] ? Colors.blue[700] : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        product['inStock'] ? 'Add to Cart' : 'Out of Stock',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

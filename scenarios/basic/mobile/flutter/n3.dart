import 'package:flutter/material.dart';

class DecorativeImageWithAltText extends StatefulWidget {
  const DecorativeImageWithAltText({Key? key}) : super(key: key);

  @override
  State<DecorativeImageWithAltText> createState() => _DecorativeImageWithAltTextState();
}

class _DecorativeImageWithAltTextState extends State<DecorativeImageWithAltText> {
  int selectedCategory = 0;
  final List<String> categories = ['All', 'Electronics', 'Clothing', 'Home', 'Sports'];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'price': 99.99,
      'originalPrice': 149.99,
      'rating': 4.5,
      'reviews': 128,
      'category': 'Electronics',
      'image': 'https://via.placeholder.com/200x200',
      'description': 'High-quality wireless headphones with noise cancellation.',
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'price': 299.99,
      'originalPrice': 399.99,
      'rating': 4.8,
      'reviews': 256,
      'category': 'Electronics',
      'image': 'https://via.placeholder.com/200x200',
      'description': 'Advanced smartwatch with health monitoring features.',
    },
    {
      'id': 3,
      'name': 'Running Shoes',
      'price': 129.99,
      'originalPrice': 179.99,
      'rating': 4.3,
      'reviews': 89,
      'category': 'Sports',
      'image': 'https://via.placeholder.com/200x200',
      'description': 'Comfortable running shoes for all terrains.',
    },
    {
      'id': 4,
      'name': 'Coffee Maker',
      'price': 79.99,
      'originalPrice': 99.99,
      'rating': 4.6,
      'reviews': 156,
      'category': 'Home',
      'image': 'https://via.placeholder.com/200x200',
      'description': 'Automatic coffee maker with programmable features.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Product Catalog'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Hero Section with Decorative Images
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[700]!, Colors.blue[500]!],
              ),
            ),
            child: Stack(
              children: [
                // Decorative Background Pattern - DECORATIVE IMAGE WITH ALT TEXT
                Positioned(
                  top: 20,
                  right: 20,
                  child: Image.network(
                    'https://via.placeholder.com/100x100',
                    width: 100,
                    height: 100,
                    // DECORATIVE IMAGE WITH ALT TEXT - Unnecessary descriptive alt text for decorative image
                    semanticLabel: 'Decorative geometric pattern with blue and white triangles creating a modern abstract background design for visual appeal',
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Another Decorative Element
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Image.network(
                    'https://via.placeholder.com/80x80',
                    width: 80,
                    height: 80,
                    // DECORATIVE IMAGE WITH ALT TEXT - Unnecessary descriptive alt text for decorative image
                    semanticLabel: 'Decorative circular pattern with gradient colors and geometric shapes used as a visual design element',
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Main Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Discover Amazing Products',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Find the perfect items for your needs',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(categories[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = index;
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
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index]);
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
                  // Product Image
                  Center(
                    child: Image.network(
                      product['image'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      semanticLabel: 'Product image of ${product['name']}',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  
                  // Decorative Border Pattern - DECORATIVE IMAGE WITH ALT TEXT
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.network(
                      'https://via.placeholder.com/200x200',
                      width: double.infinity,
                      height: double.infinity,
                      // DECORATIVE IMAGE WITH ALT TEXT - Unnecessary descriptive alt text for decorative border
                      semanticLabel: 'Decorative border pattern with intricate geometric designs and subtle gradient effects used purely for visual enhancement and aesthetic appeal',
                      fit: BoxFit.cover,
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
                  
                  // Decorative Corner Element - DECORATIVE IMAGE WITH ALT TEXT
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Image.network(
                      'https://via.placeholder.com/20x20',
                      width: 20,
                      height: 20,
                      // DECORATIVE IMAGE WITH ALT TEXT - Unnecessary descriptive alt text for decorative corner element
                      semanticLabel: 'Small decorative corner element with star-shaped design and golden color used as a visual accent',
                      fit: BoxFit.cover,
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
                      onPressed: () {
                        // Add to cart functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 12),
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

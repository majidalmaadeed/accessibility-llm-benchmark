import 'package:flutter/material.dart';

class FlashingAdvertisement extends StatefulWidget {
  const FlashingAdvertisement({Key? key}) : super(key: key);

  @override
  State<FlashingAdvertisement> createState() => _FlashingAdvertisementState();
}

class _FlashingAdvertisementState extends State<FlashingAdvertisement>
    with TickerProviderStateMixin {
  late AnimationController _flashController;
  late Animation<double> _flashAnimation;
  int flashCount = 0;
  bool isFlashing = true;

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'price': 99.99,
      'originalPrice': 149.99,
      'rating': 4.5,
      'reviews': 128,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Electronics',
      'inStock': true,
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'price': 299.99,
      'originalPrice': 399.99,
      'rating': 4.8,
      'reviews': 256,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Wearables',
      'inStock': true,
    },
    {
      'id': 3,
      'name': 'Bluetooth Speaker',
      'price': 79.99,
      'originalPrice': 99.99,
      'rating': 4.3,
      'reviews': 89,
      'image': 'https://via.placeholder.com/200x200',
      'category': 'Audio',
      'inStock': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      duration: const Duration(milliseconds: 200), // Flash every 200ms (5 times per second)
      vsync: this,
    );
    
    _flashAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeInOut,
    ));

    _startFlashing();
  }

  void _startFlashing() {
    if (isFlashing) {
      _flashController.forward().then((_) {
        setState(() {
          flashCount++;
        });
        _flashController.reverse().then((_) {
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted && isFlashing) {
              _startFlashing();
            }
          });
        });
      });
    }
  }

  void _stopFlashing() {
    setState(() {
      isFlashing = false;
    });
    _flashController.stop();
  }

  @override
  void dispose() {
    _flashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Electronics Store'),
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
          // FLASHING ADVERTISEMENT - FLASHING 5 TIMES PER SECOND
          AnimatedBuilder(
            animation: _flashAnimation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  // FLASHING: Alternates between colors
                  color: _flashAnimation.value > 0.5 
                      ? Colors.red[600] 
                      : Colors.orange[600],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '🔥',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'FLASH SALE!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Up to 50% OFF!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Flashes: $flashCount',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        isFlashing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (isFlashing) {
                          _stopFlashing();
                        } else {
                          setState(() {
                            isFlashing = true;
                          });
                          _startFlashing();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          
          // Products Section
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
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
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Row(
        children: [
          // Product Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    product['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
                if (!product['inStock'])
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Out of Stock',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < product['rating'].floor() ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${product['rating']} (${product['reviews']})',
                        style: TextStyle(
                          fontSize: 12,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${product['originalPrice']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Save \$${(product['originalPrice'] - product['price']).toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
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
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // Wishlist functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          // Share functionality
                        },
                      ),
                    ],
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

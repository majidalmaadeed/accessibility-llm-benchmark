import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ECommercePage(),
    );
  }
}

class ECommercePage extends StatefulWidget {
  @override
  _ECommercePageState createState() => _ECommercePageState();
}

class _ECommercePageState extends State<ECommercePage> with TickerProviderStateMixin {
  late AnimationController _flashController;
  late Animation<double> _flashAnimation;
  Timer? _flashTimer;
  bool _isFlashing = true;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _flashAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeInOut,
    ));
    
    _startFlashing();
  }

  void _startFlashing() {
    _flashTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (_isFlashing) {
        _flashController.forward().then((_) {
          _flashController.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _flashController.dispose();
    _flashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('E-Commerce Store'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
            AnimatedBuilder(
              animation: _flashAnimation,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red[600]!.withOpacity(_flashAnimation.value),
                        Colors.orange[600]!.withOpacity(_flashAnimation.value),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🔥 FLASH SALE - 50% OFF EVERYTHING! 🔥',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Limited time offer! Don\'t miss out on these amazing deals!',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isFlashing = !_isFlashing;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red[600],
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isFlashing ? 'Stop Flash' : 'Start Flash',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            // Main Content
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Products
                  Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Product Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildProductCard(index);
                    },
                  ),
                  
                  SizedBox(height: 40),
                  
                  // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
                  AnimatedBuilder(
                    animation: _flashAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple[600]!.withOpacity(_flashAnimation.value),
                              Colors.pink[600]!.withOpacity(_flashAnimation.value),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'PREMIUM MEMBERSHIP SALE!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Get 70% off on all premium memberships. Limited time offer!',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.purple[600],
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Get Premium Now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Categories
                  Text(
                    'Shop by Category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Category Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return _buildCategoryCard(index);
                    },
                  ),
                  
                  SizedBox(height: 40),
                  
                  // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
                  AnimatedBuilder(
                    animation: _flashAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green[600]!.withOpacity(_flashAnimation.value),
                              Colors.teal[600]!.withOpacity(_flashAnimation.value),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FREE SHIPPING ON ALL ORDERS!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'No minimum purchase required. Valid for limited time only.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.local_shipping,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Best Sellers
                  Text(
                    'Best Sellers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Best Sellers List
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 300,
                          margin: EdgeInsets.only(right: 20),
                          child: _buildBestSellerCard(index),
                        );
                      },
                    ),
                  ),
                  
                  SizedBox(height: 40),
                  
                  // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
                  AnimatedBuilder(
                    animation: _flashAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.amber[600]!.withOpacity(_flashAnimation.value),
                              Colors.orange[600]!.withOpacity(_flashAnimation.value),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'LIMITED TIME DEAL!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Buy 2 Get 1 FREE on all electronics. Hurry up, offer ends soon!',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.amber[600],
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Shop Now'),
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(color: Colors.white, width: 2),
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Learn More'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProductCard(int index) {
    List<Map<String, dynamic>> products = [
      {
        'name': 'Wireless Headphones',
        'price': '\$99.99',
        'originalPrice': '\$199.99',
        'rating': 4.5,
        'reviews': 128,
        'image': '🎧',
      },
      {
        'name': 'Smart Watch',
        'price': '\$199.99',
        'originalPrice': '\$299.99',
        'rating': 4.8,
        'reviews': 89,
        'image': '⌚',
      },
      {
        'name': 'Bluetooth Speaker',
        'price': '\$79.99',
        'originalPrice': '\$129.99',
        'rating': 4.3,
        'reviews': 156,
        'image': '🔊',
      },
      {
        'name': 'Phone Case',
        'price': '\$29.99',
        'originalPrice': '\$49.99',
        'rating': 4.2,
        'reviews': 203,
        'image': '📱',
      },
      {
        'name': 'Laptop Stand',
        'price': '\$49.99',
        'originalPrice': '\$79.99',
        'rating': 4.6,
        'reviews': 67,
        'image': '💻',
      },
      {
        'name': 'Gaming Mouse',
        'price': '\$59.99',
        'originalPrice': '\$99.99',
        'rating': 4.7,
        'reviews': 91,
        'image': '🖱️',
      },
    ];
    
    var product = products[index];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  product['image'],
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
          ),
          
          // Product Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        product['rating'].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '(${product['reviews']})',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Text(
                        product['price'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        product['originalPrice'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  
                  Spacer(),
                  
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryCard(int index) {
    List<Map<String, dynamic>> categories = [
      {'name': 'Electronics', 'image': '📱'},
      {'name': 'Clothing', 'image': '👕'},
      {'name': 'Home & Garden', 'image': '🏠'},
      {'name': 'Sports', 'image': '⚽'},
      {'name': 'Books', 'image': '📚'},
      {'name': 'Beauty', 'image': '💄'},
      {'name': 'Toys', 'image': '🧸'},
      {'name': 'Automotive', 'image': '🚗'},
    ];
    
    var category = categories[index];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category['image'],
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 12),
                Text(
                  category['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBestSellerCard(int index) {
    List<Map<String, dynamic>> bestSellers = [
      {
        'name': 'Premium Wireless Earbuds',
        'price': '\$149.99',
        'rating': 4.9,
        'reviews': 342,
        'image': '🎧',
        'badge': 'Best Seller',
      },
      {
        'name': 'Smart Home Hub',
        'price': '\$89.99',
        'rating': 4.7,
        'reviews': 198,
        'image': '🏠',
        'badge': 'Trending',
      },
      {
        'name': 'Fitness Tracker',
        'price': '\$79.99',
        'rating': 4.6,
        'reviews': 267,
        'image': '⌚',
        'badge': 'Popular',
      },
      {
        'name': 'Portable Charger',
        'price': '\$39.99',
        'rating': 4.4,
        'reviews': 189,
        'image': '🔋',
        'badge': 'New',
      },
      {
        'name': 'Gaming Keyboard',
        'price': '\$129.99',
        'rating': 4.8,
        'reviews': 156,
        'image': '⌨️',
        'badge': 'Hot',
      },
    ];
    
    var product = bestSellers[index];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                product['image'],
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product['badge'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        product['rating'].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '(${product['reviews']})',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    product['price'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  
                  Spacer(),
                  
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text('Add to Cart'),
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


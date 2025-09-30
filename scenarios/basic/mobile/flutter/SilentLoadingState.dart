import 'package:flutter/material.dart';

class SilentLoadingState extends StatefulWidget {
  const SilentLoadingState({Key? key}) : super(key: key);

  @override
  State<SilentLoadingState> createState() => _SilentLoadingStateState();
}

class _SilentLoadingStateState extends State<SilentLoadingState> {
  bool loading = false;
  List<Map<String, dynamic>> data = [];
  int currentPage = 1;
  bool hasMore = true;
  bool refreshing = false;

  String searchQuery = '';
  String filter = 'all';
  String sortBy = 'name';

  final List<Map<String, dynamic>> mockData = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'category': 'electronics',
      'price': 99.99,
      'rating': 4.5,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'description': 'High-quality wireless headphones with noise cancellation'
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'category': 'electronics',
      'price': 299.99,
      'rating': 4.8,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'description': 'Advanced smartwatch with health monitoring features'
    },
    {
      'id': 3,
      'name': 'Laptop Stand',
      'category': 'accessories',
      'price': 49.99,
      'rating': 4.2,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': false,
      'description': 'Adjustable laptop stand for better ergonomics'
    },
    {
      'id': 4,
      'name': 'Bluetooth Speaker',
      'category': 'electronics',
      'price': 79.99,
      'rating': 4.6,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'description': 'Portable Bluetooth speaker with excellent sound quality'
    },
    {
      'id': 5,
      'name': 'Phone Case',
      'category': 'accessories',
      'price': 19.99,
      'rating': 4.3,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'description': 'Protective phone case with wireless charging support'
    },
    {
      'id': 6,
      'name': 'USB Cable',
      'category': 'accessories',
      'price': 9.99,
      'rating': 4.1,
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'description': 'High-speed USB-C cable for fast charging and data transfer'
    }
  ];

  final List<String> categories = ['all', 'electronics', 'accessories'];
  final List<Map<String, dynamic>> sortOptions = [
    {'id': 'name', 'name': 'Name'},
    {'id': 'price', 'name': 'Price'},
    {'id': 'rating', 'name': 'Rating'},
    {'id': 'newest', 'name': 'Newest'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });
    
    // SILENT LOADING STATE - No screen reader announcement
    // Just shows spinner without announcing loading state to assistive technology
    
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      final startIndex = (currentPage - 1) * 3;
      final endIndex = startIndex + 3;
      final newData = mockData.skip(startIndex).take(3).toList();
      
      setState(() {
        if (currentPage == 1) {
          data = newData;
        } else {
          data.addAll(newData);
        }
        currentPage++;
        hasMore = endIndex < mockData.length;
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      refreshing = true;
      currentPage = 1;
    });
    
    await _fetchData();
    
    setState(() {
      refreshing = false;
    });
  }

  Future<void> _handleSearch() async {
    setState(() {
      loading = true;
    });
    
    // Simulate search delay
    await Future.delayed(const Duration(seconds: 1));
    
    final filtered = mockData.where((item) => 
      item['name'].toLowerCase().contains(searchQuery.toLowerCase()) &&
      (filter == 'all' || item['category'] == filter)
    ).toList();
    
    setState(() {
      data = filtered;
      loading = false;
    });
  }

  Future<void> _handleFilterChange(String newFilter) async {
    setState(() {
      filter = newFilter;
      loading = true;
    });
    
    // Simulate filter delay
    await Future.delayed(const Duration(seconds: 1));
    
    final filtered = mockData.where((item) => 
      newFilter == 'all' || item['category'] == newFilter
    ).toList();
    
    setState(() {
      data = filtered;
      loading = false;
    });
  }

  Future<void> _handleSortChange(String newSort) async {
    setState(() {
      sortBy = newSort;
      loading = true;
    });
    
    // Simulate sort delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    final sorted = List<Map<String, dynamic>>.from(data);
    sorted.sort((a, b) {
      switch (newSort) {
        case 'name':
          return a['name'].compareTo(b['name']);
        case 'price':
          return a['price'].compareTo(b['price']);
        case 'rating':
          return b['rating'].compareTo(a['rating']);
        case 'newest':
          return b['id'].compareTo(a['id']);
        default:
          return 0;
      }
    });
    
    setState(() {
      data = sorted;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Product Catalog'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  onSubmitted: (value) => _handleSearch(),
                ),
                
                const SizedBox(height: 16),
                
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      final isSelected = filter == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) => _handleFilterChange(category),
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.blue[100],
                          checkmarkColor: Colors.blue[700],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sort Options
                Row(
                  children: [
                    const Text('Sort by: '),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sortOptions.map((option) {
                            final isSelected = sortBy == option['id'];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(option['name']),
                                selected: isSelected,
                                onSelected: (selected) => _handleSortChange(option['id']),
                                backgroundColor: Colors.grey[200],
                                selectedColor: Colors.green[100],
                                checkmarkColor: Colors.green[700],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Loading State - SILENT (No screen reader announcement)
          if (loading) _buildLoadingState(),
          
          // Products List
          if (!loading) _buildProductsList(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading products...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          // MISSING: Screen reader announcement of loading state
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: data.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return _buildLoadMoreButton();
                  }
                  return _buildProductCard(data[index]);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '📦',
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Products Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your search or filter criteria',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
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
                  
                  const SizedBox(height: 4),
                  
                  // Description
                  Text(
                    product['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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
                          size: 12,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '${product['rating']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Price
                  Text(
                    '\$${product['price']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
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

  Widget _buildLoadMoreButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ElevatedButton(
          onPressed: hasMore ? _fetchData : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Load More Products'),
        ),
      ),
    );
  }
}

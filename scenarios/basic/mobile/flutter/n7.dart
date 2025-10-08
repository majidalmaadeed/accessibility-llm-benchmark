import 'package:flutter/material.dart';

class InsufficientButtonSpacing extends StatefulWidget {
  const InsufficientButtonSpacing({Key? key}) : super(key: key);

  @override
  State<InsufficientButtonSpacing> createState() => _InsufficientButtonSpacingState();
}

class _InsufficientButtonSpacingState extends State<InsufficientButtonSpacing> {
  Set<int> selectedItems = {};
  String searchQuery = '';
  String filter = 'all';

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Wireless Headphones',
      'price': 99.99,
      'category': 'electronics',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'rating': 4.5
    },
    {
      'id': 2,
      'name': 'Smart Watch',
      'price': 299.99,
      'category': 'electronics',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'rating': 4.8
    },
    {
      'id': 3,
      'name': 'Laptop Stand',
      'price': 49.99,
      'category': 'accessories',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': false,
      'rating': 4.2
    },
    {
      'id': 4,
      'name': 'Bluetooth Speaker',
      'price': 79.99,
      'category': 'electronics',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'rating': 4.6
    },
    {
      'id': 5,
      'name': 'Phone Case',
      'price': 19.99,
      'category': 'accessories',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'rating': 4.3
    },
    {
      'id': 6,
      'name': 'USB Cable',
      'price': 9.99,
      'category': 'accessories',
      'image': 'https://via.placeholder.com/150x150',
      'inStock': true,
      'rating': 4.1
    }
  ];

  final List<String> categories = ['all', 'electronics', 'accessories'];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = filter == 'all' || product['category'] == filter;
      final matchesSearch = product['name'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _handleItemSelect(int itemId) {
    setState(() {
      if (selectedItems.contains(itemId)) {
        selectedItems.remove(itemId);
      } else {
        selectedItems.add(itemId);
      }
    });
  }

  void _handleBulkAction(String action) {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select items first')),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action ${selectedItems.length} item(s)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Product Manager'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: categories.map((category) {
                    final isSelected = filter == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category.toUpperCase()),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            filter = category;
                          });
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: Colors.blue[100],
                        checkmarkColor: Colors.blue[700],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Bulk Actions - INSUFFICIENT BUTTON SPACING (2px apart instead of 44px minimum)
          if (selectedItems.isNotEmpty) _buildBulkActions(),
          
          // Products Grid
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Products (${filteredProducts.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(filteredProducts[index]);
                  },
                ),
              ],
            ),
          ),
          
          // Footer Actions - INSUFFICIENT SPACING
          _buildFooterActions(),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
    return Container(
      color: Colors.blue[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '${selectedItems.length} item(s) selected',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // INSUFFICIENT SPACING: Only 2px margin
                    margin: const EdgeInsets.only(right: 2),
                  ),
                  child: const Text('Delete'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Export'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // INSUFFICIENT SPACING: Only 2px margin
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                  ),
                  child: const Text('Export'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Archive'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // INSUFFICIENT SPACING: Only 2px margin
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                  ),
                  child: const Text('Archive'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Duplicate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // INSUFFICIENT SPACING: Only 2px margin
                    margin: const EdgeInsets.only(left: 2),
                  ),
                  child: const Text('Duplicate'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isSelected = selectedItems.contains(product['id']);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
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
                  Center(
                    child: Image.network(
                      product['image'],
                      width: double.infinity,
                      height: double.infinity,
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
                  
                  // Selection Checkbox
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _handleItemSelect(product['id']),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
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
                            fontSize: 12,
                          ),
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
                        '${product['rating']}',
                        style: TextStyle(
                          fontSize: 10,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Action Buttons - INSUFFICIENT SPACING (2px apart)
                  // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
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
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.only(right: 2),
                          ),
                          child: Text(
                            product['inStock'] ? 'Add to Cart' : 'Out of Stock',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Wishlist functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                          ),
                          child: const Text(
                            'Wishlist',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Share functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                          ),
                          child: const Text(
                            'Share',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Quick view functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Edit functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Delete functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[100],
                            foregroundColor: Colors.red[700],
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            // INSUFFICIENT SPACING: Only 2px margin
                            margin: const EdgeInsets.only(left: 2),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
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

  Widget _buildFooterActions() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        // INSUFFICIENT SPACING: Only 2px between buttons instead of minimum 44px
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Save changes functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.only(right: 2),
              ),
              child: const Text('Save Changes'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Cancel functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.grey[700],
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              child: const Text('Cancel'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Reset functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.grey[700],
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              child: const Text('Reset'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Export all functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              child: const Text('Export All'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Import functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              child: const Text('Import'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Settings functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                // INSUFFICIENT SPACING: Only 2px margin
                margin: const EdgeInsets.only(left: 2),
              ),
              child: const Text('Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

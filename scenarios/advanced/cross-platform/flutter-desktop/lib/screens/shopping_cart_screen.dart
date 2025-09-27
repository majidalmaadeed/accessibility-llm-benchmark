import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(name: 'Product 1', price: 29.99, quantity: 2),
    CartItem(name: 'Product 2', price: 19.99, quantity: 1),
    CartItem(name: 'Product 3', price: 39.99, quantity: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart System'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)} each'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Qty: ${item.quantity}'),
                        IconButton(
                          onPressed: () => _removeItem(index),
                          icon: const Icon(Icons.remove_circle),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Total and Checkout
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Total: \$${_calculateTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearCart,
                        child: const Text('Clear Cart'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _checkout,
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to clear all items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proceeding to checkout...')),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

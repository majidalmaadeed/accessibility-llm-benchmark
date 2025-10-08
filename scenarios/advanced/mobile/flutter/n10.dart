import 'package:flutter/material.dart';

class ShoppingCartSystem extends StatefulWidget {
  const ShoppingCartSystem({Key? key}) : super(key: key);

  @override
  State<ShoppingCartSystem> createState() => _ShoppingCartSystemState();
}

class _ShoppingCartSystemState extends State<ShoppingCartSystem> {
  List<Map<String, dynamic>> cartItems = [];
  String promoCode = '';
  Map<String, dynamic>? appliedPromo;
  bool showPromoField = false;
  bool showCheckout = false;
  String selectedShipping = 'standard';
  String paymentMethod = 'creditCard';
  bool isCheckingOut = false;

  final List<Map<String, dynamic>> shippingOptions = [
    {'id': 'standard', 'name': 'Standard', 'price': 5.99, 'days': '5-7 business days'},
    {'id': 'express', 'name': 'Express', 'price': 12.99, 'days': '2-3 business days'},
    {'id': 'overnight', 'name': 'Overnight', 'price': 24.99, 'days': 'Next business day'},
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {'id': 'creditCard', 'name': 'Credit Card', 'icon': Icons.credit_card},
    {'id': 'paypal', 'name': 'PayPal', 'icon': Icons.payment},
    {'id': 'applePay', 'name': 'Apple Pay', 'icon': Icons.apple},
    {'id': 'googlePay', 'name': 'Google Pay', 'icon': Icons.g_mobiledata},
  ];

  final List<Map<String, dynamic>> promoCodes = [
    {'code': 'SAVE10', 'discount': 10, 'type': 'percentage'},
    {'code': 'WELCOME', 'discount': 15, 'type': 'percentage'},
    {'code': 'FREESHIP', 'discount': 0, 'type': 'shipping'},
    {'code': 'FLAT20', 'discount': 20, 'type': 'fixed'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    setState(() {
      cartItems = [
        {
          'id': '1',
          'name': 'Wireless Headphones',
          'price': 99.99,
          'quantity': 1,
          'image': Icons.headphones,
          'category': 'Electronics',
        },
        {
          'id': '2',
          'name': 'Smart Watch',
          'price': 299.99,
          'quantity': 1,
          'image': Icons.watch,
          'category': 'Electronics',
        },
        {
          'id': '3',
          'name': 'Coffee Maker',
          'price': 149.99,
          'quantity': 2,
          'image': Icons.coffee,
          'category': 'Home & Kitchen',
        },
      ];
    });
  }

  double _calculateSubtotal() {
    return cartItems.fold(0.0, (total, item) => total + (item['price'] * item['quantity']));
  }

  double _calculateShipping() {
    final selectedOption = shippingOptions.firstWhere((option) => option['id'] == selectedShipping);
    return selectedOption['price'];
  }

  double _calculateTax() {
    final subtotal = _calculateSubtotal();
    final shipping = _calculateShipping();
    return (subtotal + shipping) * 0.08; // 8% tax
  }

  double _calculateDiscount() {
    if (appliedPromo == null) return 0;

    final subtotal = _calculateSubtotal();
    final shipping = _calculateShipping();

    switch (appliedPromo!['type']) {
      case 'percentage':
        return subtotal * (appliedPromo!['discount'] / 100);
      case 'fixed':
        return appliedPromo!['discount'].toDouble();
      case 'shipping':
        return shipping;
      default:
        return 0;
    }
  }

  double _calculateTotal() {
    final subtotal = _calculateSubtotal();
    final shipping = _calculateShipping();
    final tax = _calculateTax();
    final discount = _calculateDiscount();
    return subtotal + shipping + tax - discount;
  }

  void _handleQuantityChange(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      _handleRemoveItem(itemId);
    } else {
      setState(() {
        final index = cartItems.indexWhere((item) => item['id'] == itemId);
        if (index != -1) {
          cartItems[index]['quantity'] = newQuantity;
        }
      });
    }
  }

  void _handleRemoveItem(String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Item'),
        content: const Text('Are you sure you want to remove this item from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cartItems.removeWhere((item) => item['id'] == itemId);
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _handleApplyPromo() {
    final promo = promoCodes.firstWhere(
      (p) => p['code'] == promoCode.toUpperCase(),
      orElse: () => <String, dynamic>{},
    );

    if (promo.isNotEmpty) {
      setState(() {
        appliedPromo = promo;
        promoCode = '';
        showPromoField = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Promo code applied successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The promo code you entered is not valid.')),
      );
    }
  }

  void _handleRemovePromo() {
    setState(() {
      appliedPromo = null;
    });
  }

  void _handleCheckout() async {
    setState(() {
      isCheckingOut = true;
    });

    // Simulate checkout process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isCheckingOut = false;
    });

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Placed!'),
          content: const Text(
            'Your order has been placed successfully. You will receive a confirmation email shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  showCheckout = false;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return _buildEmptyState();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCartItems(),
                  _buildPromoSection(),
                  _buildOrderSummary(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              const Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Add some items to get started',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to shop
                },
                child: const Text('Start Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: cartItems.map((item) => _buildCartItem(item)).toList(),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              item['image'],
              size: 40,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item['category'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item['price'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _handleQuantityChange(item['id'], item['quantity'] - 1),
                    icon: const Icon(Icons.remove, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      minimumSize: const Size(32, 32),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item['quantity'].toString(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _handleQuantityChange(item['id'], item['quantity'] + 1),
                    icon: const Icon(Icons.add, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      minimumSize: const Size(32, 32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () => _handleRemoveItem(item['id']),
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: appliedPromo == null
            ? _buildPromoInput()
            : _buildAppliedPromo(),
      ),
    );
  }

  Widget _buildPromoInput() {
    if (!showPromoField) {
      return InkWell(
        onTap: () => setState(() => showPromoField = true),
        child: const Row(
          children: [
            Icon(Icons.card_giftcard, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Add Promo Code',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter promo code',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) => setState(() => promoCode = value),
            textCapitalization: TextCapitalization.characters,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _handleApplyPromo,
          child: const Text('Apply'),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => setState(() {
            showPromoField = false;
            promoCode = '';
          }),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildAppliedPromo() {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          '${appliedPromo!['code']} applied',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        IconButton(
          onPressed: _handleRemovePromo,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Subtotal', _calculateSubtotal()),
            _buildSummaryRow('Shipping', _calculateShipping()),
            _buildSummaryRow('Tax', _calculateTax()),
            if (appliedPromo != null)
              _buildSummaryRow(
                'Discount (${appliedPromo!['code']})',
                -_calculateDiscount(),
                isDiscount: true,
              ),
            const Divider(),
            _buildSummaryRow('Total', _calculateTotal(), isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : null,
            ),
          ),
          Text(
            '${isDiscount ? '-' : ''}\$${value.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => setState(() => showCheckout = true),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Proceed to Checkout - \$${_calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return _buildEmptyState();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCartItems(),
                  _buildPromoSection(),
                  _buildOrderSummary(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
      bottomSheet: showCheckout ? _buildCheckoutModal() : null,
    );
  }

  Widget _buildCheckoutModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildCheckoutHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildShippingOptions(),
                  _buildPaymentMethods(),
                  _buildOrderSummary(),
                ],
              ),
            ),
          ),
          _buildCheckoutFooter(),
        ],
      ),
    );
  }

  Widget _buildCheckoutHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => setState(() => showCheckout = false),
            icon: const Icon(Icons.close),
          ),
          const Text(
            'Checkout',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 48), // Balance the close button
        ],
      ),
    );
  }

  Widget _buildShippingOptions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Options',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...shippingOptions.map((option) => _buildShippingOption(option)),
        ],
      ),
    );
  }

  Widget _buildShippingOption(Map<String, dynamic> option) {
    final isSelected = selectedShipping == option['id'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue[50] : Colors.white,
      ),
      child: RadioListTile<String>(
        title: Text(option['name']),
        subtitle: Text(option['days']),
        value: option['id'],
        groupValue: selectedShipping,
        onChanged: (value) => setState(() => selectedShipping = value!),
        secondary: Text(
          '\$${option['price'].toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) => _buildPaymentOption(method)),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method) {
    final isSelected = paymentMethod == method['id'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue[50] : Colors.white,
      ),
      child: RadioListTile<String>(
        title: Text(method['name']),
        value: method['id'],
        groupValue: paymentMethod,
        onChanged: (value) => setState(() => paymentMethod = value!),
        secondary: Icon(method['icon'], color: Colors.blue),
      ),
    );
  }

  Widget _buildCheckoutFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isCheckingOut ? null : _handleCheckout,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: isCheckingOut
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text('Processing...'),
                    ],
                  )
                : Text(
                    'Place Order - \$${_calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}

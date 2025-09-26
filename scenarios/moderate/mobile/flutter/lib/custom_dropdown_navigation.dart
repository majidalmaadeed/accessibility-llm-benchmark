import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class Product {
  final String name;
  final String category;

  Product({required this.name, required this.category});
}

class Option {
  final String value;
  final String text;

  Option({required this.value, required this.text});
}

class CustomDropdownNavigation extends StatefulWidget {
  const CustomDropdownNavigation({Key? key}) : super(key: key);

  @override
  State<CustomDropdownNavigation> createState() => _CustomDropdownNavigationState();
}

class _CustomDropdownNavigationState extends State<CustomDropdownNavigation> {
  bool isOpen = false;
  String selectedValue = 'all';
  String selectedText = 'All Categories';
  int currentIndex = 0;

  final List<Option> options = [
    Option(value: 'all', text: 'All Categories'),
    Option(value: 'electronics', text: 'Electronics'),
    Option(value: 'clothing', text: 'Clothing'),
    Option(value: 'books', text: 'Books'),
    Option(value: 'home', text: 'Home & Garden'),
  ];

  final Map<String, List<Product>> products = {
    'all': [
      Product(name: 'iPhone 15', category: 'Electronics'),
      Product(name: 'MacBook Pro', category: 'Electronics'),
      Product(name: 'Cotton T-Shirt', category: 'Clothing'),
      Product(name: 'JavaScript Guide', category: 'Books'),
      Product(name: 'Garden Tools', category: 'Home & Garden'),
    ],
    'electronics': [
      Product(name: 'iPhone 15', category: 'Electronics'),
      Product(name: 'MacBook Pro', category: 'Electronics'),
    ],
    'clothing': [
      Product(name: 'Cotton T-Shirt', category: 'Clothing'),
    ],
    'books': [
      Product(name: 'JavaScript Guide', category: 'Books'),
    ],
    'home': [
      Product(name: 'Garden Tools', category: 'Home & Garden'),
    ],
  };

  List<Product> get filteredProducts => products[selectedValue] ?? [];

  void toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void selectOption(String value, String text, int index) {
    setState(() {
      selectedValue = value;
      selectedText = text;
      currentIndex = index;
      isOpen = false;
    });

    SemanticsService.announce('Selected $text', TextDirection.ltr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Main Content Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Product Filter',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Description
                    const Text(
                      'Filter products by category using the dropdown below.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Filter Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filter by Category:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Custom Dropdown
                        SizedBox(
                          width: 200,
                          child: Stack(
                            children: [
                              // Dropdown Button
                              Semantics(
                                label: 'Category filter, $selectedText, double tap to open dropdown',
                                hint: 'Opens category selection dropdown',
                                button: true,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: toggleDropdown,
                                    borderRadius: BorderRadius.circular(isOpen ? 8 : 8),
                                    child: Container(
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8F9FA),
                                        border: Border.all(
                                          color: isOpen 
                                              ? const Color(0xFF007BFF) 
                                              : const Color(0xFFDDDDDD),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(isOpen ? 8 : 8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              selectedText,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                            AnimatedRotation(
                                              turns: isOpen ? 0.5 : 0,
                                              duration: const Duration(milliseconds: 200),
                                              child: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(0xFF666666),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Dropdown Menu
                              if (isOpen)
                                Positioned(
                                  top: 44,
                                  left: 0,
                                  right: 0,
                                  child: Material(
                                    elevation: 8,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0xFF007BFF),
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Column(
                                        children: options.asMap().entries.map((entry) {
                                          int index = entry.key;
                                          Option option = entry.value;
                                          bool isSelected = selectedValue == option.value;
                                          
                                          return Semantics(
                                            label: option.text,
                                            selected: isSelected,
                                            button: true,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () => selectOption(option.value, option.text, index),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: isSelected 
                                                        ? const Color(0xFF007BFF) 
                                                        : Colors.transparent,
                                                    border: index < options.length - 1
                                                        ? const Border(
                                                            bottom: BorderSide(
                                                              color: Color(0xFFEEEEEE),
                                                              width: 1,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        option.text,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: isSelected 
                                                              ? Colors.white 
                                                              : const Color(0xFF333333),
                                                        ),
                                                      ),
                                                      if (isSelected)
                                                        const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    
                    // Results Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filtered Results',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        SizedBox(
                          height: 200,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return Semantics(
                                label: '${product.name}, ${product.category}',
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF333333),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          product.category,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
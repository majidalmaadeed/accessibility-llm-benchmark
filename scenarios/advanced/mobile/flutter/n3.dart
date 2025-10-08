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

    > selectOption(option.value, option.text, index),
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
                    
                    
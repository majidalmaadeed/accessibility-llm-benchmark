import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  FlatList,
  StyleSheet,
  Dimensions,
  Platform,
} from 'react-native';
const { width } = Dimensions.get('window');
  const [isOpen, setIsOpen] = useState(false);
  const [selectedValue, setSelectedValue] = useState('all');
  const [selectedText, setSelectedText] = useState('All Categories');
  const [currentIndex, setCurrentIndex] = useState(0);
  const options = [
    { value: 'all', text: 'All Categories' },
    { value: 'electronics', text: 'Electronics' },
    { value: 'clothing', text: 'Clothing' },
    { value: 'books', text: 'Books' },
    { value: 'home', text: 'Home & Garden' }
  ];
  const products = {
    all: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' },
      { name: 'Cotton T-Shirt', category: 'Clothing' },
      { name: 'JavaScript Guide', category: 'Books' },
      { name: 'Garden Tools', category: 'Home & Garden' }
    ],
    electronics: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' }
    ],
    clothing: [
      { name: 'Cotton T-Shirt', category: 'Clothing' }
    ],
    books: [
      { name: 'JavaScript Guide', category: 'Books' }
    ],
    home: [
      { name: 'Garden Tools', category: 'Home & Garden' }
    ]
  };
  const filteredProducts = products[selectedValue] || [];
  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };
  const selectOption = (value, text, index) => {
    setSelectedValue(value);
    setSelectedText(text);
    setCurrentIndex(index);
    setIsOpen(false);
    if (Platform.OS === 'ios') {
    } else {
    }
  };
  const renderProduct = ({ item }) => (
    <View style={styles.productCard}>
      <Text style={styles.productName}>{item.name}</Text>
      <Text style={styles.productCategory}>{item.category}</Text>
    </View>
  );
  const renderOption = ({ item, index }) => (
    <TouchableOpacity
      style={[
        styles.optionItem,
        selectedValue === item.value && styles.selectedOption
      ]}
      onPress={() => selectOption(item.value, item.text, index)}
      accessible={true}
    >
      <Text style={[
        styles.optionText,
        selectedValue === item.value && styles.selectedOptionText
      ]}>
        {item.text}
      </Text>
      {selectedValue === item.value && (
        <Text style={styles.checkmark}>✓</Text>
      )}
    </TouchableOpacity>
  );
  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.contentContainer}>
      <View style={styles.mainContent}>
        <Text style={styles.title}>
          Product Filter
        </Text>
        <Text style={styles.description}>
          Filter products by category using the dropdown below.
        </Text>
        <View style={styles.filterSection}>
          <View style={styles.dropdownContainer}>
            <TouchableOpacity
              style={[styles.dropdownButton, isOpen && styles.dropdownButtonOpen]}
              onPress={toggleDropdown}
              accessible={true}
            >
              <Text style={styles.dropdownButtonText}>{selectedText}</Text>
              <Text style={[styles.dropdownArrow, isOpen && styles.dropdownArrowRotated]}>
                ▼
              </Text>
            </TouchableOpacity>
            {isOpen && (
              <View style={styles.dropdownMenu}>
                <FlatList
                  data={options}
                  renderItem={renderOption}
                  keyExtractor={(item) => item.value}
                  style={styles.optionsList}
                />
              </View>
            )}
          </View>
        </View>
        <View style={styles.resultsSection}>
          <Text style={styles.resultsTitle}>Filtered Results</Text>
          <FlatList
            data={filteredProducts}
            renderItem={renderProduct}
            keyExtractor={(item) => item.name}
            numColumns={2}
            scrollEnabled={false}
            contentContainerStyle={styles.productsGrid}
          />
        </View>
      </View>
    backgroundColor: '#E9ECEF',
    padding: 20,
    borderRadius: 4,
  },
  infoTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 12,
  },
  infoText: {
    fontSize: 14,
    color: '#333333',
    marginBottom: 12,
    lineHeight: 20,
  },
});
import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  FlatList,
  StyleSheet,
  Dimensions,
  AccessibilityInfo,
  Platform,
} from 'react-native';

const { width } = Dimensions.get('window');

const CustomDropdownNavigation = () => {
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
    
    // Announce selection change for accessibility
    if (Platform.OS === 'ios') {
      AccessibilityInfo.announceForAccessibility(`Selected ${text}`);
    } else {
      AccessibilityInfo.announceForAccessibility(`Selected ${text}`);
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
      accessibilityLabel={item.text}
      accessibilityRole="button"
      accessibilityState={{ selected: selectedValue === item.value }}
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
          Product Filter - Custom Dropdown Accessibility Violation
        </Text>
        
        <Text style={styles.description}>
          Violation: Custom dropdown lacks proper keyboard navigation, ARIA attributes, and screen reader support.
        </Text>
        
        <View style={styles.filterSection}>
          <Text style={styles.filterLabel}>Filter by Category:</Text>
          
          <View style={styles.dropdownContainer}>
            <TouchableOpacity
              style={[styles.dropdownButton, isOpen && styles.dropdownButtonOpen]}
              onPress={toggleDropdown}
              accessible={true}
              accessibilityLabel={`Category filter, ${selectedText}, double tap to open dropdown`}
              accessibilityRole="button"
              accessibilityHint="Opens category selection dropdown"
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

      <View style={styles.accessibilityInfo}>
        <Text style={styles.infoTitle}>Accessibility Issues:</Text>
        
        <Text style={styles.infoText}>
          • Incomplete keyboard navigation: Arrow keys don't navigate through options{'\n'}
          • Missing ARIA attributes: No aria-activedescendant or proper role attributes{'\n'}
          • Focus management: Focus doesn't move to options when dropdown opens{'\n'}
          • Screen reader announcements: No announcements when selection changes{'\n'}
          • Escape key handling: Escape doesn't close dropdown{'\n'}
          • Tab order: Options are not in proper tab sequence
        </Text>
        
        <Text style={styles.infoTitle}>How to Fix:</Text>
        
        <Text style={styles.infoText}>
          • Add aria-activedescendant to track focused option{'\n'}
          • Implement arrow key navigation (Up/Down){'\n'}
          • Add aria-selected to indicate selected state{'\n'}
          • Handle Escape key to close dropdown{'\n'}
          • Add aria-live region for selection announcements{'\n'}
          • Ensure proper focus management when opening/closing
        </Text>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  contentContainer: {
    padding: 20,
  },
  mainContent: {
    backgroundColor: 'white',
    padding: 30,
    borderRadius: 8,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 10,
    elevation: 4,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 16,
  },
  description: {
    fontSize: 16,
    color: '#666666',
    marginBottom: 30,
  },
  filterSection: {
    marginBottom: 30,
  },
  filterLabel: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 8,
  },
  dropdownContainer: {
    position: 'relative',
    width: 200,
  },
  dropdownButton: {
    backgroundColor: '#F8F9FA',
    borderWidth: 2,
    borderColor: '#DDDDDD',
    borderRadius: 4,
    padding: 12,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    minHeight: 44,
  },
  dropdownButtonOpen: {
    borderColor: '#007BFF',
    borderBottomLeftRadius: 0,
    borderBottomRightRadius: 0,
  },
  dropdownButtonText: {
    fontSize: 16,
    color: '#333333',
  },
  dropdownArrow: {
    fontSize: 16,
    color: '#666666',
    transform: [{ rotate: '0deg' }],
  },
  dropdownArrowRotated: {
    transform: [{ rotate: '180deg' }],
  },
  dropdownMenu: {
    position: 'absolute',
    top: '100%',
    left: 0,
    right: 0,
    backgroundColor: 'white',
    borderWidth: 2,
    borderColor: '#007BFF',
    borderTopWidth: 0,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
    zIndex: 1000,
  },
  optionsList: {
    maxHeight: 220,
  },
  optionItem: {
    padding: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  selectedOption: {
    backgroundColor: '#007BFF',
  },
  optionText: {
    fontSize: 16,
    color: '#333333',
  },
  selectedOptionText: {
    color: 'white',
  },
  checkmark: {
    fontSize: 16,
    color: 'white',
    fontWeight: 'bold',
  },
  resultsSection: {
    marginTop: 30,
  },
  resultsTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 16,
  },
  productsGrid: {
    gap: 16,
  },
  productCard: {
    flex: 1,
    backgroundColor: 'white',
    borderWidth: 1,
    borderColor: '#DDDDDD',
    borderRadius: 8,
    padding: 20,
    margin: 8,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  productName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333333',
    marginBottom: 8,
    textAlign: 'center',
  },
  productCategory: {
    fontSize: 12,
    color: '#666666',
    textAlign: 'center',
  },
  accessibilityInfo: {
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

export default CustomDropdownNavigation;
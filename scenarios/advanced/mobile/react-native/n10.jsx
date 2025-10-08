import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  TextInput,
  Modal,
  Alert,
  Dimensions,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const ShoppingCartSystem = () => {
  const [cartItems, setCartItems] = useState([]);
  const [promoCode, setPromoCode] = useState('');
  const [appliedPromo, setAppliedPromo] = useState(null);
  const [showPromoField, setShowPromoField] = useState(false);
  const [showCheckout, setShowCheckout] = useState(false);
  const [selectedShipping, setSelectedShipping] = useState('standard');
  const [paymentMethod, setPaymentMethod] = useState('creditCard');
  const [isCheckingOut, setIsCheckingOut] = useState(false);

  const shippingOptions = [
    { id: 'standard', name: 'Standard', price: 5.99, days: '5-7 business days' },
    { id: 'express', name: 'Express', price: 12.99, days: '2-3 business days' },
    { id: 'overnight', name: 'Overnight', price: 24.99, days: 'Next business day' },
  ];

  const paymentMethods = [
    { id: 'creditCard', name: 'Credit Card', icon: 'card' },
    { id: 'paypal', name: 'PayPal', icon: 'logo-paypal' },
    { id: 'applePay', name: 'Apple Pay', icon: 'logo-apple' },
    { id: 'googlePay', name: 'Google Pay', icon: 'logo-google' },
  ];

  const promoCodes = [
    { code: 'SAVE10', discount: 10, type: 'percentage' },
    { code: 'WELCOME', discount: 15, type: 'percentage' },
    { code: 'FREESHIP', discount: 0, type: 'shipping' },
    { code: 'FLAT20', discount: 20, type: 'fixed' },
  ];

  useEffect(() => {
    // Load sample cart items
    setCartItems([
      {
        id: '1',
        name: 'Wireless Headphones',
        price: 99.99,
        quantity: 1,
        image: 'headphones',
        category: 'Electronics',
      },
      {
        id: '2',
        name: 'Smart Watch',
        price: 299.99,
        quantity: 1,
        image: 'watch',
        category: 'Electronics',
      },
      {
        id: '3',
        name: 'Coffee Maker',
        price: 149.99,
        quantity: 2,
        image: 'cafe',
        category: 'Home & Kitchen',
      },
    ]);
  }, []);

  const calculateSubtotal = () => {
    return cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
  };

  const calculateShipping = () => {
    const selectedOption = shippingOptions.find(option => option.id === selectedShipping);
    return selectedOption ? selectedOption.price : 0;
  };

  const calculateTax = () => {
    const subtotal = calculateSubtotal();
    const shipping = calculateShipping();
    return (subtotal + shipping) * 0.08; // 8% tax
  };

  const calculateDiscount = () => {
    if (!appliedPromo) return 0;
    
    const subtotal = calculateSubtotal();
    const shipping = calculateShipping();
    
    switch (appliedPromo.type) {
      case 'percentage':
        return subtotal * (appliedPromo.discount / 100);
      case 'fixed':
        return appliedPromo.discount;
      case 'shipping':
        return shipping;
      default:
        return 0;
    }
  };

  const calculateTotal = () => {
    const subtotal = calculateSubtotal();
    const shipping = calculateShipping();
    const tax = calculateTax();
    const discount = calculateDiscount();
    return subtotal + shipping + tax - discount;
  };

  const handleQuantityChange = (itemId, newQuantity) => {
    if (newQuantity <= 0) {
      handleRemoveItem(itemId);
    } else {
      setCartItems(items =>
        items.map(item =>
          item.id === itemId ? { ...item, quantity: newQuantity } : item
        )
      );
    }
  };

  const handleRemoveItem = (itemId) => {
    Alert.alert(
      'Remove Item',
      'Are you sure you want to remove this item from your cart?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Remove',
          style: 'destructive',
          onPress: () => {
            setCartItems(items => items.filter(item => item.id !== itemId));
          },
        },
      ]
    );
  };

  const handleApplyPromo = () => {
    const promo = promoCodes.find(p => p.code === promoCode.toUpperCase());
    if (promo) {
      setAppliedPromo(promo);
      setPromoCode('');
      setShowPromoField(false);
      Alert.alert('Success', 'Promo code applied successfully!');
    } else {
      Alert.alert('Invalid Code', 'The promo code you entered is not valid.');
    }
  };

  const handleRemovePromo = () => {
    setAppliedPromo(null);
  };

  const handleCheckout = () => {
    setIsCheckingOut(true);
    // Simulate checkout process
    setTimeout(() => {
      setIsCheckingOut(false);
      Alert.alert(
        'Order Placed!',
        'Your order has been placed successfully. You will receive a confirmation email shortly.',
        [{ text: 'OK', onPress: () => setShowCheckout(false) }]
      );
    }, 2000);
  };

  const renderCartItem = (item) => (
    <View key={item.id} style={styles.cartItem}>
      <View style={styles.itemImage}>
        <Ionicons name={item.image} size={40} color="#007AFF" />
      </View>
      
      <View style={styles.itemDetails}>
        <Text style={styles.itemName}>{item.name}</Text>
        <Text style={styles.itemCategory}>{item.category}</Text>
        <Text style={styles.itemPrice}>${item.price.toFixed(2)}</Text>
      </View>

      <View style={styles.itemControls}>
        <View style={styles.quantityControls}>
          <TouchableOpacity
            style={styles.quantityButton}
            onPress={() => handleQuantityChange(item.id, item.quantity - 1)}
          >
            <Ionicons name="remove" size={16} color="#666" />
          </TouchableOpacity>
          
          <Text style={styles.quantityText}>{item.quantity}</Text>
          
          <TouchableOpacity
            style={styles.quantityButton}
            onPress={() => handleQuantityChange(item.id, item.quantity + 1)}
          >
            <Ionicons name="add" size={16} color="#666" />
          </TouchableOpacity>
        </View>

        <TouchableOpacity
          style={styles.removeButton}
          onPress={() => handleRemoveItem(item.id)}
        >
          <Ionicons name="trash" size={20} color="#F44336" />
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderPromoSection = () => (
    <View style={styles.promoSection}>
      {!appliedPromo ? (
        <View>
          {!showPromoField ? (
            <TouchableOpacity
              style={styles.promoButton}
              onPress={() => setShowPromoField(true)}
            >
              <Ionicons name="gift" size={20} color="#007AFF" />
              <Text style={styles.promoButtonText}>Add Promo Code</Text>
            </TouchableOpacity>
          ) : (
            <View style={styles.promoInputContainer}>
              <TextInput
                style={styles.promoInput}
                placeholder="Enter promo code"
                value={promoCode}
                onChangeText={setPromoCode}
                placeholderTextColor="#999"
                autoCapitalize="characters"
              />
              <TouchableOpacity
                style={styles.applyButton}
                onPress={handleApplyPromo}
              >
                <Text style={styles.applyButtonText}>Apply</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.cancelButton}
                onPress={() => {
                  setShowPromoField(false);
                  setPromoCode('');
                }}
              >
                <Ionicons name="close" size={20} color="#666" />
              </TouchableOpacity>
            </View>
          )}
        </View>
      ) : (
        <View style={styles.appliedPromo}>
          <View style={styles.appliedPromoInfo}>
            <Ionicons name="checkmark-circle" size={20} color="#4CAF50" />
            <Text style={styles.appliedPromoText}>
              {appliedPromo.code} applied
            </Text>
          </View>
          <TouchableOpacity onPress={handleRemovePromo}>
            <Ionicons name="close" size={20} color="#666" />
          </TouchableOpacity>
        </View>
      )}
    </View>
  );

  const renderOrderSummary = () => (
    <View style={styles.orderSummary}>
      <Text style={styles.summaryTitle}>Order Summary</Text>
      
      <View style={styles.summaryRow}>
        <Text style={styles.summaryLabel}>Subtotal</Text>
        <Text style={styles.summaryValue}>${calculateSubtotal().toFixed(2)}</Text>
      </View>

      <View style={styles.summaryRow}>
        <Text style={styles.summaryLabel}>Shipping</Text>
        <Text style={styles.summaryValue}>${calculateShipping().toFixed(2)}</Text>
      </View>

      <View style={styles.summaryRow}>
        <Text style={styles.summaryLabel}>Tax</Text>
        <Text style={styles.summaryValue}>${calculateTax().toFixed(2)}</Text>
      </View>

      {appliedPromo && (
        <View style={styles.summaryRow}>
          <Text style={[styles.summaryLabel, styles.discountLabel]}>
            Discount ({appliedPromo.code})
          </Text>
          <Text style={[styles.summaryValue, styles.discountValue]}>
            -${calculateDiscount().toFixed(2)}
          </Text>
        </View>
      )}

      <View style={[styles.summaryRow, styles.totalRow]}>
        <Text style={styles.totalLabel}>Total</Text>
        <Text style={styles.totalValue}>${calculateTotal().toFixed(2)}</Text>
      </View>
    </View>
  );

  const renderCheckoutModal = () => (
    <Modal
      visible={showCheckout}
      animationType="slide"
      onRequestClose={() => setShowCheckout(false)}
    >
      <View style={styles.checkoutContainer}>
        <View style={styles.checkoutHeader}>
          <TouchableOpacity onPress={() => setShowCheckout(false)}>
            <Ionicons name="close" size={24} color="#666" />
          </TouchableOpacity>
          <Text style={styles.checkoutTitle}>Checkout</Text>
          <View style={{ width: 24 }} />
        </View>

        <ScrollView style={styles.checkoutContent}>
          <View style={styles.checkoutSection}>
            <Text style={styles.sectionTitle}>Shipping Options</Text>
            {shippingOptions.map((option) => (
              <TouchableOpacity
                key={option.id}
                style={[
                  styles.shippingOption,
                  selectedShipping === option.id && styles.shippingOptionSelected,
                ]}
                onPress={() => setSelectedShipping(option.id)}
              >
                <View style={styles.shippingInfo}>
                  <Text style={styles.shippingName}>{option.name}</Text>
                  <Text style={styles.shippingDays}>{option.days}</Text>
                </View>
                <View style={styles.shippingPrice}>
                  <Text style={styles.shippingPriceText}>${option.price.toFixed(2)}</Text>
                  {selectedShipping === option.id && (
                    <Ionicons name="checkmark-circle" size={20} color="#007AFF" />
                  )}
                </View>
              </TouchableOpacity>
            ))}
          </View>

          <View style={styles.checkoutSection}>
            <Text style={styles.sectionTitle}>Payment Method</Text>
            {paymentMethods.map((method) => (
              <TouchableOpacity
                key={method.id}
                style={[
                  styles.paymentOption,
                  paymentMethod === method.id && styles.paymentOptionSelected,
                ]}
                onPress={() => setPaymentMethod(method.id)}
              >
                <View style={styles.paymentInfo}>
                  <Ionicons name={method.icon} size={24} color="#007AFF" />
                  <Text style={styles.paymentName}>{method.name}</Text>
                </View>
                {paymentMethod === method.id && (
                  <Ionicons name="checkmark-circle" size={20} color="#007AFF" />
                )}
              </TouchableOpacity>
            ))}
          </View>

          {renderOrderSummary()}
        </ScrollView>

        <View style={styles.checkoutFooter}>
          <TouchableOpacity
            style={[styles.checkoutButton, isCheckingOut && styles.checkoutButtonDisabled]}
            onPress={handleCheckout}
            disabled={isCheckingOut}
          >
            {isCheckingOut ? (
              <Text style={styles.checkoutButtonText}>Processing...</Text>
            ) : (
              <Text style={styles.checkoutButtonText}>
                Place Order - ${calculateTotal().toFixed(2)}
              </Text>
            )}
          </TouchableOpacity>
        </View>
      </View>
    </Modal>
  );

  if (cartItems.length === 0) {
    return (
      <View style={styles.emptyContainer}>
        <Ionicons name="cart" size={80} color="#e0e0e0" />
        <Text style={styles.emptyTitle}>Your cart is empty</Text>
        <Text style={styles.emptySubtitle}>
          Add some items to get started
        </Text>
        <TouchableOpacity style={styles.shopButton}>
          <Text style={styles.shopButtonText}>Start Shopping</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Shopping Cart</Text>
        <Text style={styles.headerSubtitle}>
          {cartItems.length} item{cartItems.length !== 1 ? 's' : ''}
        </Text>
      </View>

      <ScrollView style={styles.content}>
        <View style={styles.cartItems}>
          {cartItems.map(renderCartItem)}
        </View>

        {renderPromoSection()}
        {renderOrderSummary()}
      </ScrollView>

      <View style={styles.footer}>
        <TouchableOpacity
          style={styles.checkoutButton}
          onPress={() => setShowCheckout(true)}
        >
          <Text style={styles.checkoutButtonText}>
            Proceed to Checkout - ${calculateTotal().toFixed(2)}
          </Text>
        </TouchableOpacity>
      </View>

      {renderCheckoutModal()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  emptyTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 16,
  },
  emptySubtitle: {
    fontSize: 16,
    color: '#666',
    marginTop: 8,
    textAlign: 'center',
  },
  shopButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 32,
    paddingVertical: 12,
    borderRadius: 8,
    marginTop: 24,
  },
  shopButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  header: {
    backgroundColor: '#fff',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  headerSubtitle: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
  content: {
    flex: 1,
  },
  cartItems: {
    backgroundColor: '#fff',
    marginBottom: 8,
  },
  cartItem: {
    flexDirection: 'row',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  itemImage: {
    width: 60,
    height: 60,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  itemDetails: {
    flex: 1,
    justifyContent: 'center',
  },
  itemName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  itemCategory: {
    fontSize: 14,
    color: '#666',
    marginBottom: 4,
  },
  itemPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  itemControls: {
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  quantityControls: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  quantityButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  quantityText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginHorizontal: 16,
    minWidth: 20,
    textAlign: 'center',
  },
  removeButton: {
    padding: 8,
  },
  promoSection: {
    backgroundColor: '#fff',
    padding: 16,
    marginBottom: 8,
  },
  promoButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  promoButtonText: {
    fontSize: 16,
    color: '#007AFF',
    marginLeft: 8,
    fontWeight: '500',
  },
  promoInputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  promoInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    fontSize: 16,
    marginRight: 8,
  },
  applyButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 8,
    marginRight: 8,
  },
  applyButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
  },
  cancelButton: {
    padding: 8,
  },
  appliedPromo: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#e8f5e8',
    padding: 12,
    borderRadius: 8,
  },
  appliedPromoInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  appliedPromoText: {
    fontSize: 14,
    color: '#4CAF50',
    marginLeft: 8,
    fontWeight: '500',
  },
  orderSummary: {
    backgroundColor: '#fff',
    padding: 16,
  },
  summaryTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  summaryLabel: {
    fontSize: 14,
    color: '#666',
  },
  summaryValue: {
    fontSize: 14,
    color: '#333',
    fontWeight: '500',
  },
  discountLabel: {
    color: '#4CAF50',
  },
  discountValue: {
    color: '#4CAF50',
  },
  totalRow: {
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    paddingTop: 8,
    marginTop: 8,
  },
  totalLabel: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  totalValue: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  footer: {
    backgroundColor: '#fff',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
  checkoutButton: {
    backgroundColor: '#007AFF',
    paddingVertical: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  checkoutButtonDisabled: {
    backgroundColor: '#ccc',
  },
  checkoutButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  checkoutContainer: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  checkoutHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  checkoutTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  checkoutContent: {
    flex: 1,
  },
  checkoutSection: {
    backgroundColor: '#fff',
    marginBottom: 8,
    padding: 16,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  shippingOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  shippingOptionSelected: {
    backgroundColor: '#e3f2fd',
  },
  shippingInfo: {
    flex: 1,
  },
  shippingName: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333',
  },
  shippingDays: {
    fontSize: 14,
    color: '#666',
    marginTop: 2,
  },
  shippingPrice: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  shippingPriceText: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginRight: 8,
  },
  paymentOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  paymentOptionSelected: {
    backgroundColor: '#e3f2fd',
  },
  paymentInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  paymentName: {
    fontSize: 16,
    color: '#333',
    marginLeft: 12,
  },
  checkoutFooter: {
    backgroundColor: '#fff',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
});

export default ShoppingCartSystem;

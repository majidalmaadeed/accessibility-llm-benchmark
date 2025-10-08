'use client';

import { useState } from 'react';
import styles from './ShoppingCartSystem.module.css';

const ShoppingCartSystem = () => {
  const [cartItems, setCartItems] = useState([
    {
      id: 1,
      name: 'Wireless Bluetooth Headphones',
      price: 99.99,
      quantity: 1,
      image: 'https://via.placeholder.com/80x80/4caf50/fff?text=🎧',
      inStock: true,
      maxQuantity: 5
    },
    {
      id: 2,
      name: 'Smart Fitness Watch',
      price: 199.99,
      quantity: 2,
      image: 'https://via.placeholder.com/80x80/2196f3/fff?text=⌚',
      inStock: true,
      maxQuantity: 3
    },
    {
      id: 3,
      name: 'USB-C Charging Cable',
      price: 19.99,
      quantity: 1,
      image: 'https://via.placeholder.com/80x80/ff9800/fff?text=🔌',
      inStock: false,
      maxQuantity: 10
    }
  ]);

  const [promoCode, setPromoCode] = useState('');
  const [appliedPromo, setAppliedPromo] = useState(null);
  const [shippingOption, setShippingOption] = useState('standard');
  const [showPromoForm, setShowPromoForm] = useState(false);
  const [isCheckingOut, setIsCheckingOut] = useState(false);

  const shippingOptions = [
    { id: 'standard', name: 'Standard Shipping', price: 5.99, days: '5-7 business days' },
    { id: 'express', name: 'Express Shipping', price: 12.99, days: '2-3 business days' },
    { id: 'overnight', name: 'Overnight Shipping', price: 24.99, days: 'Next business day' }
  ];

  const promoCodes = {
    'SAVE10': { discount: 0.1, type: 'percentage', description: '10% off your order' },
    'FREESHIP': { discount: 0, type: 'shipping', description: 'Free standard shipping' },
    'WELCOME20': { discount: 20, type: 'fixed', description: '$20 off your order' }
  };

  const updateQuantity = (id, newQuantity) => {
    if (newQuantity < 1) return;
    
    setCartItems(prev => prev.map(item => {
      if (item.id === id) {
        const updatedQuantity = Math.min(newQuantity, item.maxQuantity);
        return { ...item, quantity: updatedQuantity };
      }
      return item;
    }));
  };

  const removeItem = (id) => {
    setCartItems(prev => prev.filter(item => item.id !== id));
  };

  const applyPromoCode = () => {
    const promo = promoCodes[promoCode.toUpperCase()];
    if (promo) {
      setAppliedPromo(promo);
      setPromoCode('');
      setShowPromoForm(false);
    } else {
      alert('Invalid promo code');
    }
  };

  const removePromoCode = () => {
    setAppliedPromo(null);
  };

  const getPromoCodeName = () => {
    return Object.keys(promoCodes).find(code => promoCodes[code] === appliedPromo) || '';
  };

  const calculateSubtotal = () => {
    return cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
  };

  const calculateShipping = () => {
    if (appliedPromo && appliedPromo.type === 'shipping') {
      return 0;
    }
    return shippingOptions.find(option => option.id === shippingOption)?.price || 0;
  };

  const calculateDiscount = () => {
    if (!appliedPromo) return 0;
    
    const subtotal = calculateSubtotal();
    
    switch (appliedPromo.type) {
      case 'percentage':
        return subtotal * appliedPromo.discount;
      case 'fixed':
        return appliedPromo.discount;
      default:
        return 0;
    }
  };

  const calculateTotal = () => {
    const subtotal = calculateSubtotal();
    const shipping = calculateShipping();
    const discount = calculateDiscount();
    return subtotal + shipping - discount;
  };

  const handleCheckout = async () => {
    if (cartItems.length === 0) {
      alert('Your cart is empty');
      return;
    }

    setIsCheckingOut(true);
    
    setTimeout(() => {
      console.log('Checkout completed:', {
        items: cartItems,
        subtotal: calculateSubtotal(),
        shipping: calculateShipping(),
        discount: calculateDiscount(),
        total: calculateTotal(),
        promoCode: appliedPromo
      });
      setIsCheckingOut(false);
      alert('Order placed successfully!');
    }, 2000);
  };

  const getItemTotal = (item) => {
    return item.price * item.quantity;
  };

  const hasOutOfStockItems = () => {
    return cartItems.some(item => !item.inStock);
  };

  const getSelectedShippingOption = () => {
    return shippingOptions.find(option => option.id === shippingOption);
  };

  return (
    <div className={styles.shoppingCart}>
      <div className={styles.cartHeader}>
        <h1>Shopping Cart</h1>
        <div className={styles.cartSummary}>
          {cartItems.length} item{cartItems.length !== 1 ? 's' : ''} in cart
        </div>
      </div>

      {cartItems.length === 0 ? (
        <div className={styles.emptyCart}>
          <div className={styles.emptyCartIcon}>🛒</div>
          <h2>Your cart is empty</h2>
          <p>Add some items to get started</p>
          <button className={styles.continueShoppingBtn}>Continue Shopping</button>
        </div>
      ) : (
        <div className={styles.cartContent}>
          <div className={styles.cartItems}>
            <h2>Items in your cart</h2>
            {cartItems.map((item) => (
              <div key={item.id} className={styles.cartItem}>
                <div className={styles.itemImage}>
                  <img src={item.image} alt={item.name} />
                </div>
                
                <div className={styles.itemDetails}>
                  <h3 className={styles.itemName}>{item.name}</h3>
                  <div className={styles.itemPrice}>${item.price.toFixed(2)}</div>
                  {!item.inStock && (
                    <div className={styles.outOfStock}>Out of Stock</div>
                  )}
                </div>

                <div className={styles.quantityControls}>
                  <button 
                    onClick={() => updateQuantity(item.id, item.quantity - 1)}
                    disabled={item.quantity <= 1}
                    className={styles.quantityBtn}
                  >
                    −
                  </button>
                  <span className={styles.quantityDisplay}>{item.quantity}</span>
                  <button 
                    onClick={() => updateQuantity(item.id, item.quantity + 1)}
                    disabled={item.quantity >= item.maxQuantity}
                    className={styles.quantityBtn}
                  >
                    +
                  </button>
                </div>

                <div className={styles.itemTotal}>
                  ${getItemTotal(item).toFixed(2)}
                </div>

                <button 
                  onClick={() => removeItem(item.id)}
                  className={styles.removeBtn}
                >
                  🗑️
                </button>
              </div>
            ))}
          </div>

          <div className={styles.cartSummarySection}>
            <div className={styles.promoSection}>
              {!appliedPromo ? (
                <div className={styles.promoForm}>
                  {!showPromoForm ? (
                    <button 
                      onClick={() => setShowPromoForm(true)}
                      className={styles.promoToggleBtn}
                    >
                      Have a promo code?
                    </button>
                  ) : (
                    <div className={styles.promoInputGroup}>
                      <input
                        type="text"
                        placeholder="Enter promo code"
                        value={promoCode}
                        onChange={(e) => setPromoCode(e.target.value)}
                        className={styles.promoInput}
                      />
                      <button onClick={applyPromoCode} className={styles.applyBtn}>
                        Apply
                      </button>
                      <button 
                        onClick={() => setShowPromoForm(false)}
                        className={styles.cancelBtn}
                      >
                        Cancel
                      </button>
                    </div>
                  )}
                </div>
              ) : (
                <div className={styles.appliedPromo}>
                  <span className={styles.promoCode}>{getPromoCodeName()}</span>
                  <span className={styles.promoDescription}>{appliedPromo.description}</span>
                  <button onClick={removePromoCode} className={styles.removePromoBtn}>
                    ✕
                  </button>
                </div>
              )}
            </div>

            <div className={styles.shippingSection}>
              <h3>Shipping Options</h3>
              {shippingOptions.map((option) => (
                <label key={option.id} className={styles.shippingOption}>
                  <input
                    type="radio"
                    name="shipping"
                    value={option.id}
                    checked={shippingOption === option.id}
                    onChange={(e) => setShippingOption(e.target.value)}
                  />
                  <div className={styles.shippingDetails}>
                    <div className={styles.shippingName}>{option.name}</div>
                    <div className={styles.shippingInfo}>
                      {option.days} • ${option.price.toFixed(2)}
                    </div>
                  </div>
                </label>
              ))}
            </div>

            <div className={styles.orderSummary}>
              <h3>Order Summary</h3>
              <div className={styles.summaryRow}>
                <span>Subtotal</span>
                <span>${calculateSubtotal().toFixed(2)}</span>
              </div>
              <div className={styles.summaryRow}>
                <span>Shipping</span>
                <span>${calculateShipping().toFixed(2)}</span>
              </div>
              {calculateDiscount() > 0 && (
                <div className={`${styles.summaryRow} ${styles.discount}`}>
                  <span>Discount</span>
                  <span>-${calculateDiscount().toFixed(2)}</span>
                </div>
              )}
              <div className={`${styles.summaryRow} ${styles.total}`}>
                <span>Total</span>
                <span>${calculateTotal().toFixed(2)}</span>
              </div>
            </div>

            <div className={styles.checkoutSection}>
              <button 
                onClick={handleCheckout}
                disabled={isCheckingOut || hasOutOfStockItems()}
                className={styles.checkoutBtn}
              >
                {isCheckingOut ? 'Processing...' : 'Proceed to Checkout'}
              </button>
              
              {hasOutOfStockItems() && (
                <div className={styles.checkoutWarning}>
                  Please remove out-of-stock items before checkout
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ShoppingCartSystem;

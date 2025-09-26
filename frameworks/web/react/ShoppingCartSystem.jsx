import React, { useState, useEffect } from 'react';
import './ShoppingCartSystem.css';

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
    
    // Simulate checkout process
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

  const subtotal = calculateSubtotal();
  const shipping = calculateShipping();
  const discount = calculateDiscount();
  const total = calculateTotal();

  return (
    <div className="shopping-cart">
      <div className="cart-header">
        <h1>Shopping Cart</h1>
        <div className="cart-summary">
          {cartItems.length} item{cartItems.length !== 1 ? 's' : ''} in cart
        </div>
      </div>

      {cartItems.length === 0 ? (
        <div className="empty-cart">
          <div className="empty-cart-icon">🛒</div>
          <h2>Your cart is empty</h2>
          <p>Add some items to get started</p>
          <button className="continue-shopping-btn">Continue Shopping</button>
        </div>
      ) : (
        <div className="cart-content">
          <div className="cart-items">
            <h2>Items in your cart</h2>
            {cartItems.map(item => (
              <div key={item.id} className="cart-item">
                <div className="item-image">
                  <img src={item.image} alt={item.name} />
                </div>
                
                <div className="item-details">
                  <h3 className="item-name">{item.name}</h3>
                  <div className="item-price">${item.price.toFixed(2)}</div>
                  {!item.inStock && (
                    <div className="out-of-stock">Out of Stock</div>
                  )}
                </div>

                <div className="quantity-controls">
                  <button 
                    onClick={() => updateQuantity(item.id, item.quantity - 1)}
                    disabled={item.quantity <= 1}
                    className="quantity-btn"
                  >
                    −
                  </button>
                  <span className="quantity-display">{item.quantity}</span>
                  <button 
                    onClick={() => updateQuantity(item.id, item.quantity + 1)}
                    disabled={item.quantity >= item.maxQuantity}
                    className="quantity-btn"
                  >
                    +
                  </button>
                </div>

                <div className="item-total">
                  ${(item.price * item.quantity).toFixed(2)}
                </div>

                <button 
                  onClick={() => removeItem(item.id)}
                  className="remove-btn"
                >
                  🗑️
                </button>
              </div>
            ))}
          </div>

          <div className="cart-summary-section">
            <div className="promo-section">
              {!appliedPromo ? (
                <div className="promo-form">
                  {!showPromoForm ? (
                    <button 
                      onClick={() => setShowPromoForm(true)}
                      className="promo-toggle-btn"
                    >
                      Have a promo code?
                    </button>
                  ) : (
                    <div className="promo-input-group">
                      <input
                        type="text"
                        placeholder="Enter promo code"
                        value={promoCode}
                        onChange={(e) => setPromoCode(e.target.value)}
                        className="promo-input"
                      />
                      <button onClick={applyPromoCode} className="apply-btn">
                        Apply
                      </button>
                      <button 
                        onClick={() => setShowPromoForm(false)}
                        className="cancel-btn"
                      >
                        Cancel
                      </button>
                    </div>
                  )}
                </div>
              ) : (
                <div className="applied-promo">
                  <span className="promo-code">{Object.keys(promoCodes).find(code => promoCodes[code] === appliedPromo)}</span>
                  <span className="promo-description">{appliedPromo.description}</span>
                  <button onClick={removePromoCode} className="remove-promo-btn">
                    ✕
                  </button>
                </div>
              )}
            </div>

            <div className="shipping-section">
              <h3>Shipping Options</h3>
              {shippingOptions.map(option => (
                <label key={option.id} className="shipping-option">
                  <input
                    type="radio"
                    name="shipping"
                    value={option.id}
                    checked={shippingOption === option.id}
                    onChange={(e) => setShippingOption(e.target.value)}
                  />
                  <div className="shipping-details">
                    <div className="shipping-name">{option.name}</div>
                    <div className="shipping-info">
                      {option.days} • ${option.price.toFixed(2)}
                    </div>
                  </div>
                </label>
              ))}
            </div>

            <div className="order-summary">
              <h3>Order Summary</h3>
              <div className="summary-row">
                <span>Subtotal</span>
                <span>${subtotal.toFixed(2)}</span>
              </div>
              <div className="summary-row">
                <span>Shipping</span>
                <span>${shipping.toFixed(2)}</span>
              </div>
              {discount > 0 && (
                <div className="summary-row discount">
                  <span>Discount</span>
                  <span>-${discount.toFixed(2)}</span>
                </div>
              )}
              <div className="summary-row total">
                <span>Total</span>
                <span>${total.toFixed(2)}</span>
              </div>
            </div>

            <div className="checkout-section">
              <button 
                onClick={handleCheckout}
                disabled={isCheckingOut || cartItems.some(item => !item.inStock)}
                className="checkout-btn"
              >
                {isCheckingOut ? 'Processing...' : 'Proceed to Checkout'}
              </button>
              
              {cartItems.some(item => !item.inStock) && (
                <div className="checkout-warning">
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

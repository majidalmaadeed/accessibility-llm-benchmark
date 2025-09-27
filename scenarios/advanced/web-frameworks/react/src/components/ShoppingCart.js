import React, { useState } from 'react';

const ShoppingCart = () => {
  const [cartItems, setCartItems] = useState([
    { id: 1, name: 'Wireless Headphones', price: 99.99, quantity: 1, image: '🎧' },
    { id: 2, name: 'Smart Watch', price: 199.99, quantity: 1, image: '⌚' },
    { id: 3, name: 'Bluetooth Speaker', price: 79.99, quantity: 2, image: '🔊' },
    { id: 4, name: 'Phone Case', price: 24.99, quantity: 1, image: '📱' }
  ]);

  const [couponCode, setCouponCode] = useState('');
  const [appliedCoupon, setAppliedCoupon] = useState(null);
  const [shippingMethod, setShippingMethod] = useState('standard');
  const [checkoutStep, setCheckoutStep] = useState('cart');

  const updateQuantity = (id, newQuantity) => {
    if (newQuantity <= 0) {
      removeItem(id);
    } else {
      setCartItems(items =>
        items.map(item =>
          item.id === id ? { ...item, quantity: newQuantity } : item
        )
      );
    }
  };

  const removeItem = (id) => {
    setCartItems(items => items.filter(item => item.id !== id));
  };

  const applyCoupon = () => {
    const validCoupons = {
      'SAVE10': { discount: 0.1, description: '10% off' },
      'WELCOME': { discount: 0.15, description: '15% off for new customers' },
      'FREESHIP': { discount: 0, description: 'Free shipping', freeShipping: true }
    };

    if (validCoupons[couponCode]) {
      setAppliedCoupon(validCoupons[couponCode]);
      alert(`Coupon applied: ${validCoupons[couponCode].description}`);
    } else {
      alert('Invalid coupon code');
    }
  };

  const calculateSubtotal = () => {
    return cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
  };

  const calculateTax = () => {
    return calculateSubtotal() * 0.08; // 8% tax
  };

  const calculateShipping = () => {
    if (appliedCoupon?.freeShipping) return 0;
    const subtotal = calculateSubtotal();
    if (subtotal > 100) return 0; // Free shipping over $100
    return shippingMethod === 'express' ? 15.99 : 9.99;
  };

  const calculateDiscount = () => {
    if (!appliedCoupon) return 0;
    return calculateSubtotal() * appliedCoupon.discount;
  };

  const calculateTotal = () => {
    return calculateSubtotal() + calculateTax() + calculateShipping() - calculateDiscount();
  };

  const proceedToCheckout = () => {
    setCheckoutStep('checkout');
  };

  const completeOrder = () => {
    alert('Order completed successfully!');
    setCartItems([]);
    setCheckoutStep('cart');
  };

  if (checkoutStep === 'checkout') {
    return (
      <div className="container">
        <div className="page-header">
          <h1 className="page-title">Checkout</h1>
          <p className="page-subtitle">Complete your order</p>
        </div>

        <div className="grid grid-2">
          <div className="card">
            <h2>Shipping Information</h2>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">First Name</label>
                <input type="text" className="form-control" />
              </div>
              <div className="form-group">
                <label className="form-label">Last Name</label>
                <input type="text" className="form-control" />
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Address</label>
              <input type="text" className="form-control" />
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">City</label>
                <input type="text" className="form-control" />
              </div>
              <div className="form-group">
                <label className="form-label">State</label>
                <input type="text" className="form-control" />
              </div>
              <div className="form-group">
                <label className="form-label">ZIP Code</label>
                <input type="text" className="form-control" />
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Phone</label>
              <input type="tel" className="form-control" />
            </div>
          </div>

          <div className="card">
            <h2>Payment Information</h2>
            <div className="form-group">
              <label className="form-label">Card Number</label>
              <input type="text" className="form-control" placeholder="1234 5678 9012 3456" />
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Expiry Date</label>
                <input type="text" className="form-control" placeholder="MM/YY" />
              </div>
              <div className="form-group">
                <label className="form-label">CVV</label>
                <input type="text" className="form-control" placeholder="123" />
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Name on Card</label>
              <input type="text" className="form-control" />
            </div>
          </div>
        </div>

        <div className="card">
          <h2>Order Summary</h2>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
            <span>Subtotal:</span>
            <span>${calculateSubtotal().toFixed(2)}</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
            <span>Tax:</span>
            <span>${calculateTax().toFixed(2)}</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
            <span>Shipping:</span>
            <span>${calculateShipping().toFixed(2)}</span>
          </div>
          {appliedCoupon && (
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem', color: '#28a745' }}>
              <span>Discount ({appliedCoupon.description}):</span>
              <span>-${calculateDiscount().toFixed(2)}</span>
            </div>
          )}
          <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '1.2rem', fontWeight: 'bold', borderTop: '1px solid #eee', paddingTop: '1rem' }}>
            <span>Total:</span>
            <span>${calculateTotal().toFixed(2)}</span>
          </div>
        </div>

        <div className="form-actions">
          <button className="btn btn-secondary" onClick={() => setCheckoutStep('cart')}>
            Back to Cart
          </button>
          <button className="btn" onClick={completeOrder}>
            Complete Order
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Shopping Cart System</h1>
        <p className="page-subtitle">
          E-commerce shopping cart system
        </p>
      </div>

      <div className="grid grid-2">
        <div className="card">
          <h2>Shopping Cart</h2>
          {cartItems.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2rem', color: '#666' }}>
              <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🛒</div>
              <p>Your cart is empty</p>
            </div>
          ) : (
            <div>
              {cartItems.map(item => (
                <div key={item.id} className="cart-item">
                  <div style={{ fontSize: '2rem', marginRight: '1rem' }}>
                    {item.image}
                  </div>
                  <div className="cart-item-info">
                    <div className="cart-item-name">{item.name}</div>
                    <div className="cart-item-price">${item.price.toFixed(2)} each</div>
                  </div>
                  <div className="cart-item-controls">
                    <div className="quantity-controls">
                      <button
                        className="quantity-btn"
                        onClick={() => updateQuantity(item.id, item.quantity - 1)}
                      >
                        -
                      </button>
                      <input
                        type="number"
                        className="quantity-input"
                        value={item.quantity}
                        onChange={(e) => updateQuantity(item.id, parseInt(e.target.value) || 0)}
                        min="0"
                      />
                      <button
                        className="quantity-btn"
                        onClick={() => updateQuantity(item.id, item.quantity + 1)}
                      >
                        +
                      </button>
                    </div>
                    <button
                      className="btn btn-secondary"
                      onClick={() => removeItem(item.id)}
                      style={{ marginLeft: '1rem' }}
                    >
                      Remove
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="card">
          <h2>Order Summary</h2>
          <div style={{ marginBottom: '1rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
              <span>Subtotal ({cartItems.reduce((total, item) => total + item.quantity, 0)} items):</span>
              <span>${calculateSubtotal().toFixed(2)}</span>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
              <span>Tax:</span>
              <span>${calculateTax().toFixed(2)}</span>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
              <span>Shipping:</span>
              <span>${calculateShipping().toFixed(2)}</span>
            </div>
            {appliedCoupon && (
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem', color: '#28a745' }}>
                <span>Discount ({appliedCoupon.description}):</span>
                <span>-${calculateDiscount().toFixed(2)}</span>
              </div>
            )}
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '1.2rem', fontWeight: 'bold', borderTop: '1px solid #eee', paddingTop: '0.5rem' }}>
              <span>Total:</span>
              <span>${calculateTotal().toFixed(2)}</span>
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Coupon Code</label>
            <div style={{ display: 'flex', gap: '0.5rem' }}>
              <input
                type="text"
                className="form-control"
                value={couponCode}
                onChange={(e) => setCouponCode(e.target.value)}
                placeholder="Enter coupon code"
              />
              <button className="btn" onClick={applyCoupon}>
                Apply
              </button>
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Shipping Method</label>
            <select
              className="form-control"
              value={shippingMethod}
              onChange={(e) => setShippingMethod(e.target.value)}
            >
              <option value="standard">Standard (5-7 days) - $9.99</option>
              <option value="express">Express (2-3 days) - $15.99</option>
            </select>
          </div>

          <button
            className="btn"
            onClick={proceedToCheckout}
            disabled={cartItems.length === 0}
            style={{ width: '100%', marginTop: '1rem' }}
          >
            Proceed to Checkout
          </button>
        </div>
      </div>

      <div className="card">
        <h2>Recommended Products</h2>
        <div className="grid grid-4">
          {[
            { name: 'Laptop Stand', price: 49.99, image: '💻' },
            { name: 'Wireless Mouse', price: 29.99, image: '🖱️' },
            { name: 'USB Cable', price: 12.99, image: '🔌' },
            { name: 'Screen Cleaner', price: 8.99, image: '🧽' }
          ].map((product, index) => (
            <div key={index} style={{ textAlign: 'center', padding: '1rem', border: '1px solid #eee', borderRadius: '8px' }}>
              <div style={{ fontSize: '2rem', marginBottom: '0.5rem' }}>{product.image}</div>
              <div style={{ fontWeight: '600', marginBottom: '0.25rem' }}>{product.name}</div>
              <div style={{ color: '#666', marginBottom: '0.5rem' }}>${product.price}</div>
              <button className="btn" style={{ width: '100%' }}>
                Add to Cart
              </button>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default ShoppingCart;

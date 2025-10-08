<template>
  <div class="shopping-cart">
    <div class="cart-header">
      <h1>Shopping Cart</h1>
      <div class="cart-summary">
        {{ cartItems.length }} item{{ cartItems.length !== 1 ? 's' : '' }} in cart
      </div>
    </div>

    <div v-if="cartItems.length === 0" class="empty-cart">
      <div class="empty-cart-icon">🛒</div>
      <h2>Your cart is empty</h2>
      <p>Add some items to get started</p>
      <button class="continue-shopping-btn">Continue Shopping</button>
    </div>

    <div v-else class="cart-content">
      <div class="cart-items">
        <h2>Items in your cart</h2>
        <div 
          v-for="item in cartItems" 
          :key="item.id" 
          class="cart-item"
        >
          <div class="item-image">
            <img :src="item.image" :alt="item.name" />
          </div>
          
          <div class="item-details">
            <h3 class="item-name">{{ item.name }}</h3>
            <div class="item-price">${{ item.price.toFixed(2) }}</div>
            <div v-if="!item.inStock" class="out-of-stock">Out of Stock</div>
          </div>

          <div class="quantity-controls">
            <button 
              @click="updateQuantity(item.id, item.quantity - 1)"
              :disabled="item.quantity <= 1"
              class="quantity-btn"
            >
              −
            </button>
            <span class="quantity-display">{{ item.quantity }}</span>
            <button 
              @click="updateQuantity(item.id, item.quantity + 1)"
              :disabled="item.quantity >= item.maxQuantity"
              class="quantity-btn"
            >
              +
            </button>
          </div>

          <div class="item-total">
            ${{ (item.price * item.quantity).toFixed(2) }}
          </div>

          <button 
            @click="removeItem(item.id)"
            class="remove-btn"
          >
            🗑️
          </button>
        </div>
      </div>

      <div class="cart-summary-section">
        <div class="promo-section">
          <div v-if="!appliedPromo" class="promo-form">
            <button 
              v-if="!showPromoForm"
              @click="showPromoForm = true"
              class="promo-toggle-btn"
            >
              Have a promo code?
            </button>
            <div v-else class="promo-input-group">
              <input
                type="text"
                placeholder="Enter promo code"
                v-model="promoCode"
                class="promo-input"
              />
              <button @click="applyPromoCode" class="apply-btn">
                Apply
              </button>
              <button 
                @click="showPromoForm = false"
                class="cancel-btn"
              >
                Cancel
              </button>
            </div>
          </div>
          <div v-else class="applied-promo">
            <span class="promo-code">{{ getPromoCodeName() }}</span>
            <span class="promo-description">{{ appliedPromo.description }}</span>
            <button @click="removePromoCode" class="remove-promo-btn">
              ✕
            </button>
          </div>
        </div>

        <div class="shipping-section">
          <h3>Shipping Options</h3>
          <label 
            v-for="option in shippingOptions" 
            :key="option.id" 
            class="shipping-option"
          >
            <input
              type="radio"
              name="shipping"
              :value="option.id"
              v-model="shippingOption"
            />
            <div class="shipping-details">
              <div class="shipping-name">{{ option.name }}</div>
              <div class="shipping-info">
                {{ option.days }} • ${{ option.price.toFixed(2) }}
              </div>
            </div>
          </label>
        </div>

        <div class="order-summary">
          <h3>Order Summary</h3>
          <div class="summary-row">
            <span>Subtotal</span>
            <span>${{ calculateSubtotal().toFixed(2) }}</span>
          </div>
          <div class="summary-row">
            <span>Shipping</span>
            <span>${{ calculateShipping().toFixed(2) }}</span>
          </div>
          <div v-if="calculateDiscount() > 0" class="summary-row discount">
            <span>Discount</span>
            <span>-${{ calculateDiscount().toFixed(2) }}</span>
          </div>
          <div class="summary-row total">
            <span>Total</span>
            <span>${{ calculateTotal().toFixed(2) }}</span>
          </div>
        </div>

        <div class="checkout-section">
          <button 
            @click="handleCheckout"
            :disabled="isCheckingOut || cartItems.some(item => !item.inStock)"
            class="checkout-btn"
          >
            {{ isCheckingOut ? 'Processing...' : 'Proceed to Checkout' }}
          </button>
          
          <div v-if="cartItems.some(item => !item.inStock)" class="checkout-warning">
            Please remove out-of-stock items before checkout
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ShoppingCartSystem',
  data() {
    return {
      cartItems: [
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
      ],
      promoCode: '',
      appliedPromo: null,
      shippingOption: 'standard',
      showPromoForm: false,
      isCheckingOut: false,
      shippingOptions: [
        { id: 'standard', name: 'Standard Shipping', price: 5.99, days: '5-7 business days' },
        { id: 'express', name: 'Express Shipping', price: 12.99, days: '2-3 business days' },
        { id: 'overnight', name: 'Overnight Shipping', price: 24.99, days: 'Next business day' }
      ],
      promoCodes: {
        'SAVE10': { discount: 0.1, type: 'percentage', description: '10% off your order' },
        'FREESHIP': { discount: 0, type: 'shipping', description: 'Free standard shipping' },
        'WELCOME20': { discount: 20, type: 'fixed', description: '$20 off your order' }
      }
    }
  },
  methods: {
    updateQuantity(id, newQuantity) {
      if (newQuantity < 1) return;
      
      this.cartItems = this.cartItems.map(item => {
        if (item.id === id) {
          const updatedQuantity = Math.min(newQuantity, item.maxQuantity);
          return { ...item, quantity: updatedQuantity };
        }
        return item;
      });
    },
    removeItem(id) {
      this.cartItems = this.cartItems.filter(item => item.id !== id);
    },
    applyPromoCode() {
      const promo = this.promoCodes[this.promoCode.toUpperCase()];
      if (promo) {
        this.appliedPromo = promo;
        this.promoCode = '';
        this.showPromoForm = false;
      } else {
        alert('Invalid promo code');
      }
    },
    removePromoCode() {
      this.appliedPromo = null;
    },
    getPromoCodeName() {
      return Object.keys(this.promoCodes).find(code => this.promoCodes[code] === this.appliedPromo);
    },
    calculateSubtotal() {
      return this.cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
    },
    calculateShipping() {
      if (this.appliedPromo && this.appliedPromo.type === 'shipping') {
        return 0;
      }
      return this.shippingOptions.find(option => option.id === this.shippingOption)?.price || 0;
    },
    calculateDiscount() {
      if (!this.appliedPromo) return 0;
      
      const subtotal = this.calculateSubtotal();
      
      switch (this.appliedPromo.type) {
        case 'percentage':
          return subtotal * this.appliedPromo.discount;
        case 'fixed':
          return this.appliedPromo.discount;
        default:
          return 0;
      }
    },
    calculateTotal() {
      const subtotal = this.calculateSubtotal();
      const shipping = this.calculateShipping();
      const discount = this.calculateDiscount();
      return subtotal + shipping - discount;
    },
    async handleCheckout() {
      if (this.cartItems.length === 0) {
        alert('Your cart is empty');
        return;
      }

      this.isCheckingOut = true;
      
      // Simulate checkout process
      setTimeout(() => {
        console.log('Checkout completed:', {
          items: this.cartItems,
          subtotal: this.calculateSubtotal(),
          shipping: this.calculateShipping(),
          discount: this.calculateDiscount(),
          total: this.calculateTotal(),
          promoCode: this.appliedPromo
        });
        this.isCheckingOut = false;
        alert('Order placed successfully!');
      }, 2000);
    }
  }
}
</script>

<style scoped>
.shopping-cart {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.cart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.cart-header h1 {
  margin: 0;
  color: #333;
  font-size: 28px;
}

.cart-summary {
  color: #666;
  font-size: 14px;
}

.empty-cart {
  text-align: center;
  padding: 60px 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.empty-cart-icon {
  font-size: 64px;
  margin-bottom: 20px;
}

.empty-cart h2 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 24px;
}

.empty-cart p {
  margin: 0 0 30px 0;
  color: #666;
  font-size: 16px;
}

.continue-shopping-btn {
  padding: 12px 24px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.continue-shopping-btn:hover {
  background: #45a049;
}

.cart-content {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 30px;
}

.cart-items h2 {
  margin: 0 0 20px 0;
  color: #333;
  font-size: 20px;
}

.cart-item {
  display: grid;
  grid-template-columns: 80px 1fr auto auto auto;
  gap: 15px;
  align-items: center;
  padding: 20px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 15px;
  transition: box-shadow 0.3s ease;
}

.cart-item:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.item-image img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
}

.item-details {
  min-width: 0;
}

.item-name {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 16px;
  font-weight: 600;
  line-height: 1.3;
}

.item-price {
  color: #666;
  font-size: 14px;
  font-weight: 500;
}

.out-of-stock {
  color: #f44336;
  font-size: 12px;
  font-weight: 600;
  margin-top: 4px;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #f8f9fa;
  border-radius: 6px;
  padding: 4px;
}

.quantity-btn {
  width: 32px;
  height: 32px;
  border: none;
  background: white;
  color: #333;
  cursor: pointer;
  border-radius: 4px;
  font-size: 16px;
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease;
}

.quantity-btn:hover:not(:disabled) {
  background: #e9ecef;
}

.quantity-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.quantity-display {
  min-width: 40px;
  text-align: center;
  font-weight: 600;
  color: #333;
}

.item-total {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  text-align: right;
}

.remove-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

.remove-btn:hover {
  background: #f5f5f5;
}

.cart-summary-section {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 25px;
  height: fit-content;
}

.promo-section {
  margin-bottom: 25px;
}

.promo-toggle-btn {
  width: 100%;
  padding: 12px;
  background: white;
  border: 2px dashed #4caf50;
  color: #4caf50;
  cursor: pointer;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.promo-toggle-btn:hover {
  background: #4caf50;
  color: white;
}

.promo-input-group {
  display: flex;
  gap: 8px;
}

.promo-input {
  flex: 1;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.promo-input:focus {
  outline: none;
  border-color: #4caf50;
}

.apply-btn,
.cancel-btn {
  padding: 10px 16px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.apply-btn {
  background: #4caf50;
  color: white;
}

.apply-btn:hover {
  background: #45a049;
}

.cancel-btn {
  background: #f5f5f5;
  color: #666;
}

.cancel-btn:hover {
  background: #e0e0e0;
}

.applied-promo {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px;
  background: #e8f5e8;
  border: 1px solid #4caf50;
  border-radius: 6px;
}

.promo-code {
  font-weight: 600;
  color: #2e7d32;
}

.promo-description {
  flex: 1;
  color: #2e7d32;
  font-size: 14px;
}

.remove-promo-btn {
  background: none;
  border: none;
  color: #2e7d32;
  cursor: pointer;
  font-size: 16px;
  padding: 4px;
  border-radius: 3px;
  transition: background-color 0.3s ease;
}

.remove-promo-btn:hover {
  background: rgba(46, 125, 50, 0.1);
}

.shipping-section {
  margin-bottom: 25px;
}

.shipping-section h3 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 16px;
}

.shipping-option {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.shipping-option:hover {
  border-color: #4caf50;
}

.shipping-option input[type="radio"] {
  margin: 0;
}

.shipping-option input[type="radio"]:checked + .shipping-details {
  color: #4caf50;
}

.shipping-details {
  flex: 1;
}

.shipping-name {
  font-weight: 600;
  color: #333;
  margin-bottom: 2px;
}

.shipping-info {
  font-size: 12px;
  color: #666;
}

.order-summary {
  margin-bottom: 25px;
}

.order-summary h3 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 16px;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #e0e0e0;
}

.summary-row:last-child {
  border-bottom: none;
}

.summary-row.discount {
  color: #4caf50;
  font-weight: 600;
}

.summary-row.total {
  font-size: 18px;
  font-weight: 700;
  color: #333;
  border-top: 2px solid #e0e0e0;
  margin-top: 8px;
  padding-top: 12px;
}

.checkout-section {
  text-align: center;
}

.checkout-btn {
  width: 100%;
  padding: 16px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-bottom: 10px;
}

.checkout-btn:hover:not(:disabled) {
  background: #45a049;
}

.checkout-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.checkout-warning {
  color: #f44336;
  font-size: 12px;
  font-weight: 500;
}

@media (max-width: 968px) {
  .cart-content {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .cart-summary-section {
    order: -1;
  }
}

@media (max-width: 768px) {
  .shopping-cart {
    padding: 15px;
  }
  
  .cart-header {
    flex-direction: column;
    gap: 10px;
    align-items: stretch;
  }
  
  .cart-item {
    grid-template-columns: 60px 1fr;
    gap: 10px;
    padding: 15px;
  }
  
  .item-image img {
    width: 60px;
    height: 60px;
  }
  
  .quantity-controls,
  .item-total,
  .remove-btn {
    grid-column: 1 / -1;
    justify-self: start;
  }
  
  .quantity-controls {
    justify-self: center;
  }
  
  .item-total {
    justify-self: end;
  }
  
  .remove-btn {
    justify-self: end;
  }
  
  .promo-input-group {
    flex-direction: column;
  }
  
  .apply-btn,
  .cancel-btn {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .cart-item {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .item-image {
    justify-self: center;
  }
  
  .quantity-controls,
  .item-total,
  .remove-btn {
    justify-self: center;
  }
}
</style>

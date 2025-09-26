<template>
  <div class="shopping-cart">
    <div class="cart-header">
      <h1>Shopping Cart</h1>
      <div class="cart-actions">
        <button 
          @click="clearCart"
          :disabled="cartItems.length === 0"
          class="clear-cart-btn"
        >
          Clear Cart
        </button>
      </div>
    </div>

    <div class="cart-content">
      <div class="cart-items">
        <div v-if="cartItems.length === 0" class="empty-cart">
          <div class="empty-icon">🛒</div>
          <h3>Your cart is empty</h3>
          <p>Add some items to get started</p>
        </div>
        <div v-else class="items-list">
          <div 
            v-for="item in cartItems"
            :key="item.id"
            class="cart-item"
          >
            <div class="item-image">
              <img :src="item.image" :alt="item.name" />
            </div>
            
            <div class="item-details">
              <h4 class="item-name">{{ item.name }}</h4>
              <p class="item-category">{{ item.category }}</p>
              <p class="item-price">{{ formatPrice(item.price) }} each</p>
              
              <span v-if="!item.inStock" class="out-of-stock">Out of Stock</span>
            </div>
            
            <div class="item-controls">
              <div class="quantity-controls">
                <button 
                  @click="updateQuantity(item.id, item.quantity - 1)"
                  :disabled="item.quantity <= 1"
                  class="quantity-btn"
                >
                  −
                </button>
                <input
                  v-model.number="item.quantity"
                  @change="updateQuantity(item.id, item.quantity)"
                  type="number"
                  min="1"
                  :max="item.stockCount"
                  class="quantity-input"
                />
                <button 
                  @click="updateQuantity(item.id, item.quantity + 1)"
                  :disabled="item.quantity >= item.stockCount"
                  class="quantity-btn"
                >
                  +
                </button>
              </div>
              
              <div class="item-total">
                {{ formatPrice(getItemTotal(item)) }}
              </div>
              
              <button 
                @click="removeFromCart(item.id)"
                class="remove-btn"
              >
                Remove
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="cart-summary">
        <div class="summary-section">
          <h3>Order Summary</h3>
          
          <div class="summary-row">
            <span>Subtotal ({{ cartItems.length }} item{{ cartItems.length !== 1 ? 's' : '' }})</span>
            <span>{{ formatPrice(calculateSubtotal()) }}</span>
          </div>

          <div v-if="promoApplied && calculateDiscount() > 0" class="summary-row discount">
            <span>Discount ({{ promoCode }})</span>
            <span>-{{ formatPrice(calculateDiscount()) }}</span>
          </div>

          <div class="summary-row">
            <span>Shipping</span>
            <span>{{ formatPrice(calculateShipping()) }}</span>
          </div>

          <div class="summary-row">
            <span>Tax</span>
            <span>{{ formatPrice(calculateTax()) }}</span>
          </div>

          <div class="summary-row total">
            <span>Total</span>
            <span>{{ formatPrice(calculateTotal()) }}</span>
          </div>
        </div>

        <div class="promo-section">
          <div class="promo-header">
            <h4>Promo Code</h4>
            <button 
              v-if="!promoApplied"
              @click="showPromoForm = !showPromoForm"
              class="promo-toggle"
            >
              {{ showPromoForm ? 'Cancel' : 'Add Code' }}
            </button>
          </div>

          <div v-if="showPromoForm && !promoApplied" class="promo-form">
            <input
              v-model="promoCode"
              type="text"
              placeholder="Enter promo code"
              class="promo-input"
            />
            <button 
              @click="applyPromoCode"
              :disabled="!promoCode.trim()"
              class="apply-promo-btn"
            >
              Apply
            </button>
          </div>

          <div v-if="promoMessage" class="promo-message" :class="{ error: !promoApplied }">
            {{ promoMessage }}
          </div>

          <div v-if="promoApplied" class="applied-promo">
            <span>Applied: {{ promoCode }}</span>
            <button 
              @click="removePromoCode"
              class="remove-promo-btn"
            >
              Remove
            </button>
          </div>
        </div>

        <div class="shipping-section">
          <h4>Shipping Options</h4>
          <div class="shipping-options">
            <label 
              v-for="option in shippingOptions"
              :key="option.value"
              class="shipping-option"
            >
              <input
                v-model="shippingOption"
                type="radio"
                :value="option.value"
                name="shipping"
              />
              <div class="shipping-info">
                <div class="shipping-label">{{ option.label }}</div>
                <div class="shipping-details">
                  {{ option.days }} • {{ formatPrice(option.price) }}
                </div>
              </div>
            </label>
          </div>
        </div>

        <div class="checkout-section">
          <button 
            @click="handleCheckout"
            :disabled="cartItems.length === 0 || isCheckingOut"
            class="checkout-btn"
          >
            {{ isCheckingOut ? 'Processing...' : `Checkout ${formatPrice(calculateTotal())}` }}
          </button>
          
          <div class="checkout-info">
            <p>Secure checkout with SSL encryption</p>
            <p>We accept Visa, MasterCard, American Express</p>
          </div>
        </div>
      </div>
    </div>

    <div class="product-suggestions">
      <h3>You might also like</h3>
      <div class="suggestions-grid">
        <div 
          v-for="product in sampleProducts.slice(0, 3)"
          :key="product.id"
          class="suggestion-item"
        >
          <img :src="product.image" :alt="product.name" />
          <h4>{{ product.name }}</h4>
          <p class="suggestion-price">{{ formatPrice(product.price) }}</p>
          <button 
            @click="addToCart(product)"
            :disabled="!product.inStock"
            class="add-to-cart-btn"
          >
            {{ product.inStock ? 'Add to Cart' : 'Out of Stock' }}
          </button>
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
      cartItems: [],
      promoCode: '',
      shippingOption: 'standard',
      isCheckingOut: false,
      showPromoForm: false,
      promoApplied: false,
      promoDiscount: 0,
      promoMessage: '',
      sampleProducts: [
        {
          id: 1,
          name: 'Wireless Headphones',
          price: 99.99,
          image: 'https://via.placeholder.com/80x80/4caf50/fff?text=WH',
          category: 'Electronics',
          inStock: true,
          stockCount: 15
        },
        {
          id: 2,
          name: 'Smart Watch',
          price: 199.99,
          image: 'https://via.placeholder.com/80x80/2196f3/fff?text=SW',
          category: 'Electronics',
          inStock: true,
          stockCount: 8
        },
        {
          id: 3,
          name: 'Laptop Stand',
          price: 49.99,
          image: 'https://via.placeholder.com/80x80/ff9800/fff?text=LS',
          category: 'Accessories',
          inStock: true,
          stockCount: 25
        },
        {
          id: 4,
          name: 'Bluetooth Speaker',
          price: 79.99,
          image: 'https://via.placeholder.com/80x80/9c27b0/fff?text=BS',
          category: 'Electronics',
          inStock: false,
          stockCount: 0
        },
        {
          id: 5,
          name: 'Phone Case',
          price: 24.99,
          image: 'https://via.placeholder.com/80x80/f44336/fff?text=PC',
          category: 'Accessories',
          inStock: true,
          stockCount: 50
        }
      ],
      shippingOptions: [
        { value: 'standard', label: 'Standard Shipping', price: 5.99, days: '5-7 business days' },
        { value: 'express', label: 'Express Shipping', price: 12.99, days: '2-3 business days' },
        { value: 'overnight', label: 'Overnight Shipping', price: 24.99, days: '1 business day' }
      ],
      promoCodes: {
        'SAVE10': { discount: 0.1, type: 'percentage', description: '10% off your order' },
        'WELCOME20': { discount: 20, type: 'fixed', description: '$20 off your order' },
        'FREESHIP': { discount: 0, type: 'shipping', description: 'Free shipping on your order' }
      }
    }
  },
  mounted() {
    this.loadCartFromStorage()
  },
  methods: {
    loadCartFromStorage() {
      const saved = localStorage.getItem('shoppingCart')
      if (saved) {
        this.cartItems = JSON.parse(saved)
      }
    },
    saveCartToStorage() {
      localStorage.setItem('shoppingCart', JSON.stringify(this.cartItems))
    },
    addToCart(product) {
      const existingItem = this.cartItems.find(item => item.id === product.id)
      
      if (existingItem) {
        if (existingItem.quantity < product.stockCount) {
          existingItem.quantity += 1
        } else {
          alert('Not enough stock available')
          return
        }
      } else {
        this.cartItems = [...this.cartItems, { ...product, quantity: 1 }]
      }
      
      this.saveCartToStorage()
    },
    removeFromCart(productId) {
      this.cartItems = this.cartItems.filter(item => item.id !== productId)
      this.saveCartToStorage()
    },
    updateQuantity(productId, newQuantity) {
      if (newQuantity <= 0) {
        this.removeFromCart(productId)
        return
      }

      const product = this.sampleProducts.find(p => p.id === productId)
      if (product && newQuantity > product.stockCount) {
        alert('Not enough stock available')
        return
      }

      this.cartItems = this.cartItems.map(item => 
        item.id === productId ? { ...item, quantity: newQuantity } : item
      )
      this.saveCartToStorage()
    },
    applyPromoCode() {
      const code = this.promoCode.toUpperCase()
      const promo = this.promoCodes[code]
      
      if (promo) {
        this.promoApplied = true
        this.promoDiscount = promo.discount
        this.promoMessage = `Promo code applied: ${promo.description}`
      } else {
        this.promoMessage = 'Invalid promo code'
      }
    },
    removePromoCode() {
      this.promoCode = ''
      this.promoApplied = false
      this.promoDiscount = 0
      this.promoMessage = ''
    },
    calculateSubtotal() {
      return this.cartItems.reduce((total, item) => total + (item.price * item.quantity), 0)
    },
    calculateShipping() {
      if (this.promoApplied && this.promoCodes[this.promoCode.toUpperCase()]?.type === 'shipping') {
        return 0
      }
      const option = this.shippingOptions.find(opt => opt.value === this.shippingOption)
      return option ? option.price : 0
    },
    calculateDiscount() {
      if (!this.promoApplied) return 0
      
      const promo = this.promoCodes[this.promoCode.toUpperCase()]
      if (promo.type === 'percentage') {
        return this.calculateSubtotal() * promo.discount
      } else if (promo.type === 'fixed') {
        return Math.min(promo.discount, this.calculateSubtotal())
      }
      return 0
    },
    calculateTax() {
      const subtotal = this.calculateSubtotal() - this.calculateDiscount()
      return subtotal * 0.08
    },
    calculateTotal() {
      const subtotal = this.calculateSubtotal()
      const discount = this.calculateDiscount()
      const shipping = this.calculateShipping()
      const tax = this.calculateTax()
      
      return subtotal - discount + shipping + tax
    },
    getItemTotal(item) {
      return item.price * item.quantity
    },
    formatPrice(price) {
      return `$${price.toFixed(2)}`
    },
    handleCheckout() {
      if (this.cartItems.length === 0) {
        alert('Your cart is empty')
        return
      }

      this.isCheckingOut = true
      
      setTimeout(() => {
        console.log('Checkout completed:', {
          items: this.cartItems,
          subtotal: this.calculateSubtotal(),
          discount: this.calculateDiscount(),
          shipping: this.calculateShipping(),
          tax: this.calculateTax(),
          total: this.calculateTotal()
        })
        
        this.cartItems = []
        this.promoCode = ''
        this.promoApplied = false
        this.promoDiscount = 0
        this.promoMessage = ''
        this.isCheckingOut = false
        this.saveCartToStorage()
        
        alert('Order placed successfully!')
      }, 2000)
    },
    clearCart() {
      this.cartItems = []
      this.saveCartToStorage()
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

.clear-cart-btn {
  padding: 8px 16px;
  background: #f44336;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.clear-cart-btn:hover:not(:disabled) {
  background: #d32f2f;
}

.clear-cart-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.cart-content {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 30px;
  margin-bottom: 40px;
}

.cart-items {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
}

.empty-cart {
  text-align: center;
  padding: 60px 20px;
  color: #666;
}

.empty-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.empty-cart h3 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 20px;
}

.empty-cart p {
  margin: 0;
  font-size: 14px;
}

.items-list {
  padding: 20px;
}

.cart-item {
  display: flex;
  gap: 15px;
  padding: 20px 0;
  border-bottom: 1px solid #f0f0f0;
}

.cart-item:last-child {
  border-bottom: none;
}

.item-image img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
}

.item-details {
  flex: 1;
}

.item-name {
  margin: 0 0 5px 0;
  color: #333;
  font-size: 16px;
  font-weight: 600;
}

.item-category {
  margin: 0 0 5px 0;
  color: #666;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.item-price {
  margin: 0 0 5px 0;
  color: #666;
  font-size: 14px;
}

.out-of-stock {
  color: #f44336;
  font-size: 12px;
  font-weight: 600;
}

.item-controls {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 10px;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 5px;
}

.quantity-btn {
  width: 30px;
  height: 30px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 16px;
  font-weight: bold;
  transition: all 0.3s ease;
}

.quantity-btn:hover:not(:disabled) {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.quantity-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.quantity-input {
  width: 50px;
  height: 30px;
  border: 1px solid #ddd;
  border-radius: 4px;
  text-align: center;
  font-size: 14px;
}

.quantity-input:focus {
  outline: none;
  border-color: #4caf50;
}

.item-total {
  font-size: 16px;
  font-weight: bold;
  color: #333;
}

.remove-btn {
  padding: 4px 8px;
  background: #f44336;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  transition: background-color 0.3s ease;
}

.remove-btn:hover {
  background: #d32f2f;
}

.cart-summary {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  height: fit-content;
}

.summary-section {
  margin-bottom: 25px;
}

.summary-section h3 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 18px;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  font-size: 14px;
}

.summary-row.discount {
  color: #4caf50;
  font-weight: 600;
}

.summary-row.total {
  border-top: 2px solid #e0e0e0;
  padding-top: 15px;
  margin-top: 10px;
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.promo-section {
  margin-bottom: 25px;
  padding: 15px;
  background: white;
  border-radius: 6px;
  border: 1px solid #e0e0e0;
}

.promo-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.promo-header h4 {
  margin: 0;
  color: #333;
  font-size: 14px;
}

.promo-toggle {
  background: none;
  border: none;
  color: #4caf50;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
}

.promo-form {
  display: flex;
  gap: 8px;
}

.promo-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.promo-input:focus {
  outline: none;
  border-color: #4caf50;
}

.apply-promo-btn {
  padding: 8px 16px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.apply-promo-btn:hover:not(:disabled) {
  background: #45a049;
}

.apply-promo-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.promo-message {
  margin-top: 8px;
  padding: 6px 8px;
  border-radius: 4px;
  font-size: 12px;
  background: #e8f5e8;
  color: #4caf50;
}

.promo-message.error {
  background: #ffebee;
  color: #f44336;
}

.applied-promo {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px;
  background: #e8f5e8;
  border-radius: 4px;
  font-size: 12px;
  color: #4caf50;
}

.remove-promo-btn {
  background: none;
  border: none;
  color: #f44336;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
}

.shipping-section {
  margin-bottom: 25px;
}

.shipping-section h4 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 14px;
}

.shipping-options {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.shipping-option {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  padding: 10px;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.shipping-option:hover {
  border-color: #4caf50;
  background: #f8f9fa;
}

.shipping-option input[type="radio"] {
  margin: 0;
}

.shipping-info {
  flex: 1;
}

.shipping-label {
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.shipping-details {
  font-size: 12px;
  color: #666;
  margin-top: 2px;
}

.checkout-section {
  text-align: center;
}

.checkout-btn {
  width: 100%;
  padding: 15px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: background-color 0.3s ease;
  margin-bottom: 15px;
}

.checkout-btn:hover:not(:disabled) {
  background: #45a049;
}

.checkout-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.checkout-info {
  font-size: 11px;
  color: #666;
  line-height: 1.4;
}

.checkout-info p {
  margin: 2px 0;
}

.product-suggestions {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
}

.product-suggestions h3 {
  margin: 0 0 20px 0;
  color: #333;
  font-size: 18px;
}

.suggestions-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.suggestion-item {
  text-align: center;
  padding: 15px;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.suggestion-item:hover {
  border-color: #4caf50;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
}

.suggestion-item img {
  width: 100%;
  height: 120px;
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 10px;
}

.suggestion-item h4 {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 14px;
  font-weight: 600;
}

.suggestion-price {
  margin: 0 0 10px 0;
  color: #4caf50;
  font-size: 16px;
  font-weight: bold;
}

.add-to-cart-btn {
  width: 100%;
  padding: 8px 12px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.add-to-cart-btn:hover:not(:disabled) {
  background: #45a049;
}

.add-to-cart-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

@media (max-width: 768px) {
  .shopping-cart {
    padding: 15px;
  }
  
  .cart-content {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .cart-summary {
    order: -1;
  }
  
  .cart-item {
    flex-direction: column;
    gap: 10px;
  }
  
  .item-controls {
    align-items: stretch;
  }
  
  .quantity-controls {
    justify-content: center;
  }
  
  .suggestions-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .shopping-cart {
    padding: 10px;
  }
  
  .cart-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .cart-item {
    padding: 15px 0;
  }
  
  .item-image img {
    width: 60px;
    height: 60px;
  }
  
  .promo-form {
    flex-direction: column;
  }
  
  .shipping-option {
    flex-direction: column;
    align-items: stretch;
    text-align: center;
  }
}
</style>

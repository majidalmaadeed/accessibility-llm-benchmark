<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Shopping Cart System</h1>
      <p class="page-subtitle">
        E-commerce shopping cart system
      </p>
    </div>

    <div v-if="checkoutStep === 'checkout'">
      <div class="page-header">
        <h1 class="page-title">Checkout</h1>
        <p class="page-subtitle">Complete your order</p>
      </div>

      <div class="grid grid-2">
        <div class="card">
          <h2>Shipping Information</h2>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">First Name</label>
              <input type="text" class="form-control" />
            </div>
            <div class="form-group">
              <label class="form-label">Last Name</label>
              <input type="text" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Address</label>
            <input type="text" class="form-control" />
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">City</label>
              <input type="text" class="form-control" />
            </div>
            <div class="form-group">
              <label class="form-label">State</label>
              <input type="text" class="form-control" />
            </div>
            <div class="form-group">
              <label class="form-label">ZIP Code</label>
              <input type="text" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Phone</label>
            <input type="tel" class="form-control" />
          </div>
        </div>

        <div class="card">
          <h2>Payment Information</h2>
          <div class="form-group">
            <label class="form-label">Card Number</label>
            <input type="text" class="form-control" placeholder="1234 5678 9012 3456" />
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Expiry Date</label>
              <input type="text" class="form-control" placeholder="MM/YY" />
            </div>
            <div class="form-group">
              <label class="form-label">CVV</label>
              <input type="text" class="form-control" placeholder="123" />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Name on Card</label>
            <input type="text" class="form-control" />
          </div>
        </div>
      </div>

      <div class="card">
        <h2>Order Summary</h2>
        <div style="display: flex; justify-content: space-between; margin-bottom: 1rem">
          <span>Subtotal:</span>
          <span>${{ calculateSubtotal().toFixed(2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: 1rem">
          <span>Tax:</span>
          <span>${{ calculateTax().toFixed(2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: 1rem">
          <span>Shipping:</span>
          <span>${{ calculateShipping().toFixed(2) }}</span>
        </div>
        <div v-if="appliedCoupon" style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: #28a745">
          <span>Discount ({{ appliedCoupon.description }}):</span>
          <span>-${{ calculateDiscount().toFixed(2) }}</span>
        </div>
        <div style="display: flex; justify-content: space-between; font-size: 1.2rem; font-weight: bold; border-top: 1px solid #eee; padding-top: 1rem">
          <span>Total:</span>
          <span>${{ calculateTotal().toFixed(2) }}</span>
        </div>
      </div>

      <div class="form-actions">
        <button class="btn btn-secondary" @click="checkoutStep = 'cart'">
          Back to Cart
        </button>
        <button class="btn" @click="completeOrder">
          Complete Order
        </button>
      </div>
    </div>

    <div v-else>
      <div class="grid grid-2">
        <div class="card">
          <h2>Shopping Cart</h2>
          <div v-if="cartItems.length === 0" style="text-align: center; padding: 2rem; color: #666">
            <div style="font-size: 3rem; margin-bottom: 1rem">🛒</div>
            <p>Your cart is empty</p>
          </div>
          <div v-else>
            <div
              v-for="item in cartItems"
              :key="item.id"
              class="cart-item"
            >
              <div style="font-size: 2rem; margin-right: 1rem">
                {{ item.image }}
              </div>
              <div class="cart-item-info">
                <div class="cart-item-name">{{ item.name }}</div>
                <div class="cart-item-price">${{ item.price.toFixed(2) }} each</div>
              </div>
              <div class="cart-item-controls">
                <div class="quantity-controls">
                  <button
                    class="quantity-btn"
                    @click="updateQuantity(item.id, item.quantity - 1)"
                  >
                    -
                  </button>
                  <input
                    type="number"
                    class="quantity-input"
                    :value="item.quantity"
                    @input="updateQuantity(item.id, parseInt($event.target.value) || 0)"
                    min="0"
                  />
                  <button
                    class="quantity-btn"
                    @click="updateQuantity(item.id, item.quantity + 1)"
                  >
                    +
                  </button>
                </div>
                <button
                  class="btn btn-secondary"
                  @click="removeItem(item.id)"
                  style="margin-left: 1rem"
                >
                  Remove
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <h2>Order Summary</h2>
          <div style="margin-bottom: 1rem">
            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem">
              <span>Subtotal ({{ totalItems }} items):</span>
              <span>${{ calculateSubtotal().toFixed(2) }}</span>
            </div>
            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem">
              <span>Tax:</span>
              <span>${{ calculateTax().toFixed(2) }}</span>
            </div>
            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem">
              <span>Shipping:</span>
              <span>${{ calculateShipping().toFixed(2) }}</span>
            </div>
            <div v-if="appliedCoupon" style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; color: #28a745">
              <span>Discount ({{ appliedCoupon.description }}):</span>
              <span>-${{ calculateDiscount().toFixed(2) }}</span>
            </div>
            <div style="display: flex; justify-content: space-between; font-size: 1.2rem; font-weight: bold; border-top: 1px solid #eee; padding-top: 0.5rem">
              <span>Total:</span>
              <span>${{ calculateTotal().toFixed(2) }}</span>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">Coupon Code</label>
            <div style="display: flex; gap: 0.5rem">
              <input
                type="text"
                class="form-control"
                v-model="couponCode"
                placeholder="Enter coupon code"
              />
              <button class="btn" @click="applyCoupon">
                Apply
              </button>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">Shipping Method</label>
            <select
              class="form-control"
              v-model="shippingMethod"
            >
              <option value="standard">Standard (5-7 days) - $9.99</option>
              <option value="express">Express (2-3 days) - $15.99</option>
            </select>
          </div>

          <button
            class="btn"
            @click="proceedToCheckout"
            :disabled="cartItems.length === 0"
            style="width: 100%; margin-top: 1rem"
          >
            Proceed to Checkout
          </button>
        </div>
      </div>

      <div class="card">
        <h2>Recommended Products</h2>
        <div class="grid grid-4">
          <div
            v-for="(product, index) in recommendedProducts"
            :key="index"
            style="text-align: center; padding: 1rem; border: 1px solid #eee; border-radius: 8px"
          >
            <div style="font-size: 2rem; margin-bottom: 0.5rem">{{ product.image }}</div>
            <div style="font-weight: 600; margin-bottom: 0.25rem">{{ product.name }}</div>
            <div style="color: #666; margin-bottom: 0.5rem">${{ product.price }}</div>
            <button class="btn" style="width: 100%">
              Add to Cart
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ShoppingCart',
  data() {
    return {
      cartItems: [
        { id: 1, name: 'Wireless Headphones', price: 99.99, quantity: 1, image: '🎧' },
        { id: 2, name: 'Smart Watch', price: 199.99, quantity: 1, image: '⌚' },
        { id: 3, name: 'Bluetooth Speaker', price: 79.99, quantity: 2, image: '🔊' },
        { id: 4, name: 'Phone Case', price: 24.99, quantity: 1, image: '📱' }
      ],
      couponCode: '',
      appliedCoupon: null,
      shippingMethod: 'standard',
      checkoutStep: 'cart',
      recommendedProducts: [
        { name: 'Laptop Stand', price: 49.99, image: '💻' },
        { name: 'Wireless Mouse', price: 29.99, image: '🖱️' },
        { name: 'USB Cable', price: 12.99, image: '🔌' },
        { name: 'Screen Cleaner', price: 8.99, image: '🧽' }
      ]
    }
  },
  computed: {
    totalItems() {
      return this.cartItems.reduce((total, item) => total + item.quantity, 0)
    }
  },
  methods: {
    updateQuantity(id, newQuantity) {
      if (newQuantity <= 0) {
        this.removeItem(id)
      } else {
        const item = this.cartItems.find(item => item.id === id)
        if (item) {
          item.quantity = newQuantity
        }
      }
    },
    removeItem(id) {
      this.cartItems = this.cartItems.filter(item => item.id !== id)
    },
    applyCoupon() {
      const validCoupons = {
        'SAVE10': { discount: 0.1, description: '10% off' },
        'WELCOME': { discount: 0.15, description: '15% off for new customers' },
        'FREESHIP': { discount: 0, description: 'Free shipping', freeShipping: true }
      }

      if (validCoupons[this.couponCode]) {
        this.appliedCoupon = validCoupons[this.couponCode]
        alert(`Coupon applied: ${validCoupons[this.couponCode].description}`)
      } else {
        alert('Invalid coupon code')
      }
    },
    calculateSubtotal() {
      return this.cartItems.reduce((total, item) => total + (item.price * item.quantity), 0)
    },
    calculateTax() {
      return this.calculateSubtotal() * 0.08
    },
    calculateShipping() {
      if (this.appliedCoupon?.freeShipping) return 0
      const subtotal = this.calculateSubtotal()
      if (subtotal > 100) return 0
      return this.shippingMethod === 'express' ? 15.99 : 9.99
    },
    calculateDiscount() {
      if (!this.appliedCoupon) return 0
      return this.calculateSubtotal() * this.appliedCoupon.discount
    },
    calculateTotal() {
      return this.calculateSubtotal() + this.calculateTax() + this.calculateShipping() - this.calculateDiscount()
    },
    proceedToCheckout() {
      this.checkoutStep = 'checkout'
    },
    completeOrder() {
      alert('Order completed successfully!')
      this.cartItems = []
      this.checkoutStep = 'cart'
    }
  }
}
</script>

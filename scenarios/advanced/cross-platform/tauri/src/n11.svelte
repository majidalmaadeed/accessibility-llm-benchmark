<script>
  export let data
  
  let cartData = null
  let selectedItems = new Set()
  let promoCode = ''
  let appliedPromo = null
  let selectedShipping = 'standard'
  
  $: {
    if (data) {
      cartData = JSON.parse(data)
    }
  }
  
  $: subtotal = cartData?.items.reduce((sum, item) => sum + (item.price * item.quantity), 0) || 0
  $: shippingCost = selectedShipping === 'standard' ? 0 : selectedShipping === 'express' ? 9.99 : 19.99
  $: tax = subtotal * 0.08
  $: discount = appliedPromo ? subtotal * 0.1 : 0
  $: total = subtotal + shippingCost + tax - discount
  
  function updateQuantity(itemId, change) {
    if (cartData) {
      const item = cartData.items.find(i => i.id === itemId)
      if (item) {
        item.quantity = Math.max(1, Math.min(10, item.quantity + change))
      }
    }
  }
  
  function removeItem(itemId) {
    if (cartData) {
      cartData.items = cartData.items.filter(item => item.id !== itemId)
    }
  }
  
  function toggleSelectItem(itemId) {
    if (selectedItems.has(itemId)) {
      selectedItems.delete(itemId)
    } else {
      selectedItems.add(itemId)
    }
    selectedItems = selectedItems
  }
  
  function toggleSelectAll() {
    if (selectedItems.size === cartData?.items.length) {
      selectedItems.clear()
    } else {
      selectedItems = new Set(cartData?.items.map(item => item.id) || [])
    }
  }
  
  function deleteSelected() {
    if (confirm(`Delete ${selectedItems.size} selected items?`)) {
      if (cartData) {
        cartData.items = cartData.items.filter(item => !selectedItems.has(item.id))
        selectedItems.clear()
      }
    }
  }
  
  function saveForLater() {
    alert(`Save ${selectedItems.size} items for later`)
  }
  
  function addToWishlist(itemId) {
    alert(`Add item ${itemId} to wishlist`)
  }
  
  function applyPromoCode() {
    if (promoCode === 'SAVE10') {
      appliedPromo = promoCode
      alert('Promo code applied! 10% discount added.')
    } else if (promoCode === 'FREESHIP') {
      appliedPromo = promoCode
      selectedShipping = 'standard'
      alert('Free shipping applied!')
    } else if (promoCode) {
      alert('Invalid promo code. Please try again.')
    }
  }
  
  function selectShipping(type) {
    selectedShipping = type
  }
  
  function proceedToCheckout() {
    alert('Proceeding to checkout...')
  }
</script>

<div class="shopping-cart-container">
  <div class="cart-header">
    <h2>Your Items</h2>
    <span class="item-count">{cartData?.items.length || 0} items</span>
  </div>
  
  {#if selectedItems.size > 0}
    <div class="bulk-actions">
      <div class="bulk-actions-content">
        <div class="bulk-actions-left">
          <button class="bulk-btn" on:click={saveForLater}>Save for Later</button>
          <button class="bulk-btn danger" on:click={deleteSelected}>Remove Selected</button>
        </div>
        <div class="bulk-actions-right">
          {selectedItems.size} items selected
        </div>
      </div>
    </div>
  {/if}
  
  <div class="cart-items">
    {#if cartData?.items}
      {#each cartData.items as item}
        <div class="cart-item">
          <input type="checkbox" 
                 checked={selectedItems.has(item.id)}
                 on:change={() => toggleSelectItem(item.id)}>
          <div class="item-image">📱</div>
          <div class="item-details">
            <div class="item-name">{item.name}</div>
            <div class="item-sku">SKU: {item.sku}</div>
            <div class="item-options">Brand: {item.brand}</div>
          </div>
          <div class="item-price">${item.price.toFixed(2)}</div>
          <div class="quantity-controls">
            <button class="quantity-btn" on:click={() => updateQuantity(item.id, -1)}>-</button>
            <input type="number" 
                   bind:value={item.quantity} 
                   min="1" 
                   max="10"
                   on:change={(e) => item.quantity = Math.max(1, Math.min(10, parseInt(e.target.value) || 1))}>
            <button class="quantity-btn" on:click={() => updateQuantity(item.id, 1)}>+</button>
          </div>
          <div class="item-actions">
            <button class="action-btn save-btn" on:click={() => alert('Save for later')}>Save</button>
            <button class="action-btn remove-btn" on:click={() => removeItem(item.id)}>Remove</button>
            <button class="action-btn wishlist-btn" on:click={() => addToWishlist(item.id)}>Wishlist</button>
          </div>
        </div>
      {/each}
    {/if}
  </div>
  
  <div class="promo-section">
    <h3>Promo Code</h3>
    <div class="promo-input-group">
      <input type="text" bind:value={promoCode} placeholder="Enter promo code">
      <button class="apply-btn" on:click={applyPromoCode}>Apply</button>
    </div>
    {#if appliedPromo}
      <div class="promo-success">Promo code applied!</div>
    {/if}
  </div>
  
  <div class="shipping-section">
    <h3>Shipping Options</h3>
    <div class="shipping-options">
      <div class="shipping-option" class:selected={selectedShipping === 'standard'} on:click={() => selectShipping('standard')}>
        <input type="radio" bind:group={selectedShipping} value="standard">
        <div class="shipping-info">
          <div class="shipping-name">Standard Shipping</div>
          <div class="shipping-details">5-7 business days</div>
        </div>
        <div class="shipping-price">Free</div>
      </div>
      <div class="shipping-option" class:selected={selectedShipping === 'express'} on:click={() => selectShipping('express')}>
        <input type="radio" bind:group={selectedShipping} value="express">
        <div class="shipping-info">
          <div class="shipping-name">Express Shipping</div>
          <div class="shipping-details">2-3 business days</div>
        </div>
        <div class="shipping-price">$9.99</div>
      </div>
      <div class="shipping-option" class:selected={selectedShipping === 'overnight'} on:click={() => selectShipping('overnight')}>
        <input type="radio" bind:group={selectedShipping} value="overnight">
        <div class="shipping-info">
          <div class="shipping-name">Overnight Shipping</div>
          <div class="shipping-details">Next business day</div>
        </div>
        <div class="shipping-price">$19.99</div>
      </div>
    </div>
  </div>
  
  <div class="cart-summary">
    <h3>Order Summary</h3>
    <div class="summary-row">
      <span class="summary-label">Subtotal ({cartData?.items.length || 0} items)</span>
      <span class="summary-value">${subtotal.toFixed(2)}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label">Shipping</span>
      <span class="summary-value">{shippingCost === 0 ? 'Free' : `$${shippingCost.toFixed(2)}`}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label">Tax</span>
      <span class="summary-value">${tax.toFixed(2)}</span>
    </div>
    <div class="summary-row">
      <span class="summary-label">Discount</span>
      <span class="summary-value">-${discount.toFixed(2)}</span>
    </div>
    <div class="summary-row summary-total">
      <span class="summary-label">Total</span>
      <span class="summary-value">${total.toFixed(2)}</span>
    </div>
    <button class="checkout-btn" on:click={proceedToCheckout}>Proceed to Checkout</button>
    <div class="security-badges">
      <div class="security-badge">🔒 Secure Checkout</div>
      <div class="security-badge">💳 SSL Encrypted</div>
      <div class="security-badge">🛡️ Money Back Guarantee</div>
    </div>
  </div>
</div>

<style>
  .shopping-cart-container {
    padding: 20px;
  }
  
  .cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
  }
  
  .cart-header h2 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }
  
  .item-count {
    color: #666;
    font-size: 14px;
  }
  
  .bulk-actions {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .bulk-actions-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .bulk-actions-left {
    display: flex;
    gap: 10px;
  }
  
  .bulk-actions-right {
    color: #666;
    font-size: 14px;
  }
  
  .bulk-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
  }
  
  .bulk-btn:hover {
    background: #f8f9fa;
  }
  
  .bulk-btn.danger {
    border-color: #dc3545;
    color: #dc3545;
  }
  
  .bulk-btn.danger:hover {
    background: #dc3545;
    color: white;
  }
  
  .cart-items {
    margin-bottom: 20px;
  }
  
  .cart-item {
    display: flex;
    align-items: center;
    padding: 20px 0;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .cart-item:last-child {
    border-bottom: none;
  }
  
  .item-image {
    width: 80px;
    height: 80px;
    background: #f0f0f0;
    border-radius: 8px;
    margin: 0 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
  }
  
  .item-details {
    flex: 1;
  }
  
  .item-name {
    font-size: 16px;
    font-weight: 600;
    color: #333;
    margin-bottom: 5px;
  }
  
  .item-sku {
    font-size: 12px;
    color: #666;
    margin-bottom: 5px;
  }
  
  .item-options {
    font-size: 14px;
    color: #666;
  }
  
  .item-price {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin-right: 20px;
  }
  
  .quantity-controls {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-right: 20px;
  }
  
  .quantity-btn {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .quantity-btn:hover {
    background: #f8f9fa;
  }
  
  .quantity-controls input {
    width: 50px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
    font-size: 14px;
  }
  
  .item-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
  }
  
  .save-btn {
    background: #28a745;
    color: white;
  }
  
  .remove-btn {
    background: #dc3545;
    color: white;
  }
  
  .wishlist-btn {
    background: #6c757d;
    color: white;
  }
  
  .promo-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .promo-section h3 {
    margin: 0 0 10px 0;
    color: #333;
  }
  
  .promo-input-group {
    display: flex;
    gap: 10px;
  }
  
  .promo-input-group input {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .apply-btn {
    padding: 10px 20px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
  }
  
  .apply-btn:hover {
    background: #0056b3;
  }
  
  .promo-success {
    margin-top: 10px;
    padding: 10px;
    background: #d4edda;
    color: #155724;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .shipping-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
  }
  
  .shipping-section h3 {
    margin: 0 0 15px 0;
    color: #333;
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
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.2s ease;
  }
  
  .shipping-option:hover {
    background: white;
  }
  
  .shipping-option.selected {
    border-color: #007bff;
    background: #e3f2fd;
  }
  
  .shipping-info {
    flex: 1;
  }
  
  .shipping-name {
    font-weight: 600;
    margin-bottom: 2px;
  }
  
  .shipping-details {
    font-size: 12px;
    color: #666;
  }
  
  .shipping-price {
    font-weight: 600;
    color: #007bff;
  }
  
  .cart-summary {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
  }
  
  .cart-summary h3 {
    margin: 0 0 20px 0;
    color: #333;
  }
  
  .summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
    font-size: 14px;
  }
  
  .summary-label {
    color: #666;
  }
  
  .summary-value {
    font-weight: 600;
    color: #333;
  }
  
  .summary-total {
    border-top: 2px solid #f0f0f0;
    padding-top: 15px;
    margin-top: 15px;
    font-size: 18px;
    font-weight: 600;
  }
  
  .checkout-btn {
    width: 100%;
    padding: 15px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 20px;
  }
  
  .checkout-btn:hover {
    background: #1e7e34;
  }
  
  .security-badges {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid #f0f0f0;
  }
  
  .security-badge {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    color: #666;
  }
</style>

<template>
  <div class="product-catalog">
    <h1>Product Catalog</h1>
    <p>Browse our latest products.</p>
    
    <div class="products-grid">
      <div class="product-card">
        
        <img 
          src="https://via.placeholder.com/200x150/4CAF50/white?text=Product+Image"
          class="product-image"
        />
        
        <h3 class="product-title">Wireless Headphones</h3>
        
        <p class="product-description">
          High-quality wireless headphones with noise cancellation
        </p>
        
        <div class="product-footer">
          <span class="product-price">$99.99</span>
          <button class="add-to-cart-btn">Add to Cart</button>
        </div>
      </div>

      <div class="product-card">
        
        <img 
          src="https://via.placeholder.com/200x150/2196F3/white?text=Smart+Watch"
          class="product-image"
        />
        
        <h3 class="product-title">Smart Watch</h3>
        
        <p class="product-description">
          Advanced fitness tracking with heart rate monitoring
        </p>
        
        <div class="product-footer">
          <span class="product-price">$199.99</span>
          <button class="add-to-cart-btn">Add to Cart</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MissingImageAltText'
}
</script>

<style scoped>
.product-catalog {
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-top: 30px;
}

.product-card {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 20px;
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.product-image {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 15px;
}

.product-title {
  margin: 0 0 10px 0;
  font-size: 18px;
  color: #333;
}

.product-description {
  color: #666;
  font-size: 14px;
  margin: 0 0 15px 0;
}

.product-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.product-price {
  font-size: 20px;
  font-weight: bold;
  color: #2e7d32;
}

.add-to-cart-btn {
  background: #4caf50;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}
</style>

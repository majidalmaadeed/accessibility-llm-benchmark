<script>
  import { onMount } from 'svelte';
  
  let formData = {
    name: '',
    email: '',
    phone: '',
    address: '',
    city: '',
    zipCode: '',
    country: '',
    message: ''
  };
  
  let showTooltips = {};
  
  function handleInputChange(field, value) {
    formData[field] = value;
  }
  
  function showTooltip(field) {
    showTooltips[field] = true;
  }
  
  function hideTooltip(field) {
    showTooltips[field] = false;
  }
  
  function handleSubmit() {
    alert('Form submitted successfully!');
  }
  
  function resetForm() {
    formData = {
      name: '',
      email: '',
      phone: '',
      address: '',
      city: '',
      zipCode: '',
      country: '',
      message: ''
    };
    showTooltips = {};
  }
</script>

<div class="contact-form-page">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Contact Us</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Home clicked')}>
          🏠 Home
        </button>
        <button class="header-btn" on:click={() => alert('About clicked')}>
          ℹ️ About
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="form-container">
      <div class="form-header">
        <h2 class="form-title">Get in Touch</h2>
        <p class="form-subtitle">We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
      </div>
      
      <form class="contact-form" on:submit|preventDefault={handleSubmit}>
        <div class="form-section">
          <h3 class="section-title">Personal Information</h3>
          
          <div class="form-group">
            <label for="name" class="form-label">Full Name *</label>
            <div class="input-group">
              <input 
                type="text" 
                id="name" 
                class="form-input" 
                placeholder="Enter your full name"
                value={formData.name}
                on:input={(e) => handleInputChange('name', e.target.value)}
                required
              />
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('name')}
                  on:mouseleave={() => hideTooltip('name')}
                >
                  ?
                </button>
                {#if showTooltips.name}
                  <div class="tooltip">
                    Enter your full legal name as it appears on official documents
                  </div>
                {/if}
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="email" class="form-label">Email Address *</label>
            <div class="input-group">
              <input 
                type="email" 
                id="email" 
                class="form-input" 
                placeholder="Enter your email address"
                value={formData.email}
                on:input={(e) => handleInputChange('email', e.target.value)}
                required
              />
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('email')}
                  on:mouseleave={() => hideTooltip('email')}
                >
                  ?
                </button>
                {#if showTooltips.email}
                  <div class="tooltip">
                    Enter a valid email address where we can reach you
                  </div>
                {/if}
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="phone" class="form-label">Phone Number</label>
            <div class="input-group">
              <input 
                type="tel" 
                id="phone" 
                class="form-input" 
                placeholder="Enter your phone number"
                value={formData.phone}
                on:input={(e) => handleInputChange('phone', e.target.value)}
              />
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('phone')}
                  on:mouseleave={() => hideTooltip('phone')}
                >
                  ?
                </button>
                {#if showTooltips.phone}
                  <div class="tooltip">
                    Include country code if international. Example: +1 (555) 123-4567
                  </div>
                {/if}
              </div>
            </div>
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Address Information</h3>
          
          <div class="form-group">
            <label for="address" class="form-label">Street Address</label>
            <div class="input-group">
              <input 
                type="text" 
                id="address" 
                class="form-input" 
                placeholder="Enter your street address"
                value={formData.address}
                on:input={(e) => handleInputChange('address', e.target.value)}
              />
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('address')}
                  on:mouseleave={() => hideTooltip('address')}
                >
                  ?
                </button>
                {#if showTooltips.address}
                  <div class="tooltip">
                    Include apartment or suite number if applicable
                  </div>
                {/if}
              </div>
            </div>
          </div>
          
          <div class="form-row">
            <div class="form-group">
              <label for="city" class="form-label">City</label>
              <div class="input-group">
                <input 
                  type="text" 
                  id="city" 
                  class="form-input" 
                  placeholder="Enter your city"
                  value={formData.city}
                  on:input={(e) => handleInputChange('city', e.target.value)}
                />
                <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
                <div class="tooltip-container">
                  <button 
                    type="button" 
                    class="help-btn" 
                    on:mouseenter={() => showTooltip('city')}
                    on:mouseleave={() => hideTooltip('city')}
                  >
                    ?
                  </button>
                  {#if showTooltips.city}
                    <div class="tooltip">
                      Enter the city name where you reside
                    </div>
                  {/if}
                </div>
              </div>
            </div>
            
            <div class="form-group">
              <label for="zipCode" class="form-label">ZIP Code</label>
              <div class="input-group">
                <input 
                  type="text" 
                  id="zipCode" 
                  class="form-input" 
                  placeholder="Enter your ZIP code"
                  value={formData.zipCode}
                  on:input={(e) => handleInputChange('zipCode', e.target.value)}
                />
                <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
                <div class="tooltip-container">
                  <button 
                    type="button" 
                    class="help-btn" 
                    on:mouseenter={() => showTooltip('zipCode')}
                    on:mouseleave={() => hideTooltip('zipCode')}
                  >
                    ?
                  </button>
                  {#if showTooltips.zipCode}
                    <div class="tooltip">
                      Enter your 5-digit ZIP code or postal code
                    </div>
                  {/if}
                </div>
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="country" class="form-label">Country</label>
            <div class="input-group">
              <select 
                id="country" 
                class="form-select"
                value={formData.country}
                on:change={(e) => handleInputChange('country', e.target.value)}
              >
                <option value="">Select your country</option>
                <option value="US">United States</option>
                <option value="CA">Canada</option>
                <option value="UK">United Kingdom</option>
                <option value="AU">Australia</option>
                <option value="DE">Germany</option>
                <option value="FR">France</option>
                <option value="ES">Spain</option>
                <option value="IT">Italy</option>
                <option value="JP">Japan</option>
                <option value="CN">China</option>
                <option value="IN">India</option>
                <option value="BR">Brazil</option>
                <option value="MX">Mexico</option>
                <option value="other">Other</option>
              </select>
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('country')}
                  on:mouseleave={() => hideTooltip('country')}
                >
                  ?
                </button>
                {#if showTooltips.country}
                  <div class="tooltip">
                    Select your country of residence
                  </div>
                {/if}
              </div>
            </div>
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Message</h3>
          
          <div class="form-group">
            <label for="message" class="form-label">Message *</label>
            <div class="input-group">
              <textarea 
                id="message" 
                class="form-textarea" 
                placeholder="Enter your message"
                rows="5"
                value={formData.message}
                on:input={(e) => handleInputChange('message', e.target.value)}
                required
              ></textarea>
              <!-- INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible -->
              <div class="tooltip-container">
                <button 
                  type="button" 
                  class="help-btn" 
                  on:mouseenter={() => showTooltip('message')}
                  on:mouseleave={() => hideTooltip('message')}
                >
                  ?
                </button>
                {#if showTooltips.message}
                  <div class="tooltip">
                    Please provide as much detail as possible about your inquiry
                  </div>
                {/if}
              </div>
            </div>
          </div>
        </div>
        
        <div class="form-actions">
          <button type="button" class="form-btn secondary" on:click={resetForm}>
            Reset Form
          </button>
          <button type="submit" class="form-btn primary">
            Send Message
          </button>
        </div>
      </form>
    </div>
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">Contact Info</h4>
        <div class="contact-info">
          <div class="contact-item">
            <span class="contact-icon">📧</span>
            <span class="contact-text">info@company.com</span>
          </div>
          <div class="contact-item">
            <span class="contact-icon">📞</span>
            <span class="contact-text">+1 (555) 123-4567</span>
          </div>
          <div class="contact-item">
            <span class="contact-icon">📍</span>
            <span class="contact-text">123 Business St, City, State 12345</span>
          </div>
        </div>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Quick Links</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Home</a></li>
          <li><a href="#" class="footer-link">About</a></li>
          <li><a href="#" class="footer-link">Services</a></li>
          <li><a href="#" class="footer-link">Contact</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Follow Us</h4>
        <div class="social-links">
          <a href="#" class="social-link">Twitter</a>
          <a href="#" class="social-link">LinkedIn</a>
          <a href="#" class="social-link">Facebook</a>
        </div>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 Company Name. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .contact-form-page {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .form-container {
    background: white;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .form-header {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .form-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .form-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .form-section {
    margin-bottom: 40px;
    padding-bottom: 30px;
    border-bottom: 1px solid #eee;
  }
  
  .form-section:last-child {
    border-bottom: none;
    margin-bottom: 0;
  }
  
  .section-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin: 0 0 20px 0;
  }
  
  .form-group {
    margin-bottom: 25px;
  }
  
  .form-label {
    display: block;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
  }
  
  .input-group {
    position: relative;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .form-input,
  .form-select,
  .form-textarea {
    flex: 1;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    box-sizing: border-box;
    transition: border-color 0.2s;
  }
  
  .form-input:focus,
  .form-select:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .form-textarea {
    resize: vertical;
    min-height: 120px;
  }
  
  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
  }
  
  .tooltip-container {
    position: relative;
  }
  
  .help-btn {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 50%;
    background: #f8f9fa;
    color: #666;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .help-btn:hover {
    background: #e9ecef;
    color: #333;
  }
  
  /* INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible */
  .tooltip {
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: #333;
    color: white;
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 14px;
    white-space: nowrap;
    z-index: 1000;
    margin-bottom: 5px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  }
  
  .tooltip::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border: 5px solid transparent;
    border-top-color: #333;
  }
  
  .form-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid #eee;
  }
  
  .form-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .form-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .form-btn.primary:hover {
    background: #0056b3;
  }
  
  .form-btn.secondary {
    background: #6c757d;
    color: white;
  }
  
  .form-btn.secondary:hover {
    background: #545b62;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 40px 0 20px 0;
    margin-top: 60px;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
  }
  
  .footer-title {
    font-size: 18px;
    font-weight: bold;
    margin: 0 0 15px 0;
  }
  
  .contact-info {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .contact-item {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .contact-icon {
    font-size: 16px;
  }
  
  .contact-text {
    color: #ccc;
  }
  
  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .footer-links li {
    margin-bottom: 8px;
  }
  
  .footer-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .footer-link:hover {
    color: white;
  }
  
  .social-links {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .social-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .social-link:hover {
    color: white;
  }
  
  .footer-bottom {
    border-top: 1px solid #555;
    margin-top: 30px;
    padding-top: 20px;
    text-align: center;
    color: #ccc;
  }
  
  @media (max-width: 768px) {
    .form-container {
      padding: 20px;
    }
    
    .form-title {
      font-size: 24px;
    }
    
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .form-actions {
      flex-direction: column;
    }
  }
</style>

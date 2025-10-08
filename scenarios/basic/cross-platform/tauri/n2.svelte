<script>
  import { onMount } from 'svelte';
  
  let formData = {
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    confirmPassword: '',
    phone: '',
    address: '',
    city: '',
    zipCode: '',
    country: '',
    terms: false,
    newsletter: false
  };
  
  let errors = {};
  let isSubmitting = false;
  
  function validateForm() {
    errors = {};
    
    if (!formData.firstName.trim()) {
      errors.firstName = 'First name is required';
    }
    
    if (!formData.lastName.trim()) {
      errors.lastName = 'Last name is required';
    }
    
    if (!formData.email.trim()) {
      errors.email = 'Email is required';
    } else if (!isValidEmail(formData.email)) {
      errors.email = 'Please enter a valid email address';
    }
    
    if (!formData.password) {
      errors.password = 'Password is required';
    } else if (formData.password.length < 8) {
      errors.password = 'Password must be at least 8 characters';
    }
    
    if (!formData.confirmPassword) {
      errors.confirmPassword = 'Please confirm your password';
    } else if (formData.password !== formData.confirmPassword) {
      errors.confirmPassword = 'Passwords do not match';
    }
    
    if (!formData.phone.trim()) {
      errors.phone = 'Phone number is required';
    } else if (!isValidPhone(formData.phone)) {
      errors.phone = 'Please enter a valid phone number';
    }
    
    if (!formData.address.trim()) {
      errors.address = 'Address is required';
    }
    
    if (!formData.city.trim()) {
      errors.city = 'City is required';
    }
    
    if (!formData.zipCode.trim()) {
      errors.zipCode = 'ZIP code is required';
    } else if (!isValidZipCode(formData.zipCode)) {
      errors.zipCode = 'Please enter a valid ZIP code';
    }
    
    if (!formData.country) {
      errors.country = 'Country is required';
    }
    
    if (!formData.terms) {
      errors.terms = 'You must accept the terms and conditions';
    }
    
    return Object.keys(errors).length === 0;
  }
  
  function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  function isValidPhone(phone) {
    const phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
    return phoneRegex.test(phone.replace(/[\s\-\(\)]/g, ''));
  }
  
  function isValidZipCode(zipCode) {
    const zipRegex = /^\d{5}(-\d{4})?$/;
    return zipRegex.test(zipCode);
  }
  
  function handleInputChange(field, value) {
    formData[field] = value;
    // Clear error when user starts typing
    if (errors[field]) {
      delete errors[field];
      errors = { ...errors };
    }
  }
  
  function handleSubmit() {
    if (validateForm()) {
      isSubmitting = true;
      // Simulate form submission
      setTimeout(() => {
        isSubmitting = false;
        alert('Account created successfully!');
      }, 2000);
    } else {
      alert('Please fix the errors in the form');
    }
  }
  
  function resetForm() {
    formData = {
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      confirmPassword: '',
      phone: '',
      address: '',
      city: '',
      zipCode: '',
      country: '',
      terms: false,
      newsletter: false
    };
    errors = {};
  }
</script>

<div class="registration-page">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Create Account</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Login clicked')}>
          🔐 Login
        </button>
        <button class="header-btn" on:click={() => alert('Help clicked')}>
          ❓ Help
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="form-container">
      <div class="form-header">
        <h2 class="form-title">Join Our Platform</h2>
        <p class="form-subtitle">Create your account to get started</p>
      </div>
      
      <form class="registration-form" on:submit|preventDefault={handleSubmit}>
        <div class="form-section">
          <h3 class="section-title">Personal Information</h3>
          
          <div class="form-row">
            <div class="form-group">
              <label for="firstName" class="form-label">First Name *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="text" 
                id="firstName" 
                class="form-input {errors.firstName ? 'error' : ''}" 
                placeholder="Enter your first name"
                value={formData.firstName}
                on:input={(e) => handleInputChange('firstName', e.target.value)}
              />
            </div>
            
            <div class="form-group">
              <label for="lastName" class="form-label">Last Name *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="text" 
                id="lastName" 
                class="form-input {errors.lastName ? 'error' : ''}" 
                placeholder="Enter your last name"
                value={formData.lastName}
                on:input={(e) => handleInputChange('lastName', e.target.value)}
              />
            </div>
          </div>
          
          <div class="form-group">
            <label for="email" class="form-label">Email Address *</label>
            <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
            <input 
              type="email" 
              id="email" 
              class="form-input {errors.email ? 'error' : ''}" 
              placeholder="Enter your email address"
              value={formData.email}
              on:input={(e) => handleInputChange('email', e.target.value)}
            />
          </div>
          
          <div class="form-row">
            <div class="form-group">
              <label for="password" class="form-label">Password *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="password" 
                id="password" 
                class="form-input {errors.password ? 'error' : ''}" 
                placeholder="Create a password"
                value={formData.password}
                on:input={(e) => handleInputChange('password', e.target.value)}
              />
            </div>
            
            <div class="form-group">
              <label for="confirmPassword" class="form-label">Confirm Password *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="password" 
                id="confirmPassword" 
                class="form-input {errors.confirmPassword ? 'error' : ''}" 
                placeholder="Confirm your password"
                value={formData.confirmPassword}
                on:input={(e) => handleInputChange('confirmPassword', e.target.value)}
              />
            </div>
          </div>
          
          <div class="form-group">
            <label for="phone" class="form-label">Phone Number *</label>
            <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
            <input 
              type="tel" 
              id="phone" 
              class="form-input {errors.phone ? 'error' : ''}" 
              placeholder="Enter your phone number"
              value={formData.phone}
              on:input={(e) => handleInputChange('phone', e.target.value)}
            />
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Address Information</h3>
          
          <div class="form-group">
            <label for="address" class="form-label">Street Address *</label>
            <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
            <input 
              type="text" 
              id="address" 
              class="form-input {errors.address ? 'error' : ''}" 
              placeholder="Enter your street address"
              value={formData.address}
              on:input={(e) => handleInputChange('address', e.target.value)}
            />
          </div>
          
          <div class="form-row">
            <div class="form-group">
              <label for="city" class="form-label">City *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="text" 
                id="city" 
                class="form-input {errors.city ? 'error' : ''}" 
                placeholder="Enter your city"
                value={formData.city}
                on:input={(e) => handleInputChange('city', e.target.value)}
              />
            </div>
            
            <div class="form-group">
              <label for="zipCode" class="form-label">ZIP Code *</label>
              <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
              <input 
                type="text" 
                id="zipCode" 
                class="form-input {errors.zipCode ? 'error' : ''}" 
                placeholder="Enter your ZIP code"
                value={formData.zipCode}
                on:input={(e) => handleInputChange('zipCode', e.target.value)}
              />
            </div>
          </div>
          
          <div class="form-group">
            <label for="country" class="form-label">Country *</label>
            <!-- COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border -->
            <select 
              id="country" 
              class="form-select {errors.country ? 'error' : ''}"
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
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Preferences</h3>
          
          <div class="checkbox-group">
            <label class="checkbox-option {errors.terms ? 'error' : ''}">
              <input 
                type="checkbox" 
                checked={formData.terms}
                on:change={(e) => handleInputChange('terms', e.target.checked)}
              />
              <span class="checkbox-label">
                I agree to the <a href="#" class="link">Terms and Conditions</a> *
              </span>
            </label>
            
            <label class="checkbox-option">
              <input 
                type="checkbox" 
                checked={formData.newsletter}
                on:change={(e) => handleInputChange('newsletter', e.target.checked)}
              />
              <span class="checkbox-label">
                Subscribe to our newsletter for updates and offers
              </span>
            </label>
          </div>
        </div>
        
        <div class="form-actions">
          <button type="button" class="form-btn secondary" on:click={resetForm}>
            Reset Form
          </button>
          <button type="submit" class="form-btn primary" disabled={isSubmitting}>
            {isSubmitting ? 'Creating Account...' : 'Create Account'}
          </button>
        </div>
      </form>
    </div>
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">About</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Our Mission</a></li>
          <li><a href="#" class="footer-link">Team</a></li>
          <li><a href="#" class="footer-link">Careers</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Support</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Help Center</a></li>
          <li><a href="#" class="footer-link">Contact Us</a></li>
          <li><a href="#" class="footer-link">Documentation</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Legal</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Privacy Policy</a></li>
          <li><a href="#" class="footer-link">Terms of Service</a></li>
          <li><a href="#" class="footer-link">Cookie Policy</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 Company Name. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .registration-page {
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
  
  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
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
  
  .form-input,
  .form-select {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    box-sizing: border-box;
    transition: border-color 0.2s;
  }
  
  .form-input:focus,
  .form-select:focus {
    outline: none;
    border-color: #007bff;
  }
  
  /* COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border */
  .form-input.error,
  .form-select.error {
    border-color: #dc3545;
  }
  
  .form-input.error:focus,
  .form-select.error:focus {
    border-color: #dc3545;
  }
  
  .checkbox-group {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .checkbox-option {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border-radius: 6px;
    transition: background-color 0.2s;
  }
  
  .checkbox-option:hover {
    background: #f8f9fa;
  }
  
  /* COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border */
  .checkbox-option.error {
    border: 2px solid #dc3545;
    border-radius: 6px;
  }
  
  .checkbox-option input[type="checkbox"] {
    width: 20px;
    height: 20px;
    margin: 0;
    margin-top: 2px;
  }
  
  .checkbox-label {
    font-size: 16px;
    color: #333;
    line-height: 1.5;
  }
  
  .link {
    color: #007bff;
    text-decoration: none;
  }
  
  .link:hover {
    text-decoration: underline;
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
  
  .form-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  
  .form-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .form-btn.primary:hover:not(:disabled) {
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
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 40px;
  }
  
  .footer-title {
    font-size: 18px;
    font-weight: bold;
    margin: 0 0 15px 0;
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

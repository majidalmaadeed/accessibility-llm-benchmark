<script>
  let formData = {
    name: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
    address: '',
    city: '',
    state: '',
    zipCode: '',
    country: '',
    dateOfBirth: '',
    gender: '',
    newsletter: false,
    terms: false
  };
  
  let errors = {};
  let isSubmitting = false;
  let showSuccess = false;
  
  const countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Germany',
    'France',
    'Spain',
    'Italy',
    'Australia',
    'Japan',
    'Other'
  ];
  
  const states = [
    'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
    'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
    'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
    'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
    'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
    'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
    'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
    'West Virginia', 'Wisconsin', 'Wyoming'
  ];
  
  function validateForm() {
    errors = {};
    
    if (!formData.name.trim()) {
      errors.name = 'Name is required';
    } else if (formData.name.trim().length < 2) {
      errors.name = 'Name must be at least 2 characters';
    }
    
    if (!formData.email.trim()) {
      errors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      errors.email = 'Email is invalid';
    }
    
    if (!formData.phone.trim()) {
      errors.phone = 'Phone number is required';
    } else if (!/^\(\d{3}\) \d{3}-\d{4}$/.test(formData.phone)) {
      errors.phone = 'Phone number must be in format (123) 456-7890';
    }
    
    if (!formData.password) {
      errors.password = 'Password is required';
    } else if (formData.password.length < 8) {
      errors.password = 'Password must be at least 8 characters';
    } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(formData.password)) {
      errors.password = 'Password must contain uppercase, lowercase, and number';
    }
    
    if (!formData.confirmPassword) {
      errors.confirmPassword = 'Please confirm your password';
    } else if (formData.password !== formData.confirmPassword) {
      errors.confirmPassword = 'Passwords do not match';
    }
    
    if (!formData.address.trim()) {
      errors.address = 'Address is required';
    }
    
    if (!formData.city.trim()) {
      errors.city = 'City is required';
    }
    
    if (!formData.state) {
      errors.state = 'State is required';
    }
    
    if (!formData.zipCode.trim()) {
      errors.zipCode = 'ZIP code is required';
    } else if (!/^\d{5}(-\d{4})?$/.test(formData.zipCode)) {
      errors.zipCode = 'ZIP code must be 5 digits or 5+4 format';
    }
    
    if (!formData.country) {
      errors.country = 'Country is required';
    }
    
    if (!formData.dateOfBirth) {
      errors.dateOfBirth = 'Date of birth is required';
    } else {
      const birthDate = new Date(formData.dateOfBirth);
      const today = new Date();
      const age = today.getFullYear() - birthDate.getFullYear();
      if (age < 18) {
        errors.dateOfBirth = 'You must be at least 18 years old';
      }
    }
    
    if (!formData.gender) {
      errors.gender = 'Gender is required';
    }
    
    if (!formData.terms) {
      errors.terms = 'You must accept the terms and conditions';
    }
    
    return Object.keys(errors).length === 0;
  }
  
  function handleSubmit() {
    if (validateForm()) {
      isSubmitting = true;
      
      // Simulate form submission
      setTimeout(() => {
        isSubmitting = false;
        showSuccess = true;
        formData = {
          name: '',
          email: '',
          phone: '',
          password: '',
          confirmPassword: '',
          address: '',
          city: '',
          state: '',
          zipCode: '',
          country: '',
          dateOfBirth: '',
          gender: '',
          newsletter: false,
          terms: false
        };
        errors = {};
      }, 2000);
    }
  }
  
  function formatPhoneNumber(value) {
    const phoneNumber = value.replace(/\D/g, '');
    const phoneNumberLength = phoneNumber.length;
    if (phoneNumberLength < 4) return phoneNumber;
    if (phoneNumberLength < 7) {
      return `(${phoneNumber.slice(0, 3)}) ${phoneNumber.slice(3)}`;
    }
    return `(${phoneNumber.slice(0, 3)}) ${phoneNumber.slice(3, 6)}-${phoneNumber.slice(6, 10)}`;
  }
  
  function handlePhoneChange(event) {
    const formatted = formatPhoneNumber(event.target.value);
    formData.phone = formatted;
  }
</script>

<div class="registration-form">
  <header class="form-header">
    <h1 class="form-title">Create Your Account</h1>
    <p class="form-subtitle">Join our community and get started today</p>
  </header>

  {#if showSuccess}
    <div class="success-message">
      <div class="success-icon">✓</div>
      <h2 class="success-title">Welcome!</h2>
      <p class="success-description">Your account has been created successfully. You can now log in and start using our services.</p>
      <button 
        class="success-btn" 
        on:click={() => showSuccess = false}
      >
        Create Another Account
      </button>
    </div>
  {:else}
    <form class="form-container" on:submit|preventDefault={handleSubmit}>
      <div class="form-section">
        <h2 class="section-title">Personal Information</h2>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="name">Full Name *</label>
            <input 
              type="text" 
              id="name"
              bind:value={formData.name}
              class="form-input" 
              class:error={errors.name}
              placeholder="Enter your full name"
            />
            {#if errors.name}
              <span class="error-message">{errors.name}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="email">Email Address *</label>
            <input 
              type="email" 
              id="email"
              bind:value={formData.email}
              class="form-input" 
              class:error={errors.email}
              placeholder="Enter your email address"
            />
            {#if errors.email}
              <span class="error-message">{errors.email}</span>
            {/if}
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="phone">Phone Number *</label>
            <input 
              type="tel" 
              id="phone"
              value={formData.phone}
              on:input={handlePhoneChange}
              class="form-input" 
              class:error={errors.phone}
              placeholder="(123) 456-7890"
            />
            {#if errors.phone}
              <span class="error-message">{errors.phone}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="dateOfBirth">Date of Birth *</label>
            <input 
              type="date" 
              id="dateOfBirth"
              bind:value={formData.dateOfBirth}
              class="form-input" 
              class:error={errors.dateOfBirth}
            />
            {#if errors.dateOfBirth}
              <span class="error-message">{errors.dateOfBirth}</span>
            {/if}
          </div>
        </div>
        
        <div class="form-group">
          <label class="form-label">Gender *</label>
          <div class="radio-group">
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.gender} 
                value="male"
                class="radio-input"
              />
              <span class="radio-label">Male</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.gender} 
                value="female"
                class="radio-input"
              />
              <span class="radio-label">Female</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.gender} 
                value="other"
                class="radio-input"
              />
              <span class="radio-label">Other</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.gender} 
                value="prefer-not-to-say"
                class="radio-input"
              />
              <span class="radio-label">Prefer not to say</span>
            </label>
          </div>
          {#if errors.gender}
            <span class="error-message">{errors.gender}</span>
          {/if}
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Account Security</h2>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="password">Password *</label>
            <input 
              type="password" 
              id="password"
              bind:value={formData.password}
              class="form-input" 
              class:error={errors.password}
              placeholder="Create a strong password"
            />
            {#if errors.password}
              <span class="error-message">{errors.password}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="confirmPassword">Confirm Password *</label>
            <input 
              type="password" 
              id="confirmPassword"
              bind:value={formData.confirmPassword}
              class="form-input" 
              class:error={errors.confirmPassword}
              placeholder="Confirm your password"
            />
            {#if errors.confirmPassword}
              <span class="error-message">{errors.confirmPassword}</span>
            {/if}
          </div>
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Address Information</h2>
        
        <div class="form-group">
          <label class="form-label" for="address">Street Address *</label>
          <input 
            type="text" 
            id="address"
            bind:value={formData.address}
            class="form-input" 
            class:error={errors.address}
            placeholder="Enter your street address"
          />
          {#if errors.address}
            <span class="error-message">{errors.address}</span>
          {/if}
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="city">City *</label>
            <input 
              type="text" 
              id="city"
              bind:value={formData.city}
              class="form-input" 
              class:error={errors.city}
              placeholder="Enter your city"
            />
            {#if errors.city}
              <span class="error-message">{errors.city}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="state">State *</label>
            <select 
              id="state"
              bind:value={formData.state}
              class="form-select" 
              class:error={errors.state}
            >
              <option value="">Select a state</option>
              {#each states as state (state)}
                <option value={state}>{state}</option>
              {/each}
            </select>
            {#if errors.state}
              <span class="error-message">{errors.state}</span>
            {/if}
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="zipCode">ZIP Code *</label>
            <input 
              type="text" 
              id="zipCode"
              bind:value={formData.zipCode}
              class="form-input" 
              class:error={errors.zipCode}
              placeholder="12345 or 12345-6789"
            />
            {#if errors.zipCode}
              <span class="error-message">{errors.zipCode}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="country">Country *</label>
            <select 
              id="country"
              bind:value={formData.country}
              class="form-select" 
              class:error={errors.country}
            >
              <option value="">Select a country</option>
              {#each countries as country (country)}
                <option value={country}>{country}</option>
              {/each}
            </select>
            {#if errors.country}
              <span class="error-message">{errors.country}</span>
            {/if}
          </div>
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Preferences</h2>
        
        <div class="form-group">
          <div class="checkbox-option">
            <input 
              type="checkbox" 
              bind:checked={formData.newsletter}
              class="checkbox-input"
            />
            <span class="checkbox-label">Subscribe to our newsletter for updates and special offers</span>
          </div>
        </div>
        
        <div class="form-group">
          <div class="checkbox-option">
            <input 
              type="checkbox" 
              bind:checked={formData.terms}
              class="checkbox-input"
            />
            <span class="checkbox-label">I agree to the <a href="#" class="terms-link">Terms and Conditions</a> and <a href="#" class="terms-link">Privacy Policy</a> *</span>
          </div>
          {#if errors.terms}
            <span class="error-message">{errors.terms}</span>
          {/if}
        </div>
      </div>

      <div class="form-actions">
        <button 
          type="button" 
          class="btn btn-secondary"
          on:click={() => {
            formData = {
              name: '',
              email: '',
              phone: '',
              password: '',
              confirmPassword: '',
              address: '',
              city: '',
              state: '',
              zipCode: '',
              country: '',
              dateOfBirth: '',
              gender: '',
              newsletter: false,
              terms: false
            };
            errors = {};
          }}
        >
          Reset Form
        </button>
        <button 
          type="submit" 
          class="btn btn-primary"
          disabled={isSubmitting}
        >
          {isSubmitting ? 'Creating Account...' : 'Create Account'}
        </button>
      </div>
    </form>
  {/if}
</div>

<style>
  .registration-form {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
  }
  
  .form-header {
    text-align: center;
    margin-bottom: 40px;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .form-title {
    margin: 0 0 15px 0;
    font-size: 32px;
    color: #333;
  }
  
  .form-subtitle {
    margin: 0;
    font-size: 18px;
    color: #666;
  }
  
  .form-container {
    max-width: 800px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .form-section {
    padding: 30px;
    border-bottom: 1px solid #eee;
  }
  
  .form-section:last-child {
    border-bottom: none;
  }
  
  .section-title {
    margin: 0 0 25px 0;
    font-size: 20px;
    color: #333;
    border-bottom: 2px solid #007bff;
    padding-bottom: 10px;
  }
  
  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
  }
  
  .form-group {
    margin-bottom: 25px;
  }
  
  .form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
  }
  
  .form-input,
  .form-select {
    width: 100%;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.2s ease;
  }
  
  .form-input:focus,
  .form-select:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
  }
  
  .form-input.error,
  .form-select.error {
    border-color: #dc3545;
  }
  
  .radio-group {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
  }
  
  .radio-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .radio-option:hover {
    background: #f8f9fa;
    border-color: #007bff;
  }
  
  .radio-input {
    margin: 0;
  }
  
  .radio-label {
    font-weight: 500;
    color: #333;
  }
  
  .checkbox-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  
  .checkbox-option:hover {
    background: #f8f9fa;
    border-color: #007bff;
  }
  
  .checkbox-input {
    margin: 0;
  }
  
  .checkbox-label {
    font-weight: 500;
    color: #333;
  }
  
  .terms-link {
    color: #007bff;
    text-decoration: none;
  }
  
  .terms-link:hover {
    text-decoration: underline;
  }
  
  .error-message {
    display: block;
    color: #dc3545;
    font-size: 14px;
    margin-top: 5px;
  }
  
  .form-actions {
    padding: 30px;
    background: #f8f9fa;
    display: flex;
    gap: 15px;
    justify-content: flex-end;
  }
  
  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 16px;
  }
  
  .btn-primary {
    background: #007bff;
    color: white;
  }
  
  .btn-primary:hover:not(:disabled) {
    background: #0056b3;
  }
  
  .btn-primary:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
  
  .success-message {
    text-align: center;
    padding: 60px 40px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    max-width: 600px;
    margin: 0 auto;
  }
  
  .success-icon {
    width: 80px;
    height: 80px;
    background: #28a745;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    margin: 0 auto 30px;
  }
  
  .success-title {
    margin: 0 0 15px 0;
    font-size: 28px;
    color: #333;
  }
  
  .success-description {
    margin: 0 0 30px 0;
    color: #666;
    font-size: 16px;
  }
  
  .success-btn {
    padding: 15px 30px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .success-btn:hover {
    background: #0056b3;
  }
  
  @media (max-width: 768px) {
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .radio-group {
      grid-template-columns: 1fr;
    }
    
    .form-actions {
      flex-direction: column;
    }
    
    .btn {
      width: 100%;
    }
  }
</style>

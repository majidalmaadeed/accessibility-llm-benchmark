<script>
  let formData = {
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
    age: '',
    country: '',
    newsletter: false,
    terms: false
  };

  let errors = {};
  let isSubmitting = false;
  let submitAttempted = false;

  function validateField(fieldName, value) {
    const newErrors = { ...errors };
    
    switch (fieldName) {
      case 'firstName':
        if (!value.trim()) {
          newErrors[fieldName] = 'First name is required';
        } else if (value.trim().length < 2) {
          newErrors[fieldName] = 'First name must be at least 2 characters';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'lastName':
        if (!value.trim()) {
          newErrors[fieldName] = 'Last name is required';
        } else if (value.trim().length < 2) {
          newErrors[fieldName] = 'Last name must be at least 2 characters';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'email':
        if (!value.trim()) {
          newErrors[fieldName] = 'Email is required';
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
          newErrors[fieldName] = 'Please enter a valid email address';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'phone':
        if (value && !/^[\d\s\-\+\(\)]+$/.test(value)) {
          newErrors[fieldName] = 'Please enter a valid phone number';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'password':
        if (!value) {
          newErrors[fieldName] = 'Password is required';
        } else if (value.length < 8) {
          newErrors[fieldName] = 'Password must be at least 8 characters';
        } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(value)) {
          newErrors[fieldName] = 'Password must contain uppercase, lowercase, and number';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'confirmPassword':
        if (!value) {
          newErrors[fieldName] = 'Please confirm your password';
        } else if (value !== formData.password) {
          newErrors[fieldName] = 'Passwords do not match';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'age':
        if (value && (isNaN(value) || value < 13 || value > 120)) {
          newErrors[fieldName] = 'Please enter a valid age between 13 and 120';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'country':
        if (!value) {
          newErrors[fieldName] = 'Please select your country';
        } else {
          delete newErrors[fieldName];
        }
        break;
        
      case 'terms':
        if (!value) {
          newErrors[fieldName] = 'You must accept the terms and conditions';
        } else {
          delete newErrors[fieldName];
        }
        break;
    }
    
    errors = newErrors;
  }

  function handleInput(fieldName, value) {
    formData[fieldName] = value;
    if (submitAttempted) {
      validateField(fieldName, value);
    }
  }

  function handleSubmit() {
    submitAttempted = true;
    
    // Validate all fields
    Object.keys(formData).forEach(field => {
      validateField(field, formData[field]);
    });
    
    if (Object.keys(errors).length === 0) {
      isSubmitting = true;
      // Simulate form submission
      setTimeout(() => {
        isSubmitting = false;
        alert('Form submitted successfully!');
      }, 2000);
    }
  }

  function handleReset() {
    formData = {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      password: '',
      confirmPassword: '',
      age: '',
      country: '',
      newsletter: false,
      terms: false
    };
    errors = {};
    submitAttempted = false;
  }

  function getFieldClass(fieldName) {
    const hasError = errors[fieldName];
    return `form-input ${hasError ? 'error' : ''}`;
  }
</script>

<div class="registration-form">
  <header class="form-header">
    <h1>User Registration</h1>
    <p>Create your account to get started</p>
  </header>

  <form class="registration-form-content" on:submit|preventDefault={handleSubmit}>
    <div class="form-section">
      <h2 class="section-title">Personal Information</h2>
      
      <div class="form-row">
        <div class="form-group">
          <label for="firstName" class="form-label">First Name *</label>
          <input 
            type="text" 
            id="firstName" 
            bind:value={formData.firstName}
            on:input={(e) => handleInput('firstName', e.target.value)}
            class={getFieldClass('firstName')}
            placeholder="Enter your first name"
          />
        </div>

        <div class="form-group">
          <label for="lastName" class="form-label">Last Name *</label>
          <input 
            type="text" 
            id="lastName" 
            bind:value={formData.lastName}
            on:input={(e) => handleInput('lastName', e.target.value)}
            class={getFieldClass('lastName')}
            placeholder="Enter your last name"
          />
        </div>
      </div>

      <div class="form-group">
        <label for="email" class="form-label">Email Address *</label>
        <input 
          type="email" 
          id="email" 
          bind:value={formData.email}
          on:input={(e) => handleInput('email', e.target.value)}
          class={getFieldClass('email')}
          placeholder="Enter your email address"
        />
      </div>

      <div class="form-group">
        <label for="phone" class="form-label">Phone Number</label>
        <input 
          type="tel" 
          id="phone" 
          bind:value={formData.phone}
          on:input={(e) => handleInput('phone', e.target.value)}
          class={getFieldClass('phone')}
          placeholder="Enter your phone number"
        />
      </div>

      <div class="form-group">
        <label for="age" class="form-label">Age</label>
        <input 
          type="number" 
          id="age" 
          bind:value={formData.age}
          on:input={(e) => handleInput('age', e.target.value)}
          class={getFieldClass('age')}
          placeholder="Enter your age"
          min="13"
          max="120"
        />
      </div>

      <div class="form-group">
        <label for="country" class="form-label">Country *</label>
        <select 
          id="country" 
          bind:value={formData.country}
          on:change={(e) => handleInput('country', e.target.value)}
          class={getFieldClass('country')}
        >
          <option value="">Select your country</option>
          <option value="us">United States</option>
          <option value="ca">Canada</option>
          <option value="uk">United Kingdom</option>
          <option value="au">Australia</option>
          <option value="de">Germany</option>
          <option value="fr">France</option>
          <option value="jp">Japan</option>
          <option value="other">Other</option>
        </select>
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Account Security</h2>
      
      <div class="form-group">
        <label for="password" class="form-label">Password *</label>
        <input 
          type="password" 
          id="password" 
          bind:value={formData.password}
          on:input={(e) => handleInput('password', e.target.value)}
          class={getFieldClass('password')}
          placeholder="Create a strong password"
        />
      </div>

      <div class="form-group">
        <label for="confirmPassword" class="form-label">Confirm Password *</label>
        <input 
          type="password" 
          id="confirmPassword" 
          bind:value={formData.confirmPassword}
          on:input={(e) => handleInput('confirmPassword', e.target.value)}
          class={getFieldClass('confirmPassword')}
          placeholder="Confirm your password"
        />
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Preferences</h2>
      
      <div class="form-group checkbox-group">
        <label class="checkbox-label">
          <input 
            type="checkbox" 
            bind:checked={formData.newsletter}
            on:change={(e) => handleInput('newsletter', e.target.checked)}
          />
          <span class="checkbox-text">Subscribe to our newsletter for updates and offers</span>
        </label>
      </div>

      <div class="form-group checkbox-group">
        <label class="checkbox-label">
          <input 
            type="checkbox" 
            bind:checked={formData.terms}
            on:change={(e) => handleInput('terms', e.target.checked)}
            class={errors.terms ? 'error' : ''}
          />
          <span class="checkbox-text">I agree to the <a href="#" class="terms-link">Terms and Conditions</a> *</span>
        </label>
      </div>
    </div>

    <div class="form-actions">
      <button type="button" class="btn secondary" on:click={handleReset}>
        Reset Form
      </button>
      <button type="submit" class="btn primary" disabled={isSubmitting}>
        {isSubmitting ? 'Creating Account...' : 'Create Account'}
      </button>
    </div>
  </form>

  <div class="form-help">
    <h3>Form Guidelines</h3>
    <div class="help-content">
      <div class="help-item">
        <span class="help-icon">ℹ️</span>
        <div class="help-text">
          <h4>Required Fields</h4>
          <p>Fields marked with * are required and must be filled out</p>
        </div>
      </div>
      
      <div class="help-item">
        <span class="help-icon">🔒</span>
        <div class="help-text">
          <h4>Password Requirements</h4>
          <p>Password must be at least 8 characters with uppercase, lowercase, and numbers</p>
        </div>
      </div>
      
      <div class="help-item">
        <span class="help-icon">📧</span>
        <div class="help-text">
          <h4>Email Verification</h4>
          <p>We'll send a verification email to confirm your account</p>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .registration-form {
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .form-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .form-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .form-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .registration-form-content {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 30px;
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
    margin: 0 0 25px 0;
    font-size: 20px;
    color: #333;
  }

  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
  }

  .form-input {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.2s ease;
  }

  .form-input:focus {
    outline: none;
    border-color: #007bff;
  }

  .form-input.error {
    border-color: #dc3545;
  }

  .checkbox-group {
    margin-bottom: 15px;
  }

  .checkbox-label {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    cursor: pointer;
  }

  .checkbox-label input[type="checkbox"] {
    margin: 0;
    width: 18px;
    height: 18px;
    flex-shrink: 0;
  }

  .checkbox-label input[type="checkbox"].error {
    accent-color: #dc3545;
  }

  .checkbox-text {
    color: #333;
    line-height: 1.4;
  }

  .terms-link {
    color: #007bff;
    text-decoration: none;
  }

  .terms-link:hover {
    text-decoration: underline;
  }

  .form-actions {
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #eee;
  }

  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .btn.primary {
    background: #007bff;
    color: white;
  }

  .btn.primary:hover:not(:disabled) {
    background: #0056b3;
  }

  .btn.primary:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }

  .btn.secondary {
    background: #6c757d;
    color: white;
  }

  .btn.secondary:hover {
    background: #545b62;
  }

  .form-help {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 8px;
  }

  .form-help h3 {
    margin: 0 0 25px 0;
    font-size: 24px;
    color: #333;
  }

  .help-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }

  .help-item {
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }

  .help-icon {
    font-size: 24px;
    flex-shrink: 0;
  }

  .help-text h4 {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #333;
  }

  .help-text p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  @media (max-width: 768px) {
    .form-row {
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

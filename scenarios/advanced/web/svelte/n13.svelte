<script>
  import { onMount } from 'svelte';
  
  let currentStep = 1;
  let formData = {
    personalInfo: {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      dateOfBirth: ''
    },
    addressInfo: {
      street: '',
      city: '',
      state: '',
      zipCode: '',
      country: ''
    },
    preferences: {
      newsletter: false,
      notifications: false,
      theme: 'light',
      language: 'en'
    },
    paymentInfo: {
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      billingAddress: ''
    }
  };
  let errors = {};
  let isSubmitting = false;

  const steps = [
    { id: 1, title: 'Personal', description: 'Basic information' },
    { id: 2, title: 'Address', description: 'Location details' },
    { id: 3, title: 'Preferences', description: 'Your settings' },
    { id: 4, title: 'Payment', description: 'Billing information' },
    { id: 5, title: 'Review', description: 'Confirm details' }
  ];

  $: progressPercentage = (currentStep / steps.length) * 100;

  onMount(() => {
    validateCurrentStep();
  });

  $: validateCurrentStep();

  function validateCurrentStep() {
    const newErrors = {};

    switch (currentStep) {
      case 1:
        if (!formData.personalInfo.firstName.trim()) {
          newErrors.firstName = 'First name is required';
        }
        if (!formData.personalInfo.lastName.trim()) {
          newErrors.lastName = 'Last name is required';
        }
        if (!formData.personalInfo.email.trim()) {
          newErrors.email = 'Email is required';
        } else if (!/\S+@\S+\.\S+/.test(formData.personalInfo.email)) {
          newErrors.email = 'Email is invalid';
        }
        if (!formData.personalInfo.phone.trim()) {
          newErrors.phone = 'Phone number is required';
        }
        break;
      case 2:
        if (!formData.addressInfo.street.trim()) {
          newErrors.street = 'Street address is required';
        }
        if (!formData.addressInfo.city.trim()) {
          newErrors.city = 'City is required';
        }
        if (!formData.addressInfo.state.trim()) {
          newErrors.state = 'State is required';
        }
        if (!formData.addressInfo.zipCode.trim()) {
          newErrors.zipCode = 'ZIP code is required';
        }
        break;
      case 4:
        if (!formData.paymentInfo.cardNumber.trim()) {
          newErrors.cardNumber = 'Card number is required';
        }
        if (!formData.paymentInfo.expiryDate.trim()) {
          newErrors.expiryDate = 'Expiry date is required';
        }
        if (!formData.paymentInfo.cvv.trim()) {
          newErrors.cvv = 'CVV is required';
        }
        break;
    }

    errors = newErrors;
  }

  function handleInputChange(section, field, value) {
    formData = {
      ...formData,
      [section]: {
        ...formData[section],
        [field]: value
      }
    };
  }

  function handleNext() {
    if (Object.keys(errors).length === 0 && currentStep < steps.length) {
      currentStep += 1;
    }
  }

  function handlePrevious() {
    if (currentStep > 1) {
      currentStep -= 1;
    }
  }

  async function handleSubmit() {
    isSubmitting = true;
    
    setTimeout(() => {
      console.log('Form submitted:', formData);
      isSubmitting = false;
      alert('Registration completed successfully!');
    }, 2000);
  }

  function getStepClass(step) {
    if (step.id === currentStep) return 'active';
    if (step.id < currentStep) return 'completed';
    return '';
  }

  function getStepNumber(step) {
    return step.id < currentStep ? '✓' : step.id;
  }

  function hasError(field) {
    return errors[field] ? true : false;
  }

  function getError(field) {
    return errors[field] || '';
  }

  function getMaskedCardNumber() {
    const cardNumber = formData.paymentInfo.cardNumber;
    if (cardNumber.length > 4) {
      return '**** **** **** ' + cardNumber.slice(-4);
    }
    return cardNumber;
  }
</script>

<div class="wizard-container">
  <div class="wizard-header">
    <h1>User Registration Wizard</h1>
    <div class="progress-bar">
      <div 
        class="progress-fill" 
        style="width: {progressPercentage}%"
      />
    </div>
    <div class="progress-text">
      Step {currentStep} of {steps.length}
    </div>
  </div>

  <div class="wizard-steps">
    {#each steps as step}
      <div 
        class="step {getStepClass(step)}"
        on:click={() => currentStep = step.id}
      >
        <div class="step-number">
          {getStepNumber(step)}
        </div>
        <div class="step-info">
          <div class="step-title">{step.title}</div>
          <div class="step-description">{step.description}</div>
        </div>
      </div>
    {/each}
  </div>

  <div class="wizard-content">
    {#if currentStep === 1}
      <div class="step-content">
        <h3>Personal Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="First Name"
            bind:value={formData.personalInfo.firstName}
            class="form-input"
            class:error={hasError('firstName')}
          />
          {#if hasError('firstName')}
            <span class="error-message">{getError('firstName')}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <input
            type="text"
            placeholder="Last Name"
            bind:value={formData.personalInfo.lastName}
            class="form-input"
            class:error={hasError('lastName')}
          />
          {#if hasError('lastName')}
            <span class="error-message">{getError('lastName')}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <input
            type="email"
            placeholder="Email Address"
            bind:value={formData.personalInfo.email}
            class="form-input"
            class:error={hasError('email')}
          />
          {#if hasError('email')}
            <span class="error-message">{getError('email')}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <input
            type="tel"
            placeholder="Phone Number"
            bind:value={formData.personalInfo.phone}
            class="form-input"
            class:error={hasError('phone')}
          />
          {#if hasError('phone')}
            <span class="error-message">{getError('phone')}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <input
            type="date"
            bind:value={formData.personalInfo.dateOfBirth}
            class="form-input"
          />
        </div>
      </div>
    {/if}

    {#if currentStep === 2}
      <div class="step-content">
        <h3>Address Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="Street Address"
            bind:value={formData.addressInfo.street}
            class="form-input"
            class:error={hasError('street')}
          />
          {#if hasError('street')}
            <span class="error-message">{getError('street')}</span>
          {/if}
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="City"
              bind:value={formData.addressInfo.city}
              class="form-input"
              class:error={hasError('city')}
            />
            {#if hasError('city')}
              <span class="error-message">{getError('city')}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <input
              type="text"
              placeholder="State"
              bind:value={formData.addressInfo.state}
              class="form-input"
              class:error={hasError('state')}
            />
            {#if hasError('state')}
              <span class="error-message">{getError('state')}</span>
            {/if}
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="ZIP Code"
              bind:value={formData.addressInfo.zipCode}
              class="form-input"
              class:error={hasError('zipCode')}
            />
            {#if hasError('zipCode')}
              <span class="error-message">{getError('zipCode')}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <select 
              bind:value={formData.addressInfo.country}
              class="form-input"
            >
              <option value="">Select Country</option>
              <option value="US">United States</option>
              <option value="CA">Canada</option>
              <option value="UK">United Kingdom</option>
              <option value="AU">Australia</option>
            </select>
          </div>
        </div>
      </div>
    {/if}

    {#if currentStep === 3}
      <div class="step-content">
        <h3>Preferences</h3>
        <div class="form-group">
          <label class="checkbox-label">
            <input
              type="checkbox"
              bind:checked={formData.preferences.newsletter}
            />
            Subscribe to newsletter
          </label>
        </div>
        
        <div class="form-group">
          <label class="checkbox-label">
            <input
              type="checkbox"
              bind:checked={formData.preferences.notifications}
            />
            Enable push notifications
          </label>
        </div>
        
        <div class="form-group">
          <label class="form-label">Theme Preference</label>
          <select 
            bind:value={formData.preferences.theme}
            class="form-input"
          >
            <option value="light">Light</option>
            <option value="dark">Dark</option>
            <option value="auto">Auto</option>
          </select>
        </div>
        
        <div class="form-group">
          <label class="form-label">Language</label>
          <select 
            bind:value={formData.preferences.language}
            class="form-input"
          >
            <option value="en">English</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
            <option value="de">German</option>
          </select>
        </div>
      </div>
    {/if}

    {#if currentStep === 4}
      <div class="step-content">
        <h3>Payment Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="Card Number"
            bind:value={formData.paymentInfo.cardNumber}
            class="form-input"
            class:error={hasError('cardNumber')}
          />
          {#if hasError('cardNumber')}
            <span class="error-message">{getError('cardNumber')}</span>
          {/if}
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="MM/YY"
              bind:value={formData.paymentInfo.expiryDate}
              class="form-input"
              class:error={hasError('expiryDate')}
            />
            {#if hasError('expiryDate')}
              <span class="error-message">{getError('expiryDate')}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <input
              type="text"
              placeholder="CVV"
              bind:value={formData.paymentInfo.cvv}
              class="form-input"
              class:error={hasError('cvv')}
            />
            {#if hasError('cvv')}
              <span class="error-message">{getError('cvv')}</span>
            {/if}
          </div>
        </div>
        
        <div class="form-group">
          <input
            type="text"
            placeholder="Billing Address (if different)"
            bind:value={formData.paymentInfo.billingAddress}
            class="form-input"
          />
        </div>
      </div>
    {/if}

    {#if currentStep === 5}
      <div class="step-content">
        <h3>Review Your Information</h3>
        <div class="review-section">
          <h4>Personal Information</h4>
          <p><strong>Name:</strong> {formData.personalInfo.firstName} {formData.personalInfo.lastName}</p>
          <p><strong>Email:</strong> {formData.personalInfo.email}</p>
          <p><strong>Phone:</strong> {formData.personalInfo.phone}</p>
          <p><strong>Date of Birth:</strong> {formData.personalInfo.dateOfBirth}</p>
        </div>
        
        <div class="review-section">
          <h4>Address</h4>
          <p>{formData.addressInfo.street}</p>
          <p>{formData.addressInfo.city}, {formData.addressInfo.state} {formData.addressInfo.zipCode}</p>
          <p>{formData.addressInfo.country}</p>
        </div>
        
        <div class="review-section">
          <h4>Preferences</h4>
          <p><strong>Newsletter:</strong> {formData.preferences.newsletter ? 'Yes' : 'No'}</p>
          <p><strong>Notifications:</strong> {formData.preferences.notifications ? 'Yes' : 'No'}</p>
          <p><strong>Theme:</strong> {formData.preferences.theme}</p>
          <p><strong>Language:</strong> {formData.preferences.language}</p>
        </div>
        
        <div class="review-section">
          <h4>Payment</h4>
          <p><strong>Card:</strong> {getMaskedCardNumber()}</p>
          <p><strong>Expires:</strong> {formData.paymentInfo.expiryDate}</p>
        </div>
      </div>
    {/if}
  </div>

  <div class="wizard-navigation">
    <button 
      on:click={handlePrevious}
      disabled={currentStep === 1}
      class="btn-secondary"
    >
      Previous
    </button>
    
    {#if currentStep < steps.length}
      <button 
        on:click={handleNext}
        class="btn-primary"
      >
        Next
      </button>
    {:else}
      <button 
        on:click={handleSubmit}
        disabled={isSubmitting}
        class="btn-primary"
      >
        {isSubmitting ? 'Submitting...' : 'Complete Registration'}
      </button>
    {/if}
  </div>
</div>

<style>
  .wizard-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }

  .wizard-header {
    text-align: center;
    margin-bottom: 30px;
  }

  .wizard-header h1 {
    margin: 0 0 20px 0;
    color: #333;
    font-size: 28px;
  }

  .progress-bar {
    width: 100%;
    height: 8px;
    background: #e0e0e0;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 10px;
  }

  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #4caf50, #8bc34a);
    transition: width 0.3s ease;
  }

  .progress-text {
    color: #666;
    font-size: 14px;
    font-weight: 500;
  }

  .wizard-steps {
    display: flex;
    justify-content: space-between;
    margin-bottom: 40px;
    position: relative;
  }

  .wizard-steps::before {
    content: '';
    position: absolute;
    top: 20px;
    left: 40px;
    right: 40px;
    height: 2px;
    background: #e0e0e0;
    z-index: 1;
  }

  .step {
    display: flex;
    flex-direction: column;
    align-items: center;
    cursor: pointer;
    position: relative;
    z-index: 2;
    flex: 1;
  }

  .step-number {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #e0e0e0;
    color: #666;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 16px;
    margin-bottom: 8px;
    transition: all 0.3s ease;
  }

  .step.active .step-number {
    background: #4caf50;
    color: white;
    transform: scale(1.1);
  }

  .step.completed .step-number {
    background: #8bc34a;
    color: white;
  }

  .step-info {
    text-align: center;
    max-width: 120px;
  }

  .step-title {
    font-weight: 600;
    font-size: 12px;
    color: #333;
    margin-bottom: 2px;
  }

  .step-description {
    font-size: 10px;
    color: #666;
    line-height: 1.3;
  }

  .step.active .step-title {
    color: #4caf50;
  }

  .step.completed .step-title {
    color: #8bc34a;
  }

  .wizard-content {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 30px;
    margin-bottom: 30px;
    min-height: 400px;
  }

  .step-content h3 {
    margin: 0 0 20px 0;
    color: #333;
    font-size: 20px;
    border-bottom: 2px solid #4caf50;
    padding-bottom: 10px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-row {
    display: flex;
    gap: 15px;
  }

  .form-row .form-group {
    flex: 1;
  }

  .form-input {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #e0e0e0;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
    box-sizing: border-box;
  }

  .form-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .form-input.error {
    border-color: #f44336;
  }

  .error-message {
    display: block;
    color: #f44336;
    font-size: 12px;
    margin-top: 5px;
    font-weight: 500;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
  }

  .checkbox-label input[type="checkbox"] {
    width: auto;
    margin: 0;
  }

  .form-label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .review-section {
    margin-bottom: 25px;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 6px;
    border-left: 4px solid #4caf50;
  }

  .review-section h4 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 16px;
  }

  .review-section p {
    margin: 5px 0;
    color: #666;
    font-size: 14px;
  }

  .wizard-navigation {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .btn-primary,
  .btn-secondary {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    min-width: 120px;
  }

  .btn-primary {
    background: #4caf50;
    color: white;
  }

  .btn-primary:hover:not(:disabled) {
    background: #45a049;
    transform: translateY(-1px);
  }

  .btn-primary:disabled {
    background: #ccc;
    cursor: not-allowed;
    transform: none;
  }

  .btn-secondary {
    background: #f5f5f5;
    color: #333;
    border: 2px solid #e0e0e0;
  }

  .btn-secondary:hover:not(:disabled) {
    background: #e0e0e0;
    transform: translateY(-1px);
  }

  .btn-secondary:disabled {
    background: #f5f5f5;
    color: #ccc;
    cursor: not-allowed;
    transform: none;
  }

  @media (max-width: 768px) {
    .wizard-container {
      padding: 15px;
    }
    
    .wizard-steps {
      flex-direction: column;
      gap: 20px;
    }
    
    .wizard-steps::before {
      display: none;
    }
    
    .step {
      flex-direction: row;
      text-align: left;
    }
    
    .step-number {
      margin-right: 15px;
      margin-bottom: 0;
    }
    
    .step-info {
      text-align: left;
      max-width: none;
    }
    
    .step-title {
      font-size: 14px;
    }
    
    .step-description {
      font-size: 12px;
    }
    
    .wizard-content {
      padding: 20px;
    }
    
    .form-row {
      flex-direction: column;
      gap: 0;
    }
    
    .wizard-navigation {
      flex-direction: column;
      gap: 15px;
    }
    
    .btn-primary,
    .btn-secondary {
      width: 100%;
    }
  }
</style>

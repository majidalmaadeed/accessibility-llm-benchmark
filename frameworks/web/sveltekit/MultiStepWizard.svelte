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
      country: 'US'
    },
    preferences: {
      newsletter: false,
      notifications: true,
      theme: 'light',
      language: 'en'
    },
    paymentInfo: {
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      cardholderName: '',
      billingAddress: ''
    },
    review: {
      termsAccepted: false,
      privacyAccepted: false,
      marketingAccepted: false
    }
  };
  
  let errors = {};
  let isSubmitting = false;
  let showSuccess = false;
  
  const steps = [
    {
      id: 1,
      title: 'Personal Information',
      description: 'Tell us about yourself',
      icon: '👤'
    },
    {
      id: 2,
      title: 'Address Details',
      description: 'Where should we send your items?',
      icon: '🏠'
    },
    {
      id: 3,
      title: 'Preferences',
      description: 'Customize your experience',
      icon: '⚙️'
    },
    {
      id: 4,
      title: 'Payment',
      description: 'Secure payment information',
      icon: '💳'
    },
    {
      id: 5,
      title: 'Review & Confirm',
      description: 'Review your information',
      icon: '✅'
    }
  ];
  
  const countries = [
    { value: 'US', label: 'United States' },
    { value: 'CA', label: 'Canada' },
    { value: 'GB', label: 'United Kingdom' },
    { value: 'AU', label: 'Australia' },
    { value: 'DE', label: 'Germany' },
    { value: 'FR', label: 'France' }
  ];
  
  const states = [
    { value: 'CA', label: 'California' },
    { value: 'NY', label: 'New York' },
    { value: 'TX', label: 'Texas' },
    { value: 'FL', label: 'Florida' },
    { value: 'IL', label: 'Illinois' },
    { value: 'PA', label: 'Pennsylvania' }
  ];
  
  const themes = [
    { value: 'light', label: 'Light' },
    { value: 'dark', label: 'Dark' },
    { value: 'auto', label: 'Auto' }
  ];
  
  const languages = [
    { value: 'en', label: 'English' },
    { value: 'es', label: 'Spanish' },
    { value: 'fr', label: 'French' },
    { value: 'de', label: 'German' }
  ];
  
  onMount(() => {
    // Initialize form validation
    validateCurrentStep();
  });
  
  function nextStep() {
    if (validateCurrentStep()) {
      if (currentStep < steps.length) {
        currentStep++;
      }
    }
  }
  
  function previousStep() {
    if (currentStep > 1) {
      currentStep--;
    }
  }
  
  function goToStep(stepNumber) {
    if (stepNumber >= 1 && stepNumber <= steps.length) {
      currentStep = stepNumber;
      validateCurrentStep();
    }
  }
  
  function validateCurrentStep() {
    errors = {};
    let isValid = true;
    
    switch (currentStep) {
      case 1:
        if (!formData.personalInfo.firstName.trim()) {
          errors.firstName = 'First name is required';
          isValid = false;
        }
        if (!formData.personalInfo.lastName.trim()) {
          errors.lastName = 'Last name is required';
          isValid = false;
        }
        if (!formData.personalInfo.email.trim()) {
          errors.email = 'Email is required';
          isValid = false;
        } else if (!isValidEmail(formData.personalInfo.email)) {
          errors.email = 'Please enter a valid email address';
          isValid = false;
        }
        if (!formData.personalInfo.phone.trim()) {
          errors.phone = 'Phone number is required';
          isValid = false;
        }
        if (!formData.personalInfo.dateOfBirth) {
          errors.dateOfBirth = 'Date of birth is required';
          isValid = false;
        }
        break;
        
      case 2:
        if (!formData.addressInfo.street.trim()) {
          errors.street = 'Street address is required';
          isValid = false;
        }
        if (!formData.addressInfo.city.trim()) {
          errors.city = 'City is required';
          isValid = false;
        }
        if (!formData.addressInfo.state) {
          errors.state = 'State is required';
          isValid = false;
        }
        if (!formData.addressInfo.zipCode.trim()) {
          errors.zipCode = 'ZIP code is required';
          isValid = false;
        }
        break;
        
      case 3:
        // Preferences are optional, no validation needed
        break;
        
      case 4:
        if (!formData.paymentInfo.cardNumber.trim()) {
          errors.cardNumber = 'Card number is required';
          isValid = false;
        } else if (!isValidCardNumber(formData.paymentInfo.cardNumber)) {
          errors.cardNumber = 'Please enter a valid card number';
          isValid = false;
        }
        if (!formData.paymentInfo.expiryDate.trim()) {
          errors.expiryDate = 'Expiry date is required';
          isValid = false;
        } else if (!isValidExpiryDate(formData.paymentInfo.expiryDate)) {
          errors.expiryDate = 'Please enter a valid expiry date (MM/YY)';
          isValid = false;
        }
        if (!formData.paymentInfo.cvv.trim()) {
          errors.cvv = 'CVV is required';
          isValid = false;
        } else if (!isValidCVV(formData.paymentInfo.cvv)) {
          errors.cvv = 'Please enter a valid CVV';
          isValid = false;
        }
        if (!formData.paymentInfo.cardholderName.trim()) {
          errors.cardholderName = 'Cardholder name is required';
          isValid = false;
        }
        break;
        
      case 5:
        if (!formData.review.termsAccepted) {
          errors.termsAccepted = 'You must accept the terms and conditions';
          isValid = false;
        }
        if (!formData.review.privacyAccepted) {
          errors.privacyAccepted = 'You must accept the privacy policy';
          isValid = false;
        }
        break;
    }
    
    return isValid;
  }
  
  function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  function isValidCardNumber(cardNumber) {
    const cleaned = cardNumber.replace(/\s/g, '');
    return /^\d{13,19}$/.test(cleaned);
  }
  
  function isValidExpiryDate(expiryDate) {
    const regex = /^(0[1-9]|1[0-2])\/\d{2}$/;
    if (!regex.test(expiryDate)) return false;
    
    const [month, year] = expiryDate.split('/');
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear() % 100;
    const currentMonth = currentDate.getMonth() + 1;
    
    const expYear = parseInt(year);
    const expMonth = parseInt(month);
    
    return expYear > currentYear || (expYear === currentYear && expMonth >= currentMonth);
  }
  
  function isValidCVV(cvv) {
    return /^\d{3,4}$/.test(cvv);
  }
  
  function formatCardNumber(value) {
    const cleaned = value.replace(/\s/g, '');
    const formatted = cleaned.replace(/(.{4})/g, '$1 ').trim();
    return formatted;
  }
  
  function formatExpiryDate(value) {
    const cleaned = value.replace(/\D/g, '');
    if (cleaned.length >= 2) {
      return cleaned.substring(0, 2) + '/' + cleaned.substring(2, 4);
    }
    return cleaned;
  }
  
  function handleCardNumberInput(event) {
    const formatted = formatCardNumber(event.target.value);
    formData.paymentInfo.cardNumber = formatted;
  }
  
  function handleExpiryDateInput(event) {
    const formatted = formatExpiryDate(event.target.value);
    formData.paymentInfo.expiryDate = formatted;
  }
  
  async function submitForm() {
    if (!validateCurrentStep()) {
      return;
    }
    
    isSubmitting = true;
    
    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      console.log('Form submitted:', formData);
      showSuccess = true;
    } catch (error) {
      console.error('Submission error:', error);
      alert('There was an error submitting the form. Please try again.');
    } finally {
      isSubmitting = false;
    }
  }
  
  function resetForm() {
    formData = {
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
        country: 'US'
      },
      preferences: {
        newsletter: false,
        notifications: true,
        theme: 'light',
        language: 'en'
      },
      paymentInfo: {
        cardNumber: '',
        expiryDate: '',
        cvv: '',
        cardholderName: '',
        billingAddress: ''
      },
      review: {
        termsAccepted: false,
        privacyAccepted: false,
        marketingAccepted: false
      }
    };
    currentStep = 1;
    errors = {};
    showSuccess = false;
  }
  
  function getProgressPercentage() {
    return (currentStep / steps.length) * 100;
  }
  
  function isStepCompleted(stepNumber) {
    return stepNumber < currentStep;
  }
  
  function isStepAccessible(stepNumber) {
    return stepNumber <= currentStep;
  }
  
  $: progressPercentage = getProgressPercentage();
</script>

<div class="wizard-container">
  <div class="wizard-header">
    <h1>Multi-Step Registration</h1>
    <p class="wizard-description">Complete your registration in a few simple steps</p>
  </div>

  <div class="wizard-progress">
    <div class="progress-bar">
      <div 
        class="progress-fill" 
        style="width: {progressPercentage}%"
      ></div>
    </div>
    <div class="progress-text">
      Step {currentStep} of {steps.length} ({Math.round(progressPercentage)}% complete)
    </div>
  </div>

  <div class="wizard-steps">
    {#each steps as step}
      <div 
        class="step-indicator"
        class:completed={isStepCompleted(step.id)}
        class:current={step.id === currentStep}
        class:accessible={isStepAccessible(step.id)}
        on:click={() => goToStep(step.id)}
      >
        <div class="step-icon">
          {#if isStepCompleted(step.id)}
            ✓
          {:else}
            {step.icon}
          {/if}
        </div>
        <div class="step-content">
          <h3 class="step-title">{step.title}</h3>
          <p class="step-description">{step.description}</p>
        </div>
      </div>
    {/each}
  </div>

  <div class="wizard-content">
    {#if showSuccess}
      <div class="success-message">
        <div class="success-icon">🎉</div>
        <h2>Registration Complete!</h2>
        <p>Thank you for completing the registration process. You will receive a confirmation email shortly.</p>
        <button 
          on:click={resetForm}
          class="reset-btn"
        >
          Start New Registration
        </button>
      </div>
    {:else}
      <div class="step-content">
        {#if currentStep === 1}
          <div class="form-section">
            <h2>Personal Information</h2>
            <p class="section-description">Please provide your basic personal details</p>
            
            <div class="form-grid">
              <div class="form-group">
                <label for="firstName" class="form-label">First Name *</label>
                <input
                  id="firstName"
                  type="text"
                  bind:value={formData.personalInfo.firstName}
                  class="form-input"
                  class:error={errors.firstName}
                  placeholder="Enter your first name"
                />
                {#if errors.firstName}
                  <span class="error-message">{errors.firstName}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="lastName" class="form-label">Last Name *</label>
                <input
                  id="lastName"
                  type="text"
                  bind:value={formData.personalInfo.lastName}
                  class="form-input"
                  class:error={errors.lastName}
                  placeholder="Enter your last name"
                />
                {#if errors.lastName}
                  <span class="error-message">{errors.lastName}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="email" class="form-label">Email Address *</label>
                <input
                  id="email"
                  type="email"
                  bind:value={formData.personalInfo.email}
                  class="form-input"
                  class:error={errors.email}
                  placeholder="Enter your email address"
                />
                {#if errors.email}
                  <span class="error-message">{errors.email}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="phone" class="form-label">Phone Number *</label>
                <input
                  id="phone"
                  type="tel"
                  bind:value={formData.personalInfo.phone}
                  class="form-input"
                  class:error={errors.phone}
                  placeholder="Enter your phone number"
                />
                {#if errors.phone}
                  <span class="error-message">{errors.phone}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="dateOfBirth" class="form-label">Date of Birth *</label>
                <input
                  id="dateOfBirth"
                  type="date"
                  bind:value={formData.personalInfo.dateOfBirth}
                  class="form-input"
                  class:error={errors.dateOfBirth}
                />
                {#if errors.dateOfBirth}
                  <span class="error-message">{errors.dateOfBirth}</span>
                {/if}
              </div>
            </div>
          </div>
        {/if}

        {#if currentStep === 2}
          <div class="form-section">
            <h2>Address Information</h2>
            <p class="section-description">Where should we send your items?</p>
            
            <div class="form-grid">
              <div class="form-group full-width">
                <label for="street" class="form-label">Street Address *</label>
                <input
                  id="street"
                  type="text"
                  bind:value={formData.addressInfo.street}
                  class="form-input"
                  class:error={errors.street}
                  placeholder="Enter your street address"
                />
                {#if errors.street}
                  <span class="error-message">{errors.street}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="city" class="form-label">City *</label>
                <input
                  id="city"
                  type="text"
                  bind:value={formData.addressInfo.city}
                  class="form-input"
                  class:error={errors.city}
                  placeholder="Enter your city"
                />
                {#if errors.city}
                  <span class="error-message">{errors.city}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="state" class="form-label">State *</label>
                <select
                  id="state"
                  bind:value={formData.addressInfo.state}
                  class="form-select"
                  class:error={errors.state}
                >
                  <option value="">Select a state</option>
                  {#each states as state}
                    <option value={state.value}>{state.label}</option>
                  {/each}
                </select>
                {#if errors.state}
                  <span class="error-message">{errors.state}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="zipCode" class="form-label">ZIP Code *</label>
                <input
                  id="zipCode"
                  type="text"
                  bind:value={formData.addressInfo.zipCode}
                  class="form-input"
                  class:error={errors.zipCode}
                  placeholder="Enter your ZIP code"
                />
                {#if errors.zipCode}
                  <span class="error-message">{errors.zipCode}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="country" class="form-label">Country</label>
                <select
                  id="country"
                  bind:value={formData.addressInfo.country}
                  class="form-select"
                >
                  {#each countries as country}
                    <option value={country.value}>{country.label}</option>
                  {/each}
                </select>
              </div>
            </div>
          </div>
        {/if}

        {#if currentStep === 3}
          <div class="form-section">
            <h2>Preferences</h2>
            <p class="section-description">Customize your experience</p>
            
            <div class="form-grid">
              <div class="form-group full-width">
                <div class="checkbox-group">
                  <label class="checkbox-label">
                    <input
                      type="checkbox"
                      bind:checked={formData.preferences.newsletter}
                      class="checkbox-input"
                    />
                    <span class="checkbox-text">Subscribe to our newsletter</span>
                  </label>
                </div>
              </div>
              
              <div class="form-group full-width">
                <div class="checkbox-group">
                  <label class="checkbox-label">
                    <input
                      type="checkbox"
                      bind:checked={formData.preferences.notifications}
                      class="checkbox-input"
                    />
                    <span class="checkbox-text">Receive email notifications</span>
                  </label>
                </div>
              </div>
              
              <div class="form-group">
                <label for="theme" class="form-label">Theme Preference</label>
                <select
                  id="theme"
                  bind:value={formData.preferences.theme}
                  class="form-select"
                >
                  {#each themes as theme}
                    <option value={theme.value}>{theme.label}</option>
                  {/each}
                </select>
              </div>
              
              <div class="form-group">
                <label for="language" class="form-label">Language</label>
                <select
                  id="language"
                  bind:value={formData.preferences.language}
                  class="form-select"
                >
                  {#each languages as language}
                    <option value={language.value}>{language.label}</option>
                  {/each}
                </select>
              </div>
            </div>
          </div>
        {/if}

        {#if currentStep === 4}
          <div class="form-section">
            <h2>Payment Information</h2>
            <p class="section-description">Secure payment details</p>
            
            <div class="form-grid">
              <div class="form-group full-width">
                <label for="cardNumber" class="form-label">Card Number *</label>
                <input
                  id="cardNumber"
                  type="text"
                  bind:value={formData.paymentInfo.cardNumber}
                  on:input={handleCardNumberInput}
                  class="form-input"
                  class:error={errors.cardNumber}
                  placeholder="1234 5678 9012 3456"
                  maxlength="19"
                />
                {#if errors.cardNumber}
                  <span class="error-message">{errors.cardNumber}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="expiryDate" class="form-label">Expiry Date *</label>
                <input
                  id="expiryDate"
                  type="text"
                  bind:value={formData.paymentInfo.expiryDate}
                  on:input={handleExpiryDateInput}
                  class="form-input"
                  class:error={errors.expiryDate}
                  placeholder="MM/YY"
                  maxlength="5"
                />
                {#if errors.expiryDate}
                  <span class="error-message">{errors.expiryDate}</span>
                {/if}
              </div>
              
              <div class="form-group">
                <label for="cvv" class="form-label">CVV *</label>
                <input
                  id="cvv"
                  type="text"
                  bind:value={formData.paymentInfo.cvv}
                  class="form-input"
                  class:error={errors.cvv}
                  placeholder="123"
                  maxlength="4"
                />
                {#if errors.cvv}
                  <span class="error-message">{errors.cvv}</span>
                {/if}
              </div>
              
              <div class="form-group full-width">
                <label for="cardholderName" class="form-label">Cardholder Name *</label>
                <input
                  id="cardholderName"
                  type="text"
                  bind:value={formData.paymentInfo.cardholderName}
                  class="form-input"
                  class:error={errors.cardholderName}
                  placeholder="Enter cardholder name"
                />
                {#if errors.cardholderName}
                  <span class="error-message">{errors.cardholderName}</span>
                {/if}
              </div>
            </div>
          </div>
        {/if}

        {#if currentStep === 5}
          <div class="form-section">
            <h2>Review & Confirm</h2>
            <p class="section-description">Please review your information before submitting</p>
            
            <div class="review-summary">
              <div class="review-section">
                <h3>Personal Information</h3>
                <div class="review-item">
                  <span class="review-label">Name:</span>
                  <span class="review-value">{formData.personalInfo.firstName} {formData.personalInfo.lastName}</span>
                </div>
                <div class="review-item">
                  <span class="review-label">Email:</span>
                  <span class="review-value">{formData.personalInfo.email}</span>
                </div>
                <div class="review-item">
                  <span class="review-label">Phone:</span>
                  <span class="review-value">{formData.personalInfo.phone}</span>
                </div>
              </div>
              
              <div class="review-section">
                <h3>Address</h3>
                <div class="review-item">
                  <span class="review-label">Address:</span>
                  <span class="review-value">{formData.addressInfo.street}, {formData.addressInfo.city}, {formData.addressInfo.state} {formData.addressInfo.zipCode}</span>
                </div>
              </div>
              
              <div class="review-section">
                <h3>Preferences</h3>
                <div class="review-item">
                  <span class="review-label">Newsletter:</span>
                  <span class="review-value">{formData.preferences.newsletter ? 'Yes' : 'No'}</span>
                </div>
                <div class="review-item">
                  <span class="review-label">Theme:</span>
                  <span class="review-value">{formData.preferences.theme}</span>
                </div>
              </div>
            </div>
            
            <div class="terms-section">
              <div class="checkbox-group">
                <label class="checkbox-label">
                  <input
                    type="checkbox"
                    bind:checked={formData.review.termsAccepted}
                    class="checkbox-input"
                    class:error={errors.termsAccepted}
                  />
                  <span class="checkbox-text">I accept the <a href="#" class="link">Terms and Conditions</a> *</span>
                </label>
                {#if errors.termsAccepted}
                  <span class="error-message">{errors.termsAccepted}</span>
                {/if}
              </div>
              
              <div class="checkbox-group">
                <label class="checkbox-label">
                  <input
                    type="checkbox"
                    bind:checked={formData.review.privacyAccepted}
                    class="checkbox-input"
                    class:error={errors.privacyAccepted}
                  />
                  <span class="checkbox-text">I accept the <a href="#" class="link">Privacy Policy</a> *</span>
                </label>
                {#if errors.privacyAccepted}
                  <span class="error-message">{errors.privacyAccepted}</span>
                {/if}
              </div>
              
              <div class="checkbox-group">
                <label class="checkbox-label">
                  <input
                    type="checkbox"
                    bind:checked={formData.review.marketingAccepted}
                    class="checkbox-input"
                  />
                  <span class="checkbox-text">I would like to receive marketing communications</span>
                </label>
              </div>
            </div>
          </div>
        {/if}
      </div>
    {/if}
  </div>

  <div class="wizard-actions">
    {#if !showSuccess}
      <div class="action-buttons">
        {#if currentStep > 1}
          <button 
            on:click={previousStep}
            class="btn btn-secondary"
          >
            ← Previous
          </button>
        {/if}
        
        {#if currentStep < steps.length}
          <button 
            on:click={nextStep}
            class="btn btn-primary"
          >
            Next →
          </button>
        {:else}
          <button 
            on:click={submitForm}
            disabled={isSubmitting}
            class="btn btn-primary"
          >
            {isSubmitting ? 'Submitting...' : 'Submit Registration'}
          </button>
        {/if}
      </div>
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
    margin-bottom: 40px;
  }

  .wizard-header h1 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 32px;
  }

  .wizard-description {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .wizard-progress {
    margin-bottom: 40px;
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
    background: linear-gradient(90deg, #4caf50, #45a049);
    transition: width 0.3s ease;
  }

  .progress-text {
    text-align: center;
    color: #666;
    font-size: 14px;
    font-weight: 600;
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
    left: 0;
    right: 0;
    height: 2px;
    background: #e0e0e0;
    z-index: 1;
  }

  .step-indicator {
    display: flex;
    flex-direction: column;
    align-items: center;
    cursor: pointer;
    position: relative;
    z-index: 2;
    transition: all 0.3s ease;
  }

  .step-indicator:not(.accessible) {
    cursor: not-allowed;
    opacity: 0.5;
  }

  .step-indicator.accessible:hover {
    transform: translateY(-2px);
  }

  .step-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #e0e0e0;
    color: #666;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
    transition: all 0.3s ease;
  }

  .step-indicator.current .step-icon {
    background: #4caf50;
    color: white;
    box-shadow: 0 0 0 4px rgba(76, 175, 80, 0.2);
  }

  .step-indicator.completed .step-icon {
    background: #4caf50;
    color: white;
  }

  .step-content {
    text-align: center;
  }

  .step-title {
    margin: 0 0 5px 0;
    color: #333;
    font-size: 14px;
    font-weight: 600;
  }

  .step-indicator.current .step-title {
    color: #4caf50;
  }

  .step-description {
    margin: 0;
    color: #666;
    font-size: 12px;
  }

  .wizard-content {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 30px;
    margin-bottom: 30px;
    min-height: 400px;
  }

  .success-message {
    text-align: center;
    padding: 60px 20px;
  }

  .success-icon {
    font-size: 64px;
    margin-bottom: 20px;
  }

  .success-message h2 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 28px;
  }

  .success-message p {
    margin: 0 0 30px 0;
    color: #666;
    font-size: 16px;
  }

  .reset-btn {
    padding: 12px 24px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .reset-btn:hover {
    background: #45a049;
  }

  .form-section h2 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 24px;
  }

  .section-description {
    margin: 0 0 30px 0;
    color: #666;
    font-size: 16px;
  }

  .form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }

  .form-group {
    display: flex;
    flex-direction: column;
  }

  .form-group.full-width {
    grid-column: 1 / -1;
  }

  .form-label {
    margin-bottom: 8px;
    color: #333;
    font-weight: 600;
    font-size: 14px;
  }

  .form-input,
  .form-select {
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
  }

  .form-input:focus,
  .form-select:focus {
    outline: none;
    border-color: #4caf50;
  }

  .form-input.error,
  .form-select.error {
    border-color: #f44336;
  }

  .error-message {
    color: #f44336;
    font-size: 12px;
    margin-top: 5px;
  }

  .checkbox-group {
    margin-bottom: 15px;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 14px;
  }

  .checkbox-input {
    margin-right: 10px;
    width: 16px;
    height: 16px;
  }

  .checkbox-input.error {
    accent-color: #f44336;
  }

  .checkbox-text {
    color: #333;
  }

  .link {
    color: #4caf50;
    text-decoration: none;
  }

  .link:hover {
    text-decoration: underline;
  }

  .review-summary {
    margin-bottom: 30px;
  }

  .review-section {
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 1px solid #f0f0f0;
  }

  .review-section:last-child {
    border-bottom: none;
    margin-bottom: 0;
  }

  .review-section h3 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 18px;
  }

  .review-item {
    display: flex;
    margin-bottom: 8px;
  }

  .review-label {
    font-weight: 600;
    color: #666;
    width: 120px;
    flex-shrink: 0;
  }

  .review-value {
    color: #333;
  }

  .terms-section {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 6px;
  }

  .wizard-actions {
    display: flex;
    justify-content: center;
  }

  .action-buttons {
    display: flex;
    gap: 15px;
  }

  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .btn-primary {
    background: #4caf50;
    color: white;
  }

  .btn-primary:hover:not(:disabled) {
    background: #45a049;
  }

  .btn-secondary {
    background: #f5f5f5;
    color: #666;
    border: 1px solid #ddd;
  }

  .btn-secondary:hover {
    background: #e0e0e0;
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
    
    .step-indicator {
      flex-direction: row;
      text-align: left;
    }
    
    .step-icon {
      margin-right: 15px;
      margin-bottom: 0;
    }
    
    .wizard-content {
      padding: 20px;
    }
    
    .form-grid {
      grid-template-columns: 1fr;
    }
    
    .action-buttons {
      flex-direction: column;
      width: 100%;
    }
    
    .btn {
      width: 100%;
    }
  }

  @media (max-width: 480px) {
    .wizard-container {
      padding: 10px;
    }
    
    .wizard-header h1 {
      font-size: 24px;
    }
    
    .wizard-content {
      padding: 15px;
    }
    
    .step-content {
      text-align: left;
    }
  }
</style>

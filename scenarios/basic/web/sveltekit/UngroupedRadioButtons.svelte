<script>
  let formData = {
    name: '',
    email: '',
    phone: '',
    company: '',
    industry: '',
    budget: '',
    timeline: '',
    features: [],
    preferences: [],
    communication: '',
    newsletter: false,
    notifications: false,
    terms: false
  };
  
  let errors = {};
  let isSubmitting = false;
  let showSuccess = false;
  
  const industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Retail',
    'Manufacturing',
    'Other'
  ];
  
  const budgetRanges = [
    'Under $10,000',
    '$10,000 - $25,000',
    '$25,000 - $50,000',
    '$50,000 - $100,000',
    'Over $100,000'
  ];
  
  const timelines = [
    'ASAP',
    'Within 1 month',
    '1-3 months',
    '3-6 months',
    '6+ months'
  ];
  
  const features = [
    'User Authentication',
    'Payment Processing',
    'Real-time Chat',
    'File Upload',
    'Analytics Dashboard',
    'Mobile App',
    'API Integration',
    'Custom Design'
  ];
  
  const preferences = [
    'Email Updates',
    'Phone Calls',
    'SMS Notifications',
    'Video Meetings',
    'In-person Meetings'
  ];
  
  function validateForm() {
    errors = {};
    
    if (!formData.name.trim()) {
      errors.name = 'Name is required';
    }
    
    if (!formData.email.trim()) {
      errors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      errors.email = 'Email is invalid';
    }
    
    if (!formData.phone.trim()) {
      errors.phone = 'Phone number is required';
    }
    
    if (!formData.company.trim()) {
      errors.company = 'Company name is required';
    }
    
    if (!formData.industry) {
      errors.industry = 'Please select an industry';
    }
    
    if (!formData.budget) {
      errors.budget = 'Please select a budget range';
    }
    
    if (!formData.timeline) {
      errors.timeline = 'Please select a timeline';
    }
    
    if (formData.features.length === 0) {
      errors.features = 'Please select at least one feature';
    }
    
    if (formData.preferences.length === 0) {
      errors.preferences = 'Please select at least one communication preference';
    }
    
    if (!formData.communication) {
      errors.communication = 'Please select your preferred communication method';
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
          company: '',
          industry: '',
          budget: '',
          timeline: '',
          features: [],
          preferences: [],
          communication: '',
          newsletter: false,
          notifications: false,
          terms: false
        };
      }, 2000);
    }
  }
  
  function handleFeatureChange(feature) {
    if (formData.features.includes(feature)) {
      formData.features = formData.features.filter(f => f !== feature);
    } else {
      formData.features = [...formData.features, feature];
    }
  }
  
  function handlePreferenceChange(preference) {
    if (formData.preferences.includes(preference)) {
      formData.preferences = formData.preferences.filter(p => p !== preference);
    } else {
      formData.preferences = [...formData.preferences, preference];
    }
  }
</script>

<div class="contact-form">
  <header class="form-header">
    <h1 class="form-title">Get Started Today</h1>
    <p class="form-subtitle">Tell us about your project and we'll help you bring it to life</p>
  </header>

  {#if showSuccess}
    <div class="success-message">
      <div class="success-icon">✓</div>
      <h2 class="success-title">Thank You!</h2>
      <p class="success-description">Your information has been submitted successfully. We'll be in touch within 24 hours.</p>
      <button 
        class="success-btn" 
        on:click={() => showSuccess = false}
      >
        Submit Another Request
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
              bind:value={formData.phone}
              class="form-input" 
              class:error={errors.phone}
              placeholder="Enter your phone number"
            />
            {#if errors.phone}
              <span class="error-message">{errors.phone}</span>
            {/if}
          </div>
          
          <div class="form-group">
            <label class="form-label" for="company">Company Name *</label>
            <input 
              type="text" 
              id="company"
              bind:value={formData.company}
              class="form-input" 
              class:error={errors.company}
              placeholder="Enter your company name"
            />
            {#if errors.company}
              <span class="error-message">{errors.company}</span>
            {/if}
          </div>
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Project Details</h2>
        
        <div class="form-group">
          <label class="form-label">Industry *</label>
          <div class="radio-group">
            {#each industries as industry (industry)}
              <label class="radio-option">
                <input 
                  type="radio" 
                  bind:group={formData.industry} 
                  value={industry}
                  class="radio-input"
                />
                <span class="radio-label">{industry}</span>
              </label>
            {/each}
          </div>
          {#if errors.industry}
            <span class="error-message">{errors.industry}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <label class="form-label">Budget Range *</label>
          <div class="radio-group">
            {#each budgetRanges as budget (budget)}
              <label class="radio-option">
                <input 
                  type="radio" 
                  bind:group={formData.budget} 
                  value={budget}
                  class="radio-input"
                />
                <span class="radio-label">{budget}</span>
              </label>
            {/each}
          </div>
          {#if errors.budget}
            <span class="error-message">{errors.budget}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <label class="form-label">Project Timeline *</label>
          <div class="radio-group">
            {#each timelines as timeline (timeline)}
              <label class="radio-option">
                <input 
                  type="radio" 
                  bind:group={formData.timeline} 
                  value={timeline}
                  class="radio-input"
                />
                <span class="radio-label">{timeline}</span>
              </label>
            {/each}
          </div>
          {#if errors.timeline}
            <span class="error-message">{errors.timeline}</span>
          {/if}
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Features & Requirements</h2>
        
        <div class="form-group">
          <label class="form-label">Desired Features * (Select all that apply)</label>
          <div class="checkbox-group">
            {#each features as feature (feature)}
              <label class="checkbox-option">
                <input 
                  type="checkbox" 
                  checked={formData.features.includes(feature)}
                  on:change={() => handleFeatureChange(feature)}
                  class="checkbox-input"
                />
                <span class="checkbox-label">{feature}</span>
              </label>
            {/each}
          </div>
          {#if errors.features}
            <span class="error-message">{errors.features}</span>
          {/if}
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Communication Preferences</h2>
        
        <div class="form-group">
          <label class="form-label">How would you like us to contact you? *</label>
          <div class="radio-group">
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.communication} 
                value="email"
                class="radio-input"
              />
              <span class="radio-label">Email</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.communication} 
                value="phone"
                class="radio-input"
              />
              <span class="radio-label">Phone Call</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.communication} 
                value="video"
                class="radio-input"
              />
              <span class="radio-label">Video Meeting</span>
            </label>
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.communication} 
                value="in-person"
                class="radio-input"
              />
              <span class="radio-label">In-Person Meeting</span>
            </label>
          </div>
          {#if errors.communication}
            <span class="error-message">{errors.communication}</span>
          {/if}
        </div>
        
        <div class="form-group">
          <label class="form-label">Update Preferences * (Select all that apply)</label>
          <div class="checkbox-group">
            {#each preferences as preference (preference)}
              <label class="checkbox-option">
                <input 
                  type="checkbox" 
                  checked={formData.preferences.includes(preference)}
                  on:change={() => handlePreferenceChange(preference)}
                  class="checkbox-input"
                />
                <span class="checkbox-label">{preference}</span>
              </label>
            {/each}
          </div>
          {#if errors.preferences}
            <span class="error-message">{errors.preferences}</span>
          {/if}
        </div>
      </div>

      <div class="form-section">
        <h2 class="section-title">Additional Options</h2>
        
        <div class="form-group">
          <div class="checkbox-option">
            <input 
              type="checkbox" 
              bind:checked={formData.newsletter}
              class="checkbox-input"
            />
            <span class="checkbox-label">Subscribe to our newsletter for project updates and tips</span>
          </div>
        </div>
        
        <div class="form-group">
          <div class="checkbox-option">
            <input 
              type="checkbox" 
              bind:checked={formData.notifications}
              class="checkbox-input"
            />
            <span class="checkbox-label">Receive notifications about new features and services</span>
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
              company: '',
              industry: '',
              budget: '',
              timeline: '',
              features: [],
              preferences: [],
              communication: '',
              newsletter: false,
              notifications: false,
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
          {isSubmitting ? 'Submitting...' : 'Submit Request'}
        </button>
      </div>
    </form>
  {/if}
</div>

<style>
  .contact-form {
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
  
  .form-input {
    width: 100%;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.2s ease;
  }
  
  .form-input:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
  }
  
  .form-input.error {
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
  
  .checkbox-group {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 15px;
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
    
    .checkbox-group {
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

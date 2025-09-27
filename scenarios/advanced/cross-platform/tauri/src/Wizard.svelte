<script>
  export let data
  
  let currentStep = 1
  let formData = {
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    dateOfBirth: '',
    username: '',
    password: '',
    confirmPassword: '',
    securityQuestion: '',
    securityAnswer: '',
    newsletter: false,
    promotions: false,
    updates: false,
    timezone: '',
    language: '',
    bio: ''
  }
  let errors = {}
  let steps = []
  
  $: {
    if (data) {
      steps = JSON.parse(data).steps || []
    }
  }
  
  $: progress = (currentStep / steps.length) * 100
  
  function nextStep() {
    if (validateCurrentStep()) {
      if (currentStep < steps.length) {
        currentStep++
      }
    }
  }
  
  function previousStep() {
    if (currentStep > 1) {
      currentStep--
    }
  }
  
  function validateCurrentStep() {
    errors = {}
    const currentStepData = steps.find(s => s.id === currentStep)
    
    if (currentStepData) {
      currentStepData.fields.forEach(field => {
        if (field === 'firstName' && !formData.firstName.trim()) {
          errors.firstName = 'First name is required'
        }
        if (field === 'lastName' && !formData.lastName.trim()) {
          errors.lastName = 'Last name is required'
        }
        if (field === 'email' && !formData.email.trim()) {
          errors.email = 'Email is required'
        } else if (field === 'email' && formData.email && !isValidEmail(formData.email)) {
          errors.email = 'Please enter a valid email address'
        }
        if (field === 'password' && !formData.password.trim()) {
          errors.password = 'Password is required'
        } else if (field === 'password' && formData.password && formData.password.length < 8) {
          errors.password = 'Password must be at least 8 characters long'
        }
        if (field === 'confirmPassword' && formData.password !== formData.confirmPassword) {
          errors.confirmPassword = 'Passwords do not match'
        }
      })
    }
    
    return Object.keys(errors).length === 0
  }
  
  function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
  }
  
  function submitForm() {
    if (validateCurrentStep()) {
      alert('Registration completed successfully!')
    }
  }
  
  function updateSummary() {
    // This would update the summary in step 4
  }
</script>

<div class="wizard-container">
  <div class="wizard-header">
    <h2>User Registration Wizard</h2>
    <p>Complete your profile in a few simple steps</p>
    
    <div class="progress-bar">
      <div class="progress-fill" style="width: {progress}%"></div>
    </div>
    
    <div class="step-indicators">
      {#each steps as step, index}
        <div class="step {currentStep === step.id ? 'active' : ''} {currentStep > step.id ? 'completed' : ''}">
          <div class="step-number">{step.id}</div>
          <div class="step-label">{step.title}</div>
          {#if index < steps.length - 1}
            <div class="step-line"></div>
          {/if}
        </div>
      {/each}
    </div>
  </div>
  
  <div class="wizard-content">
    {#if Object.keys(errors).length > 0}
      <div class="validation-summary">
        <h3>Please fix the following errors:</h3>
        <ul>
          {#each Object.entries(errors) as [field, error]}
            <li>{error}</li>
          {/each}
        </ul>
      </div>
    {/if}
    
    {#if currentStep === 1}
      <div class="step-content">
        <h3>Personal Information</h3>
        <p>Tell us about yourself</p>
        
        <div class="form-row">
          <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" bind:value={formData.firstName} class={errors.firstName ? 'error' : ''}>
            {#if errors.firstName}
              <div class="error-message">{errors.firstName}</div>
            {/if}
          </div>
          <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" bind:value={formData.lastName} class={errors.lastName ? 'error' : ''}>
            {#if errors.lastName}
              <div class="error-message">{errors.lastName}</div>
            {/if}
          </div>
        </div>
        
        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" bind:value={formData.email} class={errors.email ? 'error' : ''}>
          {#if errors.email}
            <div class="error-message">{errors.email}</div>
          {/if}
        </div>
        
        <div class="form-group">
          <label for="phone">Phone Number</label>
          <input type="tel" id="phone" bind:value={formData.phone}>
        </div>
        
        <div class="form-group">
          <label for="dateOfBirth">Date of Birth</label>
          <input type="date" id="dateOfBirth" bind:value={formData.dateOfBirth}>
        </div>
      </div>
    {:else if currentStep === 2}
      <div class="step-content">
        <h3>Account Details</h3>
        <p>Set up your login credentials</p>
        
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" bind:value={formData.username}>
        </div>
        
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" bind:value={formData.password} class={errors.password ? 'error' : ''}>
          {#if errors.password}
            <div class="error-message">{errors.password}</div>
          {/if}
        </div>
        
        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <input type="password" id="confirmPassword" bind:value={formData.confirmPassword} class={errors.confirmPassword ? 'error' : ''}>
          {#if errors.confirmPassword}
            <div class="error-message">{errors.confirmPassword}</div>
          {/if}
        </div>
        
        <div class="form-group">
          <label for="securityQuestion">Security Question</label>
          <select id="securityQuestion" bind:value={formData.securityQuestion}>
            <option value="">Select a security question</option>
            <option value="mother">What is your mother's maiden name?</option>
            <option value="pet">What was the name of your first pet?</option>
            <option value="school">What was the name of your first school?</option>
            <option value="city">In what city were you born?</option>
          </select>
        </div>
        
        <div class="form-group">
          <label for="securityAnswer">Security Answer</label>
          <input type="text" id="securityAnswer" bind:value={formData.securityAnswer}>
        </div>
      </div>
    {:else if currentStep === 3}
      <div class="step-content">
        <h3>Preferences</h3>
        <p>Customize your experience</p>
        
        <div class="form-group">
          <label>Communication Preferences</label>
          <div class="checkbox-group">
            <label>
              <input type="checkbox" bind:checked={formData.newsletter}>
              Subscribe to newsletter
            </label>
          </div>
          <div class="checkbox-group">
            <label>
              <input type="checkbox" bind:checked={formData.promotions}>
              Receive promotional emails
            </label>
          </div>
          <div class="checkbox-group">
            <label>
              <input type="checkbox" bind:checked={formData.updates}>
              Get product updates
            </label>
          </div>
        </div>
        
        <div class="form-group">
          <label for="timezone">Timezone</label>
          <select id="timezone" bind:value={formData.timezone}>
            <option value="">Select your timezone</option>
            <option value="UTC-8">UTC-8 (Pacific Time)</option>
            <option value="UTC-7">UTC-7 (Mountain Time)</option>
            <option value="UTC-6">UTC-6 (Central Time)</option>
            <option value="UTC-5">UTC-5 (Eastern Time)</option>
            <option value="UTC+0">UTC+0 (Greenwich)</option>
          </select>
        </div>
        
        <div class="form-group">
          <label for="language">Preferred Language</label>
          <select id="language" bind:value={formData.language}>
            <option value="">Select your language</option>
            <option value="en">English</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
            <option value="de">German</option>
          </select>
        </div>
        
        <div class="form-group">
          <label for="bio">Bio (Optional)</label>
          <textarea id="bio" bind:value={formData.bio} rows="4" placeholder="Tell us a bit about yourself..."></textarea>
        </div>
      </div>
    {:else if currentStep === 4}
      <div class="step-content">
        <h3>Review Your Information</h3>
        <p>Please review your information before submitting</p>
        
        <div class="summary-item">
          <span class="summary-label">Name:</span>
          <span class="summary-value">{formData.firstName} {formData.lastName}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Email:</span>
          <span class="summary-value">{formData.email}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Phone:</span>
          <span class="summary-value">{formData.phone || 'Not provided'}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Username:</span>
          <span class="summary-value">{formData.username}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Timezone:</span>
          <span class="summary-value">{formData.timezone || 'Not selected'}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Language:</span>
          <span class="summary-value">{formData.language || 'Not selected'}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">Newsletter:</span>
          <span class="summary-value">{formData.newsletter ? 'Yes' : 'No'}</span>
        </div>
      </div>
    {/if}
  </div>
  
  <div class="wizard-footer">
    <button class="btn btn-secondary" on:click={previousStep} disabled={currentStep === 1}>Previous</button>
    <div>
      {#if currentStep < steps.length}
        <button class="btn btn-primary" on:click={nextStep}>Next</button>
      {:else}
        <button class="btn btn-success" on:click={submitForm}>Complete Registration</button>
      {/if}
    </div>
  </div>
</div>

<style>
  .wizard-container {
    max-width: 800px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .wizard-header {
    background: #f8f9fa;
    padding: 20px;
    border-bottom: 1px solid #dee2e6;
  }
  
  .wizard-header h2 {
    margin: 0 0 10px 0;
    color: #333;
  }
  
  .wizard-header p {
    margin: 0 0 20px 0;
    color: #666;
  }
  
  .progress-bar {
    width: 100%;
    height: 8px;
    background: #e9ecef;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 20px;
  }
  
  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #28a745, #20c997);
    transition: width 0.3s ease;
  }
  
  .step-indicators {
    display: flex;
    justify-content: space-between;
  }
  
  .step {
    display: flex;
    align-items: center;
    flex: 1;
  }
  
  .step-number {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: #6c757d;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    margin-right: 10px;
  }
  
  .step.active .step-number {
    background: #007bff;
  }
  
  .step.completed .step-number {
    background: #28a745;
  }
  
  .step-label {
    font-weight: 500;
    color: #495057;
  }
  
  .step.active .step-label {
    color: #007bff;
  }
  
  .step.completed .step-label {
    color: #28a745;
  }
  
  .step-line {
    flex: 1;
    height: 2px;
    background: #dee2e6;
    margin: 0 10px;
  }
  
  .step.completed + .step .step-line {
    background: #28a745;
  }
  
  .wizard-content {
    padding: 30px;
    min-height: 400px;
  }
  
  .step-content h3 {
    margin: 0 0 10px 0;
    color: #333;
  }
  
  .step-content p {
    margin: 0 0 20px 0;
    color: #666;
  }
  
  .form-row {
    display: flex;
    gap: 20px;
  }
  
  .form-row .form-group {
    flex: 1;
  }
  
  .form-group {
    margin-bottom: 20px;
  }
  
  .form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #495057;
  }
  
  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 12px;
    border: 2px solid #e9ecef;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.3s ease;
  }
  
  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .form-group input.error,
  .form-group select.error,
  .form-group textarea.error {
    border-color: #dc3545;
  }
  
  .error-message {
    color: #dc3545;
    font-size: 14px;
    margin-top: 5px;
  }
  
  .checkbox-group {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .checkbox-group input[type="checkbox"] {
    width: auto;
    margin-right: 10px;
  }
  
  .validation-summary {
    background: #f8d7da;
    color: #721c24;
    padding: 15px;
    border-radius: 6px;
    margin-bottom: 20px;
  }
  
  .validation-summary h3 {
    margin: 0 0 10px 0;
  }
  
  .validation-summary ul {
    margin: 0;
    padding-left: 20px;
  }
  
  .summary-item {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #e9ecef;
  }
  
  .summary-item:last-child {
    border-bottom: none;
  }
  
  .summary-label {
    font-weight: 600;
    color: #495057;
  }
  
  .summary-value {
    color: #6c757d;
  }
  
  .wizard-footer {
    padding: 20px 30px;
    background: #f8f9fa;
    border-top: 1px solid #dee2e6;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  
  .btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  
  .btn-primary {
    background: #007bff;
    color: white;
  }
  
  .btn-primary:hover {
    background: #0056b3;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
  
  .btn-success {
    background: #28a745;
    color: white;
  }
  
  .btn-success:hover {
    background: #1e7e34;
  }
</style>

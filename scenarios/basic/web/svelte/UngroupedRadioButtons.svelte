<script>
  let formData = {
    name: '',
    email: '',
    phone: '',
    preferredContact: '',
    newsletter: false,
    notifications: false,
    marketing: false,
    experience: '',
    budget: '',
    timeline: '',
    features: [],
    comments: ''
  };

  const experienceOptions = [
    { value: 'beginner', label: 'Beginner' },
    { value: 'intermediate', label: 'Intermediate' },
    { value: 'advanced', label: 'Advanced' },
    { value: 'expert', label: 'Expert' }
  ];

  const budgetOptions = [
    { value: 'under-5k', label: 'Under $5,000' },
    { value: '5k-10k', label: '$5,000 - $10,000' },
    { value: '10k-25k', label: '$10,000 - $25,000' },
    { value: '25k-50k', label: '$25,000 - $50,000' },
    { value: 'over-50k', label: 'Over $50,000' }
  ];

  const timelineOptions = [
    { value: 'asap', label: 'ASAP' },
    { value: '1-month', label: 'Within 1 month' },
    { value: '3-months', label: 'Within 3 months' },
    { value: '6-months', label: 'Within 6 months' },
    { value: 'flexible', label: 'Flexible' }
  ];

  const featureOptions = [
    { value: 'responsive', label: 'Responsive Design' },
    { value: 'ecommerce', label: 'E-commerce Integration' },
    { value: 'cms', label: 'Content Management' },
    { value: 'seo', label: 'SEO Optimization' },
    { value: 'analytics', label: 'Analytics Integration' },
    { value: 'security', label: 'Security Features' },
    { value: 'mobile', label: 'Mobile App' },
    { value: 'api', label: 'API Development' }
  ];

  function handleFeatureChange(feature) {
    if (formData.features.includes(feature)) {
      formData.features = formData.features.filter(f => f !== feature);
    } else {
      formData.features = [...formData.features, feature];
    }
  }

  function handleSubmit() {
    alert('Form submitted successfully!');
    console.log('Form data:', formData);
  }

  function handleReset() {
    formData = {
      name: '',
      email: '',
      phone: '',
      preferredContact: '',
      newsletter: false,
      notifications: false,
      marketing: false,
      experience: '',
      budget: '',
      timeline: '',
      features: [],
      comments: ''
    };
  }
</script>

<div class="project-consultation">
  <header class="form-header">
    <h1>Project Consultation Form</h1>
    <p>Tell us about your project and we'll provide a customized solution</p>
  </header>

  <form class="consultation-form" on:submit|preventDefault={handleSubmit}>
    <div class="form-section">
      <h2 class="section-title">Personal Information</h2>
      
      <div class="form-group">
        <label for="name" class="form-label">Full Name *</label>
        <input 
          type="text" 
          id="name" 
          bind:value={formData.name}
          class="form-input"
          required
        />
      </div>

      <div class="form-group">
        <label for="email" class="form-label">Email Address *</label>
        <input 
          type="email" 
          id="email" 
          bind:value={formData.email}
          class="form-input"
          required
        />
      </div>

      <div class="form-group">
        <label for="phone" class="form-label">Phone Number</label>
        <input 
          type="tel" 
          id="phone" 
          bind:value={formData.phone}
          class="form-input"
        />
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Communication Preferences</h2>
      <p class="section-description">How would you like us to contact you?</p>
      
      <div class="radio-group">
        <label class="radio-option">
          <input 
            type="radio" 
            bind:group={formData.preferredContact}
            value="email"
            class="radio-input"
          />
          <span class="radio-label">Email</span>
        </label>
        
        <label class="radio-option">
          <input 
            type="radio" 
            bind:group={formData.preferredContact}
            value="phone"
            class="radio-input"
          />
          <span class="radio-label">Phone Call</span>
        </label>
        
        <label class="radio-option">
          <input 
            type="radio" 
            bind:group={formData.preferredContact}
            value="video"
            class="radio-input"
          />
          <span class="radio-label">Video Call</span>
        </label>
        
        <label class="radio-option">
          <input 
            type="radio" 
            bind:group={formData.preferredContact}
            value="in-person"
            class="radio-input"
          />
          <span class="radio-label">In-Person Meeting</span>
        </label>
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Project Details</h2>
      
      <div class="form-group">
        <label class="form-label">Experience Level *</label>
        <div class="radio-group">
          {#each experienceOptions as option}
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.experience}
                value={option.value}
                class="radio-input"
                required
              />
              <span class="radio-label">{option.label}</span>
            </label>
          {/each}
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Project Budget *</label>
        <div class="radio-group">
          {#each budgetOptions as option}
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.budget}
                value={option.value}
                class="radio-input"
                required
              />
              <span class="radio-label">{option.label}</span>
            </label>
          {/each}
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Project Timeline *</label>
        <div class="radio-group">
          {#each timelineOptions as option}
            <label class="radio-option">
              <input 
                type="radio" 
                bind:group={formData.timeline}
                value={option.value}
                class="radio-input"
                required
              />
              <span class="radio-label">{option.label}</span>
            </label>
          {/each}
        </div>
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Desired Features</h2>
      <p class="section-description">Select all features that apply to your project</p>
      
      <div class="checkbox-group">
        {#each featureOptions as option}
          <label class="checkbox-option">
            <input 
              type="checkbox" 
              checked={formData.features.includes(option.value)}
              on:change={() => handleFeatureChange(option.value)}
              class="checkbox-input"
            />
            <span class="checkbox-label">{option.label}</span>
          </label>
        {/each}
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Additional Information</h2>
      
      <div class="form-group">
        <label for="comments" class="form-label">Project Description</label>
        <textarea 
          id="comments" 
          bind:value={formData.comments}
          class="form-textarea"
          rows="5"
          placeholder="Please describe your project in detail..."
        ></textarea>
      </div>
    </div>

    <div class="form-section">
      <h2 class="section-title">Marketing Preferences</h2>
      <p class="section-description">How would you like to receive updates?</p>
      
      <div class="checkbox-group">
        <label class="checkbox-option">
          <input 
            type="checkbox" 
            bind:checked={formData.newsletter}
            class="checkbox-input"
          />
          <span class="checkbox-label">Newsletter Updates</span>
        </label>
        
        <label class="checkbox-option">
          <input 
            type="checkbox" 
            bind:checked={formData.notifications}
            class="checkbox-input"
          />
          <span class="checkbox-label">Project Notifications</span>
        </label>
        
        <label class="checkbox-option">
          <input 
            type="checkbox" 
            bind:checked={formData.marketing}
            class="checkbox-input"
          />
          <span class="checkbox-label">Marketing Communications</span>
        </label>
      </div>
    </div>

    <div class="form-actions">
      <button type="button" class="btn secondary" on:click={handleReset}>
        Reset Form
      </button>
      <button type="submit" class="btn primary">
        Submit Consultation Request
      </button>
    </div>
  </form>

  <div class="form-info">
    <h3>What happens next?</h3>
    <div class="info-steps">
      <div class="step">
        <div class="step-number">1</div>
        <div class="step-content">
          <h4>Review</h4>
          <p>We'll review your project requirements and preferences</p>
        </div>
      </div>
      
      <div class="step">
        <div class="step-number">2</div>
        <div class="step-content">
          <h4>Consultation</h4>
          <p>Schedule a free consultation call to discuss your project</p>
        </div>
      </div>
      
      <div class="step">
        <div class="step-number">3</div>
        <div class="step-content">
          <h4>Proposal</h4>
          <p>Receive a detailed proposal with timeline and pricing</p>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .project-consultation {
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

  .consultation-form {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 40px;
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
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }

  .section-description {
    margin: 0 0 20px 0;
    color: #666;
    font-size: 14px;
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
  .form-textarea {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.2s ease;
  }

  .form-input:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #007bff;
  }

  .form-textarea {
    resize: vertical;
    min-height: 120px;
  }

  .radio-group {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .radio-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border: 1px solid #eee;
    border-radius: 6px;
    transition: all 0.2s ease;
  }

  .radio-option:hover {
    background: #f8f9fa;
    border-color: #ddd;
  }

  .radio-input {
    margin: 0;
    width: 18px;
    height: 18px;
  }

  .radio-label {
    font-size: 16px;
    color: #333;
  }

  .checkbox-group {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 12px;
  }

  .checkbox-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border: 1px solid #eee;
    border-radius: 6px;
    transition: all 0.2s ease;
  }

  .checkbox-option:hover {
    background: #f8f9fa;
    border-color: #ddd;
  }

  .checkbox-input {
    margin: 0;
    width: 18px;
    height: 18px;
  }

  .checkbox-label {
    font-size: 16px;
    color: #333;
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

  .btn.primary:hover {
    background: #0056b3;
  }

  .btn.secondary {
    background: #6c757d;
    color: white;
  }

  .btn.secondary:hover {
    background: #545b62;
  }

  .form-info {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 8px;
  }

  .form-info h3 {
    margin: 0 0 25px 0;
    font-size: 24px;
    color: #333;
    text-align: center;
  }

  .info-steps {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 25px;
  }

  .step {
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }

  .step-number {
    width: 40px;
    height: 40px;
    background: #007bff;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 18px;
    flex-shrink: 0;
  }

  .step-content h4 {
    margin: 0 0 8px 0;
    font-size: 18px;
    color: #333;
  }

  .step-content p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  @media (max-width: 768px) {
    .project-consultation {
      margin: 20px auto;
      padding: 10px;
    }

    .consultation-form {
      padding: 20px;
    }

    .form-actions {
      flex-direction: column;
    }

    .btn {
      width: 100%;
    }

    .info-steps {
      grid-template-columns: 1fr;
    }
  }
</style>

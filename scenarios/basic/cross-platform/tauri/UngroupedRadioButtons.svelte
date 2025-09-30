<script>
  import { onMount } from 'svelte';
  
  let formData = {
    name: '',
    email: '',
    phone: '',
    contactMethod: '', // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
    newsletter: false,
    notifications: false,
    marketing: false,
    age: '',
    experience: '',
    interests: []
  };
  
  let interests = [
    'Web Development',
    'Mobile Development',
    'Data Science',
    'Machine Learning',
    'Cloud Computing',
    'Cybersecurity',
    'UI/UX Design',
    'DevOps'
  ];
  
  function handleInputChange(field, value) {
    formData[field] = value;
  }
  
  function handleCheckboxChange(field, checked) {
    formData[field] = checked;
  }
  
  function handleInterestChange(interest, checked) {
    if (checked) {
      formData.interests = [...formData.interests, interest];
    } else {
      formData.interests = formData.interests.filter(i => i !== interest);
    }
  }
  
  function handleSubmit() {
    alert('Form submitted successfully!');
    console.log('Form data:', formData);
  }
  
  function resetForm() {
    formData = {
      name: '',
      email: '',
      phone: '',
      contactMethod: '',
      newsletter: false,
      notifications: false,
      marketing: false,
      age: '',
      experience: '',
      interests: []
    };
  }
</script>

<div class="registration-form">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Developer Registration</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Help clicked')}>
          ❓ Help
        </button>
        <button class="header-btn" on:click={() => alert('Login clicked')}>
          🔐 Login
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="form-container">
      <div class="form-header">
        <h2 class="form-title">Join Our Developer Community</h2>
        <p class="form-subtitle">Fill out the form below to get started</p>
      </div>
      
      <form class="registration-form-content" on:submit|preventDefault={handleSubmit}>
        <div class="form-section">
          <h3 class="section-title">Personal Information</h3>
          
          <div class="form-group">
            <label for="name" class="form-label">Full Name *</label>
            <input 
              type="text" 
              id="name" 
              class="form-input" 
              placeholder="Enter your full name"
              value={formData.name}
              on:input={(e) => handleInputChange('name', e.target.value)}
              required
            />
          </div>
          
          <div class="form-group">
            <label for="email" class="form-label">Email Address *</label>
            <input 
              type="email" 
              id="email" 
              class="form-input" 
              placeholder="Enter your email address"
              value={formData.email}
              on:input={(e) => handleInputChange('email', e.target.value)}
              required
            />
          </div>
          
          <div class="form-group">
            <label for="phone" class="form-label">Phone Number</label>
            <input 
              type="tel" 
              id="phone" 
              class="form-input" 
              placeholder="Enter your phone number"
              value={formData.phone}
              on:input={(e) => handleInputChange('phone', e.target.value)}
            />
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Contact Preferences</h3>
          
          <!-- UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping -->
          <div class="form-group">
            <label class="form-label">Preferred Contact Method *</label>
            <div class="radio-group">
              <label class="radio-option">
                <input 
                  type="radio" 
                  name="contactMethod" 
                  value="email"
                  checked={formData.contactMethod === 'email'}
                  on:change={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span class="radio-label">Email</span>
              </label>
              
              <label class="radio-option">
                <input 
                  type="radio" 
                  name="contactMethod" 
                  value="phone"
                  checked={formData.contactMethod === 'phone'}
                  on:change={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span class="radio-label">Phone</span>
              </label>
              
              <label class="radio-option">
                <input 
                  type="radio" 
                  name="contactMethod" 
                  value="sms"
                  checked={formData.contactMethod === 'sms'}
                  on:change={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span class="radio-label">SMS</span>
              </label>
              
              <label class="radio-option">
                <input 
                  type="radio" 
                  name="contactMethod" 
                  value="none"
                  checked={formData.contactMethod === 'none'}
                  on:change={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span class="radio-label">No Contact</span>
              </label>
            </div>
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Communication Preferences</h3>
          
          <div class="checkbox-group">
            <label class="checkbox-option">
              <input 
                type="checkbox" 
                checked={formData.newsletter}
                on:change={(e) => handleCheckboxChange('newsletter', e.target.checked)}
              />
              <span class="checkbox-label">Subscribe to newsletter</span>
            </label>
            
            <label class="checkbox-option">
              <input 
                type="checkbox" 
                checked={formData.notifications}
                on:change={(e) => handleCheckboxChange('notifications', e.target.checked)}
              />
              <span class="checkbox-label">Receive notifications</span>
            </label>
            
            <label class="checkbox-option">
              <input 
                type="checkbox" 
                checked={formData.marketing}
                on:change={(e) => handleCheckboxChange('marketing', e.target.checked)}
              />
              <span class="checkbox-label">Receive marketing emails</span>
            </label>
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Professional Information</h3>
          
          <div class="form-group">
            <label for="age" class="form-label">Age Range</label>
            <select 
              id="age" 
              class="form-select"
              value={formData.age}
              on:change={(e) => handleInputChange('age', e.target.value)}
            >
              <option value="">Select age range</option>
              <option value="18-25">18-25</option>
              <option value="26-35">26-35</option>
              <option value="36-45">36-45</option>
              <option value="46-55">46-55</option>
              <option value="55+">55+</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="experience" class="form-label">Years of Experience</label>
            <select 
              id="experience" 
              class="form-select"
              value={formData.experience}
              on:change={(e) => handleInputChange('experience', e.target.value)}
            >
              <option value="">Select experience level</option>
              <option value="0-1">0-1 years</option>
              <option value="2-5">2-5 years</option>
              <option value="6-10">6-10 years</option>
              <option value="11-15">11-15 years</option>
              <option value="15+">15+ years</option>
            </select>
          </div>
        </div>
        
        <div class="form-section">
          <h3 class="section-title">Areas of Interest</h3>
          
          <div class="interests-grid">
            {#each interests as interest}
              <label class="interest-option">
                <input 
                  type="checkbox" 
                  checked={formData.interests.includes(interest)}
                  on:change={(e) => handleInterestChange(interest, e.target.checked)}
                />
                <span class="interest-label">{interest}</span>
              </label>
            {/each}
          </div>
        </div>
        
        <div class="form-actions">
          <button type="button" class="form-btn secondary" on:click={resetForm}>
            Reset Form
          </button>
          <button type="submit" class="form-btn primary">
            Submit Registration
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
        <h4 class="footer-title">Resources</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Documentation</a></li>
          <li><a href="#" class="footer-link">Tutorials</a></li>
          <li><a href="#" class="footer-link">API Reference</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Support</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Help Center</a></li>
          <li><a href="#" class="footer-link">Contact Us</a></li>
          <li><a href="#" class="footer-link">Community</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 Developer Community. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .registration-form {
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
  
  .radio-group {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .radio-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border-radius: 6px;
    transition: background-color 0.2s;
  }
  
  .radio-option:hover {
    background: #f8f9fa;
  }
  
  .radio-option input[type="radio"] {
    width: 20px;
    height: 20px;
    margin: 0;
  }
  
  .radio-label {
    font-size: 16px;
    color: #333;
  }
  
  .checkbox-group {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .checkbox-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border-radius: 6px;
    transition: background-color 0.2s;
  }
  
  .checkbox-option:hover {
    background: #f8f9fa;
  }
  
  .checkbox-option input[type="checkbox"] {
    width: 20px;
    height: 20px;
    margin: 0;
  }
  
  .checkbox-label {
    font-size: 16px;
    color: #333;
  }
  
  .interests-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
  }
  
  .interest-option {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    transition: all 0.2s;
  }
  
  .interest-option:hover {
    background: #f8f9fa;
    border-color: #007bff;
  }
  
  .interest-option input[type="checkbox"] {
    width: 18px;
    height: 18px;
    margin: 0;
  }
  
  .interest-label {
    font-size: 14px;
    color: #333;
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
    
    .form-actions {
      flex-direction: column;
    }
    
    .interests-grid {
      grid-template-columns: 1fr;
    }
  }
</style>

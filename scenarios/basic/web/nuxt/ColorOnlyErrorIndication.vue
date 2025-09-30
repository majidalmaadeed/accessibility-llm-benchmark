<template>
  <div class="user-registration-form">
    <header class="form-header">
      <div class="header-content">
        <h1 class="form-title">Create Your Account</h1>
        <p class="form-subtitle">Join our platform and start your journey today</p>
      </div>
    </header>

    <main class="main-content">
      <div class="form-container">
        <form class="registration-form" @submit.prevent="submitForm">
          <div class="form-section">
            <h2 class="section-title">Personal Information</h2>
            
            <div class="form-row">
              <div class="form-group">
                <label for="firstName" class="form-label">First Name</label>
                <input 
                  type="text" 
                  id="firstName" 
                  name="firstName"
                  v-model="formData.firstName"
                  class="form-input"
                  :class="{ 'error': errors.firstName }"
                  required
                />
                <div class="error-message" v-if="errors.firstName">{{ errors.firstName }}</div>
              </div>
              
              <div class="form-group">
                <label for="lastName" class="form-label">Last Name</label>
                <input 
                  type="text" 
                  id="lastName" 
                  name="lastName"
                  v-model="formData.lastName"
                  class="form-input"
                  :class="{ 'error': errors.lastName }"
                  required
                />
                <div class="error-message" v-if="errors.lastName">{{ errors.lastName }}</div>
              </div>
            </div>

            <div class="form-group">
              <label for="email" class="form-label">Email Address</label>
              <input 
                type="email" 
                id="email" 
                name="email"
                v-model="formData.email"
                class="form-input"
                :class="{ 'error': errors.email }"
                required
              />
              <div class="error-message" v-if="errors.email">{{ errors.email }}</div>
            </div>

            <div class="form-group">
              <label for="phone" class="form-label">Phone Number</label>
              <input 
                type="tel" 
                id="phone" 
                name="phone"
                v-model="formData.phone"
                class="form-input"
                :class="{ 'error': errors.phone }"
                placeholder="(555) 123-4567"
              />
              <div class="error-message" v-if="errors.phone">{{ errors.phone }}</div>
            </div>

            <div class="form-group">
              <label for="dateOfBirth" class="form-label">Date of Birth</label>
              <input 
                type="date" 
                id="dateOfBirth" 
                name="dateOfBirth"
                v-model="formData.dateOfBirth"
                class="form-input"
                :class="{ 'error': errors.dateOfBirth }"
                required
              />
              <div class="error-message" v-if="errors.dateOfBirth">{{ errors.dateOfBirth }}</div>
            </div>
          </div>

          <div class="form-section">
            <h2 class="section-title">Account Security</h2>
            
            <div class="form-group">
              <label for="username" class="form-label">Username</label>
              <input 
                type="text" 
                id="username" 
                name="username"
                v-model="formData.username"
                class="form-input"
                :class="{ 'error': errors.username }"
                required
              />
              <div class="error-message" v-if="errors.username">{{ errors.username }}</div>
            </div>

            <div class="form-group">
              <label for="password" class="form-label">Password</label>
              <input 
                type="password" 
                id="password" 
                name="password"
                v-model="formData.password"
                class="form-input"
                :class="{ 'error': errors.password }"
                required
              />
              <div class="error-message" v-if="errors.password">{{ errors.password }}</div>
            </div>

            <div class="form-group">
              <label for="confirmPassword" class="form-label">Confirm Password</label>
              <input 
                type="password" 
                id="confirmPassword" 
                name="confirmPassword"
                v-model="formData.confirmPassword"
                class="form-input"
                :class="{ 'error': errors.confirmPassword }"
                required
              />
              <div class="error-message" v-if="errors.confirmPassword">{{ errors.confirmPassword }}</div>
            </div>

            <div class="form-group">
              <label for="securityQuestion" class="form-label">Security Question</label>
              <select 
                id="securityQuestion" 
                name="securityQuestion"
                v-model="formData.securityQuestion"
                class="form-select"
                :class="{ 'error': errors.securityQuestion }"
                required
              >
                <option value="">Select a security question</option>
                <option value="mother-maiden">What is your mother's maiden name?</option>
                <option value="first-pet">What was the name of your first pet?</option>
                <option value="birth-city">What city were you born in?</option>
                <option value="high-school">What high school did you attend?</option>
                <option value="favorite-teacher">Who was your favorite teacher?</option>
              </select>
              <div class="error-message" v-if="errors.securityQuestion">{{ errors.securityQuestion }}</div>
            </div>

            <div class="form-group">
              <label for="securityAnswer" class="form-label">Security Answer</label>
              <input 
                type="text" 
                id="securityAnswer" 
                name="securityAnswer"
                v-model="formData.securityAnswer"
                class="form-input"
                :class="{ 'error': errors.securityAnswer }"
                required
              />
              <div class="error-message" v-if="errors.securityAnswer">{{ errors.securityAnswer }}</div>
            </div>
          </div>

          <div class="form-section">
            <h2 class="section-title">Preferences</h2>
            
            <div class="form-group">
              <label for="country" class="form-label">Country</label>
              <select 
                id="country" 
                name="country"
                v-model="formData.country"
                class="form-select"
                :class="{ 'error': errors.country }"
                required
              >
                <option value="">Select your country</option>
                <option value="US">United States</option>
                <option value="CA">Canada</option>
                <option value="UK">United Kingdom</option>
                <option value="AU">Australia</option>
                <option value="DE">Germany</option>
                <option value="FR">France</option>
                <option value="JP">Japan</option>
                <option value="other">Other</option>
              </select>
              <div class="error-message" v-if="errors.country">{{ errors.country }}</div>
            </div>

            <div class="form-group">
              <label for="timezone" class="form-label">Timezone</label>
              <select 
                id="timezone" 
                name="timezone"
                v-model="formData.timezone"
                class="form-select"
                :class="{ 'error': errors.timezone }"
                required
              >
                <option value="">Select your timezone</option>
                <option value="UTC-12">UTC-12 (Baker Island)</option>
                <option value="UTC-11">UTC-11 (American Samoa)</option>
                <option value="UTC-10">UTC-10 (Hawaii)</option>
                <option value="UTC-9">UTC-9 (Alaska)</option>
                <option value="UTC-8">UTC-8 (Pacific Time)</option>
                <option value="UTC-7">UTC-7 (Mountain Time)</option>
                <option value="UTC-6">UTC-6 (Central Time)</option>
                <option value="UTC-5">UTC-5 (Eastern Time)</option>
                <option value="UTC-4">UTC-4 (Atlantic Time)</option>
                <option value="UTC-3">UTC-3 (Brazil)</option>
                <option value="UTC-2">UTC-2 (Mid-Atlantic)</option>
                <option value="UTC-1">UTC-1 (Azores)</option>
                <option value="UTC+0">UTC+0 (Greenwich)</option>
                <option value="UTC+1">UTC+1 (Central European)</option>
                <option value="UTC+2">UTC+2 (Eastern European)</option>
                <option value="UTC+3">UTC+3 (Moscow)</option>
                <option value="UTC+4">UTC+4 (Gulf)</option>
                <option value="UTC+5">UTC+5 (Pakistan)</option>
                <option value="UTC+6">UTC+6 (Bangladesh)</option>
                <option value="UTC+7">UTC+7 (Thailand)</option>
                <option value="UTC+8">UTC+8 (China)</option>
                <option value="UTC+9">UTC+9 (Japan)</option>
                <option value="UTC+10">UTC+10 (Australia Eastern)</option>
                <option value="UTC+11">UTC+11 (Solomon Islands)</option>
                <option value="UTC+12">UTC+12 (New Zealand)</option>
              </select>
              <div class="error-message" v-if="errors.timezone">{{ errors.timezone }}</div>
            </div>

            <div class="form-group">
              <label for="language" class="form-label">Preferred Language</label>
              <select 
                id="language" 
                name="language"
                v-model="formData.language"
                class="form-select"
                :class="{ 'error': errors.language }"
                required
              >
                <option value="">Select your language</option>
                <option value="en">English</option>
                <option value="es">Spanish</option>
                <option value="fr">French</option>
                <option value="de">German</option>
                <option value="it">Italian</option>
                <option value="pt">Portuguese</option>
                <option value="ru">Russian</option>
                <option value="ja">Japanese</option>
                <option value="ko">Korean</option>
                <option value="zh">Chinese</option>
              </select>
              <div class="error-message" v-if="errors.language">{{ errors.language }}</div>
            </div>
          </div>

          <div class="form-section">
            <h2 class="section-title">Terms and Conditions</h2>
            
            <div class="form-group">
              <label class="checkbox-label">
                <input 
                  type="checkbox" 
                  v-model="formData.agreeTerms"
                  class="checkbox-input"
                  :class="{ 'error': errors.agreeTerms }"
                  required
                />
                <span class="checkbox-text">
                  I agree to the <a href="/terms" class="link">Terms of Service</a> and 
                  <a href="/privacy" class="link">Privacy Policy</a>
                </span>
              </label>
              <div class="error-message" v-if="errors.agreeTerms">{{ errors.agreeTerms }}</div>
            </div>

            <div class="form-group">
              <label class="checkbox-label">
                <input 
                  type="checkbox" 
                  v-model="formData.agreeMarketing"
                  class="checkbox-input"
                />
                <span class="checkbox-text">
                  I would like to receive marketing emails and updates
                </span>
              </label>
            </div>

            <div class="form-group">
              <label class="checkbox-label">
                <input 
                  type="checkbox" 
                  v-model="formData.agreeNewsletter"
                  class="checkbox-input"
                />
                <span class="checkbox-text">
                  Subscribe to our newsletter for tips and updates
                </span>
              </label>
            </div>
          </div>

          <div class="form-actions">
            <button type="button" class="btn btn-secondary" @click="resetForm">Reset Form</button>
            <button type="submit" class="btn btn-primary">Create Account</button>
          </div>
        </form>
      </div>
    </main>

    <footer class="form-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Account</h4>
          <ul class="footer-links">
            <li><a href="/login">Sign In</a></li>
            <li><a href="/forgot-password">Forgot Password</a></li>
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact Support</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Legal</h4>
          <ul class="footer-links">
            <li><a href="/terms">Terms of Service</a></li>
            <li><a href="/privacy">Privacy Policy</a></li>
            <li><a href="/cookies">Cookie Policy</a></li>
            <li><a href="/gdpr">GDPR Compliance</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Company</h4>
          <ul class="footer-links">
            <li><a href="/about">About Us</a></li>
            <li><a href="/careers">Careers</a></li>
            <li><a href="/press">Press</a></li>
            <li><a href="/blog">Blog</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Connect</h4>
          <ul class="footer-links">
            <li><a href="/twitter">Twitter</a></li>
            <li><a href="/facebook">Facebook</a></li>
            <li><a href="/linkedin">LinkedIn</a></li>
            <li><a href="/instagram">Instagram</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 User Registration Platform. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

const formData = reactive({
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
  country: '',
  timezone: '',
  language: '',
  agreeTerms: false,
  agreeMarketing: false,
  agreeNewsletter: false
})

const errors = reactive({})

const validateForm = () => {
  const newErrors = {}
  
  // Clear previous errors
  Object.keys(errors).forEach(key => delete errors[key])
  
  // First Name validation
  if (!formData.firstName.trim()) {
    newErrors.firstName = 'First name is required'
  } else if (formData.firstName.length < 2) {
    newErrors.firstName = 'First name must be at least 2 characters'
  }
  
  // Last Name validation
  if (!formData.lastName.trim()) {
    newErrors.lastName = 'Last name is required'
  } else if (formData.lastName.length < 2) {
    newErrors.lastName = 'Last name must be at least 2 characters'
  }
  
  // Email validation
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!formData.email.trim()) {
    newErrors.email = 'Email address is required'
  } else if (!emailRegex.test(formData.email)) {
    newErrors.email = 'Please enter a valid email address'
  }
  
  // Phone validation
  if (formData.phone && !/^\(\d{3}\) \d{3}-\d{4}$/.test(formData.phone)) {
    newErrors.phone = 'Please enter a valid phone number in format (555) 123-4567'
  }
  
  // Date of Birth validation
  if (!formData.dateOfBirth) {
    newErrors.dateOfBirth = 'Date of birth is required'
  } else {
    const birthDate = new Date(formData.dateOfBirth)
    const today = new Date()
    const age = today.getFullYear() - birthDate.getFullYear()
    if (age < 13) {
      newErrors.dateOfBirth = 'You must be at least 13 years old to register'
    }
  }
  
  // Username validation
  if (!formData.username.trim()) {
    newErrors.username = 'Username is required'
  } else if (formData.username.length < 3) {
    newErrors.username = 'Username must be at least 3 characters'
  } else if (!/^[a-zA-Z0-9_]+$/.test(formData.username)) {
    newErrors.username = 'Username can only contain letters, numbers, and underscores'
  }
  
  // Password validation
  if (!formData.password) {
    newErrors.password = 'Password is required'
  } else if (formData.password.length < 8) {
    newErrors.password = 'Password must be at least 8 characters'
  } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(formData.password)) {
    newErrors.password = 'Password must contain at least one uppercase letter, one lowercase letter, and one number'
  }
  
  // Confirm Password validation
  if (!formData.confirmPassword) {
    newErrors.confirmPassword = 'Please confirm your password'
  } else if (formData.password !== formData.confirmPassword) {
    newErrors.confirmPassword = 'Passwords do not match'
  }
  
  // Security Question validation
  if (!formData.securityQuestion) {
    newErrors.securityQuestion = 'Please select a security question'
  }
  
  // Security Answer validation
  if (!formData.securityAnswer.trim()) {
    newErrors.securityAnswer = 'Security answer is required'
  } else if (formData.securityAnswer.length < 3) {
    newErrors.securityAnswer = 'Security answer must be at least 3 characters'
  }
  
  // Country validation
  if (!formData.country) {
    newErrors.country = 'Please select your country'
  }
  
  // Timezone validation
  if (!formData.timezone) {
    newErrors.timezone = 'Please select your timezone'
  }
  
  // Language validation
  if (!formData.language) {
    newErrors.language = 'Please select your preferred language'
  }
  
  // Terms agreement validation
  if (!formData.agreeTerms) {
    newErrors.agreeTerms = 'You must agree to the Terms of Service and Privacy Policy'
  }
  
  // Apply errors
  Object.assign(errors, newErrors)
  
  return Object.keys(newErrors).length === 0
}

const submitForm = () => {
  if (validateForm()) {
    console.log('Form submitted successfully:', formData)
    alert('Account created successfully!')
    resetForm()
  } else {
    console.log('Form validation failed:', errors)
  }
}

const resetForm = () => {
  Object.keys(formData).forEach(key => {
    if (typeof formData[key] === 'boolean') {
      formData[key] = false
    } else {
      formData[key] = ''
    }
  })
  
  Object.keys(errors).forEach(key => delete errors[key])
}
</script>

<style scoped>
.user-registration-form {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.form-header {
  background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
  color: white;
  padding: 60px 0;
  text-align: center;
}

.header-content {
  max-width: 800px;
  margin: 0 auto;
  padding: 0 20px;
}

.form-title {
  margin: 0 0 15px 0;
  font-size: 36px;
  font-weight: bold;
}

.form-subtitle {
  margin: 0;
  font-size: 18px;
  opacity: 0.9;
}

.main-content {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
}

.form-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

.registration-form {
  padding: 40px;
}

.form-section {
  margin-bottom: 40px;
  padding-bottom: 30px;
  border-bottom: 1px solid #eee;
}

.form-section:last-of-type {
  border-bottom: none;
  margin-bottom: 0;
}

.section-title {
  margin: 0 0 25px 0;
  font-size: 24px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
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
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.form-input,
.form-select {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s ease;
  box-sizing: border-box;
}

.form-input:focus,
.form-select:focus {
  outline: none;
  border-color: #007bff;
}

.form-input.error,
.form-select.error {
  border-color: #dc3545;
}

.error-message {
  color: #dc3545;
  font-size: 12px;
  margin-top: 5px;
  font-weight: 500;
}

.checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  cursor: pointer;
  margin-bottom: 15px;
}

.checkbox-input {
  margin: 0;
  width: 18px;
  height: 18px;
  accent-color: #007bff;
  flex-shrink: 0;
  margin-top: 2px;
}

.checkbox-input.error {
  accent-color: #dc3545;
}

.checkbox-text {
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
  justify-content: flex-end;
  margin-top: 40px;
  padding-top: 30px;
  border-top: 1px solid #eee;
}

.btn {
  padding: 15px 30px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #007bff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #545b62;
}

.form-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 768px) {
  .form-title {
    font-size: 28px;
  }

  .form-subtitle {
    font-size: 16px;
  }

  .registration-form {
    padding: 30px 20px;
  }

  .form-row {
    grid-template-columns: 1fr;
  }

  .form-actions {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .form-title {
    font-size: 24px;
  }

  .section-title {
    font-size: 20px;
  }

  .form-input,
  .form-select {
    font-size: 14px;
  }
}
</style>

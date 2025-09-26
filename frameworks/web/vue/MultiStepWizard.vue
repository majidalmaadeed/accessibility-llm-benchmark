<template>
  <div class="wizard-container">
    <div class="wizard-header">
      <h1>User Registration Wizard</h1>
      <div class="progress-bar">
        <div 
          class="progress-fill" 
          :style="{ width: `${progressPercentage}%` }"
        ></div>
      </div>
      <div class="progress-text">
        Step {{ currentStep }} of {{ steps.length }}
      </div>
    </div>

    <div class="wizard-steps">
      <div 
        v-for="(step, index) in steps" 
        :key="step.id" 
        :class="`step ${currentStep === step.id ? 'active' : ''} ${currentStep > step.id ? 'completed' : ''}`"
        @click="currentStep = step.id"
      >
        <div class="step-number">
          {{ currentStep > step.id ? '✓' : step.id }}
        </div>
        <div class="step-info">
          <div class="step-title">{{ step.title }}</div>
          <div class="step-description">{{ step.description }}</div>
        </div>
      </div>
    </div>

    <div class="wizard-content">
      <!-- Step 1: Personal Information -->
      <div v-if="currentStep === 1" class="step-content">
        <h3>Personal Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="First Name"
            v-model="formData.personalInfo.firstName"
            :class="{ error: errors.firstName }"
          />
          <span v-if="errors.firstName" class="error-message">{{ errors.firstName }}</span>
        </div>
        
        <div class="form-group">
          <input
            type="text"
            placeholder="Last Name"
            v-model="formData.personalInfo.lastName"
            :class="{ error: errors.lastName }"
          />
          <span v-if="errors.lastName" class="error-message">{{ errors.lastName }}</span>
        </div>
        
        <div class="form-group">
          <input
            type="email"
            placeholder="Email Address"
            v-model="formData.personalInfo.email"
            :class="{ error: errors.email }"
          />
          <span v-if="errors.email" class="error-message">{{ errors.email }}</span>
        </div>
        
        <div class="form-group">
          <input
            type="tel"
            placeholder="Phone Number"
            v-model="formData.personalInfo.phone"
            :class="{ error: errors.phone }"
          />
          <span v-if="errors.phone" class="error-message">{{ errors.phone }}</span>
        </div>
        
        <div class="form-group">
          <input
            type="date"
            v-model="formData.personalInfo.dateOfBirth"
          />
        </div>
      </div>

      <!-- Step 2: Address Information -->
      <div v-if="currentStep === 2" class="step-content">
        <h3>Address Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="Street Address"
            v-model="formData.addressInfo.street"
            :class="{ error: errors.street }"
          />
          <span v-if="errors.street" class="error-message">{{ errors.street }}</span>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="City"
              v-model="formData.addressInfo.city"
              :class="{ error: errors.city }"
            />
            <span v-if="errors.city" class="error-message">{{ errors.city }}</span>
          </div>
          
          <div class="form-group">
            <input
              type="text"
              placeholder="State"
              v-model="formData.addressInfo.state"
              :class="{ error: errors.state }"
            />
            <span v-if="errors.state" class="error-message">{{ errors.state }}</span>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="ZIP Code"
              v-model="formData.addressInfo.zipCode"
              :class="{ error: errors.zipCode }"
            />
            <span v-if="errors.zipCode" class="error-message">{{ errors.zipCode }}</span>
          </div>
          
          <div class="form-group">
            <select v-model="formData.addressInfo.country">
              <option value="">Select Country</option>
              <option value="US">United States</option>
              <option value="CA">Canada</option>
              <option value="UK">United Kingdom</option>
              <option value="AU">Australia</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Step 3: Preferences -->
      <div v-if="currentStep === 3" class="step-content">
        <h3>Preferences</h3>
        <div class="form-group">
          <label>
            <input
              type="checkbox"
              v-model="formData.preferences.newsletter"
            />
            Subscribe to newsletter
          </label>
        </div>
        
        <div class="form-group">
          <label>
            <input
              type="checkbox"
              v-model="formData.preferences.notifications"
            />
            Enable push notifications
          </label>
        </div>
        
        <div class="form-group">
          <label>Theme Preference</label>
          <select v-model="formData.preferences.theme">
            <option value="light">Light</option>
            <option value="dark">Dark</option>
            <option value="auto">Auto</option>
          </select>
        </div>
        
        <div class="form-group">
          <label>Language</label>
          <select v-model="formData.preferences.language">
            <option value="en">English</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
            <option value="de">German</option>
          </select>
        </div>
      </div>

      <!-- Step 4: Payment Information -->
      <div v-if="currentStep === 4" class="step-content">
        <h3>Payment Information</h3>
        <div class="form-group">
          <input
            type="text"
            placeholder="Card Number"
            v-model="formData.paymentInfo.cardNumber"
            :class="{ error: errors.cardNumber }"
          />
          <span v-if="errors.cardNumber" class="error-message">{{ errors.cardNumber }}</span>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              type="text"
              placeholder="MM/YY"
              v-model="formData.paymentInfo.expiryDate"
              :class="{ error: errors.expiryDate }"
            />
            <span v-if="errors.expiryDate" class="error-message">{{ errors.expiryDate }}</span>
          </div>
          
          <div class="form-group">
            <input
              type="text"
              placeholder="CVV"
              v-model="formData.paymentInfo.cvv"
              :class="{ error: errors.cvv }"
            />
            <span v-if="errors.cvv" class="error-message">{{ errors.cvv }}</span>
          </div>
        </div>
        
        <div class="form-group">
          <input
            type="text"
            placeholder="Billing Address (if different)"
            v-model="formData.paymentInfo.billingAddress"
          />
        </div>
      </div>

      <!-- Step 5: Review -->
      <div v-if="currentStep === 5" class="step-content">
        <h3>Review Your Information</h3>
        <div class="review-section">
          <h4>Personal Information</h4>
          <p><strong>Name:</strong> {{ formData.personalInfo.firstName }} {{ formData.personalInfo.lastName }}</p>
          <p><strong>Email:</strong> {{ formData.personalInfo.email }}</p>
          <p><strong>Phone:</strong> {{ formData.personalInfo.phone }}</p>
          <p><strong>Date of Birth:</strong> {{ formData.personalInfo.dateOfBirth }}</p>
        </div>
        
        <div class="review-section">
          <h4>Address</h4>
          <p>{{ formData.addressInfo.street }}</p>
          <p>{{ formData.addressInfo.city }}, {{ formData.addressInfo.state }} {{ formData.addressInfo.zipCode }}</p>
          <p>{{ formData.addressInfo.country }}</p>
        </div>
        
        <div class="review-section">
          <h4>Preferences</h4>
          <p><strong>Newsletter:</strong> {{ formData.preferences.newsletter ? 'Yes' : 'No' }}</p>
          <p><strong>Notifications:</strong> {{ formData.preferences.notifications ? 'Yes' : 'No' }}</p>
          <p><strong>Theme:</strong> {{ formData.preferences.theme }}</p>
          <p><strong>Language:</strong> {{ formData.preferences.language }}</p>
        </div>
        
        <div class="review-section">
          <h4>Payment</h4>
          <p><strong>Card:</strong> **** **** **** {{ formData.paymentInfo.cardNumber.slice(-4) }}</p>
          <p><strong>Expires:</strong> {{ formData.paymentInfo.expiryDate }}</p>
        </div>
      </div>
    </div>

    <div class="wizard-navigation">
      <button 
        @click="handlePrevious"
        :disabled="currentStep === 1"
        class="btn-secondary"
      >
        Previous
      </button>
      
      <button 
        v-if="currentStep < steps.length"
        @click="handleNext"
        class="btn-primary"
      >
        Next
      </button>
      <button 
        v-else
        @click="handleSubmit"
        :disabled="isSubmitting"
        class="btn-primary"
      >
        {{ isSubmitting ? 'Submitting...' : 'Complete Registration' }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MultiStepWizard',
  data() {
    return {
      currentStep: 1,
      formData: {
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
      },
      errors: {},
      isSubmitting: false,
      steps: [
        { id: 1, title: 'Personal Information', description: 'Basic details about yourself' },
        { id: 2, title: 'Address Information', description: 'Where you live' },
        { id: 3, title: 'Preferences', description: 'Your preferences and settings' },
        { id: 4, title: 'Payment Information', description: 'Billing and payment details' },
        { id: 5, title: 'Review & Submit', description: 'Review your information' }
      ]
    }
  },
  computed: {
    progressPercentage() {
      return (this.currentStep / this.steps.length) * 100;
    }
  },
  methods: {
    validateStep(step) {
      this.errors = {};

      switch (step) {
        case 1:
          if (!this.formData.personalInfo.firstName) this.errors.firstName = 'First name is required';
          if (!this.formData.personalInfo.lastName) this.errors.lastName = 'Last name is required';
          if (!this.formData.personalInfo.email) this.errors.email = 'Email is required';
          else if (!/\S+@\S+\.\S+/.test(this.formData.personalInfo.email)) {
            this.errors.email = 'Email is invalid';
          }
          if (!this.formData.personalInfo.phone) this.errors.phone = 'Phone number is required';
          break;
        
        case 2:
          if (!this.formData.addressInfo.street) this.errors.street = 'Street address is required';
          if (!this.formData.addressInfo.city) this.errors.city = 'City is required';
          if (!this.formData.addressInfo.state) this.errors.state = 'State is required';
          if (!this.formData.addressInfo.zipCode) this.errors.zipCode = 'ZIP code is required';
          break;
        
        case 3:
          // Preferences are optional, no validation needed
          break;
        
        case 4:
          if (!this.formData.paymentInfo.cardNumber) this.errors.cardNumber = 'Card number is required';
          if (!this.formData.paymentInfo.expiryDate) this.errors.expiryDate = 'Expiry date is required';
          if (!this.formData.paymentInfo.cvv) this.errors.cvv = 'CVV is required';
          break;
        
        default:
          break;
      }

      return Object.keys(this.errors).length === 0;
    },
    handleNext() {
      if (this.validateStep(this.currentStep)) {
        this.currentStep = Math.min(this.currentStep + 1, this.steps.length);
      }
    },
    handlePrevious() {
      this.currentStep = Math.max(this.currentStep - 1, 1);
    },
    async handleSubmit() {
      if (this.validateStep(this.currentStep)) {
        this.isSubmitting = true;
        
        // Simulate API call
        setTimeout(() => {
          console.log('Form submitted:', this.formData);
          this.isSubmitting = false;
          alert('Registration completed successfully!');
        }, 2000);
      }
    }
  }
}
</script>

<style scoped>
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

.form-group input,
.form-group select {
  width: 100%;
  padding: 12px 15px;
  border: 2px solid #e0e0e0;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group select:focus {
  outline: none;
  border-color: #4caf50;
}

.form-group input.error {
  border-color: #f44336;
}

.error-message {
  display: block;
  color: #f44336;
  font-size: 12px;
  margin-top: 5px;
  font-weight: 500;
}

.form-group label {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
}

.form-group label input[type="checkbox"] {
  width: auto;
  margin: 0;
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

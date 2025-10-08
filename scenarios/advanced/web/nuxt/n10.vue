<template>
  <div class="wizard-container">
    <div class="wizard-header">
      <h1>User Registration Wizard</h1>
      <div class="progress-bar">
        <div 
          class="progress-fill" 
          :style="{ width: progressPercentage + '%' }"
        />
      </div>
      <div class="progress-text">
        Step {{ currentStep }} of {{ steps.length }}
      </div>
    </div>

    <div class="wizard-steps">
      <div 
        v-for="step in steps"
        :key="step.id"
        class="step"
        :class="getStepClass(step)"
        @click="currentStep = step.id"
      >
        <div class="step-number">
          {{ getStepNumber(step) }}
        </div>
        <div class="step-info">
          <div class="step-title">{{ step.title }}</div>
          <div class="step-description">{{ step.description }}</div>
        </div>
      </div>
    </div>

    <div class="wizard-content">
      <div v-if="currentStep === 1" class="step-content">
        <h3>Personal Information</h3>
        <div class="form-group">
          <input
            v-model="formData.personalInfo.firstName"
            type="text"
            placeholder="First Name"
            class="form-input"
            :class="{ error: hasError('firstName') }"
          />
          <span v-if="hasError('firstName')" class="error-message">{{ getError('firstName') }}</span>
        </div>
        
        <div class="form-group">
          <input
            v-model="formData.personalInfo.lastName"
            type="text"
            placeholder="Last Name"
            class="form-input"
            :class="{ error: hasError('lastName') }"
          />
          <span v-if="hasError('lastName')" class="error-message">{{ getError('lastName') }}</span>
        </div>
        
        <div class="form-group">
          <input
            v-model="formData.personalInfo.email"
            type="email"
            placeholder="Email Address"
            class="form-input"
            :class="{ error: hasError('email') }"
          />
          <span v-if="hasError('email')" class="error-message">{{ getError('email') }}</span>
        </div>
        
        <div class="form-group">
          <input
            v-model="formData.personalInfo.phone"
            type="tel"
            placeholder="Phone Number"
            class="form-input"
            :class="{ error: hasError('phone') }"
          />
          <span v-if="hasError('phone')" class="error-message">{{ getError('phone') }}</span>
        </div>
        
        <div class="form-group">
          <input
            v-model="formData.personalInfo.dateOfBirth"
            type="date"
            class="form-input"
          />
        </div>
      </div>

      <div v-if="currentStep === 2" class="step-content">
        <h3>Address Information</h3>
        <div class="form-group">
          <input
            v-model="formData.addressInfo.street"
            type="text"
            placeholder="Street Address"
            class="form-input"
            :class="{ error: hasError('street') }"
          />
          <span v-if="hasError('street')" class="error-message">{{ getError('street') }}</span>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              v-model="formData.addressInfo.city"
              type="text"
              placeholder="City"
              class="form-input"
              :class="{ error: hasError('city') }"
            />
            <span v-if="hasError('city')" class="error-message">{{ getError('city') }}</span>
          </div>
          
          <div class="form-group">
            <input
              v-model="formData.addressInfo.state"
              type="text"
              placeholder="State"
              class="form-input"
              :class="{ error: hasError('state') }"
            />
            <span v-if="hasError('state')" class="error-message">{{ getError('state') }}</span>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              v-model="formData.addressInfo.zipCode"
              type="text"
              placeholder="ZIP Code"
              class="form-input"
              :class="{ error: hasError('zipCode') }"
            />
            <span v-if="hasError('zipCode')" class="error-message">{{ getError('zipCode') }}</span>
          </div>
          
          <div class="form-group">
            <select v-model="formData.addressInfo.country" class="form-input">
              <option value="">Select Country</option>
              <option value="US">United States</option>
              <option value="CA">Canada</option>
              <option value="UK">United Kingdom</option>
              <option value="AU">Australia</option>
            </select>
          </div>
        </div>
      </div>

      <div v-if="currentStep === 3" class="step-content">
        <h3>Preferences</h3>
        <div class="form-group">
          <label class="checkbox-label">
            <input
              v-model="formData.preferences.newsletter"
              type="checkbox"
            />
            Subscribe to newsletter
          </label>
        </div>
        
        <div class="form-group">
          <label class="checkbox-label">
            <input
              v-model="formData.preferences.notifications"
              type="checkbox"
            />
            Enable push notifications
          </label>
        </div>
        
        <div class="form-group">
          <label class="form-label">Theme Preference</label>
          <select v-model="formData.preferences.theme" class="form-input">
            <option value="light">Light</option>
            <option value="dark">Dark</option>
            <option value="auto">Auto</option>
          </select>
        </div>
        
        <div class="form-group">
          <label class="form-label">Language</label>
          <select v-model="formData.preferences.language" class="form-input">
            <option value="en">English</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
            <option value="de">German</option>
          </select>
        </div>
      </div>

      <div v-if="currentStep === 4" class="step-content">
        <h3>Payment Information</h3>
        <div class="form-group">
          <input
            v-model="formData.paymentInfo.cardNumber"
            type="text"
            placeholder="Card Number"
            class="form-input"
            :class="{ error: hasError('cardNumber') }"
          />
          <span v-if="hasError('cardNumber')" class="error-message">{{ getError('cardNumber') }}</span>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <input
              v-model="formData.paymentInfo.expiryDate"
              type="text"
              placeholder="MM/YY"
              class="form-input"
              :class="{ error: hasError('expiryDate') }"
            />
            <span v-if="hasError('expiryDate')" class="error-message">{{ getError('expiryDate') }}</span>
          </div>
          
          <div class="form-group">
            <input
              v-model="formData.paymentInfo.cvv"
              type="text"
              placeholder="CVV"
              class="form-input"
              :class="{ error: hasError('cvv') }"
            />
            <span v-if="hasError('cvv')" class="error-message">{{ getError('cvv') }}</span>
          </div>
        </div>
        
        <div class="form-group">
          <input
            v-model="formData.paymentInfo.billingAddress"
            type="text"
            placeholder="Billing Address (if different)"
            class="form-input"
          />
        </div>
      </div>

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
          <p><strong>Card:</strong> {{ getMaskedCardNumber() }}</p>
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
        { id: 1, title: 'Personal', description: 'Basic information' },
        { id: 2, title: 'Address', description: 'Location details' },
        { id: 3, title: 'Preferences', description: 'Your settings' },
        { id: 4, title: 'Payment', description: 'Billing information' },
        { id: 5, title: 'Review', description: 'Confirm details' }
      ]
    }
  },
  computed: {
    progressPercentage() {
      return (this.currentStep / this.steps.length) * 100
    }
  },
  watch: {
    currentStep() {
      this.validateCurrentStep()
    }
  },
  mounted() {
    this.validateCurrentStep()
  },
  methods: {
    validateCurrentStep() {
      const newErrors = {}

      switch (this.currentStep) {
        case 1:
          if (!this.formData.personalInfo.firstName.trim()) {
            newErrors.firstName = 'First name is required'
          }
          if (!this.formData.personalInfo.lastName.trim()) {
            newErrors.lastName = 'Last name is required'
          }
          if (!this.formData.personalInfo.email.trim()) {
            newErrors.email = 'Email is required'
          } else if (!/\S+@\S+\.\S+/.test(this.formData.personalInfo.email)) {
            newErrors.email = 'Email is invalid'
          }
          if (!this.formData.personalInfo.phone.trim()) {
            newErrors.phone = 'Phone number is required'
          }
          break
        case 2:
          if (!this.formData.addressInfo.street.trim()) {
            newErrors.street = 'Street address is required'
          }
          if (!this.formData.addressInfo.city.trim()) {
            newErrors.city = 'City is required'
          }
          if (!this.formData.addressInfo.state.trim()) {
            newErrors.state = 'State is required'
          }
          if (!this.formData.addressInfo.zipCode.trim()) {
            newErrors.zipCode = 'ZIP code is required'
          }
          break
        case 4:
          if (!this.formData.paymentInfo.cardNumber.trim()) {
            newErrors.cardNumber = 'Card number is required'
          }
          if (!this.formData.paymentInfo.expiryDate.trim()) {
            newErrors.expiryDate = 'Expiry date is required'
          }
          if (!this.formData.paymentInfo.cvv.trim()) {
            newErrors.cvv = 'CVV is required'
          }
          break
      }

      this.errors = newErrors
    },
    handleNext() {
      if (Object.keys(this.errors).length === 0 && this.currentStep < this.steps.length) {
        this.currentStep += 1
      }
    },
    handlePrevious() {
      if (this.currentStep > 1) {
        this.currentStep -= 1
      }
    },
    async handleSubmit() {
      this.isSubmitting = true
      
      setTimeout(() => {
        console.log('Form submitted:', this.formData)
        this.isSubmitting = false
        alert('Registration completed successfully!')
      }, 2000)
    },
    getStepClass(step) {
      if (step.id === this.currentStep) return 'active'
      if (step.id < this.currentStep) return 'completed'
      return ''
    },
    getStepNumber(step) {
      return step.id < this.currentStep ? '✓' : step.id
    },
    hasError(field) {
      return this.errors[field] ? true : false
    },
    getError(field) {
      return this.errors[field] || ''
    },
    getMaskedCardNumber() {
      const cardNumber = this.formData.paymentInfo.cardNumber
      if (cardNumber.length > 4) {
        return '**** **** **** ' + cardNumber.slice(-4)
      }
      return cardNumber
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

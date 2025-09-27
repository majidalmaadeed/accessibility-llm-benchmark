<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Multi-Step Wizard</h1>
      <p class="page-subtitle">
        Multi-step form wizard with validation
      </p>
    </div>

    <div class="card">
      <div class="wizard-steps">
        <div
          v-for="step in steps"
          :key="step.number"
          :class="[
            'wizard-step',
            { active: currentStep === step.number },
            { completed: currentStep > step.number }
          ]"
        >
          <span class="wizard-step-number">{{ step.number }}</span>
          {{ step.title }}
        </div>
      </div>

      <div style="margin-bottom: 2rem">
        <h2>{{ steps[currentStep - 1].title }}</h2>
        <p>{{ steps[currentStep - 1].description }}</p>
      </div>

      <div v-if="currentStep === 1">
        <h3>Personal Information</h3>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">First Name *</label>
            <input
              type="text"
              class="form-control"
              v-model="formData.firstName"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Last Name *</label>
            <input
              type="text"
              class="form-control"
              v-model="formData.lastName"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Email *</label>
            <input
              type="email"
              class="form-control"
              v-model="formData.email"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Phone</label>
            <input
              type="tel"
              class="form-control"
              v-model="formData.phone"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Country</label>
            <select class="form-control" v-model="formData.country">
              <option value="">Select Country</option>
              <option value="US">United States</option>
              <option value="CA">Canada</option>
              <option value="UK">United Kingdom</option>
              <option value="DE">Germany</option>
              <option value="FR">France</option>
              <option value="JP">Japan</option>
              <option value="AU">Australia</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Language</label>
            <select class="form-control" v-model="formData.language">
              <option value="">Select Language</option>
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
              <option value="de">German</option>
              <option value="ja">Japanese</option>
              <option value="zh">Chinese</option>
            </select>
          </div>
        </div>
      </div>

      <div v-if="currentStep === 2">
        <h3>Preferences</h3>
        <div class="form-group">
          <label class="form-label">Theme Preference</label>
          <div>
            <label>
              <input
                type="radio"
                name="theme"
                value="light"
                v-model="formData.theme"
              />
              Light Theme
            </label>
            <label style="margin-left: 20px">
              <input
                type="radio"
                name="theme"
                value="dark"
                v-model="formData.theme"
              />
              Dark Theme
            </label>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Notification Preferences</label>
          <div>
            <label>
              <input
                type="checkbox"
                v-model="formData.emailNotifications"
              />
              Email Notifications
            </label>
            <label style="margin-left: 20px">
              <input
                type="checkbox"
                v-model="formData.smsNotifications"
              />
              SMS Notifications
            </label>
            <label style="margin-left: 20px">
              <input
                type="checkbox"
                v-model="formData.pushNotifications"
              />
              Push Notifications
            </label>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Volume: {{ formData.volume }}%</label>
            <input
              type="range"
              min="0"
              max="100"
              v-model.number="formData.volume"
              class="form-control"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Font Size</label>
            <input
              type="number"
              min="8"
              max="24"
              v-model.number="formData.fontSize"
              class="form-control"
            />
          </div>
        </div>
      </div>

      <div v-if="currentStep === 3">
        <h3>Account Settings</h3>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Username *</label>
            <input
              type="text"
              class="form-control"
              v-model="formData.username"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Password *</label>
            <input
              type="password"
              class="form-control"
              v-model="formData.password"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Confirm Password *</label>
            <input
              type="password"
              class="form-control"
              v-model="formData.confirmPassword"
            />
          </div>
        </div>
        <div class="form-group">
          <label>
            <input
              type="checkbox"
              v-model="formData.termsAccepted"
            />
            I agree to the Terms of Service *
          </label>
        </div>
        <div class="form-group">
          <label>
            <input
              type="checkbox"
              v-model="formData.privacyAccepted"
            />
            I agree to the Privacy Policy *
          </label>
        </div>
        <div class="form-group">
          <label>
            <input
              type="checkbox"
              v-model="formData.newsletter"
            />
            Subscribe to newsletter
          </label>
        </div>
      </div>

      <div v-if="currentStep === 4">
        <h3>Additional Information</h3>
        <div class="form-group">
          <label class="form-label">Biography</label>
          <textarea
            class="form-control"
            rows="4"
            v-model="formData.bio"
            placeholder="Tell us about yourself..."
          />
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Industry</label>
            <select class="form-control" v-model="formData.industry">
              <option value="">Select Industry</option>
              <option value="technology">Technology</option>
              <option value="healthcare">Healthcare</option>
              <option value="finance">Finance</option>
              <option value="education">Education</option>
              <option value="retail">Retail</option>
              <option value="other">Other</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Experience</label>
            <select class="form-control" v-model="formData.experience">
              <option value="">Select Experience</option>
              <option value="0-1">0-1 years</option>
              <option value="1-3">1-3 years</option>
              <option value="3-5">3-5 years</option>
              <option value="5-10">5-10 years</option>
              <option value="10+">10+ years</option>
            </select>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Website</label>
            <input
              type="url"
              class="form-control"
              v-model="formData.website"
              placeholder="https://example.com"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Birth Date</label>
            <input
              type="date"
              class="form-control"
              v-model="formData.birthDate"
            />
          </div>
        </div>
      </div>

      <div v-if="currentStep === 5">
        <h3>Review and Confirm</h3>
        <p>Please review your information before proceeding:</p>
        <div class="card">
          <h4>Personal Information</h4>
          <p><strong>Name:</strong> {{ formData.firstName }} {{ formData.lastName }}</p>
          <p><strong>Email:</strong> {{ formData.email }}</p>
          <p><strong>Phone:</strong> {{ formData.phone || 'Not provided' }}</p>
          <p><strong>Country:</strong> {{ formData.country || 'Not selected' }}</p>
          <p><strong>Language:</strong> {{ formData.language || 'Not selected' }}</p>
        </div>
        <div class="card">
          <h4>Preferences</h4>
          <p><strong>Theme:</strong> {{ formData.theme }}</p>
          <p><strong>Email Notifications:</strong> {{ formData.emailNotifications ? 'Yes' : 'No' }}</p>
          <p><strong>SMS Notifications:</strong> {{ formData.smsNotifications ? 'Yes' : 'No' }}</p>
          <p><strong>Push Notifications:</strong> {{ formData.pushNotifications ? 'Yes' : 'No' }}</p>
          <p><strong>Volume:</strong> {{ formData.volume }}%</p>
          <p><strong>Font Size:</strong> {{ formData.fontSize }}px</p>
        </div>
        <div class="card">
          <h4>Account Settings</h4>
          <p><strong>Username:</strong> {{ formData.username }}</p>
          <p><strong>Terms Accepted:</strong> {{ formData.termsAccepted ? 'Yes' : 'No' }}</p>
          <p><strong>Privacy Accepted:</strong> {{ formData.privacyAccepted ? 'Yes' : 'No' }}</p>
          <p><strong>Newsletter:</strong> {{ formData.newsletter ? 'Yes' : 'No' }}</p>
        </div>
        <div class="card">
          <h4>Additional Information</h4>
          <p><strong>Biography:</strong> {{ formData.bio || 'Not provided' }}</p>
          <p><strong>Industry:</strong> {{ formData.industry || 'Not selected' }}</p>
          <p><strong>Experience:</strong> {{ formData.experience || 'Not selected' }}</p>
          <p><strong>Website:</strong> {{ formData.website || 'Not provided' }}</p>
          <p><strong>Birth Date:</strong> {{ formData.birthDate || 'Not provided' }}</p>
        </div>
      </div>

      <div class="form-actions">
        <button
          class="btn btn-secondary"
          @click="prevStep"
          :disabled="currentStep === 1"
        >
          Previous
        </button>
        <button
          v-if="currentStep < totalSteps"
          class="btn"
          @click="nextStep"
        >
          Next
        </button>
        <button
          v-else
          class="btn"
          @click="finishWizard"
        >
          Finish
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Wizard',
  data() {
    return {
      currentStep: 1,
      totalSteps: 5,
      formData: {
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        country: '',
        language: '',
        theme: 'dark',
        emailNotifications: false,
        smsNotifications: false,
        pushNotifications: true,
        volume: 50,
        fontSize: 12,
        username: '',
        password: '',
        confirmPassword: '',
        termsAccepted: false,
        privacyAccepted: false,
        newsletter: false,
        bio: '',
        industry: '',
        experience: '',
        website: '',
        birthDate: ''
      }
    }
  },
  computed: {
    steps() {
      return [
        { number: 1, title: 'Personal Information', description: 'Enter your personal details' },
        { number: 2, title: 'Preferences', description: 'Set your preferences' },
        { number: 3, title: 'Account Settings', description: 'Create your account' },
        { number: 4, title: 'Additional Information', description: 'Tell us more about yourself' },
        { number: 5, title: 'Review and Confirm', description: 'Review your information' }
      ]
    }
  },
  methods: {
    nextStep() {
      if (this.validateCurrentStep()) {
        this.currentStep = Math.min(this.currentStep + 1, this.totalSteps)
      }
    },
    prevStep() {
      this.currentStep = Math.max(this.currentStep - 1, 1)
    },
    validateCurrentStep() {
      switch (this.currentStep) {
        case 1:
          if (!this.formData.firstName || !this.formData.lastName || !this.formData.email) {
            alert('Please fill in all required fields in Personal Information.')
            return false
          }
          break
        case 3:
          if (!this.formData.username || !this.formData.password || !this.formData.confirmPassword) {
            alert('Please fill in all required fields in Account Settings.')
            return false
          }
          if (this.formData.password !== this.formData.confirmPassword) {
            alert('Passwords do not match.')
            return false
          }
          if (!this.formData.termsAccepted || !this.formData.privacyAccepted) {
            alert('You must accept the Terms of Service and Privacy Policy.')
            return false
          }
          break
        default:
          break
      }
      return true
    },
    finishWizard() {
      if (this.validateCurrentStep()) {
        alert('Wizard completed successfully! Thank you for your information.')
      }
    }
  }
}
</script>

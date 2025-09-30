<template>
  <div class="registration-form">
    <h1>User Registration</h1>
    <p>Please provide your contact details and preferences.</p>
    
    <form @submit.prevent="handleSubmit" class="form-container">
      <div class="form-group">
        <label class="form-label">Username *</label>
        <div class="input-with-tooltip">
          <input
            type="text"
            v-model="formData.username"
            required
            class="form-input"
            @mouseenter="showTooltip('username')"
            @mouseleave="hideTooltip"
          />
          <span
            class="help-icon"
            @mouseenter="showTooltip('username')"
            @mouseleave="hideTooltip"
          >
            ?
          </span>
          <div v-if="hoveredField === 'username'" class="tooltip">
            {{ tooltips.username }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Email Address *</label>
        <div class="input-with-tooltip">
          <input
            type="email"
            v-model="formData.email"
            required
            class="form-input"
            @mouseenter="showTooltip('email')"
            @mouseleave="hideTooltip"
          />
          <span
            class="help-icon"
            @mouseenter="showTooltip('email')"
            @mouseleave="hideTooltip"
          >
            ?
          </span>
          <div v-if="hoveredField === 'email'" class="tooltip">
            {{ tooltips.email }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Password *</label>
        <div class="input-with-tooltip">
          <input
            type="password"
            v-model="formData.password"
            required
            class="form-input"
            @mouseenter="showTooltip('password')"
            @mouseleave="hideTooltip"
          />
          <span
            class="help-icon"
            @mouseenter="showTooltip('password')"
            @mouseleave="hideTooltip"
          >
            ?
          </span>
          <div v-if="hoveredField === 'password'" class="tooltip">
            {{ tooltips.password }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Confirm Password *</label>
        <div class="input-with-tooltip">
          <input
            type="password"
            v-model="formData.confirmPassword"
            required
            class="form-input"
            @mouseenter="showTooltip('confirmPassword')"
            @mouseleave="hideTooltip"
          />
          <span
            class="help-icon"
            @mouseenter="showTooltip('confirmPassword')"
            @mouseleave="hideTooltip"
          >
            ?
          </span>
          <div v-if="hoveredField === 'confirmPassword'" class="tooltip">
            {{ tooltips.confirmPassword }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Phone Number</label>
        <div class="input-with-tooltip">
          <input
            type="tel"
            v-model="formData.phone"
            class="form-input"
            @mouseenter="showTooltip('phone')"
            @mouseleave="hideTooltip"
          />
          <span
            class="help-icon"
            @mouseenter="showTooltip('phone')"
            @mouseleave="hideTooltip"
          >
            ?
          </span>
          <div v-if="hoveredField === 'phone'" class="tooltip">
            {{ tooltips.phone }}
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="checkbox-group">
          <div class="checkbox-item">
            <input
              type="checkbox"
              id="terms"
              required
              class="checkbox-input"
            />
            <label for="terms" class="checkbox-label">
              I agree to the 
              <span
                class="link-with-tooltip"
                @mouseenter="showTooltip('terms')"
                @mouseleave="hideTooltip"
              >
                Terms and Conditions
              </span>
              and
              <span
                class="link-with-tooltip"
                @mouseenter="showTooltip('privacy')"
                @mouseleave="hideTooltip"
              >
                Privacy Policy
              </span>
            </label>
          </div>
          <div v-if="hoveredField === 'terms'" class="tooltip">
            {{ tooltips.terms }}
          </div>
          <div v-if="hoveredField === 'privacy'" class="tooltip">
            {{ tooltips.privacy }}
          </div>
        </div>
      </div>

      <div class="form-actions">
        <button type="button" class="btn-secondary">Cancel</button>
        <button type="submit" class="btn-primary">Create Account</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: 'InaccessibleTooltip',
  data() {
    return {
      formData: {
        username: '',
        email: '',
        password: '',
        confirmPassword: '',
        phone: ''
      },
      hoveredField: null,
      tooltips: {
        username: 'Enter your username or email address',
        password: 'Password must be at least 8 characters long',
        confirmPassword: 'Re-enter your password to confirm',
        email: 'We will send a verification email to this address',
        phone: 'Include country code (e.g., +1 for US)',
        terms: 'You must agree to our terms and conditions',
        privacy: 'Read our privacy policy to understand how we use your data'
      }
    }
  },
  methods: {
    showTooltip(field) {
      this.hoveredField = field
    },
    hideTooltip() {
      this.hoveredField = null
    },
    handleSubmit() {
      alert('Form submitted successfully!')
    }
  }
}
</script>

<style scoped>
.registration-form {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.form-container {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  border: 1px solid #e0e0e0;
}

.form-group {
  margin-bottom: 25px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #333;
}

.input-with-tooltip {
  position: relative;
  display: inline-block;
}

.form-input {
  width: 300px;
  padding: 12px 40px 12px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.help-icon {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
  cursor: help;
}

.tooltip {
  position: absolute;
  top: -40px;
  left: 0;
  background: #333;
  color: white;
  padding: 8px 12px;
  border-radius: 4px;
  font-size: 12px;
  white-space: nowrap;
  z-index: 1000;
}

.checkbox-group {
  margin-top: 10px;
}

.checkbox-item {
  margin-bottom: 15px;
}

.checkbox-input {
  margin-right: 10px;
}

.checkbox-label {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-size: 14px;
}

.link-with-tooltip {
  color: #007bff;
  text-decoration: underline;
  margin: 0 5px;
  cursor: help;
}

.form-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
}

.btn-primary {
  background: #007bff;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

.btn-secondary {
  background: #6c757d;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}
</style>

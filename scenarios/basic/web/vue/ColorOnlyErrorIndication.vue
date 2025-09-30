<template>
  <div class="registration-form">
    <h1>User Registration</h1>
    <p>Please fill out the form below to create your account.</p>
    
    <form @submit.prevent="handleSubmit" class="form-container" v-if="!isSubmitted">
      <div class="form-group">
        <label class="form-label">First Name *</label>
        <input
          type="text"
          v-model="formData.firstName"
          required
          :class="['form-input', { error: errors.firstName }]"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Last Name *</label>
        <input
          type="text"
          v-model="formData.lastName"
          required
          :class="['form-input', { error: errors.lastName }]"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Email Address *</label>
        <input
          type="email"
          v-model="formData.email"
          required
          :class="['form-input', { error: errors.email }]"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Phone Number *</label>
        <input
          type="tel"
          v-model="formData.phone"
          required
          :class="['form-input', { error: errors.phone }]"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Password *</label>
        <input
          type="password"
          v-model="formData.password"
          required
          :class="['form-input', { error: errors.password }]"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Confirm Password *</label>
        <input
          type="password"
          v-model="formData.confirmPassword"
          required
          :class="['form-input', { error: errors.confirmPassword }]"
        />
      </div>

      <div class="form-actions">
        <button type="button" class="btn-secondary">Cancel</button>
        <button type="submit" class="btn-primary">Register</button>
      </div>
    </form>

    <div v-if="isSubmitted" class="success-message">
      <h1>Registration Successful!</h1>
      <p>Thank you for registering. Your account has been created.</p>
      <button @click="resetForm" class="btn-primary">Register Another Account</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ColorOnlyErrorIndication',
  data() {
    return {
      formData: {
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        password: '',
        confirmPassword: ''
      },
      errors: {},
      isSubmitted: false
    }
  },
  methods: {
    validateForm() {
      const newErrors = {}
      
      if (!this.formData.firstName.trim()) {
        newErrors.firstName = 'First name is required'
      }
      
      if (!this.formData.lastName.trim()) {
        newErrors.lastName = 'Last name is required'
      }
      
      if (!this.formData.email.trim()) {
        newErrors.email = 'Email is required'
      } else if (!/\S+@\S+\.\S+/.test(this.formData.email)) {
        newErrors.email = 'Email is invalid'
      }
      
      if (!this.formData.phone.trim()) {
        newErrors.phone = 'Phone number is required'
      } else if (!/^\d{10}$/.test(this.formData.phone.replace(/\D/g, ''))) {
        newErrors.phone = 'Phone number must be 10 digits'
      }
      
      if (!this.formData.password) {
        newErrors.password = 'Password is required'
      } else if (this.formData.password.length < 8) {
        newErrors.password = 'Password must be at least 8 characters'
      }
      
      if (!this.formData.confirmPassword) {
        newErrors.confirmPassword = 'Please confirm your password'
      } else if (this.formData.password !== this.formData.confirmPassword) {
        newErrors.confirmPassword = 'Passwords do not match'
      }
      
      this.errors = newErrors
      return Object.keys(newErrors).length === 0
    },
    handleSubmit() {
      if (this.validateForm()) {
        this.isSubmitted = true
      }
    },
    resetForm() {
      this.formData = {
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        password: '',
        confirmPassword: ''
      }
      this.errors = {}
      this.isSubmitted = false
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

.form-input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.form-input.error {
  border: 2px solid #dc3545;
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

.success-message {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  text-align: center;
  font-family: Arial, sans-serif;
}

.success-message h1 {
  color: #28a745;
  margin-bottom: 20px;
}
</style>

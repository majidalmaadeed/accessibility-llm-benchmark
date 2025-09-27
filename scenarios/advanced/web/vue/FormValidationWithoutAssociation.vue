<template>
  <div class="main-container">
    <div class="main-content">
      <h1>User Registration</h1>
      <p>Create your account by filling out the form below.</p>
      
      <form @submit.prevent="handleSubmit" class="registration-form">
        <div class="form-group">
          <label for="username">Username:</label>
          <input
            type="text"
            id="username"
            v-model="formData.username"
            @input="clearError('username')"
            :class="{ error: errors.username }"
          />
        </div>
        
        <div class="form-group">
          <label for="email">Email:</label>
          <input
            type="email"
            id="email"
            v-model="formData.email"
            @input="clearError('email')"
            :class="{ error: errors.email }"
          />
        </div>
        
        <div class="form-group">
          <label for="password">Password:</label>
          <input
            type="password"
            id="password"
            v-model="formData.password"
            @input="clearError('password')"
            :class="{ error: errors.password }"
          />
        </div>
        
        <div class="form-group">
          <label for="confirmPassword">Confirm Password:</label>
          <input
            type="password"
            id="confirmPassword"
            v-model="formData.confirmPassword"
            @input="clearError('confirmPassword')"
            :class="{ error: errors.confirmPassword }"
          />
        </div>
        
        <!-- Error Messages - Not properly associated with fields -->
        <div v-if="Object.keys(errors).length > 0" class="error-summary">
          <strong>Please fix the following errors:</strong>
          <ul>
            <li v-for="(error, field) in errors" :key="field">{{ error }}</li>
          </ul>
        </div>
        
        <button type="submit" :disabled="isSubmitting" class="submit-button">
          {{ isSubmitting ? 'Creating Account...' : 'Create Account' }}
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { ref, reactive } from 'vue'

export default {
  name: 'FormValidationWithoutAssociation',
  setup() {
    const formData = reactive({
      username: '',
      password: '',
      email: '',
      confirmPassword: ''
    })
    
    const errors = ref({})
    const isSubmitting = ref(false)

    const clearError = (field) => {
      if (errors.value[field]) {
        delete errors.value[field]
      }
    }

    const validateForm = () => {
      const newErrors = {}

      if (!formData.username.trim()) {
        newErrors.username = 'Username is required'
      } else if (formData.username.length < 3) {
        newErrors.username = 'Username must be at least 3 characters'
      }

      if (!formData.email.trim()) {
        newErrors.email = 'Email is required'
      } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
        newErrors.email = 'Please enter a valid email address'
      }

      if (!formData.password) {
        newErrors.password = 'Password is required'
      } else if (formData.password.length < 8) {
        newErrors.password = 'Password must be at least 8 characters'
      }

      if (!formData.confirmPassword) {
        newErrors.confirmPassword = 'Please confirm your password'
      } else if (formData.password !== formData.confirmPassword) {
        newErrors.confirmPassword = 'Passwords do not match'
      }

      return newErrors
    }

    const handleSubmit = async () => {
      isSubmitting.value = true

      const validationErrors = validateForm()
      
      if (Object.keys(validationErrors).length > 0) {
        errors.value = validationErrors
        isSubmitting.value = false
        return
      }

      // Simulate API call
      try {
        await new Promise(resolve => setTimeout(resolve, 1000))
        alert('Registration successful!')
        Object.assign(formData, { username: '', password: '', email: '', confirmPassword: '' })
        errors.value = {}
      } catch (error) {
        alert('Registration failed. Please try again.')
      } finally {
        isSubmitting.value = false
      }
    }

    return {
      formData,
      errors,
      isSubmitting,
      clearError,
      handleSubmit
    }
  }
}
</script>

<style scoped>
.main-container {
  font-family: Arial, sans-serif;
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.registration-form {
  margin-top: 20px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #333;
}

.form-group input {
  width: 100%;
  padding: 12px;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.form-group input:focus {
  border-color: #007bff;
  outline: none;
}

.form-group input.error {
  border-color: #dc3545;
}

.error-summary {
  color: #dc3545;
  font-size: 14px;
  margin-bottom: 20px;
  padding: 10px;
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
  border-radius: 4px;
}

.error-summary ul {
  margin: 5px 0 0 20px;
}

.submit-button {
  background-color: #007bff;
  color: white;
  padding: 12px 30px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
  width: 100%;
}

.submit-button:hover:not(:disabled) {
  background-color: #0056b3;
}

.submit-button:disabled {
  background-color: #6c757d;
  cursor: not-allowed;
}
</style>
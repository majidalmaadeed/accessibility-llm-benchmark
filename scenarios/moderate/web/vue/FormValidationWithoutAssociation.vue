<template>
  <div class="form-container">
    <h1>Login Form</h1>
    <p>Please enter your credentials to access your account.</p>
    
    <form @submit.prevent="handleSubmit" class="login-form">
      <div class="form-group">
        <label for="username">Username:</label>
        <input
          type="text"
          id="username"
          v-model="formData.username"
          @input="clearErrors"
          :class="{ error: errors.username }"
          required
          <!-- MISSING: aria-describedby, aria-invalid -->
        />
        <div v-if="errors.username" class="error-message">
          {{ errors.username }}
        </div>
      </div>
      
      <div class="form-group">
        <label for="password">Password:</label>
        <input
          type="password"
          id="password"
          v-model="formData.password"
          @input="clearErrors"
          :class="{ error: errors.password }"
          required
          <!-- MISSING: aria-describedby, aria-invalid -->
        />
        <div v-if="errors.password" class="error-message">
          {{ errors.password }}
        </div>
      </div>
      
      <!-- GENERIC ERROR MESSAGE NOT ASSOCIATED WITH SPECIFIC FIELDS -->
      <div v-if="showGenericError" class="generic-error">
        Please fill in all required fields.
        <!-- MISSING: role="alert", aria-live -->
      </div>
      
      <button type="submit" class="login-button">
        Login
      </button>
    </form>

    <div class="accessibility-info">
      <h3>Accessibility Issues:</h3>
      <ul>
        <li><strong>Missing aria-describedby:</strong> Error messages are not linked to input fields</li>
        <li><strong>No aria-invalid:</strong> Input fields don't indicate validation state</li>
        <li><strong>Generic error:</strong> Generic error message doesn't specify which fields have issues</li>
        <li><strong>No live region:</strong> Screen readers won't announce errors when they appear</li>
      </ul>
      
      <h3>How to Fix:</h3>
      <ul>
        <li>Add <code>:aria-describedby="'error-' + fieldName"</code> to input fields</li>
        <li>Add <code>:aria-invalid="!!errors.fieldName"</code> to indicate validation state</li>
        <li>Use specific error messages for each field</li>
        <li>Add <code>role="alert"</code> or <code>aria-live="polite"</code> to error messages</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'FormValidationWithoutAssociation',
  data() {
    return {
      formData: {
        username: '',
        password: ''
      },
      errors: {},
      showGenericError: false
    };
  },
  methods: {
    clearErrors() {
      if (this.showGenericError) {
        this.showGenericError = false;
        this.errors = {};
      }
    },
    handleSubmit() {
      const newErrors = {};
      
      if (!this.formData.username.trim()) {
        newErrors.username = 'Username is required';
      }
      
      if (!this.formData.password.trim()) {
        newErrors.password = 'Password is required';
      }
      
      if (Object.keys(newErrors).length > 0) {
        this.errors = newErrors;
        this.showGenericError = true;
      } else {
        alert('Form submitted successfully!');
        this.formData = { username: '', password: '' };
        this.errors = {};
        this.showGenericError = false;
      }
    }
  }
};
</script>

<style scoped>
.form-container {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
}

.login-form {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.form-group {
  margin-bottom: 20px;
}

label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #333;
}

input[type="text"], input[type="password"] {
  width: 100%;
  padding: 12px;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

input[type="text"]:focus, input[type="password"]:focus {
  border-color: #007bff;
  outline: none;
}

input.error {
  border-color: #dc3545;
}

.error-message {
  color: #dc3545;
  font-size: 14px;
  margin-top: 5px;
  font-weight: bold;
}

.generic-error {
  color: #dc3545;
  font-size: 14px;
  margin-bottom: 20px;
  font-weight: bold;
}

.login-button {
  background-color: #007bff;
  color: white;
  padding: 12px 30px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
  width: 100%;
}

.login-button:hover {
  background-color: #0056b3;
}

.accessibility-info {
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}

.accessibility-info ul {
  margin: 10px 0;
  padding-left: 20px;
}

.accessibility-info code {
  background-color: #f8f9fa;
  padding: 2px 4px;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
}
</style>
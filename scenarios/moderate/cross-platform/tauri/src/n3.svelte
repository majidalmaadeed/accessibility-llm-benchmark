<script>
  import { onMount } from 'svelte';
  let username = '';
  let password = '';
  let usernameError = '';
  let passwordError = '';
  let genericError = '';
  let isSubmitting = false;
  function clearFieldError(fieldName) {
    if (fieldName === 'username') {
      usernameError = '';
    } else if (fieldName === 'password') {
      passwordError = '';
    }
  }
  function clearAllErrors() {
    usernameError = '';
    passwordError = '';
    genericError = '';
  }
  function showFieldError(fieldName, message) {
    if (fieldName === 'username') {
      usernameError = message;
    } else if (fieldName === 'password') {
      passwordError = message;
    }
  }
  function showGenericError(message) {
    genericError = message;
  }
  async function handleSubmit() {
    if (isSubmitting) return;
    clearAllErrors();
    let hasErrors = false;
    // Validate username
    if (!username.trim()) {
      showFieldError('username', 'Username is required');
      hasErrors = true;
    } else if (username.trim().length < 3) {
      showFieldError('username', 'Username must be at least 3 characters');
      hasErrors = true;
    }
    // Validate password
    if (!password) {
      showFieldError('password', 'Password is required');
      hasErrors = true;
    } else if (password.length < 8) {
      showFieldError('password', 'Password must be at least 8 characters');
      hasErrors = true;
    }
    if (hasErrors) {
      // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
      showGenericError('Please fill in all required fields.');
      return;
    }
    // Simulate login process
    isSubmitting = true;
    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      // Show success
      alert('Login successful!');
    } catch (error) {
      showGenericError('Login failed. Please try again.');
    } finally {
      isSubmitting = false;
    }
  }
</script>
  </div>
</div>
<style>
  .container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
  }
  .card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 30px;
  }
  h1 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
  }
  .description {
    color: #666;
    margin-bottom: 30px;
    font-size: 16px;
  }
  .form-group {
    margin-bottom: 20px;
  }
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
  }
  input[type="text"], input[type="password"] {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
    transition: border-color 0.3s;
  }
    outline: none;
    border-color: #007bff;
  }
  .field-error {
    border-color: #dc3545 !important;
  }
  .error-message {
    color: #dc3545;
    font-size: 14px;
    font-weight: bold;
    margin-top: 5px;
  }
  .generic-error {
    background-color: #f8d7da;
    border: 1px solid #f5c6cb;
    border-radius: 4px;
    padding: 15px;
    margin: 20px 0;
    display: flex;
    align-items: center;
  }
  .error-icon {
    color: #dc3545;
    font-weight: bold;
    margin-right: 10px;
  }
  .error-text {
    color: #dc3545;
    font-weight: bold;
  }
  .login-button {
    width: 100%;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 15px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .login-button:hover:not(:disabled) {
    background-color: #0056b3;
  }
  .login-button:disabled {
    background-color: #6c757d;
    cursor: not-allowed;
  }
    background-color: #e9ecef;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    padding: 20px;
    margin-top: 30px;
  }
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
  }
    margin-left: 20px;
    margin-bottom: 15px;
  }
    margin-bottom: 5px;
    color: #666;
  }
</style>

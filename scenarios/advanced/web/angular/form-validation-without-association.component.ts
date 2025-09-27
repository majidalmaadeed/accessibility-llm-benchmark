import { Component } from '@angular/core';

@Component({
  selector: 'app-form-validation-without-association',
  template: `
    <div class="main-container">
      <div class="main-content">
        <h1>User Registration</h1>
        <p>Create your account by filling out the form below.</p>
        
        <form (ngSubmit)="handleSubmit($event)" class="registration-form">
          <div class="form-group">
            <label for="username">Username:</label>
            <input
              type="text"
              id="username"
              [(ngModel)]="formData.username"
              (input)="clearError('username')"
              [class.error]="errors['username']"
              name="username"
            />
          </div>
          
          <div class="form-group">
            <label for="email">Email:</label>
            <input
              type="email"
              id="email"
              [(ngModel)]="formData.email"
              (input)="clearError('email')"
              [class.error]="errors['email']"
              name="email"
            />
          </div>
          
          <div class="form-group">
            <label for="password">Password:</label>
            <input
              type="password"
              id="password"
              [(ngModel)]="formData.password"
              (input)="clearError('password')"
              [class.error]="errors['password']"
              name="password"
            />
          </div>
          
          <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input
              type="password"
              id="confirmPassword"
              [(ngModel)]="formData.confirmPassword"
              (input)="clearError('confirmPassword')"
              [class.error]="errors['confirmPassword']"
              name="confirmPassword"
            />
          </div>
          
          <!-- Error Messages - Not properly associated with fields -->
          <div *ngIf="Object.keys(errors).length > 0" class="error-summary">
            <strong>Please fix the following errors:</strong>
            <ul>
              <li *ngFor="let error of getErrorEntries()">{{ error.value }}</li>
            </ul>
          </div>
          
          <button type="submit" [disabled]="isSubmitting" class="submit-button">
            {{ isSubmitting ? 'Creating Account...' : 'Create Account' }}
          </button>
        </form>
      </div>
    </div>
  `,
  styles: [`
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
  `]
})
export class FormValidationWithoutAssociationComponent {
  formData = {
    username: '',
    password: '',
    email: '',
    confirmPassword: ''
  };
  
  errors: { [key: string]: string } = {};
  isSubmitting = false;

  clearError(field: string) {
    if (this.errors[field]) {
      delete this.errors[field];
    }
  }

  getErrorEntries() {
    return Object.entries(this.errors).map(([key, value]) => ({ key, value }));
  }

  validateForm() {
    const newErrors: { [key: string]: string } = {};

    if (!this.formData.username.trim()) {
      newErrors['username'] = 'Username is required';
    } else if (this.formData.username.length < 3) {
      newErrors['username'] = 'Username must be at least 3 characters';
    }

    if (!this.formData.email.trim()) {
      newErrors['email'] = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(this.formData.email)) {
      newErrors['email'] = 'Please enter a valid email address';
    }

    if (!this.formData.password) {
      newErrors['password'] = 'Password is required';
    } else if (this.formData.password.length < 8) {
      newErrors['password'] = 'Password must be at least 8 characters';
    }

    if (!this.formData.confirmPassword) {
      newErrors['confirmPassword'] = 'Please confirm your password';
    } else if (this.formData.password !== this.formData.confirmPassword) {
      newErrors['confirmPassword'] = 'Passwords do not match';
    }

    return newErrors;
  }

  async handleSubmit(event: Event) {
    event.preventDefault();
    this.isSubmitting = true;

    const validationErrors = this.validateForm();
    
    if (Object.keys(validationErrors).length > 0) {
      this.errors = validationErrors;
      this.isSubmitting = false;
      return;
    }

    // Simulate API call
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      alert('Registration successful!');
      this.formData = { username: '', password: '', email: '', confirmPassword: '' };
      this.errors = {};
    } catch (error) {
      alert('Registration failed. Please try again.');
    } finally {
      this.isSubmitting = false;
    }
  }
}
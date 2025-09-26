import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-form-validation-without-association',
  template: `
    <div class="form-container">
      <h1>Login Form</h1>
      <p>Please enter your credentials to access your account.</p>
      
      <form [formGroup]="loginForm" (ngSubmit)="onSubmit()" class="login-form">
        <div class="form-group">
          <label for="username">Username:</label>
          <input
            type="text"
            id="username"
            formControlName="username"
            [class.error]="loginForm.get('username')?.invalid && loginForm.get('username')?.touched"
            <!-- MISSING: aria-describedby, aria-invalid -->
          />
          <div 
            *ngIf="loginForm.get('username')?.invalid && loginForm.get('username')?.touched" 
            class="error-message">
            Username is required
          </div>
        </div>
        
        <div class="form-group">
          <label for="password">Password:</label>
          <input
            type="password"
            id="password"
            formControlName="password"
            [class.error]="loginForm.get('password')?.invalid && loginForm.get('password')?.touched"
            <!-- MISSING: aria-describedby, aria-invalid -->
          />
          <div 
            *ngIf="loginForm.get('password')?.invalid && loginForm.get('password')?.touched" 
            class="error-message">
            Password is required
          </div>
        </div>
        
        <!-- GENERIC ERROR MESSAGE NOT ASSOCIATED WITH SPECIFIC FIELDS -->
        <div 
          *ngIf="showGenericError" 
          class="generic-error">
          Please fill in all required fields.
          <!-- MISSING: role="alert", aria-live -->
        </div>
        
        <button 
          type="submit" 
          class="login-button"
          [disabled]="loginForm.invalid">
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
          <li>Add <code>[attr.aria-describedby]="'error-' + fieldName"</code> to input fields</li>
          <li>Add <code>[attr.aria-invalid]="loginForm.get(fieldName)?.invalid"</code> to indicate validation state</li>
          <li>Use specific error messages for each field</li>
          <li>Add <code>role="alert"</code> or <code>aria-live="polite"</code> to error messages</li>
        </ul>
      </div>
    </div>
  `,
  styles: [`
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

    .login-button:hover:not(:disabled) {
      background-color: #0056b3;
    }

    .login-button:disabled {
      background-color: #6c757d;
      cursor: not-allowed;
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
  `]
})
export class FormValidationWithoutAssociationComponent {
  loginForm: FormGroup;
  showGenericError = false;

  constructor(private fb: FormBuilder) {
    this.loginForm = this.fb.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  onSubmit() {
    if (this.loginForm.valid) {
      alert('Form submitted successfully!');
      this.loginForm.reset();
      this.showGenericError = false;
    } else {
      this.showGenericError = true;
      // Mark all fields as touched to show validation errors
      Object.keys(this.loginForm.controls).forEach(key => {
        this.loginForm.get(key)?.markAsTouched();
      });
    }
  }
}
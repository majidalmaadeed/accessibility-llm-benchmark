import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
@Component({
  selector: 'app-form-validation-without-association',
  template: `
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
      margin-top: 30px;
      padding: 20px;
      background-color: #e9ecef;
      border-radius: 4px;
    }
      margin: 10px 0;
      padding-left: 20px;
    }
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
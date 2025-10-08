import { Component } from '@angular/core';

@Component({
  selector: 'app-ungrouped-radio-buttons',
  template: `
    <div class="contact-form">
      <h1>Contact Information Form</h1>
      <p>Please provide your contact details and preferences.</p>
      
      <form (ngSubmit)="handleSubmit()" class="form-container">
        <div class="form-group">
          <label class="form-label">Full Name *</label>
          <input
            type="text"
            [(ngModel)]="formData.name"
            name="name"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Email Address *</label>
          <input
            type="email"
            [(ngModel)]="formData.email"
            name="email"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Phone Number</label>
          <input
            type="tel"
            [(ngModel)]="formData.phone"
            name="phone"
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Preferred Contact Method</label>
          
          <!-- Contact preference radio buttons without fieldset grouping -->
          <div class="radio-group">
            <div class="radio-item">
              <input
                type="radio"
                id="email-contact"
                [(ngModel)]="formData.contactPreference"
                name="contactPreference"
                value="email"
                class="radio-input"
              />
              <label for="email-contact" class="radio-label">Email</label>
            </div>
            
            <div class="radio-item">
              <input
                type="radio"
                id="phone-contact"
                [(ngModel)]="formData.contactPreference"
                name="contactPreference"
                value="phone"
                class="radio-input"
              />
              <label for="phone-contact" class="radio-label">Phone</label>
            </div>
            
            <div class="radio-item">
              <input
                type="radio"
                id="text-contact"
                [(ngModel)]="formData.contactPreference"
                name="contactPreference"
                value="text"
                class="radio-input"
              />
              <label for="text-contact" class="radio-label">Text Message</label>
            </div>
            
            <div class="radio-item">
              <input
                type="radio"
                id="mail-contact"
                [(ngModel)]="formData.contactPreference"
                name="contactPreference"
                value="mail"
                class="radio-input"
              />
              <label for="mail-contact" class="radio-label">Postal Mail</label>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">Communication Preferences</label>
          
          <div class="checkbox-group">
            <div class="checkbox-item">
              <input
                type="checkbox"
                id="newsletter"
                [(ngModel)]="formData.newsletter"
                name="newsletter"
                class="checkbox-input"
              />
              <label for="newsletter" class="checkbox-label">Subscribe to our newsletter</label>
            </div>
            
            <div class="checkbox-item">
              <input
                type="checkbox"
                id="notifications"
                [(ngModel)]="formData.notifications"
                name="notifications"
                class="checkbox-input"
              />
              <label for="notifications" class="checkbox-label">Receive promotional notifications</label>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="btn-secondary">Cancel</button>
          <button type="submit" class="btn-primary">Submit</button>
        </div>
      </form>
    </div>
  `,
  styles: [`
    .contact-form {
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

    .radio-group {
      margin-top: 10px;
    }

    .radio-item {
      margin-bottom: 10px;
    }

    .radio-input {
      margin-right: 8px;
    }

    .radio-label {
      cursor: pointer;
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
      font-weight: bold;
      color: #333;
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
  `]
})
export class UngroupedRadioButtonsComponent {
  formData = {
    name: '',
    email: '',
    phone: '',
    contactPreference: '',
    newsletter: false,
    notifications: false
  };

  handleSubmit() {
    alert('Form submitted successfully!');
  }
}

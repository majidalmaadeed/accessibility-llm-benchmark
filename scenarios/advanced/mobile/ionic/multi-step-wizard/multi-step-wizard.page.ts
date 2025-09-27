import { Component, OnInit } from '@angular/core';
import { AlertController } from '@ionic/angular';

interface Step {
  id: number;
  title: string;
  icon: string;
}

@Component({
  selector: 'app-multi-step-wizard',
  templateUrl: './multi-step-wizard.page.html',
  styleUrls: ['./multi-step-wizard.page.scss'],
})
export class MultiStepWizardPage implements OnInit {
  currentStep: number = 1;
  totalSteps: number = 5;
  isSubmitting: boolean = false;

  steps: Step[] = [
    { id: 1, title: 'Personal Info', icon: 'person' },
    { id: 2, title: 'Address', icon: 'location' },
    { id: 3, title: 'Preferences', icon: 'settings' },
    { id: 4, title: 'Payment', icon: 'card' },
    { id: 5, title: 'Review', icon: 'checkmark-circle' }
  ];

  formData = {
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    dateOfBirth: '',
    street: '',
    city: '',
    state: '',
    zipCode: '',
    country: '',
    newsletter: false,
    notifications: true,
    theme: 'light',
    language: 'en',
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    cardholderName: '',
    termsAccepted: false,
    privacyAccepted: false
  };

  errors: { [key: string]: string } = {};

  constructor(private alertController: AlertController) {}

  ngOnInit() {}

  clearError(field: string) {
    if (this.errors[field]) {
      delete this.errors[field];
    }
  }

  validateCurrentStep(): boolean {
    this.errors = {};

    switch (this.currentStep) {
      case 1:
        if (!this.formData.firstName.trim()) {
          this.errors['firstName'] = 'First name is required';
        }
        if (!this.formData.lastName.trim()) {
          this.errors['lastName'] = 'Last name is required';
        }
        if (!this.formData.email.trim()) {
          this.errors['email'] = 'Email is required';
        } else if (!this.isValidEmail(this.formData.email)) {
          this.errors['email'] = 'Email is invalid';
        }
        if (!this.formData.phone.trim()) {
          this.errors['phone'] = 'Phone number is required';
        }
        break;
      case 2:
        if (!this.formData.street.trim()) {
          this.errors['street'] = 'Street address is required';
        }
        if (!this.formData.city.trim()) {
          this.errors['city'] = 'City is required';
        }
        if (!this.formData.state.trim()) {
          this.errors['state'] = 'State is required';
        }
        if (!this.formData.zipCode.trim()) {
          this.errors['zipCode'] = 'ZIP code is required';
        }
        break;
      case 3:
        // Preferences are optional
        break;
      case 4:
        if (!this.formData.cardNumber.trim()) {
          this.errors['cardNumber'] = 'Card number is required';
        } else if (this.formData.cardNumber.replace(/\s/g, '').length < 16) {
          this.errors['cardNumber'] = 'Card number must be 16 digits';
        }
        if (!this.formData.expiryDate.trim()) {
          this.errors['expiryDate'] = 'Expiry date is required';
        }
        if (!this.formData.cvv.trim()) {
          this.errors['cvv'] = 'CVV is required';
        }
        if (!this.formData.cardholderName.trim()) {
          this.errors['cardholderName'] = 'Cardholder name is required';
        }
        break;
      case 5:
        if (!this.formData.termsAccepted) {
          this.errors['termsAccepted'] = 'You must accept the terms and conditions';
        }
        if (!this.formData.privacyAccepted) {
          this.errors['privacyAccepted'] = 'You must accept the privacy policy';
        }
        break;
    }

    return Object.keys(this.errors).length === 0;
  }

  isValidEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  previousStep() {
    if (this.currentStep > 1) {
      this.currentStep--;
    }
  }

  nextStep() {
    if (this.validateCurrentStep()) {
      if (this.currentStep < this.totalSteps) {
        this.currentStep++;
      } else {
        this.submitForm();
      }
    }
  }

  async submitForm() {
    this.isSubmitting = true;

    // Simulate API call
    setTimeout(async () => {
      this.isSubmitting = false;

      const alert = await this.alertController.create({
        header: 'Success!',
        message: 'Your registration has been completed successfully.',
        buttons: [
          {
            text: 'OK',
            handler: () => {
              this.resetForm();
            }
          }
        ]
      });

      await alert.present();
    }, 2000);
  }

  resetForm() {
    this.currentStep = 1;
    this.formData = {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      dateOfBirth: '',
      street: '',
      city: '',
      state: '',
      zipCode: '',
      country: '',
      newsletter: false,
      notifications: true,
      theme: 'light',
      language: 'en',
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      cardholderName: '',
      termsAccepted: false,
      privacyAccepted: false
    };
    this.errors = {};
  }
}

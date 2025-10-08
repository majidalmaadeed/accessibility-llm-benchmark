import { Component, OnInit } from '@angular/core';

interface Step {
  id: number;
  title: string;
  description: string;
}

interface PersonalInfo {
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  dateOfBirth: string;
}

interface AddressInfo {
  street: string;
  city: string;
  state: string;
  zipCode: string;
  country: string;
}

interface Preferences {
  newsletter: boolean;
  notifications: boolean;
  theme: string;
  language: string;
}

interface PaymentInfo {
  cardNumber: string;
  expiryDate: string;
  cvv: string;
  billingAddress: string;
}

interface FormData {
  personalInfo: PersonalInfo;
  addressInfo: AddressInfo;
  preferences: Preferences;
  paymentInfo: PaymentInfo;
}

@Component({
  selector: 'app-multi-step-wizard',
  templateUrl: './multi-step-wizard.component.html',
  styleUrls: ['./multi-step-wizard.component.css']
})
export class MultiStepWizardComponent implements OnInit {
  currentStep: number = 1;
  formData: FormData = {
    personalInfo: {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      dateOfBirth: ''
    },
    addressInfo: {
      street: '',
      city: '',
      state: '',
      zipCode: '',
      country: ''
    },
    preferences: {
      newsletter: false,
      notifications: false,
      theme: 'light',
      language: 'en'
    },
    paymentInfo: {
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      billingAddress: ''
    }
  };
  errors: { [key: string]: string } = {};
  isSubmitting: boolean = false;
  steps: Step[] = [
    { id: 1, title: 'Personal Information', description: 'Basic details about yourself' },
    { id: 2, title: 'Address Information', description: 'Where you live' },
    { id: 3, title: 'Preferences', description: 'Your preferences and settings' },
    { id: 4, title: 'Payment Information', description: 'Billing and payment details' },
    { id: 5, title: 'Review & Submit', description: 'Review your information' }
  ];

  constructor() { }

  ngOnInit(): void {
  }

  get progressPercentage(): number {
    return (this.currentStep / this.steps.length) * 100;
  }

  validateStep(step: number): boolean {
    this.errors = {};

    switch (step) {
      case 1:
        if (!this.formData.personalInfo.firstName) this.errors['firstName'] = 'First name is required';
        if (!this.formData.personalInfo.lastName) this.errors['lastName'] = 'Last name is required';
        if (!this.formData.personalInfo.email) this.errors['email'] = 'Email is required';
        else if (!/\S+@\S+\.\S+/.test(this.formData.personalInfo.email)) {
          this.errors['email'] = 'Email is invalid';
        }
        if (!this.formData.personalInfo.phone) this.errors['phone'] = 'Phone number is required';
        break;
      
      case 2:
        if (!this.formData.addressInfo.street) this.errors['street'] = 'Street address is required';
        if (!this.formData.addressInfo.city) this.errors['city'] = 'City is required';
        if (!this.formData.addressInfo.state) this.errors['state'] = 'State is required';
        if (!this.formData.addressInfo.zipCode) this.errors['zipCode'] = 'ZIP code is required';
        break;
      
      case 3:
        // Preferences are optional, no validation needed
        break;
      
      case 4:
        if (!this.formData.paymentInfo.cardNumber) this.errors['cardNumber'] = 'Card number is required';
        if (!this.formData.paymentInfo.expiryDate) this.errors['expiryDate'] = 'Expiry date is required';
        if (!this.formData.paymentInfo.cvv) this.errors['cvv'] = 'CVV is required';
        break;
      
      default:
        break;
    }

    return Object.keys(this.errors).length === 0;
  }

  handleNext(): void {
    if (this.validateStep(this.currentStep)) {
      this.currentStep = Math.min(this.currentStep + 1, this.steps.length);
    }
  }

  handlePrevious(): void {
    this.currentStep = Math.max(this.currentStep - 1, 1);
  }

  async handleSubmit(): Promise<void> {
    if (this.validateStep(this.currentStep)) {
      this.isSubmitting = true;
      
      // Simulate API call
      setTimeout(() => {
        console.log('Form submitted:', this.formData);
        this.isSubmitting = false;
        alert('Registration completed successfully!');
      }, 2000);
    }
  }

  getStepClass(step: Step): string {
    let classes = 'step';
    if (this.currentStep === step.id) {
      classes += ' active';
    }
    if (this.currentStep > step.id) {
      classes += ' completed';
    }
    return classes;
  }

  getStepNumber(step: Step): string {
    return this.currentStep > step.id ? '✓' : step.id.toString();
  }

  hasError(field: string): boolean {
    return !!this.errors[field];
  }

  getError(field: string): string {
    return this.errors[field] || '';
  }

  getMaskedCardNumber(): string {
    const cardNumber = this.formData.paymentInfo.cardNumber;
    if (cardNumber.length >= 4) {
      return '**** **** **** ' + cardNumber.slice(-4);
    }
    return cardNumber;
  }
}

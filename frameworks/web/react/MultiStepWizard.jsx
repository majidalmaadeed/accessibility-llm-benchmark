import React, { useState } from 'react';
import './MultiStepWizard.css';

const MultiStepWizard = () => {
  const [currentStep, setCurrentStep] = useState(1);
  const [formData, setFormData] = useState({
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
  });

  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  const steps = [
    { id: 1, title: 'Personal Information', description: 'Basic details about yourself' },
    { id: 2, title: 'Address Information', description: 'Where you live' },
    { id: 3, title: 'Preferences', description: 'Your preferences and settings' },
    { id: 4, title: 'Payment Information', description: 'Billing and payment details' },
    { id: 5, title: 'Review & Submit', description: 'Review your information' }
  ];

  const validateStep = (step) => {
    const newErrors = {};

    switch (step) {
      case 1:
        if (!formData.personalInfo.firstName) newErrors.firstName = 'First name is required';
        if (!formData.personalInfo.lastName) newErrors.lastName = 'Last name is required';
        if (!formData.personalInfo.email) newErrors.email = 'Email is required';
        else if (!/\S+@\S+\.\S+/.test(formData.personalInfo.email)) {
          newErrors.email = 'Email is invalid';
        }
        if (!formData.personalInfo.phone) newErrors.phone = 'Phone number is required';
        break;
      
      case 2:
        if (!formData.addressInfo.street) newErrors.street = 'Street address is required';
        if (!formData.addressInfo.city) newErrors.city = 'City is required';
        if (!formData.addressInfo.state) newErrors.state = 'State is required';
        if (!formData.addressInfo.zipCode) newErrors.zipCode = 'ZIP code is required';
        break;
      
      case 3:
        // Preferences are optional, no validation needed
        break;
      
      case 4:
        if (!formData.paymentInfo.cardNumber) newErrors.cardNumber = 'Card number is required';
        if (!formData.paymentInfo.expiryDate) newErrors.expiryDate = 'Expiry date is required';
        if (!formData.paymentInfo.cvv) newErrors.cvv = 'CVV is required';
        break;
      
      default:
        break;
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleInputChange = (section, field, value) => {
    setFormData(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value
      }
    }));
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: ''
      }));
    }
  };

  const handleNext = () => {
    if (validateStep(currentStep)) {
      setCurrentStep(prev => Math.min(prev + 1, steps.length));
    }
  };

  const handlePrevious = () => {
    setCurrentStep(prev => Math.max(prev - 1, 1));
  };

  const handleSubmit = async () => {
    if (validateStep(currentStep)) {
      setIsSubmitting(true);
      
      // Simulate API call
      setTimeout(() => {
        console.log('Form submitted:', formData);
        setIsSubmitting(false);
        alert('Registration completed successfully!');
      }, 2000);
    }
  };

  const renderStepContent = () => {
    switch (currentStep) {
      case 1:
        return (
          <div className="step-content">
            <h3>Personal Information</h3>
            <div className="form-group">
              <input
                type="text"
                placeholder="First Name"
                value={formData.personalInfo.firstName}
                onChange={(e) => handleInputChange('personalInfo', 'firstName', e.target.value)}
                className={errors.firstName ? 'error' : ''}
              />
              {errors.firstName && <span className="error-message">{errors.firstName}</span>}
            </div>
            
            <div className="form-group">
              <input
                type="text"
                placeholder="Last Name"
                value={formData.personalInfo.lastName}
                onChange={(e) => handleInputChange('personalInfo', 'lastName', e.target.value)}
                className={errors.lastName ? 'error' : ''}
              />
              {errors.lastName && <span className="error-message">{errors.lastName}</span>}
            </div>
            
            <div className="form-group">
              <input
                type="email"
                placeholder="Email Address"
                value={formData.personalInfo.email}
                onChange={(e) => handleInputChange('personalInfo', 'email', e.target.value)}
                className={errors.email ? 'error' : ''}
              />
              {errors.email && <span className="error-message">{errors.email}</span>}
            </div>
            
            <div className="form-group">
              <input
                type="tel"
                placeholder="Phone Number"
                value={formData.personalInfo.phone}
                onChange={(e) => handleInputChange('personalInfo', 'phone', e.target.value)}
                className={errors.phone ? 'error' : ''}
              />
              {errors.phone && <span className="error-message">{errors.phone}</span>}
            </div>
            
            <div className="form-group">
              <input
                type="date"
                value={formData.personalInfo.dateOfBirth}
                onChange={(e) => handleInputChange('personalInfo', 'dateOfBirth', e.target.value)}
              />
            </div>
          </div>
        );

      case 2:
        return (
          <div className="step-content">
            <h3>Address Information</h3>
            <div className="form-group">
              <input
                type="text"
                placeholder="Street Address"
                value={formData.addressInfo.street}
                onChange={(e) => handleInputChange('addressInfo', 'street', e.target.value)}
                className={errors.street ? 'error' : ''}
              />
              {errors.street && <span className="error-message">{errors.street}</span>}
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="City"
                  value={formData.addressInfo.city}
                  onChange={(e) => handleInputChange('addressInfo', 'city', e.target.value)}
                  className={errors.city ? 'error' : ''}
                />
                {errors.city && <span className="error-message">{errors.city}</span>}
              </div>
              
              <div className="form-group">
                <input
                  type="text"
                  placeholder="State"
                  value={formData.addressInfo.state}
                  onChange={(e) => handleInputChange('addressInfo', 'state', e.target.value)}
                  className={errors.state ? 'error' : ''}
                />
                {errors.state && <span className="error-message">{errors.state}</span>}
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="ZIP Code"
                  value={formData.addressInfo.zipCode}
                  onChange={(e) => handleInputChange('addressInfo', 'zipCode', e.target.value)}
                  className={errors.zipCode ? 'error' : ''}
                />
                {errors.zipCode && <span className="error-message">{errors.zipCode}</span>}
              </div>
              
              <div className="form-group">
                <select
                  value={formData.addressInfo.country}
                  onChange={(e) => handleInputChange('addressInfo', 'country', e.target.value)}
                >
                  <option value="">Select Country</option>
                  <option value="US">United States</option>
                  <option value="CA">Canada</option>
                  <option value="UK">United Kingdom</option>
                  <option value="AU">Australia</option>
                </select>
              </div>
            </div>
          </div>
        );

      case 3:
        return (
          <div className="step-content">
            <h3>Preferences</h3>
            <div className="form-group">
              <label>
                <input
                  type="checkbox"
                  checked={formData.preferences.newsletter}
                  onChange={(e) => handleInputChange('preferences', 'newsletter', e.target.checked)}
                />
                Subscribe to newsletter
              </label>
            </div>
            
            <div className="form-group">
              <label>
                <input
                  type="checkbox"
                  checked={formData.preferences.notifications}
                  onChange={(e) => handleInputChange('preferences', 'notifications', e.target.checked)}
                />
                Enable push notifications
              </label>
            </div>
            
            <div className="form-group">
              <label>Theme Preference</label>
              <select
                value={formData.preferences.theme}
                onChange={(e) => handleInputChange('preferences', 'theme', e.target.value)}
              >
                <option value="light">Light</option>
                <option value="dark">Dark</option>
                <option value="auto">Auto</option>
              </select>
            </div>
            
            <div className="form-group">
              <label>Language</label>
              <select
                value={formData.preferences.language}
                onChange={(e) => handleInputChange('preferences', 'language', e.target.value)}
              >
                <option value="en">English</option>
                <option value="es">Spanish</option>
                <option value="fr">French</option>
                <option value="de">German</option>
              </select>
            </div>
          </div>
        );

      case 4:
        return (
          <div className="step-content">
            <h3>Payment Information</h3>
            <div className="form-group">
              <input
                type="text"
                placeholder="Card Number"
                value={formData.paymentInfo.cardNumber}
                onChange={(e) => handleInputChange('paymentInfo', 'cardNumber', e.target.value)}
                className={errors.cardNumber ? 'error' : ''}
              />
              {errors.cardNumber && <span className="error-message">{errors.cardNumber}</span>}
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="MM/YY"
                  value={formData.paymentInfo.expiryDate}
                  onChange={(e) => handleInputChange('paymentInfo', 'expiryDate', e.target.value)}
                  className={errors.expiryDate ? 'error' : ''}
                />
                {errors.expiryDate && <span className="error-message">{errors.expiryDate}</span>}
              </div>
              
              <div className="form-group">
                <input
                  type="text"
                  placeholder="CVV"
                  value={formData.paymentInfo.cvv}
                  onChange={(e) => handleInputChange('paymentInfo', 'cvv', e.target.value)}
                  className={errors.cvv ? 'error' : ''}
                />
                {errors.cvv && <span className="error-message">{errors.cvv}</span>}
              </div>
            </div>
            
            <div className="form-group">
              <input
                type="text"
                placeholder="Billing Address (if different)"
                value={formData.paymentInfo.billingAddress}
                onChange={(e) => handleInputChange('paymentInfo', 'billingAddress', e.target.value)}
              />
            </div>
          </div>
        );

      case 5:
        return (
          <div className="step-content">
            <h3>Review Your Information</h3>
            <div className="review-section">
              <h4>Personal Information</h4>
              <p><strong>Name:</strong> {formData.personalInfo.firstName} {formData.personalInfo.lastName}</p>
              <p><strong>Email:</strong> {formData.personalInfo.email}</p>
              <p><strong>Phone:</strong> {formData.personalInfo.phone}</p>
              <p><strong>Date of Birth:</strong> {formData.personalInfo.dateOfBirth}</p>
            </div>
            
            <div className="review-section">
              <h4>Address</h4>
              <p>{formData.addressInfo.street}</p>
              <p>{formData.addressInfo.city}, {formData.addressInfo.state} {formData.addressInfo.zipCode}</p>
              <p>{formData.addressInfo.country}</p>
            </div>
            
            <div className="review-section">
              <h4>Preferences</h4>
              <p><strong>Newsletter:</strong> {formData.preferences.newsletter ? 'Yes' : 'No'}</p>
              <p><strong>Notifications:</strong> {formData.preferences.notifications ? 'Yes' : 'No'}</p>
              <p><strong>Theme:</strong> {formData.preferences.theme}</p>
              <p><strong>Language:</strong> {formData.preferences.language}</p>
            </div>
            
            <div className="review-section">
              <h4>Payment</h4>
              <p><strong>Card:</strong> **** **** **** {formData.paymentInfo.cardNumber.slice(-4)}</p>
              <p><strong>Expires:</strong> {formData.paymentInfo.expiryDate}</p>
            </div>
          </div>
        );

      default:
        return null;
    }
  };

  const progressPercentage = (currentStep / steps.length) * 100;

  return (
    <div className="wizard-container">
      <div className="wizard-header">
        <h1>User Registration Wizard</h1>
        <div className="progress-bar">
          <div 
            className="progress-fill" 
            style={{ width: `${progressPercentage}%` }}
          ></div>
        </div>
        <div className="progress-text">
          Step {currentStep} of {steps.length}
        </div>
      </div>

      <div className="wizard-steps">
        {steps.map((step, index) => (
          <div 
            key={step.id} 
            className={`step ${currentStep === step.id ? 'active' : ''} ${currentStep > step.id ? 'completed' : ''}`}
            onClick={() => setCurrentStep(step.id)}
          >
            <div className="step-number">
              {currentStep > step.id ? '✓' : step.id}
            </div>
            <div className="step-info">
              <div className="step-title">{step.title}</div>
              <div className="step-description">{step.description}</div>
            </div>
          </div>
        ))}
      </div>

      <div className="wizard-content">
        {renderStepContent()}
      </div>

      <div className="wizard-navigation">
        <button 
          onClick={handlePrevious}
          disabled={currentStep === 1}
          className="btn-secondary"
        >
          Previous
        </button>
        
        {currentStep < steps.length ? (
          <button 
            onClick={handleNext}
            className="btn-primary"
          >
            Next
          </button>
        ) : (
          <button 
            onClick={handleSubmit}
            disabled={isSubmitting}
            className="btn-primary"
          >
            {isSubmitting ? 'Submitting...' : 'Complete Registration'}
          </button>
        )}
      </div>
    </div>
  );
};

export default MultiStepWizard;

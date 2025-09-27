'use client';

import { useState, useEffect } from 'react';
import styles from './MultiStepWizard.module.css';

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
    { id: 1, title: 'Personal', description: 'Basic information' },
    { id: 2, title: 'Address', description: 'Location details' },
    { id: 3, title: 'Preferences', description: 'Your settings' },
    { id: 4, title: 'Payment', description: 'Billing information' },
    { id: 5, title: 'Review', description: 'Confirm details' }
  ];

  useEffect(() => {
    validateCurrentStep();
  }, [currentStep, formData]);

  const validateCurrentStep = () => {
    const newErrors = {};

    switch (currentStep) {
      case 1:
        if (!formData.personalInfo.firstName.trim()) {
          newErrors.firstName = 'First name is required';
        }
        if (!formData.personalInfo.lastName.trim()) {
          newErrors.lastName = 'Last name is required';
        }
        if (!formData.personalInfo.email.trim()) {
          newErrors.email = 'Email is required';
        } else if (!/\S+@\S+\.\S+/.test(formData.personalInfo.email)) {
          newErrors.email = 'Email is invalid';
        }
        if (!formData.personalInfo.phone.trim()) {
          newErrors.phone = 'Phone number is required';
        }
        break;
      case 2:
        if (!formData.addressInfo.street.trim()) {
          newErrors.street = 'Street address is required';
        }
        if (!formData.addressInfo.city.trim()) {
          newErrors.city = 'City is required';
        }
        if (!formData.addressInfo.state.trim()) {
          newErrors.state = 'State is required';
        }
        if (!formData.addressInfo.zipCode.trim()) {
          newErrors.zipCode = 'ZIP code is required';
        }
        break;
      case 4:
        if (!formData.paymentInfo.cardNumber.trim()) {
          newErrors.cardNumber = 'Card number is required';
        }
        if (!formData.paymentInfo.expiryDate.trim()) {
          newErrors.expiryDate = 'Expiry date is required';
        }
        if (!formData.paymentInfo.cvv.trim()) {
          newErrors.cvv = 'CVV is required';
        }
        break;
    }

    setErrors(newErrors);
  };

  const handleInputChange = (section, field, value) => {
    setFormData(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value
      }
    }));
  };

  const handleNext = () => {
    if (Object.keys(errors).length === 0 && currentStep < steps.length) {
      setCurrentStep(prev => prev + 1);
    }
  };

  const handlePrevious = () => {
    if (currentStep > 1) {
      setCurrentStep(prev => prev - 1);
    }
  };

  const handleSubmit = async () => {
    setIsSubmitting(true);
    
    setTimeout(() => {
      console.log('Form submitted:', formData);
      setIsSubmitting(false);
      alert('Registration completed successfully!');
    }, 2000);
  };

  const getStepClass = (step) => {
    if (step.id === currentStep) return 'active';
    if (step.id < currentStep) return 'completed';
    return '';
  };

  const getStepNumber = (step) => {
    return step.id < currentStep ? '✓' : step.id;
  };

  const progressPercentage = (currentStep / steps.length) * 100;

  const hasError = (field) => {
    return errors[field] ? true : false;
  };

  const getError = (field) => {
    return errors[field] || '';
  };

  const getMaskedCardNumber = () => {
    const cardNumber = formData.paymentInfo.cardNumber;
    if (cardNumber.length > 4) {
      return '**** **** **** ' + cardNumber.slice(-4);
    }
    return cardNumber;
  };

  return (
    <div className={styles.wizardContainer}>
      <div className={styles.wizardHeader}>
        <h1>User Registration Wizard</h1>
        <div className={styles.progressBar}>
          <div 
            className={styles.progressFill} 
            style={{ width: `${progressPercentage}%` }}
          />
        </div>
        <div className={styles.progressText}>
          Step {currentStep} of {steps.length}
        </div>
      </div>

      <div className={styles.wizardSteps}>
        {steps.map((step) => (
          <div 
            key={step.id}
            className={`${styles.step} ${getStepClass(step)}`}
            onClick={() => setCurrentStep(step.id)}
          >
            <div className={styles.stepNumber}>
              {getStepNumber(step)}
            </div>
            <div className={styles.stepInfo}>
              <div className={styles.stepTitle}>{step.title}</div>
              <div className={styles.stepDescription}>{step.description}</div>
            </div>
          </div>
        ))}
      </div>

      <div className={styles.wizardContent}>
        {currentStep === 1 && (
          <div className={styles.stepContent}>
            <h3>Personal Information</h3>
            <div className={styles.formGroup}>
              <input
                type="text"
                placeholder="First Name"
                value={formData.personalInfo.firstName}
                onChange={(e) => handleInputChange('personalInfo', 'firstName', e.target.value)}
                className={`${styles.formInput} ${hasError('firstName') ? styles.error : ''}`}
              />
              {hasError('firstName') && (
                <span className={styles.errorMessage}>{getError('firstName')}</span>
              )}
            </div>
            
            <div className={styles.formGroup}>
              <input
                type="text"
                placeholder="Last Name"
                value={formData.personalInfo.lastName}
                onChange={(e) => handleInputChange('personalInfo', 'lastName', e.target.value)}
                className={`${styles.formInput} ${hasError('lastName') ? styles.error : ''}`}
              />
              {hasError('lastName') && (
                <span className={styles.errorMessage}>{getError('lastName')}</span>
              )}
            </div>
            
            <div className={styles.formGroup}>
              <input
                type="email"
                placeholder="Email Address"
                value={formData.personalInfo.email}
                onChange={(e) => handleInputChange('personalInfo', 'email', e.target.value)}
                className={`${styles.formInput} ${hasError('email') ? styles.error : ''}`}
              />
              {hasError('email') && (
                <span className={styles.errorMessage}>{getError('email')}</span>
              )}
            </div>
            
            <div className={styles.formGroup}>
              <input
                type="tel"
                placeholder="Phone Number"
                value={formData.personalInfo.phone}
                onChange={(e) => handleInputChange('personalInfo', 'phone', e.target.value)}
                className={`${styles.formInput} ${hasError('phone') ? styles.error : ''}`}
              />
              {hasError('phone') && (
                <span className={styles.errorMessage}>{getError('phone')}</span>
              )}
            </div>
            
            <div className={styles.formGroup}>
              <input
                type="date"
                value={formData.personalInfo.dateOfBirth}
                onChange={(e) => handleInputChange('personalInfo', 'dateOfBirth', e.target.value)}
                className={styles.formInput}
              />
            </div>
          </div>
        )}

        {currentStep === 2 && (
          <div className={styles.stepContent}>
            <h3>Address Information</h3>
            <div className={styles.formGroup}>
              <input
                type="text"
                placeholder="Street Address"
                value={formData.addressInfo.street}
                onChange={(e) => handleInputChange('addressInfo', 'street', e.target.value)}
                className={`${styles.formInput} ${hasError('street') ? styles.error : ''}`}
              />
              {hasError('street') && (
                <span className={styles.errorMessage}>{getError('street')}</span>
              )}
            </div>
            
            <div className={styles.formRow}>
              <div className={styles.formGroup}>
                <input
                  type="text"
                  placeholder="City"
                  value={formData.addressInfo.city}
                  onChange={(e) => handleInputChange('addressInfo', 'city', e.target.value)}
                  className={`${styles.formInput} ${hasError('city') ? styles.error : ''}`}
                />
                {hasError('city') && (
                  <span className={styles.errorMessage}>{getError('city')}</span>
                )}
              </div>
              
              <div className={styles.formGroup}>
                <input
                  type="text"
                  placeholder="State"
                  value={formData.addressInfo.state}
                  onChange={(e) => handleInputChange('addressInfo', 'state', e.target.value)}
                  className={`${styles.formInput} ${hasError('state') ? styles.error : ''}`}
                />
                {hasError('state') && (
                  <span className={styles.errorMessage}>{getError('state')}</span>
                )}
              </div>
            </div>
            
            <div className={styles.formRow}>
              <div className={styles.formGroup}>
                <input
                  type="text"
                  placeholder="ZIP Code"
                  value={formData.addressInfo.zipCode}
                  onChange={(e) => handleInputChange('addressInfo', 'zipCode', e.target.value)}
                  className={`${styles.formInput} ${hasError('zipCode') ? styles.error : ''}`}
                />
                {hasError('zipCode') && (
                  <span className={styles.errorMessage}>{getError('zipCode')}</span>
                )}
              </div>
              
              <div className={styles.formGroup}>
                <select 
                  value={formData.addressInfo.country}
                  onChange={(e) => handleInputChange('addressInfo', 'country', e.target.value)}
                  className={styles.formInput}
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
        )}

        {currentStep === 3 && (
          <div className={styles.stepContent}>
            <h3>Preferences</h3>
            <div className={styles.formGroup}>
              <label className={styles.checkboxLabel}>
                <input
                  type="checkbox"
                  checked={formData.preferences.newsletter}
                  onChange={(e) => handleInputChange('preferences', 'newsletter', e.target.checked)}
                />
                Subscribe to newsletter
              </label>
            </div>
            
            <div className={styles.formGroup}>
              <label className={styles.checkboxLabel}>
                <input
                  type="checkbox"
                  checked={formData.preferences.notifications}
                  onChange={(e) => handleInputChange('preferences', 'notifications', e.target.checked)}
                />
                Enable push notifications
              </label>
            </div>
            
            <div className={styles.formGroup}>
              <label className={styles.formLabel}>Theme Preference</label>
              <select 
                value={formData.preferences.theme}
                onChange={(e) => handleInputChange('preferences', 'theme', e.target.value)}
                className={styles.formInput}
              >
                <option value="light">Light</option>
                <option value="dark">Dark</option>
                <option value="auto">Auto</option>
              </select>
            </div>
            
            <div className={styles.formGroup}>
              <label className={styles.formLabel}>Language</label>
              <select 
                value={formData.preferences.language}
                onChange={(e) => handleInputChange('preferences', 'language', e.target.value)}
                className={styles.formInput}
              >
                <option value="en">English</option>
                <option value="es">Spanish</option>
                <option value="fr">French</option>
                <option value="de">German</option>
              </select>
            </div>
          </div>
        )}

        {currentStep === 4 && (
          <div className={styles.stepContent}>
            <h3>Payment Information</h3>
            <div className={styles.formGroup}>
              <input
                type="text"
                placeholder="Card Number"
                value={formData.paymentInfo.cardNumber}
                onChange={(e) => handleInputChange('paymentInfo', 'cardNumber', e.target.value)}
                className={`${styles.formInput} ${hasError('cardNumber') ? styles.error : ''}`}
              />
              {hasError('cardNumber') && (
                <span className={styles.errorMessage}>{getError('cardNumber')}</span>
              )}
            </div>
            
            <div className={styles.formRow}>
              <div className={styles.formGroup}>
                <input
                  type="text"
                  placeholder="MM/YY"
                  value={formData.paymentInfo.expiryDate}
                  onChange={(e) => handleInputChange('paymentInfo', 'expiryDate', e.target.value)}
                  className={`${styles.formInput} ${hasError('expiryDate') ? styles.error : ''}`}
                />
                {hasError('expiryDate') && (
                  <span className={styles.errorMessage}>{getError('expiryDate')}</span>
                )}
              </div>
              
              <div className={styles.formGroup}>
                <input
                  type="text"
                  placeholder="CVV"
                  value={formData.paymentInfo.cvv}
                  onChange={(e) => handleInputChange('paymentInfo', 'cvv', e.target.value)}
                  className={`${styles.formInput} ${hasError('cvv') ? styles.error : ''}`}
                />
                {hasError('cvv') && (
                  <span className={styles.errorMessage}>{getError('cvv')}</span>
                )}
              </div>
            </div>
            
            <div className={styles.formGroup}>
              <input
                type="text"
                placeholder="Billing Address (if different)"
                value={formData.paymentInfo.billingAddress}
                onChange={(e) => handleInputChange('paymentInfo', 'billingAddress', e.target.value)}
                className={styles.formInput}
              />
            </div>
          </div>
        )}

        {currentStep === 5 && (
          <div className={styles.stepContent}>
            <h3>Review Your Information</h3>
            <div className={styles.reviewSection}>
              <h4>Personal Information</h4>
              <p><strong>Name:</strong> {formData.personalInfo.firstName} {formData.personalInfo.lastName}</p>
              <p><strong>Email:</strong> {formData.personalInfo.email}</p>
              <p><strong>Phone:</strong> {formData.personalInfo.phone}</p>
              <p><strong>Date of Birth:</strong> {formData.personalInfo.dateOfBirth}</p>
            </div>
            
            <div className={styles.reviewSection}>
              <h4>Address</h4>
              <p>{formData.addressInfo.street}</p>
              <p>{formData.addressInfo.city}, {formData.addressInfo.state} {formData.addressInfo.zipCode}</p>
              <p>{formData.addressInfo.country}</p>
            </div>
            
            <div className={styles.reviewSection}>
              <h4>Preferences</h4>
              <p><strong>Newsletter:</strong> {formData.preferences.newsletter ? 'Yes' : 'No'}</p>
              <p><strong>Notifications:</strong> {formData.preferences.notifications ? 'Yes' : 'No'}</p>
              <p><strong>Theme:</strong> {formData.preferences.theme}</p>
              <p><strong>Language:</strong> {formData.preferences.language}</p>
            </div>
            
            <div className={styles.reviewSection}>
              <h4>Payment</h4>
              <p><strong>Card:</strong> {getMaskedCardNumber()}</p>
              <p><strong>Expires:</strong> {formData.paymentInfo.expiryDate}</p>
            </div>
          </div>
        )}
      </div>

      <div className={styles.wizardNavigation}>
        <button 
          onClick={handlePrevious}
          disabled={currentStep === 1}
          className={styles.btnSecondary}
        >
          Previous
        </button>
        
        {currentStep < steps.length ? (
          <button 
            onClick={handleNext}
            className={styles.btnPrimary}
          >
            Next
          </button>
        ) : (
          <button 
            onClick={handleSubmit}
            disabled={isSubmitting}
            className={styles.btnPrimary}
          >
            {isSubmitting ? 'Submitting...' : 'Complete Registration'}
          </button>
        )}
      </div>
    </div>
  );
};

export default MultiStepWizard;

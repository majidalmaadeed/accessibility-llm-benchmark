import React, { useState } from 'react';

const Wizard = () => {
  const [currentStep, setCurrentStep] = useState(1);
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    country: '',
    language: '',
    theme: 'dark',
    emailNotifications: false,
    smsNotifications: false,
    pushNotifications: true,
    volume: 50,
    fontSize: 12,
    username: '',
    password: '',
    confirmPassword: '',
    termsAccepted: false,
    privacyAccepted: false,
    newsletter: false,
    bio: '',
    industry: '',
    experience: '',
    website: '',
    birthDate: ''
  });

  const totalSteps = 5;

  const steps = [
    { number: 1, title: 'Personal Information', description: 'Enter your personal details' },
    { number: 2, title: 'Preferences', description: 'Set your preferences' },
    { number: 3, title: 'Account Settings', description: 'Create your account' },
    { number: 4, title: 'Additional Information', description: 'Tell us more about yourself' },
    { number: 5, title: 'Review and Confirm', description: 'Review your information' }
  ];

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const nextStep = () => {
    if (validateCurrentStep()) {
      setCurrentStep(prev => Math.min(prev + 1, totalSteps));
    }
  };

  const prevStep = () => {
    setCurrentStep(prev => Math.max(prev - 1, 1));
  };

  const validateCurrentStep = () => {
    switch (currentStep) {
      case 1:
        if (!formData.firstName || !formData.lastName || !formData.email) {
          alert('Please fill in all required fields in Personal Information.');
          return false;
        }
        break;
      case 3:
        if (!formData.username || !formData.password || !formData.confirmPassword) {
          alert('Please fill in all required fields in Account Settings.');
          return false;
        }
        if (formData.password !== formData.confirmPassword) {
          alert('Passwords do not match.');
          return false;
        }
        if (!formData.termsAccepted || !formData.privacyAccepted) {
          alert('You must accept the Terms of Service and Privacy Policy.');
          return false;
        }
        break;
      default:
        break;
    }
    return true;
  };

  const finishWizard = () => {
    if (validateCurrentStep()) {
      alert('Wizard completed successfully! Thank you for your information.');
    }
  };

  const renderStepContent = () => {
    switch (currentStep) {
      case 1:
        return (
          <div>
            <h3>Personal Information</h3>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">First Name *</label>
                <input
                  type="text"
                  className="form-control"
                  value={formData.firstName}
                  onChange={(e) => handleInputChange('firstName', e.target.value)}
                />
              </div>
              <div className="form-group">
                <label className="form-label">Last Name *</label>
                <input
                  type="text"
                  className="form-control"
                  value={formData.lastName}
                  onChange={(e) => handleInputChange('lastName', e.target.value)}
                />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Email *</label>
                <input
                  type="email"
                  className="form-control"
                  value={formData.email}
                  onChange={(e) => handleInputChange('email', e.target.value)}
                />
              </div>
              <div className="form-group">
                <label className="form-label">Phone</label>
                <input
                  type="tel"
                  className="form-control"
                  value={formData.phone}
                  onChange={(e) => handleInputChange('phone', e.target.value)}
                />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Country</label>
                <select
                  className="form-control"
                  value={formData.country}
                  onChange={(e) => handleInputChange('country', e.target.value)}
                >
                  <option value="">Select Country</option>
                  <option value="US">United States</option>
                  <option value="CA">Canada</option>
                  <option value="UK">United Kingdom</option>
                  <option value="DE">Germany</option>
                  <option value="FR">France</option>
                  <option value="JP">Japan</option>
                  <option value="AU">Australia</option>
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Language</label>
                <select
                  className="form-control"
                  value={formData.language}
                  onChange={(e) => handleInputChange('language', e.target.value)}
                >
                  <option value="">Select Language</option>
                  <option value="en">English</option>
                  <option value="es">Spanish</option>
                  <option value="fr">French</option>
                  <option value="de">German</option>
                  <option value="ja">Japanese</option>
                  <option value="zh">Chinese</option>
                </select>
              </div>
            </div>
          </div>
        );

      case 2:
        return (
          <div>
            <h3>Preferences</h3>
            <div className="form-group">
              <label className="form-label">Theme Preference</label>
              <div>
                <label>
                  <input
                    type="radio"
                    name="theme"
                    value="light"
                    checked={formData.theme === 'light'}
                    onChange={(e) => handleInputChange('theme', e.target.value)}
                  />
                  Light Theme
                </label>
                <label style={{ marginLeft: '20px' }}>
                  <input
                    type="radio"
                    name="theme"
                    value="dark"
                    checked={formData.theme === 'dark'}
                    onChange={(e) => handleInputChange('theme', e.target.value)}
                  />
                  Dark Theme
                </label>
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Notification Preferences</label>
              <div>
                <label>
                  <input
                    type="checkbox"
                    checked={formData.emailNotifications}
                    onChange={(e) => handleInputChange('emailNotifications', e.target.checked)}
                  />
                  Email Notifications
                </label>
                <label style={{ marginLeft: '20px' }}>
                  <input
                    type="checkbox"
                    checked={formData.smsNotifications}
                    onChange={(e) => handleInputChange('smsNotifications', e.target.checked)}
                  />
                  SMS Notifications
                </label>
                <label style={{ marginLeft: '20px' }}>
                  <input
                    type="checkbox"
                    checked={formData.pushNotifications}
                    onChange={(e) => handleInputChange('pushNotifications', e.target.checked)}
                  />
                  Push Notifications
                </label>
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Volume: {formData.volume}%</label>
                <input
                  type="range"
                  min="0"
                  max="100"
                  value={formData.volume}
                  onChange={(e) => handleInputChange('volume', parseInt(e.target.value))}
                  className="form-control"
                />
              </div>
              <div className="form-group">
                <label className="form-label">Font Size</label>
                <input
                  type="number"
                  min="8"
                  max="24"
                  value={formData.fontSize}
                  onChange={(e) => handleInputChange('fontSize', parseInt(e.target.value))}
                  className="form-control"
                />
              </div>
            </div>
          </div>
        );

      case 3:
        return (
          <div>
            <h3>Account Settings</h3>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Username *</label>
                <input
                  type="text"
                  className="form-control"
                  value={formData.username}
                  onChange={(e) => handleInputChange('username', e.target.value)}
                />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Password *</label>
                <input
                  type="password"
                  className="form-control"
                  value={formData.password}
                  onChange={(e) => handleInputChange('password', e.target.value)}
                />
              </div>
              <div className="form-group">
                <label className="form-label">Confirm Password *</label>
                <input
                  type="password"
                  className="form-control"
                  value={formData.confirmPassword}
                  onChange={(e) => handleInputChange('confirmPassword', e.target.value)}
                />
              </div>
            </div>
            <div className="form-group">
              <label>
                <input
                  type="checkbox"
                  checked={formData.termsAccepted}
                  onChange={(e) => handleInputChange('termsAccepted', e.target.checked)}
                />
                I agree to the Terms of Service *
              </label>
            </div>
            <div className="form-group">
              <label>
                <input
                  type="checkbox"
                  checked={formData.privacyAccepted}
                  onChange={(e) => handleInputChange('privacyAccepted', e.target.checked)}
                />
                I agree to the Privacy Policy *
              </label>
            </div>
            <div className="form-group">
              <label>
                <input
                  type="checkbox"
                  checked={formData.newsletter}
                  onChange={(e) => handleInputChange('newsletter', e.target.checked)}
                />
                Subscribe to newsletter
              </label>
            </div>
          </div>
        );

      case 4:
        return (
          <div>
            <h3>Additional Information</h3>
            <div className="form-group">
              <label className="form-label">Biography</label>
              <textarea
                className="form-control"
                rows="4"
                value={formData.bio}
                onChange={(e) => handleInputChange('bio', e.target.value)}
                placeholder="Tell us about yourself..."
              />
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Industry</label>
                <select
                  className="form-control"
                  value={formData.industry}
                  onChange={(e) => handleInputChange('industry', e.target.value)}
                >
                  <option value="">Select Industry</option>
                  <option value="technology">Technology</option>
                  <option value="healthcare">Healthcare</option>
                  <option value="finance">Finance</option>
                  <option value="education">Education</option>
                  <option value="retail">Retail</option>
                  <option value="other">Other</option>
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Experience</label>
                <select
                  className="form-control"
                  value={formData.experience}
                  onChange={(e) => handleInputChange('experience', e.target.value)}
                >
                  <option value="">Select Experience</option>
                  <option value="0-1">0-1 years</option>
                  <option value="1-3">1-3 years</option>
                  <option value="3-5">3-5 years</option>
                  <option value="5-10">5-10 years</option>
                  <option value="10+">10+ years</option>
                </select>
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Website</label>
                <input
                  type="url"
                  className="form-control"
                  value={formData.website}
                  onChange={(e) => handleInputChange('website', e.target.value)}
                  placeholder="https://example.com"
                />
              </div>
              <div className="form-group">
                <label className="form-label">Birth Date</label>
                <input
                  type="date"
                  className="form-control"
                  value={formData.birthDate}
                  onChange={(e) => handleInputChange('birthDate', e.target.value)}
                />
              </div>
            </div>
          </div>
        );

      case 5:
        return (
          <div>
            <h3>Review and Confirm</h3>
            <p>Please review your information before proceeding:</p>
            <div className="card">
              <h4>Personal Information</h4>
              <p><strong>Name:</strong> {formData.firstName} {formData.lastName}</p>
              <p><strong>Email:</strong> {formData.email}</p>
              <p><strong>Phone:</strong> {formData.phone || 'Not provided'}</p>
              <p><strong>Country:</strong> {formData.country || 'Not selected'}</p>
              <p><strong>Language:</strong> {formData.language || 'Not selected'}</p>
            </div>
            <div className="card">
              <h4>Preferences</h4>
              <p><strong>Theme:</strong> {formData.theme}</p>
              <p><strong>Email Notifications:</strong> {formData.emailNotifications ? 'Yes' : 'No'}</p>
              <p><strong>SMS Notifications:</strong> {formData.smsNotifications ? 'Yes' : 'No'}</p>
              <p><strong>Push Notifications:</strong> {formData.pushNotifications ? 'Yes' : 'No'}</p>
              <p><strong>Volume:</strong> {formData.volume}%</p>
              <p><strong>Font Size:</strong> {formData.fontSize}px</p>
            </div>
            <div className="card">
              <h4>Account Settings</h4>
              <p><strong>Username:</strong> {formData.username}</p>
              <p><strong>Terms Accepted:</strong> {formData.termsAccepted ? 'Yes' : 'No'}</p>
              <p><strong>Privacy Accepted:</strong> {formData.privacyAccepted ? 'Yes' : 'No'}</p>
              <p><strong>Newsletter:</strong> {formData.newsletter ? 'Yes' : 'No'}</p>
            </div>
            <div className="card">
              <h4>Additional Information</h4>
              <p><strong>Biography:</strong> {formData.bio || 'Not provided'}</p>
              <p><strong>Industry:</strong> {formData.industry || 'Not selected'}</p>
              <p><strong>Experience:</strong> {formData.experience || 'Not selected'}</p>
              <p><strong>Website:</strong> {formData.website || 'Not provided'}</p>
              <p><strong>Birth Date:</strong> {formData.birthDate || 'Not provided'}</p>
            </div>
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Multi-Step Wizard</h1>
        <p className="page-subtitle">
          Multi-step form wizard with validation
        </p>
      </div>

      <div className="card">
        <div className="wizard-steps">
          {steps.map(step => (
            <div
              key={step.number}
              className={`wizard-step ${
                currentStep === step.number ? 'active' : 
                currentStep > step.number ? 'completed' : ''
              }`}
            >
              <span className="wizard-step-number">{step.number}</span>
              {step.title}
            </div>
          ))}
        </div>

        <div style={{ marginBottom: '2rem' }}>
          <h2>{steps[currentStep - 1].title}</h2>
          <p>{steps[currentStep - 1].description}</p>
        </div>

        {renderStepContent()}

        <div className="form-actions">
          <button
            className="btn btn-secondary"
            onClick={prevStep}
            disabled={currentStep === 1}
          >
            Previous
          </button>
          {currentStep < totalSteps ? (
            <button className="btn" onClick={nextStep}>
              Next
            </button>
          ) : (
            <button className="btn" onClick={finishWizard}>
              Finish
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default Wizard;

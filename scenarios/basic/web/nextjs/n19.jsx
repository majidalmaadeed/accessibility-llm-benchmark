import { useState } from 'react';

export default function UngroupedRadioButtons() {
  const [formData, setFormData] = useState({
    contactMethod: '',
    notificationFrequency: '',
    preferredLanguage: '',
    accountType: '',
    subscriptionPlan: '',
    marketingConsent: '',
    dataProcessing: '',
    communicationChannel: '',
    reportFormat: '',
    timezone: ''
  });

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitMessage, setSubmitMessage] = useState('');

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      setSubmitMessage('Preferences saved successfully!');
      setTimeout(() => setSubmitMessage(''), 3000);
    } catch (error) {
      setSubmitMessage('Error saving preferences. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleReset = () => {
    setFormData({
      contactMethod: '',
      notificationFrequency: '',
      preferredLanguage: '',
      accountType: '',
      subscriptionPlan: '',
      marketingConsent: '',
      dataProcessing: '',
      communicationChannel: '',
      reportFormat: '',
      timezone: ''
    });
    setSubmitMessage('');
  };

  return (
    <div className="preferences-form">
      <div className="form-container">
        <header className="form-header">
          <h1>User Preferences</h1>
          <p>Customize your account settings and preferences</p>
        </header>

        <form onSubmit={handleSubmit} className="preferences-form-content">
          <div className="form-section">
            <h3>Contact Preferences</h3>
            <p>How would you like us to contact you?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="contactMethod"
                  value="email"
                  checked={formData.contactMethod === 'email'}
                  onChange={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span className="radio-label">Email</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="contactMethod"
                  value="phone"
                  checked={formData.contactMethod === 'phone'}
                  onChange={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span className="radio-label">Phone</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="contactMethod"
                  value="sms"
                  checked={formData.contactMethod === 'sms'}
                  onChange={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span className="radio-label">SMS</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="contactMethod"
                  value="none"
                  checked={formData.contactMethod === 'none'}
                  onChange={(e) => handleInputChange('contactMethod', e.target.value)}
                />
                <span className="radio-label">No contact</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Notification Settings</h3>
            <p>How often would you like to receive notifications?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="notificationFrequency"
                  value="immediate"
                  checked={formData.notificationFrequency === 'immediate'}
                  onChange={(e) => handleInputChange('notificationFrequency', e.target.value)}
                />
                <span className="radio-label">Immediately</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="notificationFrequency"
                  value="daily"
                  checked={formData.notificationFrequency === 'daily'}
                  onChange={(e) => handleInputChange('notificationFrequency', e.target.value)}
                />
                <span className="radio-label">Daily digest</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="notificationFrequency"
                  value="weekly"
                  checked={formData.notificationFrequency === 'weekly'}
                  onChange={(e) => handleInputChange('notificationFrequency', e.target.value)}
                />
                <span className="radio-label">Weekly summary</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="notificationFrequency"
                  value="never"
                  checked={formData.notificationFrequency === 'never'}
                  onChange={(e) => handleInputChange('notificationFrequency', e.target.value)}
                />
                <span className="radio-label">Never</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Language Preferences</h3>
            <p>Select your preferred language for the interface</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="preferredLanguage"
                  value="en"
                  checked={formData.preferredLanguage === 'en'}
                  onChange={(e) => handleInputChange('preferredLanguage', e.target.value)}
                />
                <span className="radio-label">English</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="preferredLanguage"
                  value="es"
                  checked={formData.preferredLanguage === 'es'}
                  onChange={(e) => handleInputChange('preferredLanguage', e.target.value)}
                />
                <span className="radio-label">Spanish</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="preferredLanguage"
                  value="fr"
                  checked={formData.preferredLanguage === 'fr'}
                  onChange={(e) => handleInputChange('preferredLanguage', e.target.value)}
                />
                <span className="radio-label">French</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="preferredLanguage"
                  value="de"
                  checked={formData.preferredLanguage === 'de'}
                  onChange={(e) => handleInputChange('preferredLanguage', e.target.value)}
                />
                <span className="radio-label">German</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Account Type</h3>
            <p>What type of account do you have?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="accountType"
                  value="personal"
                  checked={formData.accountType === 'personal'}
                  onChange={(e) => handleInputChange('accountType', e.target.value)}
                />
                <span className="radio-label">Personal</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="accountType"
                  value="business"
                  checked={formData.accountType === 'business'}
                  onChange={(e) => handleInputChange('accountType', e.target.value)}
                />
                <span className="radio-label">Business</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="accountType"
                  value="enterprise"
                  checked={formData.accountType === 'enterprise'}
                  onChange={(e) => handleInputChange('accountType', e.target.value)}
                />
                <span className="radio-label">Enterprise</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Subscription Plan</h3>
            <p>Choose your subscription plan</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="subscriptionPlan"
                  value="free"
                  checked={formData.subscriptionPlan === 'free'}
                  onChange={(e) => handleInputChange('subscriptionPlan', e.target.value)}
                />
                <span className="radio-label">Free Plan</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="subscriptionPlan"
                  value="basic"
                  checked={formData.subscriptionPlan === 'basic'}
                  onChange={(e) => handleInputChange('subscriptionPlan', e.target.value)}
                />
                <span className="radio-label">Basic Plan ($9.99/month)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="subscriptionPlan"
                  value="premium"
                  checked={formData.subscriptionPlan === 'premium'}
                  onChange={(e) => handleInputChange('subscriptionPlan', e.target.value)}
                />
                <span className="radio-label">Premium Plan ($19.99/month)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="subscriptionPlan"
                  value="pro"
                  checked={formData.subscriptionPlan === 'pro'}
                  onChange={(e) => handleInputChange('subscriptionPlan', e.target.value)}
                />
                <span className="radio-label">Pro Plan ($39.99/month)</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Marketing Consent</h3>
            <p>Would you like to receive marketing communications?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="marketingConsent"
                  value="yes"
                  checked={formData.marketingConsent === 'yes'}
                  onChange={(e) => handleInputChange('marketingConsent', e.target.value)}
                />
                <span className="radio-label">Yes, send me marketing emails</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="marketingConsent"
                  value="no"
                  checked={formData.marketingConsent === 'no'}
                  onChange={(e) => handleInputChange('marketingConsent', e.target.value)}
                />
                <span className="radio-label">No, don't send marketing emails</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Data Processing</h3>
            <p>How should we process your data?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="dataProcessing"
                  value="minimal"
                  checked={formData.dataProcessing === 'minimal'}
                  onChange={(e) => handleInputChange('dataProcessing', e.target.value)}
                />
                <span className="radio-label">Minimal processing only</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="dataProcessing"
                  value="standard"
                  checked={formData.dataProcessing === 'standard'}
                  onChange={(e) => handleInputChange('dataProcessing', e.target.value)}
                />
                <span className="radio-label">Standard processing</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="dataProcessing"
                  value="full"
                  checked={formData.dataProcessing === 'full'}
                  onChange={(e) => handleInputChange('dataProcessing', e.target.value)}
                />
                <span className="radio-label">Full processing for personalization</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Communication Channel</h3>
            <p>Preferred method for important updates</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="communicationChannel"
                  value="email"
                  checked={formData.communicationChannel === 'email'}
                  onChange={(e) => handleInputChange('communicationChannel', e.target.value)}
                />
                <span className="radio-label">Email</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="communicationChannel"
                  value="in-app"
                  checked={formData.communicationChannel === 'in-app'}
                  onChange={(e) => handleInputChange('communicationChannel', e.target.value)}
                />
                <span className="radio-label">In-app notifications</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="communicationChannel"
                  value="both"
                  checked={formData.communicationChannel === 'both'}
                  onChange={(e) => handleInputChange('communicationChannel', e.target.value)}
                />
                <span className="radio-label">Both email and in-app</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Report Format</h3>
            <p>How would you like to receive reports?</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="reportFormat"
                  value="pdf"
                  checked={formData.reportFormat === 'pdf'}
                  onChange={(e) => handleInputChange('reportFormat', e.target.value)}
                />
                <span className="radio-label">PDF format</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="reportFormat"
                  value="excel"
                  checked={formData.reportFormat === 'excel'}
                  onChange={(e) => handleInputChange('reportFormat', e.target.value)}
                />
                <span className="radio-label">Excel format</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="reportFormat"
                  value="csv"
                  checked={formData.reportFormat === 'csv'}
                  onChange={(e) => handleInputChange('reportFormat', e.target.value)}
                />
                <span className="radio-label">CSV format</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="reportFormat"
                  value="web"
                  checked={formData.reportFormat === 'web'}
                  onChange={(e) => handleInputChange('reportFormat', e.target.value)}
                />
                <span className="radio-label">Web dashboard only</span>
              </label>
            </div>
          </div>

          <div className="form-section">
            <h3>Timezone</h3>
            <p>Select your timezone for accurate scheduling</p>
            
            <div className="radio-group">
              <label className="radio-option">
                <input
                  type="radio"
                  name="timezone"
                  value="est"
                  checked={formData.timezone === 'est'}
                  onChange={(e) => handleInputChange('timezone', e.target.value)}
                />
                <span className="radio-label">Eastern Time (EST/EDT)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="timezone"
                  value="cst"
                  checked={formData.timezone === 'cst'}
                  onChange={(e) => handleInputChange('timezone', e.target.value)}
                />
                <span className="radio-label">Central Time (CST/CDT)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="timezone"
                  value="mst"
                  checked={formData.timezone === 'mst'}
                  onChange={(e) => handleInputChange('timezone', e.target.value)}
                />
                <span className="radio-label">Mountain Time (MST/MDT)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="timezone"
                  value="pst"
                  checked={formData.timezone === 'pst'}
                  onChange={(e) => handleInputChange('timezone', e.target.value)}
                />
                <span className="radio-label">Pacific Time (PST/PDT)</span>
              </label>

              <label className="radio-option">
                <input
                  type="radio"
                  name="timezone"
                  value="utc"
                  checked={formData.timezone === 'utc'}
                  onChange={(e) => handleInputChange('timezone', e.target.value)}
                />
                <span className="radio-label">UTC (Coordinated Universal Time)</span>
              </label>
            </div>
          </div>

          <div className="form-actions">
            <button 
              type="button" 
              className="btn btn-secondary" 
              onClick={handleReset}
            >
              Reset Form
            </button>
            
            <button 
              type="submit" 
              className="btn btn-primary" 
              disabled={isSubmitting}
            >
              {isSubmitting ? 'Saving...' : 'Save Preferences'}
            </button>
          </div>

          {submitMessage && (
            <div className={`submit-message ${submitMessage.includes('Error') ? 'error' : 'success'}`}>
              {submitMessage}
            </div>
          )}
        </form>
      </div>

      <style jsx>{`
        .preferences-form {
          min-height: 100vh;
          background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
          padding: 40px 20px;
        }

        .form-container {
          max-width: 800px;
          margin: 0 auto;
          background: white;
          border-radius: 12px;
          box-shadow: 0 10px 30px rgba(0,0,0,0.1);
          overflow: hidden;
        }

        .form-header {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          padding: 40px;
          text-align: center;
        }

        .form-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          font-weight: bold;
        }

        .form-header p {
          margin: 0;
          font-size: 16px;
          opacity: 0.9;
        }

        .preferences-form-content {
          padding: 40px;
        }

        .form-section {
          margin-bottom: 40px;
          padding-bottom: 30px;
          border-bottom: 1px solid #e9ecef;
        }

        .form-section:last-of-type {
          border-bottom: none;
          margin-bottom: 30px;
        }

        .form-section h3 {
          margin: 0 0 10px 0;
          font-size: 20px;
          color: #333;
          font-weight: bold;
        }

        .form-section p {
          margin: 0 0 20px 0;
          color: #666;
          font-size: 14px;
        }

        .radio-group {
          display: flex;
          flex-direction: column;
          gap: 12px;
        }

        .radio-option {
          display: flex;
          align-items: center;
          cursor: pointer;
          padding: 12px 16px;
          border: 2px solid #e9ecef;
          border-radius: 8px;
          transition: all 0.2s ease;
          background: #f8f9fa;
        }

        .radio-option:hover {
          border-color: #007bff;
          background: #e3f2fd;
        }

        .radio-option input[type="radio"] {
          margin: 0 12px 0 0;
          width: 18px;
          height: 18px;
          accent-color: #007bff;
        }

        .radio-option input[type="radio"]:checked + .radio-label {
          color: #007bff;
          font-weight: bold;
        }

        .radio-option:has(input[type="radio"]:checked) {
          border-color: #007bff;
          background: #e3f2fd;
        }

        .radio-label {
          font-size: 14px;
          color: #333;
          transition: color 0.2s ease;
        }

        .form-actions {
          display: flex;
          gap: 20px;
          justify-content: flex-end;
          margin-top: 40px;
          padding-top: 30px;
          border-top: 1px solid #e9ecef;
        }

        .btn {
          padding: 12px 24px;
          border: none;
          border-radius: 6px;
          font-size: 14px;
          font-weight: bold;
          cursor: pointer;
          transition: all 0.2s ease;
          min-width: 120px;
        }

        .btn-primary {
          background: #007bff;
          color: white;
        }

        .btn-primary:hover:not(:disabled) {
          background: #0056b3;
          transform: translateY(-1px);
        }

        .btn-primary:disabled {
          background: #6c757d;
          cursor: not-allowed;
          transform: none;
        }

        .btn-secondary {
          background: #6c757d;
          color: white;
        }

        .btn-secondary:hover {
          background: #545b62;
          transform: translateY(-1px);
        }

        .submit-message {
          margin-top: 20px;
          padding: 12px 16px;
          border-radius: 6px;
          font-weight: bold;
          text-align: center;
        }

        .submit-message.success {
          background: #d4edda;
          color: #155724;
          border: 1px solid #c3e6cb;
        }

        .submit-message.error {
          background: #f8d7da;
          color: #721c24;
          border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
          .preferences-form {
            padding: 20px 10px;
          }

          .form-header {
            padding: 30px 20px;
          }

          .form-header h1 {
            font-size: 24px;
          }

          .preferences-form-content {
            padding: 30px 20px;
          }

          .form-actions {
            flex-direction: column;
          }

          .btn {
            width: 100%;
          }
        }
      `}</style>
    </div>
  );
}

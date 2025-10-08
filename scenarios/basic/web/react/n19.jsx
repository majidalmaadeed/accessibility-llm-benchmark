import React, { useState } from 'react';

const UngroupedRadioButtons = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    contactPreference: '',
    newsletter: false,
    notifications: false
  });

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Form submitted successfully!');
  };

  return (
    <div style={{ 
      maxWidth: '600px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Contact Information Form</h1>
      <p>Please provide your contact details and preferences.</p>
      
      <form onSubmit={handleSubmit} style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
        border: '1px solid #e0e0e0'
      }}>
        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Full Name *
          </label>
          <input
            type="text"
            name="name"
            value={formData.name}
            onChange={handleInputChange}
            required
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
          />
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Email Address *
          </label>
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleInputChange}
            required
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
          />
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Phone Number
          </label>
          <input
            type="tel"
            name="phone"
            value={formData.phone}
            onChange={handleInputChange}
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
          />
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '10px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Preferred Contact Method
          </label>
          
          {/* Contact preference radio buttons without fieldset grouping */}
          <div style={{ marginBottom: '10px' }}>
            <input
              type="radio"
              id="email-contact"
              name="contactPreference"
              value="email"
              checked={formData.contactPreference === 'email'}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="email-contact" style={{ cursor: 'pointer' }}>
              Email
            </label>
          </div>
          
          <div style={{ marginBottom: '10px' }}>
            <input
              type="radio"
              id="phone-contact"
              name="contactPreference"
              value="phone"
              checked={formData.contactPreference === 'phone'}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="phone-contact" style={{ cursor: 'pointer' }}>
              Phone
            </label>
          </div>
          
          <div style={{ marginBottom: '10px' }}>
            <input
              type="radio"
              id="text-contact"
              name="contactPreference"
              value="text"
              checked={formData.contactPreference === 'text'}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="text-contact" style={{ cursor: 'pointer' }}>
              Text Message
            </label>
          </div>
          
          <div style={{ marginBottom: '10px' }}>
            <input
              type="radio"
              id="mail-contact"
              name="contactPreference"
              value="mail"
              checked={formData.contactPreference === 'mail'}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="mail-contact" style={{ cursor: 'pointer' }}>
              Postal Mail
            </label>
          </div>
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '10px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Communication Preferences
          </label>
          
          <div style={{ marginBottom: '10px' }}>
            <input
              type="checkbox"
              id="newsletter"
              name="newsletter"
              checked={formData.newsletter}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="newsletter" style={{ cursor: 'pointer' }}>
              Subscribe to our newsletter
            </label>
          </div>
          
          <div style={{ marginBottom: '10px' }}>
            <input
              type="checkbox"
              id="notifications"
              name="notifications"
              checked={formData.notifications}
              onChange={handleInputChange}
              style={{ marginRight: '8px' }}
            />
            <label htmlFor="notifications" style={{ cursor: 'pointer' }}>
              Receive promotional notifications
            </label>
          </div>
        </div>

        <div style={{
          display: 'flex',
          gap: '15px',
          justifyContent: 'flex-end'
        }}>
          <button
            type="button"
            style={{
              background: '#6c757d',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '16px'
            }}
          >
            Cancel
          </button>
          <button
            type="submit"
            style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '16px'
            }}
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  );
};

export default UngroupedRadioButtons;

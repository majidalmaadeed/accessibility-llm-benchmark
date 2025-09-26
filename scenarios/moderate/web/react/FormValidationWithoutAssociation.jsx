import React, { useState } from 'react';

const FormValidationWithoutAssociation = () => {
  const [formData, setFormData] = useState({
    username: '',
    password: ''
  });
  const [errors, setErrors] = useState({});
  const [showError, setShowError] = useState(false);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
    
    // Clear error when user starts typing
    if (showError) {
      setShowError(false);
      setErrors({});
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    const newErrors = {};
    
    if (!formData.username.trim()) {
      newErrors.username = 'Username is required';
    }
    
    if (!formData.password.trim()) {
      newErrors.password = 'Password is required';
    }
    
    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      setShowError(true);
    } else {
      alert('Form submitted successfully!');
      setFormData({ username: '', password: '' });
      setErrors({});
      setShowError(false);
    }
  };

  return (
    <div style={{ maxWidth: '600px', margin: '50px auto', padding: '20px' }}>
      <h1>Login Form</h1>
      <p>Please enter your credentials to access your account.</p>
      
      <form onSubmit={handleSubmit} style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)'
      }}>
        <div style={{ marginBottom: '20px' }}>
          <label htmlFor="username" style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Username:
          </label>
          <input
            type="text"
            id="username"
            name="username"
            value={formData.username}
            onChange={handleInputChange}
            style={{
              width: '100%',
              padding: '12px',
              border: errors.username ? '2px solid #dc3545' : '2px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
            // MISSING: aria-describedby, aria-invalid
          />
          {errors.username && (
            <div style={{
              color: '#dc3545',
              fontSize: '14px',
              marginTop: '5px',
              fontWeight: 'bold'
            }}>
              {errors.username}
            </div>
          )}
        </div>
        
        <div style={{ marginBottom: '20px' }}>
          <label htmlFor="password" style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Password:
          </label>
          <input
            type="password"
            id="password"
            name="password"
            value={formData.password}
            onChange={handleInputChange}
            style={{
              width: '100%',
              padding: '12px',
              border: errors.password ? '2px solid #dc3545' : '2px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
            // MISSING: aria-describedby, aria-invalid
          />
          {errors.password && (
            <div style={{
              color: '#dc3545',
              fontSize: '14px',
              marginTop: '5px',
              fontWeight: 'bold'
            }}>
              {errors.password}
            </div>
          )}
        </div>
        
        {/* GENERIC ERROR MESSAGE NOT ASSOCIATED WITH SPECIFIC FIELDS */}
        {showError && Object.keys(errors).length > 0 && (
          <div style={{
            color: '#dc3545',
            fontSize: '14px',
            marginBottom: '20px',
            fontWeight: 'bold'
            // MISSING: role="alert", aria-live
          }}>
            Please fill in all required fields.
          </div>
        )}
        
        <button
          type="submit"
          style={{
            backgroundColor: '#007bff',
            color: 'white',
            padding: '12px 30px',
            border: 'none',
            borderRadius: '4px',
            fontSize: '16px',
            cursor: 'pointer',
            width: '100%'
          }}
        >
          Login
        </button>
      </form>

      <div style={{
        marginTop: '30px',
        padding: '20px',
        backgroundColor: '#e9ecef',
        borderRadius: '4px'
      }}>
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Missing aria-describedby:</strong> Error messages are not linked to input fields</li>
          <li><strong>No aria-invalid:</strong> Input fields don't indicate validation state</li>
          <li><strong>Generic error:</strong> Generic error message doesn't specify which fields have issues</li>
          <li><strong>No live region:</strong> Screen readers won't announce errors when they appear</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>aria-describedby="error-{fieldName}"</code> to input fields</li>
          <li>Add <code>aria-invalid={!!errors.fieldName}</code> to indicate validation state</li>
          <li>Use specific error messages for each field</li>
          <li>Add <code>role="alert"</code> or <code>aria-live="polite"</code> to error messages</li>
        </ul>
      </div>
    </div>
  );
};

export default FormValidationWithoutAssociation;
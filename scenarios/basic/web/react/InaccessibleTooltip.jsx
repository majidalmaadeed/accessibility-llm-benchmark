import React, { useState } from 'react';

const InaccessibleTooltip = () => {
  const [hoveredField, setHoveredField] = useState(null);

  const tooltips = {
    username: 'Enter your username or email address',
    password: 'Password must be at least 8 characters long',
    confirmPassword: 'Re-enter your password to confirm',
    email: 'We will send a verification email to this address',
    phone: 'Include country code (e.g., +1 for US)',
    terms: 'You must agree to our terms and conditions',
    privacy: 'Read our privacy policy to understand how we use your data'
  };

  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: '',
    confirmPassword: '',
    phone: ''
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
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
      <h1>User Registration</h1>
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
            Username *
          </label>
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="text"
              name="username"
              value={formData.username}
              onChange={handleInputChange}
              required
              onMouseEnter={() => setHoveredField('username')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                width: '300px',
                padding: '12px 40px 12px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <span
              onMouseEnter={() => setHoveredField('username')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                color: '#666',
                cursor: 'help'
              }}
            >
              ?
            </span>
            {/* Help icon shows tooltip on hover only, not keyboard accessible */}
            {hoveredField === 'username' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.username}
              </div>
            )}
          </div>
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
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              required
              onMouseEnter={() => setHoveredField('email')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                width: '300px',
                padding: '12px 40px 12px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <span
              onMouseEnter={() => setHoveredField('email')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                color: '#666',
                cursor: 'help'
              }}
            >
              ?
            </span>
            {hoveredField === 'email' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.email}
              </div>
            )}
          </div>
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Password *
          </label>
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="password"
              name="password"
              value={formData.password}
              onChange={handleInputChange}
              required
              onMouseEnter={() => setHoveredField('password')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                width: '300px',
                padding: '12px 40px 12px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <span
              onMouseEnter={() => setHoveredField('password')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                color: '#666',
                cursor: 'help'
              }}
            >
              ?
            </span>
            {hoveredField === 'password' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.password}
              </div>
            )}
          </div>
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Confirm Password *
          </label>
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="password"
              name="confirmPassword"
              value={formData.confirmPassword}
              onChange={handleInputChange}
              required
              onMouseEnter={() => setHoveredField('confirmPassword')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                width: '300px',
                padding: '12px 40px 12px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <span
              onMouseEnter={() => setHoveredField('confirmPassword')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                color: '#666',
                cursor: 'help'
              }}
            >
              ?
            </span>
            {hoveredField === 'confirmPassword' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.confirmPassword}
              </div>
            )}
          </div>
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
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="tel"
              name="phone"
              value={formData.phone}
              onChange={handleInputChange}
              onMouseEnter={() => setHoveredField('phone')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                width: '300px',
                padding: '12px 40px 12px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box'
              }}
            />
            <span
              onMouseEnter={() => setHoveredField('phone')}
              onMouseLeave={() => setHoveredField(null)}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                color: '#666',
                cursor: 'help'
              }}
            >
              ?
            </span>
            {hoveredField === 'phone' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.phone}
              </div>
            )}
          </div>
        </div>

        <div style={{ marginBottom: '25px' }}>
          <div style={{ marginBottom: '15px' }}>
            <input
              type="checkbox"
              id="terms"
              required
              style={{ marginRight: '10px' }}
            />
            <label htmlFor="terms" style={{ 
              cursor: 'pointer',
              fontSize: '14px'
            }}>
              I agree to the 
              <span
                onMouseEnter={() => setHoveredField('terms')}
                onMouseLeave={() => setHoveredField(null)}
                style={{
                  color: '#007bff',
                  textDecoration: 'underline',
                  margin: '0 5px',
                  cursor: 'help'
                }}
              >
                Terms and Conditions
              </span>
              and
              <span
                onMouseEnter={() => setHoveredField('privacy')}
                onMouseLeave={() => setHoveredField(null)}
                style={{
                  color: '#007bff',
                  textDecoration: 'underline',
                  margin: '0 5px',
                  cursor: 'help'
                }}
              >
                Privacy Policy
              </span>
            </label>
            {hoveredField === 'terms' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.terms}
              </div>
            )}
            {hoveredField === 'privacy' && (
              <div style={{
                position: 'absolute',
                top: '-40px',
                left: '0',
                background: '#333',
                color: 'white',
                padding: '8px 12px',
                borderRadius: '4px',
                fontSize: '12px',
                whiteSpace: 'nowrap',
                zIndex: 1000
              }}>
                {tooltips.privacy}
              </div>
            )}
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
            Create Account
          </button>
        </div>
      </form>
    </div>
  );
};

export default InaccessibleTooltip;

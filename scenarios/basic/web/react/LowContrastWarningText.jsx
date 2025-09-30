import React, { useState, useEffect } from 'react';

const LowContrastWarningText = () => {
  const [showWarning, setShowWarning] = useState(false);

  useEffect(() => {
    // Show warning after 5 seconds for demo
    const timer = setTimeout(() => {
      setShowWarning(true);
    }, 5000);

    return () => clearTimeout(timer);
  }, []);

  return (
    <div style={{ 
      maxWidth: '600px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>User Dashboard</h1>
      <p>Welcome to your account dashboard.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '20px'
      }}>
        <h2>Account Information</h2>
        <p><strong>Username:</strong> john.doe@example.com</p>
        <p><strong>Last Login:</strong> Today at 2:30 PM</p>
        <p><strong>Status:</strong> Active</p>
      </div>

      {/* Session timeout warning with insufficient color contrast */}
      {showWarning && (
        <div style={{
          background: '#f8f9fa',
          color: '#6c757d',
          padding: '15px',
          borderRadius: '4px',
          border: '1px solid #dee2e6',
          marginBottom: '20px',
          fontSize: '14px'
        }}>
          <strong>Session Timeout Warning:</strong> Your session will expire in 2 minutes due to inactivity. 
          Please save your work and refresh the page to continue.
        </div>
      )}

      <div style={{
        background: '#e3f2fd',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '20px'
      }}>
        <h2>Recent Activity</h2>
        <ul style={{ margin: 0, paddingLeft: '20px' }}>
          <li>Updated profile information</li>
          <li>Changed password</li>
          <li>Downloaded monthly report</li>
        </ul>
      </div>

      <div style={{
        display: 'flex',
        gap: '10px',
        justifyContent: 'center'
      }}>
        <button style={{
          background: '#007bff',
          color: 'white',
          border: 'none',
          padding: '10px 20px',
          borderRadius: '4px',
          cursor: 'pointer'
        }}>
          View Profile
        </button>
        <button style={{
          background: '#6c757d',
          color: 'white',
          border: 'none',
          padding: '10px 20px',
          borderRadius: '4px',
          cursor: 'pointer'
        }}>
          Settings
        </button>
      </div>
    </div>
  );
};

export default LowContrastWarningText;

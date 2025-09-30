import React, { useState, useEffect } from 'react';
const ToastNotificationIssues = () => {
  const [toasts, setToasts] = useState([]);
  const [nextId, setNextId] = useState(1);
  const addToast = (type, message, duration = 5000) => {
    const id = nextId;
    const newToast = {
      id,
      type,
      message,
      duration,
      timestamp: new Date()
    };
    setToasts(prev => [...prev, newToast]);
    setNextId(prev => prev + 1);
    // Auto-dismiss after duration
    setTimeout(() => {
      removeToast(id);
    }, duration);
  };
  const removeToast = (id) => {
    setToasts(prev => prev.filter(toast => toast.id !== id));
  };
  const handleSuccess = () => {
    addToast('success', 'Your changes have been saved successfully!');
  };
  const handleError = () => {
    addToast('error', 'An error occurred while processing your request.');
  };
  const handleWarning = () => {
    addToast('warning', 'Please review your input before continuing.');
  };
  const handleInfo = () => {
    addToast('info', 'New features are now available in your dashboard.');
  };
  const handleKeyDown = (e, toastId) => {
    if (e.key === 'Escape') {
      removeToast(toastId);
    }
  };
  const getToastStyles = (type) => {
    const baseStyles = {
      padding: '16px 20px',
      borderRadius: '8px',
      marginBottom: '12px',
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center',
      boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
      border: '1px solid',
      fontSize: '14px',
      fontWeight: '500',
      maxWidth: '400px',
      animation: 'slideIn 0.3s ease-out'
    };
    const typeStyles = {
      success: {
        background: '#d4edda',
        borderColor: '#c3e6cb',
        color: '#155724'
      },
      error: {
        background: '#f8d7da',
        borderColor: '#f5c6cb',
        color: '#721c24'
      },
      warning: {
        background: '#fff3cd',
        borderColor: '#ffeaa7',
        color: '#856404'
      },
      info: {
        background: '#d1ecf1',
        borderColor: '#bee5eb',
        color: '#0c5460'
      }
    };
    return { ...baseStyles, ...typeStyles[type] };
  };
  const getIcon = (type) => {
    const icons = {
      success: '✓',
      error: '✕',
      warning: '⚠',
      info: 'ℹ'
    };
    return icons[type] || 'ℹ';
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Toast Notifications</h1>
        <p>View notifications and alerts using the system below.</p>
        {/* Action Buttons */}
        <div style={{ marginBottom: '30px' }}>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>Trigger Notifications</h2>
          <div style={{ display: 'flex', gap: '12px', flexWrap: 'wrap' }}>
            <button
              onClick={handleSuccess}
              style={{
                background: '#28a745',
                color: 'white',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '14px'
              }}
            >
              Show Success Toast
            </button>
            <button
              onClick={handleError}
              style={{
                background: '#dc3545',
                color: 'white',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '14px'
              }}
            >
              Show Error Toast
            </button>
            <button
              onClick={handleWarning}
              style={{
                background: '#ffc107',
                color: '#212529',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '14px'
              }}
            >
              Show Warning Toast
            </button>
            <button
              onClick={handleInfo}
              style={{
                background: '#17a2b8',
                color: 'white',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '14px'
              }}
            >
              Show Info Toast
            </button>
          </div>
        </div>
        {/* Toast Container */}
        <div style={{ marginBottom: '30px' }}>
          <h3 style={{ marginBottom: '15px', color: '#333' }}>Active Notifications</h3>
          {toasts.length === 0 ? (
            <p style={{ color: '#666', fontStyle: 'italic' }}>No active notifications</p>
          ) : (
            <div style={{ fontSize: '12px', color: '#666', marginBottom: '10px' }}>
              {toasts.length} notification{toasts.length !== 1 ? 's' : ''} active
            </div>
          )}
        </div>
        {}
        <div
          style={{
            position: 'fixed',
            top: '20px',
            right: '20px',
            zIndex: 1000,
            maxHeight: '80vh',
            overflowY: 'auto'
          }}
        >
          {toasts.map((toast) => (
            <div
              key={toast.id}
              style={getToastStyles(toast.type)}
              onKeyDown={(e) => handleKeyDown(e, toast.id)}
            >
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                <span
                  style={{
                    fontSize: '18px',
                    fontWeight: 'bold'
                  }}
                >
                  {getIcon(toast.type)}
                </span>
                <span>{toast.message}</span>
              </div>
              <button
                onClick={() => removeToast(toast.id)}
                style={{
                  background: 'none',
                  border: 'none',
                  fontSize: '18px',
                  cursor: 'pointer',
                  padding: '0',
                  marginLeft: '12px',
                  color: 'inherit',
                  opacity: '0.7'
                }}
              >
                ×
              </button>
            </div>
          ))}
        </div>
        {/* Instructions */}
        <div style={{ 
          marginTop: '30px', 
          padding: '20px', 
          background: '#f8f9fa', 
          borderRadius: '4px',
          fontSize: '14px',
          color: '#666'
        }}>
          <h4 style={{ margin: '0 0 10px 0', color: '#333' }}>Instructions:</h4>
          <ul style={{ margin: '0', paddingLeft: '20px' }}>
            <li>Click any button above to trigger a notification</li>
            <li>Notifications auto-dismiss after 5 seconds</li>
            <li>Click the × button to dismiss manually</li>
          </ul>
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
      <style>
        {`
          @keyframes slideIn {
            from {
              transform: translateX(100%);
              opacity: 0;
            }
            to {
              transform: translateX(0);
              opacity: 1;
            }
          }
        `}
      </style>
    </div>
  );
};
export default ToastNotificationIssues;
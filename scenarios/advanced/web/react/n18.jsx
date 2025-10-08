import React, { useState, useEffect } from 'react';

const ToastNotificationIssues = () => {
  const [notifications, setNotifications] = useState([]);
  const [notificationId, setNotificationId] = useState(1);

  const addNotification = (type, message, duration = 5000) => {
    const id = notificationId;
    const newNotification = {
      id,
      type,
      message,
      duration,
      timestamp: new Date()
    };

    setNotifications(prev => [...prev, newNotification]);
    setNotificationId(prev => prev + 1);

    // Auto-remove notification after duration
    setTimeout(() => {
      removeNotification(id);
    }, duration);
  };

  const removeNotification = (id) => {
    setNotifications(prev => prev.filter(notification => notification.id !== id));
  };

  const handleSuccessAction = () => {
    addNotification('success', 'Operation completed successfully!');
  };

  const handleErrorAction = () => {
    addNotification('error', 'Something went wrong. Please try again.');
  };

  const handleWarningAction = () => {
    addNotification('warning', 'Please review your input before proceeding.');
  };

  const handleInfoAction = () => {
    addNotification('info', 'New features are now available in your dashboard.');
  };

  const handleLongMessage = () => {
    addNotification('info', 'This is a very long notification message that contains multiple sentences and provides detailed information about what happened. It should be properly formatted and readable even when it spans multiple lines.');
  };

  const handleMultipleNotifications = () => {
    addNotification('success', 'First notification');
    setTimeout(() => addNotification('info', 'Second notification'), 200);
    setTimeout(() => addNotification('warning', 'Third notification'), 400);
  };

  const getNotificationStyle = (type) => {
    const baseStyle = {
      padding: '16px 20px',
      borderRadius: '8px',
      marginBottom: '10px',
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'flex-start',
      boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
      maxWidth: '400px',
      wordWrap: 'break-word'
    };

    switch (type) {
      case 'success':
        return {
          ...baseStyle,
          backgroundColor: '#d4edda',
          border: '1px solid #c3e6cb',
          color: '#155724'
        };
      case 'error':
        return {
          ...baseStyle,
          backgroundColor: '#f8d7da',
          border: '1px solid #f5c6cb',
          color: '#721c24'
        };
      case 'warning':
        return {
          ...baseStyle,
          backgroundColor: '#fff3cd',
          border: '1px solid #ffeaa7',
          color: '#856404'
        };
      case 'info':
        return {
          ...baseStyle,
          backgroundColor: '#d1ecf1',
          border: '1px solid #bee5eb',
          color: '#0c5460'
        };
      default:
        return baseStyle;
    }
  };

  const getNotificationIcon = (type) => {
    switch (type) {
      case 'success':
        return '✅';
      case 'error':
        return '❌';
      case 'warning':
        return '⚠️';
      case 'info':
        return 'ℹ️';
      default:
        return '📢';
    }
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '1000px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Notification System Demo</h1>
        <p>Test different types of notifications and see how they behave.</p>
        
        <div style={{ marginTop: '30px' }}>
          <h3>Trigger Notifications</h3>
          <div style={{ display: 'flex', gap: '10px', flexWrap: 'wrap', marginBottom: '30px' }}>
            <button
              onClick={handleSuccessAction}
              style={{
                backgroundColor: '#28a745',
                color: 'white',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Success Notification
            </button>
            
            <button
              onClick={handleErrorAction}
              style={{
                backgroundColor: '#dc3545',
                color: 'white',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Error Notification
            </button>
            
            <button
              onClick={handleWarningAction}
              style={{
                backgroundColor: '#ffc107',
                color: '#212529',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Warning Notification
            </button>
            
            <button
              onClick={handleInfoAction}
              style={{
                backgroundColor: '#17a2b8',
                color: 'white',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Info Notification
            </button>
            
            <button
              onClick={handleLongMessage}
              style={{
                backgroundColor: '#6c757d',
                color: 'white',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Long Message
            </button>
            
            <button
              onClick={handleMultipleNotifications}
              style={{
                backgroundColor: '#6f42c1',
                color: 'white',
                padding: '10px 20px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              Multiple Notifications
            </button>
          </div>

          {/* Notification Display Area */}
          <div style={{ marginTop: '20px' }}>
            <h3>Active Notifications ({notifications.length})</h3>
            {notifications.length === 0 ? (
              <p style={{ color: '#666', fontStyle: 'italic' }}>No active notifications</p>
            ) : (
              <div style={{ 
                position: 'fixed',
                top: '20px',
                right: '20px',
                zIndex: 1000,
                maxHeight: '80vh',
                overflowY: 'auto'
              }}>
                {notifications.map((notification) => (
                  <div
                    key={notification.id}
                    style={getNotificationStyle(notification.type)}
                  >
                    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '10px', flex: 1 }}>
                      <span style={{ fontSize: '16px', marginTop: '2px' }}>
                        {getNotificationIcon(notification.type)}
                      </span>
                      <div style={{ flex: 1 }}>
                        <div style={{ fontWeight: 'bold', marginBottom: '4px' }}>
                          {notification.type.charAt(0).toUpperCase() + notification.type.slice(1)}
                        </div>
                        <div style={{ fontSize: '14px', lineHeight: '1.4' }}>
                          {notification.message}
                        </div>
                        <div style={{ fontSize: '12px', marginTop: '8px', opacity: 0.7 }}>
                          {notification.timestamp.toLocaleTimeString()}
                        </div>
                      </div>
                    </div>
                    <button
                      onClick={() => removeNotification(notification.id)}
                      style={{
                        background: 'none',
                        border: 'none',
                        fontSize: '18px',
                        cursor: 'pointer',
                        color: 'inherit',
                        opacity: 0.7,
                        marginLeft: '10px'
                      }}
                    >
                      ×
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Notification Settings */}
          <div style={{ 
            marginTop: '40px', 
            padding: '20px', 
            backgroundColor: '#f8f9fa', 
            borderRadius: '4px' 
          }}>
            <h3>Notification Settings</h3>
            <div style={{ display: 'flex', gap: '20px', alignItems: 'center', flexWrap: 'wrap' }}>
              <label style={{ display: 'flex', alignItems: 'center', gap: '5px', cursor: 'pointer' }}>
                <input type="checkbox" defaultChecked />
                Enable desktop notifications
              </label>
              <label style={{ display: 'flex', alignItems: 'center', gap: '5px', cursor: 'pointer' }}>
                <input type="checkbox" defaultChecked />
                Play sound for notifications
              </label>
              <label style={{ display: 'flex', alignItems: 'center', gap: '5px', cursor: 'pointer' }}>
                <input type="checkbox" />
                Show notification count in badge
              </label>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ToastNotificationIssues;
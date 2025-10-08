import React, { useState } from 'react';

const MissingPageTitle = () => {
  const [settings, setSettings] = useState({
    theme: 'light',
    language: 'en',
    newsletter: true,
    autoSave: true,
    fontSize: 'medium'
  });

  const handleSettingChange = (name, value) => {
    setSettings(prev => ({
      ...prev,
      [name]: value
    }));
  };

  return (
    <div style={{ 
      maxWidth: '800px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      {/* This page intentionally lacks a proper <title> element */}
      <h1>Settings</h1>
      <p>Configure your application preferences and account settings.</p>
      
      <div style={{
        display: 'grid',
        gap: '30px'
      }}>
        {/* Appearance Settings */}
        <div style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '20px', 
            margin: '0 0 20px 0',
            color: '#333',
            borderBottom: '2px solid #007bff',
            paddingBottom: '10px'
          }}>
            Appearance
          </h2>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Theme
            </label>
            <select
              value={settings.theme}
              onChange={(e) => handleSettingChange('theme', e.target.value)}
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="light">Light</option>
              <option value="dark">Dark</option>
              <option value="auto">Auto</option>
            </select>
          </div>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Font Size
            </label>
            <select
              value={settings.fontSize}
              onChange={(e) => handleSettingChange('fontSize', e.target.value)}
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="small">Small</option>
              <option value="medium">Medium</option>
              <option value="large">Large</option>
            </select>
          </div>
        </div>

        {/* Language Settings */}
        <div style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '20px', 
            margin: '0 0 20px 0',
            color: '#333',
            borderBottom: '2px solid #007bff',
            paddingBottom: '10px'
          }}>
            Language & Region
          </h2>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Language
            </label>
            <select
              value={settings.language}
              onChange={(e) => handleSettingChange('language', e.target.value)}
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
              <option value="de">German</option>
              <option value="it">Italian</option>
            </select>
          </div>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Time Zone
            </label>
            <select
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="utc">UTC</option>
              <option value="est">Eastern Time</option>
              <option value="pst">Pacific Time</option>
              <option value="cet">Central European Time</option>
            </select>
          </div>
        </div>

        {/* Notification Settings */}
        <div style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '20px', 
            margin: '0 0 20px 0',
            color: '#333',
            borderBottom: '2px solid #007bff',
            paddingBottom: '10px'
          }}>
            Notifications
          </h2>
          
          <div style={{ marginBottom: '15px' }}>
            <input
              type="checkbox"
              id="newsletter"
              checked={settings.newsletter}
              onChange={(e) => handleSettingChange('newsletter', e.target.checked)}
              style={{ marginRight: '10px' }}
            />
            <label htmlFor="newsletter" style={{ 
              cursor: 'pointer',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Enable notifications
            </label>
          </div>
          
          <div style={{ marginBottom: '15px' }}>
            <input
              type="checkbox"
              id="autoSave"
              checked={settings.autoSave}
              onChange={(e) => handleSettingChange('autoSave', e.target.checked)}
              style={{ marginRight: '10px' }}
            />
            <label htmlFor="autoSave" style={{ 
              cursor: 'pointer',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Auto-save changes
            </label>
          </div>
          
          <div style={{ marginBottom: '15px' }}>
            <input
              type="checkbox"
              id="emailNotifications"
              style={{ marginRight: '10px' }}
            />
            <label htmlFor="emailNotifications" style={{ 
              cursor: 'pointer',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Email notifications
            </label>
          </div>
        </div>

        {/* Privacy Settings */}
        <div style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '20px', 
            margin: '0 0 20px 0',
            color: '#333',
            borderBottom: '2px solid #007bff',
            paddingBottom: '10px'
          }}>
            Privacy & Security
          </h2>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Data Collection
            </label>
            <select
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="minimal">Minimal</option>
              <option value="standard">Standard</option>
              <option value="comprehensive">Comprehensive</option>
            </select>
          </div>
          
          <div style={{ marginBottom: '20px' }}>
            <label style={{
              display: 'block',
              marginBottom: '8px',
              fontWeight: 'bold',
              color: '#333'
            }}>
              Session Timeout
            </label>
            <select
              style={{
                padding: '8px 12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '14px',
                width: '200px'
              }}
            >
              <option value="15">15 minutes</option>
              <option value="30">30 minutes</option>
              <option value="60">1 hour</option>
              <option value="240">4 hours</option>
            </select>
          </div>
        </div>
      </div>

      <div style={{
        display: 'flex',
        gap: '15px',
        justifyContent: 'flex-end',
        marginTop: '30px'
      }}>
        <button style={{
          background: '#6c757d',
          color: 'white',
          border: 'none',
          padding: '12px 24px',
          borderRadius: '4px',
          cursor: 'pointer',
          fontSize: '16px'
        }}>
          Cancel
        </button>
        <button style={{
          background: '#007bff',
          color: 'white',
          border: 'none',
          padding: '12px 24px',
          borderRadius: '4px',
          cursor: 'pointer',
          fontSize: '16px'
        }}>
          Save Changes
        </button>
      </div>
    </div>
  );
};

export default MissingPageTitle;

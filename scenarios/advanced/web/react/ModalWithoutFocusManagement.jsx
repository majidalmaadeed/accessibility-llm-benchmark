import React, { useState, useRef, useEffect } from 'react';

const ModalWithoutFocusManagement = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [settings, setSettings] = useState({
    theme: 'light',
    language: 'en',
    notifications: 'all'
  });

  const handleOpenModal = () => {
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  const handleSaveSettings = () => {
    alert('Settings saved successfully!');
    handleCloseModal();
  };

  const handleSettingChange = (key, value) => {
    setSettings(prev => ({
      ...prev,
      [key]: value
    }));
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Settings Dashboard</h1>
        <p>Manage your application preferences and settings.</p>
        
        <div style={{ marginTop: '30px' }}>
          <button
            onClick={handleOpenModal}
            style={{
              backgroundColor: '#007bff',
              color: 'white',
              padding: '12px 24px',
              border: 'none',
              borderRadius: '4px',
              fontSize: '16px',
              cursor: 'pointer'
            }}
          >
            Open Settings Modal
          </button>
          
          <div style={{ marginTop: '20px', padding: '20px', backgroundColor: '#f8f9fa', borderRadius: '4px' }}>
            <h3>Current Settings:</h3>
            <p><strong>Theme:</strong> {settings.theme}</p>
            <p><strong>Language:</strong> {settings.language}</p>
            <p><strong>Notifications:</strong> {settings.notifications}</p>
          </div>
        </div>
      </div>

      {/* Modal */}
      {isModalOpen && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 1000
          }}
          onClick={(e) => {
            if (e.target === e.currentTarget) {
              handleCloseModal();
            }
          }}
        >
          <div
            style={{
              background: 'white',
              padding: '30px',
              borderRadius: '8px',
              boxShadow: '0 4px 20px rgba(0,0,0,0.3)',
              maxWidth: '500px',
              width: '90%',
              position: 'relative'
            }}
            onClick={(e) => e.stopPropagation()}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px', paddingBottom: '10px', borderBottom: '1px solid #eee' }}>
              <h2 style={{ margin: 0, fontSize: '24px', color: '#333' }}>Settings</h2>
              <button
                onClick={handleCloseModal}
                style={{
                  background: 'none',
                  border: 'none',
                  fontSize: '24px',
                  cursor: 'pointer',
                  color: '#666',
                  padding: 0,
                  width: '30px',
                  height: '30px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center'
                }}
              >
                ×
              </button>
            </div>
            
            <form>
              <div style={{ marginBottom: '20px' }}>
                <label htmlFor="theme" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold', color: '#333' }}>
                  Theme:
                </label>
                <select
                  id="theme"
                  name="theme"
                  value={settings.theme}
                  onChange={(e) => handleSettingChange('theme', e.target.value)}
                  style={{
                    width: '100%',
                    padding: '10px',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    fontSize: '16px',
                    boxSizing: 'border-box'
                  }}
                >
                  <option value="light">Light</option>
                  <option value="dark">Dark</option>
                  <option value="auto">Auto</option>
                </select>
              </div>
              
              <div style={{ marginBottom: '20px' }}>
                <label htmlFor="language" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold', color: '#333' }}>
                  Language:
                </label>
                <select
                  id="language"
                  name="language"
                  value={settings.language}
                  onChange={(e) => handleSettingChange('language', e.target.value)}
                  style={{
                    width: '100%',
                    padding: '10px',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    fontSize: '16px',
                    boxSizing: 'border-box'
                  }}
                >
                  <option value="en">English</option>
                  <option value="es">Spanish</option>
                  <option value="fr">French</option>
                </select>
              </div>
              
              <div style={{ marginBottom: '20px' }}>
                <label htmlFor="notifications" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold', color: '#333' }}>
                  Email Notifications:
                </label>
                <select
                  id="notifications"
                  name="notifications"
                  value={settings.notifications}
                  onChange={(e) => handleSettingChange('notifications', e.target.value)}
                  style={{
                    width: '100%',
                    padding: '10px',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    fontSize: '16px',
                    boxSizing: 'border-box'
                  }}
                >
                  <option value="all">All</option>
                  <option value="important">Important Only</option>
                  <option value="none">None</option>
                </select>
              </div>
            </form>
            
            <div style={{ display: 'flex', gap: '10px', justifyContent: 'flex-end', marginTop: '30px' }}>
              <button
                type="button"
                onClick={handleCloseModal}
                style={{
                  padding: '10px 20px',
                  border: 'none',
                  borderRadius: '4px',
                  fontSize: '16px',
                  cursor: 'pointer',
                  backgroundColor: '#6c757d',
                  color: 'white'
                }}
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={handleSaveSettings}
                style={{
                  padding: '10px 20px',
                  border: 'none',
                  borderRadius: '4px',
                  fontSize: '16px',
                  cursor: 'pointer',
                  backgroundColor: '#007bff',
                  color: 'white'
                }}
              >
                Save Settings
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ModalWithoutFocusManagement;
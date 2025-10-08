'use client';

import React, { useState } from 'react';

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
    <div className="main-container">
      <div className="main-content">
        <h1>Settings Dashboard</h1>
        <p>Manage your application preferences and settings.</p>
        
        <div className="dashboard-content">
          <button onClick={handleOpenModal} className="open-modal-btn">
            Open Settings Modal
          </button>
          
          <div className="current-settings">
            <h3>Current Settings:</h3>
            <p><strong>Theme:</strong> {settings.theme}</p>
            <p><strong>Language:</strong> {settings.language}</p>
            <p><strong>Notifications:</strong> {settings.notifications}</p>
          </div>
        </div>
      </div>

      {/* Modal */}
      {isModalOpen && (
        <div className="modal-overlay" onClick={(e) => {
          if (e.target === e.currentTarget) {
            handleCloseModal();
          }
        }}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h2 className="modal-title">Settings</h2>
              <button onClick={handleCloseModal} className="close-btn" aria-label="Close modal">
                ×
              </button>
            </div>
            
            <form>
              <div className="form-group">
                <label htmlFor="theme">Theme:</label>
                <select
                  id="theme"
                  name="theme"
                  value={settings.theme}
                  onChange={(e) => handleSettingChange('theme', e.target.value)}
                >
                  <option value="light">Light</option>
                  <option value="dark">Dark</option>
                  <option value="auto">Auto</option>
                </select>
              </div>
              
              <div className="form-group">
                <label htmlFor="language">Language:</label>
                <select
                  id="language"
                  name="language"
                  value={settings.language}
                  onChange={(e) => handleSettingChange('language', e.target.value)}
                >
                  <option value="en">English</option>
                  <option value="es">Spanish</option>
                  <option value="fr">French</option>
                </select>
              </div>
              
              <div className="form-group">
                <label htmlFor="notifications">Email Notifications:</label>
                <select
                  id="notifications"
                  name="notifications"
                  value={settings.notifications}
                  onChange={(e) => handleSettingChange('notifications', e.target.value)}
                >
                  <option value="all">All</option>
                  <option value="important">Important Only</option>
                  <option value="none">None</option>
                </select>
              </div>
            </form>
            
            <div className="modal-actions">
              <button type="button" onClick={handleCloseModal} className="btn btn-secondary">
                Cancel
              </button>
              <button type="button" onClick={handleSaveSettings} className="btn btn-primary">
                Save Settings
              </button>
            </div>
          </div>
        </div>
      )}

      <style jsx>{`
        .main-container {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background-color: #f5f5f5;
        }

        .main-content {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .dashboard-content {
          margin-top: 30px;
        }

        .open-modal-btn {
          background-color: #007bff;
          color: white;
          padding: 12px 24px;
          border: none;
          border-radius: 4px;
          font-size: 16px;
          cursor: pointer;
        }

        .open-modal-btn:hover {
          background-color: #0056b3;
        }

        .current-settings {
          margin-top: 20px;
          padding: 20px;
          background-color: #f8f9fa;
          border-radius: 4px;
        }

        .current-settings h3 {
          margin-top: 0;
        }

        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 1000;
        }

        .modal-content {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 4px 20px rgba(0,0,0,0.3);
          max-width: 500px;
          width: 90%;
          position: relative;
        }

        .modal-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
          padding-bottom: 10px;
          border-bottom: 1px solid #eee;
        }

        .modal-title {
          margin: 0;
          font-size: 24px;
          color: #333;
        }

        .close-btn {
          background: none;
          border: none;
          font-size: 24px;
          cursor: pointer;
          color: #666;
          padding: 0;
          width: 30px;
          height: 30px;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .close-btn:hover {
          color: #333;
        }

        .form-group {
          margin-bottom: 20px;
        }

        .form-group label {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
          color: #333;
        }

        .form-group input, .form-group select {
          width: 100%;
          padding: 10px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 16px;
          box-sizing: border-box;
        }

        .modal-actions {
          display: flex;
          gap: 10px;
          justify-content: flex-end;
          margin-top: 30px;
        }

        .btn {
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          font-size: 16px;
          cursor: pointer;
        }

        .btn-primary {
          background-color: #007bff;
          color: white;
        }

        .btn-primary:hover {
          background-color: #0056b3;
        }

        .btn-secondary {
          background-color: #6c757d;
          color: white;
        }

        .btn-secondary:hover {
          background-color: #545b62;
        }
      `}</style>
    </div>
  );
};

export default ModalWithoutFocusManagement;
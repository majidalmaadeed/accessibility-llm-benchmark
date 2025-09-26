import React, { useState, useRef, useEffect } from 'react';

const ModalWithoutFocusManagement = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [settings, setSettings] = useState({
    theme: 'light',
    language: 'en',
    notifications: 'all'
  });
  
  const modalRef = useRef(null);
  const previousActiveElement = useRef(null);

  const openModal = () => {
    previousActiveElement.current = document.activeElement;
    setIsOpen(true);
    
    // MISSING: Focus management
    // Should set focus to modal and implement focus trap
  };

  const closeModal = () => {
    setIsOpen(false);
    
    // MISSING: Focus return
    // Should return focus to previousActiveElement.current
  };

  const handleSave = () => {
    alert('Settings saved!');
    closeModal();
  };

  const handleKeyDown = (event) => {
    if (event.key === 'Escape') {
      closeModal();
    }
    
    // MISSING: Focus trap implementation
    // Should handle Tab/Shift+Tab to keep focus within modal
  };

  useEffect(() => {
    if (isOpen) {
      document.addEventListener('keydown', handleKeyDown);
      return () => document.removeEventListener('keydown', handleKeyDown);
    }
  }, [isOpen]);

  return (
    <div style={{ maxWidth: '800px', margin: '50px auto', padding: '20px' }}>
      <div style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)'
      }}>
        <h1>Settings Modal</h1>
        <p>Configure your application settings using the modal below.</p>
        
        <button
          onClick={openModal}
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
        
        <p style={{ marginTop: '20px' }}>
          This page demonstrates a modal dialog that violates accessibility guidelines by not managing focus properly.
          When the modal opens, focus should be trapped inside it and returned to the trigger button when closed.
        </p>
      </div>

      {/* Modal */}
      {isOpen && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            zIndex: 1000,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
          onClick={(e) => {
            if (e.target === e.currentTarget) {
              closeModal();
            }
          }}
          // MISSING: role="dialog", aria-modal="true", aria-labelledby
        >
          <div
            ref={modalRef}
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
            <div style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              marginBottom: '20px',
              paddingBottom: '10px',
              borderBottom: '1px solid #eee'
            }}>
              <h2 style={{ margin: 0, fontSize: '24px', color: '#333' }}>
                Settings
              </h2>
              <button
                onClick={closeModal}
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
                aria-label="Close modal"
              >
                ×
              </button>
            </div>
            
            <form>
              <div style={{ marginBottom: '20px' }}>
                <label htmlFor="theme" style={{
                  display: 'block',
                  marginBottom: '5px',
                  fontWeight: 'bold',
                  color: '#333'
                }}>
                  Theme:
                </label>
                <select
                  id="theme"
                  value={settings.theme}
                  onChange={(e) => setSettings({...settings, theme: e.target.value})}
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
                <label htmlFor="language" style={{
                  display: 'block',
                  marginBottom: '5px',
                  fontWeight: 'bold',
                  color: '#333'
                }}>
                  Language:
                </label>
                <select
                  id="language"
                  value={settings.language}
                  onChange={(e) => setSettings({...settings, language: e.target.value})}
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
                <label htmlFor="notifications" style={{
                  display: 'block',
                  marginBottom: '5px',
                  fontWeight: 'bold',
                  color: '#333'
                }}>
                  Email Notifications:
                </label>
                <select
                  id="notifications"
                  value={settings.notifications}
                  onChange={(e) => setSettings({...settings, notifications: e.target.value})}
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
            
            <div style={{
              display: 'flex',
              gap: '10px',
              justifyContent: 'flex-end',
              marginTop: '30px'
            }}>
              <button
                type="button"
                onClick={closeModal}
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
                onClick={handleSave}
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

      <div style={{
        marginTop: '30px',
        padding: '20px',
        backgroundColor: '#e9ecef',
        borderRadius: '4px'
      }}>
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>No focus trap:</strong> Tab key can move focus outside the modal</li>
          <li><strong>No initial focus:</strong> Focus doesn't move to the modal when it opens</li>
          <li><strong>No focus return:</strong> Focus doesn't return to trigger button when modal closes</li>
          <li><strong>Missing ARIA attributes:</strong> No role="dialog", aria-modal, or aria-labelledby</li>
          <li><strong>Escape key not handled:</strong> Modal doesn't close when Escape is pressed</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>role="dialog"</code> and <code>aria-modal="true"</code> to modal</li>
          <li>Add <code>aria-labelledby="modal-title"</code> to reference the title</li>
          <li>Implement focus trap to keep focus within modal</li>
          <li>Set initial focus to first focusable element in modal</li>
          <li>Return focus to trigger button when modal closes</li>
          <li>Handle Escape key to close modal</li>
        </ul>
      </div>
    </div>
  );
};

export default ModalWithoutFocusManagement;
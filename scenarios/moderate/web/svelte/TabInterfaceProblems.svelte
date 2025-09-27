import React, { useState } from 'react';

const TabInterfaceProblems = () => {
  const [activeTab, setActiveTab] = useState(0);

  const tabs = [
    {
      id: 'general',
      label: 'General',
      content: {
        title: 'General Settings',
        fields: [
          { id: 'site-name', label: 'Site Name', type: 'text', value: 'My Website' },
          { id: 'site-description', label: 'Site Description', type: 'textarea', value: 'A sample website for demonstration purposes.' },
          { id: 'language', label: 'Default Language', type: 'select', value: 'en', options: [
            { value: 'en', label: 'English' },
            { value: 'es', label: 'Spanish' },
            { value: 'fr', label: 'French' }
          ]}
        ]
      }
    },
    {
      id: 'appearance',
      label: 'Appearance',
      content: {
        title: 'Appearance Settings',
        fields: [
          { id: 'theme', label: 'Theme', type: 'select', value: 'light', options: [
            { value: 'light', label: 'Light' },
            { value: 'dark', label: 'Dark' },
            { value: 'auto', label: 'Auto' }
          ]},
          { id: 'primary-color', label: 'Primary Color', type: 'color', value: '#007bff' },
          { id: 'font-size', label: 'Font Size', type: 'range', value: '16', min: '12', max: '24' }
        ]
      }
    },
    {
      id: 'security',
      label: 'Security',
      content: {
        title: 'Security Settings',
        fields: [
          { id: 'two-factor', label: 'Two-Factor Authentication', type: 'checkbox', value: false },
          { id: 'session-timeout', label: 'Session Timeout (minutes)', type: 'number', value: '30' },
          { id: 'password-policy', label: 'Password Policy', type: 'select', value: 'medium', options: [
            { value: 'low', label: 'Low' },
            { value: 'medium', label: 'Medium' },
            { value: 'high', label: 'High' }
          ]}
        ]
      }
    },
    {
      id: 'notifications',
      label: 'Notifications',
      content: {
        title: 'Notification Settings',
        fields: [
          { id: 'email-notifications', label: 'Email Notifications', type: 'checkbox', value: true },
          { id: 'push-notifications', label: 'Push Notifications', type: 'checkbox', value: false },
          { id: 'notification-frequency', label: 'Notification Frequency', type: 'select', value: 'daily', options: [
            { value: 'immediate', label: 'Immediate' },
            { value: 'daily', label: 'Daily' },
            { value: 'weekly', label: 'Weekly' }
          ]}
        ]
      }
    }
  ];

  const handleTabClick = (index) => {
    setActiveTab(index);
  };

  const handleKeyDown = (e, index) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      setActiveTab(index);
    } else if (e.key === 'ArrowRight') {
      e.preventDefault();
      setActiveTab((prevIndex) => (prevIndex + 1) % tabs.length);
    } else if (e.key === 'ArrowLeft') {
      e.preventDefault();
      setActiveTab((prevIndex) => (prevIndex - 1 + tabs.length) % tabs.length);
    } else if (e.key === 'Home') {
      e.preventDefault();
      setActiveTab(0);
    } else if (e.key === 'End') {
      e.preventDefault();
      setActiveTab(tabs.length - 1);
    }
  };

  const renderField = (field) => {
    switch (field.type) {
      case 'text':
        return (
          <input
            type="text"
            id={field.id}
            defaultValue={field.value}
            style={{
              width: '100%',
              padding: '8px 12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '14px'
            }}
          />
        );
      case 'textarea':
        return (
          <textarea
            id={field.id}
            defaultValue={field.value}
            rows="3"
            style={{
              width: '100%',
              padding: '8px 12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '14px',
              resize: 'vertical'
            }}
          />
        );
      case 'select':
        return (
          <select
            id={field.id}
            defaultValue={field.value}
            style={{
              width: '100%',
              padding: '8px 12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '14px'
            }}
          >
            {field.options.map(option => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        );
      case 'checkbox':
        return (
          <input
            type="checkbox"
            id={field.id}
            defaultChecked={field.value}
            style={{ marginRight: '8px' }}
          />
        );
      case 'number':
        return (
          <input
            type="number"
            id={field.id}
            defaultValue={field.value}
            min={field.min}
            max={field.max}
            style={{
              width: '100%',
              padding: '8px 12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '14px'
            }}
          />
        );
      case 'color':
        return (
          <input
            type="color"
            id={field.id}
            defaultValue={field.value}
            style={{
              width: '60px',
              height: '40px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              cursor: 'pointer'
            }}
          />
        );
      case 'range':
        return (
          <input
            type="range"
            id={field.id}
            defaultValue={field.value}
            min={field.min}
            max={field.max}
            style={{ width: '100%' }}
          />
        );
      default:
        return null;
    }
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Settings Dashboard</h1>
        <p>Configure your settings using the tabbed interface below.</p>
        
        {/* Tab Interface */}
        <div style={{ marginTop: '30px' }}>
          {/* Tab List - MISSING PROPER ARIA ATTRIBUTES */}
          <div
            role="tablist"
            aria-label="Settings categories"
            style={{
              display: 'flex',
              borderBottom: '2px solid #eee',
              marginBottom: '20px'
            }}
          >
            {tabs.map((tab, index) => (
              <button
                key={tab.id}
                onClick={() => handleTabClick(index)}
                onKeyDown={(e) => handleKeyDown(e, index)}
                style={{
                  padding: '12px 20px',
                  border: 'none',
                  background: 'none',
                  cursor: 'pointer',
                  fontSize: '16px',
                  fontWeight: activeTab === index ? 'bold' : 'normal',
                  color: activeTab === index ? '#007bff' : '#666',
                  borderBottom: activeTab === index ? '3px solid #007bff' : '3px solid transparent',
                  transition: 'all 0.3s ease',
                  position: 'relative'
                }}
                role="tab"
                aria-selected={activeTab === index}
                aria-controls={`tabpanel-${tab.id}`}
                id={`tab-${tab.id}`}
                tabIndex={activeTab === index ? 0 : -1}
              >
                {tab.label}
              </button>
            ))}
          </div>

          {/* Tab Panels - MISSING PROPER ARIA ATTRIBUTES */}
          {tabs.map((tab, index) => (
            <div
              key={tab.id}
              id={`tabpanel-${tab.id}`}
              role="tabpanel"
              aria-labelledby={`tab-${tab.id}`}
              style={{
                display: activeTab === index ? 'block' : 'none',
                padding: '20px 0'
              }}
            >
              <h2 style={{ margin: '0 0 20px 0', color: '#333' }}>
                {tab.content.title}
              </h2>
              
              <form style={{ display: 'grid', gap: '20px' }}>
                {tab.content.fields.map((field) => (
                  <div key={field.id} style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                    <label
                      htmlFor={field.id}
                      style={{
                        fontWeight: 'bold',
                        color: '#333',
                        fontSize: '14px'
                      }}
                    >
                      {field.label}
                    </label>
                    {renderField(field)}
                  </div>
                ))}
              </form>
            </div>
          ))}
        </div>

        {/* Action Buttons */}
        <div style={{ 
          marginTop: '30px', 
          paddingTop: '20px', 
          borderTop: '1px solid #eee',
          display: 'flex',
          gap: '12px',
          justifyContent: 'flex-end'
        }}>
          <button
            style={{
              background: '#6c757d',
              color: 'white',
              border: 'none',
              padding: '10px 20px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}
          >
            Cancel
          </button>
          
          <button
            style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '10px 20px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}
          >
            Save Changes
          </button>
        </div>
      </div>

      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Missing ARIA attributes:</strong> No aria-selected, aria-controls, or aria-labelledby</li>
          <li><strong>Incomplete keyboard navigation:</strong> Arrow keys don't navigate between tabs properly</li>
          <li><strong>No focus management:</strong> Focus doesn't move to tab panel when tab is activated</li>
          <li><strong>Missing tab semantics:</strong> Tab buttons lack proper role and state attributes</li>
          <li><strong>No screen reader announcements:</strong> Tab changes not announced to screen readers</li>
          <li><strong>Missing tab order:</strong> Tab panels not properly associated with their triggers</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>role="tab"</code> and <code>aria-selected</code> to tab buttons</li>
          <li>Use <code>aria-controls</code> to link tabs to their panels</li>
          <li>Add <code>aria-labelledby</code> to associate panels with their tabs</li>
          <li>Implement arrow key navigation (Left/Right) between tabs</li>
          <li>Add <code>role="tabpanel"</code> to content areas</li>
          <li>Use <code>aria-live="polite"</code> for tab change announcements</li>
        </ul>
      </div>
    </div>
  );
};

export default TabInterfaceProblems;
import React, { useState } from 'react';
    {
      id: 'general',
      content: {
        title: 'General Settings',
        fields: [
          ]}
        ]
      }
    },
    {
      id: 'appearance',
      content: {
        title: 'Appearance Settings',
        fields: [
          ]},
        ]
      }
    },
    {
      id: 'security',
      content: {
        title: 'Security Settings',
        fields: [
          ]}
        ]
      }
    },
    {
      id: 'notifications',
      content: {
        title: 'Notification Settings',
        fields: [
          ]}
        ]
      }
    }
  ];
  };
  const handleKeyDown = (e, index) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
    } else if (e.key === 'ArrowRight') {
      e.preventDefault();
    } else if (e.key === 'ArrowLeft') {
      e.preventDefault();
    } else if (e.key === 'Home') {
      e.preventDefault();
    } else if (e.key === 'End') {
      e.preventDefault();
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
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Settings Dashboard</h1>
        <div style={{ marginTop: '30px' }}>
          {}
          <div
            style={{
              display: 'flex',
              borderBottom: '2px solid #eee',
              marginBottom: '20px'
            }}
          >
              <button
                onKeyDown={(e) => handleKeyDown(e, index)}
                style={{
                  padding: '12px 20px',
                  border: 'none',
                  background: 'none',
                  cursor: 'pointer',
                  fontSize: '16px',
                  transition: 'all 0.3s ease',
                  position: 'relative'
                }}
              >
              </button>
            ))}
          </div>
          {}
            <div
              style={{
                padding: '20px 0'
              }}
            >
              <h2 style={{ margin: '0 0 20px 0', color: '#333' }}>
              </h2>
              <form style={{ display: 'grid', gap: '20px' }}>
                  <div key={field.id} style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                      htmlFor={field.id}
                      style={{
                        fontWeight: 'bold',
                        color: '#333',
                        fontSize: '14px'
                      }}
                    >
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
      </div>
    </div>
  );
};
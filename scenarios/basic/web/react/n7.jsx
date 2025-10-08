import React, { useState } from 'react';

const InsufficientButtonSpacing = () => {
  const [selectedAction, setSelectedAction] = useState('');

  const handleAction = (action) => {
    setSelectedAction(action);
  };

  return (
    <div style={{ 
      maxWidth: '800px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Document Management</h1>
      <p>Manage your documents with the available actions below.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '30px'
      }}>
        <h2>Current Document: Project Proposal.docx</h2>
        <p style={{ color: '#666', margin: '5px 0 0 0' }}>
          Last modified: January 15, 2024 | Size: 2.3 MB
        </p>
      </div>

      <div style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
        border: '1px solid #e0e0e0',
        marginBottom: '30px'
      }}>
        <h2>Available Actions</h2>
        <p>Select an action to perform on the current document:</p>
        
        {/* Action buttons placed 2px apart instead of minimum 44px */}
        <div style={{
          display: 'flex',
          gap: '2px',
          flexWrap: 'wrap',
          marginTop: '20px'
        }}>
          <button
            onClick={() => handleAction('view')}
            style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            View
          </button>
          <button
            onClick={() => handleAction('edit')}
            style={{
              background: '#28a745',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Edit
          </button>
          <button
            onClick={() => handleAction('download')}
            style={{
              background: '#17a2b8',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Download
          </button>
          <button
            onClick={() => handleAction('share')}
            style={{
              background: '#ffc107',
              color: '#212529',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Share
          </button>
          <button
            onClick={() => handleAction('print')}
            style={{
              background: '#6c757d',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Print
          </button>
          <button
            onClick={() => handleAction('delete')}
            style={{
              background: '#dc3545',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Delete
          </button>
        </div>
      </div>

      <div style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
        border: '1px solid #e0e0e0',
        marginBottom: '30px'
      }}>
        <h2>Quick Actions Toolbar</h2>
        <p>Commonly used actions for quick access:</p>
        
        {/* Another set of insufficiently spaced buttons */}
        <div style={{
          display: 'flex',
          gap: '2px',
          flexWrap: 'wrap',
          marginTop: '15px'
        }}>
          <button style={{
            background: '#e9ecef',
            color: '#495057',
            border: '1px solid #ced4da',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Copy
          </button>
          <button style={{
            background: '#e9ecef',
            color: '#495057',
            border: '1px solid #ced4da',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Move
          </button>
          <button style={{
            background: '#e9ecef',
            color: '#495057',
            border: '1px solid #ced4da',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Rename
          </button>
          <button style={{
            background: '#e9ecef',
            color: '#495057',
            border: '1px solid #ced4da',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Archive
          </button>
          <button style={{
            background: '#e9ecef',
            color: '#495057',
            border: '1px solid #ced4da',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Properties
          </button>
        </div>
      </div>

      <div style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
        border: '1px solid #e0e0e0',
        marginBottom: '30px'
      }}>
        <h2>Document Status</h2>
        <p>Current status and available status changes:</p>
        
        <div style={{
          display: 'flex',
          gap: '2px',
          flexWrap: 'wrap',
          marginTop: '15px'
        }}>
          <button style={{
            background: '#d4edda',
            color: '#155724',
            border: '1px solid #c3e6cb',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Mark as Draft
          </button>
          <button style={{
            background: '#fff3cd',
            color: '#856404',
            border: '1px solid #ffeaa7',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Mark as Review
          </button>
          <button style={{
            background: '#d1ecf1',
            color: '#0c5460',
            border: '1px solid #bee5eb',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Mark as Approved
          </button>
          <button style={{
            background: '#f8d7da',
            color: '#721c24',
            border: '1px solid #f5c6cb',
            padding: '6px 12px',
            borderRadius: '3px',
            cursor: 'pointer',
            fontSize: '12px'
          }}>
            Mark as Rejected
          </button>
        </div>
      </div>

      {selectedAction && (
        <div style={{
          background: '#d1ecf1',
          color: '#0c5460',
          padding: '15px',
          borderRadius: '4px',
          marginBottom: '20px',
          border: '1px solid #bee5eb'
        }}>
          <strong>Action Selected:</strong> {selectedAction}
        </div>
      )}
    </div>
  );
};

export default InsufficientButtonSpacing;

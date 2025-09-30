import React, { useState } from 'react';

const StatusByShapeOnly = () => {
  const [documents] = useState([
    { id: 1, name: 'Project Proposal.docx', status: 'approved', lastModified: '2024-01-15' },
    { id: 2, name: 'Budget Report.xlsx', status: 'pending', lastModified: '2024-01-14' },
    { id: 3, name: 'Meeting Notes.pdf', status: 'rejected', lastModified: '2024-01-13' },
    { id: 4, name: 'Contract Agreement.pdf', status: 'approved', lastModified: '2024-01-12' },
    { id: 5, name: 'Invoice Template.docx', status: 'pending', lastModified: '2024-01-11' }
  ]);

  const getStatusIcon = (status) => {
    switch (status) {
      case 'approved':
        return '●'; // Circle
      case 'pending':
        return '■'; // Square
      case 'rejected':
        return '▲'; // Triangle
      default:
        return '●';
    }
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'approved':
        return '#4caf50';
      case 'pending':
        return '#ff9800';
      case 'rejected':
        return '#f44336';
      default:
        return '#666';
    }
  };

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Document Management System</h1>
      <p>Review and manage document approval status across your organization.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '30px'
      }}>
        <h2>Document Status Overview</h2>
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
          gap: '20px',
          marginTop: '15px'
        }}>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', color: '#4caf50', marginBottom: '5px' }}>●</div>
            <div style={{ fontSize: '18px', fontWeight: 'bold', color: '#333' }}>
              {documents.filter(doc => doc.status === 'approved').length}
            </div>
            <div style={{ fontSize: '14px', color: '#666' }}>Approved</div>
          </div>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', color: '#ff9800', marginBottom: '5px' }}>■</div>
            <div style={{ fontSize: '18px', fontWeight: 'bold', color: '#333' }}>
              {documents.filter(doc => doc.status === 'pending').length}
            </div>
            <div style={{ fontSize: '14px', color: '#666' }}>Pending</div>
          </div>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', color: '#f44336', marginBottom: '5px' }}>▲</div>
            <div style={{ fontSize: '18px', fontWeight: 'bold', color: '#333' }}>
              {documents.filter(doc => doc.status === 'rejected').length}
            </div>
            <div style={{ fontSize: '14px', color: '#666' }}>Rejected</div>
          </div>
        </div>
      </div>

      <div style={{
        background: 'white',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
        overflow: 'hidden',
        border: '1px solid #e0e0e0'
      }}>
        <div style={{
          background: '#f8f9fa',
          padding: '20px',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h2 style={{ margin: 0, fontSize: '20px' }}>Document List</h2>
          <p style={{ margin: '5px 0 0 0', color: '#666', fontSize: '14px' }}>
            Document approval status indicated by shape only
          </p>
        </div>
        
        <div style={{ padding: '20px' }}>
          <div style={{
            display: 'grid',
            gap: '15px'
          }}>
            {documents.map((document) => (
              <div 
                key={document.id}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  padding: '15px',
                  border: '1px solid #e0e0e0',
                  borderRadius: '4px',
                  background: '#fafafa'
                }}
              >
                {/* Document approval status indicated only by circle vs square shape */}
                <div style={{
                  fontSize: '24px',
                  color: getStatusColor(document.status),
                  marginRight: '15px',
                  minWidth: '30px',
                  textAlign: 'center'
                }}>
                  {getStatusIcon(document.status)}
                </div>
                
                <div style={{ flex: 1 }}>
                  <h3 style={{ 
                    margin: '0 0 5px 0', 
                    fontSize: '16px',
                    color: '#333'
                  }}>
                    {document.name}
                  </h3>
                  <p style={{ 
                    margin: 0, 
                    fontSize: '14px', 
                    color: '#666'
                  }}>
                    Last modified: {document.lastModified}
                  </p>
                </div>
                
                <div style={{
                  display: 'flex',
                  gap: '10px',
                  alignItems: 'center'
                }}>
                  <button style={{
                    background: '#007bff',
                    color: 'white',
                    border: 'none',
                    padding: '6px 12px',
                    borderRadius: '4px',
                    cursor: 'pointer',
                    fontSize: '12px'
                  }}>
                    View
                  </button>
                  <button style={{
                    background: '#6c757d',
                    color: 'white',
                    border: 'none',
                    padding: '6px 12px',
                    borderRadius: '4px',
                    cursor: 'pointer',
                    fontSize: '12px'
                  }}>
                    Download
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default StatusByShapeOnly;

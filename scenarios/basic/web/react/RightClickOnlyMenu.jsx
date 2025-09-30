import React, { useState } from 'react';

const RightClickOnlyMenu = () => {
  const [files] = useState([
    { id: 1, name: 'Document1.pdf', type: 'pdf', size: '2.3 MB', lastModified: '2024-01-15' },
    { id: 2, name: 'Image1.jpg', type: 'image', size: '1.8 MB', lastModified: '2024-01-14' },
    { id: 3, name: 'Spreadsheet.xlsx', type: 'excel', size: '856 KB', lastModified: '2024-01-13' },
    { id: 4, name: 'Presentation.pptx', type: 'powerpoint', size: '4.2 MB', lastModified: '2024-01-12' },
    { id: 5, name: 'TextFile.txt', type: 'text', size: '12 KB', lastModified: '2024-01-11' }
  ]);

  const [contextMenu, setContextMenu] = useState({ visible: false, x: 0, y: 0, fileId: null });
  const [selectedFile, setSelectedFile] = useState(null);

  const getFileIcon = (type) => {
    const icons = {
      pdf: '📄',
      image: '🖼️',
      excel: '📊',
      powerpoint: '📈',
      text: '📝'
    };
    return icons[type] || '📄';
  };

  const handleContextMenu = (e, fileId) => {
    e.preventDefault();
    setContextMenu({
      visible: true,
      x: e.clientX,
      y: e.clientY,
      fileId: fileId
    });
    setSelectedFile(fileId);
  };

  const handleClick = () => {
    setContextMenu({ visible: false, x: 0, y: 0, fileId: null });
    setSelectedFile(null);
  };

  const handleAction = (action) => {
    const file = files.find(f => f.id === selectedFile);
    alert(`${action} action performed on ${file?.name}`);
  };

  const handleContextAction = (action) => {
    const file = files.find(f => f.id === contextMenu.fileId);
    alert(`${action} action performed on ${file?.name}`);
    setContextMenu({ visible: false, x: 0, y: 0, fileId: null });
    setSelectedFile(null);
  };

  const totalSize = files.reduce((total, file) => {
    const size = parseFloat(file.size);
    return total + (isNaN(size) ? 0 : size);
  }, 0).toFixed(1);

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>File Manager</h1>
      <p>Manage your files and documents. Right-click on any file to access additional options.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '30px'
      }}>
        <h2>File Statistics</h2>
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
            <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#007bff', marginBottom: '5px' }}>
              {files.length}
            </div>
            <div style={{ fontSize: '14px', color: '#666' }}>Total Files</div>
          </div>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#28a745', marginBottom: '5px' }}>
              {totalSize} MB
            </div>
            <div style={{ fontSize: '14px', color: '#666' }}>Total Size</div>
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
          <h2 style={{ margin: 0, fontSize: '20px' }}>Files</h2>
          <p style={{ margin: '5px 0 0 0', color: '#666', fontSize: '14px' }}>
            Right-click on any file to access additional options
          </p>
        </div>
        
        <div style={{ padding: '20px' }}>
          <div style={{
            display: 'grid',
            gap: '10px'
          }}>
            {files.map((file) => (
              <div 
                key={file.id}
                onContextMenu={(e) => handleContextMenu(e, file.id)}
                onClick={handleClick}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  padding: '15px',
                  border: '1px solid #e0e0e0',
                  borderRadius: '4px',
                  background: selectedFile === file.id ? '#e3f2fd' : '#fafafa',
                  cursor: 'pointer',
                  transition: 'background-color 0.2s ease'
                }}
              >
                <div style={{
                  fontSize: '24px',
                  marginRight: '15px'
                }}>
                  {getFileIcon(file.type)}
                </div>
                
                <div style={{ flex: 1 }}>
                  <h3 style={{ 
                    margin: '0 0 5px 0', 
                    fontSize: '16px',
                    color: '#333'
                  }}>
                    {file.name}
                  </h3>
                  <div style={{
                    display: 'flex',
                    gap: '20px',
                    fontSize: '14px',
                    color: '#666'
                  }}>
                    <span>Size: {file.size}</span>
                    <span>Modified: {file.lastModified}</span>
                    <span style={{ color: '#007bff', fontWeight: 'bold' }}>
                      {file.type.toUpperCase()}
                    </span>
                  </div>
                </div>
                
                <div style={{
                  display: 'flex',
                  gap: '10px',
                  alignItems: 'center'
                }}>
                  <button 
                    onClick={(e) => {
                      e.stopPropagation();
                      handleAction('View');
                    }}
                    style={{
                      background: '#007bff',
                      color: 'white',
                      border: 'none',
                      padding: '6px 12px',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '12px'
                    }}
                  >
                    View
                  </button>
                  <button 
                    onClick={(e) => {
                      e.stopPropagation();
                      handleAction('Download');
                    }}
                    style={{
                      background: '#6c757d',
                      color: 'white',
                      border: 'none',
                      padding: '6px 12px',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '12px'
                    }}
                  >
                    Download
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Essential delete option only available via right-click */}
      {contextMenu.visible && (
        <div 
          style={{
            position: 'fixed',
            left: contextMenu.x + 'px',
            top: contextMenu.y + 'px',
            background: 'white',
            border: '1px solid #ddd',
            borderRadius: '4px',
            boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
            zIndex: 1000,
            minWidth: '150px'
          }}
        >
          <div 
            onClick={() => handleContextAction('Open')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              borderBottom: '1px solid #eee',
              fontSize: '14px'
            }}
          >
            Open
          </div>
          <div 
            onClick={() => handleContextAction('Download')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              borderBottom: '1px solid #eee',
              fontSize: '14px'
            }}
          >
            Download
          </div>
          <div 
            onClick={() => handleContextAction('Rename')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              borderBottom: '1px solid #eee',
              fontSize: '14px'
            }}
          >
            Rename
          </div>
          <div 
            onClick={() => handleContextAction('Move')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              borderBottom: '1px solid #eee',
              fontSize: '14px'
            }}
          >
            Move
          </div>
          <div 
            onClick={() => handleContextAction('Copy')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              borderBottom: '1px solid #eee',
              fontSize: '14px'
            }}
          >
            Copy
          </div>
          <div 
            onClick={() => handleContextAction('Delete')}
            style={{
              padding: '10px 15px',
              cursor: 'pointer',
              color: '#dc3545',
              fontSize: '14px'
            }}
          >
            Delete
          </div>
        </div>
      )}
    </div>
  );
};

export default RightClickOnlyMenu;

import { useState, useEffect, useRef } from 'react';

export default function RightClickOnlyMenu() {
  const [selectedItems, setSelectedItems] = useState([]);
  const [contextMenu, setContextMenu] = useState({ visible: false, x: 0, y: 0, itemId: null });
  const [isEditing, setIsEditing] = useState(false);
  const [editingItem, setEditingItem] = useState(null);
  const [editValue, setEditValue] = useState('');
  const [sortBy, setSortBy] = useState('name');
  const [filterBy, setFilterBy] = useState('all');

  const fileListRef = useRef(null);
  const editInputRef = useRef(null);

  const fileItems = [
    { id: 1, name: 'Project Proposal.docx', type: 'document', size: '2.4 MB', modified: '2024-01-15', status: 'active' },
    { id: 2, name: 'Budget Spreadsheet.xlsx', type: 'spreadsheet', size: '1.8 MB', modified: '2024-01-14', status: 'active' },
    { id: 3, name: 'Team Photo.jpg', type: 'image', size: '3.2 MB', modified: '2024-01-13', status: 'archived' },
    { id: 4, name: 'Meeting Notes.pdf', type: 'document', size: '856 KB', modified: '2024-01-12', status: 'active' },
    { id: 5, name: 'Presentation.pptx', type: 'presentation', size: '4.1 MB', modified: '2024-01-11', status: 'draft' },
    { id: 6, name: 'Database Backup.sql', type: 'database', size: '15.2 MB', modified: '2024-01-10', status: 'active' },
    { id: 7, name: 'Logo Design.psd', type: 'image', size: '8.7 MB', modified: '2024-01-09', status: 'draft' },
    { id: 8, name: 'User Manual.pdf', type: 'document', size: '5.3 MB', modified: '2024-01-08', status: 'active' }
  ];

  const filteredItems = fileItems.filter(item => {
    if (filterBy === 'all') return true;
    return item.status === filterBy;
  });

  const sortedItems = [...filteredItems].sort((a, b) => {
    switch(sortBy) {
      case 'name':
        return a.name.localeCompare(b.name);
      case 'size':
        return parseFloat(b.size) - parseFloat(a.size);
      case 'modified':
        return new Date(b.modified) - new Date(a.modified);
      case 'type':
        return a.type.localeCompare(b.type);
      default:
        return 0;
    }
  });

  const handleContextMenu = (e, itemId) => {
    e.preventDefault();
    setContextMenu({
      visible: true,
      x: e.clientX,
      y: e.clientY,
      itemId: itemId
    });
  };

  const handleContextMenuAction = (action, itemId) => {
    const item = fileItems.find(f => f.id === itemId);
    
    switch(action) {
      case 'rename':
        setIsEditing(true);
        setEditingItem(itemId);
        setEditValue(item.name);
        break;
      case 'copy':
        alert(`Copying "${item.name}"`);
        break;
      case 'cut':
        alert(`Cutting "${item.name}"`);
        break;
      case 'delete':
        if (confirm(`Are you sure you want to delete "${item.name}"?`)) {
          alert(`Deleted "${item.name}"`);
        }
        break;
      case 'properties':
        alert(`Properties for "${item.name}"`);
        break;
      case 'download':
        alert(`Downloading "${item.name}"`);
        break;
      case 'share':
        alert(`Sharing "${item.name}"`);
        break;
      case 'archive':
        alert(`Archiving "${item.name}"`);
        break;
      default:
        break;
    }
    
    setContextMenu({ visible: false, x: 0, y: 0, itemId: null });
  };

  const handleItemClick = (itemId) => {
    if (isEditing && editingItem === itemId) return;
    
    setSelectedItems(prev => 
      prev.includes(itemId) 
        ? prev.filter(id => id !== itemId)
        : [...prev, itemId]
    );
  };

  const handleItemDoubleClick = (itemId) => {
    const item = fileItems.find(f => f.id === itemId);
    alert(`Opening "${item.name}"`);
  };

  const handleEditSubmit = () => {
    if (editValue.trim()) {
      alert(`Renamed to "${editValue}"`);
      setIsEditing(false);
      setEditingItem(null);
      setEditValue('');
    }
  };

  const handleEditCancel = () => {
    setIsEditing(false);
    setEditingItem(null);
    setEditValue('');
  };

  const handleEditKeyDown = (e) => {
    if (e.key === 'Enter') {
      handleEditSubmit();
    } else if (e.key === 'Escape') {
      handleEditCancel();
    }
  };

  const handleBulkAction = (action) => {
    if (selectedItems.length === 0) {
      alert('Please select items first');
      return;
    }
    
    const itemNames = selectedItems.map(id => 
      fileItems.find(f => f.id === id).name
    ).join(', ');
    
    alert(`${action} action performed on: ${itemNames}`);
  };

  const getFileIcon = (type) => {
    const icons = {
      document: '📄',
      spreadsheet: '📊',
      image: '🖼️',
      presentation: '📽️',
      database: '🗄️'
    };
    return icons[type] || '📁';
  };

  const getStatusColor = (status) => {
    const colors = {
      active: '#28a745',
      draft: '#ffc107',
      archived: '#6c757d'
    };
    return colors[status] || '#6c757d';
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString();
  };

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (contextMenu.visible && !e.target.closest('.context-menu')) {
        setContextMenu({ visible: false, x: 0, y: 0, itemId: null });
      }
    };

    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        setContextMenu({ visible: false, x: 0, y: 0, itemId: null });
        if (isEditing) {
          handleEditCancel();
        }
      }
    };

    document.addEventListener('click', handleClickOutside);
    document.addEventListener('keydown', handleKeyDown);

    return () => {
      document.removeEventListener('click', handleClickOutside);
      document.removeEventListener('keydown', handleKeyDown);
    };
  }, [contextMenu.visible, isEditing]);

  useEffect(() => {
    if (isEditing && editInputRef.current) {
      editInputRef.current.focus();
      editInputRef.current.select();
    }
  }, [isEditing]);

  return (
    <div className="file-manager">
      <header className="manager-header">
        <h1>File Manager</h1>
        <p>Manage your files and documents</p>
      </header>

      <div className="manager-controls">
        <div className="view-controls">
          <button className="view-btn active">List View</button>
          <button className="view-btn">Grid View</button>
        </div>

        <div className="filter-controls">
          <select 
            value={filterBy} 
            onChange={(e) => setFilterBy(e.target.value)}
            className="filter-select"
          >
            <option value="all">All Files</option>
            <option value="active">Active</option>
            <option value="draft">Draft</option>
            <option value="archived">Archived</option>
          </select>

          <select 
            value={sortBy} 
            onChange={(e) => setSortBy(e.target.value)}
            className="sort-select"
          >
            <option value="name">Sort by Name</option>
            <option value="size">Sort by Size</option>
            <option value="modified">Sort by Modified</option>
            <option value="type">Sort by Type</option>
          </select>
        </div>

        <div className="bulk-actions">
          <button 
            className="action-btn"
            onClick={() => handleBulkAction('Download')}
            disabled={selectedItems.length === 0}
          >
            Download Selected
          </button>
          <button 
            className="action-btn"
            onClick={() => handleBulkAction('Archive')}
            disabled={selectedItems.length === 0}
          >
            Archive Selected
          </button>
          <button 
            className="action-btn danger"
            onClick={() => handleBulkAction('Delete')}
            disabled={selectedItems.length === 0}
          >
            Delete Selected
          </button>
        </div>
      </div>

      <div className="file-list" ref={fileListRef}>
        <div className="list-header">
          <div className="list-checkbox">
            <input
              type="checkbox"
              checked={selectedItems.length === sortedItems.length && sortedItems.length > 0}
              onChange={(e) => {
                if (e.target.checked) {
                  setSelectedItems(sortedItems.map(item => item.id));
                } else {
                  setSelectedItems([]);
                }
              }}
            />
          </div>
          <div className="list-name">Name</div>
          <div className="list-type">Type</div>
          <div className="list-size">Size</div>
          <div className="list-modified">Modified</div>
          <div className="list-status">Status</div>
        </div>

        {sortedItems.map(item => (
          <div 
            key={item.id} 
            className={`list-item ${selectedItems.includes(item.id) ? 'selected' : ''}`}
            onClick={() => handleItemClick(item.id)}
            onDoubleClick={() => handleItemDoubleClick(item.id)}
            onContextMenu={(e) => handleContextMenu(e, item.id)}
          >
            <div className="list-checkbox">
              <input
                type="checkbox"
                checked={selectedItems.includes(item.id)}
                onChange={() => handleItemClick(item.id)}
                onClick={(e) => e.stopPropagation()}
              />
            </div>
            <div className="list-name">
              {isEditing && editingItem === item.id ? (
                <input
                  ref={editInputRef}
                  type="text"
                  value={editValue}
                  onChange={(e) => setEditValue(e.target.value)}
                  onBlur={handleEditSubmit}
                  onKeyDown={handleEditKeyDown}
                  className="edit-input"
                />
              ) : (
                <div className="file-name">
                  <span className="file-icon">{getFileIcon(item.type)}</span>
                  <span className="file-text">{item.name}</span>
                </div>
              )}
            </div>
            <div className="list-type">{item.type}</div>
            <div className="list-size">{item.size}</div>
            <div className="list-modified">{formatDate(item.modified)}</div>
            <div className="list-status">
              <span 
                className="status-badge"
                style={{ backgroundColor: getStatusColor(item.status) }}
              >
                {item.status}
              </span>
            </div>
          </div>
        ))}
      </div>

      {contextMenu.visible && (
        <div 
          className="context-menu"
          style={{
            position: 'fixed',
            left: contextMenu.x,
            top: contextMenu.y,
            zIndex: 1000
          }}
        >
          <div className="context-menu-item" onClick={() => handleContextMenuAction('rename', contextMenu.itemId)}>
            <span className="context-icon">✏️</span>
            Rename
          </div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('copy', contextMenu.itemId)}>
            <span className="context-icon">📋</span>
            Copy
          </div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('cut', contextMenu.itemId)}>
            <span className="context-icon">✂️</span>
            Cut
          </div>
          <div className="context-menu-divider"></div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('download', contextMenu.itemId)}>
            <span className="context-icon">⬇️</span>
            Download
          </div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('share', contextMenu.itemId)}>
            <span className="context-icon">🔗</span>
            Share
          </div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('archive', contextMenu.itemId)}>
            <span className="context-icon">📦</span>
            Archive
          </div>
          <div className="context-menu-divider"></div>
          <div className="context-menu-item" onClick={() => handleContextMenuAction('properties', contextMenu.itemId)}>
            <span className="context-icon">ℹ️</span>
            Properties
          </div>
          <div className="context-menu-item danger" onClick={() => handleContextMenuAction('delete', contextMenu.itemId)}>
            <span className="context-icon">🗑️</span>
            Delete
          </div>
        </div>
      )}

      <div className="help-section">
        <h3>How to Use</h3>
        <div className="help-items">
          <div className="help-item">
            <span className="help-icon">🖱️</span>
            <span className="help-text">Right-click on any file to access context menu</span>
          </div>
          <div className="help-item">
            <span className="help-icon">⌨️</span>
            <span className="help-text">Use keyboard shortcuts for quick actions</span>
          </div>
          <div className="help-item">
            <span className="help-icon">📁</span>
            <span className="help-text">Double-click to open files</span>
          </div>
        </div>
      </div>

      <style jsx>{`
        .file-manager {
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .manager-header {
          text-align: center;
          margin-bottom: 30px;
        }

        .manager-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .manager-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .manager-controls {
          display: flex;
          flex-wrap: wrap;
          gap: 20px;
          align-items: center;
          justify-content: space-between;
          margin-bottom: 20px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .view-controls {
          display: flex;
          gap: 5px;
        }

        .view-btn {
          padding: 8px 16px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .view-btn.active {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .view-btn:hover:not(.active) {
          border-color: #007bff;
          color: #007bff;
        }

        .filter-controls {
          display: flex;
          gap: 10px;
        }

        .filter-select,
        .sort-select {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
          cursor: pointer;
        }

        .bulk-actions {
          display: flex;
          gap: 10px;
        }

        .action-btn {
          padding: 8px 16px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn:hover:not(:disabled) {
          background: #f8f9fa;
          border-color: #007bff;
          color: #007bff;
        }

        .action-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .action-btn.danger {
          background: #dc3545;
          color: white;
          border-color: #dc3545;
        }

        .action-btn.danger:hover:not(:disabled) {
          background: #c82333;
        }

        .file-list {
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          overflow: hidden;
        }

        .list-header {
          display: grid;
          grid-template-columns: 40px 1fr 100px 100px 120px 100px;
          gap: 15px;
          padding: 15px 20px;
          background: #f8f9fa;
          font-weight: bold;
          font-size: 14px;
          color: #333;
          border-bottom: 2px solid #dee2e6;
        }

        .list-item {
          display: grid;
          grid-template-columns: 40px 1fr 100px 100px 120px 100px;
          gap: 15px;
          padding: 15px 20px;
          border-bottom: 1px solid #eee;
          align-items: center;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .list-item:hover {
          background: #f8f9fa;
        }

        .list-item.selected {
          background: #e3f2fd;
        }

        .list-item:last-child {
          border-bottom: none;
        }

        .list-checkbox input {
          width: 16px;
          height: 16px;
        }

        .file-name {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .file-icon {
          font-size: 16px;
        }

        .file-text {
          font-weight: bold;
          color: #333;
        }

        .edit-input {
          width: 100%;
          padding: 4px 8px;
          border: 2px solid #007bff;
          border-radius: 4px;
          font-size: 14px;
          font-weight: bold;
        }

        .status-badge {
          padding: 4px 8px;
          border-radius: 12px;
          color: white;
          font-size: 11px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .context-menu {
          background: white;
          border: 1px solid #ddd;
          border-radius: 6px;
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
          padding: 5px 0;
          min-width: 180px;
        }

        .context-menu-item {
          display: flex;
          align-items: center;
          gap: 10px;
          padding: 8px 15px;
          cursor: pointer;
          font-size: 14px;
          transition: background-color 0.2s ease;
        }

        .context-menu-item:hover {
          background: #f8f9fa;
        }

        .context-menu-item.danger {
          color: #dc3545;
        }

        .context-menu-item.danger:hover {
          background: #f8d7da;
        }

        .context-icon {
          font-size: 14px;
          width: 16px;
          text-align: center;
        }

        .context-menu-divider {
          height: 1px;
          background: #eee;
          margin: 5px 0;
        }

        .help-section {
          margin-top: 30px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
          border-left: 4px solid #007bff;
        }

        .help-section h3 {
          margin: 0 0 15px 0;
          font-size: 18px;
          color: #333;
        }

        .help-items {
          display: flex;
          flex-direction: column;
          gap: 10px;
        }

        .help-item {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .help-icon {
          font-size: 16px;
        }

        .help-text {
          font-size: 14px;
          color: #666;
        }

        @media (max-width: 768px) {
          .manager-controls {
            flex-direction: column;
            align-items: stretch;
          }

          .bulk-actions {
            flex-wrap: wrap;
            justify-content: center;
          }

          .list-header,
          .list-item {
            grid-template-columns: 30px 1fr 80px 80px 100px 80px;
            gap: 10px;
            padding: 10px 15px;
          }

          .context-menu {
            min-width: 160px;
          }
        }
      `}</style>
    </div>
  );
}

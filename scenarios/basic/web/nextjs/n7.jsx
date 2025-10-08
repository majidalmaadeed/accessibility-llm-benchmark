import { useState } from 'react';

export default function InsufficientButtonSpacing() {
  const [selectedItems, setSelectedItems] = useState([]);
  const [isProcessing, setIsProcessing] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [currentView, setCurrentView] = useState('grid');
  const [sortBy, setSortBy] = useState('name');
  const [filterBy, setFilterBy] = useState('all');

  const items = [
    { id: 1, name: 'Document 1', type: 'PDF', size: '2.4 MB', date: '2024-01-15', status: 'active' },
    { id: 2, name: 'Image File', type: 'JPG', size: '1.8 MB', date: '2024-01-14', status: 'archived' },
    { id: 3, name: 'Spreadsheet', type: 'XLSX', size: '3.2 MB', date: '2024-01-13', status: 'active' },
    { id: 4, name: 'Presentation', type: 'PPTX', size: '4.1 MB', date: '2024-01-12', status: 'draft' },
    { id: 5, name: 'Text Document', type: 'DOCX', size: '1.5 MB', date: '2024-01-11', status: 'active' },
    { id: 6, name: 'Video File', type: 'MP4', size: '15.2 MB', date: '2024-01-10', status: 'archived' },
    { id: 7, name: 'Audio File', type: 'MP3', size: '5.3 MB', date: '2024-01-09', status: 'active' },
    { id: 8, name: 'Archive File', type: 'ZIP', size: '8.7 MB', date: '2024-01-08', status: 'draft' }
  ];

  const filteredItems = items.filter(item => {
    if (filterBy === 'all') return true;
    return item.status === filterBy;
  });

  const sortedItems = [...filteredItems].sort((a, b) => {
    switch(sortBy) {
      case 'name':
        return a.name.localeCompare(b.name);
      case 'size':
        return parseFloat(b.size) - parseFloat(a.size);
      case 'date':
        return new Date(b.date) - new Date(a.date);
      case 'type':
        return a.type.localeCompare(b.type);
      default:
        return 0;
    }
  });

  const handleSelectItem = (itemId) => {
    setSelectedItems(prev => 
      prev.includes(itemId) 
        ? prev.filter(id => id !== itemId)
        : [...prev, itemId]
    );
  };

  const handleSelectAll = () => {
    if (selectedItems.length === sortedItems.length) {
      setSelectedItems([]);
    } else {
      setSelectedItems(sortedItems.map(item => item.id));
    }
  };

  const handleAction = async (action) => {
    if (selectedItems.length === 0) {
      alert('Please select items first');
      return;
    }

    setIsProcessing(true);
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      alert(`${action} action completed for ${selectedItems.length} items`);
      setSelectedItems([]);
    } catch (error) {
      alert(`Error performing ${action} action`);
    } finally {
      setIsProcessing(false);
    }
  };

  const handleDownload = (item) => {
    alert(`Downloading ${item.name}`);
  };

  const handleEdit = (item) => {
    alert(`Editing ${item.name}`);
  };

  const handleDelete = (item) => {
    if (confirm(`Are you sure you want to delete ${item.name}?`)) {
      alert(`Deleted ${item.name}`);
    }
  };

  const handleShare = (item) => {
    setShowModal(true);
  };

  const handleViewChange = (view) => {
    setCurrentView(view);
  };

  const formatFileSize = (size) => {
    return size;
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString();
  };

  const getStatusColor = (status) => {
    const colors = {
      active: '#28a745',
      draft: '#ffc107',
      archived: '#6c757d'
    };
    return colors[status] || '#6c757d';
  };

  return (
    <div className="file-manager">
      <header className="manager-header">
        <h1>File Manager</h1>
        <p>Manage your files and documents</p>
      </header>

      <div className="manager-controls">
        <div className="view-controls">
          <button 
            className={`view-btn ${currentView === 'grid' ? 'active' : ''}`}
            onClick={() => handleViewChange('grid')}
          >
            Grid
          </button>
          <button 
            className={`view-btn ${currentView === 'list' ? 'active' : ''}`}
            onClick={() => handleViewChange('list')}
          >
            List
          </button>
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
            <option value="date">Sort by Date</option>
            <option value="type">Sort by Type</option>
          </select>
        </div>

        <div className="bulk-actions">
          <button 
            className="action-btn select-all"
            onClick={handleSelectAll}
          >
            {selectedItems.length === sortedItems.length ? 'Deselect All' : 'Select All'}
          </button>
          
          <button 
            className="action-btn download"
            onClick={() => handleAction('Download')}
            disabled={selectedItems.length === 0 || isProcessing}
          >
            Download
          </button>
          
          <button 
            className="action-btn share"
            onClick={() => handleAction('Share')}
            disabled={selectedItems.length === 0 || isProcessing}
          >
            Share
          </button>
          
          <button 
            className="action-btn archive"
            onClick={() => handleAction('Archive')}
            disabled={selectedItems.length === 0 || isProcessing}
          >
            Archive
          </button>
          
          <button 
            className="action-btn delete"
            onClick={() => handleAction('Delete')}
            disabled={selectedItems.length === 0 || isProcessing}
          >
            Delete
          </button>
        </div>
      </div>

      <div className="files-container">
        {currentView === 'grid' ? (
          <div className="files-grid">
            {sortedItems.map(item => (
              <div key={item.id} className="file-card">
                <div className="file-header">
                  <input
                    type="checkbox"
                    checked={selectedItems.includes(item.id)}
                    onChange={() => handleSelectItem(item.id)}
                    className="file-checkbox"
                  />
                  <div className="file-type">{item.type}</div>
                </div>

                <div className="file-content">
                  <h4 className="file-name">{item.name}</h4>
                  <p className="file-size">{formatFileSize(item.size)}</p>
                  <p className="file-date">{formatDate(item.date)}</p>
                  <div 
                    className="file-status"
                    style={{ color: getStatusColor(item.status) }}
                  >
                    {item.status}
                  </div>
                </div>

                <div className="file-actions">
                  <button 
                    className="action-btn download"
                    onClick={() => handleDownload(item)}
                    title="Download"
                  >
                    ⬇️
                  </button>
                  <button 
                    className="action-btn edit"
                    onClick={() => handleEdit(item)}
                    title="Edit"
                  >
                    ✏️
                  </button>
                  <button 
                    className="action-btn share"
                    onClick={() => handleShare(item)}
                    title="Share"
                  >
                    🔗
                  </button>
                  <button 
                    className="action-btn delete"
                    onClick={() => handleDelete(item)}
                    title="Delete"
                  >
                    🗑️
                  </button>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="files-list">
            <div className="list-header">
              <div className="list-checkbox">
                <input
                  type="checkbox"
                  checked={selectedItems.length === sortedItems.length && sortedItems.length > 0}
                  onChange={handleSelectAll}
                />
              </div>
              <div className="list-name">Name</div>
              <div className="list-type">Type</div>
              <div className="list-size">Size</div>
              <div className="list-date">Date</div>
              <div className="list-status">Status</div>
              <div className="list-actions">Actions</div>
            </div>

            {sortedItems.map(item => (
              <div key={item.id} className="list-item">
                <div className="list-checkbox">
                  <input
                    type="checkbox"
                    checked={selectedItems.includes(item.id)}
                    onChange={() => handleSelectItem(item.id)}
                  />
                </div>
                <div className="list-name">
                  <span className="file-name">{item.name}</span>
                </div>
                <div className="list-type">{item.type}</div>
                <div className="list-size">{formatFileSize(item.size)}</div>
                <div className="list-date">{formatDate(item.date)}</div>
                <div 
                  className="list-status"
                  style={{ color: getStatusColor(item.status) }}
                >
                  {item.status}
                </div>
                <div className="list-actions">
                  <button 
                    className="action-btn download"
                    onClick={() => handleDownload(item)}
                    title="Download"
                  >
                    ⬇️
                  </button>
                  <button 
                    className="action-btn edit"
                    onClick={() => handleEdit(item)}
                    title="Edit"
                  >
                    ✏️
                  </button>
                  <button 
                    className="action-btn share"
                    onClick={() => handleShare(item)}
                    title="Share"
                  >
                    🔗
                  </button>
                  <button 
                    className="action-btn delete"
                    onClick={() => handleDelete(item)}
                    title="Delete"
                  >
                    🗑️
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {showModal && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">
              <h3>Share Files</h3>
              <button 
                className="modal-close"
                onClick={() => setShowModal(false)}
              >
                ✕
              </button>
            </div>
            <div className="modal-body">
              <p>Share {selectedItems.length} selected files</p>
              <div className="share-options">
                <button className="share-btn email">Email</button>
                <button className="share-btn link">Copy Link</button>
                <button className="share-btn social">Social Media</button>
              </div>
            </div>
          </div>
        </div>
      )}

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
          gap: 15px;
          align-items: center;
          justify-content: space-between;
          margin-bottom: 30px;
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
          gap: 2px;
        }

        .action-btn {
          padding: 8px 12px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
          transition: all 0.2s ease;
          white-space: nowrap;
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

        .action-btn.download {
          background: #28a745;
          color: white;
          border-color: #28a745;
        }

        .action-btn.download:hover:not(:disabled) {
          background: #218838;
        }

        .action-btn.share {
          background: #17a2b8;
          color: white;
          border-color: #17a2b8;
        }

        .action-btn.share:hover:not(:disabled) {
          background: #138496;
        }

        .action-btn.archive {
          background: #ffc107;
          color: #212529;
          border-color: #ffc107;
        }

        .action-btn.archive:hover:not(:disabled) {
          background: #e0a800;
        }

        .action-btn.delete {
          background: #dc3545;
          color: white;
          border-color: #dc3545;
        }

        .action-btn.delete:hover:not(:disabled) {
          background: #c82333;
        }

        .files-container {
          margin-bottom: 30px;
        }

        .files-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
          gap: 20px;
        }

        .file-card {
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          padding: 15px;
          transition: all 0.2s ease;
        }

        .file-card:hover {
          box-shadow: 0 4px 8px rgba(0,0,0,0.1);
          transform: translateY(-2px);
        }

        .file-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
        }

        .file-checkbox {
          width: 16px;
          height: 16px;
        }

        .file-type {
          background: #e9ecef;
          color: #495057;
          padding: 2px 6px;
          border-radius: 3px;
          font-size: 10px;
          font-weight: bold;
        }

        .file-content {
          margin-bottom: 15px;
        }

        .file-name {
          margin: 0 0 5px 0;
          font-size: 14px;
          font-weight: bold;
          color: #333;
        }

        .file-size,
        .file-date {
          margin: 0 0 3px 0;
          font-size: 12px;
          color: #666;
        }

        .file-status {
          font-size: 11px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .file-actions {
          display: flex;
          gap: 2px;
        }

        .files-list {
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          overflow: hidden;
        }

        .list-header {
          display: grid;
          grid-template-columns: 40px 1fr 80px 80px 100px 100px 120px;
          gap: 15px;
          padding: 15px;
          background: #f8f9fa;
          font-weight: bold;
          font-size: 12px;
          color: #666;
          border-bottom: 1px solid #ddd;
        }

        .list-item {
          display: grid;
          grid-template-columns: 40px 1fr 80px 80px 100px 100px 120px;
          gap: 15px;
          padding: 15px;
          border-bottom: 1px solid #eee;
          align-items: center;
          transition: background-color 0.2s ease;
        }

        .list-item:hover {
          background: #f8f9fa;
        }

        .list-item:last-child {
          border-bottom: none;
        }

        .list-checkbox input {
          width: 16px;
          height: 16px;
        }

        .list-name .file-name {
          font-weight: bold;
          color: #333;
        }

        .list-actions {
          display: flex;
          gap: 2px;
        }

        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0,0,0,0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 1000;
        }

        .modal-content {
          background: white;
          border-radius: 8px;
          max-width: 400px;
          width: 90%;
        }

        .modal-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 20px;
          border-bottom: 1px solid #ddd;
        }

        .modal-header h3 {
          margin: 0;
          font-size: 18px;
        }

        .modal-close {
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
          color: #666;
        }

        .modal-body {
          padding: 20px;
        }

        .share-options {
          display: flex;
          gap: 10px;
          margin-top: 15px;
        }

        .share-btn {
          padding: 8px 16px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }

        .share-btn:hover {
          background: #f8f9fa;
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

          .files-grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
          }

          .list-header,
          .list-item {
            grid-template-columns: 30px 1fr 60px 60px 80px 80px 100px;
            gap: 10px;
            padding: 10px;
          }

          .action-btn {
            padding: 6px 8px;
            font-size: 10px;
          }
        }
      `}</style>
    </div>
  );
}

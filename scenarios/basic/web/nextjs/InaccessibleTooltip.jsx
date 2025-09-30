import { useState } from 'react';

export default function InaccessibleTooltip() {
  const [selectedItems, setSelectedItems] = useState([]);
  const [showAdvancedOptions, setShowAdvancedOptions] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [sortBy, setSortBy] = useState('name');
  const [filterBy, setFilterBy] = useState('all');

  const dataItems = [
    { id: 1, name: 'Project Alpha', status: 'active', priority: 'high', progress: 75, deadline: '2024-02-15' },
    { id: 2, name: 'Project Beta', status: 'pending', priority: 'medium', progress: 45, deadline: '2024-03-20' },
    { id: 3, name: 'Project Gamma', status: 'completed', priority: 'low', progress: 100, deadline: '2024-01-30' },
    { id: 4, name: 'Project Delta', status: 'active', priority: 'high', progress: 60, deadline: '2024-02-28' },
    { id: 5, name: 'Project Epsilon', status: 'paused', priority: 'medium', progress: 30, deadline: '2024-04-10' },
    { id: 6, name: 'Project Zeta', status: 'active', priority: 'low', progress: 90, deadline: '2024-02-05' }
  ];

  const filteredItems = dataItems.filter(item => {
    if (filterBy === 'all') return true;
    return item.status === filterBy;
  });

  const sortedItems = [...filteredItems].sort((a, b) => {
    switch(sortBy) {
      case 'name':
        return a.name.localeCompare(b.name);
      case 'status':
        return a.status.localeCompare(b.status);
      case 'priority':
        const priorityOrder = { high: 3, medium: 2, low: 1 };
        return priorityOrder[b.priority] - priorityOrder[a.priority];
      case 'progress':
        return b.progress - a.progress;
      case 'deadline':
        return new Date(a.deadline) - new Date(b.deadline);
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

  const handleAction = (action, itemId = null) => {
    const targetItems = itemId ? [itemId] : selectedItems;
    if (targetItems.length === 0) {
      alert('Please select items first');
      return;
    }
    alert(`${action} action performed on ${targetItems.length} item(s)`);
  };

  const getStatusColor = (status) => {
    const colors = {
      active: '#28a745',
      pending: '#ffc107',
      completed: '#6c757d',
      paused: '#dc3545'
    };
    return colors[status] || '#6c757d';
  };

  const getPriorityColor = (priority) => {
    const colors = {
      high: '#dc3545',
      medium: '#ffc107',
      low: '#28a745'
    };
    return colors[priority] || '#6c757d';
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString();
  };

  return (
    <div className="data-management">
      <header className="management-header">
        <h1>Project Management Dashboard</h1>
        <p>Manage and monitor your projects efficiently</p>
      </header>

      <div className="management-controls">
        <div className="control-group">
          <label className="control-label">Filter by Status:</label>
          <select 
            value={filterBy} 
            onChange={(e) => setFilterBy(e.target.value)}
            className="control-select"
          >
            <option value="all">All Projects</option>
            <option value="active">Active</option>
            <option value="pending">Pending</option>
            <option value="completed">Completed</option>
            <option value="paused">Paused</option>
          </select>
        </div>

        <div className="control-group">
          <label className="control-label">Sort by:</label>
          <select 
            value={sortBy} 
            onChange={(e) => setSortBy(e.target.value)}
            className="control-select"
          >
            <option value="name">Name</option>
            <option value="status">Status</option>
            <option value="priority">Priority</option>
            <option value="progress">Progress</option>
            <option value="deadline">Deadline</option>
          </select>
        </div>

        <div className="control-group">
          <button 
            className="control-btn"
            onClick={() => setShowAdvancedOptions(!showAdvancedOptions)}
          >
            Advanced Options
          </button>
        </div>
      </div>

      {showAdvancedOptions && (
        <div className="advanced-options">
          <h3>Advanced Filtering Options</h3>
          <div className="options-grid">
            <div className="option-group">
              <label>Priority Level:</label>
              <div className="checkbox-group">
                <label><input type="checkbox" defaultChecked /> High</label>
                <label><input type="checkbox" defaultChecked /> Medium</label>
                <label><input type="checkbox" defaultChecked /> Low</label>
              </div>
            </div>
            <div className="option-group">
              <label>Progress Range:</label>
              <div className="range-group">
                <input type="range" min="0" max="100" defaultValue="0" />
                <span>0% - 100%</span>
              </div>
            </div>
            <div className="option-group">
              <label>Date Range:</label>
              <div className="date-group">
                <input type="date" />
                <span>to</span>
                <input type="date" />
              </div>
            </div>
          </div>
        </div>
      )}

      <div className="bulk-actions">
        <div className="selection-info">
          <span>{selectedItems.length} of {sortedItems.length} items selected</span>
          <button 
            className="select-all-btn"
            onClick={handleSelectAll}
          >
            {selectedItems.length === sortedItems.length ? 'Deselect All' : 'Select All'}
          </button>
        </div>

        <div className="action-buttons">
          <button 
            className="action-btn primary"
            onClick={() => handleAction('Export')}
            disabled={selectedItems.length === 0}
          >
            Export Selected
          </button>
          <button 
            className="action-btn secondary"
            onClick={() => handleAction('Archive')}
            disabled={selectedItems.length === 0}
          >
            Archive
          </button>
          <button 
            className="action-btn danger"
            onClick={() => handleAction('Delete')}
            disabled={selectedItems.length === 0}
          >
            Delete
          </button>
        </div>
      </div>

      <div className="data-table">
        <div className="table-header">
          <div className="table-cell checkbox-cell">
            <input
              type="checkbox"
              checked={selectedItems.length === sortedItems.length && sortedItems.length > 0}
              onChange={handleSelectAll}
            />
          </div>
          <div className="table-cell name-cell">Project Name</div>
          <div className="table-cell status-cell">Status</div>
          <div className="table-cell priority-cell">Priority</div>
          <div className="table-cell progress-cell">Progress</div>
          <div className="table-cell deadline-cell">Deadline</div>
          <div className="table-cell actions-cell">Actions</div>
        </div>

        {sortedItems.map(item => (
          <div key={item.id} className="table-row">
            <div className="table-cell checkbox-cell">
              <input
                type="checkbox"
                checked={selectedItems.includes(item.id)}
                onChange={() => handleSelectItem(item.id)}
              />
            </div>
            <div className="table-cell name-cell">
              <span className="item-name">{item.name}</span>
            </div>
            <div className="table-cell status-cell">
              <span 
                className="status-badge"
                style={{ backgroundColor: getStatusColor(item.status) }}
              >
                {item.status}
              </span>
            </div>
            <div className="table-cell priority-cell">
              <span 
                className="priority-badge"
                style={{ backgroundColor: getPriorityColor(item.priority) }}
              >
                {item.priority}
              </span>
            </div>
            <div className="table-cell progress-cell">
              <div className="progress-container">
                <div className="progress-bar">
                  <div 
                    className="progress-fill"
                    style={{ width: `${item.progress}%` }}
                  ></div>
                </div>
                <span className="progress-text">{item.progress}%</span>
              </div>
            </div>
            <div className="table-cell deadline-cell">
              <span className="deadline-text">{formatDate(item.deadline)}</span>
            </div>
            <div className="table-cell actions-cell">
              <div className="action-buttons">
                <button 
                  className="action-icon-btn"
                  onClick={() => handleAction('View', item.id)}
                  title="View Details"
                >
                  👁️
                </button>
                <button 
                  className="action-icon-btn"
                  onClick={() => handleAction('Edit', item.id)}
                  title="Edit Project"
                >
                  ✏️
                </button>
                <button 
                  className="action-icon-btn"
                  onClick={() => handleAction('Duplicate', item.id)}
                  title="Duplicate Project"
                >
                  📋
                </button>
                <button 
                  className="action-icon-btn"
                  onClick={() => handleAction('Share', item.id)}
                  title="Share Project"
                >
                  🔗
                </button>
                <button 
                  className="action-icon-btn danger"
                  onClick={() => handleAction('Delete', item.id)}
                  title="Delete Project"
                >
                  🗑️
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="pagination">
        <button 
          className="page-btn"
          onClick={() => setCurrentPage(Math.max(1, currentPage - 1))}
          disabled={currentPage === 1}
        >
          Previous
        </button>
        
        <div className="page-numbers">
          {Array(3).fill(0).map((_, i) => (
            <button
              key={i}
              className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
              onClick={() => setCurrentPage(i + 1)}
            >
              {i + 1}
            </button>
          ))}
        </div>
        
        <button 
          className="page-btn"
          onClick={() => setCurrentPage(Math.min(3, currentPage + 1))}
          disabled={currentPage === 3}
        >
          Next
        </button>
      </div>

      <div className="help-section">
        <h3>Quick Help</h3>
        <div className="help-items">
          <div className="help-item">
            <span className="help-icon">ℹ️</span>
            <span className="help-text">Hover over action buttons to see what they do</span>
          </div>
          <div className="help-item">
            <span className="help-icon">💡</span>
            <span className="help-text">Use filters to narrow down your project list</span>
          </div>
          <div className="help-item">
            <span className="help-icon">⚡</span>
            <span className="help-text">Select multiple items to perform bulk actions</span>
          </div>
        </div>
      </div>

      <style jsx>{`
        .data-management {
          max-width: 1400px;
          margin: 0 auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .management-header {
          text-align: center;
          margin-bottom: 30px;
        }

        .management-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .management-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .management-controls {
          display: flex;
          flex-wrap: wrap;
          gap: 20px;
          align-items: center;
          margin-bottom: 20px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .control-group {
          display: flex;
          flex-direction: column;
          gap: 5px;
        }

        .control-label {
          font-size: 14px;
          font-weight: bold;
          color: #333;
        }

        .control-select {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
          cursor: pointer;
        }

        .control-btn {
          padding: 8px 16px;
          background: #007bff;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
          transition: background-color 0.2s ease;
        }

        .control-btn:hover {
          background: #0056b3;
        }

        .advanced-options {
          background: white;
          padding: 20px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
          margin-bottom: 20px;
        }

        .advanced-options h3 {
          margin: 0 0 20px 0;
          font-size: 18px;
          color: #333;
        }

        .options-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 20px;
        }

        .option-group {
          display: flex;
          flex-direction: column;
          gap: 10px;
        }

        .option-group label {
          font-weight: bold;
          color: #333;
        }

        .checkbox-group {
          display: flex;
          flex-direction: column;
          gap: 5px;
        }

        .checkbox-group label {
          display: flex;
          align-items: center;
          gap: 5px;
          font-weight: normal;
        }

        .range-group {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .date-group {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .bulk-actions {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
          padding: 15px 20px;
          background: #e3f2fd;
          border-radius: 8px;
        }

        .selection-info {
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .select-all-btn {
          padding: 6px 12px;
          background: #6c757d;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 12px;
          font-weight: bold;
        }

        .select-all-btn:hover {
          background: #545b62;
        }

        .action-buttons {
          display: flex;
          gap: 10px;
        }

        .action-btn {
          padding: 8px 16px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
        }

        .action-btn.primary:hover:not(:disabled) {
          background: #0056b3;
        }

        .action-btn.secondary {
          background: #6c757d;
          color: white;
        }

        .action-btn.secondary:hover:not(:disabled) {
          background: #545b62;
        }

        .action-btn.danger {
          background: #dc3545;
          color: white;
        }

        .action-btn.danger:hover:not(:disabled) {
          background: #c82333;
        }

        .data-table {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
          overflow: hidden;
          margin-bottom: 20px;
        }

        .table-header {
          display: grid;
          grid-template-columns: 50px 1fr 100px 100px 150px 120px 200px;
          gap: 15px;
          padding: 15px 20px;
          background: #f8f9fa;
          font-weight: bold;
          font-size: 14px;
          color: #333;
          border-bottom: 2px solid #dee2e6;
        }

        .table-row {
          display: grid;
          grid-template-columns: 50px 1fr 100px 100px 150px 120px 200px;
          gap: 15px;
          padding: 15px 20px;
          border-bottom: 1px solid #dee2e6;
          align-items: center;
          transition: background-color 0.2s ease;
        }

        .table-row:hover {
          background: #f8f9fa;
        }

        .table-row:last-child {
          border-bottom: none;
        }

        .table-cell {
          display: flex;
          align-items: center;
        }

        .checkbox-cell input {
          width: 16px;
          height: 16px;
        }

        .item-name {
          font-weight: bold;
          color: #333;
        }

        .status-badge,
        .priority-badge {
          padding: 4px 8px;
          border-radius: 12px;
          color: white;
          font-size: 11px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .progress-container {
          display: flex;
          align-items: center;
          gap: 10px;
          width: 100%;
        }

        .progress-bar {
          flex: 1;
          height: 8px;
          background: #e9ecef;
          border-radius: 4px;
          overflow: hidden;
        }

        .progress-fill {
          height: 100%;
          background: #007bff;
          transition: width 0.3s ease;
        }

        .progress-text {
          font-size: 12px;
          font-weight: bold;
          color: #666;
          min-width: 35px;
        }

        .deadline-text {
          font-size: 12px;
          color: #666;
        }

        .action-buttons {
          display: flex;
          gap: 5px;
        }

        .action-icon-btn {
          width: 32px;
          height: 32px;
          border: 1px solid #ddd;
          background: white;
          border-radius: 4px;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 14px;
          transition: all 0.2s ease;
        }

        .action-icon-btn:hover {
          background: #f8f9fa;
          border-color: #007bff;
        }

        .action-icon-btn.danger:hover {
          background: #f8d7da;
          border-color: #dc3545;
        }

        .pagination {
          display: flex;
          justify-content: center;
          align-items: center;
          gap: 10px;
          margin-bottom: 30px;
        }

        .page-btn {
          padding: 8px 12px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .page-btn:hover:not(:disabled) {
          border-color: #007bff;
          color: #007bff;
        }

        .page-btn.active {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .page-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .page-numbers {
          display: flex;
          gap: 5px;
        }

        .help-section {
          background: #f8f9fa;
          padding: 20px;
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
          .management-controls {
            flex-direction: column;
            align-items: stretch;
          }

          .bulk-actions {
            flex-direction: column;
            gap: 15px;
            align-items: stretch;
          }

          .action-buttons {
            justify-content: center;
          }

          .table-header,
          .table-row {
            grid-template-columns: 40px 1fr 80px 80px 120px 100px 150px;
            gap: 10px;
            padding: 10px 15px;
          }

          .action-buttons {
            flex-wrap: wrap;
          }

          .action-icon-btn {
            width: 28px;
            height: 28px;
            font-size: 12px;
          }
        }
      `}</style>
    </div>
  );
}

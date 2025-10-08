import { useState } from 'react';

export default function StatusByShapeOnly() {
  const [selectedFilter, setSelectedFilter] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState('date');
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 8;

  const filters = [
    { id: 'all', name: 'All Documents' },
    { id: 'pending', name: 'Pending Review' },
    { id: 'approved', name: 'Approved' },
    { id: 'rejected', name: 'Rejected' },
    { id: 'draft', name: 'Draft' }
  ];

  const documents = [
    {
      id: 1,
      title: 'Q4 Financial Report',
      type: 'Financial',
      status: 'approved',
      author: 'Sarah Johnson',
      createdDate: '2024-01-15',
      lastModified: '2024-01-16',
      version: '2.1',
      size: '2.4 MB',
      priority: 'high'
    },
    {
      id: 2,
      title: 'Marketing Strategy 2024',
      type: 'Marketing',
      status: 'pending',
      author: 'Mike Chen',
      createdDate: '2024-01-14',
      lastModified: '2024-01-15',
      version: '1.3',
      size: '1.8 MB',
      priority: 'medium'
    },
    {
      id: 3,
      title: 'Employee Handbook Update',
      type: 'HR',
      status: 'draft',
      author: 'Lisa Rodriguez',
      createdDate: '2024-01-13',
      lastModified: '2024-01-14',
      version: '0.8',
      size: '3.2 MB',
      priority: 'low'
    },
    {
      id: 4,
      title: 'Technical Specifications',
      type: 'Technical',
      status: 'rejected',
      author: 'David Kim',
      createdDate: '2024-01-12',
      lastModified: '2024-01-13',
      version: '1.0',
      size: '4.1 MB',
      priority: 'high'
    },
    {
      id: 5,
      title: 'Project Proposal Alpha',
      type: 'Project',
      status: 'approved',
      author: 'Emma Wilson',
      createdDate: '2024-01-11',
      lastModified: '2024-01-12',
      version: '3.0',
      size: '1.5 MB',
      priority: 'medium'
    },
    {
      id: 6,
      title: 'Legal Compliance Review',
      type: 'Legal',
      status: 'pending',
      author: 'Robert Brown',
      createdDate: '2024-01-10',
      lastModified: '2024-01-11',
      version: '1.2',
      size: '2.7 MB',
      priority: 'high'
    },
    {
      id: 7,
      title: 'User Research Findings',
      type: 'Research',
      status: 'draft',
      author: 'Anna Garcia',
      createdDate: '2024-01-09',
      lastModified: '2024-01-10',
      version: '0.5',
      size: '5.3 MB',
      priority: 'medium'
    },
    {
      id: 8,
      title: 'Budget Allocation Plan',
      type: 'Financial',
      status: 'approved',
      author: 'Tom Anderson',
      createdDate: '2024-01-08',
      lastModified: '2024-01-09',
      version: '2.0',
      size: '1.9 MB',
      priority: 'high'
    },
    {
      id: 9,
      title: 'Security Audit Report',
      type: 'Security',
      status: 'rejected',
      author: 'Jennifer Lee',
      createdDate: '2024-01-07',
      lastModified: '2024-01-08',
      version: '1.1',
      size: '3.8 MB',
      priority: 'high'
    },
    {
      id: 10,
      title: 'Product Roadmap 2024',
      type: 'Product',
      status: 'pending',
      author: 'Chris Taylor',
      createdDate: '2024-01-06',
      lastModified: '2024-01-07',
      version: '1.4',
      size: '2.2 MB',
      priority: 'medium'
    }
  ];

  const filteredDocuments = documents.filter(doc => {
    const matchesFilter = selectedFilter === 'all' || doc.status === selectedFilter;
    const matchesSearch = doc.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         doc.author.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         doc.type.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  const sortedDocuments = [...filteredDocuments].sort((a, b) => {
    switch(sortBy) {
      case 'title':
        return a.title.localeCompare(b.title);
      case 'author':
        return a.author.localeCompare(b.author);
      case 'type':
        return a.type.localeCompare(b.type);
      case 'size':
        return parseFloat(b.size) - parseFloat(a.size);
      case 'date':
      default:
        return new Date(b.lastModified) - new Date(a.lastModified);
    }
  });

  const totalPages = Math.ceil(sortedDocuments.length / itemsPerPage);
  const paginatedDocuments = sortedDocuments.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  const statusCounts = documents.reduce((counts, doc) => {
    counts[doc.status] = (counts[doc.status] || 0) + 1;
    return counts;
  }, {});

  const getStatusIcon = (status) => {
    const icons = {
      approved: '●',
      pending: '●',
      rejected: '●',
      draft: '●'
    };
    return icons[status] || '●';
  };

  const getStatusColor = (status) => {
    const colors = {
      approved: '#28a745',
      pending: '#ffc107',
      rejected: '#dc3545',
      draft: '#6c757d'
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
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  };

  const handleAction = (action, document) => {
    alert(`${action} action performed on "${document.title}"`);
  };

  const goToPage = (page) => {
    setCurrentPage(page);
  };

  const nextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const prevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <div className="document-management">
      <header className="management-header">
        <h1>Document Management System</h1>
        <p>Organize, track, and manage your documents efficiently</p>
      </header>

      <div className="management-controls">
        <div className="search-section">
          <input 
            type="text" 
            placeholder="Search documents, authors, or types..." 
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filter-section">
          <select 
            value={selectedFilter} 
            onChange={(e) => setSelectedFilter(e.target.value)}
            className="status-filter"
          >
            {filters.map(filter => (
              <option key={filter.id} value={filter.id}>
                {filter.name}
              </option>
            ))}
          </select>

          <select 
            value={sortBy} 
            onChange={(e) => setSortBy(e.target.value)}
            className="sort-filter"
          >
            <option value="date">Sort by Date</option>
            <option value="title">Sort by Title</option>
            <option value="author">Sort by Author</option>
            <option value="type">Sort by Type</option>
            <option value="size">Sort by Size</option>
          </select>
        </div>
      </div>

      <div className="status-overview">
        <div className="status-card approved">
          <div className="status-icon">●</div>
          <div className="status-content">
            <div className="status-count">{statusCounts.approved || 0}</div>
            <div className="status-label">Approved</div>
          </div>
        </div>

        <div className="status-card pending">
          <div className="status-icon">●</div>
          <div className="status-content">
            <div className="status-count">{statusCounts.pending || 0}</div>
            <div className="status-label">Pending</div>
          </div>
        </div>

        <div className="status-card rejected">
          <div className="status-icon">●</div>
          <div className="status-content">
            <div className="status-count">{statusCounts.rejected || 0}</div>
            <div className="status-label">Rejected</div>
          </div>
        </div>

        <div className="status-card draft">
          <div className="status-icon">●</div>
          <div className="status-content">
            <div className="status-count">{statusCounts.draft || 0}</div>
            <div className="status-label">Draft</div>
          </div>
        </div>
      </div>

      <div className="documents-container">
        <div className="documents-header">
          <h3>Documents ({sortedDocuments.length})</h3>
          <div className="view-options">
            <button className="view-btn active">Grid View</button>
            <button className="view-btn">List View</button>
          </div>
        </div>

        <div className="documents-grid">
          {paginatedDocuments.map(document => (
            <div key={document.id} className="document-card">
              <div className="document-header">
                <div className="document-type">{document.type}</div>
                <div 
                  className="document-priority" 
                  style={{ color: getPriorityColor(document.priority) }}
                >
                  {document.priority.toUpperCase()}
                </div>
              </div>

              <div className="document-content">
                <h4 className="document-title">{document.title}</h4>
                <p className="document-author">By {document.author}</p>
                <p className="document-version">Version {document.version}</p>
              </div>

              <div className="document-meta">
                <div className="meta-item">
                  <span className="meta-label">Size:</span>
                  <span className="meta-value">{document.size}</span>
                </div>
                <div className="meta-item">
                  <span className="meta-label">Modified:</span>
                  <span className="meta-value">{formatDate(document.lastModified)}</span>
                </div>
              </div>

              <div className="document-status">
                <div 
                  className="status-indicator" 
                  style={{ color: getStatusColor(document.status) }}
                >
                  {getStatusIcon(document.status)}
                </div>
                <span 
                  className="status-text" 
                  style={{ color: getStatusColor(document.status) }}
                >
                  {document.status.charAt(0).toUpperCase() + document.status.slice(1)}
                </span>
              </div>

              <div className="document-actions">
                <button 
                  className="action-btn primary" 
                  onClick={() => handleAction('View', document)}
                >
                  View
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Edit', document)}
                >
                  Edit
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Duplicate', document)}
                >
                  Duplicate
                </button>
                <button 
                  className="action-btn secondary" 
                  onClick={() => handleAction('Archive', document)}
                >
                  Archive
                </button>
                <button 
                  className="action-btn danger" 
                  onClick={() => handleAction('Delete', document)}
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>

        {totalPages > 1 && (
          <div className="pagination">
            <button 
              className="page-btn" 
              onClick={prevPage} 
              disabled={currentPage === 1}
            >
              Previous
            </button>
            
            {Array(totalPages).fill(0).map((_, i) => (
              <button 
                key={i}
                className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
                onClick={() => goToPage(i + 1)}
              >
                {i + 1}
              </button>
            ))}
            
            <button 
              className="page-btn" 
              onClick={nextPage} 
              disabled={currentPage === totalPages}
            >
              Next
            </button>
          </div>
        )}
      </div>

      <style jsx>{`
        .document-management {
          max-width: 1400px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .management-header {
          text-align: center;
          margin-bottom: 40px;
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
          flex-direction: column;
          gap: 20px;
          margin-bottom: 30px;
          padding: 25px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .search-section {
          display: flex;
          justify-content: center;
        }

        .search-input {
          width: 100%;
          max-width: 500px;
          padding: 15px 20px;
          border: 2px solid #ddd;
          border-radius: 25px;
          font-size: 16px;
          transition: border-color 0.2s ease;
        }

        .search-input:focus {
          outline: none;
          border-color: #007bff;
        }

        .filter-section {
          display: flex;
          gap: 20px;
          align-items: center;
          justify-content: center;
          flex-wrap: wrap;
        }

        .status-filter,
        .sort-filter {
          padding: 10px 15px;
          border: 2px solid #ddd;
          border-radius: 6px;
          background: white;
          font-size: 14px;
          min-width: 150px;
        }

        .status-overview {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 20px;
          margin-bottom: 40px;
        }

        .status-card {
          background: white;
          padding: 25px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .status-card.approved .status-icon {
          color: #28a745;
        }

        .status-card.pending .status-icon {
          color: #ffc107;
        }

        .status-card.rejected .status-icon {
          color: #dc3545;
        }

        .status-card.draft .status-icon {
          color: #6c757d;
        }

        .status-icon {
          font-size: 32px;
        }

        .status-content {
          flex: 1;
        }

        .status-count {
          font-size: 28px;
          font-weight: bold;
          color: #333;
          margin-bottom: 5px;
        }

        .status-label {
          font-size: 14px;
          color: #666;
          font-weight: bold;
        }

        .documents-container {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          padding: 30px;
          margin-bottom: 30px;
        }

        .documents-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 25px;
        }

        .documents-header h3 {
          margin: 0;
          font-size: 24px;
          color: #333;
        }

        .view-options {
          display: flex;
          border: 1px solid #ddd;
          border-radius: 4px;
          overflow: hidden;
        }

        .view-btn {
          padding: 8px 16px;
          border: none;
          background: white;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .view-btn.active {
          background: #007bff;
          color: white;
        }

        .documents-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
          gap: 25px;
        }

        .document-card {
          border: 1px solid #eee;
          border-radius: 8px;
          padding: 20px;
          transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .document-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .document-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 15px;
        }

        .document-type {
          background: #e9ecef;
          color: #495057;
          padding: 4px 8px;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }

        .document-priority {
          font-size: 12px;
          font-weight: bold;
        }

        .document-content {
          margin-bottom: 15px;
        }

        .document-title {
          margin: 0 0 10px 0;
          font-size: 16px;
          color: #333;
        }

        .document-author {
          margin: 0 0 5px 0;
          font-size: 14px;
          color: #666;
        }

        .document-version {
          margin: 0;
          font-size: 12px;
          color: #999;
        }

        .document-meta {
          display: flex;
          flex-direction: column;
          gap: 8px;
          margin-bottom: 15px;
          padding-bottom: 15px;
          border-bottom: 1px solid #eee;
        }

        .meta-item {
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .meta-label {
          font-weight: bold;
          color: #666;
          font-size: 12px;
        }

        .meta-value {
          color: #333;
          font-size: 12px;
        }

        .document-status {
          display: flex;
          align-items: center;
          gap: 8px;
          margin-bottom: 15px;
        }

        .status-indicator {
          font-size: 16px;
        }

        .status-text {
          font-size: 14px;
          font-weight: bold;
        }

        .document-actions {
          display: flex;
          gap: 5px;
          flex-wrap: wrap;
        }

        .action-btn {
          padding: 6px 12px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 12px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
        }

        .action-btn.primary:hover {
          background: #0056b3;
        }

        .action-btn.secondary {
          background: #6c757d;
          color: white;
        }

        .action-btn.secondary:hover {
          background: #545b62;
        }

        .action-btn.danger {
          background: #dc3545;
          color: white;
        }

        .action-btn.danger:hover {
          background: #c82333;
        }

        .pagination {
          display: flex;
          justify-content: center;
          gap: 5px;
          margin-top: 30px;
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
      `}</style>
    </div>
  );
}

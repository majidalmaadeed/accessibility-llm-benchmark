<script>
  let selectedFilter = 'all';
  let sortBy = 'date';
  let viewMode = 'grid';
  
  const documents = [
    {
      id: 1,
      title: "Project Proposal - Q1 2024",
      type: "proposal",
      status: "approved",
      author: "Sarah Johnson",
      date: "2024-01-15",
      department: "Marketing",
      priority: "high",
      size: "2.4 MB",
      version: "v2.1",
      lastModified: "2024-01-15 14:30",
      description: "Comprehensive project proposal for Q1 2024 marketing initiatives including budget allocation and timeline."
    },
    {
      id: 2,
      title: "Financial Report - December 2023",
      type: "report",
      status: "pending",
      author: "Mike Chen",
      date: "2024-01-14",
      department: "Finance",
      priority: "high",
      size: "1.8 MB",
      version: "v1.0",
      lastModified: "2024-01-14 16:45",
      description: "Monthly financial report covering revenue, expenses, and profit margins for December 2023."
    },
    {
      id: 3,
      title: "Employee Handbook 2024",
      type: "handbook",
      status: "draft",
      author: "Emily Davis",
      date: "2024-01-13",
      department: "HR",
      priority: "medium",
      size: "3.2 MB",
      version: "v3.0",
      lastModified: "2024-01-13 11:20",
      description: "Updated employee handbook with new policies and procedures for 2024."
    },
    {
      id: 4,
      title: "Technical Specifications - API v2",
      type: "specification",
      status: "approved",
      author: "David Wilson",
      date: "2024-01-12",
      department: "Engineering",
      priority: "high",
      size: "4.1 MB",
      version: "v2.0",
      lastModified: "2024-01-12 09:15",
      description: "Detailed technical specifications for the new API version 2.0 including endpoints and data models."
    },
    {
      id: 5,
      title: "Meeting Minutes - Board Meeting",
      type: "minutes",
      status: "reviewed",
      author: "Lisa Brown",
      date: "2024-01-11",
      department: "Executive",
      priority: "medium",
      size: "856 KB",
      version: "v1.2",
      lastModified: "2024-01-11 17:30",
      description: "Minutes from the quarterly board meeting covering strategic decisions and action items."
    },
    {
      id: 6,
      title: "Security Audit Report",
      type: "audit",
      status: "rejected",
      author: "Tom Anderson",
      date: "2024-01-10",
      department: "IT",
      priority: "high",
      size: "2.9 MB",
      version: "v1.5",
      lastModified: "2024-01-10 13:45",
      description: "Comprehensive security audit report identifying vulnerabilities and recommendations."
    },
    {
      id: 7,
      title: "Product Roadmap 2024",
      type: "roadmap",
      status: "approved",
      author: "Anna Garcia",
      date: "2024-01-09",
      department: "Product",
      priority: "high",
      size: "1.5 MB",
      version: "v4.0",
      lastModified: "2024-01-09 15:20",
      description: "Strategic product roadmap outlining key features and milestones for 2024."
    },
    {
      id: 8,
      title: "Training Materials - New Hires",
      type: "training",
      status: "draft",
      author: "Kevin Lee",
      date: "2024-01-08",
      department: "HR",
      priority: "low",
      size: "5.7 MB",
      version: "v2.3",
      lastModified: "2024-01-08 10:10",
      description: "Comprehensive training materials for new employee onboarding process."
    }
  ];
  
  function filterDocuments() {
    return documents.filter(doc => {
      if (selectedFilter === 'all') return true;
      return doc.status === selectedFilter;
    });
  }
  
  function sortDocuments(docs) {
    return [...docs].sort((a, b) => {
      switch(sortBy) {
        case 'title':
          return a.title.localeCompare(b.title);
        case 'author':
          return a.author.localeCompare(b.author);
        case 'date':
        default:
          return new Date(b.date) - new Date(a.date);
      }
    });
  }
  
  function getStatusIcon(status) {
    switch(status) {
      case 'approved': return '●';
      case 'pending': return '○';
      case 'draft': return '◐';
      case 'reviewed': return '●';
      case 'rejected': return '●';
      default: return '○';
    }
  }
  
  function getStatusColor(status) {
    switch(status) {
      case 'approved': return '#28a745';
      case 'pending': return '#ffc107';
      case 'draft': return '#6c757d';
      case 'reviewed': return '#17a2b8';
      case 'rejected': return '#dc3545';
      default: return '#6c757d';
    }
  }
  
  $: filteredDocuments = sortDocuments(filterDocuments());
</script>

<div class="document-management">
  <header class="management-header">
    <div class="header-content">
      <h1 class="management-title">Document Management System</h1>
      <p class="management-subtitle">Organize, track, and manage your documents efficiently</p>
    </div>
    
    <div class="header-actions">
      <button class="action-btn primary-btn">Upload Document</button>
      <button class="action-btn secondary-btn">Create Folder</button>
      <button class="action-btn secondary-btn">Bulk Actions</button>
    </div>
  </header>

  <div class="management-controls">
    <div class="control-group">
      <label class="control-label">Status Filter:</label>
      <select bind:value={selectedFilter} class="control-select">
        <option value="all">All Documents</option>
        <option value="approved">Approved</option>
        <option value="pending">Pending</option>
        <option value="draft">Draft</option>
        <option value="reviewed">Reviewed</option>
        <option value="rejected">Rejected</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort by:</label>
      <select bind:value={sortBy} class="control-select">
        <option value="date">Date</option>
        <option value="title">Title</option>
        <option value="author">Author</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">View:</label>
      <div class="view-toggle">
        <button 
          class="view-btn" 
          class:active={viewMode === 'grid'}
          on:click={() => viewMode = 'grid'}
        >
          Grid
        </button>
        <button 
          class="view-btn" 
          class:active={viewMode === 'list'}
          on:click={() => viewMode = 'list'}
        >
          List
        </button>
      </div>
    </div>
  </div>

  <div class="documents-section">
    <div class="section-header">
      <h2 class="section-title">Documents</h2>
      <div class="section-info">
        <span class="documents-count">{filteredDocuments.length} documents</span>
        <span class="last-updated">Last updated: {new Date().toLocaleString()}</span>
      </div>
    </div>
    
    {#if viewMode === 'grid'}
      <div class="documents-grid">
        {#each filteredDocuments as doc (doc.id)}
          <div class="document-card">
            <div class="card-header">
              <div class="document-type">
                <span class="type-icon">{doc.type.charAt(0).toUpperCase()}</span>
                <span class="type-label">{doc.type}</span>
              </div>
              <div class="document-status">
                <span 
                  class="status-indicator" 
                  style="color: {getStatusColor(doc.status)}"
                >
                  {getStatusIcon(doc.status)}
                </span>
              </div>
            </div>
            
            <div class="card-body">
              <h3 class="document-title">{doc.title}</h3>
              <p class="document-description">{doc.description}</p>
              
              <div class="document-meta">
                <div class="meta-item">
                  <span class="meta-label">Author:</span>
                  <span class="meta-value">{doc.author}</span>
                </div>
                <div class="meta-item">
                  <span class="meta-label">Department:</span>
                  <span class="meta-value">{doc.department}</span>
                </div>
                <div class="meta-item">
                  <span class="meta-label">Priority:</span>
                  <span class="meta-value priority-{doc.priority}">{doc.priority}</span>
                </div>
                <div class="meta-item">
                  <span class="meta-label">Size:</span>
                  <span class="meta-value">{doc.size}</span>
                </div>
                <div class="meta-item">
                  <span class="meta-label">Version:</span>
                  <span class="meta-value">{doc.version}</span>
                </div>
                <div class="meta-item">
                  <span class="meta-label">Date:</span>
                  <span class="meta-value">{new Date(doc.date).toLocaleDateString()}</span>
                </div>
              </div>
            </div>
            
            <div class="card-footer">
              <div class="document-actions">
                <button class="action-btn view-btn">View</button>
                <button class="action-btn edit-btn">Edit</button>
                <button class="action-btn download-btn">Download</button>
                <button class="action-btn share-btn">Share</button>
              </div>
            </div>
          </div>
        {/each}
      </div>
    {:else}
      <div class="documents-list">
        {#each filteredDocuments as doc (doc.id)}
          <div class="document-list-item">
            <div class="list-status">
              <span 
                class="status-indicator" 
                style="color: {getStatusColor(doc.status)}"
              >
                {getStatusIcon(doc.status)}
              </span>
            </div>
            
            <div class="list-content">
              <div class="list-header">
                <h3 class="list-title">{doc.title}</h3>
                <div class="list-meta">
                  <span class="document-type">{doc.type}</span>
                  <span class="document-priority priority-{doc.priority}">{doc.priority}</span>
                </div>
              </div>
              
              <p class="list-description">{doc.description}</p>
              
              <div class="list-details">
                <div class="detail-item">
                  <span class="detail-label">Author:</span>
                  <span class="detail-value">{doc.author}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Department:</span>
                  <span class="detail-value">{doc.department}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Size:</span>
                  <span class="detail-value">{doc.size}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Version:</span>
                  <span class="detail-value">{doc.version}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Date:</span>
                  <span class="detail-value">{new Date(doc.date).toLocaleDateString()}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Modified:</span>
                  <span class="detail-value">{doc.lastModified}</span>
                </div>
              </div>
            </div>
            
            <div class="list-actions">
              <button class="list-action-btn view">👁</button>
              <button class="list-action-btn edit">✏️</button>
              <button class="list-action-btn download">⬇️</button>
              <button class="list-action-btn share">🔗</button>
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  <div class="status-legend">
    <h3 class="legend-title">Status Legend</h3>
    <div class="legend-items">
      <div class="legend-item">
        <span class="legend-icon" style="color: #28a745;">●</span>
        <span class="legend-label">Approved</span>
      </div>
      <div class="legend-item">
        <span class="legend-icon" style="color: #ffc107;">○</span>
        <span class="legend-label">Pending</span>
      </div>
      <div class="legend-item">
        <span class="legend-icon" style="color: #6c757d;">◐</span>
        <span class="legend-label">Draft</span>
      </div>
      <div class="legend-item">
        <span class="legend-icon" style="color: #17a2b8;">●</span>
        <span class="legend-label">Reviewed</span>
      </div>
      <div class="legend-item">
        <span class="legend-icon" style="color: #dc3545;">●</span>
        <span class="legend-label">Rejected</span>
      </div>
    </div>
  </div>

  <div class="bulk-actions-section">
    <div class="bulk-actions-content">
      <h3 class="bulk-title">Bulk Actions</h3>
      <p class="bulk-description">Select multiple documents to perform batch operations</p>
      <div class="bulk-buttons">
        <button class="bulk-btn approve-btn">Approve Selected</button>
        <button class="bulk-btn reject-btn">Reject Selected</button>
        <button class="bulk-btn download-btn">Download Selected</button>
        <button class="bulk-btn archive-btn">Archive Selected</button>
        <button class="bulk-btn delete-btn">Delete Selected</button>
      </div>
    </div>
  </div>
</div>

<style>
  .document-management {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .management-header {
    background: white;
    padding: 30px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    text-align: center;
    margin-bottom: 30px;
  }
  
  .management-title {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }
  
  .management-subtitle {
    margin: 0;
    font-size: 16px;
    color: #666;
  }
  
  .header-actions {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    gap: 15px;
  }
  
  .action-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .primary-btn {
    background: #007bff;
    color: white;
  }
  
  .primary-btn:hover {
    background: #0056b3;
  }
  
  .secondary-btn {
    background: #f8f9fa;
    color: #333;
    border: 1px solid #ddd;
  }
  
  .secondary-btn:hover {
    background: #e9ecef;
    border-color: #007bff;
    color: #007bff;
  }
  
  .management-controls {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    gap: 30px;
    align-items: center;
  }
  
  .control-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .control-label {
    font-weight: bold;
    color: #333;
    white-space: nowrap;
  }
  
  .control-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    cursor: pointer;
    min-width: 150px;
  }
  
  .view-toggle {
    display: flex;
    gap: 5px;
  }
  
  .view-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .view-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .view-btn:hover:not(.active) {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .documents-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
  }
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
  }
  
  .section-title {
    margin: 0;
    font-size: 24px;
    color: #333;
  }
  
  .section-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
  }
  
  .documents-count {
    font-weight: bold;
    color: #333;
  }
  
  .last-updated {
    font-size: 14px;
    color: #666;
  }
  
  .documents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 30px;
  }
  
  .document-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .document-card:hover {
    transform: translateY(-2px);
  }
  
  .card-header {
    padding: 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .document-type {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .type-icon {
    width: 30px;
    height: 30px;
    background: #007bff;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 14px;
  }
  
  .type-label {
    font-weight: bold;
    color: #333;
    text-transform: capitalize;
  }
  
  .status-indicator {
    font-size: 20px;
    font-weight: bold;
  }
  
  .card-body {
    padding: 20px;
  }
  
  .document-title {
    margin: 0 0 15px 0;
    font-size: 18px;
    color: #333;
    font-weight: bold;
    line-height: 1.3;
  }
  
  .document-description {
    margin: 0 0 20px 0;
    color: #666;
    line-height: 1.5;
  }
  
  .document-meta {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
  }
  
  .meta-item {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .meta-label {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .meta-value {
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }
  
  .priority-high {
    color: #dc3545;
  }
  
  .priority-medium {
    color: #ffc107;
  }
  
  .priority-low {
    color: #28a745;
  }
  
  .card-footer {
    padding: 20px;
    border-top: 1px solid #eee;
    background: #f8f9fa;
  }
  
  .document-actions {
    display: flex;
    gap: 10px;
  }
  
  .view-btn,
  .edit-btn,
  .download-btn,
  .share-btn {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .view-btn:hover {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .edit-btn:hover {
    background: #28a745;
    color: white;
    border-color: #28a745;
  }
  
  .download-btn:hover {
    background: #17a2b8;
    color: white;
    border-color: #17a2b8;
  }
  
  .share-btn:hover {
    background: #6f42c1;
    color: white;
    border-color: #6f42c1;
  }
  
  .documents-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  
  .document-list-item {
    display: flex;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
  }
  
  .document-list-item:hover {
    transform: translateY(-1px);
  }
  
  .list-status {
    padding: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
    border-right: 1px solid #eee;
  }
  
  .list-content {
    flex: 1;
    padding: 20px;
  }
  
  .list-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;
  }
  
  .list-title {
    margin: 0;
    font-size: 18px;
    color: #333;
    font-weight: bold;
  }
  
  .list-meta {
    display: flex;
    gap: 15px;
    align-items: center;
  }
  
  .document-type {
    background: #e9ecef;
    color: #495057;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .document-priority {
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }
  
  .list-description {
    margin: 0 0 15px 0;
    color: #666;
    line-height: 1.5;
  }
  
  .list-details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
  }
  
  .detail-item {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .detail-label {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .detail-value {
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }
  
  .list-actions {
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 20px;
    justify-content: center;
  }
  
  .list-action-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
  }
  
  .list-action-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .status-legend {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .legend-title {
    margin: 0 0 20px 0;
    font-size: 18px;
    color: #333;
  }
  
  .legend-items {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
  }
  
  .legend-item {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  
  .legend-icon {
    font-size: 16px;
    font-weight: bold;
  }
  
  .legend-label {
    font-weight: 500;
    color: #333;
  }
  
  .bulk-actions-section {
    max-width: 1200px;
    margin: 0 auto 50px;
    padding: 0 20px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .bulk-actions-content {
    text-align: center;
  }
  
  .bulk-title {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }
  
  .bulk-description {
    margin: 0 0 25px 0;
    color: #666;
  }
  
  .bulk-buttons {
    display: flex;
    gap: 15px;
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .bulk-btn {
    padding: 10px 20px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .approve-btn:hover {
    background: #28a745;
    color: white;
    border-color: #28a745;
  }
  
  .reject-btn:hover {
    background: #dc3545;
    color: white;
    border-color: #dc3545;
  }
  
  .download-btn:hover {
    background: #17a2b8;
    color: white;
    border-color: #17a2b8;
  }
  
  .archive-btn:hover {
    background: #6c757d;
    color: white;
    border-color: #6c757d;
  }
  
  .delete-btn:hover {
    background: #dc3545;
    color: white;
    border-color: #dc3545;
  }
  
  @media (max-width: 768px) {
    .management-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: space-between;
    }
    
    .header-actions {
      flex-direction: column;
      gap: 10px;
    }
    
    .documents-grid {
      grid-template-columns: 1fr;
    }
    
    .document-list-item {
      flex-direction: column;
    }
    
    .list-status {
      border-right: none;
      border-bottom: 1px solid #eee;
    }
    
    .list-details {
      grid-template-columns: 1fr;
    }
    
    .list-actions {
      flex-direction: row;
      justify-content: space-around;
    }
    
    .legend-items {
      justify-content: center;
    }
    
    .bulk-buttons {
      flex-direction: column;
    }
  }
</style>

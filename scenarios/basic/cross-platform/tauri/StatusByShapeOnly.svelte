<script>
  import { onMount } from 'svelte';
  
  let documents = [
    {
      id: 1,
      name: 'Project Proposal.docx',
      type: 'Word Document',
      size: '2.3 MB',
      lastModified: '2024-01-15',
      status: 'approved' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    },
    {
      id: 2,
      name: 'Budget Report.xlsx',
      type: 'Excel Spreadsheet',
      size: '1.8 MB',
      lastModified: '2024-01-14',
      status: 'pending' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    },
    {
      id: 3,
      name: 'Meeting Notes.pdf',
      type: 'PDF Document',
      size: '856 KB',
      lastModified: '2024-01-13',
      status: 'rejected' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    },
    {
      id: 4,
      name: 'Design Mockups.png',
      type: 'Image File',
      size: '4.2 MB',
      lastModified: '2024-01-12',
      status: 'approved' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    },
    {
      id: 5,
      name: 'Contract Template.docx',
      type: 'Word Document',
      size: '1.5 MB',
      lastModified: '2024-01-11',
      status: 'pending' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    },
    {
      id: 6,
      name: 'Presentation.pptx',
      type: 'PowerPoint Presentation',
      size: '3.7 MB',
      lastModified: '2024-01-10',
      status: 'approved' // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
    }
  ];
  
  let selectedStatus = 'all';
  let filteredDocuments = [...documents];
  
  function filterByStatus(status) {
    selectedStatus = status;
    if (status === 'all') {
      filteredDocuments = [...documents];
    } else {
      filteredDocuments = documents.filter(doc => doc.status === status);
    }
  }
  
  function getStatusCounts() {
    return {
      all: documents.length,
      approved: documents.filter(doc => doc.status === 'approved').length,
      pending: documents.filter(doc => doc.status === 'pending').length,
      rejected: documents.filter(doc => doc.status === 'rejected').length
    };
  }
  
  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }
  
  function getFileIcon(type) {
    const icons = {
      'Word Document': '📄',
      'Excel Spreadsheet': '📊',
      'PDF Document': '📋',
      'Image File': '🖼️',
      'PowerPoint Presentation': '📽️'
    };
    return icons[type] || '📁';
  }
  
  function handleDocumentClick(document) {
    alert(`Opening document: ${document.name}`);
  }
  
  function handleStatusChange(document, newStatus) {
    document.status = newStatus;
    filteredDocuments = [...filteredDocuments];
    alert(`Document ${document.name} status changed to ${newStatus}`);
  }
</script>

<div class="document-manager">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Document Manager</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Upload clicked')}>
          📤 Upload
        </button>
        <button class="header-btn" on:click={() => alert('New Folder clicked')}>
          📁 New Folder
        </button>
        <button class="header-btn" on:click={() => alert('Settings clicked')}>
          ⚙️ Settings
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="page-header">
      <h2 class="page-title">Document Library</h2>
      <p class="page-subtitle">Manage and organize your documents</p>
    </div>
    
    <div class="controls">
      <div class="filter-group">
        <label for="statusFilter" class="filter-label">Filter by Status:</label>
        <select id="statusFilter" class="filter-select" on:change={(e) => filterByStatus(e.target.value)}>
          <option value="all">All Documents</option>
          <option value="approved">Approved</option>
          <option value="pending">Pending</option>
          <option value="rejected">Rejected</option>
        </select>
      </div>
      
      <div class="status-counts">
        {#each Object.entries(getStatusCounts()) as [status, count]}
          <div class="status-count">
            <span class="status-label">{status}:</span>
            <span class="status-value">{count}</span>
          </div>
        {/each}
      </div>
    </div>
    
    <div class="documents-grid">
      {#each filteredDocuments as document}
        <div class="document-card" on:click={() => handleDocumentClick(document)}>
          <div class="document-header">
            <div class="document-icon">{getFileIcon(document.type)}</div>
            <div class="document-actions">
              <button class="action-btn" on:click|stopPropagation={() => alert(`Download ${document.name}`)}>
                📥
              </button>
              <button class="action-btn" on:click|stopPropagation={() => alert(`Share ${document.name}`)}>
                📤
              </button>
              <button class="action-btn" on:click|stopPropagation={() => alert(`Delete ${document.name}`)}>
                🗑️
              </button>
            </div>
          </div>
          
          <div class="document-content">
            <h3 class="document-name">{document.name}</h3>
            <p class="document-type">{document.type}</p>
            <p class="document-size">{document.size}</p>
            <p class="document-date">Modified: {formatDate(document.lastModified)}</p>
          </div>
          
          <div class="document-footer">
            <div class="status-section">
              <div class="status-label">Status:</div>
              <!-- STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape -->
              <div class="status-indicator">
                {#if document.status === 'approved'}
                  <!-- STATUS BY SHAPE ONLY - Approved status shown as circle -->
                  <div class="status-shape circle approved"></div>
                {:else if document.status === 'pending'}
                  <!-- STATUS BY SHAPE ONLY - Pending status shown as square -->
                  <div class="status-shape square pending"></div>
                {:else if document.status === 'rejected'}
                  <!-- STATUS BY SHAPE ONLY - Rejected status shown as square -->
                  <div class="status-shape square rejected"></div>
                {/if}
              </div>
            </div>
            
            <div class="status-actions">
              <button class="status-btn approved" on:click|stopPropagation={() => handleStatusChange(document, 'approved')}>
                Approve
              </button>
              <button class="status-btn pending" on:click|stopPropagation={() => handleStatusChange(document, 'pending')}>
                Pending
              </button>
              <button class="status-btn rejected" on:click|stopPropagation={() => handleStatusChange(document, 'rejected')}>
                Reject
              </button>
            </div>
          </div>
        </div>
      {/each}
    </div>
    
    {#if filteredDocuments.length === 0}
      <div class="empty-state">
        <div class="empty-icon">📁</div>
        <h3 class="empty-title">No documents found</h3>
        <p class="empty-description">Try adjusting your filters or upload new documents</p>
        <button class="empty-action" on:click={() => alert('Upload clicked')}>
          Upload Documents
        </button>
      </div>
    {/if}
  </main>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">Quick Actions</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Upload Documents</a></li>
          <li><a href="#" class="footer-link">Create Folder</a></li>
          <li><a href="#" class="footer-link">Bulk Actions</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Document Types</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">Word Documents</a></li>
          <li><a href="#" class="footer-link">Excel Spreadsheets</a></li>
          <li><a href="#" class="footer-link">PDF Files</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h4 class="footer-title">Help</h4>
        <ul class="footer-links">
          <li><a href="#" class="footer-link">User Guide</a></li>
          <li><a href="#" class="footer-link">Support</a></li>
          <li><a href="#" class="footer-link">Contact</a></li>
        </ul>
      </div>
    </div>
    
    <div class="footer-bottom">
      <p>&copy; 2024 Document Manager. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .document-manager {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .page-header {
    text-align: center;
    margin-bottom: 30px;
  }
  
  .page-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .page-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .filter-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .filter-label {
    font-weight: bold;
    color: #333;
  }
  
  .filter-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
  }
  
  .status-counts {
    display: flex;
    gap: 20px;
  }
  
  .status-count {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
  }
  
  .status-label {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
  }
  
  .status-value {
    font-size: 18px;
    font-weight: bold;
    color: #333;
  }
  
  .documents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
  }
  
  .document-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  
  .document-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  }
  
  .document-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .document-icon {
    font-size: 32px;
  }
  
  .document-actions {
    display: flex;
    gap: 8px;
  }
  
  .action-btn {
    background: none;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 6px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .document-content {
    margin-bottom: 20px;
  }
  
  .document-name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0 0 8px 0;
    word-break: break-word;
  }
  
  .document-type {
    font-size: 14px;
    color: #666;
    margin: 0 0 4px 0;
  }
  
  .document-size {
    font-size: 14px;
    color: #666;
    margin: 0 0 4px 0;
  }
  
  .document-date {
    font-size: 14px;
    color: #666;
    margin: 0;
  }
  
  .document-footer {
    border-top: 1px solid #eee;
    padding-top: 15px;
  }
  
  .status-section {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
  }
  
  .status-label {
    font-size: 14px;
    font-weight: bold;
    color: #333;
  }
  
  .status-indicator {
    display: flex;
    align-items: center;
  }
  
  /* STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape */
  .status-shape {
    width: 20px;
    height: 20px;
    border: 2px solid;
  }
  
  .status-shape.circle {
    border-radius: 50%;
  }
  
  .status-shape.square {
    border-radius: 4px;
  }
  
  .status-shape.approved {
    border-color: #28a745;
    background: #28a745;
  }
  
  .status-shape.pending {
    border-color: #ffc107;
    background: #ffc107;
  }
  
  .status-shape.rejected {
    border-color: #dc3545;
    background: #dc3545;
  }
  
  .status-actions {
    display: flex;
    gap: 8px;
  }
  
  .status-btn {
    padding: 6px 12px;
    border: 1px solid;
    border-radius: 4px;
    background: none;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    transition: all 0.2s;
  }
  
  .status-btn.approved {
    color: #28a745;
    border-color: #28a745;
  }
  
  .status-btn.approved:hover {
    background: #28a745;
    color: white;
  }
  
  .status-btn.pending {
    color: #ffc107;
    border-color: #ffc107;
  }
  
  .status-btn.pending:hover {
    background: #ffc107;
    color: white;
  }
  
  .status-btn.rejected {
    color: #dc3545;
    border-color: #dc3545;
  }
  
  .status-btn.rejected:hover {
    background: #dc3545;
    color: white;
  }
  
  .empty-state {
    text-align: center;
    padding: 60px 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .empty-icon {
    font-size: 64px;
    margin-bottom: 20px;
  }
  
  .empty-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .empty-description {
    font-size: 16px;
    color: #666;
    margin: 0 0 20px 0;
  }
  
  .empty-action {
    background: #007bff;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
  }
  
  .empty-action:hover {
    background: #0056b3;
  }
  
  .footer {
    background: #333;
    color: white;
    padding: 40px 0 20px 0;
    margin-top: 60px;
  }
  
  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 40px;
  }
  
  .footer-title {
    font-size: 18px;
    font-weight: bold;
    margin: 0 0 15px 0;
  }
  
  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .footer-links li {
    margin-bottom: 8px;
  }
  
  .footer-link {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }
  
  .footer-link:hover {
    color: white;
  }
  
  .footer-bottom {
    border-top: 1px solid #555;
    margin-top: 30px;
    padding-top: 20px;
    text-align: center;
    color: #ccc;
  }
</style>

<script>
  let selectedCategory = 'all';
  let sortBy = 'date';
  let viewMode = 'grid';
  let showFilters = false;
  let contextMenu = {
    visible: false,
    x: 0,
    y: 0,
    item: null
  };
  
  const files = [
    {
      id: 1,
      name: "Project Proposal.docx",
      type: "document",
      size: "2.4 MB",
      modified: "2024-01-15",
      author: "Sarah Johnson",
      status: "draft"
    },
    {
      id: 2,
      name: "Financial Report.xlsx",
      type: "spreadsheet",
      size: "1.8 MB",
      modified: "2024-01-14",
      author: "Mike Chen",
      status: "final"
    },
    {
      id: 3,
      name: "Presentation.pptx",
      type: "presentation",
      size: "5.2 MB",
      modified: "2024-01-13",
      author: "Emily Davis",
      status: "review"
    },
    {
      id: 4,
      name: "Meeting Notes.txt",
      type: "text",
      size: "156 KB",
      modified: "2024-01-12",
      author: "David Wilson",
      status: "draft"
    },
    {
      id: 5,
      name: "Design Mockup.png",
      type: "image",
      size: "3.1 MB",
      modified: "2024-01-11",
      author: "Lisa Brown",
      status: "final"
    },
    {
      id: 6,
      name: "Code Review.pdf",
      type: "document",
      size: "892 KB",
      modified: "2024-01-10",
      author: "Tom Anderson",
      status: "review"
    },
    {
      id: 7,
      name: "Database Schema.sql",
      type: "code",
      size: "234 KB",
      modified: "2024-01-09",
      author: "Anna Garcia",
      status: "draft"
    },
    {
      id: 8,
      name: "User Manual.pdf",
      type: "document",
      size: "4.7 MB",
      modified: "2024-01-08",
      author: "Kevin Lee",
      status: "final"
    }
  ];
  
  function filterFiles() {
    return files.filter(file => {
      if (selectedCategory === 'all') return true;
      return file.type === selectedCategory;
    });
  }
  
  function sortFiles(files) {
    return [...files].sort((a, b) => {
      switch(sortBy) {
        case 'name':
          return a.name.localeCompare(b.name);
        case 'size':
          return parseFloat(b.size) - parseFloat(a.size);
        case 'modified':
        default:
          return new Date(b.modified) - new Date(a.modified);
      }
    });
  }
  
  function handleContextMenu(event, file) {
    event.preventDefault();
    contextMenu = {
      visible: true,
      x: event.clientX,
      y: event.clientY,
      item: file
    };
  }
  
  function handleClickOutside() {
    contextMenu.visible = false;
  }
  
  function handleContextAction(action) {
    console.log(`${action} on ${contextMenu.item.name}`);
    contextMenu.visible = false;
  }
  
  function getFileIcon(type) {
    switch(type) {
      case 'document': return '📄';
      case 'spreadsheet': return '📊';
      case 'presentation': return '📽️';
      case 'text': return '📝';
      case 'image': return '🖼️';
      case 'code': return '💻';
      default: return '📁';
    }
  }
  
  function getStatusColor(status) {
    switch(status) {
      case 'draft': return '#ffc107';
      case 'review': return '#17a2b8';
      case 'final': return '#28a745';
      default: return '#6c757d';
    }
  }
  
  $: filteredFiles = sortFiles(filterFiles());
</script>

<svelte:window on:click={handleClickOutside} />

<div class="file-manager">
  <header class="manager-header">
    <div class="header-content">
      <h1 class="manager-title">File Manager</h1>
      <p class="manager-subtitle">Organize and manage your files</p>
    </div>
    
    <div class="header-actions">
      <button class="header-btn upload-btn">📤 Upload</button>
      <button class="header-btn new-folder-btn">📁 New Folder</button>
      <button class="header-btn view-btn">👁 View</button>
    </div>
  </header>

  <div class="manager-controls">
    <div class="control-group">
      <label class="control-label">Filter by type:</label>
      <select bind:value={selectedCategory} class="control-select">
        <option value="all">All Files</option>
        <option value="document">Documents</option>
        <option value="spreadsheet">Spreadsheets</option>
        <option value="presentation">Presentations</option>
        <option value="text">Text Files</option>
        <option value="image">Images</option>
        <option value="code">Code Files</option>
      </select>
    </div>
    
    <div class="control-group">
      <label class="control-label">Sort by:</label>
      <select bind:value={sortBy} class="control-select">
        <option value="modified">Date Modified</option>
        <option value="name">Name</option>
        <option value="size">Size</option>
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

  <div class="files-section">
    <div class="section-header">
      <h2 class="section-title">Files</h2>
      <div class="section-info">
        <span class="files-count">{filteredFiles.length} files</span>
        <span class="last-updated">Last updated: {new Date().toLocaleString()}</span>
      </div>
    </div>
    
    {#if viewMode === 'grid'}
      <div class="files-grid">
        {#each filteredFiles as file (file.id)}
          <div 
            class="file-card"
            on:contextmenu={(e) => handleContextMenu(e, file)}
          >
            <div class="file-icon">
              {getFileIcon(file.type)}
            </div>
            
            <div class="file-info">
              <h3 class="file-name">{file.name}</h3>
              <p class="file-details">
                <span class="file-size">{file.size}</span>
                <span class="file-date">{new Date(file.modified).toLocaleDateString()}</span>
              </p>
              <p class="file-author">By {file.author}</p>
              <div class="file-status">
                <span 
                  class="status-badge" 
                  style="background-color: {getStatusColor(file.status)}"
                >
                  {file.status}
                </span>
              </div>
            </div>
          </div>
        {/each}
      </div>
    {:else}
      <div class="files-list">
        {#each filteredFiles as file (file.id)}
          <div 
            class="file-list-item"
            on:contextmenu={(e) => handleContextMenu(e, file)}
          >
            <div class="list-file-icon">
              {getFileIcon(file.type)}
            </div>
            
            <div class="list-file-info">
              <h3 class="list-file-name">{file.name}</h3>
              <p class="list-file-details">
                <span class="list-file-size">{file.size}</span>
                <span class="list-file-date">{new Date(file.modified).toLocaleDateString()}</span>
                <span class="list-file-author">By {file.author}</span>
              </p>
            </div>
            
            <div class="list-file-status">
              <span 
                class="list-status-badge" 
                style="background-color: {getStatusColor(file.status)}"
              >
                {file.status}
              </span>
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </div>

  {#if contextMenu.visible}
    <div 
      class="context-menu"
      style="left: {contextMenu.x}px; top: {contextMenu.y}px;"
    >
      <div class="context-menu-item" on:click={() => handleContextAction('Open')}>
        <span class="context-icon">👁</span>
        <span class="context-text">Open</span>
      </div>
      <div class="context-menu-item" on:click={() => handleContextAction('Download')}>
        <span class="context-icon">⬇️</span>
        <span class="context-text">Download</span>
      </div>
      <div class="context-menu-item" on:click={() => handleContextAction('Rename')}>
        <span class="context-icon">✏️</span>
        <span class="context-text">Rename</span>
      </div>
      <div class="context-menu-item" on:click={() => handleContextAction('Move')}>
        <span class="context-icon">📁</span>
        <span class="context-text">Move to Folder</span>
      </div>
      <div class="context-menu-item" on:click={() => handleContextAction('Copy')}>
        <span class="context-icon">📋</span>
        <span class="context-text">Copy</span>
      </div>
      <div class="context-menu-item" on:click={() => handleContextAction('Share')}>
        <span class="context-icon">🔗</span>
        <span class="context-text">Share</span>
      </div>
      <div class="context-menu-divider"></div>
      <div class="context-menu-item danger" on:click={() => handleContextAction('Delete')}>
        <span class="context-icon">🗑️</span>
        <span class="context-text">Delete</span>
      </div>
    </div>
  {/if}
</div>

<style>
  .file-manager {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f8f9fa;
    min-height: 100vh;
  }
  
  .manager-header {
    background: white;
    padding: 20px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    text-align: center;
    margin-bottom: 20px;
  }
  
  .manager-title {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }
  
  .manager-subtitle {
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
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
    border-radius: 6px;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .manager-controls {
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
  
  .files-section {
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
  
  .files-count {
    font-weight: bold;
    color: #333;
  }
  
  .last-updated {
    font-size: 14px;
    color: #666;
  }
  
  .files-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
  }
  
  .file-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 20px;
    text-align: center;
    transition: transform 0.2s ease;
    cursor: pointer;
  }
  
  .file-card:hover {
    transform: translateY(-2px);
  }
  
  .file-icon {
    font-size: 48px;
    margin-bottom: 15px;
  }
  
  .file-info {
    text-align: left;
  }
  
  .file-name {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: #333;
    font-weight: bold;
    word-break: break-word;
  }
  
  .file-details {
    margin: 0 0 8px 0;
    font-size: 14px;
    color: #666;
    display: flex;
    justify-content: space-between;
  }
  
  .file-author {
    margin: 0 0 10px 0;
    font-size: 12px;
    color: #999;
  }
  
  .file-status {
    text-align: center;
  }
  
  .status-badge {
    display: inline-block;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    text-transform: uppercase;
  }
  
  .files-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .file-list-item {
    display: flex;
    align-items: center;
    background: white;
    border-radius: 8px;
    box-shadow: 0 1px 5px rgba(0,0,0,0.1);
    padding: 15px 20px;
    transition: transform 0.2s ease;
    cursor: pointer;
  }
  
  .file-list-item:hover {
    transform: translateY(-1px);
  }
  
  .list-file-icon {
    font-size: 24px;
    margin-right: 15px;
  }
  
  .list-file-info {
    flex: 1;
  }
  
  .list-file-name {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #333;
    font-weight: bold;
  }
  
  .list-file-details {
    margin: 0;
    font-size: 14px;
    color: #666;
    display: flex;
    gap: 20px;
  }
  
  .list-file-status {
    margin-left: 15px;
  }
  
  .list-status-badge {
    display: inline-block;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    text-transform: uppercase;
  }
  
  .context-menu {
    position: fixed;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    padding: 8px 0;
    z-index: 1000;
    min-width: 200px;
  }
  
  .context-menu-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 16px;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }
  
  .context-menu-item:hover {
    background: #f8f9fa;
  }
  
  .context-menu-item.danger:hover {
    background: #f8d7da;
    color: #721c24;
  }
  
  .context-icon {
    font-size: 16px;
    width: 20px;
    text-align: center;
  }
  
  .context-text {
    font-size: 14px;
    font-weight: 500;
  }
  
  .context-menu-divider {
    height: 1px;
    background: #e9ecef;
    margin: 4px 0;
  }
  
  @media (max-width: 768px) {
    .manager-controls {
      flex-direction: column;
      gap: 20px;
      align-items: stretch;
    }
    
    .control-group {
      justify-content: space-between;
    }
    
    .files-grid {
      grid-template-columns: 1fr;
    }
    
    .file-list-item {
      flex-direction: column;
      align-items: flex-start;
      gap: 10px;
    }
    
    .list-file-details {
      flex-direction: column;
      gap: 5px;
    }
    
    .list-file-status {
      margin-left: 0;
    }
  }
</style>

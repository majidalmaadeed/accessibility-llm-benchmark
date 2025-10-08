<script>
  let contextMenu = { visible: false, x: 0, y: 0, itemId: null };
  let selectedItem = null;
  let searchTerm = '';
  let selectedCategory = 'all';
  let currentPage = 1;
  const itemsPerPage = 8;

  const categories = [
    { id: 'all', name: 'All Files' },
    { id: 'documents', name: 'Documents' },
    { id: 'images', name: 'Images' },
    { id: 'videos', name: 'Videos' },
    { id: 'audio', name: 'Audio' },
    { id: 'archives', name: 'Archives' }
  ];

  const files = [
    {
      id: 1,
      name: 'Project Proposal.docx',
      type: 'document',
      category: 'documents',
      size: '2.3 MB',
      modified: '2024-01-15',
      author: 'John Smith',
      icon: '📄'
    },
    {
      id: 2,
      name: 'Team Photo.jpg',
      type: 'image',
      category: 'images',
      size: '4.1 MB',
      modified: '2024-01-14',
      author: 'Sarah Johnson',
      icon: '🖼️'
    },
    {
      id: 3,
      name: 'Product Demo.mp4',
      type: 'video',
      category: 'videos',
      size: '125.7 MB',
      modified: '2024-01-13',
      author: 'Mike Chen',
      icon: '🎥'
    },
    {
      id: 4,
      name: 'Meeting Notes.pdf',
      type: 'document',
      category: 'documents',
      size: '856 KB',
      modified: '2024-01-12',
      author: 'Lisa Rodriguez',
      icon: '📄'
    },
    {
      id: 5,
      name: 'Background Music.mp3',
      type: 'audio',
      category: 'audio',
      size: '8.2 MB',
      modified: '2024-01-11',
      author: 'David Wilson',
      icon: '🎵'
    },
    {
      id: 6,
      name: 'Data Backup.zip',
      type: 'archive',
      category: 'archives',
      size: '45.6 MB',
      modified: '2024-01-10',
      author: 'Emma Davis',
      icon: '📦'
    },
    {
      id: 7,
      name: 'Logo Design.png',
      type: 'image',
      category: 'images',
      size: '1.8 MB',
      modified: '2024-01-09',
      author: 'Tom Anderson',
      icon: '🖼️'
    },
    {
      id: 8,
      name: 'User Manual.pdf',
      type: 'document',
      category: 'documents',
      size: '3.4 MB',
      modified: '2024-01-08',
      author: 'Anna Garcia',
      icon: '📄'
    }
  ];

  $: filteredFiles = files.filter(file => {
    const matchesCategory = selectedCategory === 'all' || file.category === selectedCategory;
    const matchesSearch = file.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         file.author.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  $: totalPages = Math.ceil(filteredFiles.length / itemsPerPage);
  $: paginatedFiles = filteredFiles.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  function handleContextMenu(event, fileId) {
    event.preventDefault();
    contextMenu = {
      visible: true,
      x: event.clientX,
      y: event.clientY,
      itemId: fileId
    };
    selectedItem = fileId;
  }

  function handleClick() {
    contextMenu = { visible: false, x: 0, y: 0, itemId: null };
    selectedItem = null;
  }

  function handleContextAction(action) {
    const file = files.find(f => f.id === contextMenu.itemId);
    alert(`${action} action performed on "${file?.name}"`);
    contextMenu = { visible: false, x: 0, y: 0, itemId: null };
    selectedItem = null;
  }

  function handleFileAction(action, file) {
    alert(`${action} action performed on "${file.name}"`);
  }

  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  function goToPage(page) {
    currentPage = page;
  }

  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }

  function prevPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
</script>

<div class="file-manager" on:click={handleClick}>
  <header class="manager-header">
    <h1>File Manager</h1>
    <p>Right-click on files to access additional options</p>
  </header>

  <div class="manager-controls">
    <div class="search-section">
      <input 
        type="text" 
        placeholder="Search files..." 
        bind:value={searchTerm}
        class="search-input"
      />
    </div>

    <div class="filter-section">
      <select bind:value={selectedCategory} class="category-filter">
        {#each categories as category}
          <option value={category.id}>{category.name}</option>
        {/each}
      </select>
    </div>
  </div>

  <div class="files-container">
    <div class="files-header">
      <h2>Files ({filteredFiles.length})</h2>
      <div class="view-options">
        <button class="view-btn active">Grid View</button>
        <button class="view-btn">List View</button>
      </div>
    </div>

    <div class="files-grid">
      {#each paginatedFiles as file}
        <div 
          class="file-item {selectedItem === file.id ? 'selected' : ''}"
          on:contextmenu={(e) => handleContextMenu(e, file.id)}
        >
          <div class="file-icon">{file.icon}</div>
          
          <div class="file-info">
            <h3 class="file-name">{file.name}</h3>
            <div class="file-details">
              <span class="file-size">{file.size}</span>
              <span class="file-modified">{formatDate(file.modified)}</span>
              <span class="file-author">By {file.author}</span>
            </div>
          </div>

          <div class="file-actions">
            <button 
              class="action-btn primary" 
              on:click={() => handleFileAction('Open', file)}
            >
              Open
            </button>
            <button 
              class="action-btn secondary" 
              on:click={() => handleFileAction('Download', file)}
            >
              Download
            </button>
          </div>
        </div>
      {/each}
    </div>

    {#if totalPages > 1}
      <div class="pagination">
        <button 
          class="page-btn" 
          on:click={prevPage} 
          disabled={currentPage === 1}
        >
          Previous
        </button>
        
        {#each Array(totalPages) as _, i}
          <button 
            class="page-btn {currentPage === i + 1 ? 'active' : ''}" 
            on:click={() => goToPage(i + 1)}
          >
            {i + 1}
          </button>
        {/each}
        
        <button 
          class="page-btn" 
          on:click={nextPage} 
          disabled={currentPage === totalPages}
        >
          Next
        </button>
      </div>
    {/if}
  </div>

  {#if contextMenu.visible}
    <div 
      class="context-menu" 
      style="left: {contextMenu.x}px; top: {contextMenu.y}px;"
      on:click|stopPropagation
    >
      <div class="context-header">
        <span class="context-title">File Actions</span>
      </div>
      
      <div class="context-items">
        <div 
          class="context-item" 
          on:click={() => handleContextAction('Open')}
        >
          <span class="context-icon">👁️</span>
          <span class="context-text">Open</span>
        </div>
        
        <div 
          class="context-item" 
          on:click={() => handleContextAction('Download')}
        >
          <span class="context-icon">⬇️</span>
          <span class="context-text">Download</span>
        </div>
        
        <div 
          class="context-item" 
          on:click={() => handleContextAction('Rename')}
        >
          <span class="context-icon">✏️</span>
          <span class="context-text">Rename</span>
        </div>
        
        <div 
          class="context-item" 
          on:click={() => handleContextAction('Copy')}
        >
          <span class="context-icon">📋</span>
          <span class="context-text">Copy</span>
        </div>
        
        <div 
          class="context-item" 
          on:click={() => handleContextAction('Move')}
        >
          <span class="context-icon">📁</span>
          <span class="context-text">Move</span>
        </div>
        
        <div class="context-divider"></div>
        
        <div 
          class="context-item danger" 
          on:click={() => handleContextAction('Delete')}
        >
          <span class="context-icon">🗑️</span>
          <span class="context-text">Delete</span>
        </div>
      </div>
    </div>
  {/if}

  <div class="manager-info">
    <h3>File Manager Instructions</h3>
    <div class="info-content">
      <div class="info-item">
        <span class="info-icon">🖱️</span>
        <div class="info-text">
          <h4>Right-Click Menu</h4>
          <p>Right-click on any file to access additional options like rename, copy, move, or delete</p>
        </div>
      </div>
      
      <div class="info-item">
        <span class="info-icon">⌨️</span>
        <div class="info-text">
          <h4>Keyboard Access</h4>
          <p>Essential actions like delete are only available through right-click context menu</p>
        </div>
      </div>
      
      <div class="info-item">
        <span class="info-icon">⚠️</span>
        <div class="info-text">
          <h4>Accessibility Issue</h4>
          <p>This demonstrates an accessibility problem where critical functions are only available via right-click</p>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .file-manager {
    max-width: 1200px;
    margin: 50px auto;
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
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .search-section {
    flex: 1;
    max-width: 400px;
  }

  .search-input {
    width: 100%;
    padding: 10px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
  }

  .search-input:focus {
    outline: none;
    border-color: #007bff;
  }

  .filter-section {
    margin-left: 20px;
  }

  .category-filter {
    padding: 10px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    background: white;
    font-size: 16px;
  }

  .files-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 30px;
  }

  .files-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
  }

  .files-header h2 {
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

  .files-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .file-item {
    border: 2px solid #eee;
    border-radius: 8px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.2s ease;
    position: relative;
  }

  .file-item:hover {
    border-color: #007bff;
    box-shadow: 0 4px 12px rgba(0,123,255,0.1);
  }

  .file-item.selected {
    border-color: #007bff;
    background: #e3f2fd;
  }

  .file-icon {
    font-size: 48px;
    text-align: center;
    margin-bottom: 15px;
  }

  .file-info {
    text-align: center;
    margin-bottom: 15px;
  }

  .file-name {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: #333;
    word-break: break-word;
  }

  .file-details {
    display: flex;
    flex-direction: column;
    gap: 4px;
    font-size: 12px;
    color: #666;
  }

  .file-actions {
    display: flex;
    gap: 8px;
  }

  .action-btn {
    flex: 1;
    padding: 8px 12px;
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

  .pagination {
    display: flex;
    justify-content: center;
    gap: 8px;
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

  .context-menu {
    position: fixed;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 1000;
    min-width: 200px;
    overflow: hidden;
  }

  .context-header {
    background: #f8f9fa;
    padding: 10px 15px;
    border-bottom: 1px solid #eee;
  }

  .context-title {
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }

  .context-items {
    padding: 5px 0;
  }

  .context-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 15px;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .context-item:hover {
    background: #f8f9fa;
  }

  .context-item.danger:hover {
    background: #f8d7da;
  }

  .context-icon {
    font-size: 16px;
    width: 20px;
    text-align: center;
  }

  .context-text {
    font-size: 14px;
    color: #333;
  }

  .context-item.danger .context-text {
    color: #dc3545;
  }

  .context-divider {
    height: 1px;
    background: #eee;
    margin: 5px 0;
  }

  .manager-info {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 8px;
  }

  .manager-info h3 {
    margin: 0 0 20px 0;
    font-size: 24px;
    color: #333;
  }

  .info-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }

  .info-item {
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }

  .info-icon {
    font-size: 24px;
    flex-shrink: 0;
  }

  .info-text h4 {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #333;
  }

  .info-text p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  @media (max-width: 768px) {
    .manager-controls {
      flex-direction: column;
      gap: 15px;
    }

    .filter-section {
      margin-left: 0;
    }

    .files-grid {
      grid-template-columns: 1fr;
    }

    .context-menu {
      position: relative;
      left: 0 !important;
      top: 0 !important;
      margin-top: 10px;
    }
  }
</style>

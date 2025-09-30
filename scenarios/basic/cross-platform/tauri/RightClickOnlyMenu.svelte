<script>
  import { onMount, onDestroy } from 'svelte';
  
  let files = [
    { id: 1, name: 'document.pdf', type: 'PDF', size: '2.5 MB', modified: '2 hours ago' },
    { id: 2, name: 'spreadsheet.xlsx', type: 'Excel', size: '1.8 MB', modified: '1 day ago' },
    { id: 3, name: 'presentation.pptx', type: 'PowerPoint', size: '3.2 MB', modified: '3 hours ago' },
    { id: 4, name: 'image.jpg', type: 'Image', size: '4.1 MB', modified: '5 hours ago' },
    { id: 5, name: 'video.mp4', type: 'Video', size: '15.7 MB', modified: '1 week ago' },
    { id: 6, name: 'archive.zip', type: 'Archive', size: '8.3 MB', modified: '2 days ago' }
  ];
  
  let contextMenu = {
    visible: false,
    x: 0,
    y: 0,
    fileId: null
  };
  
  function handleContextMenu(event, fileId) {
    event.preventDefault();
    contextMenu = {
      visible: true,
      x: event.clientX,
      y: event.clientY,
      fileId: fileId
    };
  }
  
  function hideContextMenu() {
    contextMenu.visible = false;
  }
  
  function handleContextAction(action) {
    const file = files.find(f => f.id === contextMenu.fileId);
    if (file) {
      alert(`Action: ${action} on file: ${file.name}`);
    }
    hideContextMenu();
  }
  
  function handleFileAction(fileId, action) {
    const file = files.find(f => f.id === fileId);
    if (file) {
      alert(`Action: ${action} on file: ${file.name}`);
    }
  }
  
  function handleKeydown(event) {
    if (event.key === 'Escape' && contextMenu.visible) {
      hideContextMenu();
    }
  }
  
  onMount(() => {
    document.addEventListener('keydown', handleKeydown);
    document.addEventListener('click', hideContextMenu);
  });
  
  onDestroy(() => {
    document.removeEventListener('keydown', handleKeydown);
    document.removeEventListener('click', hideContextMenu);
  });
</script>

<div class="file-manager">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">File Manager</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('New Folder clicked')}>
          📁 New Folder
        </button>
        <button class="header-btn" on:click={() => alert('Upload clicked')}>
          📤 Upload
        </button>
        <button class="header-btn" on:click={() => alert('Settings clicked')}>
          ⚙️ Settings
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="toolbar">
      <div class="toolbar-group">
        <button class="toolbar-btn" on:click={() => alert('View clicked')}>
          👁️ View
        </button>
        <button class="toolbar-btn" on:click={() => alert('Sort clicked')}>
          ↕️ Sort
        </button>
        <button class="toolbar-btn" on:click={() => alert('Filter clicked')}>
          🔍 Filter
        </button>
      </div>
      
      <div class="toolbar-group">
        <button class="toolbar-btn" on:click={() => alert('Select All clicked')}>
          ☑️ Select All
        </button>
        <button class="toolbar-btn" on:click={() => alert('Deselect clicked')}>
          ☐ Deselect
        </button>
      </div>
    </div>
    
    <div class="files-container">
      <div class="files-grid">
        {#each files as file}
          <div 
            class="file-item" 
            on:contextmenu={(e) => handleContextMenu(e, file.id)}
            on:click={() => handleFileAction(file.id, 'Open')}
          >
            <div class="file-icon">
              {#if file.type === 'PDF'}
                📄
              {:else if file.type === 'Excel'}
                📊
              {:else if file.type === 'PowerPoint'}
                📽️
              {:else if file.type === 'Image'}
                🖼️
              {:else if file.type === 'Video'}
                🎥
              {:else if file.type === 'Archive'}
                📦
              {:else}
                📁
              {/if}
            </div>
            
            <div class="file-info">
              <div class="file-name">{file.name}</div>
              <div class="file-details">
                <span class="file-type">{file.type}</span>
                <span class="file-size">{file.size}</span>
              </div>
              <div class="file-modified">Modified: {file.modified}</div>
            </div>
            
            <div class="file-actions">
              <button 
                class="action-btn" 
                on:click|stopPropagation={() => handleFileAction(file.id, 'View')}
                title="View"
              >
                👁️
              </button>
              <button 
                class="action-btn" 
                on:click|stopPropagation={() => handleFileAction(file.id, 'Download')}
                title="Download"
              >
                📥
              </button>
              <button 
                class="action-btn" 
                on:click|stopPropagation={() => handleFileAction(file.id, 'Share')}
                title="Share"
              >
                📤
              </button>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </main>
  
  <!-- RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click -->
  {#if contextMenu.visible}
    <div 
      class="context-menu" 
      style="left: {contextMenu.x}px; top: {contextMenu.y}px;"
      on:click|stopPropagation
    >
      <div class="context-menu-item" on:click={() => handleContextAction('Open')}>
        <span class="context-icon">👁️</span>
        <span class="context-text">Open</span>
      </div>
      
      <div class="context-menu-item" on:click={() => handleContextAction('Download')}>
        <span class="context-icon">📥</span>
        <span class="context-text">Download</span>
      </div>
      
      <div class="context-menu-item" on:click={() => handleContextAction('Rename')}>
        <span class="context-icon">✏️</span>
        <span class="context-text">Rename</span>
      </div>
      
      <div class="context-menu-item" on:click={() => handleContextAction('Copy')}>
        <span class="context-icon">📋</span>
        <span class="context-text">Copy</span>
      </div>
      
      <div class="context-menu-item" on:click={() => handleContextAction('Move')}>
        <span class="context-icon">📁</span>
        <span class="context-text">Move</span>
      </div>
      
      <div class="context-menu-separator"></div>
      
      <!-- RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click -->
      <div class="context-menu-item danger" on:click={() => handleContextAction('Delete')}>
        <span class="context-icon">🗑️</span>
        <span class="context-text">Delete</span>
      </div>
      
      <div class="context-menu-item" on:click={() => handleContextAction('Properties')}>
        <span class="context-icon">ℹ️</span>
        <span class="context-text">Properties</span>
      </div>
    </div>
  {/if}
  
  <div class="status-bar">
    <div class="status-info">
      <span class="status-item">Ready</span>
      <span class="status-item">Files: {files.length}</span>
    </div>
    <div class="status-actions">
      <button class="status-btn" on:click={() => alert('Refresh clicked')}>
        🔄
      </button>
      <button class="status-btn" on:click={() => alert('Help clicked')}>
        ❓
      </button>
    </div>
  </div>
</div>

<style>
  .file-manager {
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
    padding: 20px;
  }
  
  .toolbar {
    background: white;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    display: flex;
    gap: 20px;
    align-items: center;
  }
  
  .toolbar-group {
    display: flex;
    gap: 10px;
  }
  
  .toolbar-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .toolbar-btn:hover {
    background: #f8f9fa;
  }
  
  .files-container {
    background: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .files-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
  }
  
  .file-item {
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.2s;
    position: relative;
  }
  
  .file-item:hover {
    background: #e9ecef;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
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
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
    word-break: break-word;
  }
  
  .file-details {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #666;
    margin-bottom: 5px;
  }
  
  .file-modified {
    font-size: 11px;
    color: #999;
  }
  
  .file-actions {
    display: flex;
    gap: 8px;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s;
  }
  
  .file-item:hover .file-actions {
    opacity: 1;
  }
  
  .action-btn {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .context-menu {
    position: fixed;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    padding: 8px 0;
    z-index: 1000;
    min-width: 150px;
  }
  
  .context-menu-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 16px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: background-color 0.2s;
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
    font-size: 16px;
    width: 20px;
    text-align: center;
  }
  
  .context-text {
    flex: 1;
  }
  
  .context-menu-separator {
    height: 1px;
    background: #eee;
    margin: 4px 0;
  }
  
  .status-bar {
    background: #f8f9fa;
    border-top: 1px solid #ddd;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    color: #666;
  }
  
  .status-info {
    display: flex;
    gap: 20px;
  }
  
  .status-item {
    font-weight: bold;
  }
  
  .status-actions {
    display: flex;
    gap: 10px;
  }
  
  .status-btn {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .status-btn:hover {
    background: #f8f9fa;
  }
  
  @media (max-width: 768px) {
    .files-grid {
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    }
    
    .toolbar {
      flex-direction: column;
      gap: 10px;
    }
    
    .toolbar-group {
      justify-content: center;
    }
  }
</style>

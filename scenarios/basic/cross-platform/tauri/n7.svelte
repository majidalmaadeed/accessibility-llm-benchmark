<script>
  import { onMount } from 'svelte';
  
  let currentView = 'dashboard';
  let isEditing = false;
  let documents = [
    { id: 1, name: 'Project Proposal.docx', status: 'draft' },
    { id: 2, name: 'Budget Report.xlsx', status: 'review' },
    { id: 3, name: 'Meeting Notes.pdf', status: 'final' },
    { id: 4, name: 'Design Mockups.png', status: 'draft' }
  ];
  
  function switchView(view) {
    currentView = view;
  }
  
  function toggleEdit() {
    isEditing = !isEditing;
  }
  
  function handleAction(action) {
    alert(`Action: ${action}`);
  }
  
  function handleDocumentAction(docId, action) {
    alert(`Document ${docId}: ${action}`);
  }
</script>

<div class="document-editor">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Document Editor</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => handleAction('Save')}>
          💾 Save
        </button>
        <button class="header-btn" on:click={() => handleAction('Export')}>
          📤 Export
        </button>
        <button class="header-btn" on:click={() => handleAction('Print')}>
          🖨️ Print
        </button>
      </div>
    </div>
  </header>
  
  <div class="toolbar">
    <div class="toolbar-group">
      <!-- INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart -->
      <button class="toolbar-btn" on:click={() => handleAction('New')}>
        📄 New
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Open')}>
        📁 Open
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Save')}>
        💾 Save
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Save As')}>
        💾 Save As
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Close')}>
        ❌ Close
      </button>
    </div>
    
    <div class="toolbar-group">
      <!-- INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart -->
      <button class="toolbar-btn" on:click={() => handleAction('Bold')}>
        <strong>B</strong>
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Italic')}>
        <em>I</em>
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Underline')}>
        <u>U</u>
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Strikethrough')}>
        <s>S</s>
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Superscript')}>
        X²
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Subscript')}>
        X₂
      </button>
    </div>
    
    <div class="toolbar-group">
      <!-- INSUFFICIENT BUTTON SPACING - Alignment buttons placed 2px apart -->
      <button class="toolbar-btn" on:click={() => handleAction('Align Left')}>
        ⬅️
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Align Center')}>
        ↔️
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Align Right')}>
        ➡️
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Justify')}>
        ⬅️➡️
      </button>
    </div>
    
    <div class="toolbar-group">
      <!-- INSUFFICIENT BUTTON SPACING - List buttons placed 2px apart -->
      <button class="toolbar-btn" on:click={() => handleAction('Bullet List')}>
        • List
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Numbered List')}>
        1. List
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Indent')}>
        ➡️ Indent
      </button>
      <button class="toolbar-btn" on:click={() => handleAction('Outdent')}>
        ⬅️ Outdent
      </button>
    </div>
  </div>
  
  <div class="formatting-toolbar">
    <div class="formatting-group">
      <!-- INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart -->
      <button class="format-btn" on:click={() => handleAction('Font Size')}>
        A
      </button>
      <button class="format-btn" on:click={() => handleAction('Font Color')}>
        🎨
      </button>
      <button class="format-btn" on:click={() => handleAction('Highlight')}>
        🖍️
      </button>
      <button class="format-btn" on:click={() => handleAction('Background')}>
        🎨
      </button>
      <button class="format-btn" on:click={() => handleAction('Border')}>
        ⬜
      </button>
      <button class="format-btn" on:click={() => handleAction('Shadow')}>
        🌫️
      </button>
    </div>
  </div>
  
  <div class="quick-actions">
    <div class="quick-actions-group">
      <!-- INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart -->
      <button class="quick-btn" on:click={() => handleAction('Undo')}>
        ↶
      </button>
      <button class="quick-btn" on:click={() => handleAction('Redo')}>
        ↷
      </button>
      <button class="quick-btn" on:click={() => handleAction('Cut')}>
        ✂️
      </button>
      <button class="quick-btn" on:click={() => handleAction('Copy')}>
        📋
      </button>
      <button class="quick-btn" on:click={() => handleAction('Paste')}>
        📄
      </button>
      <button class="quick-btn" on:click={() => handleAction('Find')}>
        🔍
      </button>
      <button class="quick-btn" on:click={() => handleAction('Replace')}>
        🔄
      </button>
    </div>
  </div>
  
  <main class="main-content">
    <div class="sidebar">
      <div class="sidebar-section">
        <h3 class="sidebar-title">Documents</h3>
        <div class="document-list">
          {#each documents as doc}
            <div class="document-item">
              <div class="document-info">
                <div class="document-icon">📄</div>
                <div class="document-details">
                  <div class="document-name">{doc.name}</div>
                  <div class="document-status">{doc.status}</div>
                </div>
              </div>
              <div class="document-actions">
                <!-- INSUFFICIENT BUTTON SPACING - Document action buttons placed 2px apart -->
                <button class="doc-btn" on:click={() => handleDocumentAction(doc.id, 'Edit')}>
                  ✏️
                </button>
                <button class="doc-btn" on:click={() => handleDocumentAction(doc.id, 'Delete')}>
                  🗑️
                </button>
                <button class="doc-btn" on:click={() => handleDocumentAction(doc.id, 'Share')}>
                  📤
                </button>
                <button class="doc-btn" on:click={() => handleDocumentAction(doc.id, 'Download')}>
                  📥
                </button>
              </div>
            </div>
          {/each}
        </div>
      </div>
    </div>
    
    <div class="editor-area">
      <div class="editor-toolbar">
        <div class="editor-toolbar-group">
          <!-- INSUFFICIENT BUTTON SPACING - Editor toolbar buttons placed 2px apart -->
          <button class="editor-btn" on:click={() => handleAction('Insert Table')}>
            ⬜ Table
          </button>
          <button class="editor-btn" on:click={() => handleAction('Insert Image')}>
            🖼️ Image
          </button>
          <button class="editor-btn" on:click={() => handleAction('Insert Link')}>
            🔗 Link
          </button>
          <button class="editor-btn" on:click={() => handleAction('Insert Chart')}>
            📊 Chart
          </button>
          <button class="editor-btn" on:click={() => handleAction('Insert Shape')}>
            ⬜ Shape
          </button>
          <button class="editor-btn" on:click={() => handleAction('Insert Text Box')}>
            📝 Text
          </button>
        </div>
      </div>
      
      <div class="editor-content" contenteditable={isEditing}>
        <h2>Sample Document</h2>
        <p>This is a sample document content. You can edit this text when in edit mode.</p>
        <p>The toolbar above demonstrates insufficient button spacing with only 2px gaps between action buttons, which makes it difficult for users to accurately click on the intended button, especially on touch devices.</p>
        <p>This violates accessibility guidelines that recommend a minimum of 44px touch target size and adequate spacing between interactive elements.</p>
        
        <h3>Key Features</h3>
        <ul>
          <li>Real-time collaboration</li>
          <li>Version control</li>
          <li>Cloud synchronization</li>
          <li>Advanced formatting options</li>
        </ul>
      </div>
    </div>
  </main>
  
  <div class="status-bar">
    <div class="status-info">
      <span class="status-item">Ready</span>
      <span class="status-item">Words: 45</span>
      <span class="status-item">Characters: 280</span>
    </div>
    <div class="status-actions">
      <!-- INSUFFICIENT BUTTON SPACING - Status bar buttons placed 2px apart -->
      <button class="status-btn" on:click={() => handleAction('Zoom In')}>
        🔍+
      </button>
      <button class="status-btn" on:click={() => handleAction('Zoom Out')}>
        🔍-
      </button>
      <button class="status-btn" on:click={() => handleAction('Full Screen')}>
        ⛶
      </button>
      <button class="status-btn" on:click={() => handleAction('Settings')}>
        ⚙️
      </button>
    </div>
  </div>
</div>

<style>
  .document-editor {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    display: flex;
    flex-direction: column;
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
  
  .toolbar {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 10px 20px;
    display: flex;
    gap: 20px;
    align-items: center;
    flex-wrap: wrap;
  }
  
  .toolbar-group {
    display: flex;
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart */
  }
  
  .toolbar-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .toolbar-btn:hover {
    background: #f8f9fa;
  }
  
  .toolbar-btn:active {
    background: #e9ecef;
  }
  
  .formatting-toolbar {
    background: #f8f9fa;
    border-bottom: 1px solid #ddd;
    padding: 10px 20px;
  }
  
  .formatting-group {
    display: flex;
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart */
    justify-content: center;
  }
  
  .format-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .format-btn:hover {
    background: #f8f9fa;
  }
  
  .format-btn:active {
    background: #e9ecef;
  }
  
  .quick-actions {
    background: #f8f9fa;
    border-bottom: 1px solid #ddd;
    padding: 10px 20px;
  }
  
  .quick-actions-group {
    display: flex;
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart */
    justify-content: center;
  }
  
  .quick-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
  }
  
  .quick-btn:hover {
    background: #f8f9fa;
  }
  
  .quick-btn:active {
    background: #e9ecef;
  }
  
  .main-content {
    flex: 1;
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    width: 100%;
  }
  
  .sidebar {
    width: 250px;
    background: white;
    border-right: 1px solid #ddd;
    padding: 20px;
  }
  
  .sidebar-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0 0 20px 0;
  }
  
  .document-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .document-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: #f8f9fa;
  }
  
  .document-info {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .document-icon {
    font-size: 20px;
  }
  
  .document-details {
    display: flex;
    flex-direction: column;
  }
  
  .document-name {
    font-size: 14px;
    font-weight: bold;
    color: #333;
  }
  
  .document-status {
    font-size: 12px;
    color: #666;
  }
  
  .document-actions {
    display: flex;
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Document action buttons placed 2px apart */
  }
  
  .doc-btn {
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
  
  .doc-btn:hover {
    background: #f8f9fa;
  }
  
  .doc-btn:active {
    background: #e9ecef;
  }
  
  .editor-area {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .editor-toolbar {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 10px 20px;
  }
  
  .editor-toolbar-group {
    display: flex;
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Editor toolbar buttons placed 2px apart */
  }
  
  .editor-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .editor-btn:hover {
    background: #f8f9fa;
  }
  
  .editor-btn:active {
    background: #e9ecef;
  }
  
  .editor-content {
    flex: 1;
    padding: 30px;
    background: white;
    font-size: 16px;
    line-height: 1.6;
    color: #333;
    min-height: 400px;
  }
  
  .editor-content:focus {
    outline: none;
  }
  
  .editor-content h2 {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 20px 0;
  }
  
  .editor-content h3 {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin: 20px 0 15px 0;
  }
  
  .editor-content p {
    margin: 0 0 15px 0;
  }
  
  .editor-content ul {
    margin: 0 0 15px 0;
    padding-left: 20px;
  }
  
  .editor-content li {
    margin-bottom: 5px;
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
    gap: 2px; /* INSUFFICIENT BUTTON SPACING - Status bar buttons placed 2px apart */
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
  
  .status-btn:active {
    background: #e9ecef;
  }
  
  @media (max-width: 768px) {
    .toolbar {
      flex-direction: column;
      gap: 10px;
    }
    
    .toolbar-group {
      justify-content: center;
    }
    
    .main-content {
      flex-direction: column;
    }
    
    .sidebar {
      width: 100%;
      border-right: none;
      border-bottom: 1px solid #ddd;
    }
    
    .document-actions {
      gap: 5px;
    }
    
    .status-actions {
      gap: 5px;
    }
  }
</style>
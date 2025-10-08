<script>
  export let data
  
  let editorData = null
  let documentContent = ''
  let wordCount = 0
  let charCount = 0
  let pageCount = 1
  let fontFamily = 'Arial'
  let fontSize = 16
  let textColor = '#000000'
  let backgroundColor = 'transparent'
  let isBold = false
  let isItalic = false
  let isUnderline = false
  let isStrikethrough = false
  let alignment = 'left'
  let showInsertMenu = false
  
  $: {
    if (data) {
      editorData = JSON.parse(data)
      documentContent = editorData.document.content || ''
      fontFamily = editorData.settings.fontFamily || 'Arial'
      fontSize = editorData.settings.fontSize || 16
      textColor = editorData.settings.textColor || '#000000'
      backgroundColor = editorData.settings.backgroundColor || 'transparent'
    }
  }
  
  $: {
    wordCount = documentContent.trim() ? documentContent.trim().split(/\s+/).length : 0
    charCount = documentContent.length
    pageCount = Math.ceil(charCount / 2000)
  }
  
  function updateWordCount() {
    // Word count is automatically updated via reactive statements
  }
  
  function formatText(command) {
    // This would implement text formatting
    alert(`Format text: ${command}`)
  }
  
  function changeFontFamily() {
    // Font family is bound to the select element
  }
  
  function changeFontSize() {
    // Font size is bound to the input element
  }
  
  function setTextColor(color) {
    textColor = color
  }
  
  function setBackgroundColor(color) {
    backgroundColor = color
  }
  
  function insertList(type) {
    const listText = type === 'unordered' ? '• \n• \n• ' : '1. \n2. \n3. '
    documentContent += '\n' + listText
  }
  
  function insertTable() {
    const tableText = '\n| Column 1 | Column 2 | Column 3 |\n|----------|----------|----------|\n| Row 1    | Data 1   | Data 2   |\n| Row 2    | Data 3   | Data 4   |\n'
    documentContent += tableText
  }
  
  function insertImage() {
    const url = prompt('Enter image URL:')
    if (url) {
      documentContent += `\n![Image](${url})\n`
    }
  }
  
  function insertLink() {
    const url = prompt('Enter URL:')
    const text = prompt('Enter link text:')
    if (url && text) {
      documentContent += `[${text}](${url})`
    }
  }
  
  function insertHorizontalRule() {
    documentContent += '\n---\n'
  }
  
  function findReplace() {
    const findText = prompt('Find:')
    if (findText) {
      const replaceText = prompt('Replace with:')
      documentContent = documentContent.replace(new RegExp(findText, 'g'), replaceText)
    }
  }
  
  function toggleSpellCheck() {
    alert('Spell check toggled')
  }
  
  function openDocument() {
    alert('Open document')
  }
  
  function saveDocument() {
    alert('Save document')
  }
  
  function exportDocument() {
    const format = prompt('Export format (html, pdf, docx):')
    if (format) {
      alert(`Exporting as ${format.toUpperCase()}...`)
    }
  }
  
  function printDocument() {
    window.print()
  }
  
  function showColorMenu(type) {
    alert(`Select ${type} color`)
  }
</script>

<div class="editor-container">
  <div class="editor-header">
    <h1>Document Editor</h1>
    <div class="editor-actions">
      <button class="action-btn" on:click={openDocument}>Open</button>
      <button class="action-btn" on:click={saveDocument}>Save</button>
      <button class="action-btn" on:click={exportDocument}>Export</button>
      <button class="action-btn primary" on:click={printDocument}>Print</button>
    </div>
  </div>
  
  <div class="toolbar">
    <div class="toolbar-group">
      <button class="toolbar-btn" on:click={() => alert('Undo')} title="Undo">↶</button>
      <button class="toolbar-btn" on:click={() => alert('Redo')} title="Redo">↷</button>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <button class="toolbar-btn" class:active={isBold} on:click={() => isBold = !isBold} title="Bold">B</button>
      <button class="toolbar-btn" class:active={isItalic} on:click={() => isItalic = !isItalic} title="Italic">I</button>
      <button class="toolbar-btn" class:active={isUnderline} on:click={() => isUnderline = !isUnderline} title="Underline">U</button>
      <button class="toolbar-btn" class:active={isStrikethrough} on:click={() => isStrikethrough = !isStrikethrough} title="Strikethrough">S</button>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <button class="toolbar-btn" class:active={alignment === 'left'} on:click={() => alignment = 'left'} title="Align Left">⫸</button>
      <button class="toolbar-btn" class:active={alignment === 'center'} on:click={() => alignment = 'center'} title="Align Center">⫷</button>
      <button class="toolbar-btn" class:active={alignment === 'right'} on:click={() => alignment = 'right'} title="Align Right">⫸</button>
      <button class="toolbar-btn" class:active={alignment === 'justify'} on:click={() => alignment = 'justify'} title="Justify">⫸</button>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <select bind:value={fontFamily} on:change={changeFontFamily}>
        <option value="Arial">Arial</option>
        <option value="Times New Roman">Times New Roman</option>
        <option value="Georgia">Georgia</option>
        <option value="Verdana">Verdana</option>
        <option value="Courier New">Courier New</option>
      </select>
      <select bind:value={fontSize} on:change={changeFontSize}>
        <option value="12">12px</option>
        <option value="14">14px</option>
        <option value="16">16px</option>
        <option value="18">18px</option>
        <option value="20">20px</option>
        <option value="24">24px</option>
        <option value="32">32px</option>
      </select>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <button class="toolbar-btn" on:click={() => showColorMenu('text')} title="Text Color">A</button>
      <button class="toolbar-btn" on:click={() => showColorMenu('highlight')} title="Highlight">🖍</button>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <button class="toolbar-btn" on:click={() => insertList('unordered')} title="Bullet List">•</button>
      <button class="toolbar-btn" on:click={() => insertList('ordered')} title="Numbered List">1.</button>
      <button class="toolbar-btn" on:click={insertTable} title="Insert Table">⊞</button>
    </div>
    
    <div class="toolbar-separator"></div>
    
    <div class="toolbar-group">
      <button class="toolbar-btn" on:click={() => showInsertMenu = !showInsertMenu} title="Insert">+</button>
      <button class="toolbar-btn" on:click={findReplace} title="Find & Replace">🔍</button>
      <button class="toolbar-btn" on:click={toggleSpellCheck} title="Spell Check">✓</button>
    </div>
  </div>
  
  <div class="editor-content">
    <div class="editor-main">
      <textarea class="editor-textarea" 
                bind:value={documentContent}
                style="font-family: {fontFamily}; font-size: {fontSize}px; color: {textColor}; background-color: {backgroundColor}; text-align: {alignment};"
                placeholder="Start typing your document here..."></textarea>
      <div class="word-count">
        <div class="word-count-item">
          <span>Words: <span class="word-count-value">{wordCount}</span></span>
          <span>Characters: <span class="word-count-value">{charCount}</span></span>
          <span>Pages: <span class="word-count-value">{pageCount}</span></span>
        </div>
        <div>
          <span>Last saved: <span class="word-count-value">Never</span></span>
        </div>
      </div>
    </div>
    
    <div class="editor-sidebar">
      <div class="sidebar-section">
        <h3>Text Formatting</h3>
        <div class="style-panel">
          <div class="style-group">
            <label>Font Family</label>
            <select bind:value={fontFamily} on:change={changeFontFamily}>
              <option value="Arial">Arial</option>
              <option value="Times New Roman">Times New Roman</option>
              <option value="Georgia">Georgia</option>
              <option value="Verdana">Verdana</option>
              <option value="Courier New">Courier New</option>
            </select>
          </div>
          <div class="style-group">
            <label>Font Size</label>
            <input type="number" bind:value={fontSize} min="8" max="72" on:change={changeFontSize}>
          </div>
          <div class="style-group">
            <label>Text Color</label>
            <div class="color-picker">
              <div class="color-option" style="background: #000000;" on:click={() => setTextColor('#000000')}></div>
              <div class="color-option" style="background: #333333;" on:click={() => setTextColor('#333333')}></div>
              <div class="color-option" style="background: #666666;" on:click={() => setTextColor('#666666')}></div>
              <div class="color-option" style="background: #999999;" on:click={() => setTextColor('#999999')}></div>
              <div class="color-option" style="background: #ff0000;" on:click={() => setTextColor('#ff0000')}></div>
              <div class="color-option" style="background: #00ff00;" on:click={() => setTextColor('#00ff00')}></div>
              <div class="color-option" style="background: #0000ff;" on:click={() => setTextColor('#0000ff')}></div>
              <div class="color-option" style="background: #ffff00;" on:click={() => setTextColor('#ffff00')}></div>
            </div>
          </div>
          <div class="style-group">
            <label>Highlight Color</label>
            <div class="color-picker">
              <div class="color-option" style="background: #ffff00;" on:click={() => setBackgroundColor('#ffff00')}></div>
              <div class="color-option" style="background: #00ffff;" on:click={() => setBackgroundColor('#00ffff')}></div>
              <div class="color-option" style="background: #ff00ff;" on:click={() => setBackgroundColor('#ff00ff')}></div>
              <div class="color-option" style="background: #00ff00;" on:click={() => setBackgroundColor('#00ff00')}></div>
              <div class="color-option" style="background: #ffa500;" on:click={() => setBackgroundColor('#ffa500')}></div>
              <div class="color-option" style="background: #ffc0cb;" on:click={() => setBackgroundColor('#ffc0cb')}></div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Insert Media</h3>
        <div class="media-insert" on:click={insertImage}>
          <div class="media-insert-icon">🖼️</div>
          <div class="media-insert-text">Insert Image</div>
        </div>
        <div class="media-insert" on:click={insertLink}>
          <div class="media-insert-icon">🔗</div>
          <div class="media-insert-text">Insert Link</div>
        </div>
        <div class="media-insert" on:click={insertTable}>
          <div class="media-insert-icon">📊</div>
          <div class="media-insert-text">Insert Table</div>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Document History</h3>
        <div class="history-controls">
          <button class="history-btn" on:click={() => alert('Undo')}>Undo</button>
          <button class="history-btn" on:click={() => alert('Redo')}>Redo</button>
        </div>
        <div class="document-stats">
          <div class="stat-item">
            <span class="stat-label">Created:</span>
            <span class="stat-value">Today</span>
          </div>
          <div class="stat-item">
            <span class="stat-label">Modified:</span>
            <span class="stat-value">Just now</span>
          </div>
          <div class="stat-item">
            <span class="stat-label">Version:</span>
            <span class="stat-value">1.0</span>
          </div>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Formatting Preview</h3>
        <div class="formatting-preview" style="font-family: {fontFamily}; font-size: {fontSize}px; color: {textColor}; background-color: {backgroundColor};">
          <p>Sample text preview</p>
        </div>
      </div>
    </div>
  </div>
</div>

{#if showInsertMenu}
  <div class="insert-menu">
    <div class="insert-item" on:click={insertImage}>
      <span class="insert-item-icon">🖼️</span>Image
    </div>
    <div class="insert-item" on:click={insertLink}>
      <span class="insert-item-icon">🔗</span>Link
    </div>
    <div class="insert-item" on:click={insertTable}>
      <span class="insert-item-icon">📊</span>Table
    </div>
    <div class="insert-item" on:click={() => insertList('unordered')}>
      <span class="insert-item-icon">•</span>Bullet List
    </div>
    <div class="insert-item" on:click={() => insertList('ordered')}>
      <span class="insert-item-icon">1.</span>Numbered List
    </div>
    <div class="insert-item" on:click={insertHorizontalRule}>
      <span class="insert-item-icon">—</span>Horizontal Rule
    </div>
  </div>
{/if}

<style>
  .editor-container {
    max-width: 1200px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .editor-header {
    background: #f8f9fa;
    padding: 15px 20px;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .editor-header h1 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }
  
  .editor-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .action-btn.primary {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .action-btn.primary:hover {
    background: #0056b3;
  }
  
  .toolbar {
    background: #f8f9fa;
    padding: 10px 20px;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    align-items: center;
  }
  
  .toolbar-group {
    display: flex;
    gap: 2px;
    margin-right: 15px;
    padding-right: 15px;
    border-right: 1px solid #ddd;
  }
  
  .toolbar-group:last-child {
    border-right: none;
    margin-right: 0;
  }
  
  .toolbar-btn {
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
  
  .toolbar-btn:hover {
    background: #e9ecef;
  }
  
  .toolbar-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .toolbar-separator {
    width: 1px;
    height: 24px;
    background: #ddd;
    margin: 0 8px;
  }
  
  .toolbar-group select {
    padding: 6px 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    font-size: 12px;
    cursor: pointer;
  }
  
  .editor-content {
    display: flex;
    min-height: 600px;
  }
  
  .editor-main {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .editor-textarea {
    flex: 1;
    border: none;
    padding: 20px;
    font-size: 16px;
    line-height: 1.6;
    resize: none;
    outline: none;
    font-family: 'Times New Roman', serif;
  }
  
  .editor-textarea:focus {
    outline: none;
  }
  
  .editor-sidebar {
    width: 300px;
    background: #f8f9fa;
    border-left: 1px solid #e9ecef;
    padding: 20px;
  }
  
  .sidebar-section {
    margin-bottom: 30px;
  }
  
  .sidebar-section h3 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 15px;
    color: #333;
  }
  
  .style-panel {
    background: white;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    padding: 15px;
  }
  
  .style-group {
    margin-bottom: 15px;
  }
  
  .style-group:last-child {
    margin-bottom: 0;
  }
  
  .style-group label {
    display: block;
    margin-bottom: 5px;
    font-size: 14px;
    font-weight: 600;
    color: #666;
  }
  
  .style-group input,
  .style-group select {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .color-picker {
    display: flex;
    gap: 5px;
    flex-wrap: wrap;
  }
  
  .color-option {
    width: 24px;
    height: 24px;
    border: 2px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    transition: transform 0.2s ease;
  }
  
  .color-option:hover {
    transform: scale(1.1);
  }
  
  .media-insert {
    background: white;
    border: 2px dashed #ddd;
    border-radius: 6px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-bottom: 10px;
  }
  
  .media-insert:hover {
    border-color: #007bff;
    background: #f8f9fa;
  }
  
  .media-insert-icon {
    font-size: 24px;
    margin-bottom: 10px;
  }
  
  .media-insert-text {
    font-size: 14px;
    color: #666;
  }
  
  .history-controls {
    display: flex;
    gap: 5px;
    margin-bottom: 15px;
  }
  
  .history-btn {
    padding: 6px 12px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
  }
  
  .history-btn:hover {
    background: #f8f9fa;
  }
  
  .document-stats {
    background: white;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    padding: 15px;
  }
  
  .stat-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    font-size: 14px;
  }
  
  .stat-item:last-child {
    margin-bottom: 0;
  }
  
  .stat-label {
    color: #666;
  }
  
  .stat-value {
    font-weight: 600;
    color: #333;
  }
  
  .formatting-preview {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 6px;
    margin-bottom: 15px;
    font-size: 14px;
  }
  
  .word-count {
    background: #e9ecef;
    padding: 10px 15px;
    border-top: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #666;
  }
  
  .word-count-item {
    display: flex;
    gap: 20px;
  }
  
  .word-count-value {
    font-weight: 600;
    color: #333;
  }
  
  .insert-menu {
    position: absolute;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    padding: 10px 0;
    z-index: 1000;
  }
  
  .insert-item {
    padding: 10px 20px;
    cursor: pointer;
    font-size: 14px;
    transition: background 0.2s ease;
  }
  
  .insert-item:hover {
    background: #f8f9fa;
  }
  
  .insert-item-icon {
    margin-right: 10px;
  }
</style>

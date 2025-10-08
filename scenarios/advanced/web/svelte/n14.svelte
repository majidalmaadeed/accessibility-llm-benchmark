<script>
  import { onMount } from 'svelte';
  
  let editorContent = '';
  let isBold = false;
  let isItalic = false;
  let isUnderline = false;
  let isStrikethrough = false;
  let fontSize = '14px';
  let fontFamily = 'Arial';
  let textColor = '#000000';
  let backgroundColor = '#ffffff';
  let alignment = 'left';
  let listType = 'none';
  let showStylePanel = false;
  let showMediaPanel = false;
  let showLinkDialog = false;
  let linkUrl = '';
  let linkText = '';
  let wordCount = 0;
  let charCount = 0;
  let isFullscreen = false;
  let showWordCount = true;
  let autoSave = true;
  let lastSaved = null;

  let editorElement;
  let toolbarElement;

  const fontSizes = [
    '8px', '10px', '12px', '14px', '16px', '18px', '20px', '24px', '28px', '32px', '36px', '48px'
  ];

  const fontFamilies = [
    'Arial', 'Helvetica', 'Times New Roman', 'Courier New', 'Georgia', 'Verdana', 'Trebuchet MS'
  ];

  const alignments = [
    { value: 'left', label: 'Left', icon: '⬅' },
    { value: 'center', label: 'Center', icon: '↔' },
    { value: 'right', label: 'Right', icon: '➡' },
    { value: 'justify', label: 'Justify', icon: '⬌' }
  ];

  const listTypes = [
    { value: 'none', label: 'No List' },
    { value: 'bullet', label: 'Bullet List' },
    { value: 'number', label: 'Numbered List' }
  ];

  onMount(() => {
    loadContent();
    setupAutoSave();
  });

  function loadContent() {
    const saved = localStorage.getItem('richTextContent');
    if (saved) {
      editorContent = saved;
      updateWordCount();
    }
  }

  function setupAutoSave() {
    if (autoSave) {
      setInterval(() => {
        saveContent();
      }, 30000);
    }
  }

  function saveContent() {
    localStorage.setItem('richTextContent', editorContent);
    lastSaved = new Date();
  }

  function updateWordCount() {
    const text = editorContent.replace(/<[^>]*>/g, '').trim();
    wordCount = text ? text.split(/\s+/).length : 0;
    charCount = text.length;
  }

  function handleContentChange() {
    updateWordCount();
    if (autoSave) {
      saveContent();
    }
  }

  function executeCommand(command, value = null) {
    document.execCommand(command, false, value);
    editorElement.focus();
    updateSelectionState();
  }

  function updateSelectionState() {
    isBold = document.queryCommandState('bold');
    isItalic = document.queryCommandState('italic');
    isUnderline = document.queryCommandState('underline');
    isStrikethrough = document.queryCommandState('strikeThrough');
    
    const selection = window.getSelection();
    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const container = range.commonAncestorContainer;
      const element = container.nodeType === Node.TEXT_NODE ? container.parentElement : container;
      
      if (element) {
        fontSize = getComputedStyle(element).fontSize;
        fontFamily = getComputedStyle(element).fontFamily;
        textColor = getComputedStyle(element).color;
        backgroundColor = getComputedStyle(element).backgroundColor;
      }
    }
  }

  function handleFontSizeChange(size) {
    executeCommand('fontSize', '7');
    const selection = window.getSelection();
    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const fontElement = document.createElement('font');
      fontElement.size = '7';
      fontElement.style.fontSize = size;
      range.surroundContents(fontElement);
    }
  }

  function handleFontFamilyChange(family) {
    executeCommand('fontName', family);
  }

  function handleTextColorChange(color) {
    executeCommand('foreColor', color);
  }

  function handleBackgroundColorChange(color) {
    executeCommand('backColor', color);
  }

  function handleAlignmentChange(align) {
    executeCommand('justify' + align.charAt(0).toUpperCase() + align.slice(1));
  }

  function handleListChange(type) {
    if (type === 'bullet') {
      executeCommand('insertUnorderedList');
    } else if (type === 'number') {
      executeCommand('insertOrderedList');
    } else {
      executeCommand('outdent');
    }
  }

  function insertLink() {
    if (linkText && linkUrl) {
      const linkHtml = `<a href="${linkUrl}" target="_blank">${linkText}</a>`;
      executeCommand('insertHTML', linkHtml);
    }
    showLinkDialog = false;
    linkText = '';
    linkUrl = '';
  }

  function insertImage() {
    const imageUrl = prompt('Enter image URL:');
    if (imageUrl) {
      const imageHtml = `<img src="${imageUrl}" alt="Image" style="max-width: 100%; height: auto;" />`;
      executeCommand('insertHTML', imageHtml);
    }
  }

  function insertTable() {
    const tableHtml = `
      <table border="1" style="border-collapse: collapse; width: 100%;">
        <tr>
          <td style="padding: 8px;">Cell 1</td>
          <td style="padding: 8px;">Cell 2</td>
        </tr>
        <tr>
          <td style="padding: 8px;">Cell 3</td>
          <td style="padding: 8px;">Cell 4</td>
        </tr>
      </table>
    `;
    executeCommand('insertHTML', tableHtml);
  }

  function insertHorizontalRule() {
    executeCommand('insertHorizontalRule');
  }

  function undo() {
    executeCommand('undo');
  }

  function redo() {
    executeCommand('redo');
  }

  function selectAll() {
    executeCommand('selectAll');
  }

  function clearFormatting() {
    executeCommand('removeFormat');
  }

  function toggleFullscreen() {
    isFullscreen = !isFullscreen;
    if (isFullscreen) {
      document.documentElement.requestFullscreen();
    } else {
      document.exitFullscreen();
    }
  }

  function exportContent(format) {
    let content = editorContent;
    
    if (format === 'text') {
      content = content.replace(/<[^>]*>/g, '');
    } else if (format === 'markdown') {
      content = convertToMarkdown(content);
    }
    
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `document.${format}`;
    a.click();
    URL.revokeObjectURL(url);
  }

  function convertToMarkdown(html) {
    return html
      .replace(/<h1[^>]*>(.*?)<\/h1>/gi, '# $1\n')
      .replace(/<h2[^>]*>(.*?)<\/h2>/gi, '## $1\n')
      .replace(/<h3[^>]*>(.*?)<\/h3>/gi, '### $1\n')
      .replace(/<strong[^>]*>(.*?)<\/strong>/gi, '**$1**')
      .replace(/<em[^>]*>(.*?)<\/em>/gi, '*$1*')
      .replace(/<u[^>]*>(.*?)<\/u>/gi, '<u>$1</u>')
      .replace(/<a[^>]*href="([^"]*)"[^>]*>(.*?)<\/a>/gi, '[$2]($1)')
      .replace(/<br\s*\/?>/gi, '\n')
      .replace(/<p[^>]*>(.*?)<\/p>/gi, '$1\n\n')
      .replace(/<[^>]*>/g, '');
  }

  function handleKeydown(event) {
    if (event.ctrlKey || event.metaKey) {
      switch (event.key) {
        case 'b':
          event.preventDefault();
          executeCommand('bold');
          break;
        case 'i':
          event.preventDefault();
          executeCommand('italic');
          break;
        case 'u':
          event.preventDefault();
          executeCommand('underline');
          break;
        case 'z':
          if (event.shiftKey) {
            event.preventDefault();
            redo();
          } else {
            event.preventDefault();
            undo();
          }
          break;
        case 'a':
          event.preventDefault();
          selectAll();
          break;
        case 's':
          event.preventDefault();
          saveContent();
          break;
      }
    }
  }
</script>

<svelte:window on:keydown={handleKeydown} />

<div class="rich-text-editor" class:fullscreen={isFullscreen}>
  <div class="editor-toolbar" bind:this={toolbarElement}>
    <div class="toolbar-section">
      <div class="toolbar-group">
        <button 
          on:click={undo}
          class="toolbar-btn"
          title="Undo (Ctrl+Z)"
        >
          ↶
        </button>
        <button 
          on:click={redo}
          class="toolbar-btn"
          title="Redo (Ctrl+Y)"
        >
          ↷
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => executeCommand('bold')}
          class="toolbar-btn"
          class:active={isBold}
          title="Bold (Ctrl+B)"
        >
          <strong>B</strong>
        </button>
        <button 
          on:click={() => executeCommand('italic')}
          class="toolbar-btn"
          class:active={isItalic}
          title="Italic (Ctrl+I)"
        >
          <em>I</em>
        </button>
        <button 
          on:click={() => executeCommand('underline')}
          class="toolbar-btn"
          class:active={isUnderline}
          title="Underline (Ctrl+U)"
        >
          <u>U</u>
        </button>
        <button 
          on:click={() => executeCommand('strikeThrough')}
          class="toolbar-btn"
          class:active={isStrikethrough}
          title="Strikethrough"
        >
          <s>S</s>
        </button>
      </div>

      <div class="toolbar-group">
        <select 
          bind:value={fontSize}
          on:change={() => handleFontSizeChange(fontSize)}
          class="toolbar-select"
        >
          {#each fontSizes as size}
            <option value={size}>{size}</option>
          {/each}
        </select>
        
        <select 
          bind:value={fontFamily}
          on:change={() => handleFontFamilyChange(fontFamily)}
          class="toolbar-select"
        >
          {#each fontFamilies as family}
            <option value={family}>{family}</option>
          {/each}
        </select>
      </div>

      <div class="toolbar-group">
        <input
          type="color"
          bind:value={textColor}
          on:change={() => handleTextColorChange(textColor)}
          class="color-picker"
          title="Text Color"
        />
        <input
          type="color"
          bind:value={backgroundColor}
          on:change={() => handleBackgroundColorChange(backgroundColor)}
          class="color-picker"
          title="Background Color"
        />
      </div>

      <div class="toolbar-group">
        {#each alignments as align}
          <button 
            on:click={() => handleAlignmentChange(align.value)}
            class="toolbar-btn"
            class:active={alignment === align.value}
            title={align.label}
          >
            {align.icon}
          </button>
        {/each}
      </div>

      <div class="toolbar-group">
        <select 
          bind:value={listType}
          on:change={() => handleListChange(listType)}
          class="toolbar-select"
        >
          {#each listTypes as type}
            <option value={type.value}>{type.label}</option>
          {/each}
        </select>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => showStylePanel = !showStylePanel}
          class="toolbar-btn"
          title="Style Panel"
        >
          🎨
        </button>
        <button 
          on:click={() => showMediaPanel = !showMediaPanel}
          class="toolbar-btn"
          title="Media Panel"
        >
          📷
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => showLinkDialog = true}
          class="toolbar-btn"
          title="Insert Link"
        >
          🔗
        </button>
        <button 
          on:click={insertImage}
          class="toolbar-btn"
          title="Insert Image"
        >
          🖼️
        </button>
        <button 
          on:click={insertTable}
          class="toolbar-btn"
          title="Insert Table"
        >
          📊
        </button>
        <button 
          on:click={insertHorizontalRule}
          class="toolbar-btn"
          title="Insert Horizontal Rule"
        >
          ➖
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={clearFormatting}
          class="toolbar-btn"
          title="Clear Formatting"
        >
          🧹
        </button>
        <button 
          on:click={selectAll}
          class="toolbar-btn"
          title="Select All (Ctrl+A)"
        >
          📄
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={toggleFullscreen}
          class="toolbar-btn"
          title="Toggle Fullscreen"
        >
          {isFullscreen ? '⤢' : '⤡'}
        </button>
        <button 
          on:click={() => exportContent('html')}
          class="toolbar-btn"
          title="Export HTML"
        >
          💾
        </button>
        <button 
          on:click={() => exportContent('text')}
          class="toolbar-btn"
          title="Export Text"
        >
          📝
        </button>
        <button 
          on:click={() => exportContent('markdown')}
          class="toolbar-btn"
          title="Export Markdown"
        >
          📋
        </button>
      </div>
    </div>
  </div>

  {#if showStylePanel}
    <div class="style-panel">
      <h4>Style Options</h4>
      <div class="style-controls">
        <div class="style-group">
          <label>Font Size</label>
          <select bind:value={fontSize} on:change={() => handleFontSizeChange(fontSize)}>
            {#each fontSizes as size}
              <option value={size}>{size}</option>
            {/each}
          </select>
        </div>
        
        <div class="style-group">
          <label>Font Family</label>
          <select bind:value={fontFamily} on:change={() => handleFontFamilyChange(fontFamily)}>
            {#each fontFamilies as family}
              <option value={family}>{family}</option>
            {/each}
          </select>
        </div>
        
        <div class="style-group">
          <label>Text Color</label>
          <input
            type="color"
            bind:value={textColor}
            on:change={() => handleTextColorChange(textColor)}
          />
        </div>
        
        <div class="style-group">
          <label>Background Color</label>
          <input
            type="color"
            bind:value={backgroundColor}
            on:change={() => handleBackgroundColorChange(backgroundColor)}
          />
        </div>
      </div>
    </div>
  {/if}

  {#if showMediaPanel}
    <div class="media-panel">
      <h4>Insert Media</h4>
      <div class="media-controls">
        <button on:click={insertImage} class="media-btn">
          Insert Image
        </button>
        <button on:click={insertTable} class="media-btn">
          Insert Table
        </button>
        <button on:click={insertHorizontalRule} class="media-btn">
          Insert Line
        </button>
      </div>
    </div>
  {/if}

  <div class="editor-container">
    <div
      bind:this={editorElement}
      contenteditable="true"
      bind:innerHTML={editorContent}
      on:input={handleContentChange}
      on:selectionchange={updateSelectionState}
      class="editor-content"
      style="font-size: {fontSize}; font-family: {fontFamily}; color: {textColor}; background-color: {backgroundColor};"
    />
  </div>

  <div class="editor-footer">
    <div class="footer-left">
      <label class="checkbox-label">
        <input
          type="checkbox"
          bind:checked={autoSave}
          on:change={setupAutoSave}
        />
        Auto Save
      </label>
      
      <label class="checkbox-label">
        <input
          type="checkbox"
          bind:checked={showWordCount}
        />
        Show Word Count
      </label>
    </div>
    
    <div class="footer-right">
      {#if showWordCount}
        <div class="word-count">
          <span>Words: {wordCount}</span>
          <span>Characters: {charCount}</span>
        </div>
      {/if}
      
      {#if lastSaved}
        <div class="save-status">
          Last saved: {lastSaved.toLocaleTimeString()}
        </div>
      {/if}
      
      <button 
        on:click={saveContent}
        class="save-btn"
      >
        Save
      </button>
    </div>
  </div>

  {#if showLinkDialog}
    <div class="modal-overlay">
      <div class="link-dialog">
        <h3>Insert Link</h3>
        <div class="form-group">
          <label>Link Text</label>
          <input
            type="text"
            bind:value={linkText}
            placeholder="Enter link text"
            class="form-input"
          />
        </div>
        <div class="form-group">
          <label>URL</label>
          <input
            type="url"
            bind:value={linkUrl}
            placeholder="Enter URL"
            class="form-input"
          />
        </div>
        <div class="dialog-actions">
          <button 
            on:click={() => showLinkDialog = false}
            class="btn-secondary"
          >
            Cancel
          </button>
          <button 
            on:click={insertLink}
            class="btn-primary"
          >
            Insert Link
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .rich-text-editor {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }

  .rich-text-editor.fullscreen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: 9999;
    border-radius: 0;
    padding: 0;
  }

  .editor-toolbar {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px 8px 0 0;
    padding: 10px;
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    align-items: center;
  }

  .toolbar-section {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    align-items: center;
  }

  .toolbar-group {
    display: flex;
    gap: 2px;
    align-items: center;
    padding: 0 5px;
    border-right: 1px solid #e0e0e0;
  }

  .toolbar-group:last-child {
    border-right: none;
  }

  .toolbar-btn {
    padding: 6px 10px;
    background: white;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    color: #333;
    transition: all 0.3s ease;
    min-width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .toolbar-btn:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .toolbar-btn.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .toolbar-select {
    padding: 4px 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 12px;
    background: white;
    cursor: pointer;
    min-width: 80px;
  }

  .toolbar-select:focus {
    outline: none;
    border-color: #4caf50;
  }

  .color-picker {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    padding: 0;
  }

  .style-panel,
  .media-panel {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-top: none;
    padding: 15px;
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .style-panel h4,
  .media-panel h4 {
    margin: 0;
    color: #333;
    font-size: 14px;
  }

  .style-controls {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
  }

  .style-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }

  .style-group label {
    font-size: 12px;
    font-weight: 600;
    color: #333;
  }

  .style-group select,
  .style-group input {
    padding: 6px 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 12px;
  }

  .media-controls {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .media-btn {
    padding: 8px 12px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .media-btn:hover {
    background: #45a049;
  }

  .editor-container {
    border: 1px solid #e0e0e0;
    border-top: none;
    border-radius: 0 0 8px 8px;
    overflow: hidden;
  }

  .editor-content {
    min-height: 400px;
    padding: 20px;
    line-height: 1.6;
    outline: none;
    font-size: 14px;
    color: #333;
  }

  .editor-content:focus {
    outline: none;
  }

  .editor-content h1,
  .editor-content h2,
  .editor-content h3 {
    margin: 20px 0 10px 0;
    font-weight: bold;
  }

  .editor-content h1 {
    font-size: 24px;
  }

  .editor-content h2 {
    font-size: 20px;
  }

  .editor-content h3 {
    font-size: 18px;
  }

  .editor-content p {
    margin: 10px 0;
  }

  .editor-content ul,
  .editor-content ol {
    margin: 10px 0;
    padding-left: 20px;
  }

  .editor-content li {
    margin: 5px 0;
  }

  .editor-content table {
    border-collapse: collapse;
    width: 100%;
    margin: 10px 0;
  }

  .editor-content td,
  .editor-content th {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }

  .editor-content th {
    background: #f5f5f5;
    font-weight: bold;
  }

  .editor-content img {
    max-width: 100%;
    height: auto;
    margin: 10px 0;
  }

  .editor-content a {
    color: #4caf50;
    text-decoration: underline;
  }

  .editor-content a:hover {
    color: #45a049;
  }

  .editor-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-top: none;
    border-radius: 0 0 8px 8px;
    font-size: 12px;
    color: #666;
  }

  .footer-left {
    display: flex;
    gap: 20px;
    align-items: center;
  }

  .footer-right {
    display: flex;
    gap: 20px;
    align-items: center;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
    font-size: 12px;
  }

  .checkbox-label input[type="checkbox"] {
    margin: 0;
  }

  .word-count {
    display: flex;
    gap: 15px;
    font-size: 11px;
    color: #666;
  }

  .save-status {
    font-size: 11px;
    color: #4caf50;
  }

  .save-btn {
    padding: 6px 12px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .save-btn:hover {
    background: #45a049;
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .link-dialog {
    background: white;
    border-radius: 8px;
    padding: 20px;
    width: 90%;
    max-width: 400px;
  }

  .link-dialog h3 {
    margin: 0 0 20px 0;
    color: #333;
    font-size: 18px;
  }

  .form-group {
    margin-bottom: 15px;
  }

  .form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .form-input {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
  }

  .form-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .dialog-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
  }

  .btn-primary,
  .btn-secondary {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .btn-primary {
    background: #4caf50;
    color: white;
  }

  .btn-primary:hover {
    background: #45a049;
  }

  .btn-secondary {
    background: #f5f5f5;
    color: #333;
    border: 1px solid #ddd;
  }

  .btn-secondary:hover {
    background: #e0e0e0;
  }

  @media (max-width: 768px) {
    .rich-text-editor {
      padding: 15px;
    }
    
    .editor-toolbar {
      flex-direction: column;
      align-items: stretch;
    }
    
    .toolbar-section {
      justify-content: center;
    }
    
    .toolbar-group {
      border-right: none;
      border-bottom: 1px solid #e0e0e0;
      padding: 5px 0;
    }
    
    .toolbar-group:last-child {
      border-bottom: none;
    }
    
    .style-controls {
      grid-template-columns: 1fr;
    }
    
    .media-controls {
      flex-direction: column;
    }
    
    .editor-footer {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .footer-left,
    .footer-right {
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .rich-text-editor {
      padding: 10px;
    }
    
    .editor-content {
      min-height: 300px;
      padding: 15px;
    }
    
    .toolbar-btn {
      min-width: 28px;
      height: 28px;
      font-size: 10px;
    }
    
    .toolbar-select {
      min-width: 60px;
      font-size: 10px;
    }
    
    .color-picker {
      width: 28px;
      height: 28px;
    }
  }
</style>

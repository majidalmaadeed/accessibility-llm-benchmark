<script>
  import { onMount, onDestroy } from 'svelte';
  
  let editorElement;
  let isSaving = false;
  let canUndo = false;
  let canRedo = false;
  let spellCheckEnabled = true;
  let wordCount = 0;
  let characterCount = 0;
  let cursorLine = 1;
  let cursorColumn = 1;
  let zoomLevel = 1;
  let showLinkDialog = false;
  let showImageDialog = false;
  let showTableDialog = false;
  let linkUrl = '';
  let linkText = '';
  let openInNewTab = false;
  let imageUrl = '';
  let imageAlt = '';
  let imageWidth = null;
  let imageHeight = null;
  let tableRows = 3;
  let tableColumns = 3;
  let tableHeader = true;
  
  onMount(() => {
    updateWordCount();
    setupEditor();
  });
  
  onDestroy(() => {
    // Cleanup if needed
  });
  
  function setupEditor() {
    if (editorElement) {
      editorElement.style.fontSize = `${zoomLevel * 16}px`;
    }
  }
  
  function execCommand(command, value = null) {
    document.execCommand(command, false, value);
    updateWordCount();
    updateCursorPosition();
  }
  
  function isFormatActive(command) {
    return document.queryCommandState(command);
  }
  
  function handleInput() {
    updateWordCount();
    updateCursorPosition();
  }
  
  function handleKeydown(event) {
    if (event.ctrlKey || event.metaKey) {
      switch (event.key) {
        case 's':
          event.preventDefault();
          saveDocument();
          break;
        case 'z':
          if (event.shiftKey) {
            event.preventDefault();
            execCommand('redo');
          } else {
            event.preventDefault();
            execCommand('undo');
          }
          break;
        case 'b':
          event.preventDefault();
          execCommand('bold');
          break;
        case 'i':
          event.preventDefault();
          execCommand('italic');
          break;
        case 'u':
          event.preventDefault();
          execCommand('underline');
          break;
      }
    }
  }
  
  function handlePaste(event) {
    event.preventDefault();
    const text = event.clipboardData.getData('text/plain');
    document.execCommand('insertText', false, text);
  }
  
  function handleFocus() {
    updateCursorPosition();
  }
  
  function handleBlur() {
    updateCursorPosition();
  }
  
  function updateWordCount() {
    const text = editorElement ? editorElement.textContent || '' : '';
    wordCount = text.trim() ? text.trim().split(/\s+/).length : 0;
    characterCount = text.length;
  }
  
  function updateCursorPosition() {
    const selection = window.getSelection();
    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const preCaretRange = range.cloneRange();
      preCaretRange.selectNodeContents(editorElement);
      preCaretRange.setEnd(range.endContainer, range.endOffset);
      const text = preCaretRange.toString();
      cursorLine = (text.match(/\n/g) || []).length + 1;
      cursorColumn = text.length - text.lastIndexOf('\n');
    }
  }
  
  function insertLink() {
    linkUrl = '';
    linkText = '';
    openInNewTab = false;
    showLinkDialog = true;
  }
  
  function insertLinkConfirm() {
    if (linkUrl.trim()) {
      const linkTextValue = linkText.trim() || linkUrl;
      const target = openInNewTab ? '_blank' : '_self';
      const linkHtml = `<a href="${linkUrl}" target="${target}">${linkTextValue}</a>`;
      document.execCommand('insertHTML', false, linkHtml);
      showLinkDialog = false;
    }
  }
  
  function insertImage() {
    imageUrl = '';
    imageAlt = '';
    imageWidth = null;
    imageHeight = null;
    showImageDialog = true;
  }
  
  function insertImageConfirm() {
    if (imageUrl.trim()) {
      let imgHtml = `<img src="${imageUrl}"`;
      if (imageAlt.trim()) {
        imgHtml += ` alt="${imageAlt}"`;
      }
      if (imageWidth) {
        imgHtml += ` width="${imageWidth}"`;
      }
      if (imageHeight) {
        imgHtml += ` height="${imageHeight}"`;
      }
      imgHtml += '>';
      document.execCommand('insertHTML', false, imgHtml);
      showImageDialog = false;
    }
  }
  
  function insertTable() {
    tableRows = 3;
    tableColumns = 3;
    tableHeader = true;
    showTableDialog = true;
  }
  
  function insertTableConfirm() {
    let tableHtml = '<table border="1" style="border-collapse: collapse; width: 100%;">';
    
    if (tableHeader) {
      tableHtml += '<thead><tr>';
      for (let i = 0; i < tableColumns; i++) {
        tableHtml += '<th style="padding: 8px; background-color: #f0f0f0;">Header ' + (i + 1) + '</th>';
      }
      tableHtml += '</tr></thead>';
    }
    
    tableHtml += '<tbody>';
    for (let row = 0; row < tableRows; row++) {
      tableHtml += '<tr>';
      for (let col = 0; col < tableColumns; col++) {
        tableHtml += '<td style="padding: 8px;">Cell ' + (row + 1) + ',' + (col + 1) + '</td>';
      }
      tableHtml += '</tr>';
    }
    tableHtml += '</tbody></table>';
    
    document.execCommand('insertHTML', false, tableHtml);
    showTableDialog = false;
  }
  
  function toggleWordCount() {
    console.log('Word count:', wordCount);
  }
  
  function toggleSpellCheck() {
    spellCheckEnabled = !spellCheckEnabled;
  }
  
  function increaseZoom() {
    zoomLevel = Math.min(zoomLevel + 0.1, 2.0);
    if (editorElement) {
      editorElement.style.fontSize = `${zoomLevel * 16}px`;
    }
  }
  
  function decreaseZoom() {
    zoomLevel = Math.max(zoomLevel - 0.1, 0.5);
    if (editorElement) {
      editorElement.style.fontSize = `${zoomLevel * 16}px`;
    }
  }
  
  function saveDocument() {
    isSaving = true;
    const content = editorElement ? editorElement.innerHTML : '';
    
    setTimeout(() => {
      console.log('Document saved:', content);
      isSaving = false;
      alert('Document saved successfully!');
    }, 1000);
  }
  
  function exportDocument() {
    const content = editorElement ? editorElement.innerHTML : '';
    const blob = new Blob([content], { type: 'text/html' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'document.html';
    a.click();
    URL.revokeObjectURL(url);
  }
  
  $: if (editorElement) {
    setupEditor();
  }
</script>

<div class="rich-text-editor">
  <div class="editor-header">
    <h2>Rich Text Editor</h2>
    <div class="header-actions">
      <button 
        on:click={saveDocument}
        disabled={isSaving}
        class="save-btn"
      >
        {isSaving ? 'Saving...' : 'Save'}
      </button>
      <button 
        on:click={exportDocument}
        class="export-btn"
      >
        Export
      </button>
    </div>
  </div>

  <div class="editor-container">
    <div class="toolbar">
      <div class="toolbar-group">
        <button 
          on:click={() => execCommand('undo')}
          disabled={!canUndo}
          class="toolbar-btn"
          title="Undo"
        >
          ↶
        </button>
        <button 
          on:click={() => execCommand('redo')}
          disabled={!canRedo}
          class="toolbar-btn"
          title="Redo"
        >
          ↷
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => execCommand('bold')}
          class="toolbar-btn"
          class:active={isFormatActive('bold')}
          title="Bold"
        >
          <strong>B</strong>
        </button>
        <button 
          on:click={() => execCommand('italic')}
          class="toolbar-btn"
          class:active={isFormatActive('italic')}
          title="Italic"
        >
          <em>I</em>
        </button>
        <button 
          on:click={() => execCommand('underline')}
          class="toolbar-btn"
          class:active={isFormatActive('underline')}
          title="Underline"
        >
          <u>U</u>
        </button>
        <button 
          on:click={() => execCommand('strikeThrough')}
          class="toolbar-btn"
          class:active={isFormatActive('strikeThrough')}
          title="Strikethrough"
        >
          <s>S</s>
        </button>
      </div>

      <div class="toolbar-group">
        <select 
          on:change={(e) => execCommand('fontName', e.target.value)}
          class="font-select"
        >
          <option value="Arial">Arial</option>
          <option value="Helvetica">Helvetica</option>
          <option value="Times New Roman">Times New Roman</option>
          <option value="Georgia">Georgia</option>
          <option value="Verdana">Verdana</option>
          <option value="Courier New">Courier New</option>
        </select>
        
        <select 
          on:change={(e) => execCommand('fontSize', e.target.value)}
          class="size-select"
        >
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
        </select>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => execCommand('foreColor', '#000000')}
          class="toolbar-btn color-btn"
          title="Text Color"
        >
          <span class="color-preview" style="background-color: #000000"></span>
        </button>
        <button 
          on:click={() => execCommand('backColor', '#ffff00')}
          class="toolbar-btn color-btn"
          title="Background Color"
        >
          <span class="color-preview" style="background-color: #ffff00"></span>
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => execCommand('justifyLeft')}
          class="toolbar-btn"
          class:active={isFormatActive('justifyLeft')}
          title="Align Left"
        >
          ⬅
        </button>
        <button 
          on:click={() => execCommand('justifyCenter')}
          class="toolbar-btn"
          class:active={isFormatActive('justifyCenter')}
          title="Align Center"
        >
          ↔
        </button>
        <button 
          on:click={() => execCommand('justifyRight')}
          class="toolbar-btn"
          class:active={isFormatActive('justifyRight')}
          title="Align Right"
        >
          ➡
        </button>
        <button 
          on:click={() => execCommand('justifyFull')}
          class="toolbar-btn"
          class:active={isFormatActive('justifyFull')}
          title="Justify"
        >
          ⬌
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={() => execCommand('insertUnorderedList')}
          class="toolbar-btn"
          class:active={isFormatActive('insertUnorderedList')}
          title="Bullet List"
        >
          •
        </button>
        <button 
          on:click={() => execCommand('insertOrderedList')}
          class="toolbar-btn"
          class:active={isFormatActive('insertOrderedList')}
          title="Numbered List"
        >
          1.
        </button>
        <button 
          on:click={() => execCommand('outdent')}
          class="toolbar-btn"
          title="Decrease Indent"
        >
          ⬅
        </button>
        <button 
          on:click={() => execCommand('indent')}
          class="toolbar-btn"
          title="Increase Indent"
        >
          ➡
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={insertLink}
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
          🖼
        </button>
        <button 
          on:click={insertTable}
          class="toolbar-btn"
          title="Insert Table"
        >
          ⚏
        </button>
      </div>

      <div class="toolbar-group">
        <button 
          on:click={toggleWordCount}
          class="toolbar-btn"
          title="Word Count"
        >
          📊
        </button>
        <button 
          on:click={toggleSpellCheck}
          class="toolbar-btn"
          class:active={spellCheckEnabled}
          title="Spell Check"
        >
          ✓
        </button>
      </div>
    </div>

    <div class="editor-content">
      <div 
        bind:this={editorElement}
        class="editor-area"
        contenteditable="true"
        on:input={handleInput}
        on:keydown={handleKeydown}
        on:paste={handlePaste}
        on:focus={handleFocus}
        on:blur={handleBlur}
        spellcheck={spellCheckEnabled}
      >
        <p>Start typing your document here...</p>
      </div>
    </div>

    <div class="editor-footer">
      <div class="status-bar">
        <span class="word-count">
          Words: {wordCount} | Characters: {characterCount}
        </span>
        <span class="cursor-position">
          Line: {cursorLine} | Column: {cursorColumn}
        </span>
      </div>
      
      <div class="zoom-controls">
        <button 
          on:click={decreaseZoom}
          class="zoom-btn"
        >
          −
        </button>
        <span class="zoom-level">{Math.round(zoomLevel * 100)}%</span>
        <button 
          on:click={increaseZoom}
          class="zoom-btn"
        >
          +
        </button>
      </div>
    </div>
  </div>

  {#if showLinkDialog}
    <div class="dialog-overlay">
      <div class="link-dialog">
        <div class="dialog-header">
          <h3>Insert Link</h3>
          <button 
            on:click={() => showLinkDialog = false}
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="dialog-content">
          <div class="form-group">
            <label class="form-label">URL</label>
            <input
              bind:value={linkUrl}
              type="url"
              class="form-input"
              placeholder="https://example.com"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Link Text</label>
            <input
              bind:value={linkText}
              type="text"
              class="form-input"
              placeholder="Link text"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">
              <input
                bind:checked={openInNewTab}
                type="checkbox"
              />
              Open in new tab
            </label>
          </div>
        </div>
        
        <div class="dialog-actions">
          <button 
            on:click={() => showLinkDialog = false}
            class="cancel-btn"
          >
            Cancel
          </button>
          <button 
            on:click={insertLinkConfirm}
            disabled={!linkUrl.trim()}
            class="confirm-btn"
          >
            Insert Link
          </button>
        </div>
      </div>
    </div>
  {/if}

  {#if showImageDialog}
    <div class="dialog-overlay">
      <div class="image-dialog">
        <div class="dialog-header">
          <h3>Insert Image</h3>
          <button 
            on:click={() => showImageDialog = false}
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="dialog-content">
          <div class="form-group">
            <label class="form-label">Image URL</label>
            <input
              bind:value={imageUrl}
              type="url"
              class="form-input"
              placeholder="https://example.com/image.jpg"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Alt Text</label>
            <input
              bind:value={imageAlt}
              type="text"
              class="form-input"
              placeholder="Describe the image"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Width (px)</label>
            <input
              bind:value={imageWidth}
              type="number"
              class="form-input"
              placeholder="Auto"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Height (px)</label>
            <input
              bind:value={imageHeight}
              type="number"
              class="form-input"
              placeholder="Auto"
            />
          </div>
        </div>
        
        <div class="dialog-actions">
          <button 
            on:click={() => showImageDialog = false}
            class="cancel-btn"
          >
            Cancel
          </button>
          <button 
            on:click={insertImageConfirm}
            disabled={!imageUrl.trim()}
            class="confirm-btn"
          >
            Insert Image
          </button>
        </div>
      </div>
    </div>
  {/if}

  {#if showTableDialog}
    <div class="dialog-overlay">
      <div class="table-dialog">
        <div class="dialog-header">
          <h3>Insert Table</h3>
          <button 
            on:click={() => showTableDialog = false}
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="dialog-content">
          <div class="form-group">
            <label class="form-label">Rows</label>
            <input
              bind:value={tableRows}
              type="number"
              min="1"
              max="20"
              class="form-input"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Columns</label>
            <input
              bind:value={tableColumns}
              type="number"
              min="1"
              max="20"
              class="form-input"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">
              <input
                bind:checked={tableHeader}
                type="checkbox"
              />
              Include header row
            </label>
          </div>
        </div>
        
        <div class="dialog-actions">
          <button 
            on:click={() => showTableDialog = false}
            class="cancel-btn"
          >
            Cancel
          </button>
          <button 
            on:click={insertTableConfirm}
            class="confirm-btn"
          >
            Insert Table
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
  }

  .editor-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e0e0e0;
  }

  .editor-header h2 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .header-actions {
    display: flex;
    gap: 10px;
  }

  .save-btn,
  .export-btn {
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .save-btn {
    background: #4caf50;
    color: white;
  }

  .save-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .save-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .export-btn {
    background: #2196f3;
    color: white;
  }

  .export-btn:hover {
    background: #1976d2;
  }

  .editor-container {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
  }

  .toolbar {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    padding: 10px;
    background: #f8f9fa;
    border-bottom: 1px solid #e0e0e0;
  }

  .toolbar-group {
    display: flex;
    gap: 2px;
    padding-right: 10px;
    border-right: 1px solid #ddd;
  }

  .toolbar-group:last-child {
    border-right: none;
  }

  .toolbar-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
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

  .toolbar-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .font-select,
  .size-select {
    height: 32px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    font-size: 12px;
    padding: 0 8px;
    cursor: pointer;
  }

  .color-btn {
    position: relative;
  }

  .color-preview {
    width: 16px;
    height: 16px;
    border-radius: 2px;
    border: 1px solid #ccc;
  }

  .editor-content {
    min-height: 400px;
  }

  .editor-area {
    width: 100%;
    min-height: 400px;
    padding: 20px;
    border: none;
    outline: none;
    font-size: 16px;
    line-height: 1.6;
    color: #333;
    background: white;
  }

  .editor-area:focus {
    outline: none;
  }

  .editor-area p {
    margin: 0 0 10px 0;
  }

  .editor-area h1,
  .editor-area h2,
  .editor-area h3,
  .editor-area h4,
  .editor-area h5,
  .editor-area h6 {
    margin: 20px 0 10px 0;
    font-weight: bold;
  }

  .editor-area ul,
  .editor-area ol {
    margin: 10px 0;
    padding-left: 20px;
  }

  .editor-area li {
    margin: 5px 0;
  }

  .editor-area table {
    width: 100%;
    border-collapse: collapse;
    margin: 10px 0;
  }

  .editor-area th,
  .editor-area td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }

  .editor-area th {
    background-color: #f0f0f0;
    font-weight: bold;
  }

  .editor-area img {
    max-width: 100%;
    height: auto;
    margin: 10px 0;
  }

  .editor-area a {
    color: #2196f3;
    text-decoration: underline;
  }

  .editor-area a:hover {
    color: #1976d2;
  }

  .editor-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    background: #f8f9fa;
    border-top: 1px solid #e0e0e0;
    font-size: 12px;
    color: #666;
  }

  .status-bar {
    display: flex;
    gap: 20px;
  }

  .word-count,
  .cursor-position {
    font-weight: 500;
  }

  .zoom-controls {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .zoom-btn {
    width: 24px;
    height: 24px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }

  .zoom-btn:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .zoom-level {
    font-weight: 600;
    min-width: 40px;
    text-align: center;
  }

  .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .link-dialog,
  .image-dialog,
  .table-dialog {
    background: white;
    border-radius: 8px;
    width: 90%;
    max-width: 400px;
  }

  .dialog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #e0e0e0;
  }

  .dialog-header h3 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }

  .close-btn {
    background: none;
    border: none;
    font-size: 18px;
    cursor: pointer;
    color: #666;
  }

  .dialog-content {
    padding: 20px;
  }

  .form-group {
    margin-bottom: 15px;
  }

  .form-label {
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
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
  }

  .form-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .dialog-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    padding: 20px;
    border-top: 1px solid #e0e0e0;
  }

  .cancel-btn,
  .confirm-btn {
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .cancel-btn {
    background: #f5f5f5;
    color: #666;
  }

  .cancel-btn:hover {
    background: #e0e0e0;
  }

  .confirm-btn {
    background: #4caf50;
    color: white;
  }

  .confirm-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .confirm-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  @media (max-width: 768px) {
    .rich-text-editor {
      padding: 15px;
    }
    
    .editor-header {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .header-actions {
      justify-content: center;
    }
    
    .toolbar {
      flex-direction: column;
      gap: 10px;
    }
    
    .toolbar-group {
      border-right: none;
      border-bottom: 1px solid #ddd;
      padding-right: 0;
      padding-bottom: 10px;
    }
    
    .toolbar-group:last-child {
      border-bottom: none;
    }
    
    .editor-area {
      min-height: 300px;
      padding: 15px;
    }
    
    .editor-footer {
      flex-direction: column;
      gap: 10px;
      align-items: stretch;
    }
    
    .status-bar {
      justify-content: center;
    }
    
    .zoom-controls {
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .rich-text-editor {
      padding: 10px;
    }
    
    .editor-area {
      min-height: 250px;
      padding: 10px;
    }
    
    .toolbar-btn {
      width: 28px;
      height: 28px;
      font-size: 12px;
    }
    
    .font-select,
    .size-select {
      height: 28px;
      font-size: 11px;
    }
    
    .dialog-content {
      padding: 15px;
    }
    
    .dialog-actions {
      flex-direction: column;
    }
  }
</style>

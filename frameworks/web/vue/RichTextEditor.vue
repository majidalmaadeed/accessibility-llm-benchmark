<template>
  <div :class="`rich-text-editor ${isFullscreen ? 'fullscreen' : ''}`">
    <div class="editor-toolbar">
      <div class="toolbar-section">
        <button 
          @click="undo"
          :disabled="undoStack.length === 0"
          title="Undo"
        >
          ↶
        </button>
        <button 
          @click="redo"
          :disabled="redoStack.length === 0"
          title="Redo"
        >
          ↷
        </button>
      </div>

      <div class="toolbar-section">
        <button 
          @click="execCommand('bold')"
          :class="{ active: isBold }"
          title="Bold"
        >
          <strong>B</strong>
        </button>
        <button 
          @click="execCommand('italic')"
          :class="{ active: isItalic }"
          title="Italic"
        >
          <em>I</em>
        </button>
        <button 
          @click="execCommand('underline')"
          :class="{ active: isUnderline }"
          title="Underline"
        >
          <u>U</u>
        </button>
      </div>

      <div class="toolbar-section">
        <select 
          :value="fontFamily"
          @change="handleFontFamilyChange"
          title="Font Family"
        >
          <option v-for="font in fontFamilies" :key="font" :value="font">{{ font }}</option>
        </select>
        
        <select 
          :value="fontSize"
          @change="handleFontSizeChange"
          title="Font Size"
        >
          <option v-for="size in fontSizes" :key="size" :value="size">{{ size }}px</option>
        </select>
      </div>

      <div class="toolbar-section">
        <input
          type="color"
          :value="textColor"
          @change="handleTextColorChange"
          title="Text Color"
        />
        <input
          type="color"
          :value="backgroundColor"
          @change="handleBackgroundColorChange"
          title="Background Color"
        />
      </div>

      <div class="toolbar-section">
        <button 
          @click="setAlignment('left')"
          :class="{ active: alignment === 'left' }"
          title="Align Left"
        >
          ⬅
        </button>
        <button 
          @click="setAlignment('center')"
          :class="{ active: alignment === 'center' }"
          title="Align Center"
        >
          ↔
        </button>
        <button 
          @click="setAlignment('right')"
          :class="{ active: alignment === 'right' }"
          title="Align Right"
        >
          ➡
        </button>
        <button 
          @click="setAlignment('justify')"
          :class="{ active: alignment === 'justify' }"
          title="Justify"
        >
          ⬌
        </button>
      </div>

      <div class="toolbar-section">
        <button 
          @click="execCommand('insertUnorderedList')"
          :class="{ active: listType === 'unordered' }"
          title="Bullet List"
        >
          •
        </button>
        <button 
          @click="execCommand('insertOrderedList')"
          :class="{ active: listType === 'ordered' }"
          title="Numbered List"
        >
          1.
        </button>
      </div>

      <div class="toolbar-section">
        <button 
          @click="showStylePanel = !showStylePanel"
          :class="{ active: showStylePanel }"
          title="Styles"
        >
          Styles
        </button>
        <button 
          @click="showMediaPanel = !showMediaPanel"
          :class="{ active: showMediaPanel }"
          title="Media"
        >
          Media
        </button>
      </div>

      <div class="toolbar-section">
        <button 
          @click="exportContent('html')"
          title="Export HTML"
        >
          Export HTML
        </button>
        <button 
          @click="exportContent('text')"
          title="Export Text"
        >
          Export Text
        </button>
        <button 
          @click="toggleFullscreen"
          title="Toggle Fullscreen"
        >
          {{ isFullscreen ? '⤢' : '⤡' }}
        </button>
      </div>
    </div>

    <div v-if="showStylePanel" class="style-panel">
      <h4>Quick Styles</h4>
      <div class="style-buttons">
        <button @click="execCommand('formatBlock', 'h1')">Heading 1</button>
        <button @click="execCommand('formatBlock', 'h2')">Heading 2</button>
        <button @click="execCommand('formatBlock', 'h3')">Heading 3</button>
        <button @click="execCommand('formatBlock', 'p')">Paragraph</button>
        <button @click="execCommand('formatBlock', 'blockquote')">Quote</button>
        <button @click="execCommand('formatBlock', 'pre')">Code</button>
      </div>
      
      <h4>Text Colors</h4>
      <div class="color-palette">
        <button
          v-for="color in colors"
          :key="color"
          class="color-btn"
          :style="{ backgroundColor: color }"
          @click="setTextColor(color)"
          :title="color"
        />
      </div>
    </div>

    <div v-if="showMediaPanel" class="media-panel">
      <h4>Insert Media</h4>
      <div class="media-buttons">
        <button @click="insertImage">Insert Image</button>
        <button @click="insertLink">Insert Link</button>
        <button @click="insertTable">Insert Table</button>
        <button @click="insertHorizontalRule">Insert Line</button>
      </div>
    </div>

    <div class="editor-container">
      <div
        ref="editorRef"
        class="editor-content"
        contenteditable
        v-html="content"
        @input="handleContentChange"
        @mouseup="updateToolbarState"
        @keyup="updateToolbarState"
        @focus="updateToolbarState"
      />
    </div>

    <div class="editor-footer">
      <div class="word-count">
        <span>Words: {{ wordCount }}</span>
        <span>Characters: {{ charCount }}</span>
      </div>
      <div class="editor-status">
        <span>Ready</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RichTextEditor',
  data() {
    return {
      content: '<p>Start typing your content here...</p>',
      isBold: false,
      isItalic: false,
      isUnderline: false,
      fontSize: '16',
      fontFamily: 'Arial',
      textColor: '#000000',
      backgroundColor: '#ffffff',
      alignment: 'left',
      listType: 'none',
      showStylePanel: false,
      showMediaPanel: false,
      wordCount: 0,
      charCount: 0,
      undoStack: [],
      redoStack: [],
      isFullscreen: false,
      fontFamilies: [
        'Arial', 'Helvetica', 'Times New Roman', 'Georgia', 'Verdana', 'Courier New'
      ],
      fontSizes: ['8', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '48'],
      colors: [
        '#000000', '#333333', '#666666', '#999999', '#cccccc', '#ffffff',
        '#ff0000', '#ff6600', '#ffcc00', '#00ff00', '#0066ff', '#6600ff',
        '#ff0066', '#00ffff', '#ffff00', '#ff9900', '#99ff00', '#0099ff'
      ]
    }
  },
  watch: {
    content() {
      this.updateWordCount();
    }
  },
  methods: {
    execCommand(command, value = null) {
      document.execCommand(command, false, value);
      this.updateToolbarState();
      this.saveToUndoStack();
    },
    updateToolbarState() {
      this.isBold = document.queryCommandState('bold');
      this.isItalic = document.queryCommandState('italic');
      this.isUnderline = document.queryCommandState('underline');
      
      const selection = window.getSelection();
      if (selection.rangeCount > 0) {
        const range = selection.getRangeAt(0);
        const container = range.commonAncestorContainer;
        const element = container.nodeType === Node.TEXT_NODE ? container.parentElement : container;
        
        if (element) {
          const computedStyle = window.getComputedStyle(element);
          this.fontSize = computedStyle.fontSize.replace('px', '');
          this.fontFamily = computedStyle.fontFamily.split(',')[0].replace(/['"]/g, '');
          this.textColor = computedStyle.color;
          this.backgroundColor = computedStyle.backgroundColor;
          
          const textAlign = computedStyle.textAlign;
          this.alignment = textAlign === 'start' ? 'left' : textAlign;
        }
      }
    },
    saveToUndoStack() {
      const currentContent = this.$refs.editorRef?.innerHTML || '';
      this.undoStack.push(currentContent);
      this.redoStack = [];
    },
    undo() {
      if (this.undoStack.length > 0) {
        const previousContent = this.undoStack.pop();
        this.redoStack.push(this.content);
        this.content = previousContent;
      }
    },
    redo() {
      if (this.redoStack.length > 0) {
        const nextContent = this.redoStack.pop();
        this.undoStack.push(this.content);
        this.content = nextContent;
      }
    },
    handleContentChange() {
      this.content = this.$refs.editorRef?.innerHTML || '';
    },
    updateWordCount() {
      const text = this.$refs.editorRef?.innerText || '';
      const words = text.trim().split(/\s+/).filter(word => word.length > 0);
      this.wordCount = words.length;
      this.charCount = text.length;
    },
    handleFontFamilyChange(event) {
      this.fontFamily = event.target.value;
      this.execCommand('fontName', event.target.value);
    },
    handleFontSizeChange(event) {
      this.fontSize = event.target.value;
      this.execCommand('fontSize', '7');
      this.execCommand('foreColor', this.textColor);
    },
    handleTextColorChange(event) {
      this.textColor = event.target.value;
      this.execCommand('foreColor', event.target.value);
    },
    handleBackgroundColorChange(event) {
      this.backgroundColor = event.target.value;
      this.execCommand('backColor', event.target.value);
    },
    setAlignment(align) {
      this.alignment = align;
      switch (align) {
        case 'left':
          this.execCommand('justifyLeft');
          break;
        case 'center':
          this.execCommand('justifyCenter');
          break;
        case 'right':
          this.execCommand('justifyRight');
          break;
        case 'justify':
          this.execCommand('justifyFull');
          break;
      }
    },
    setTextColor(color) {
      this.textColor = color;
      this.execCommand('foreColor', color);
    },
    insertImage() {
      const url = prompt('Enter image URL:');
      if (url) {
        this.execCommand('insertHTML', `<img src="${url}" alt="Inserted image" style="max-width: 100%; height: auto;">`);
      }
    },
    insertLink() {
      const url = prompt('Enter URL:');
      const text = prompt('Enter link text:');
      if (url && text) {
        this.execCommand('insertHTML', `<a href="${url}">${text}</a>`);
      }
    },
    insertTable() {
      const rows = prompt('Number of rows:', '3');
      const cols = prompt('Number of columns:', '3');
      if (rows && cols) {
        let tableHTML = '<table border="1" style="border-collapse: collapse; width: 100%;">';
        for (let i = 0; i < parseInt(rows); i++) {
          tableHTML += '<tr>';
          for (let j = 0; j < parseInt(cols); j++) {
            tableHTML += '<td style="padding: 8px; border: 1px solid #ccc;">Cell</td>';
          }
          tableHTML += '</tr>';
        }
        tableHTML += '</table>';
        this.execCommand('insertHTML', tableHTML);
      }
    },
    insertHorizontalRule() {
      this.execCommand('insertHTML', '<hr>');
    },
    toggleFullscreen() {
      this.isFullscreen = !this.isFullscreen;
    },
    exportContent(format) {
      const text = this.$refs.editorRef?.innerText || '';
      const html = this.$refs.editorRef?.innerHTML || '';
      
      switch (format) {
        case 'html':
          const blob = new Blob([html], { type: 'text/html' });
          const url = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = url;
          a.download = 'document.html';
          a.click();
          break;
        case 'text':
          const textBlob = new Blob([text], { type: 'text/plain' });
          const textUrl = URL.createObjectURL(textBlob);
          const textA = document.createElement('a');
          textA.href = textUrl;
          textA.download = 'document.txt';
          textA.click();
          break;
      }
    }
  }
}
</script>

<style scoped>
.rich-text-editor {
  max-width: 1000px;
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
  z-index: 1000;
  background: white;
  padding: 0;
  border-radius: 0;
}

.editor-toolbar {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  padding: 15px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
  border-radius: 8px 8px 0 0;
}

.toolbar-section {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 5px;
  background: white;
  border-radius: 6px;
  border: 1px solid #e0e0e0;
}

.toolbar-section button {
  padding: 8px 12px;
  border: none;
  background: transparent;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  color: #333;
  transition: all 0.3s ease;
  min-width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.toolbar-section button:hover:not(:disabled) {
  background: #e9ecef;
}

.toolbar-section button.active {
  background: #4caf50;
  color: white;
}

.toolbar-section button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.toolbar-section select {
  padding: 6px 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 12px;
  background: white;
  cursor: pointer;
  min-width: 80px;
}

.toolbar-section select:focus {
  outline: none;
  border-color: #4caf50;
}

.toolbar-section input[type="color"] {
  width: 36px;
  height: 36px;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
  padding: 0;
  background: none;
}

.toolbar-section input[type="color"]::-webkit-color-swatch-wrapper {
  padding: 0;
}

.toolbar-section input[type="color"]::-webkit-color-swatch {
  border: none;
  border-radius: 3px;
}

.style-panel,
.media-panel {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-top: none;
  padding: 15px;
  border-radius: 0 0 8px 8px;
}

.style-panel h4,
.media-panel h4 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 14px;
  font-weight: 600;
}

.style-buttons,
.media-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 15px;
}

.style-buttons button,
.media-buttons button {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 12px;
  color: #333;
  transition: all 0.3s ease;
}

.style-buttons button:hover,
.media-buttons button:hover {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.color-palette {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 5px;
}

.color-btn {
  width: 24px;
  height: 24px;
  border: 1px solid #ddd;
  border-radius: 3px;
  cursor: pointer;
  transition: transform 0.2s ease;
}

.color-btn:hover {
  transform: scale(1.1);
  border-color: #333;
}

.editor-container {
  min-height: 400px;
  border: 1px solid #e0e0e0;
  border-top: none;
  background: white;
}

.editor-content {
  min-height: 400px;
  padding: 20px;
  font-size: 16px;
  line-height: 1.6;
  color: #333;
  outline: none;
  overflow-y: auto;
}

.editor-content:focus {
  box-shadow: inset 0 0 0 2px #4caf50;
}

.editor-content h1,
.editor-content h2,
.editor-content h3 {
  margin: 20px 0 10px 0;
  color: #333;
}

.editor-content h1 {
  font-size: 28px;
}

.editor-content h2 {
  font-size: 24px;
}

.editor-content h3 {
  font-size: 20px;
}

.editor-content p {
  margin: 10px 0;
}

.editor-content ul,
.editor-content ol {
  margin: 10px 0;
  padding-left: 30px;
}

.editor-content li {
  margin: 5px 0;
}

.editor-content blockquote {
  margin: 20px 0;
  padding: 15px 20px;
  background: #f8f9fa;
  border-left: 4px solid #4caf50;
  font-style: italic;
}

.editor-content pre {
  background: #f8f9fa;
  padding: 15px;
  border-radius: 4px;
  overflow-x: auto;
  font-family: 'Courier New', monospace;
  font-size: 14px;
}

.editor-content table {
  width: 100%;
  border-collapse: collapse;
  margin: 15px 0;
}

.editor-content table td,
.editor-content table th {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.editor-content table th {
  background: #f8f9fa;
  font-weight: 600;
}

.editor-content img {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
  margin: 10px 0;
}

.editor-content a {
  color: #4caf50;
  text-decoration: underline;
}

.editor-content a:hover {
  color: #45a049;
}

.editor-content hr {
  border: none;
  border-top: 2px solid #e0e0e0;
  margin: 20px 0;
}

.editor-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-top: none;
  border-radius: 0 0 8px 8px;
  font-size: 12px;
  color: #666;
}

.word-count {
  display: flex;
  gap: 15px;
}

.editor-status {
  color: #4caf50;
  font-weight: 500;
}

@media (max-width: 768px) {
  .rich-text-editor {
    padding: 15px;
  }
  
  .editor-toolbar {
    flex-direction: column;
    gap: 8px;
  }
  
  .toolbar-section {
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .toolbar-section button {
    min-width: 32px;
    height: 32px;
    font-size: 12px;
  }
  
  .toolbar-section select {
    min-width: 60px;
    font-size: 11px;
  }
  
  .toolbar-section input[type="color"] {
    width: 32px;
    height: 32px;
  }
  
  .style-buttons,
  .media-buttons {
    justify-content: center;
  }
  
  .color-palette {
    grid-template-columns: repeat(4, 1fr);
  }
  
  .editor-content {
    padding: 15px;
    font-size: 14px;
  }
  
  .editor-footer {
    flex-direction: column;
    gap: 8px;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .rich-text-editor {
    padding: 10px;
  }
  
  .editor-toolbar {
    padding: 10px;
  }
  
  .toolbar-section {
    padding: 3px;
  }
  
  .toolbar-section button {
    min-width: 28px;
    height: 28px;
    font-size: 11px;
    padding: 4px 8px;
  }
  
  .toolbar-section select {
    min-width: 50px;
    font-size: 10px;
    padding: 4px 6px;
  }
  
  .toolbar-section input[type="color"] {
    width: 28px;
    height: 28px;
  }
  
  .style-panel,
  .media-panel {
    padding: 10px;
  }
  
  .style-buttons button,
  .media-buttons button {
    padding: 4px 8px;
    font-size: 11px;
  }
  
  .color-palette {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .color-btn {
    width: 20px;
    height: 20px;
  }
  
  .editor-content {
    padding: 10px;
    font-size: 13px;
  }
  
  .editor-footer {
    padding: 8px 10px;
    font-size: 11px;
  }
}
</style>

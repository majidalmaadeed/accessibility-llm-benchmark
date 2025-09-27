<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Rich Text Editor</h1>
      <p class="page-subtitle">
        Advanced rich text editing interface
      </p>
    </div>

    <div class="card">
      <div class="rich-text-toolbar">
        <button
          :class="['toolbar-btn', { active: isBold }]"
          @click="toggleFormat('bold')"
          title="Bold"
        >
          B
        </button>
        <button
          :class="['toolbar-btn', { active: isItalic }]"
          @click="toggleFormat('italic')"
          title="Italic"
        >
          I
        </button>
        <button
          :class="['toolbar-btn', { active: isUnderline }]"
          @click="toggleFormat('underline')"
          title="Underline"
        >
          U
        </button>
        <div style="width: 1px; height: 20px; backgroundColor: #ddd; margin: 0 5px" />
        <button
          :class="['toolbar-btn', { active: alignment === 'left' }]"
          @click="setAlignment('left')"
          title="Align Left"
        >
          ⬅
        </button>
        <button
          :class="['toolbar-btn', { active: alignment === 'center' }]"
          @click="setAlignment('center')"
          title="Align Center"
        >
          ↔
        </button>
        <button
          :class="['toolbar-btn', { active: alignment === 'right' }]"
          @click="setAlignment('right')"
          title="Align Right"
        >
          ➡
        </button>
        <div style="width: 1px; height: 20px; backgroundColor: #ddd; margin: 0 5px" />
        <button
          class="toolbar-btn"
          @click="insertList('bullet')"
          title="Bullet List"
        >
          •
        </button>
        <button
          class="toolbar-btn"
          @click="insertList('number')"
          title="Numbered List"
        >
          1.
        </button>
        <button
          class="toolbar-btn"
          @click="insertTable"
          title="Insert Table"
        >
          ⊞
        </button>
        <div style="width: 1px; height: 20px; backgroundColor: #ddd; margin: 0 5px" />
        <button
          class="toolbar-btn"
          @click="insertImage"
          title="Insert Image"
        >
          🖼
        </button>
        <button
          class="toolbar-btn"
          @click="insertLink"
          title="Insert Link"
        >
          🔗
        </button>
        <button
          class="toolbar-btn"
          @click="insertHorizontalLine"
          title="Horizontal Line"
        >
          ➖
        </button>
        <button
          class="toolbar-btn"
          @click="insertPageBreak"
          title="Page Break"
        >
          📄
        </button>
        <div style="width: 1px; height: 20px; backgroundColor: #ddd; margin: 0 5px" />
        <select
          class="toolbar-btn"
          :value="fontSize"
          @change="setFontSize($event.target.value)"
          style="border: 1px solid #ddd; borderRadius: 4px"
        >
          <option value="8">8px</option>
          <option value="10">10px</option>
          <option value="12">12px</option>
          <option value="14">14px</option>
          <option value="16">16px</option>
          <option value="18">18px</option>
          <option value="20">20px</option>
          <option value="24">24px</option>
          <option value="32">32px</option>
        </select>
        <input
          type="color"
          :value="fontColor"
          @change="setFontColor($event.target.value)"
          style="width: 30px; height: 30px; border: none; borderRadius: 4px"
          title="Text Color"
        />
      </div>

      <textarea
        class="rich-text-editor"
        :value="content"
        @input="updateContent"
        placeholder="Start typing your document here..."
        :style="{
          fontFamily: 'inherit',
          fontSize: fontSize + 'px',
          color: fontColor,
          textAlign: alignment,
          fontWeight: isBold ? 'bold' : 'normal',
          fontStyle: isItalic ? 'italic' : 'normal',
          textDecoration: isUnderline ? 'underline' : 'none'
        }"
      />
    </div>

    <div class="card">
      <div style="display: flex; justifyContent: space-between; alignItems: center; margin-bottom: 1rem">
        <h2>Document Actions</h2>
        <div style="display: flex; gap: 1rem">
          <button class="btn" @click="saveDocument">
            Save Document
          </button>
          <button class="btn btn-secondary" @click="loadDocument">
            Load Document
          </button>
          <button class="btn btn-secondary" @click="printDocument">
            Print
          </button>
        </div>
      </div>
      <div style="display: flex; gap: 2rem; color: #666">
        <span>Words: {{ wordCount }}</span>
        <span>Characters: {{ characterCount }}</span>
        <span>Lines: {{ lineCount }}</span>
      </div>
    </div>

    <div v-if="showImageModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Insert Image</h3>
          <button class="modal-close" @click="showImageModal = false">
            ×
          </button>
        </div>
        <div class="form-group">
          <label class="form-label">Image URL</label>
          <input
            type="url"
            class="form-control"
            placeholder="https://example.com/image.jpg"
          />
        </div>
        <div class="form-group">
          <label class="form-label">Alt Text</label>
          <input
            type="text"
            class="form-control"
            placeholder="Describe the image"
          />
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showImageModal = false">
            Cancel
          </button>
          <button class="btn" @click="showImageModal = false">
            Insert Image
          </button>
        </div>
      </div>
    </div>

    <div v-if="showLinkModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Insert Link</h3>
          <button class="modal-close" @click="showLinkModal = false">
            ×
          </button>
        </div>
        <div class="form-group">
          <label class="form-label">Link URL</label>
          <input
            type="url"
            class="form-control"
            placeholder="https://example.com"
          />
        </div>
        <div class="form-group">
          <label class="form-label">Link Text</label>
          <input
            type="text"
            class="form-control"
            placeholder="Click here"
          />
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showLinkModal = false">
            Cancel
          </button>
          <button class="btn" @click="showLinkModal = false">
            Insert Link
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RichTextEditor',
  data() {
    return {
      content: '',
      isBold: false,
      isItalic: false,
      isUnderline: false,
      fontSize: '14',
      fontColor: '#000000',
      alignment: 'left',
      showImageModal: false,
      showLinkModal: false
    }
  },
  computed: {
    wordCount() {
      return this.content.trim().split(/\s+/).filter(word => word.length > 0).length
    },
    characterCount() {
      return this.content.length
    },
    lineCount() {
      return this.content.split('\n').length
    }
  },
  methods: {
    updateContent(e) {
      this.content = e.target.value
    },
    toggleFormat(format) {
      switch (format) {
        case 'bold':
          this.isBold = !this.isBold
          break
        case 'italic':
          this.isItalic = !this.isItalic
          break
        case 'underline':
          this.isUnderline = !this.isUnderline
          break
      }
    },
    setAlignment(align) {
      this.alignment = align
    },
    setFontSize(size) {
      this.fontSize = size
    },
    setFontColor(color) {
      this.fontColor = color
    },
    insertList(type) {
      const listItem = type === 'bullet' ? '• ' : '1. '
      this.content += listItem
    },
    insertTable() {
      const table = `
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Row 1    | Data 1   | Data 1   |
| Row 2    | Data 2   | Data 2   |
| Row 3    | Data 3   | Data 3   |
`
      this.content += table
    },
    insertImage() {
      this.showImageModal = true
    },
    insertLink() {
      this.showLinkModal = true
    },
    insertHorizontalLine() {
      this.content += '\n---\n'
    },
    insertPageBreak() {
      this.content += '\n\n--- PAGE BREAK ---\n\n'
    },
    saveDocument() {
      const blob = new Blob([this.content], { type: 'text/plain' })
      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'document.txt'
      a.click()
      window.URL.revokeObjectURL(url)
    },
    loadDocument() {
      const input = document.createElement('input')
      input.type = 'file'
      input.accept = '.txt,.md'
      input.onchange = (e) => {
        const file = e.target.files[0]
        if (file) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.content = e.target.result
          }
          reader.readAsText(file)
        }
      }
      input.click()
    },
    printDocument() {
      window.print()
    }
  }
}
</script>

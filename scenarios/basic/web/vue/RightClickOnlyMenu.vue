<template>
  <div class="file-manager">
    <h1>File Manager</h1>
    <p>Manage your files and documents. Right-click on any file to access additional options.</p>
    
    <div class="stats-section">
      <h2>File Statistics</h2>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number">{{ files.length }}</div>
          <div class="stat-label">Total Files</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">{{ totalSize }} MB</div>
          <div class="stat-label">Total Size</div>
        </div>
      </div>
    </div>

    <div class="files-container">
      <div class="files-header">
        <h2>Files</h2>
        <p>Right-click on any file to access additional options</p>
      </div>
      
      <div class="files-content">
        <div class="files-list">
          <div 
            v-for="file in files" 
            :key="file.id"
            class="file-item"
            :class="{ 'selected': selectedFile === file.id }"
            @contextmenu="handleContextMenu($event, file.id)"
          >
            <div class="file-icon">{{ getFileIcon(file.type) }}</div>
            
            <div class="file-info">
              <h3>{{ file.name }}</h3>
              <div class="file-details">
                <span>Size: {{ file.size }}</span>
                <span>Modified: {{ file.lastModified }}</span>
                <span class="file-type">{{ file.type.toUpperCase() }}</span>
              </div>
            </div>
            
            <div class="file-actions">
              <button @click="handleAction('View')" class="action-btn view">View</button>
              <button @click="handleAction('Download')" class="action-btn download">Download</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Essential delete option only available via right-click -->
    <div v-if="contextMenu.visible" class="context-menu" :style="{ left: contextMenu.x + 'px', top: contextMenu.y + 'px' }">
      <div @click="handleContextAction('Open')" class="context-item">Open</div>
      <div @click="handleContextAction('Download')" class="context-item">Download</div>
      <div @click="handleContextAction('Rename')" class="context-item">Rename</div>
      <div @click="handleContextAction('Move')" class="context-item">Move</div>
      <div @click="handleContextAction('Copy')" class="context-item">Copy</div>
      <div @click="handleContextAction('Delete')" class="context-item delete">Delete</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RightClickOnlyMenu',
  data() {
    return {
      files: [
        { id: 1, name: 'Document1.pdf', type: 'pdf', size: '2.3 MB', lastModified: '2024-01-15' },
        { id: 2, name: 'Image1.jpg', type: 'image', size: '1.8 MB', lastModified: '2024-01-14' },
        { id: 3, name: 'Spreadsheet.xlsx', type: 'excel', size: '856 KB', lastModified: '2024-01-13' },
        { id: 4, name: 'Presentation.pptx', type: 'powerpoint', size: '4.2 MB', lastModified: '2024-01-12' },
        { id: 5, name: 'TextFile.txt', type: 'text', size: '12 KB', lastModified: '2024-01-11' }
      ],
      contextMenu: { visible: false, x: 0, y: 0, fileId: null },
      selectedFile: null
    }
  },
  computed: {
    totalSize() {
      return this.files.reduce((total, file) => {
        const size = parseFloat(file.size)
        return total + (isNaN(size) ? 0 : size)
      }, 0).toFixed(1)
    }
  },
  mounted() {
    document.addEventListener('click', this.handleClick)
  },
  beforeDestroy() {
    document.removeEventListener('click', this.handleClick)
  },
  methods: {
    getFileIcon(type) {
      const icons = {
        pdf: '📄',
        image: '🖼️',
        excel: '📊',
        powerpoint: '📈',
        text: '📝'
      }
      return icons[type] || '📄'
    },
    handleContextMenu(e, fileId) {
      e.preventDefault()
      this.contextMenu = {
        visible: true,
        x: e.clientX,
        y: e.clientY,
        fileId: fileId
      }
      this.selectedFile = fileId
    },
    handleClick() {
      this.contextMenu = { visible: false, x: 0, y: 0, fileId: null }
      this.selectedFile = null
    },
    handleAction(action) {
      const file = this.files.find(f => f.id === this.selectedFile)
      alert(`${action} action performed on ${file?.name}`)
    },
    handleContextAction(action) {
      const file = this.files.find(f => f.id === this.contextMenu.fileId)
      alert(`${action} action performed on ${file?.name}`)
      this.contextMenu = { visible: false, x: 0, y: 0, fileId: null }
      this.selectedFile = null
    }
  }
}
</script>

<style scoped>
.file-manager {
  max-width: 1000px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.stats-section {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 30px;
}

.stats-section h2 {
  margin: 0 0 15px 0;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-top: 15px;
}

.stat-card {
  background: white;
  padding: 15px;
  border-radius: 4px;
  text-align: center;
  border: 1px solid #e0e0e0;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

.files-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
  border: 1px solid #e0e0e0;
}

.files-header {
  background: #f8f9fa;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.files-header h2 {
  margin: 0;
  font-size: 20px;
}

.files-header p {
  margin: 5px 0 0 0;
  color: #666;
  font-size: 14px;
}

.files-content {
  padding: 20px;
}

.files-list {
  display: grid;
  gap: 10px;
}

.file-item {
  display: flex;
  align-items: center;
  padding: 15px;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  background: #fafafa;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.file-item.selected {
  background: #e3f2fd;
}

.file-icon {
  font-size: 24px;
  margin-right: 15px;
}

.file-info {
  flex: 1;
}

.file-info h3 {
  margin: 0 0 5px 0;
  font-size: 16px;
  color: #333;
}

.file-details {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #666;
}

.file-type {
  color: #007bff;
  font-weight: bold;
}

.file-actions {
  display: flex;
  gap: 10px;
  align-items: center;
}

.action-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.action-btn.view {
  background: #007bff;
  color: white;
}

.action-btn.download {
  background: #6c757d;
  color: white;
}

.context-menu {
  position: fixed;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 1000;
  min-width: 150px;
}

.context-item {
  padding: 10px 15px;
  cursor: pointer;
  border-bottom: 1px solid #eee;
  font-size: 14px;
}

.context-item:hover {
  background: #f8f9fa;
}

.context-item.delete {
  color: #dc3545;
}

.context-item:last-child {
  border-bottom: none;
}
</style>

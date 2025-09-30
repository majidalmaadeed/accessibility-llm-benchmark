<template>
  <div class="file-explorer-application">
    <header class="app-header">
      <div class="header-content">
        <h1 class="app-title">File Explorer</h1>
        <div class="header-actions">
          <button class="action-btn" @click="createNewFolder">New Folder</button>
          <button class="action-btn" @click="uploadFiles">Upload</button>
          <button class="action-btn" @click="showSettings = true">Settings</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="explorer-container">
        <div class="sidebar">
          <div class="sidebar-section">
            <h3 class="sidebar-title">Quick Access</h3>
            <ul class="sidebar-list">
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Desktop" class="sidebar-icon" />
                <span class="sidebar-text">Desktop</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Documents" class="sidebar-icon" />
                <span class="sidebar-text">Documents</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Downloads" class="sidebar-icon" />
                <span class="sidebar-text">Downloads</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Pictures" class="sidebar-icon" />
                <span class="sidebar-text">Pictures</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Music" class="sidebar-icon" />
                <span class="sidebar-text">Music</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Videos" class="sidebar-icon" />
                <span class="sidebar-text">Videos</span>
              </li>
            </ul>
          </div>
          
          <div class="sidebar-section">
            <h3 class="sidebar-title">This PC</h3>
            <ul class="sidebar-list">
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Local Disk C" class="sidebar-icon" />
                <span class="sidebar-text">Local Disk (C:)</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="Local Disk D" class="sidebar-icon" />
                <span class="sidebar-text">Local Disk (D:)</span>
              </li>
              <li class="sidebar-item">
                <img src="/api/placeholder/20/20" alt="DVD Drive" class="sidebar-icon" />
                <span class="sidebar-text">DVD Drive (E:)</span>
              </li>
            </ul>
          </div>
        </div>

        <div class="main-panel">
          <div class="toolbar">
            <div class="toolbar-left">
              <div class="breadcrumb">
                <span class="breadcrumb-item">This PC</span>
                <span class="breadcrumb-separator">></span>
                <span class="breadcrumb-item">Documents</span>
                <span class="breadcrumb-separator">></span>
                <span class="breadcrumb-item current">Projects</span>
              </div>
            </div>
            
            <div class="toolbar-right">
              <div class="view-controls">
                <button class="view-btn" :class="{ active: viewMode === 'grid' }" @click="viewMode = 'grid'">Grid</button>
                <button class="view-btn" :class="{ active: viewMode === 'list' }" @click="viewMode = 'list'">List</button>
                <button class="view-btn" :class="{ active: viewMode === 'details' }" @click="viewMode = 'details'">Details</button>
              </div>
              <div class="sort-controls">
                <select class="sort-select" v-model="sortBy">
                  <option value="name">Name</option>
                  <option value="date">Date Modified</option>
                  <option value="size">Size</option>
                  <option value="type">Type</option>
                </select>
              </div>
            </div>
          </div>

          <div class="file-panel">
            <div class="file-grid" v-if="viewMode === 'grid'">
              <div
                v-for="item in files"
                :key="item.id"
                class="file-item"
                :class="{ selected: item.selected }"
                @click="selectItem(item)"
                @dblclick="openItem(item)"
                @contextmenu="showContextMenu($event, item)"
              >
                <div class="file-icon">
                  <img :src="item.icon" :alt="item.type" />
                </div>
                <div class="file-name">{{ item.name }}</div>
                <div class="file-meta">
                  <span class="file-size">{{ item.size }}</span>
                  <span class="file-date">{{ item.date }}</span>
                </div>
              </div>
            </div>

            <div class="file-list" v-if="viewMode === 'list'">
              <div class="list-header">
                <div class="list-column name">Name</div>
                <div class="list-column date">Date Modified</div>
                <div class="list-column type">Type</div>
                <div class="list-column size">Size</div>
              </div>
              <div
                v-for="item in files"
                :key="item.id"
                class="list-item"
                :class="{ selected: item.selected }"
                @click="selectItem(item)"
                @dblclick="openItem(item)"
                @contextmenu="showContextMenu($event, item)"
              >
                <div class="list-column name">
                  <img :src="item.icon" :alt="item.type" class="list-icon" />
                  <span class="list-name">{{ item.name }}</span>
                </div>
                <div class="list-column date">{{ item.date }}</div>
                <div class="list-column type">{{ item.type }}</div>
                <div class="list-column size">{{ item.size }}</div>
              </div>
            </div>

            <div class="file-details" v-if="viewMode === 'details'">
              <div class="details-header">
                <div class="details-column name">Name</div>
                <div class="details-column size">Size</div>
                <div class="details-column type">Type</div>
                <div class="details-column date">Date Modified</div>
                <div class="details-column attributes">Attributes</div>
              </div>
              <div
                v-for="item in files"
                :key="item.id"
                class="details-item"
                :class="{ selected: item.selected }"
                @click="selectItem(item)"
                @dblclick="openItem(item)"
                @contextmenu="showContextMenu($event, item)"
              >
                <div class="details-column name">
                  <img :src="item.icon" :alt="item.type" class="details-icon" />
                  <span class="details-name">{{ item.name }}</span>
                </div>
                <div class="details-column size">{{ item.size }}</div>
                <div class="details-column type">{{ item.type }}</div>
                <div class="details-column date">{{ item.date }}</div>
                <div class="details-column attributes">{{ item.attributes }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- Context Menu -->
    <div 
      class="context-menu" 
      v-if="contextMenu.visible"
      :style="{ 
        left: contextMenu.x + 'px', 
        top: contextMenu.y + 'px' 
      }"
      @click.stop
    >
      <div class="context-item" @click="openItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Open" class="context-icon" />
        <span class="context-text">Open</span>
      </div>
      <div class="context-item" @click="openWithItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Open With" class="context-icon" />
        <span class="context-text">Open with</span>
      </div>
      <div class="context-separator"></div>
      <div class="context-item" @click="cutItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Cut" class="context-icon" />
        <span class="context-text">Cut</span>
      </div>
      <div class="context-item" @click="copyItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Copy" class="context-icon" />
        <span class="context-text">Copy</span>
      </div>
      <div class="context-item" @click="pasteItem()">
        <img src="/api/placeholder/16/16" alt="Paste" class="context-icon" />
        <span class="context-text">Paste</span>
      </div>
      <div class="context-separator"></div>
      <div class="context-item" @click="renameItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Rename" class="context-icon" />
        <span class="context-text">Rename</span>
      </div>
      <div class="context-item" @click="deleteItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Delete" class="context-icon" />
        <span class="context-text">Delete</span>
      </div>
      <div class="context-separator"></div>
      <div class="context-item" @click="propertiesItem(contextMenu.item)">
        <img src="/api/placeholder/16/16" alt="Properties" class="context-icon" />
        <span class="context-text">Properties</span>
      </div>
    </div>

    <!-- Settings Modal -->
    <div class="modal-overlay" v-if="showSettings" @click="closeSettings">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">File Explorer Settings</h3>
          <button class="close-btn" @click="closeSettings">×</button>
        </div>
        <div class="settings-content">
          <div class="setting-group">
            <h4 class="setting-title">General</h4>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.showHiddenFiles" />
                Show hidden files and folders
              </label>
            </div>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.showFileExtensions" />
                Show file extensions
              </label>
            </div>
          </div>
          <div class="setting-group">
            <h4 class="setting-title">View</h4>
            <div class="setting-item">
              <label class="setting-label">
                Default view mode:
                <select v-model="settings.defaultView">
                  <option value="grid">Grid</option>
                  <option value="list">List</option>
                  <option value="details">Details</option>
                </select>
              </label>
            </div>
          </div>
          <div class="setting-actions">
            <button class="btn btn-secondary" @click="closeSettings">Cancel</button>
            <button class="btn btn-primary" @click="saveSettings">Save Settings</button>
          </div>
        </div>
      </div>
    </div>

    <footer class="app-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>File Operations</h4>
          <ul class="footer-links">
            <li><a href="/copy">Copy Files</a></li>
            <li><a href="/move">Move Files</a></li>
            <li><a href="/delete">Delete Files</a></li>
            <li><a href="/rename">Rename Files</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>View Options</h4>
          <ul class="footer-links">
            <li><a href="/grid">Grid View</a></li>
            <li><a href="/list">List View</a></li>
            <li><a href="/details">Details View</a></li>
            <li><a href="/sort">Sort Options</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Tools</h4>
          <ul class="footer-links">
            <li><a href="/search">Search Files</a></li>
            <li><a href="/properties">File Properties</a></li>
            <li><a href="/compression">Compression</a></li>
            <li><a href="/encryption">Encryption</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Help</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/tutorials">Tutorials</a></li>
            <li><a href="/shortcuts">Keyboard Shortcuts</a></li>
            <li><a href="/feedback">Feedback</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 File Explorer Application. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'

const viewMode = ref('grid')
const sortBy = ref('name')
const showSettings = ref(false)
const selectedItems = ref([])

const contextMenu = reactive({
  visible: false,
  x: 0,
  y: 0,
  item: null
})

const settings = ref({
  showHiddenFiles: false,
  showFileExtensions: true,
  defaultView: 'grid'
})

const files = ref([
  {
    id: 1,
    name: 'Project Proposal.docx',
    type: 'Microsoft Word Document',
    size: '2.4 MB',
    date: '2024-01-15',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 2,
    name: 'Budget Spreadsheet.xlsx',
    type: 'Microsoft Excel Worksheet',
    size: '1.8 MB',
    date: '2024-01-14',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 3,
    name: 'Presentation.pptx',
    type: 'Microsoft PowerPoint Presentation',
    size: '5.2 MB',
    date: '2024-01-13',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 4,
    name: 'Design Mockups',
    type: 'File Folder',
    size: '12 items',
    date: '2024-01-12',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 5,
    name: 'Meeting Notes.txt',
    type: 'Text Document',
    size: '45 KB',
    date: '2024-01-11',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 6,
    name: 'Project Timeline.pdf',
    type: 'PDF Document',
    size: '3.1 MB',
    date: '2024-01-10',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 7,
    name: 'Logo Design.png',
    type: 'PNG Image',
    size: '892 KB',
    date: '2024-01-09',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  },
  {
    id: 8,
    name: 'Database Backup.sql',
    type: 'SQL Script',
    size: '15.6 MB',
    date: '2024-01-08',
    attributes: 'A',
    icon: '/api/placeholder/40/40',
    selected: false
  }
])

const selectItem = (item) => {
  if (!item.selected) {
    // Clear other selections
    files.value.forEach(file => file.selected = false)
    selectedItems.value = []
  }
  
  item.selected = !item.selected
  if (item.selected) {
    selectedItems.value.push(item)
  } else {
    const index = selectedItems.value.findIndex(selected => selected.id === item.id)
    if (index > -1) {
      selectedItems.value.splice(index, 1)
    }
  }
}

const openItem = (item) => {
  console.log('Opening item:', item.name)
  hideContextMenu()
}

const showContextMenu = (event, item) => {
  event.preventDefault()
  contextMenu.visible = true
  contextMenu.x = event.clientX
  contextMenu.y = event.clientY
  contextMenu.item = item
}

const hideContextMenu = () => {
  contextMenu.visible = false
  contextMenu.item = null
}

const openWithItem = (item) => {
  console.log('Open with:', item.name)
  hideContextMenu()
}

const cutItem = (item) => {
  console.log('Cut:', item.name)
  hideContextMenu()
}

const copyItem = (item) => {
  console.log('Copy:', item.name)
  hideContextMenu()
}

const pasteItem = () => {
  console.log('Paste')
  hideContextMenu()
}

const renameItem = (item) => {
  console.log('Rename:', item.name)
  hideContextMenu()
}

const deleteItem = (item) => {
  if (confirm(`Are you sure you want to delete "${item.name}"?`)) {
    const index = files.value.findIndex(f => f.id === item.id)
    if (index > -1) {
      files.value.splice(index, 1)
    }
  }
  hideContextMenu()
}

const propertiesItem = (item) => {
  console.log('Properties:', item.name)
  hideContextMenu()
}

const createNewFolder = () => {
  const folderName = prompt('Enter folder name:')
  if (folderName) {
    const newFolder = {
      id: Date.now(),
      name: folderName,
      type: 'File Folder',
      size: '0 items',
      date: new Date().toISOString().split('T')[0],
      attributes: 'A',
      icon: '/api/placeholder/40/40',
      selected: false
    }
    files.value.unshift(newFolder)
  }
}

const uploadFiles = () => {
  console.log('Upload files')
}

const closeSettings = () => {
  showSettings.value = false
}

const saveSettings = () => {
  console.log('Saving settings:', settings.value)
  closeSettings()
}

const handleClickOutside = (event) => {
  if (contextMenu.visible && !event.target.closest('.context-menu')) {
    hideContextMenu()
  }
}

const handleKeydown = (event) => {
  if (event.key === 'Escape') {
    hideContextMenu()
    if (showSettings.value) {
      closeSettings()
    }
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
  document.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.file-explorer-application {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.app-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px;
}

.app-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.action-btn {
  padding: 10px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 30px 20px;
}

.explorer-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
  display: flex;
  min-height: 600px;
}

.sidebar {
  width: 250px;
  background: #f8f9fa;
  border-right: 1px solid #eee;
  padding: 20px 0;
}

.sidebar-section {
  margin-bottom: 30px;
}

.sidebar-title {
  margin: 0 0 15px 0;
  font-size: 14px;
  font-weight: bold;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: 0 20px;
}

.sidebar-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sidebar-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 20px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.sidebar-item:hover {
  background: #e9ecef;
}

.sidebar-icon {
  width: 20px;
  height: 20px;
  object-fit: cover;
}

.sidebar-text {
  font-size: 14px;
  color: #333;
}

.main-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
}

.toolbar-left {
  flex: 1;
}

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
}

.breadcrumb-item {
  color: #007bff;
  cursor: pointer;
}

.breadcrumb-item.current {
  color: #333;
  font-weight: 500;
  cursor: default;
}

.breadcrumb-separator {
  color: #ccc;
}

.toolbar-right {
  display: flex;
  gap: 20px;
  align-items: center;
}

.view-controls {
  display: flex;
  gap: 4px;
}

.view-btn {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  cursor: pointer;
  font-size: 12px;
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

.sort-controls {
  display: flex;
  align-items: center;
  gap: 8px;
}

.sort-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  background: white;
  cursor: pointer;
}

.sort-select:focus {
  outline: none;
  border-color: #007bff;
}

.file-panel {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.file-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 20px;
}

.file-item {
  padding: 15px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: white;
  cursor: pointer;
  transition: all 0.2s ease;
  text-align: center;
}

.file-item:hover {
  border-color: #007bff;
  box-shadow: 0 4px 12px rgba(0,123,255,0.1);
  transform: translateY(-2px);
}

.file-item.selected {
  border-color: #007bff;
  background: #f8f9ff;
}

.file-icon {
  text-align: center;
  margin-bottom: 10px;
}

.file-icon img {
  width: 40px;
  height: 40px;
  object-fit: cover;
}

.file-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
  word-break: break-word;
  font-size: 14px;
}

.file-meta {
  display: flex;
  flex-direction: column;
  gap: 4px;
  font-size: 11px;
  color: #666;
}

.file-list {
  display: flex;
  flex-direction: column;
}

.list-header {
  display: grid;
  grid-template-columns: 1fr 120px 120px 80px;
  gap: 20px;
  padding: 10px 15px;
  background: #f8f9fa;
  border-bottom: 1px solid #eee;
  font-weight: bold;
  color: #666;
  font-size: 12px;
}

.list-item {
  display: grid;
  grid-template-columns: 1fr 120px 120px 80px;
  gap: 20px;
  padding: 10px 15px;
  border-bottom: 1px solid #f0f0f0;
  cursor: pointer;
  transition: all 0.2s ease;
}

.list-item:hover {
  background: #f8f9ff;
}

.list-item.selected {
  background: #e3f2fd;
}

.list-column {
  display: flex;
  align-items: center;
  gap: 10px;
}

.list-icon {
  width: 20px;
  height: 20px;
  object-fit: cover;
}

.list-name {
  font-weight: 500;
  color: #333;
}

.file-details {
  display: flex;
  flex-direction: column;
}

.details-header {
  display: grid;
  grid-template-columns: 1fr 80px 120px 120px 100px;
  gap: 20px;
  padding: 10px 15px;
  background: #f8f9fa;
  border-bottom: 1px solid #eee;
  font-weight: bold;
  color: #666;
  font-size: 12px;
}

.details-item {
  display: grid;
  grid-template-columns: 1fr 80px 120px 120px 100px;
  gap: 20px;
  padding: 10px 15px;
  border-bottom: 1px solid #f0f0f0;
  cursor: pointer;
  transition: all 0.2s ease;
}

.details-item:hover {
  background: #f8f9ff;
}

.details-item.selected {
  background: #e3f2fd;
}

.details-column {
  display: flex;
  align-items: center;
  gap: 10px;
}

.details-icon {
  width: 20px;
  height: 20px;
  object-fit: cover;
}

.details-name {
  font-weight: 500;
  color: #333;
}

.context-menu {
  position: fixed;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 1000;
  min-width: 180px;
  padding: 5px 0;
}

.context-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 15px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.context-item:hover {
  background: #f8f9fa;
}

.context-icon {
  width: 16px;
  height: 16px;
  object-fit: cover;
}

.context-text {
  font-size: 14px;
  color: #333;
}

.context-separator {
  height: 1px;
  background: #eee;
  margin: 5px 0;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
  border-radius: 12px 12px 0 0;
}

.modal-title {
  margin: 0;
  font-size: 18px;
  color: #333;
}

.close-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #666;
  padding: 0;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.close-btn:hover {
  background: #f0f0f0;
  color: #333;
}

.settings-content {
  padding: 30px;
}

.setting-group {
  margin-bottom: 30px;
}

.setting-title {
  margin: 0 0 15px 0;
  font-size: 16px;
  color: #333;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

.setting-item {
  margin-bottom: 15px;
}

.setting-label {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.setting-label input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #007bff;
}

.setting-label select {
  margin-left: 10px;
  padding: 5px 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.setting-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #eee;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #007bff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #545b62;
}

.app-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 1024px) {
  .explorer-container {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
    padding: 20px;
  }
  
  .sidebar-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .sidebar-item {
    padding: 8px 12px;
    border: 1px solid #eee;
    border-radius: 4px;
    background: white;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    height: auto;
    padding: 20px;
  }

  .header-actions {
    flex-wrap: wrap;
    justify-content: center;
  }

  .toolbar {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }

  .toolbar-right {
    justify-content: center;
  }

  .file-grid {
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  }

  .list-header,
  .list-item,
  .details-header,
  .details-item {
    grid-template-columns: 1fr;
    gap: 10px;
  }

  .list-column,
  .details-column {
    justify-content: flex-start;
  }

  .modal-content {
    width: 95%;
  }

  .setting-actions {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .file-grid {
    grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  }

  .file-item {
    padding: 10px;
  }

  .file-name {
    font-size: 12px;
  }

  .file-meta {
    font-size: 10px;
  }

  .context-menu {
    min-width: 150px;
  }

  .context-item {
    padding: 6px 12px;
  }

  .context-text {
    font-size: 12px;
  }
}
</style>

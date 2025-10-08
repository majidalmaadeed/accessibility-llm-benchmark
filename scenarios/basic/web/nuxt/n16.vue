<template>
  <div class="file-management-system">
    <header class="system-header">
      <div class="header-content">
        <h1 class="system-title">File Manager</h1>
        <div class="header-actions">
          <button class="action-btn" @click="uploadFile">Upload File</button>
          <button class="action-btn" @click="createFolder">New Folder</button>
          <button class="action-btn" @click="refreshFiles">Refresh</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="content-container">
        <div class="toolbar">
          <div class="toolbar-left">
            <div class="breadcrumb">
              <span class="breadcrumb-item">Home</span>
              <span class="breadcrumb-separator">/</span>
              <span class="breadcrumb-item">Documents</span>
              <span class="breadcrumb-separator">/</span>
              <span class="breadcrumb-item current">Projects</span>
            </div>
          </div>
          
          <div class="toolbar-right">
            <div class="view-controls">
              <button class="view-btn active">Grid</button>
              <button class="view-btn">List</button>
              <button class="view-btn">Details</button>
            </div>
            <div class="sort-controls">
              <select class="sort-select">
                <option value="name">Name</option>
                <option value="date">Date Modified</option>
                <option value="size">Size</option>
                <option value="type">Type</option>
              </select>
            </div>
          </div>
        </div>

        <div class="file-browser">
          <div class="file-grid" v-if="!isLoading">
            <div
              v-for="item in files"
              :key="item.id"
              class="file-item"
              @click="selectItem(item)"
              @dblclick="openItem(item)"
            >
              <div class="file-icon">
                <img :src="item.icon" :alt="item.type" />
              </div>
              <div class="file-info">
                <div class="file-name">{{ item.name }}</div>
                <div class="file-meta">
                  <span class="file-size">{{ item.size }}</span>
                  <span class="file-date">{{ item.date }}</span>
                </div>
              </div>
              <div class="file-actions">
                <button class="action-icon" @click.stop="downloadItem(item)">Download</button>
                <button class="action-icon" @click.stop="shareItem(item)">Share</button>
                <button class="action-icon" @click.stop="deleteItem(item)">Delete</button>
              </div>
            </div>
          </div>

          <div class="loading-container" v-if="isLoading">
            <div class="loading-spinner"></div>
            <div class="loading-text">Loading files...</div>
          </div>

          <div class="empty-state" v-if="!isLoading && files.length === 0">
            <div class="empty-icon">
              <img src="/api/placeholder/80/80" alt="Empty Folder" />
            </div>
            <div class="empty-title">No files found</div>
            <div class="empty-description">Upload files or create folders to get started</div>
            <button class="empty-action" @click="uploadFile">Upload Files</button>
          </div>
        </div>

        <div class="upload-section" v-if="showUpload">
          <div class="upload-area" @drop="handleDrop" @dragover.prevent @dragenter.prevent>
            <div class="upload-content">
              <div class="upload-icon">
                <img src="/api/placeholder/60/60" alt="Upload" />
              </div>
              <div class="upload-text">
                <div class="upload-title">Drop files here to upload</div>
                <div class="upload-subtitle">or click to browse files</div>
              </div>
              <input 
                type="file" 
                ref="fileInput"
                @change="handleFileSelect"
                multiple
                class="file-input"
              />
            </div>
          </div>
          
          <div class="upload-progress" v-if="uploadProgress > 0">
            <div class="progress-bar">
              <div class="progress-fill" :style="{ width: uploadProgress + '%' }"></div>
            </div>
            <div class="progress-text">{{ uploadProgress }}% complete</div>
          </div>
        </div>

        <div class="file-details" v-if="selectedItem">
          <div class="details-header">
            <h3 class="details-title">File Details</h3>
            <button class="close-btn" @click="closeDetails">×</button>
          </div>
          <div class="details-content">
            <div class="detail-item">
              <span class="detail-label">Name:</span>
              <span class="detail-value">{{ selectedItem.name }}</span>
            </div>
            <div class="detail-item">
              <span class="detail-label">Type:</span>
              <span class="detail-value">{{ selectedItem.type }}</span>
            </div>
            <div class="detail-item">
              <span class="detail-label">Size:</span>
              <span class="detail-value">{{ selectedItem.size }}</span>
            </div>
            <div class="detail-item">
              <span class="detail-label">Modified:</span>
              <span class="detail-value">{{ selectedItem.date }}</span>
            </div>
            <div class="detail-item">
              <span class="detail-label">Location:</span>
              <span class="detail-value">{{ selectedItem.path }}</span>
            </div>
          </div>
        </div>
      </div>
    </main>

    <footer class="system-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>File Operations</h4>
          <ul class="footer-links">
            <li><a href="/upload">Upload Files</a></li>
            <li><a href="/download">Download Files</a></li>
            <li><a href="/share">Share Files</a></li>
            <li><a href="/sync">Sync Files</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Organization</h4>
          <ul class="footer-links">
            <li><a href="/folders">Create Folders</a></li>
            <li><a href="/tags">Add Tags</a></li>
            <li><a href="/search">Search Files</a></li>
            <li><a href="/favorites">Favorites</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Settings</h4>
          <ul class="footer-links">
            <li><a href="/preferences">Preferences</a></li>
            <li><a href="/storage">Storage Settings</a></li>
            <li><a href="/security">Security</a></li>
            <li><a href="/backup">Backup</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Support</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact Support</a></li>
            <li><a href="/feedback">Feedback</a></li>
            <li><a href="/status">System Status</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 File Management System. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const isLoading = ref(false)
const showUpload = ref(false)
const selectedItem = ref(null)
const uploadProgress = ref(0)
const fileInput = ref(null)

const files = ref([
  {
    id: 1,
    name: 'Project Proposal.docx',
    type: 'Document',
    size: '2.4 MB',
    date: '2024-01-15',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 2,
    name: 'Budget Spreadsheet.xlsx',
    type: 'Spreadsheet',
    size: '1.8 MB',
    date: '2024-01-14',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 3,
    name: 'Presentation.pptx',
    type: 'Presentation',
    size: '5.2 MB',
    date: '2024-01-13',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 4,
    name: 'Design Mockups',
    type: 'Folder',
    size: '12 items',
    date: '2024-01-12',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 5,
    name: 'Meeting Notes.txt',
    type: 'Text File',
    size: '45 KB',
    date: '2024-01-11',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  },
  {
    id: 6,
    name: 'Project Timeline.pdf',
    type: 'PDF',
    size: '3.1 MB',
    date: '2024-01-10',
    path: '/Documents/Projects',
    icon: '/api/placeholder/40/40'
  }
])

const uploadFile = () => {
  showUpload.value = true
  if (fileInput.value) {
    fileInput.value.click()
  }
}

const createFolder = () => {
  const folderName = prompt('Enter folder name:')
  if (folderName) {
    const newFolder = {
      id: Date.now(),
      name: folderName,
      type: 'Folder',
      size: '0 items',
      date: new Date().toISOString().split('T')[0],
      path: '/Documents/Projects',
      icon: '/api/placeholder/40/40'
    }
    files.value.unshift(newFolder)
  }
}

const refreshFiles = async () => {
  isLoading.value = true
  showUpload.value = false
  selectedItem.value = null
  
  // Simulate API call
  await new Promise(resolve => setTimeout(resolve, 2000))
  
  isLoading.value = false
}

const selectItem = (item) => {
  selectedItem.value = item
}

const openItem = (item) => {
  if (item.type === 'Folder') {
    // Navigate to folder
    console.log('Opening folder:', item.name)
  } else {
    // Open file
    console.log('Opening file:', item.name)
  }
}

const downloadItem = (item) => {
  console.log('Downloading:', item.name)
}

const shareItem = (item) => {
  console.log('Sharing:', item.name)
}

const deleteItem = (item) => {
  if (confirm(`Are you sure you want to delete "${item.name}"?`)) {
    const index = files.value.findIndex(f => f.id === item.id)
    if (index > -1) {
      files.value.splice(index, 1)
    }
  }
}

const handleFileSelect = (event) => {
  const selectedFiles = Array.from(event.target.files)
  uploadFiles(selectedFiles)
}

const handleDrop = (event) => {
  const droppedFiles = Array.from(event.dataTransfer.files)
  uploadFiles(droppedFiles)
}

const uploadFiles = async (fileList) => {
  showUpload.value = true
  uploadProgress.value = 0
  
  for (let i = 0; i < fileList.length; i++) {
    const file = fileList[i]
    
    // Simulate upload progress
    for (let progress = 0; progress <= 100; progress += 10) {
      uploadProgress.value = progress
      await new Promise(resolve => setTimeout(resolve, 100))
    }
    
    // Add file to list
    const newFile = {
      id: Date.now() + i,
      name: file.name,
      type: getFileType(file.name),
      size: formatFileSize(file.size),
      date: new Date().toISOString().split('T')[0],
      path: '/Documents/Projects',
      icon: '/api/placeholder/40/40'
    }
    files.value.unshift(newFile)
  }
  
  uploadProgress.value = 0
  showUpload.value = false
}

const getFileType = (filename) => {
  const extension = filename.split('.').pop().toLowerCase()
  const typeMap = {
    'doc': 'Document',
    'docx': 'Document',
    'pdf': 'PDF',
    'txt': 'Text File',
    'xls': 'Spreadsheet',
    'xlsx': 'Spreadsheet',
    'ppt': 'Presentation',
    'pptx': 'Presentation',
    'jpg': 'Image',
    'jpeg': 'Image',
    'png': 'Image',
    'gif': 'Image'
  }
  return typeMap[extension] || 'File'
}

const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 Bytes'
  const k = 1024
  const sizes = ['Bytes', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}

const closeDetails = () => {
  selectedItem.value = null
}

onMounted(() => {
  // Simulate initial loading
  refreshFiles()
})
</script>

<style scoped>
.file-management-system {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.system-header {
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

.system-title {
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

.content-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
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

.file-browser {
  padding: 30px;
  min-height: 400px;
}

.file-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 20px;
}

.file-item {
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: white;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.file-item:hover {
  border-color: #007bff;
  box-shadow: 0 4px 12px rgba(0,123,255,0.1);
  transform: translateY(-2px);
}

.file-icon {
  text-align: center;
  margin-bottom: 15px;
}

.file-icon img {
  width: 40px;
  height: 40px;
  object-fit: cover;
}

.file-info {
  text-align: center;
  margin-bottom: 15px;
}

.file-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
  word-break: break-word;
}

.file-meta {
  display: flex;
  flex-direction: column;
  gap: 4px;
  font-size: 12px;
  color: #666;
}

.file-actions {
  position: absolute;
  top: 10px;
  right: 10px;
  display: flex;
  gap: 4px;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.file-item:hover .file-actions {
  opacity: 1;
}

.action-icon {
  padding: 4px 8px;
  border: none;
  background: #f8f9fa;
  color: #333;
  border-radius: 4px;
  cursor: pointer;
  font-size: 10px;
  transition: all 0.2s ease;
}

.action-icon:hover {
  background: #007bff;
  color: white;
}

.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #007bff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.loading-text {
  font-size: 16px;
  color: #666;
  font-weight: 500;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  text-align: center;
}

.empty-icon {
  margin-bottom: 20px;
}

.empty-icon img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  opacity: 0.5;
}

.empty-title {
  font-size: 20px;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.empty-description {
  color: #666;
  margin-bottom: 30px;
}

.empty-action {
  padding: 12px 24px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.empty-action:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.upload-section {
  padding: 30px;
  border-top: 1px solid #eee;
}

.upload-area {
  border: 2px dashed #ddd;
  border-radius: 8px;
  padding: 40px;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.upload-area:hover {
  border-color: #007bff;
  background: #f8f9ff;
}

.upload-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 15px;
}

.upload-icon img {
  width: 60px;
  height: 60px;
  object-fit: cover;
  opacity: 0.6;
}

.upload-text {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.upload-title {
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.upload-subtitle {
  color: #666;
}

.file-input {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  cursor: pointer;
}

.upload-progress {
  margin-top: 20px;
}

.progress-bar {
  width: 100%;
  height: 8px;
  background: #f0f0f0;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 10px;
}

.progress-fill {
  height: 100%;
  background: #007bff;
  transition: width 0.3s ease;
}

.progress-text {
  text-align: center;
  font-size: 14px;
  color: #666;
}

.file-details {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  z-index: 1000;
  min-width: 400px;
  max-width: 500px;
}

.details-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
  border-radius: 12px 12px 0 0;
}

.details-title {
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

.details-content {
  padding: 30px;
}

.detail-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
}

.detail-item:last-child {
  border-bottom: none;
}

.detail-label {
  font-weight: bold;
  color: #666;
  min-width: 80px;
}

.detail-value {
  color: #333;
  text-align: right;
  flex: 1;
}

.system-footer {
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
    gap: 20px;
    align-items: stretch;
  }

  .toolbar-right {
    justify-content: center;
  }

  .file-grid {
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  }

  .file-details {
    min-width: 90%;
    max-width: 90%;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .file-grid {
    grid-template-columns: 1fr;
  }

  .file-item {
    padding: 15px;
  }

  .upload-area {
    padding: 20px;
  }

  .upload-content {
    gap: 10px;
  }

  .upload-title {
    font-size: 16px;
  }
}
</style>

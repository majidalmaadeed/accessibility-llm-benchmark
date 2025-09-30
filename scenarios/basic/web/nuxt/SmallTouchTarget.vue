<template>
  <div class="mobile-app">
    <header class="app-header">
      <h1>Mobile App Interface</h1>
      <div class="header-actions">
        <button class="header-btn">🔍</button>
        <button class="header-btn">🔔</button>
        <button class="header-btn">⚙️</button>
      </div>
    </header>

    <div class="app-content">
      <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="action-buttons">
          <button class="action-btn">📱</button>
          <button class="action-btn">📧</button>
          <button class="action-btn">📷</button>
          <button class="action-btn">🎵</button>
          <button class="action-btn">📅</button>
          <button class="action-btn">🗺️</button>
          <button class="action-btn">💰</button>
          <button class="action-btn">🏠</button>
        </div>
      </div>

      <div class="content-sections">
        <div class="section">
          <h3>Recent Items</h3>
          <div class="item-list">
            <div
              v-for="item in recentItems"
              :key="item.id"
              class="item-card"
            >
              <div class="item-icon">{{ item.icon }}</div>
              <div class="item-content">
                <h4>{{ item.title }}</h4>
                <p>{{ item.description }}</p>
              </div>
              <div class="item-actions">
                <button class="item-btn">⋮</button>
              </div>
            </div>
          </div>
        </div>

        <div class="section">
          <h3>Navigation</h3>
          <div class="nav-buttons">
            <button class="nav-btn">Home</button>
            <button class="nav-btn">Search</button>
            <button class="nav-btn">Profile</button>
            <button class="nav-btn">Settings</button>
            <button class="nav-btn">Help</button>
            <button class="nav-btn">About</button>
          </div>
        </div>

        <div class="section">
          <h3>Media Controls</h3>
          <div class="media-controls">
            <button class="media-btn">⏮️</button>
            <button class="media-btn play-btn">▶️</button>
            <button class="media-btn">⏭️</button>
            <button class="media-btn">🔀</button>
            <button class="media-btn">🔁</button>
          </div>
        </div>

        <div class="section">
          <h3>Form Controls</h3>
          <div class="form-section">
            <div class="form-group">
              <label>Search:</label>
              <div class="input-group">
                <input type="text" class="form-input" placeholder="Enter search term" />
                <button class="input-btn">🔍</button>
              </div>
            </div>
            
            <div class="form-group">
              <label>Options:</label>
              <div class="checkbox-group">
                <label class="checkbox-item">
                  <input type="checkbox" />
                  Option 1
                </label>
                <label class="checkbox-item">
                  <input type="checkbox" />
                  Option 2
                </label>
                <label class="checkbox-item">
                  <input type="checkbox" />
                  Option 3
                </label>
              </div>
            </div>

            <div class="form-group">
              <label>Rating:</label>
              <div class="rating-group">
                <button class="rating-btn">⭐</button>
                <button class="rating-btn">⭐</button>
                <button class="rating-btn">⭐</button>
                <button class="rating-btn">⭐</button>
                <button class="rating-btn">⭐</button>
              </div>
            </div>
          </div>
        </div>

        <div class="section">
          <h3>Tab Navigation</h3>
          <div class="tab-container">
            <div class="tab-buttons">
              <button class="tab-btn active">Tab 1</button>
              <button class="tab-btn">Tab 2</button>
              <button class="tab-btn">Tab 3</button>
            </div>
            <div class="tab-content">
              <p>Content for the active tab goes here.</p>
            </div>
          </div>
        </div>

        <div class="section">
          <h3>Floating Actions</h3>
          <div class="floating-actions">
            <button class="fab primary">+</button>
            <button class="fab secondary">✏️</button>
            <button class="fab secondary">📷</button>
            <button class="fab secondary">📝</button>
          </div>
        </div>

        <div class="section">
          <h3>List Actions</h3>
          <div class="list-actions">
            <div
              v-for="action in listActions"
              :key="action.id"
              class="list-item"
            >
              <span class="item-text">{{ action.text }}</span>
              <div class="item-controls">
                <button class="control-btn">✓</button>
                <button class="control-btn">✏️</button>
                <button class="control-btn">🗑️</button>
              </div>
            </div>
          </div>
        </div>

        <div class="section">
          <h3>Toggle Controls</h3>
          <div class="toggle-section">
            <div class="toggle-item">
              <span>Notifications</span>
              <button class="toggle-btn">🔘</button>
            </div>
            <div class="toggle-item">
              <span>Dark Mode</span>
              <button class="toggle-btn">⚪</button>
            </div>
            <div class="toggle-item">
              <span>Auto-save</span>
              <button class="toggle-btn">🔘</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="bottom-navigation">
      <button class="nav-item active">
        <span class="nav-icon">🏠</span>
        <span class="nav-label">Home</span>
      </button>
      <button class="nav-item">
        <span class="nav-icon">🔍</span>
        <span class="nav-label">Search</span>
      </button>
      <button class="nav-item">
        <span class="nav-icon">❤️</span>
        <span class="nav-label">Favorites</span>
      </button>
      <button class="nav-item">
        <span class="nav-icon">👤</span>
        <span class="nav-label">Profile</span>
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const recentItems = ref([
  {
    id: 1,
    icon: '📄',
    title: 'Document.pdf',
    description: 'Last modified 2 hours ago'
  },
  {
    id: 2,
    icon: '🖼️',
    title: 'Photo.jpg',
    description: 'Last modified 1 day ago'
  },
  {
    id: 3,
    icon: '🎵',
    title: 'Song.mp3',
    description: 'Last modified 3 days ago'
  }
])

const listActions = ref([
  { id: 1, text: 'Complete project proposal' },
  { id: 2, text: 'Review quarterly reports' },
  { id: 3, text: 'Schedule team meeting' },
  { id: 4, text: 'Update contact information' }
])
</script>

<style scoped>
.mobile-app {
  max-width: 400px;
  margin: 0 auto;
  min-height: 100vh;
  background: #f5f5f5;
  font-family: Arial, sans-serif;
  display: flex;
  flex-direction: column;
}

.app-header {
  background: #007bff;
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.app-header h1 {
  margin: 0;
  font-size: 20px;
}

.header-actions {
  display: flex;
  gap: 10px;
}

.header-btn {
  background: none;
  border: none;
  color: white;
  font-size: 18px;
  cursor: pointer;
  padding: 5px;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.header-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.app-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.quick-actions {
  margin-bottom: 30px;
}

.quick-actions h2 {
  margin: 0 0 15px 0;
  font-size: 18px;
  color: #333;
}

.action-buttons {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
}

.action-btn {
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  font-size: 24px;
  cursor: pointer;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
}

.content-sections {
  display: flex;
  flex-direction: column;
  gap: 25px;
}

.section h3 {
  margin: 0 0 15px 0;
  font-size: 16px;
  color: #333;
}

.item-list {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.item-card {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 12px 15px;
  border-bottom: 1px solid #eee;
}

.item-card:last-child {
  border-bottom: none;
}

.item-icon {
  font-size: 20px;
  flex-shrink: 0;
}

.item-content {
  flex: 1;
  min-width: 0;
}

.item-content h4 {
  margin: 0 0 5px 0;
  font-size: 14px;
  color: #333;
}

.item-content p {
  margin: 0;
  font-size: 12px;
  color: #666;
}

.item-actions {
  flex-shrink: 0;
}

.item-btn {
  background: none;
  border: none;
  color: #666;
  font-size: 16px;
  cursor: pointer;
  padding: 5px;
  border-radius: 4px;
}

.item-btn:hover {
  background: #f8f9fa;
}

.nav-buttons {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 8px;
}

.nav-btn {
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  padding: 10px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
}

.media-controls {
  display: flex;
  gap: 8px;
  justify-content: center;
}

.media-btn {
  background: white;
  border: 1px solid #ddd;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.media-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
}

.play-btn {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.play-btn:hover {
  background: #0056b3;
}

.form-section {
  background: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.form-group {
  margin-bottom: 15px;
}

.form-group:last-child {
  margin-bottom: 0;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.input-group {
  display: flex;
  gap: 5px;
}

.form-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.input-btn {
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 12px;
  cursor: pointer;
  font-size: 14px;
}

.input-btn:hover {
  background: #0056b3;
}

.checkbox-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.checkbox-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  cursor: pointer;
}

.checkbox-item input[type="checkbox"] {
  width: 16px;
  height: 16px;
}

.rating-group {
  display: flex;
  gap: 5px;
}

.rating-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  padding: 2px;
  border-radius: 2px;
  transition: all 0.2s ease;
}

.rating-btn:hover {
  background: #f8f9fa;
}

.tab-container {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.tab-buttons {
  display: flex;
  border-bottom: 1px solid #eee;
}

.tab-btn {
  flex: 1;
  background: none;
  border: none;
  padding: 10px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.tab-btn.active {
  background: #f8f9fa;
  color: #007bff;
  font-weight: bold;
}

.tab-btn:hover:not(.active) {
  background: #f8f9fa;
}

.tab-content {
  padding: 15px;
}

.tab-content p {
  margin: 0;
  font-size: 14px;
  color: #666;
}

.floating-actions {
  display: flex;
  gap: 10px;
  justify-content: center;
  align-items: center;
}

.fab {
  border-radius: 50%;
  border: none;
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.fab.primary {
  width: 50px;
  height: 50px;
  background: #007bff;
  color: white;
}

.fab.secondary {
  width: 40px;
  height: 40px;
  background: white;
  color: #666;
  border: 1px solid #ddd;
}

.fab:hover {
  transform: scale(1.1);
}

.fab.primary:hover {
  background: #0056b3;
}

.fab.secondary:hover {
  background: #f8f9fa;
  border-color: #007bff;
}

.list-actions {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.list-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 15px;
  border-bottom: 1px solid #eee;
}

.list-item:last-child {
  border-bottom: none;
}

.item-text {
  flex: 1;
  font-size: 14px;
  color: #333;
}

.item-controls {
  display: flex;
  gap: 5px;
}

.control-btn {
  background: none;
  border: none;
  color: #666;
  font-size: 14px;
  cursor: pointer;
  padding: 5px;
  border-radius: 3px;
  transition: all 0.2s ease;
}

.control-btn:hover {
  background: #f8f9fa;
}

.toggle-section {
  background: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.toggle-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  font-size: 14px;
  color: #333;
}

.toggle-btn {
  background: none;
  border: none;
  font-size: 16px;
  cursor: pointer;
  padding: 2px;
  border-radius: 2px;
  transition: all 0.2s ease;
}

.toggle-btn:hover {
  background: #f8f9fa;
}

.bottom-navigation {
  background: white;
  border-top: 1px solid #eee;
  display: flex;
  padding: 10px 0;
}

.nav-item {
  flex: 1;
  background: none;
  border: none;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  padding: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-item.active {
  color: #007bff;
}

.nav-item:hover {
  background: #f8f9fa;
}

.nav-icon {
  font-size: 18px;
}

.nav-label {
  font-size: 10px;
  font-weight: bold;
}

@media (max-width: 480px) {
  .mobile-app {
    max-width: 100%;
  }
  
  .action-buttons {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .nav-buttons {
    grid-template-columns: 1fr;
  }
}
</style>

<template>
  <div class="container">
    <div class="main-content">
      <h1>Settings Modal</h1>
      <p>Configure your application settings using the modal below.</p>
      
      <button @click="openModal" class="open-modal-btn">
        Open Settings Modal
      </button>
      
      <p class="description">
        This page demonstrates a modal dialog that violates accessibility guidelines by not managing focus properly.
        When the modal opens, focus should be trapped inside it and returned to the trigger button when closed.
      </p>
    </div>

    <!-- Modal -->
    <div 
      v-if="isOpen" 
      class="modal-overlay"
      @click="closeModalOnOverlay"
      <!-- MISSING: role="dialog", aria-modal="true", aria-labelledby -->
    >
      <div 
        class="modal-content"
        @click.stop
        ref="modalContent"
      >
        <div class="modal-header">
          <h2 class="modal-title">Settings</h2>
          <button 
            @click="closeModal" 
            class="close-btn"
            aria-label="Close modal"
          >
            ×
          </button>
        </div>
        
        <form>
          <div class="form-group">
            <label for="theme">Theme:</label>
            <select 
              id="theme" 
              v-model="settings.theme"
            >
              <option value="light">Light</option>
              <option value="dark">Dark</option>
              <option value="auto">Auto</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="language">Language:</label>
            <select 
              id="language" 
              v-model="settings.language"
            >
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="notifications">Email Notifications:</label>
            <select 
              id="notifications" 
              v-model="settings.notifications"
            >
              <option value="all">All</option>
              <option value="important">Important Only</option>
              <option value="none">None</option>
            </select>
          </div>
        </form>
        
        <div class="modal-actions">
          <button 
            type="button" 
            class="btn btn-secondary" 
            @click="closeModal"
          >
            Cancel
          </button>
          <button 
            type="button" 
            class="btn btn-primary" 
            @click="saveSettings"
          >
            Save Settings
          </button>
        </div>
      </div>
    </div>

    <div class="accessibility-info">
      <h3>Accessibility Issues:</h3>
      <ul>
        <li><strong>No focus trap:</strong> Tab key can move focus outside the modal</li>
        <li><strong>No initial focus:</strong> Focus doesn't move to the modal when it opens</li>
        <li><strong>No focus return:</strong> Focus doesn't return to trigger button when modal closes</li>
        <li><strong>Missing ARIA attributes:</strong> No role="dialog", aria-modal, or aria-labelledby</li>
        <li><strong>Escape key not handled:</strong> Modal doesn't close when Escape is pressed</li>
      </ul>
      
      <h3>How to Fix:</h3>
      <ul>
        <li>Add <code>role="dialog"</code> and <code>aria-modal="true"</code> to modal</li>
        <li>Add <code>aria-labelledby="modal-title"</code> to reference the title</li>
        <li>Implement focus trap to keep focus within modal</li>
        <li>Set initial focus to first focusable element in modal</li>
        <li>Return focus to trigger button when modal closes</li>
        <li>Handle Escape key to close modal</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ModalWithoutFocusManagement',
  data() {
    return {
      isOpen: false,
      settings: {
        theme: 'light',
        language: 'en',
        notifications: 'all'
      },
      previousActiveElement: null
    };
  },
  methods: {
    openModal() {
      this.previousActiveElement = document.activeElement;
      this.isOpen = true;
      
      // MISSING: Focus management
      // Should set focus to modal and implement focus trap
      this.$nextTick(() => {
        // MISSING: Focus trap implementation
      });
    },
    closeModal() {
      this.isOpen = false;
      
      // MISSING: Focus return
      // Should return focus to this.previousActiveElement
    },
    closeModalOnOverlay(event) {
      if (event.target === event.currentTarget) {
        this.closeModal();
      }
    },
    saveSettings() {
      alert('Settings saved!');
      this.closeModal();
    },
    handleKeyDown(event) {
      if (event.key === 'Escape' && this.isOpen) {
        this.closeModal();
      }
      
      // MISSING: Focus trap implementation
      // Should handle Tab/Shift+Tab to keep focus within modal
    }
  },
  mounted() {
    document.addEventListener('keydown', this.handleKeyDown);
  },
  beforeUnmount() {
    document.removeEventListener('keydown', this.handleKeyDown);
  }
};
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.open-modal-btn {
  background-color: #007bff;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}

.open-modal-btn:hover {
  background-color: #0056b3;
}

.description {
  margin-top: 20px;
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  max-width: 500px;
  width: 90%;
  position: relative;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

.modal-title {
  margin: 0;
  font-size: 24px;
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
}

.close-btn:hover {
  color: #333;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #333;
}

.form-group select {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.modal-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
  margin-top: 30px;
}

.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover {
  background-color: #0056b3;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #545b62;
}

.accessibility-info {
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}

.accessibility-info ul {
  margin: 10px 0;
  padding-left: 20px;
}

.accessibility-info code {
  background-color: #f8f9fa;
  padding: 2px 4px;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
}
</style>
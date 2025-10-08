<template>
    <!-- Modal -->
  </div>
</template>
<script>
export default {
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
      this.$nextTick(() => {
      });
    },
    closeModal() {
      this.isOpen = false;
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
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}
  margin: 10px 0;
  padding-left: 20px;
}
  background-color: #f8f9fa;
  padding: 2px 4px;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
}
</style>
<script>
  let isModalOpen = false;
  let settings = {
    theme: 'light',
    language: 'en',
    notifications: 'all'
  };

  function openModal() {
    isModalOpen = true;
  }

  function closeModal() {
    isModalOpen = false;
  }

  function closeModalOnOverlay(event) {
    if (event.target === event.currentTarget) {
      closeModal();
    }
  }

  function saveSettings() {
    alert('Settings saved successfully!');
    closeModal();
  }
</script>

<div class="main-container">
  <div class="main-content">
    <h1>Settings Dashboard</h1>
    <p>Manage your application preferences and settings.</p>
    
    <div class="dashboard-content">
      <button on:click={openModal} class="open-modal-btn">
        Open Settings Modal
      </button>
      
      <div class="current-settings">
        <h3>Current Settings:</h3>
        <p><strong>Theme:</strong> {settings.theme}</p>
        <p><strong>Language:</strong> {settings.language}</p>
        <p><strong>Notifications:</strong> {settings.notifications}</p>
      </div>
    </div>
  </div>

  <!-- Modal -->
  {#if isModalOpen}
    <div class="modal-overlay" on:click={closeModalOnOverlay}>
      <div class="modal-content" on:click|stopPropagation>
        <div class="modal-header">
          <h2 class="modal-title">Settings</h2>
          <button on:click={closeModal} class="close-btn" aria-label="Close modal">
            ×
          </button>
        </div>
        
        <form>
          <div class="form-group">
            <label for="theme">Theme:</label>
            <select id="theme" bind:value={settings.theme}>
              <option value="light">Light</option>
              <option value="dark">Dark</option>
              <option value="auto">Auto</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="language">Language:</label>
            <select id="language" bind:value={settings.language}>
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="notifications">Email Notifications:</label>
            <select id="notifications" bind:value={settings.notifications}>
              <option value="all">All</option>
              <option value="important">Important Only</option>
              <option value="none">None</option>
            </select>
          </div>
        </form>
        
        <div class="modal-actions">
          <button type="button" on:click={closeModal} class="btn btn-secondary">
            Cancel
          </button>
          <button type="button" on:click={saveSettings} class="btn btn-primary">
            Save Settings
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .main-container {
    font-family: Arial, sans-serif;
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f5f5f5;
  }

  .main-content {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }

  .dashboard-content {
    margin-top: 30px;
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

  .current-settings {
    margin-top: 20px;
    padding: 20px;
    background-color: #f8f9fa;
    border-radius: 4px;
  }

  .current-settings h3 {
    margin-top: 0;
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
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

  .form-group input, .form-group select {
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
</style>
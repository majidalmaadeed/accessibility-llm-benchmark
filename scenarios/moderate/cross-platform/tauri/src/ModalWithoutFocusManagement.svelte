<script>
  import { onMount } from 'svelte';
  let isModalOpen = false;
  let settings = {
    theme: 'light',
    language: 'en',
    notifications: 'all'
  };
  function openModal() {
    // Show modal
    isModalOpen = true;
    setTimeout(() => {
      const firstInput = document.querySelector('#theme');
    }, 100);
  }
  function closeModal() {
    isModalOpen = false;
    }
  }
  function handleSave() {
    alert('Settings saved successfully!');
    closeModal();
  }
  function handleKeyDown(event) {
    if (event.key === 'Escape' && isModalOpen) {
      closeModal();
    }
  }
  onMount(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  });
</script>
  </div>
</div>
<!-- Modal -->
{#if isModalOpen}
  <div class="modal-overlay" on:click={closeModal}>
    <div class="modal-dialog" on:click|stopPropagation>
      <div class="modal-header">
        <h2 class="modal-title">Settings</h2>
        <button class="close-button" on:click={closeModal}>&times;</button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <select id="theme" bind:value={settings.theme}>
            <option value="light">Light</option>
            <option value="dark">Dark</option>
            <option value="auto">Auto</option>
          </select>
        </div>
        <div class="form-group">
          <select id="language" bind:value={settings.language}>
            <option value="en">English</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
          </select>
        </div>
        <div class="form-group">
          <select id="notifications" bind:value={settings.notifications}>
            <option value="all">All</option>
            <option value="important">Important Only</option>
            <option value="none">None</option>
          </select>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" on:click={closeModal}>Cancel</button>
        <button class="btn btn-primary" on:click={handleSave}>Save Settings</button>
      </div>
    </div>
  </div>
{/if}
<style>
  .container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
  }
  .card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 30px;
  }
  h1 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
  }
  .description {
    color: #666;
    margin-bottom: 30px;
    font-size: 16px;
  }
  .open-modal-button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 15px 30px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .open-modal-button:hover {
    background-color: #0056b3;
  }
  .modal-description {
    margin-top: 20px;
    color: #666;
    font-size: 14px;
  }
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }
  .modal-dialog {
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
    width: 500px;
    max-width: 90vw;
    max-height: 80vh;
    overflow: hidden;
  }
  .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 30px;
    border-bottom: 1px solid #dee2e6;
  }
  .modal-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
  }
  .close-button {
    background: none;
    border: none;
    font-size: 24px;
    color: #666;
    cursor: pointer;
    padding: 0;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .close-button:hover {
    background-color: #f8f9fa;
    border-radius: 50%;
  }
  .modal-body {
    padding: 30px;
  }
  .form-group {
    margin-bottom: 20px;
  }
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
  }
  .form-group select {
    width: 100%;
    padding: 10px;
    border: 2px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    background-color: white;
  }
    outline: none;
    border-color: #007bff;
  }
  .modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    padding: 20px 30px;
    border-top: 1px solid #dee2e6;
  }
  .btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .btn-secondary {
    background-color: #6c757d;
    color: white;
  }
  .btn-secondary:hover {
    background-color: #5a6268;
  }
  .btn-primary {
    background-color: #007bff;
    color: white;
  }
  .btn-primary:hover {
    background-color: #0056b3;
  }
    background-color: #e9ecef;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    padding: 20px;
    margin-top: 30px;
  }
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
  }
    margin-left: 20px;
    margin-bottom: 15px;
  }
    margin-bottom: 5px;
    color: #666;
  }
</style>

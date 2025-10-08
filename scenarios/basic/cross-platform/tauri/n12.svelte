<script>
  import { onMount } from 'svelte';
  
  let settings = {
    language: 'en',
    theme: 'system',
    autoSave: true,
    dataCollection: false,
    analytics: true,
    crashReports: true,
    twoFactor: true,
    biometric: false,
    sessionTimeout: 15,
    pushNotifications: true,
    emailNotifications: false,
    smsNotifications: false
  };
  
  let activeTab = 'general';
  
  function switchTab(tab) {
    activeTab = tab;
  }
  
  function updateSetting(key, value) {
    settings[key] = value;
  }
  
  function saveSettings() {
    alert('Settings saved successfully!');
  }
  
  function resetToDefaults() {
    if (confirm('Are you sure you want to reset all settings to their default values?')) {
      settings = {
        language: 'en',
        theme: 'system',
        autoSave: true,
        dataCollection: false,
        analytics: true,
        crashReports: true,
        twoFactor: true,
        biometric: false,
        sessionTimeout: 15,
        pushNotifications: true,
        emailNotifications: false,
        smsNotifications: false
      };
      alert('Settings reset to defaults!');
    }
  }
</script>

<div class="settings-page">
  
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Settings</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Help clicked')}>
          ❓ Help
        </button>
        <button class="header-btn" on:click={() => alert('Back clicked')}>
          ← Back
        </button>
      </div>
    </div>
  </header>
  
  <div class="settings-container">
    <div class="settings-sidebar">
      <nav class="settings-nav">
        <button 
          class="nav-item {activeTab === 'general' ? 'active' : ''}" 
          on:click={() => switchTab('general')}
        >
          ⚙️ General
        </button>
        <button 
          class="nav-item {activeTab === 'privacy' ? 'active' : ''}" 
          on:click={() => switchTab('privacy')}
        >
          🔒 Privacy
        </button>
        <button 
          class="nav-item {activeTab === 'security' ? 'active' : ''}" 
          on:click={() => switchTab('security')}
        >
          🛡️ Security
        </button>
        <button 
          class="nav-item {activeTab === 'notifications' ? 'active' : ''}" 
          on:click={() => switchTab('notifications')}
        >
          🔔 Notifications
        </button>
        <button 
          class="nav-item {activeTab === 'appearance' ? 'active' : ''}" 
          on:click={() => switchTab('appearance')}
        >
          🎨 Appearance
        </button>
        <button 
          class="nav-item {activeTab === 'advanced' ? 'active' : ''}" 
          on:click={() => switchTab('advanced')}
        >
          ⚡ Advanced
        </button>
      </nav>
    </div>
    
    <div class="settings-content">
      {#if activeTab === 'general'}
        <div class="settings-section">
          <h2 class="section-title">General Settings</h2>
          
          <div class="setting-group">
            <label class="setting-label">Language</label>
            <select 
              class="setting-select" 
              value={settings.language}
              on:change={(e) => updateSetting('language', e.target.value)}
            >
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
              <option value="de">German</option>
              <option value="it">Italian</option>
              <option value="pt">Portuguese</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Theme</label>
            <select 
              class="setting-select" 
              value={settings.theme}
              on:change={(e) => updateSetting('theme', e.target.value)}
            >
              <option value="system">System</option>
              <option value="light">Light</option>
              <option value="dark">Dark</option>
            </select>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.autoSave}
                  on:change={(e) => updateSetting('autoSave', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Auto-save</span>
            </div>
          </div>
        </div>
      {/if}
      
      {#if activeTab === 'privacy'}
        <div class="settings-section">
          <h2 class="section-title">Privacy Settings</h2>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.dataCollection}
                  on:change={(e) => updateSetting('dataCollection', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Data Collection</span>
            </div>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.analytics}
                  on:change={(e) => updateSetting('analytics', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Analytics</span>
            </div>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.crashReports}
                  on:change={(e) => updateSetting('crashReports', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Crash Reports</span>
            </div>
          </div>
        </div>
      {/if}
      
      {#if activeTab === 'security'}
        <div class="settings-section">
          <h2 class="section-title">Security Settings</h2>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.twoFactor}
                  on:change={(e) => updateSetting('twoFactor', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Two-Factor Authentication</span>
            </div>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.biometric}
                  on:change={(e) => updateSetting('biometric', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Biometric Login</span>
            </div>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Session Timeout</label>
            <select 
              class="setting-select" 
              value={settings.sessionTimeout}
              on:change={(e) => updateSetting('sessionTimeout', parseInt(e.target.value))}
            >
              <option value="5">5 minutes</option>
              <option value="15">15 minutes</option>
              <option value="30">30 minutes</option>
              <option value="60">1 hour</option>
            </select>
          </div>
        </div>
      {/if}
      
      {#if activeTab === 'notifications'}
        <div class="settings-section">
          <h2 class="section-title">Notification Settings</h2>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.pushNotifications}
                  on:change={(e) => updateSetting('pushNotifications', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Push Notifications</span>
            </div>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.emailNotifications}
                  on:change={(e) => updateSetting('emailNotifications', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Email Notifications</span>
            </div>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input 
                  type="checkbox" 
                  checked={settings.smsNotifications}
                  on:change={(e) => updateSetting('smsNotifications', e.target.checked)}
                />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">SMS Notifications</span>
            </div>
          </div>
        </div>
      {/if}
      
      {#if activeTab === 'appearance'}
        <div class="settings-section">
          <h2 class="section-title">Appearance Settings</h2>
          
          <div class="setting-group">
            <label class="setting-label">Font Size</label>
            <select class="setting-select">
              <option value="small">Small</option>
              <option value="medium" selected>Medium</option>
              <option value="large">Large</option>
              <option value="extra-large">Extra Large</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Color Scheme</label>
            <select class="setting-select">
              <option value="default">Default</option>
              <option value="blue">Blue</option>
              <option value="green">Green</option>
              <option value="purple">Purple</option>
            </select>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input type="checkbox" />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">High Contrast Mode</span>
            </div>
          </div>
        </div>
      {/if}
      
      {#if activeTab === 'advanced'}
        <div class="settings-section">
          <h2 class="section-title">Advanced Settings</h2>
          
          <div class="setting-group">
            <label class="setting-label">Cache Size</label>
            <select class="setting-select">
              <option value="100">100 MB</option>
              <option value="500" selected>500 MB</option>
              <option value="1000">1 GB</option>
              <option value="2000">2 GB</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Log Level</label>
            <select class="setting-select">
              <option value="error">Error</option>
              <option value="warn">Warning</option>
              <option value="info" selected>Info</option>
              <option value="debug">Debug</option>
            </select>
          </div>
          
          <div class="setting-group">
            <div class="toggle-group">
              <label class="toggle-switch">
                <input type="checkbox" />
                <span class="toggle-slider"></span>
              </label>
              <span class="toggle-label">Developer Mode</span>
            </div>
          </div>
        </div>
      {/if}
      
      <div class="settings-actions">
        <button class="action-btn secondary" on:click={resetToDefaults}>
          Reset to Defaults
        </button>
        <button class="action-btn primary" on:click={saveSettings}>
          Save Changes
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  .settings-page {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .settings-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
    display: grid;
    grid-template-columns: 250px 1fr;
    gap: 30px;
  }
  
  .settings-sidebar {
    background: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    height: fit-content;
  }
  
  .settings-nav {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  .nav-item {
    padding: 12px 16px;
    border: none;
    background: none;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    text-align: left;
    border-radius: 6px;
    transition: all 0.2s;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .nav-item:hover {
    background: #f8f9fa;
  }
  
  .nav-item.active {
    background: #007bff;
    color: white;
  }
  
  .settings-content {
    background: white;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .settings-section {
    margin-bottom: 40px;
  }
  
  .section-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 30px 0;
  }
  
  .setting-group {
    margin-bottom: 25px;
  }
  
  .setting-label {
    display: block;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
  }
  
  .setting-select {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    background: white;
    cursor: pointer;
    box-sizing: border-box;
  }
  
  .setting-select:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .toggle-group {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .toggle-switch {
    position: relative;
    display: inline-block;
    width: 50px;
    height: 24px;
    cursor: pointer;
  }
  
  .toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
  }
  
  .toggle-slider {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    border-radius: 24px;
    transition: 0.2s;
  }
  
  .toggle-slider:before {
    position: absolute;
    content: "";
    height: 18px;
    width: 18px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    border-radius: 50%;
    transition: 0.2s;
  }
  
  .toggle-switch input:checked + .toggle-slider {
    background-color: #007bff;
  }
  
  .toggle-switch input:checked + .toggle-slider:before {
    transform: translateX(26px);
  }
  
  .toggle-label {
    font-size: 16px;
    color: #333;
  }
  
  .settings-actions {
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid #eee;
  }
  
  .action-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .action-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .action-btn.primary:hover {
    background: #0056b3;
  }
  
  .action-btn.secondary {
    background: #6c757d;
    color: white;
  }
  
  .action-btn.secondary:hover {
    background: #545b62;
  }
  
  @media (max-width: 768px) {
    .settings-container {
      grid-template-columns: 1fr;
      gap: 20px;
    }
    
    .settings-sidebar {
      order: 2;
    }
    
    .settings-content {
      order: 1;
    }
    
    .settings-nav {
      flex-direction: row;
      overflow-x: auto;
      gap: 10px;
    }
    
    .nav-item {
      white-space: nowrap;
      min-width: fit-content;
    }
    
    .settings-actions {
      flex-direction: column;
    }
  }
</style>

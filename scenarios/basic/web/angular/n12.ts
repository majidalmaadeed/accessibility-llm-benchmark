import { Component } from '@angular/core';

@Component({
  selector: 'app-missing-page-title',
  template: `
    <div class="settings-page">
      <!-- This page intentionally lacks a proper <title> element -->
      <h1>Settings</h1>
      <p>Configure your application preferences and account settings.</p>
      
      <div class="settings-grid">
        <!-- Appearance Settings -->
        <div class="settings-card">
          <h2>Appearance</h2>
          
          <div class="setting-group">
            <label class="setting-label">Theme</label>
            <select [(ngModel)]="settings.theme" class="setting-select">
              <option value="light">Light</option>
              <option value="dark">Dark</option>
              <option value="auto">Auto</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Font Size</label>
            <select [(ngModel)]="settings.fontSize" class="setting-select">
              <option value="small">Small</option>
              <option value="medium">Medium</option>
              <option value="large">Large</option>
            </select>
          </div>
        </div>

        <!-- Language Settings -->
        <div class="settings-card">
          <h2>Language & Region</h2>
          
          <div class="setting-group">
            <label class="setting-label">Language</label>
            <select [(ngModel)]="settings.language" class="setting-select">
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
              <option value="de">German</option>
              <option value="it">Italian</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Time Zone</label>
            <select class="setting-select">
              <option value="utc">UTC</option>
              <option value="est">Eastern Time</option>
              <option value="pst">Pacific Time</option>
              <option value="cet">Central European Time</option>
            </select>
          </div>
        </div>

        <!-- Notification Settings -->
        <div class="settings-card">
          <h2>Notifications</h2>
          
          <div class="checkbox-group">
            <div class="checkbox-item">
              <input
                type="checkbox"
                id="newsletter"
                [(ngModel)]="settings.newsletter"
                name="newsletter"
                class="checkbox-input"
              />
              <label for="newsletter" class="checkbox-label">Enable notifications</label>
            </div>
            
            <div class="checkbox-item">
              <input
                type="checkbox"
                id="autoSave"
                [(ngModel)]="settings.autoSave"
                name="autoSave"
                class="checkbox-input"
              />
              <label for="autoSave" class="checkbox-label">Auto-save changes</label>
            </div>
            
            <div class="checkbox-item">
              <input
                type="checkbox"
                id="emailNotifications"
                class="checkbox-input"
              />
              <label for="emailNotifications" class="checkbox-label">Email notifications</label>
            </div>
          </div>
        </div>

        <!-- Privacy Settings -->
        <div class="settings-card">
          <h2>Privacy & Security</h2>
          
          <div class="setting-group">
            <label class="setting-label">Data Collection</label>
            <select class="setting-select">
              <option value="minimal">Minimal</option>
              <option value="standard">Standard</option>
              <option value="comprehensive">Comprehensive</option>
            </select>
          </div>
          
          <div class="setting-group">
            <label class="setting-label">Session Timeout</label>
            <select class="setting-select">
              <option value="15">15 minutes</option>
              <option value="30">30 minutes</option>
              <option value="60">1 hour</option>
              <option value="240">4 hours</option>
            </select>
          </div>
        </div>
      </div>

      <div class="form-actions">
        <button class="btn-secondary">Cancel</button>
        <button class="btn-primary">Save Changes</button>
      </div>
    </div>
  `,
  styles: [`
    .settings-page {
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .settings-grid {
      display: grid;
      gap: 30px;
    }

    .settings-card {
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border: 1px solid #e0e0e0;
    }

    .settings-card h2 {
      font-size: 20px;
      margin: 0 0 20px 0;
      color: #333;
      border-bottom: 2px solid #007bff;
      padding-bottom: 10px;
    }

    .setting-group {
      margin-bottom: 20px;
    }

    .setting-label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      color: #333;
    }

    .setting-select {
      padding: 8px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      width: 200px;
    }

    .checkbox-group {
      margin-top: 10px;
    }

    .checkbox-item {
      margin-bottom: 15px;
    }

    .checkbox-input {
      margin-right: 10px;
    }

    .checkbox-label {
      display: flex;
      align-items: center;
      cursor: pointer;
      font-weight: bold;
      color: #333;
    }

    .form-actions {
      display: flex;
      gap: 15px;
      justify-content: flex-end;
      margin-top: 30px;
    }

    .btn-primary {
      background: #007bff;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }

    .btn-secondary {
      background: #6c757d;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
  `]
})
export class MissingPageTitleComponent {
  settings = {
    theme: 'light',
    language: 'en',
    newsletter: true,
    autoSave: true,
    fontSize: 'medium'
  };
}

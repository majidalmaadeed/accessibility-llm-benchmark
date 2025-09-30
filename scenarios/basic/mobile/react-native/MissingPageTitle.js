import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  TextInput,
  Switch,
  Alert,
} from 'react-native';

const MissingPageTitle = () => {
  const [settings, setSettings] = useState({
    // Account Settings
    email: 'user@example.com',
    firstName: 'John',
    lastName: 'Doe',
    phone: '+1 (555) 123-4567',
    
    // Privacy Settings
    profileVisibility: 'public',
    showEmail: true,
    showPhone: false,
    allowMessages: true,
    allowNotifications: true,
    
    // Notification Settings
    emailNotifications: true,
    pushNotifications: true,
    smsNotifications: false,
    marketingEmails: false,
    
    // Security Settings
    twoFactorAuth: false,
    loginAlerts: true,
    sessionTimeout: 30,
    
    // App Preferences
    theme: 'light',
    language: 'en',
    timezone: 'UTC-5',
    dateFormat: 'MM/DD/YYYY',
    
    // Advanced Settings
    dataCollection: true,
    analytics: true,
    crashReporting: true,
    betaFeatures: false
  });

  const [activeTab, setActiveTab] = useState('account');
  const [isEditing, setIsEditing] = useState(false);

  const tabs = [
    { id: 'account', name: 'Account', icon: '👤' },
    { id: 'privacy', name: 'Privacy', icon: '🔒' },
    { id: 'notifications', name: 'Notifications', icon: '🔔' },
    { id: 'security', name: 'Security', icon: '🛡️' },
    { id: 'preferences', name: 'Preferences', icon: '⚙️' },
    { id: 'advanced', name: 'Advanced', icon: '🔧' }
  ];

  const handleSettingChange = (key, value) => {
    setSettings(prev => ({
      ...prev,
      [key]: value
    }));
  };

  const handleSave = () => {
    Alert.alert('Settings Saved', 'Your settings have been updated successfully');
    setIsEditing(false);
  };

  const handleReset = () => {
    Alert.alert('Reset Settings', 'Are you sure you want to reset all settings to default?');
  };

  const handleExport = () => {
    Alert.alert('Export Settings', 'Settings exported successfully');
  };

  const renderAccountSettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Account Information</Text>
      
      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Email Address</Text>
        <TextInput
          style={styles.textInput}
          value={settings.email}
          onChangeText={(value) => handleSettingChange('email', value)}
          editable={isEditing}
          keyboardType="email-address"
          autoCapitalize="none"
        />
      </View>

      <View style={styles.inputRow}>
        <View style={styles.inputGroupHalf}>
          <Text style={styles.inputLabel}>First Name</Text>
          <TextInput
            style={styles.textInput}
            value={settings.firstName}
            onChangeText={(value) => handleSettingChange('firstName', value)}
            editable={isEditing}
          />
        </View>
        <View style={styles.inputGroupHalf}>
          <Text style={styles.inputLabel}>Last Name</Text>
          <TextInput
            style={styles.textInput}
            value={settings.lastName}
            onChangeText={(value) => handleSettingChange('lastName', value)}
            editable={isEditing}
          />
        </View>
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Phone Number</Text>
        <TextInput
          style={styles.textInput}
          value={settings.phone}
          onChangeText={(value) => handleSettingChange('phone', value)}
          editable={isEditing}
          keyboardType="phone-pad"
        />
      </View>
    </View>
  );

  const renderPrivacySettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Privacy Controls</Text>
      
      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Profile Visibility</Text>
          <Text style={styles.settingDescription}>Who can see your profile</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.profileVisibility}</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Show Email Address</Text>
          <Text style={styles.settingDescription}>Display email on your profile</Text>
        </View>
        <Switch
          value={settings.showEmail}
          onValueChange={(value) => handleSettingChange('showEmail', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Show Phone Number</Text>
          <Text style={styles.settingDescription}>Display phone on your profile</Text>
        </View>
        <Switch
          value={settings.showPhone}
          onValueChange={(value) => handleSettingChange('showPhone', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Allow Messages</Text>
          <Text style={styles.settingDescription}>Let others send you messages</Text>
        </View>
        <Switch
          value={settings.allowMessages}
          onValueChange={(value) => handleSettingChange('allowMessages', value)}
        />
      </View>
    </View>
  );

  const renderNotificationSettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Notification Preferences</Text>
      
      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Email Notifications</Text>
          <Text style={styles.settingDescription}>Receive notifications via email</Text>
        </View>
        <Switch
          value={settings.emailNotifications}
          onValueChange={(value) => handleSettingChange('emailNotifications', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Push Notifications</Text>
          <Text style={styles.settingDescription}>Receive push notifications</Text>
        </View>
        <Switch
          value={settings.pushNotifications}
          onValueChange={(value) => handleSettingChange('pushNotifications', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>SMS Notifications</Text>
          <Text style={styles.settingDescription}>Receive notifications via SMS</Text>
        </View>
        <Switch
          value={settings.smsNotifications}
          onValueChange={(value) => handleSettingChange('smsNotifications', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Marketing Emails</Text>
          <Text style={styles.settingDescription}>Receive promotional content</Text>
        </View>
        <Switch
          value={settings.marketingEmails}
          onValueChange={(value) => handleSettingChange('marketingEmails', value)}
        />
      </View>
    </View>
  );

  const renderSecuritySettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Security & Authentication</Text>
      
      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Two-Factor Authentication</Text>
          <Text style={styles.settingDescription}>Add an extra layer of security</Text>
        </View>
        <Switch
          value={settings.twoFactorAuth}
          onValueChange={(value) => handleSettingChange('twoFactorAuth', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Login Alerts</Text>
          <Text style={styles.settingDescription}>Get notified of new logins</Text>
        </View>
        <Switch
          value={settings.loginAlerts}
          onValueChange={(value) => handleSettingChange('loginAlerts', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Session Timeout</Text>
          <Text style={styles.settingDescription}>Auto-logout after inactivity</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.sessionTimeout} minutes</Text>
        </TouchableOpacity>
      </View>

      <TouchableOpacity style={styles.actionButton}>
        <Text style={styles.actionButtonText}>Change Password</Text>
      </TouchableOpacity>
    </View>
  );

  const renderPreferenceSettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>App Preferences</Text>
      
      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Theme</Text>
          <Text style={styles.settingDescription}>Choose your preferred theme</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.theme}</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Language</Text>
          <Text style={styles.settingDescription}>Select your language</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.language}</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Timezone</Text>
          <Text style={styles.settingDescription}>Set your timezone</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.timezone}</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Date Format</Text>
          <Text style={styles.settingDescription}>Choose date display format</Text>
        </View>
        <TouchableOpacity style={styles.settingValue}>
          <Text style={styles.settingValueText}>{settings.dateFormat}</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderAdvancedSettings = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Advanced Options</Text>
      
      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Data Collection</Text>
          <Text style={styles.settingDescription}>Allow data collection for improvements</Text>
        </View>
        <Switch
          value={settings.dataCollection}
          onValueChange={(value) => handleSettingChange('dataCollection', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Analytics</Text>
          <Text style={styles.settingDescription}>Help us improve with usage analytics</Text>
        </View>
        <Switch
          value={settings.analytics}
          onValueChange={(value) => handleSettingChange('analytics', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Crash Reporting</Text>
          <Text style={styles.settingDescription}>Send crash reports automatically</Text>
        </View>
        <Switch
          value={settings.crashReporting}
          onValueChange={(value) => handleSettingChange('crashReporting', value)}
        />
      </View>

      <View style={styles.settingItem}>
        <View style={styles.settingInfo}>
          <Text style={styles.settingLabel}>Beta Features</Text>
          <Text style={styles.settingDescription}>Enable experimental features</Text>
        </View>
        <Switch
          value={settings.betaFeatures}
          onValueChange={(value) => handleSettingChange('betaFeatures', value)}
        />
      </View>
    </View>
  );

  const renderTabContent = () => {
    switch (activeTab) {
      case 'account':
        return renderAccountSettings();
      case 'privacy':
        return renderPrivacySettings();
      case 'notifications':
        return renderNotificationSettings();
      case 'security':
        return renderSecuritySettings();
      case 'preferences':
        return renderPreferenceSettings();
      case 'advanced':
        return renderAdvancedSettings();
      default:
        return null;
    }
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header - MISSING PAGE TITLE */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Settings</Text>
        <Text style={styles.headerSubtitle}>Manage your account preferences</Text>
      </View>

      {/* Tab Navigation */}
      <View style={styles.tabContainer}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {tabs.map((tab) => (
            <TouchableOpacity
              key={tab.id}
              style={[
                styles.tabButton,
                activeTab === tab.id && styles.activeTabButton
              ]}
              onPress={() => setActiveTab(tab.id)}
            >
              <Text style={styles.tabIcon}>{tab.icon}</Text>
              <Text style={[
                styles.tabText,
                activeTab === tab.id && styles.activeTabText
              ]}>
                {tab.name}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Content */}
      <View style={styles.content}>
        {renderTabContent()}
      </View>

      {/* Action Buttons */}
      <View style={styles.actionContainer}>
        <View style={styles.actionButtons}>
          <TouchableOpacity
            style={styles.editButton}
            onPress={() => setIsEditing(!isEditing)}
          >
            <Text style={styles.editButtonText}>
              {isEditing ? 'Cancel' : 'Edit'}
            </Text>
          </TouchableOpacity>
          
          {isEditing && (
            <TouchableOpacity
              style={styles.saveButton}
              onPress={handleSave}
            >
              <Text style={styles.saveButtonText}>Save Changes</Text>
            </TouchableOpacity>
          )}
        </View>
        
        <View style={styles.secondaryActions}>
          <TouchableOpacity
            style={styles.secondaryButton}
            onPress={handleReset}
          >
            <Text style={styles.secondaryButtonText}>Reset to Default</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.secondaryButton}
            onPress={handleExport}
          >
            <Text style={styles.secondaryButtonText}>Export Settings</Text>
          </TouchableOpacity>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    backgroundColor: '#2C3E50',
    padding: 24,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#BDC3C7',
  },
  tabContainer: {
    backgroundColor: '#FFFFFF',
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  tabButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 20,
    borderBottomWidth: 2,
    borderBottomColor: 'transparent',
  },
  activeTabButton: {
    borderBottomColor: '#2196F3',
  },
  tabIcon: {
    fontSize: 16,
    marginRight: 8,
  },
  tabText: {
    fontSize: 14,
    color: '#7F8C8D',
    fontWeight: '500',
  },
  activeTabText: {
    color: '#2196F3',
  },
  content: {
    padding: 24,
  },
  section: {
    marginBottom: 32,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginBottom: 20,
  },
  inputGroup: {
    marginBottom: 20,
  },
  inputGroupHalf: {
    flex: 1,
    marginRight: 12,
  },
  inputRow: {
    flexDirection: 'row',
    marginBottom: 20,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: '500',
    color: '#2C3E50',
    marginBottom: 8,
  },
  textInput: {
    borderWidth: 1,
    borderColor: '#BDBDBD',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    fontSize: 16,
    backgroundColor: '#FFFFFF',
  },
  settingItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#F0F0F0',
  },
  settingInfo: {
    flex: 1,
    marginRight: 16,
  },
  settingLabel: {
    fontSize: 16,
    fontWeight: '500',
    color: '#2C3E50',
    marginBottom: 4,
  },
  settingDescription: {
    fontSize: 14,
    color: '#7F8C8D',
  },
  settingValue: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    backgroundColor: '#F5F5F5',
    borderRadius: 6,
  },
  settingValueText: {
    fontSize: 14,
    color: '#2196F3',
    fontWeight: '500',
  },
  actionButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    alignSelf: 'flex-start',
    marginTop: 16,
  },
  actionButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  actionContainer: {
    backgroundColor: '#FFFFFF',
    padding: 24,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
  },
  actionButtons: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  editButton: {
    backgroundColor: '#F5F5F5',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    marginRight: 12,
    borderWidth: 1,
    borderColor: '#BDBDBD',
  },
  editButtonText: {
    color: '#2C3E50',
    fontSize: 16,
    fontWeight: '500',
  },
  saveButton: {
    backgroundColor: '#4CAF50',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  saveButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  secondaryActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  secondaryButton: {
    paddingVertical: 8,
    paddingHorizontal: 16,
  },
  secondaryButtonText: {
    color: '#2196F3',
    fontSize: 14,
    fontWeight: '500',
  },
});

export default MissingPageTitle;

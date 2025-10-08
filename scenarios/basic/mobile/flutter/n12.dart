import 'package:flutter/material.dart';

class MissingPageTitle extends StatefulWidget {
  const MissingPageTitle({Key? key}) : super(key: key);

  @override
  State<MissingPageTitle> createState() => _MissingPageTitleState();
}

class _MissingPageTitleState extends State<MissingPageTitle> {
  String activeTab = 'account';
  bool isEditing = false;

  // Account Settings
  String email = 'user@example.com';
  String firstName = 'John';
  String lastName = 'Doe';
  String phone = '+1 (555) 123-4567';
  
  // Privacy Settings
  String profileVisibility = 'public';
  bool showEmail = true;
  bool showPhone = false;
  bool allowMessages = true;
  bool allowNotifications = true;
  
  // Notification Settings
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = false;
  
  // Security Settings
  bool twoFactorAuth = false;
  bool loginAlerts = true;
  int sessionTimeout = 30;
  
  // App Preferences
  String theme = 'light';
  String language = 'en';
  String timezone = 'UTC-5';
  String dateFormat = 'MM/DD/YYYY';
  
  // Advanced Settings
  bool dataCollection = true;
  bool analytics = true;
  bool crashReporting = true;
  bool betaFeatures = false;

  final List<Map<String, dynamic>> tabs = [
    {'id': 'account', 'name': 'Account', 'icon': Icons.person},
    {'id': 'privacy', 'name': 'Privacy', 'icon': Icons.lock},
    {'id': 'notifications', 'name': 'Notifications', 'icon': Icons.notifications},
    {'id': 'security', 'name': 'Security', 'icon': Icons.security},
    {'id': 'preferences', 'name': 'Preferences', 'icon': Icons.settings},
    {'id': 'advanced', 'name': 'Advanced', 'icon': Icons.build},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(No title specified
      home: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(No title in app bar
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Settings functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Logout functionality
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Tab Navigation
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tabs.map((tab) {
                    final isSelected = activeTab == tab['id'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeTab = tab['id'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              tab['icon'],
                              size: 16,
                              color: isSelected ? Colors.blue : Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tab['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.blue : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildTabContent(),
              ),
            ),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (activeTab) {
      case 'account':
        return _buildAccountSettings();
      case 'privacy':
        return _buildPrivacySettings();
      case 'notifications':
        return _buildNotificationSettings();
      case 'security':
        return _buildSecuritySettings();
      case 'preferences':
        return _buildPreferenceSettings();
      case 'advanced':
        return _buildAdvancedSettings();
      default:
        return Container();
    }
  }

  Widget _buildAccountSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        // Email Field
        TextFormField(
          initialValue: email,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: (value) => email = value,
          enabled: isEditing,
        ),
        const SizedBox(height: 16),
        
        // Name Fields
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: firstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => firstName = value,
                enabled: isEditing,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: lastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => lastName = value,
                enabled: isEditing,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Phone Field
        TextFormField(
          initialValue: phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          onChanged: (value) => phone = value,
          enabled: isEditing,
        ),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy Controls',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSettingItem(
          'Profile Visibility',
          'Who can see your profile',
          profileVisibility,
          (value) => setState(() => profileVisibility = value),
        ),
        _buildSwitchItem(
          'Show Email Address',
          'Display email on your profile',
          showEmail,
          (value) => setState(() => showEmail = value),
        ),
        _buildSwitchItem(
          'Show Phone Number',
          'Display phone on your profile',
          showPhone,
          (value) => setState(() => showPhone = value),
        ),
        _buildSwitchItem(
          'Allow Messages',
          'Let others send you messages',
          allowMessages,
          (value) => setState(() => allowMessages = value),
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notification Preferences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSwitchItem(
          'Email Notifications',
          'Receive notifications via email',
          emailNotifications,
          (value) => setState(() => emailNotifications = value),
        ),
        _buildSwitchItem(
          'Push Notifications',
          'Receive push notifications',
          pushNotifications,
          (value) => setState(() => pushNotifications = value),
        ),
        _buildSwitchItem(
          'SMS Notifications',
          'Receive notifications via SMS',
          smsNotifications,
          (value) => setState(() => smsNotifications = value),
        ),
        _buildSwitchItem(
          'Marketing Emails',
          'Receive promotional content',
          marketingEmails,
          (value) => setState(() => marketingEmails = value),
        ),
      ],
    );
  }

  Widget _buildSecuritySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security & Authentication',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSwitchItem(
          'Two-Factor Authentication',
          'Add an extra layer of security',
          twoFactorAuth,
          (value) => setState(() => twoFactorAuth = value),
        ),
        _buildSwitchItem(
          'Login Alerts',
          'Get notified of new logins',
          loginAlerts,
          (value) => setState(() => loginAlerts = value),
        ),
        _buildSettingItem(
          'Session Timeout',
          'Auto-logout after inactivity',
          '$sessionTimeout minutes',
          (value) => setState(() => sessionTimeout = int.tryParse(value) ?? 30),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Change password functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Change Password'),
        ),
      ],
    );
  }

  Widget _buildPreferenceSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Preferences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSettingItem(
          'Theme',
          'Choose your preferred theme',
          theme,
          (value) => setState(() => theme = value),
        ),
        _buildSettingItem(
          'Language',
          'Select your language',
          language,
          (value) => setState(() => language = value),
        ),
        _buildSettingItem(
          'Timezone',
          'Set your timezone',
          timezone,
          (value) => setState(() => timezone = value),
        ),
        _buildSettingItem(
          'Date Format',
          'Choose date display format',
          dateFormat,
          (value) => setState(() => dateFormat = value),
        ),
      ],
    );
  }

  Widget _buildAdvancedSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advanced Options',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildSwitchItem(
          'Data Collection',
          'Allow data collection for improvements',
          dataCollection,
          (value) => setState(() => dataCollection = value),
        ),
        _buildSwitchItem(
          'Analytics',
          'Help us improve with usage analytics',
          analytics,
          (value) => setState(() => analytics = value),
        ),
        _buildSwitchItem(
          'Crash Reporting',
          'Send crash reports automatically',
          crashReporting,
          (value) => setState(() => crashReporting = value),
        ),
        _buildSwitchItem(
          'Beta Features',
          'Enable experimental features',
          betaFeatures,
          (value) => setState(() => betaFeatures = value),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, String description, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, String description, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue[700],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  child: Text(isEditing ? 'Cancel' : 'Edit'),
                ),
              ),
              if (isEditing) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Save Changes'),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  // Reset to default functionality
                },
                child: const Text('Reset to Default'),
              ),
              TextButton(
                onPressed: () {
                  // Export settings functionality
                },
                child: const Text('Export Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

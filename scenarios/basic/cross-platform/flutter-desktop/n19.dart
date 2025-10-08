import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserPreferencesPage(),
    );
  }
}

class UserPreferencesPage extends StatefulWidget {
  @override
  _UserPreferencesPageState createState() => _UserPreferencesPageState();
}

class _UserPreferencesPageState extends State<UserPreferencesPage> {
  String? selectedNotification;
  String? selectedLanguage;
  String? selectedTheme;
  String? selectedPrivacy;
  String? selectedCommunication;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('User Preferences'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[700]!, Colors.blue[900]!],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Customize your experience and manage your preferences',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Notification Preferences
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                  Row(
                    children: [
                      Radio<String>(
                        value: 'email',
                        groupValue: selectedNotification,
                        onChanged: (value) {
                          setState(() {
                            selectedNotification = value;
                          });
                        },
                      ),
                      Text('Email notifications'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'push',
                        groupValue: selectedNotification,
                        onChanged: (value) {
                          setState(() {
                            selectedNotification = value;
                          });
                        },
                      ),
                      Text('Push notifications'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'sms',
                        groupValue: selectedNotification,
                        onChanged: (value) {
                          setState(() {
                            selectedNotification = value;
                          });
                        },
                      ),
                      Text('SMS notifications'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'none',
                        groupValue: selectedNotification,
                        onChanged: (value) {
                          setState(() {
                            selectedNotification = value;
                          });
                        },
                      ),
                      Text('No notifications'),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Language Preferences
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                  Row(
                    children: [
                      Radio<String>(
                        value: 'english',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                      ),
                      Text('English'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'spanish',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                      ),
                      Text('Spanish'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'french',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                      ),
                      Text('French'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'german',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                      ),
                      Text('German'),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Theme Preferences
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                  Row(
                    children: [
                      Radio<String>(
                        value: 'light',
                        groupValue: selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            selectedTheme = value;
                          });
                        },
                      ),
                      Text('Light theme'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'dark',
                        groupValue: selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            selectedTheme = value;
                          });
                        },
                      ),
                      Text('Dark theme'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'auto',
                        groupValue: selectedTheme,
                        onChanged: (value) {
                          setState(() {
                            selectedTheme = value;
                          });
                        },
                      ),
                      Text('Auto (system)'),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Privacy Preferences
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                  Row(
                    children: [
                      Radio<String>(
                        value: 'public',
                        groupValue: selectedPrivacy,
                        onChanged: (value) {
                          setState(() {
                            selectedPrivacy = value;
                          });
                        },
                      ),
                      Text('Public profile'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'friends',
                        groupValue: selectedPrivacy,
                        onChanged: (value) {
                          setState(() {
                            selectedPrivacy = value;
                          });
                        },
                      ),
                      Text('Friends only'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'private',
                        groupValue: selectedPrivacy,
                        onChanged: (value) {
                          setState(() {
                            selectedPrivacy = value;
                          });
                        },
                      ),
                      Text('Private profile'),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Communication Preferences
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Communication Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
                  Row(
                    children: [
                      Radio<String>(
                        value: 'email',
                        groupValue: selectedCommunication,
                        onChanged: (value) {
                          setState(() {
                            selectedCommunication = value;
                          });
                        },
                      ),
                      Text('Email communication'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'phone',
                        groupValue: selectedCommunication,
                        onChanged: (value) {
                          setState(() {
                            selectedCommunication = value;
                          });
                        },
                      ),
                      Text('Phone communication'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'text',
                        groupValue: selectedCommunication,
                        onChanged: (value) {
                          setState(() {
                            selectedCommunication = value;
                          });
                        },
                      ),
                      Text('Text message'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Radio<String>(
                        value: 'app',
                        groupValue: selectedCommunication,
                        onChanged: (value) {
                          setState(() {
                            selectedCommunication = value;
                          });
                        },
                      ),
                      Text('In-app messaging'),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            
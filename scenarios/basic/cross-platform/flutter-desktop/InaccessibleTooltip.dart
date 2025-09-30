import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HelpSystemPage(),
    );
  }
}

class HelpSystemPage extends StatefulWidget {
  @override
  _HelpSystemPageState createState() => _HelpSystemPageState();
}

class _HelpSystemPageState extends State<HelpSystemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
                    'Help & Support Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find answers to your questions and get the help you need',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Help Categories
            Text(
              'Help Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
              children: [
                _buildHelpCategory(
                  'Getting Started',
                  'Learn the basics',
                  Icons.play_circle_outline,
                  Colors.blue,
                ),
                _buildHelpCategory(
                  'Account Management',
                  'Manage your account',
                  Icons.person,
                  Colors.green,
                ),
                _buildHelpCategory(
                  'Billing & Payments',
                  'Payment information',
                  Icons.payment,
                  Colors.orange,
                ),
                _buildHelpCategory(
                  'Technical Support',
                  'Technical assistance',
                  Icons.build,
                  Colors.purple,
                ),
                _buildHelpCategory(
                  'API Documentation',
                  'Developer resources',
                  Icons.code,
                  Colors.teal,
                ),
                _buildHelpCategory(
                  'Contact Support',
                  'Get in touch',
                  Icons.support_agent,
                  Colors.red,
                ),
              ],
            ),
            
            SizedBox(height: 40),
            
            // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
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
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  _buildFAQItem(
                    'How do I create a new account?',
                    'To create a new account, click on the "Sign Up" button and fill in the required information.',
                    true,
                  ),
                  
                  _buildFAQItem(
                    'How can I reset my password?',
                    'You can reset your password by clicking on "Forgot Password" on the login page.',
                    true,
                  ),
                  
                  _buildFAQItem(
                    'What payment methods do you accept?',
                    'We accept all major credit cards, PayPal, and bank transfers.',
                    true,
                  ),
                  
                  _buildFAQItem(
                    'How do I contact customer support?',
                    'You can contact us through email, phone, or live chat. Our support team is available 24/7.',
                    true,
                  ),
                  
                  _buildFAQItem(
                    'Can I cancel my subscription anytime?',
                    'Yes, you can cancel your subscription at any time from your account settings.',
                    true,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
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
                    'Form Help',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Form with help icons
                  Column(
                    children: [
                      _buildFormField(
                        'Username',
                        'Enter your username',
                        'This field is required and must be unique',
                        true,
                      ),
                      SizedBox(height: 16),
                      _buildFormField(
                        'Email Address',
                        'Enter your email',
                        'We will use this to send you important updates',
                        true,
                      ),
                      SizedBox(height: 16),
                      _buildFormField(
                        'Password',
                        'Enter your password',
                        'Password must be at least 8 characters long',
                        true,
                      ),
                      SizedBox(height: 16),
                      _buildFormField(
                        'Confirm Password',
                        'Confirm your password',
                        'Must match the password above',
                        true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
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
                    'Feature Help',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureHelp(
                          'Data Export',
                          'Export your data in various formats',
                          true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: _buildFeatureHelp(
                          'Data Import',
                          'Import data from external sources',
                          true,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureHelp(
                          'Report Generation',
                          'Generate detailed reports',
                          true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: _buildFeatureHelp(
                          'Data Backup',
                          'Backup your important data',
                          true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.amber[700],
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Tooltip Accessibility Notice',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'The help icons above show tooltips on hover only, which are not accessible to keyboard users. Tooltips should be accessible via keyboard navigation and screen readers.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.amber[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Contact Support Section
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[700]!, Colors.blue[900]!],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Still Need Help?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Our support team is here to help you with any questions or issues',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildContactOption(
                        'Email Support',
                        'support@company.com',
                        Icons.email,
                      ),
                      _buildContactOption(
                        'Phone Support',
                        '+1 (555) 123-4567',
                        Icons.phone,
                      ),
                      _buildContactOption(
                        'Live Chat',
                        'Available 24/7',
                        Icons.chat,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHelpCategory(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFAQItem(String question, String answer, bool isExpanded) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[600],
            ),
            onTap: () {
              setState(() {
                // Toggle expansion state
              });
            },
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildFormField(String label, String hint, String helpText, bool hasHelp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            if (hasHelp) ...[
              SizedBox(width: 8),
              // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
              Tooltip(
                message: helpText,
                child: Icon(
                  Icons.help_outline,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFeatureHelp(String title, String description, bool hasHelp) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              if (hasHelp) ...[
                // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
                Tooltip(
                  message: description,
                  child: Icon(
                    Icons.help_outline,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactOption(String title, String subtitle, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LowContrastWarningText extends StatefulWidget {
  const LowContrastWarningText({Key? key}) : super(key: key);

  @override
  State<LowContrastWarningText> createState() => _LowContrastWarningTextState();
}

class _LowContrastWarningTextState extends State<LowContrastWarningText> {
  bool isLoggedIn = true;
  int sessionTimeLeft = 5; // minutes
  bool showWarning = false;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
  }

  void _startSessionTimer() {
    // Simulate session countdown
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (sessionTimeLeft > 0) {
            sessionTimeLeft--;
            if (sessionTimeLeft <= 5) {
              showWarning = true;
            }
          } else {
            // Session expired
            _handleSessionExpired();
          }
        });
        _startSessionTimer();
      }
    });
  }

  void _handleSessionExpired() {
    setState(() {
      isLoggedIn = false;
      showWarning = false;
    });
  }

  void _extendSession() {
    setState(() {
      sessionTimeLeft = 30; // Extend to 30 minutes
      showWarning = false;
    });
  }

  void _logout() {
    setState(() {
      isLoggedIn = false;
      showWarning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return _buildLoginScreen();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Secure Dashboard'),
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
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          // Session Warning Banner
          if (showWarning) _buildSessionWarning(),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dashboard Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your session is active and secure',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.blue[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Session expires in: $sessionTimeLeft minutes',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Quick Actions
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildActionCard(
                        'View Reports',
                        Icons.assessment,
                        Colors.blue,
                        () {},
                      ),
                      _buildActionCard(
                        'Manage Users',
                        Icons.people,
                        Colors.green,
                        () {},
                      ),
                      _buildActionCard(
                        'Settings',
                        Icons.settings,
                        Colors.orange,
                        () {},
                      ),
                      _buildActionCard(
                        'Help & Support',
                        Icons.help,
                        Colors.purple,
                        () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Recent Activity
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildActivityList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // LOW CONTRAST WARNING TEXT - Insufficient color contrast
        color: const Color(0xFFF5F5F5), // Very light gray background
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE0E0E0), // Light gray border
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            // LOW CONTRAST - Light gray icon on light background
            color: const Color(0xFF9E9E9E), // Light gray color
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session Timeout Warning',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // LOW CONTRAST - Light gray text on light background
                    color: const Color(0xFF757575), // Medium gray color
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your session will expire in $sessionTimeLeft minutes. Please save your work and extend your session to continue.',
                  style: TextStyle(
                    fontSize: 14,
                    // LOW CONTRAST - Very light gray text on light background
                    color: const Color(0xFFBDBDBD), // Very light gray color
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              TextButton(
                onPressed: _extendSession,
                style: TextButton.styleFrom(
                  // LOW CONTRAST - Light blue text on light background
                  foregroundColor: const Color(0xFF90CAF9), // Light blue
                ),
                child: const Text('Extend'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _logout,
                style: TextButton.styleFrom(
                  // LOW CONTRAST - Light red text on light background
                  foregroundColor: const Color(0xFFEF9A9A), // Light red
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    final activities = [
      {'action': 'User login', 'time': '2 minutes ago', 'type': 'success'},
      {'action': 'Report generated', 'time': '15 minutes ago', 'type': 'info'},
      {'action': 'Settings updated', 'time': '1 hour ago', 'type': 'info'},
      {'action': 'Failed login attempt', 'time': '2 hours ago', 'type': 'warning'},
      {'action': 'Data backup completed', 'time': '3 hours ago', 'type': 'success'},
    ];

    return Column(
      children: activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: activity['type'] == 'success' 
                      ? Colors.green 
                      : activity['type'] == 'warning' 
                          ? Colors.orange 
                          : Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['action'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activity['time'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoginScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              const Text(
                'Session Expired',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your session has expired due to inactivity. Please log in again to continue.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoggedIn = true;
                      sessionTimeLeft = 30;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login Again',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

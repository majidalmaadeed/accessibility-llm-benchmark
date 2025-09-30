import 'package:flutter/material.dart';
class ToastNotificationIssues extends StatefulWidget {
  const ToastNotificationIssues({Key? key}) : super(key: key);
  @override
  State<ToastNotificationIssues> createState() => _ToastNotificationIssuesState();
}
class _ToastNotificationIssuesState extends State<ToastNotificationIssues> {
  final List<ToastNotification> _notifications = [];
  int _notificationCount = 0;
  @override
  void initState() {
    super.initState();
  }
    // Basic setup only
  }
  void _showToast(String type, String message) {
    setState(() {
      _notificationCount++;
      _notifications.insert(0, ToastNotification(
        id: _notificationCount,
        type: type,
        message: message,
        timestamp: DateTime.now(),
      ));
    });
    // Should implement auto-hide functionality with configurable duration
    // Basic auto-hide (5 seconds)
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _dismissToast(_notifications.first.id);
      }
    });
  }
  void _dismissToast(int id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });
  }
  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
      _notificationCount = 0;
    });
  }
  String _getIconForType(String type) {
    switch (type) {
      case 'success':
        return '✓';
      case 'error':
        return '✗';
      case 'warning':
        return '⚠';
      case 'info':
        return 'ℹ';
      default:
        return '•';
    }
  }
  Color _getColorForType(String type) {
    switch (type) {
      case 'success':
        return const Color(0xFF28A745);
      case 'error':
        return const Color(0xFFDC3545);
      case 'warning':
        return const Color(0xFFFFC107);
      case 'info':
        return const Color(0xFF17A2B8);
      default:
        return const Color(0xFF6C757D);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Main Content Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFDEE2E6)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Toast Notifications Demo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Description
                        const Text(
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Notification Controls
                        Column(
                          children: [
                            // Success Notification
                            _buildNotificationButton(
                              'Show Success Notification',
                              const Color(0xFF28A745),
                              () => _showToast('success', 'Operation completed successfully!'),
                            ),
                            const SizedBox(height: 15),
                            // Error Notification
                            _buildNotificationButton(
                              'Show Error Notification',
                              const Color(0xFFDC3545),
                              () => _showToast('error', 'An error occurred while processing your request.'),
                            ),
                            const SizedBox(height: 15),
                            // Warning Notification
                            _buildNotificationButton(
                              'Show Warning Notification',
                              const Color(0xFFFFC107),
                              () => _showToast('warning', 'Please review your input before proceeding.'),
                            ),
                            const SizedBox(height: 15),
                            // Info Notification
                            _buildNotificationButton(
                              'Show Info Notification',
                              const Color(0xFF17A2B8),
                              () => _showToast('info', 'New updates are available for download.'),
                            ),
                            const SizedBox(height: 15),
                            // Clear All Button
                            _buildNotificationButton(
                              'Clear All Notifications',
                              const Color(0xFF6C757D),
                              _clearAllNotifications,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Color(0xFFDEE2E6)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9ECEF),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• Missing dismiss button: No way to close notifications programmatically\n'
                          '• No auto-hide timer: Notifications don\'t disappear automatically\n'
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // How to Fix
                        const Text(
                          'How to Fix:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '• Implement auto-hide timer with configurable duration\n'
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Toast Notifications Container
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              children: _notifications.map((notification) {
                return _buildToastNotification(notification);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNotificationButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: color == const Color(0xFFFFC107) ? const Color(0xFF212529) : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Widget _buildToastNotification(ToastNotification notification) {
    final color = _getColorForType(notification.type);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      constraints: const BoxConstraints(
        minWidth: 300,
        maxWidth: 400,
      ),
      child: Row(
        children: [
          // Icon
          Text(
            _getIconForType(notification.type),
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 15),
          // Message
          Expanded(
            child: Text(
              notification.message,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _dismissToast(notification.id),
            icon: const Icon(
              Icons.close,
              color: Color(0xFF666666),
              size: 18,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
    );
  }
}
class ToastNotification {
  final int id;
  final String type;
  final String message;
  final DateTime timestamp;
  ToastNotification({
    required this.id,
    required this.type,
    required this.message,
    required this.timestamp,
  });
}

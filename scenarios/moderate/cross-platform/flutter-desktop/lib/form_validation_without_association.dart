import 'package:flutter/material.dart';
class FormValidationWithoutAssociation extends StatefulWidget {
  const FormValidationWithoutAssociation({Key? key}) : super(key: key);
  @override
  State<FormValidationWithoutAssociation> createState() => _FormValidationWithoutAssociationState();
}
class _FormValidationWithoutAssociationState extends State<FormValidationWithoutAssociation> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _usernameError = '';
  String _passwordError = '';
  String _genericError = '';
  bool _isSubmitting = false;
  @override
  void initState() {
    super.initState();
  }
    // Basic setup only
  }
  void _clearAllErrors() {
    setState(() {
      _usernameError = '';
      _passwordError = '';
      _genericError = '';
    });
  }
  void _clearFieldError(String fieldName) {
    setState(() {
      if (fieldName == 'username') {
        _usernameError = '';
      } else if (fieldName == 'password') {
        _passwordError = '';
      }
    });
  }
  void _showFieldError(String fieldName, String message) {
    setState(() {
      if (fieldName == 'username') {
        _usernameError = message;
      } else if (fieldName == 'password') {
        _passwordError = message;
      }
    });
  }
  void _showGenericError(String message) {
    setState(() {
      _genericError = message;
    });
  }
  Future<void> _handleLogin() async {
    if (_isSubmitting) return;
    _clearAllErrors();
    String username = _usernameController.text.trim();
    String password = _passwordController.text;
    bool hasErrors = false;
    // Validate username
    if (username.isEmpty) {
      _showFieldError('username', 'Username is required');
      hasErrors = true;
    } else if (username.length < 3) {
      _showFieldError('username', 'Username must be at least 3 characters');
      hasErrors = true;
    }
    // Validate password
    if (password.isEmpty) {
      _showFieldError('password', 'Password is required');
      hasErrors = true;
    } else if (password.length < 8) {
      _showFieldError('password', 'Password must be at least 8 characters');
      hasErrors = true;
    }
    if (hasErrors) {
      // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
      _showGenericError('Please fill in all required fields.');
      return;
    }
    // Simulate login process
    setState(() {
      _isSubmitting = true;
    });
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // Show success
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      _showGenericError('Login failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Login successful!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
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
                      'Login Form',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Description
                    const Text(
                      'Please enter your credentials to access your account.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Login Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                                  ),
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFF007BFF)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDC3545)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                                onChanged: (value) => _clearFieldError('username'),
                              ),
                              if (_usernameError.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    _usernameError,
                                    style: const TextStyle(
                                      color: Color(0xFFDC3545),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                                  ),
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFF007BFF)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(color: Color(0xFFDC3545)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                                onChanged: (value) => _clearFieldError('password'),
                              ),
                              if (_passwordError.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    _passwordError,
                                    style: const TextStyle(
                                      color: Color(0xFFDC3545),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Generic Error Message - NOT ASSOCIATED WITH SPECIFIC FIELDS
                          if (_genericError.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8D7DA),
                                border: Border.all(color: const Color(0xFFF5C6CB)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    '⚠',
                                    style: TextStyle(
                                      color: Color(0xFFDC3545),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _genericError,
                                      style: const TextStyle(
                                        color: Color(0xFFDC3545),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007BFF),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                _isSubmitting ? 'Logging in...' : 'Login',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      '• Generic error: Generic error message doesn\'t specify which fields have issues\n'
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
                      '• Use specific error messages for each field\n'
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
    );
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

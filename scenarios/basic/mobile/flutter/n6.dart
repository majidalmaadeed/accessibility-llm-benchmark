import 'package:flutter/material.dart';

class InaccessibleTooltip extends StatefulWidget {
  const InaccessibleTooltip({Key? key}) : super(key: key);

  @override
  State<InaccessibleTooltip> createState() => _InaccessibleTooltipState();
}

class _InaccessibleTooltipState extends State<InaccessibleTooltip> {
  final Map<String, bool> showTooltips = {};
  final Map<String, String> errors = {};

  // Form data
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String gender = '';
  String country = '';
  bool termsAccepted = false;

  final List<Map<String, dynamic>> countries = [
    {'code': 'US', 'name': 'United States'},
    {'code': 'CA', 'name': 'Canada'},
    {'code': 'GB', 'name': 'United Kingdom'},
    {'code': 'AU', 'name': 'Australia'},
    {'code': 'DE', 'name': 'Germany'},
    {'code': 'FR', 'name': 'France'},
    {'code': 'JP', 'name': 'Japan'},
    {'code': 'BR', 'name': 'Brazil'},
  ];

  final List<Map<String, dynamic>> genders = [
    {'value': 'male', 'label': 'Male'},
    {'value': 'female', 'label': 'Female'},
    {'value': 'other', 'label': 'Other'},
    {'value': 'prefer-not-to-say', 'label': 'Prefer not to say'},
  ];

  void _handleTooltipToggle(String field) {
    setState(() {
      showTooltips[field] = !(showTooltips[field] ?? false);
    });
  }

  void _validateField(String field, String value) {
    String error = '';

    switch (field) {
      case 'firstName':
        if (value.trim().isEmpty) {
          error = 'First name is required';
        } else if (value.trim().length < 2) {
          error = 'First name must be at least 2 characters';
        }
        break;
      case 'lastName':
        if (value.trim().isEmpty) {
          error = 'Last name is required';
        } else if (value.trim().length < 2) {
          error = 'Last name must be at least 2 characters';
        }
        break;
      case 'email':
        if (value.trim().isEmpty) {
          error = 'Email is required';
        } else if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
          error = 'Please enter a valid email address';
        }
        break;
      case 'phone':
        if (value.trim().isEmpty) {
          error = 'Phone number is required';
        } else if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
          error = 'Please enter a valid phone number';
        }
        break;
      case 'password':
        if (value.isEmpty) {
          error = 'Password is required';
        } else if (value.length < 8) {
          error = 'Password must be at least 8 characters';
        } else if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          error = 'Password must contain uppercase, lowercase, and number';
        }
        break;
      case 'confirmPassword':
        if (value.isEmpty) {
          error = 'Please confirm your password';
        } else if (value != passwordController.text) {
          error = 'Passwords do not match';
        }
        break;
      case 'dateOfBirth':
        if (value.trim().isEmpty) {
          error = 'Date of birth is required';
        } else {
          try {
            final birthDate = DateTime.parse(value);
            final today = DateTime.now();
            final age = today.year - birthDate.year;
            if (age < 18) {
              error = 'You must be at least 18 years old';
            }
          } catch (e) {
            error = 'Please enter a valid date';
          }
        }
        break;
      case 'gender':
        if (value.isEmpty) {
          error = 'Please select a gender';
        }
        break;
      case 'country':
        if (value.isEmpty) {
          error = 'Country is required';
        }
        break;
      case 'termsAccepted':
        if (!value.isNotEmpty) {
          error = 'You must accept the terms and conditions';
        }
        break;
    }

    setState(() {
      errors[field] = error;
    });
  }

  void _handleSubmit() {
    // Validate all fields
    _validateField('firstName', firstNameController.text);
    _validateField('lastName', lastNameController.text);
    _validateField('email', emailController.text);
    _validateField('phone', phoneController.text);
    _validateField('password', passwordController.text);
    _validateField('confirmPassword', confirmPasswordController.text);
    _validateField('dateOfBirth', dateOfBirthController.text);
    _validateField('gender', gender);
    _validateField('country', country);
    _validateField('termsAccepted', termsAccepted.toString());

    // Check if there are any errors
    bool hasErrors = errors.values.any((error) => error.isNotEmpty);
    
    if (hasErrors) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors and try again')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Join our community today',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            // Personal Information Section
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // First Name
            _buildInputWithTooltip(
              'firstName',
              'First Name *',
              'Enter your first name',
              'Your legal first name as it appears on official documents. This will be used for account verification.',
              firstNameController,
              TextInputType.text,
            ),
            const SizedBox(height: 16),
            
            // Last Name
            _buildInputWithTooltip(
              'lastName',
              'Last Name *',
              'Enter your last name',
              'Your legal last name as it appears on official documents. This will be used for account verification.',
              lastNameController,
              TextInputType.text,
            ),
            const SizedBox(height: 16),
            
            // Email
            _buildInputWithTooltip(
              'email',
              'Email Address *',
              'Enter your email address',
              'We will use this email to send you important account updates, notifications, and password reset instructions. Make sure it is an email you check regularly.',
              emailController,
              TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            
            // Phone
            _buildInputWithTooltip(
              'phone',
              'Phone Number *',
              'Enter your phone number',
              'Include country code (e.g., +1 for US). This will be used for two-factor authentication and account recovery.',
              phoneController,
              TextInputType.phone,
            ),
            const SizedBox(height: 16),
            
            // Date of Birth
            _buildInputWithTooltip(
              'dateOfBirth',
              'Date of Birth *',
              'MM/DD/YYYY',
              'You must be at least 18 years old to create an account. We use this information to verify your identity and comply with age restrictions.',
              dateOfBirthController,
              TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            
            // Gender
            _buildSelectWithTooltip(
              'gender',
              'Gender *',
              'Select your gender',
              'This information helps us provide personalized content and features. You can change this later in your account settings.',
              gender,
              genders,
              (value) => setState(() => gender = value),
            ),
            const SizedBox(height: 16),
            
            // Country
            _buildSelectWithTooltip(
              'country',
              'Country *',
              'Select your country',
              'We use your country to provide localized content, comply with local regulations, and determine available payment methods.',
              country,
              countries,
              (value) => setState(() => country = value),
            ),
            const SizedBox(height: 24),
            
            // Security Section
            const Text(
              'Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Password
            _buildInputWithTooltip(
              'password',
              'Password *',
              'Create a strong password',
              'Your password must be at least 8 characters long and include a mix of letters, numbers, and special characters. Avoid using common words or personal information.',
              passwordController,
              TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            
            // Confirm Password
            _buildInputWithTooltip(
              'confirmPassword',
              'Confirm Password *',
              'Re-enter your password',
              'Please enter the same password again to confirm. This helps ensure you typed your password correctly.',
              confirmPasswordController,
              TextInputType.visiblePassword,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            
            // Terms & Conditions
            const Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildCheckboxWithTooltip(
              'termsAccepted',
              'I agree to the Terms of Service and Privacy Policy *',
              'By checking this box, you agree to our Terms of Service and Privacy Policy. Please read these documents carefully as they contain important information about your rights and obligations.',
              termsAccepted,
              (value) => setState(() => termsAccepted = value),
            ),
            const SizedBox(height: 24),
            
            // Error Summary
            if (errors.values.any((error) => error.isNotEmpty)) _buildErrorSummary(),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                TextButton(
                  onPressed: () {
                    // Navigate to login
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputWithTooltip(
    String field,
    String label,
    String placeholder,
    String tooltipContent,
    TextEditingController controller,
    TextInputType keyboardType, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            // INACCESSIBLE TOOLTIP - Only works on hover/touch, not keyboard accessible
            GestureDetector(
              onTap: () => _handleTooltipToggle(field),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (showTooltips[field] == true) _buildTooltip(tooltipContent),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            border: const OutlineInputBorder(),
            errorText: errors[field]?.isNotEmpty == true ? errors[field] : null,
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      // Toggle password visibility
                    },
                  )
                : null,
          ),
          keyboardType: keyboardType,
          obscureText: isPassword,
          onChanged: (value) => _validateField(field, value),
        ),
      ],
    );
  }

  Widget _buildSelectWithTooltip(
    String field,
    String label,
    String placeholder,
    String tooltipContent,
    String value,
    List<Map<String, dynamic>> options,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            // INACCESSIBLE TOOLTIP - Only works on hover/touch, not keyboard accessible
            GestureDetector(
              onTap: () => _handleTooltipToggle(field),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (showTooltips[field] == true) _buildTooltip(tooltipContent),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          decoration: InputDecoration(
            hintText: placeholder,
            border: const OutlineInputBorder(),
            errorText: errors[field]?.isNotEmpty == true ? errors[field] : null,
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: Text(option['label']),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              _validateField(field, value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildCheckboxWithTooltip(
    String field,
    String label,
    String tooltipContent,
    bool value,
    Function(bool) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(!value),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      color: value ? Colors.blue[700] : Colors.transparent,
                    ),
                    child: value
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // INACCESSIBLE TOOLTIP - Only works on hover/touch, not keyboard accessible
            GestureDetector(
              onTap: () => _handleTooltipToggle(field),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (showTooltips[field] == true) _buildTooltip(tooltipContent),
          ],
        ),
        if (errors[field]?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errors[field]!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTooltip(String content) {
    return Positioned(
      top: 30,
      right: 0,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please fix the following errors:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          ...errors.entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• ${entry.value}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    companyController.dispose();
    messageController.dispose();
    super.dispose();
  }
}

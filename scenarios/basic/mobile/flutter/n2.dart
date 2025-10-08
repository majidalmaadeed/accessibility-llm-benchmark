import 'package:flutter/material.dart';

class ColorOnlyErrorIndication extends StatefulWidget {
  const ColorOnlyErrorIndication({Key? key}) : super(key: key);

  @override
  State<ColorOnlyErrorIndication> createState() => _ColorOnlyErrorIndicationState();
}

class _ColorOnlyErrorIndicationState extends State<ColorOnlyErrorIndication> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};
  final Map<String, bool> fieldErrors = {};
  final Map<String, String> errorMessages = {};

  final List<Map<String, dynamic>> formFields = [
    {
      'id': 'firstName',
      'label': 'First Name',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your first name',
    },
    {
      'id': 'lastName',
      'label': 'Last Name',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your last name',
    },
    {
      'id': 'email',
      'label': 'Email Address',
      'type': 'email',
      'required': true,
      'placeholder': 'Enter your email address',
    },
    {
      'id': 'phone',
      'label': 'Phone Number',
      'type': 'tel',
      'required': true,
      'placeholder': 'Enter your phone number',
    },
    {
      'id': 'password',
      'label': 'Password',
      'type': 'password',
      'required': true,
      'placeholder': 'Create a password',
    },
    {
      'id': 'confirmPassword',
      'label': 'Confirm Password',
      'type': 'password',
      'required': true,
      'placeholder': 'Confirm your password',
    },
    {
      'id': 'dateOfBirth',
      'label': 'Date of Birth',
      'type': 'date',
      'required': true,
      'placeholder': 'MM/DD/YYYY',
    },
    {
      'id': 'address',
      'label': 'Street Address',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your street address',
    },
    {
      'id': 'city',
      'label': 'City',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your city',
    },
    {
      'id': 'zipCode',
      'label': 'ZIP Code',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your ZIP code',
    },
    {
      'id': 'country',
      'label': 'Country',
      'type': 'text',
      'required': true,
      'placeholder': 'Enter your country',
    },
    {
      'id': 'company',
      'label': 'Company Name',
      'type': 'text',
      'required': false,
      'placeholder': 'Enter your company name (optional)',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    for (var field in formFields) {
      controllers[field['id']] = TextEditingController();
      fieldErrors[field['id']] = false;
      errorMessages[field['id']] = '';
    }
  }

  void _validateField(String fieldId, String value) {
    bool hasError = false;
    String errorMessage = '';

    switch (fieldId) {
      case 'firstName':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'First name is required';
        } else if (value.trim().length < 2) {
          hasError = true;
          errorMessage = 'First name must be at least 2 characters';
        }
        break;
      case 'lastName':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Last name is required';
        } else if (value.trim().length < 2) {
          hasError = true;
          errorMessage = 'Last name must be at least 2 characters';
        }
        break;
      case 'email':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Email address is required';
        } else if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
          hasError = true;
          errorMessage = 'Please enter a valid email address';
        }
        break;
      case 'phone':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Phone number is required';
        } else if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
          hasError = true;
          errorMessage = 'Please enter a valid phone number';
        }
        break;
      case 'password':
        if (value.isEmpty) {
          hasError = true;
          errorMessage = 'Password is required';
        } else if (value.length < 8) {
          hasError = true;
          errorMessage = 'Password must be at least 8 characters';
        } else if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          hasError = true;
          errorMessage = 'Password must contain uppercase, lowercase, and number';
        }
        break;
      case 'confirmPassword':
        if (value.isEmpty) {
          hasError = true;
          errorMessage = 'Please confirm your password';
        } else if (value != controllers['password']?.text) {
          hasError = true;
          errorMessage = 'Passwords do not match';
        }
        break;
      case 'dateOfBirth':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Date of birth is required';
        } else {
          try {
            final birthDate = DateTime.parse(value);
            final today = DateTime.now();
            final age = today.year - birthDate.year;
            if (age < 18) {
              hasError = true;
              errorMessage = 'You must be at least 18 years old';
            }
          } catch (e) {
            hasError = true;
            errorMessage = 'Please enter a valid date';
          }
        }
        break;
      case 'address':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Street address is required';
        }
        break;
      case 'city':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'City is required';
        }
        break;
      case 'zipCode':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'ZIP code is required';
        } else if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(value)) {
          hasError = true;
          errorMessage = 'Please enter a valid ZIP code';
        }
        break;
      case 'country':
        if (value.trim().isEmpty) {
          hasError = true;
          errorMessage = 'Country is required';
        }
        break;
    }

    setState(() {
      fieldErrors[fieldId] = hasError;
      errorMessages[fieldId] = errorMessage;
    });
  }

  void _handleSubmit() {
    // Validate all required fields
    bool hasErrors = false;
    
    for (var field in formFields) {
      if (field['required'] == true) {
        final value = controllers[field['id']]?.text ?? '';
        _validateField(field['id'], value);
        if (fieldErrors[field['id']] == true) {
          hasErrors = true;
        }
      }
    }

    if (hasErrors) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors and try again'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              
              // Form Fields
              ...formFields.map((field) => _buildFormField(field)).toList(),
              
              const SizedBox(height: 32),
              
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
              
              // Terms and Conditions
              Row(
                children: [
                  const Text('By creating an account, you agree to our '),
                  TextButton(
                    onPressed: () {
                      // Show terms
                    },
                    child: const Text('Terms of Service'),
                  ),
                  const Text(' and '),
                  TextButton(
                    onPressed: () {
                      // Show privacy policy
                    },
                    child: const Text('Privacy Policy'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(Map<String, dynamic> field) {
    final fieldId = field['id'];
    final hasError = fieldErrors[fieldId] == true;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field Label
          Text(
            '${field['label']}${field['required'] == true ? ' *' : ''}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          
          // Input Field
          TextFormField(
            controller: controllers[fieldId],
            decoration: InputDecoration(
              hintText: field['placeholder'],
              border: OutlineInputBorder(
                // COLOR-ONLY ERROR INDICATION - Only red border, no text
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey,
                  width: hasError ? 2 : 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey,
                  width: hasError ? 2 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.blue,
                  width: hasError ? 2 : 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),No error text or message for screen readers
              // Only visual indication through color
            ),
            keyboardType: _getKeyboardType(field['type']),
            obscureText: field['type'] == 'password',
            onChanged: (value) => _validateField(fieldId, value),
            onFieldSubmitted: (value) => _validateField(fieldId, value),
          ),
          
          // COLOR-ONLY ERROR INDICATION - No error message text
          // Only shows red border, no accessible error message
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    errorMessages[fieldId] ?? 'Invalid input',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType(String type) {
    switch (type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'tel':
        return TextInputType.phone;
      case 'password':
        return TextInputType.visiblePassword;
      case 'date':
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

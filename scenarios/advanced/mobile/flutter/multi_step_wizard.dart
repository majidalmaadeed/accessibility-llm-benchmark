import 'package:flutter/material.dart';

class MultiStepWizard extends StatefulWidget {
  const MultiStepWizard({Key? key}) : super(key: key);

  @override
  State<MultiStepWizard> createState() => _MultiStepWizardState();
}

class _MultiStepWizardState extends State<MultiStepWizard> {
  int currentStep = 1;
  final int totalSteps = 5;
  bool isSubmitting = false;

  final Map<String, dynamic> formData = {
    'personalInfo': {
      'firstName': '',
      'lastName': '',
      'email': '',
      'phone': '',
      'dateOfBirth': '',
    },
    'addressInfo': {
      'street': '',
      'city': '',
      'state': '',
      'zipCode': '',
      'country': '',
    },
    'preferences': {
      'newsletter': false,
      'notifications': true,
      'theme': 'light',
      'language': 'en',
    },
    'paymentInfo': {
      'cardNumber': '',
      'expiryDate': '',
      'cvv': '',
      'cardholderName': '',
    },
    'review': {
      'termsAccepted': false,
      'privacyAccepted': false,
    },
  };

  final Map<String, String> errors = {};

  final List<Map<String, dynamic>> steps = [
    {'id': 1, 'title': 'Personal Info', 'icon': Icons.person},
    {'id': 2, 'title': 'Address', 'icon': Icons.location_on},
    {'id': 3, 'title': 'Preferences', 'icon': Icons.settings},
    {'id': 4, 'title': 'Payment', 'icon': Icons.credit_card},
    {'id': 5, 'title': 'Review', 'icon': Icons.check_circle},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Registration Wizard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: _buildStepContent(),
          ),
          _buildNavigation(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: steps.map((step) {
          final isActive = currentStep >= step['id'];
          final isCurrent = currentStep == step['id'];
          final isLast = step['id'] == steps.length;

          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.blue : Colors.grey[300],
                        shape: BoxShape.circle,
                        border: isCurrent ? Border.all(color: Colors.blue, width: 2) : null,
                      ),
                      child: Icon(
                        step['icon'],
                        color: isActive ? Colors.white : Colors.grey[600],
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step['title'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.blue : Colors.grey[600],
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: isActive ? Colors.blue : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return _buildPersonalInfo();
      case 2:
        return _buildAddressInfo();
      case 3:
        return _buildPreferences();
      case 4:
        return _buildPaymentInfo();
      case 5:
        return _buildReview();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPersonalInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please provide your basic personal details.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            'First Name',
            'firstName',
            'Enter your first name',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Last Name',
            'lastName',
            'Enter your last name',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Email Address',
            'email',
            'Enter your email',
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Phone Number',
            'phone',
            'Enter your phone number',
            keyboardType: TextInputType.phone,
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Date of Birth',
            'dateOfBirth',
            'MM/DD/YYYY',
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please provide your current address details.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            'Street Address',
            'street',
            'Enter your street address',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'City',
                  'city',
                  'City',
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  'State',
                  'state',
                  'State',
                  isRequired: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'ZIP Code',
                  'zipCode',
                  'ZIP Code',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  'Country',
                  'country',
                  'Country',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Customize your experience with these optional settings.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildSwitchTile(
            'Newsletter Subscription',
            'Receive updates and news via email',
            'newsletter',
          ),
          _buildSwitchTile(
            'Push Notifications',
            'Get notified about important updates',
            'notifications',
          ),
          const SizedBox(height: 24),
          _buildRadioGroup(
            'Theme Preference',
            'theme',
            ['light', 'dark', 'auto'],
          ),
          const SizedBox(height: 24),
          _buildRadioGroup(
            'Language',
            'language',
            [
              {'value': 'en', 'label': 'English'},
              {'value': 'es', 'label': 'Spanish'},
              {'value': 'fr', 'label': 'French'},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your payment details securely.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            'Cardholder Name',
            'cardholderName',
            'Name on card',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Card Number',
            'cardNumber',
            '1234 5678 9012 3456',
            keyboardType: TextInputType.number,
            isRequired: true,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'Expiry Date',
                  'expiryDate',
                  'MM/YY',
                  keyboardType: TextInputType.number,
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  'CVV',
                  'cvv',
                  '123',
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  isRequired: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review & Confirm',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please review your information and accept the terms.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildReviewSection('Personal Information', [
            {'label': 'Name', 'value': '${formData['personalInfo']['firstName']} ${formData['personalInfo']['lastName']}'},
            {'label': 'Email', 'value': formData['personalInfo']['email']},
            {'label': 'Phone', 'value': formData['personalInfo']['phone']},
          ]),
          const SizedBox(height: 16),
          _buildReviewSection('Address', [
            {'label': 'Address', 'value': formData['addressInfo']['street']},
            {'label': 'City, State ZIP', 'value': '${formData['addressInfo']['city']}, ${formData['addressInfo']['state']} ${formData['addressInfo']['zipCode']}'},
          ]),
          const SizedBox(height: 16),
          _buildReviewSection('Preferences', [
            {'label': 'Newsletter', 'value': formData['preferences']['newsletter'] ? 'Yes' : 'No'},
            {'label': 'Notifications', 'value': formData['preferences']['notifications'] ? 'Enabled' : 'Disabled'},
            {'label': 'Theme', 'value': formData['preferences']['theme'].toString().toUpperCase()},
          ]),
          const SizedBox(height: 24),
          _buildCheckboxTile(
            'I accept the Terms and Conditions',
            'termsAccepted',
          ),
          _buildCheckboxTile(
            'I accept the Privacy Policy',
            'privacyAccepted',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String field,
    String hint, {
    TextInputType? keyboardType,
    bool obscureText = false,
    bool isRequired = false,
  }) {
    final section = _getSectionForField(field);
    final value = formData[section][field] as String;
    final hasError = errors.containsKey(field);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label${isRequired ? ' *' : ''}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            errorText: hasError ? errors[field] : null,
          ),
          onChanged: (value) {
            setState(() {
              formData[section][field] = value;
              if (errors.containsKey(field)) {
                errors.remove(field);
              }
            });
          },
          controller: TextEditingController(text: value),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, String field) {
    final section = _getSectionForField(field);
    final value = formData[section][field] as bool;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              setState(() {
                formData[section][field] = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(String title, String field, List<dynamic> options) {
    final section = _getSectionForField(field);
    final currentValue = formData[section][field];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...options.map((option) {
          final value = option is Map ? option['value'] : option;
          final label = option is Map ? option['label'] : option.toString();
          final isSelected = currentValue == value;

          return RadioListTile<String>(
            title: Text(label),
            value: value,
            groupValue: currentValue,
            onChanged: (newValue) {
              setState(() {
                formData[section][field] = newValue;
              });
            },
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCheckboxTile(String title, String field) {
    final section = _getSectionForField(field);
    final value = formData[section][field] as bool;
    final hasError = errors.containsKey(field);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (newValue) {
                setState(() {
                  formData[section][field] = newValue ?? false;
                  if (errors.containsKey(field)) {
                    errors.remove(field);
                  }
                });
              },
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 4),
            child: Text(
              errors[field]!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildReviewSection(String title, List<Map<String, String>> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      '${item['label']}:',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['value']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: currentStep > 1 ? _handlePrevious : null,
            icon: const Icon(Icons.chevron_left),
            label: const Text('Previous'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
          ),
          Text(
            'Step $currentStep of $totalSteps',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          if (currentStep < totalSteps)
            ElevatedButton.icon(
              onPressed: _handleNext,
              icon: const Icon(Icons.chevron_right),
              label: const Text('Next'),
            )
          else
            ElevatedButton.icon(
              onPressed: isSubmitting ? null : _handleSubmit,
              icon: isSubmitting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              label: Text(isSubmitting ? 'Submitting...' : 'Submit'),
            ),
        ],
      ),
    );
  }

  String _getSectionForField(String field) {
    if (['firstName', 'lastName', 'email', 'phone', 'dateOfBirth'].contains(field)) {
      return 'personalInfo';
    } else if (['street', 'city', 'state', 'zipCode', 'country'].contains(field)) {
      return 'addressInfo';
    } else if (['newsletter', 'notifications', 'theme', 'language'].contains(field)) {
      return 'preferences';
    } else if (['cardNumber', 'expiryDate', 'cvv', 'cardholderName'].contains(field)) {
      return 'paymentInfo';
    } else if (['termsAccepted', 'privacyAccepted'].contains(field)) {
      return 'review';
    }
    return 'personalInfo';
  }

  bool _validateStep(int step) {
    errors.clear();

    switch (step) {
      case 1:
        if (formData['personalInfo']['firstName'].toString().trim().isEmpty) {
          errors['firstName'] = 'First name is required';
        }
        if (formData['personalInfo']['lastName'].toString().trim().isEmpty) {
          errors['lastName'] = 'Last name is required';
        }
        if (formData['personalInfo']['email'].toString().trim().isEmpty) {
          errors['email'] = 'Email is required';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(formData['personalInfo']['email'])) {
          errors['email'] = 'Email is invalid';
        }
        if (formData['personalInfo']['phone'].toString().trim().isEmpty) {
          errors['phone'] = 'Phone number is required';
        }
        break;
      case 2:
        if (formData['addressInfo']['street'].toString().trim().isEmpty) {
          errors['street'] = 'Street address is required';
        }
        if (formData['addressInfo']['city'].toString().trim().isEmpty) {
          errors['city'] = 'City is required';
        }
        if (formData['addressInfo']['state'].toString().trim().isEmpty) {
          errors['state'] = 'State is required';
        }
        if (formData['addressInfo']['zipCode'].toString().trim().isEmpty) {
          errors['zipCode'] = 'ZIP code is required';
        }
        break;
      case 3:
        // Preferences are optional
        break;
      case 4:
        if (formData['paymentInfo']['cardNumber'].toString().trim().isEmpty) {
          errors['cardNumber'] = 'Card number is required';
        } else if (formData['paymentInfo']['cardNumber'].toString().replaceAll(' ', '').length < 16) {
          errors['cardNumber'] = 'Card number must be 16 digits';
        }
        if (formData['paymentInfo']['expiryDate'].toString().trim().isEmpty) {
          errors['expiryDate'] = 'Expiry date is required';
        }
        if (formData['paymentInfo']['cvv'].toString().trim().isEmpty) {
          errors['cvv'] = 'CVV is required';
        }
        if (formData['paymentInfo']['cardholderName'].toString().trim().isEmpty) {
          errors['cardholderName'] = 'Cardholder name is required';
        }
        break;
      case 5:
        if (!formData['review']['termsAccepted']) {
          errors['termsAccepted'] = 'You must accept the terms and conditions';
        }
        if (!formData['review']['privacyAccepted']) {
          errors['privacyAccepted'] = 'You must accept the privacy policy';
        }
        break;
    }

    setState(() {});
    return errors.isEmpty;
  }

  void _handleNext() {
    if (_validateStep(currentStep)) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _handlePrevious() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _handleSubmit() async {
    if (_validateStep(currentStep)) {
      setState(() {
        isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isSubmitting = false;
      });

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success!'),
            content: const Text('Your registration has been completed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentStep = 1;
                    // Reset form data
                    formData['personalInfo'] = {
                      'firstName': '',
                      'lastName': '',
                      'email': '',
                      'phone': '',
                      'dateOfBirth': '',
                    };
                    formData['addressInfo'] = {
                      'street': '',
                      'city': '',
                      'state': '',
                      'zipCode': '',
                      'country': '',
                    };
                    formData['preferences'] = {
                      'newsletter': false,
                      'notifications': true,
                      'theme': 'light',
                      'language': 'en',
                    };
                    formData['paymentInfo'] = {
                      'cardNumber': '',
                      'expiryDate': '',
                      'cvv': '',
                      'cardholderName': '',
                    };
                    formData['review'] = {
                      'termsAccepted': false,
                      'privacyAccepted': false,
                    };
                  });
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

import 'package:flutter/material.dart';

class WizardScreen extends StatefulWidget {
  const WizardScreen({super.key});

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  int _currentStep = 1;
  final int _totalSteps = 5;
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Step Wizard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: _currentStep / _totalSteps,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                const SizedBox(height: 10),
                Text(
                  'Step $_currentStep of $_totalSteps: ${_getStepTitle()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Step Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentStep > 1 ? _previousStep : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentStep < _totalSteps ? _nextStep : _finishWizard,
                  child: Text(_currentStep < _totalSteps ? 'Next' : 'Finish'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildPersonalInfoStep();
      case 2:
        return _buildPreferencesStep();
      case 3:
        return _buildAccountStep();
      case 4:
        return _buildAdditionalInfoStep();
      case 5:
        return _buildReviewStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildPreferencesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferences',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text('Theme Preference:', style: TextStyle(fontSize: 16)),
        RadioListTile<String>(
          title: const Text('Light Theme'),
          value: 'light',
          groupValue: 'light',
          onChanged: (value) {},
        ),
        RadioListTile<String>(
          title: const Text('Dark Theme'),
          value: 'dark',
          groupValue: 'light',
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        const Text('Notifications:', style: TextStyle(fontSize: 16)),
        CheckboxListTile(
          title: const Text('Email Notifications'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('SMS Notifications'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('Push Notifications'),
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildAccountStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 15),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        CheckboxListTile(
          title: const Text('I agree to the Terms of Service'),
          value: false,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('I agree to the Privacy Policy'),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Biography',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Industry',
            border: OutlineInputBorder(),
          ),
          items: ['Technology', 'Healthcare', 'Finance', 'Education', 'Retail']
              .map((industry) => DropdownMenuItem(
                    value: industry,
                    child: Text(industry),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Experience',
            border: OutlineInputBorder(),
          ),
          items: ['0-1 years', '1-3 years', '3-5 years', '5-10 years', '10+ years']
              .map((exp) => DropdownMenuItem(
                    value: exp,
                    child: Text(exp),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review and Confirm',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Please review your information before proceeding:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_firstNameController.text} ${_lastNameController.text}'),
                Text('Email: ${_emailController.text}'),
                Text('Phone: ${_phoneController.text}'),
                const Text('Theme: Light'),
                const Text('Notifications: Push only'),
                const Text('Terms: Not accepted'),
                const Text('Privacy: Not accepted'),
                const Text('Industry: Not selected'),
                const Text('Experience: Not selected'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 1:
        return 'Personal Information';
      case 2:
        return 'Preferences';
      case 3:
        return 'Account Settings';
      case 4:
        return 'Additional Information';
      case 5:
        return 'Review and Confirm';
      default:
        return 'Unknown Step';
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _finishWizard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wizard Complete'),
        content: const Text('Thank you for completing the wizard!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

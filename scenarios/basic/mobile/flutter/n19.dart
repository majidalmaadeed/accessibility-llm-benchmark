import 'package:flutter/material.dart';

class UngroupedRadioButtons extends StatefulWidget {
  const UngroupedRadioButtons({Key? key}) : super(key: key);

  @override
  State<UngroupedRadioButtons> createState() => _UngroupedRadioButtonsState();
}

class _UngroupedRadioButtonsState extends State<UngroupedRadioButtons> {
  int currentStep = 1;
  final int totalSteps = 3;

  // Contact Preferences - UNGROUPED RADIO BUTTONS
  bool email = false;
  bool sms = false;
  bool phone = false;
  bool push = false;
  
  // Newsletter Preferences - UNGROUPED RADIO BUTTONS
  bool daily = false;
  bool weekly = false;
  bool monthly = false;
  bool never = false;
  
  // Account Type - UNGROUPED RADIO BUTTONS
  bool personal = false;
  bool business = false;
  bool enterprise = false;
  
  // Other form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void _handleRadioChange(String field, bool value) {
    setState(() {
      switch (field) {
        case 'email':
          email = value;
          break;
        case 'sms':
          sms = value;
          break;
        case 'phone':
          phone = value;
          break;
        case 'push':
          push = value;
          break;
        case 'daily':
          daily = value;
          break;
        case 'weekly':
          weekly = value;
          break;
        case 'monthly':
          monthly = value;
          break;
        case 'never':
          never = value;
          break;
        case 'personal':
          personal = value;
          break;
        case 'business':
          business = value;
          break;
        case 'enterprise':
          enterprise = value;
          break;
      }
    });
  }

  void _handleNext() {
    if (currentStep < totalSteps) {
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

  void _handleSubmit() {
    // Validate required fields
    if (firstNameController.text.isEmpty || 
        lastNameController.text.isEmpty || 
        emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Check if at least one contact preference is selected
    if (!email && !sms && !phone && !push) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one contact preference')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Account Registration'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Step Indicator
          _buildStepIndicator(),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildStepContent(),
            ),
          ),
          
          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final stepNumber = index + 1;
          final isActive = stepNumber <= currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue[700] : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$stepNumber',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (stepNumber < totalSteps)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isActive ? Colors.blue[700] : Colors.grey[300],
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return Container();
    }
  }

  Widget _buildStep1() {
    return Column(
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
        
        // First Name
        TextFormField(
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        
        // Last Name
        TextFormField(
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        
        // Email
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email Address *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        
        // Phone
        TextFormField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 24),
        
        // Contact Preferences
        _buildContactPreferences(),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
        
        // Newsletter Preferences
        _buildNewsletterPreferences(),
        const SizedBox(height: 24),
        
        // Account Type
        _buildAccountType(),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
        
        // Company Name
        TextFormField(
          controller: companyController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.business),
          ),
        ),
        const SizedBox(height: 16),
        
        // Message
        TextFormField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.message),
          ),
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildContactPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'How would you like us to contact you? (Select all that apply)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        
        // UNGROUPED RADIO BUTTONS - No fieldset grouping
        _buildRadioOption('email', 'Email notifications', email),
        _buildRadioOption('sms', 'SMS messages', sms),
        _buildRadioOption('phone', 'Phone calls', phone),
        _buildRadioOption('push', 'Push notifications', push),
      ],
    );
  }

  Widget _buildNewsletterPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Newsletter Frequency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'How often would you like to receive our newsletter?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        
        // UNGROUPED RADIO BUTTONS - No fieldset grouping
        _buildRadioOption('daily', 'Daily', daily),
        _buildRadioOption('weekly', 'Weekly', weekly),
        _buildRadioOption('monthly', 'Monthly', monthly),
        _buildRadioOption('never', 'Never', never),
      ],
    );
  }

  Widget _buildAccountType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Type',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'What type of account are you creating?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        
        // UNGROUPED RADIO BUTTONS - No fieldset grouping
        _buildRadioOption('personal', 'Personal Account', personal),
        _buildRadioOption('business', 'Business Account', business),
        _buildRadioOption('enterprise', 'Enterprise Account', enterprise),
      ],
    );
  }

  Widget _buildRadioOption(String field, String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _handleRadioChange(field, !value),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: BoxShape.circle,
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
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Row(
        children: [
          if (currentStep > 1)
            Expanded(
              child: OutlinedButton(
                onPressed: _handlePrevious,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey[400]!),
                ),
                child: const Text('Previous'),
              ),
            ),
          
          if (currentStep > 1) const SizedBox(width: 16),
          
          Expanded(
            child: ElevatedButton(
              onPressed: currentStep < totalSteps ? _handleNext : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(currentStep < totalSteps ? 'Next' : 'Submit'),
            ),
          ),
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
    companyController.dispose();
    messageController.dispose();
    super.dispose();
  }
}

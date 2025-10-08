import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  TextInput,
  Alert,
} from 'react-native';

const InaccessibleTooltip = () => {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
    dateOfBirth: '',
    gender: '',
    country: '',
    termsAccepted: false
  });

  const [showTooltips, setShowTooltips] = useState({});
  const [errors, setErrors] = useState({});

  const countries = [
    { code: 'US', name: 'United States' },
    { code: 'CA', name: 'Canada' },
    { code: 'GB', name: 'United Kingdom' },
    { code: 'AU', name: 'Australia' },
    { code: 'DE', name: 'Germany' },
    { code: 'FR', name: 'France' },
    { code: 'JP', name: 'Japan' },
    { code: 'BR', name: 'Brazil' }
  ];

  const genders = [
    { value: 'male', label: 'Male' },
    { value: 'female', label: 'Female' },
    { value: 'other', label: 'Other' },
    { value: 'prefer-not-to-say', label: 'Prefer not to say' }
  ];

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: ''
      }));
    }
  };

  const handleTooltipToggle = (field) => {
    setShowTooltips(prev => ({
      ...prev,
      [field]: !prev[field]
    }));
  };

  const validateForm = () => {
    const newErrors = {};

    if (!formData.firstName.trim()) {
      newErrors.firstName = 'First name is required';
    }

    if (!formData.lastName.trim()) {
      newErrors.lastName = 'Last name is required';
    }

    if (!formData.email.trim()) {
      newErrors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      newErrors.email = 'Please enter a valid email address';
    }

    if (!formData.phone.trim()) {
      newErrors.phone = 'Phone number is required';
    } else if (!/^\+?[\d\s\-\(\)]+$/.test(formData.phone)) {
      newErrors.phone = 'Please enter a valid phone number';
    }

    if (!formData.password) {
      newErrors.password = 'Password is required';
    } else if (formData.password.length < 8) {
      newErrors.password = 'Password must be at least 8 characters';
    }

    if (formData.password !== formData.confirmPassword) {
      newErrors.confirmPassword = 'Passwords do not match';
    }

    if (!formData.dateOfBirth) {
      newErrors.dateOfBirth = 'Date of birth is required';
    }

    if (!formData.gender) {
      newErrors.gender = 'Please select a gender';
    }

    if (!formData.country) {
      newErrors.country = 'Please select a country';
    }

    if (!formData.termsAccepted) {
      newErrors.termsAccepted = 'You must accept the terms and conditions';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = () => {
    if (validateForm()) {
      Alert.alert('Success', 'Account created successfully!');
      console.log('Form Data:', formData);
    } else {
      Alert.alert('Validation Error', 'Please fix the errors and try again');
    }
  };

  const renderTooltip = (field, content) => {
    if (!showTooltips[field]) return null;

    return (
      <View style={styles.tooltip}>
        <Text style={styles.tooltipText}>{content}</Text>
        <View style={styles.tooltipArrow} />
      </View>
    );
  };

  const renderInputWithTooltip = (field, label, placeholder, tooltipContent, options = {}) => (
    <View style={styles.inputGroup}>
      <View style={styles.inputLabelContainer}>
        <Text style={styles.inputLabel}>{label}</Text>
        <TouchableOpacity
          style={styles.helpButton}
          onPress={() => handleTooltipToggle(field)}
          // INACCESSIBLE TOOLTIP - Only works on hover/touch, not keyboard accessible
        >
          <Text style={styles.helpIcon}>?</Text>
        </TouchableOpacity>
        {renderTooltip(field, tooltipContent)}
      </View>
      
      {options.type === 'select' ? (
        <TouchableOpacity style={styles.selectButton}>
          <Text style={[styles.selectText, !formData[field] && styles.placeholderText]}>
            {formData[field] || placeholder}
          </Text>
          <Text style={styles.selectArrow}>▼</Text>
        </TouchableOpacity>
      ) : (
        <TextInput
          style={[styles.textInput, errors[field] && styles.errorInput]}
          value={formData[field]}
          onChangeText={(value) => handleInputChange(field, value)}
          placeholder={placeholder}
          secureTextEntry={options.secureTextEntry}
          keyboardType={options.keyboardType}
          autoCapitalize={options.autoCapitalize}
        />
      )}
      
      {errors[field] && (
        <Text style={styles.errorText}>{errors[field]}</Text>
      )}
    </View>
  );

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Create Account</Text>
        <Text style={styles.headerSubtitle}>Join our community today</Text>
      </View>

      {/* Form */}
      <View style={styles.formContainer}>
        <Text style={styles.sectionTitle}>Personal Information</Text>
        
        <View style={styles.inputRow}>
          <View style={styles.inputGroupHalf}>
            {renderInputWithTooltip(
              'firstName',
              'First Name *',
              'Enter your first name',
              'Your legal first name as it appears on official documents. This will be used for account verification.',
              { autoCapitalize: 'words' }
            )}
          </View>
          <View style={styles.inputGroupHalf}>
            {renderInputWithTooltip(
              'lastName',
              'Last Name *',
              'Enter your last name',
              'Your legal last name as it appears on official documents. This will be used for account verification.',
              { autoCapitalize: 'words' }
            )}
          </View>
        </View>

        {renderInputWithTooltip(
          'email',
          'Email Address *',
          'Enter your email address',
          'We will use this email to send you important account updates, notifications, and password reset instructions. Make sure it is an email you check regularly.',
          { keyboardType: 'email-address', autoCapitalize: 'none' }
        )}

        {renderInputWithTooltip(
          'phone',
          'Phone Number *',
          'Enter your phone number',
          'Include country code (e.g., +1 for US). This will be used for two-factor authentication and account recovery.',
          { keyboardType: 'phone-pad' }
        )}

        {renderInputWithTooltip(
          'dateOfBirth',
          'Date of Birth *',
          'MM/DD/YYYY',
          'You must be at least 18 years old to create an account. We use this information to verify your identity and comply with age restrictions.',
          { keyboardType: 'numeric' }
        )}

        {renderInputWithTooltip(
          'gender',
          'Gender *',
          'Select your gender',
          'This information helps us provide personalized content and features. You can change this later in your account settings.',
          { type: 'select' }
        )}

        {renderInputWithTooltip(
          'country',
          'Country *',
          'Select your country',
          'We use your country to provide localized content, comply with local regulations, and determine available payment methods.',
          { type: 'select' }
        )}

        <Text style={styles.sectionTitle}>Security</Text>

        {renderInputWithTooltip(
          'password',
          'Password *',
          'Create a strong password',
          'Your password must be at least 8 characters long and include a mix of letters, numbers, and special characters. Avoid using common words or personal information.',
          { secureTextEntry: true }
        )}

        {renderInputWithTooltip(
          'confirmPassword',
          'Confirm Password *',
          'Re-enter your password',
          'Please enter the same password again to confirm. This helps ensure you typed your password correctly.',
          { secureTextEntry: true }
        )}

        <Text style={styles.sectionTitle}>Terms & Conditions</Text>

        <View style={styles.termsContainer}>
          <TouchableOpacity
            style={styles.checkboxContainer}
            onPress={() => handleInputChange('termsAccepted', !formData.termsAccepted)}
          >
            <View style={[styles.checkbox, formData.termsAccepted && styles.checkedBox]}>
              {formData.termsAccepted && <Text style={styles.checkmark}>✓</Text>}
            </View>
            <View style={styles.termsTextContainer}>
              <Text style={styles.termsText}>
                I agree to the{' '}
                <Text style={styles.termsLink}>Terms of Service</Text>
                {' '}and{' '}
                <Text style={styles.termsLink}>Privacy Policy</Text>
              </Text>
            </View>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.helpButton}
            onPress={() => handleTooltipToggle('termsAccepted')}
            // INACCESSIBLE TOOLTIP - Only works on hover/touch, not keyboard accessible
          >
            <Text style={styles.helpIcon}>?</Text>
          </TouchableOpacity>
          {renderTooltip('termsAccepted', 'By checking this box, you agree to our Terms of Service and Privacy Policy. Please read these documents carefully as they contain important information about your rights and obligations.')}
        </View>

        {errors.termsAccepted && (
          <Text style={styles.errorText}>{errors.termsAccepted}</Text>
        )}

        {/* Additional Help Section */}
        <View style={styles.helpSection}>
          <Text style={styles.helpSectionTitle}>Need Help?</Text>
          <Text style={styles.helpSectionText}>
            If you have any questions about creating your account, please contact our support team.
          </Text>
          <TouchableOpacity style={styles.contactButton}>
            <Text style={styles.contactButtonText}>Contact Support</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Submit Button */}
      <View style={styles.submitContainer}>
        <TouchableOpacity style={styles.submitButton} onPress={handleSubmit}>
          <Text style={styles.submitButtonText}>Create Account</Text>
        </TouchableOpacity>
        
        <View style={styles.loginContainer}>
          <Text style={styles.loginText}>Already have an account? </Text>
          <TouchableOpacity>
            <Text style={styles.loginLink}>Sign In</Text>
          </TouchableOpacity>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    backgroundColor: '#2196F3',
    padding: 24,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#E3F2FD',
  },
  formContainer: {
    padding: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginTop: 24,
    marginBottom: 16,
  },
  inputGroup: {
    marginBottom: 20,
  },
  inputGroupHalf: {
    flex: 1,
    marginRight: 12,
  },
  inputRow: {
    flexDirection: 'row',
  },
  inputLabelContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    position: 'relative',
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: '500',
    color: '#2C3E50',
    flex: 1,
  },
  helpButton: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: '#2196F3',
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 8,
  },
  helpIcon: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: 'bold',
  },
  tooltip: {
    position: 'absolute',
    top: 30,
    right: 0,
    backgroundColor: '#2C3E50',
    padding: 12,
    borderRadius: 8,
    maxWidth: 250,
    zIndex: 1000,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
  tooltipText: {
    color: '#FFFFFF',
    fontSize: 12,
    lineHeight: 16,
  },
  tooltipArrow: {
    position: 'absolute',
    top: -6,
    right: 20,
    width: 0,
    height: 0,
    borderLeftWidth: 6,
    borderRightWidth: 6,
    borderBottomWidth: 6,
    borderLeftColor: 'transparent',
    borderRightColor: 'transparent',
    borderBottomColor: '#2C3E50',
  },
  textInput: {
    borderWidth: 1,
    borderColor: '#BDBDBD',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    fontSize: 16,
    backgroundColor: '#FFFFFF',
  },
  errorInput: {
    borderColor: '#F44336',
  },
  selectButton: {
    borderWidth: 1,
    borderColor: '#BDBDBD',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: '#FFFFFF',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  selectText: {
    fontSize: 16,
    color: '#2C3E50',
  },
  placeholderText: {
    color: '#9E9E9E',
  },
  selectArrow: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  errorText: {
    color: '#F44336',
    fontSize: 14,
    marginTop: 4,
  },
  termsContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 8,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    flex: 1,
  },
  checkbox: {
    width: 20,
    height: 20,
    borderWidth: 2,
    borderColor: '#BDBDBD',
    borderRadius: 4,
    marginRight: 12,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 2,
  },
  checkedBox: {
    backgroundColor: '#2196F3',
    borderColor: '#2196F3',
  },
  checkmark: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  termsTextContainer: {
    flex: 1,
  },
  termsText: {
    fontSize: 14,
    color: '#2C3E50',
    lineHeight: 20,
  },
  termsLink: {
    color: '#2196F3',
    textDecorationLine: 'underline',
  },
  helpSection: {
    backgroundColor: '#E3F2FD',
    padding: 16,
    borderRadius: 8,
    marginTop: 24,
  },
  helpSectionTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 8,
  },
  helpSectionText: {
    fontSize: 14,
    color: '#1976D2',
    lineHeight: 20,
    marginBottom: 12,
  },
  contactButton: {
    backgroundColor: '#1976D2',
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 6,
    alignSelf: 'flex-start',
  },
  contactButtonText: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: '500',
  },
  submitContainer: {
    padding: 24,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
  },
  submitButton: {
    backgroundColor: '#4CAF50',
    paddingVertical: 16,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 16,
  },
  submitButtonText: {
    color: '#FFFFFF',
    fontSize: 18,
    fontWeight: 'bold',
  },
  loginContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  loginText: {
    fontSize: 14,
    color: '#7F8C8D',
  },
  loginLink: {
    fontSize: 14,
    color: '#2196F3',
    fontWeight: '500',
  },
});

export default InaccessibleTooltip;

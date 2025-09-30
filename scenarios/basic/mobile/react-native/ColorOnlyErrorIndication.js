import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  TextInput,
  Alert,
} from 'react-native';

const ColorOnlyErrorIndication = () => {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
    address: '',
    city: '',
    state: '',
    zipCode: '',
    country: '',
    dateOfBirth: '',
    gender: '',
    termsAccepted: false
  });

  const [errors, setErrors] = useState({});
  const [touched, setTouched] = useState({});

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

  const states = [
    { code: 'CA', name: 'California' },
    { code: 'NY', name: 'New York' },
    { code: 'TX', name: 'Texas' },
    { code: 'FL', name: 'Florida' },
    { code: 'IL', name: 'Illinois' },
    { code: 'PA', name: 'Pennsylvania' },
    { code: 'OH', name: 'Ohio' },
    { code: 'GA', name: 'Georgia' }
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

  const handleInputBlur = (field) => {
    setTouched(prev => ({
      ...prev,
      [field]: true
    }));
    validateField(field, formData[field]);
  };

  const validateField = (field, value) => {
    let error = '';

    switch (field) {
      case 'firstName':
        if (!value.trim()) {
          error = 'First name is required';
        } else if (value.trim().length < 2) {
          error = 'First name must be at least 2 characters';
        }
        break;
      case 'lastName':
        if (!value.trim()) {
          error = 'Last name is required';
        } else if (value.trim().length < 2) {
          error = 'Last name must be at least 2 characters';
        }
        break;
      case 'email':
        if (!value.trim()) {
          error = 'Email is required';
        } else if (!/\S+@\S+\.\S+/.test(value)) {
          error = 'Please enter a valid email address';
        }
        break;
      case 'phone':
        if (!value.trim()) {
          error = 'Phone number is required';
        } else if (!/^\+?[\d\s\-\(\)]+$/.test(value)) {
          error = 'Please enter a valid phone number';
        }
        break;
      case 'password':
        if (!value) {
          error = 'Password is required';
        } else if (value.length < 8) {
          error = 'Password must be at least 8 characters';
        } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(value)) {
          error = 'Password must contain uppercase, lowercase, and number';
        }
        break;
      case 'confirmPassword':
        if (!value) {
          error = 'Please confirm your password';
        } else if (value !== formData.password) {
          error = 'Passwords do not match';
        }
        break;
      case 'address':
        if (!value.trim()) {
          error = 'Address is required';
        }
        break;
      case 'city':
        if (!value.trim()) {
          error = 'City is required';
        }
        break;
      case 'state':
        if (!value) {
          error = 'State is required';
        }
        break;
      case 'zipCode':
        if (!value.trim()) {
          error = 'ZIP code is required';
        } else if (!/^\d{5}(-\d{4})?$/.test(value)) {
          error = 'Please enter a valid ZIP code';
        }
        break;
      case 'country':
        if (!value) {
          error = 'Country is required';
        }
        break;
      case 'dateOfBirth':
        if (!value.trim()) {
          error = 'Date of birth is required';
        } else {
          const birthDate = new Date(value);
          const today = new Date();
          const age = today.getFullYear() - birthDate.getFullYear();
          if (age < 18) {
            error = 'You must be at least 18 years old';
          }
        }
        break;
      case 'gender':
        if (!value) {
          error = 'Please select a gender';
        }
        break;
      case 'termsAccepted':
        if (!value) {
          error = 'You must accept the terms and conditions';
        }
        break;
    }

    setErrors(prev => ({
      ...prev,
      [field]: error
    }));
  };

  const validateForm = () => {
    const fieldsToValidate = [
      'firstName', 'lastName', 'email', 'phone', 'password', 'confirmPassword',
      'address', 'city', 'state', 'zipCode', 'country', 'dateOfBirth', 'gender', 'termsAccepted'
    ];

    fieldsToValidate.forEach(field => {
      validateField(field, formData[field]);
    });

    const hasErrors = fieldsToValidate.some(field => {
      validateField(field, formData[field]);
      return errors[field] || validateField(field, formData[field]);
    });

    return !hasErrors;
  };

  const handleSubmit = () => {
    if (validateForm()) {
      Alert.alert('Success', 'Account created successfully!');
      console.log('Form Data:', formData);
    } else {
      Alert.alert('Validation Error', 'Please fix the errors and try again');
    }
  };

  const renderInput = (field, label, placeholder, options = {}) => {
    const hasError = errors[field] && touched[field];
    
    return (
      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>{label}</Text>
        <TextInput
          style={[
            styles.textInput,
            hasError && styles.errorInput // COLOR-ONLY ERROR INDICATION
          ]}
          value={formData[field]}
          onChangeText={(value) => handleInputChange(field, value)}
          onBlur={() => handleInputBlur(field)}
          placeholder={placeholder}
          secureTextEntry={options.secureTextEntry}
          keyboardType={options.keyboardType}
          autoCapitalize={options.autoCapitalize}
        />
        {/* MISSING: Text-based error message for screen readers */}
        {/* Only visual color indication (red border) is provided */}
      </View>
    );
  };

  const renderSelect = (field, label, placeholder, options) => {
    const hasError = errors[field] && touched[field];
    
    return (
      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>{label}</Text>
        <TouchableOpacity 
          style={[
            styles.selectButton,
            hasError && styles.errorInput // COLOR-ONLY ERROR INDICATION
          ]}
          onPress={() => {
            // In a real app, this would open a picker
            Alert.alert('Select', `Choose ${label.toLowerCase()}`);
          }}
        >
          <Text style={[
            styles.selectText,
            !formData[field] && styles.placeholderText
          ]}>
            {formData[field] || placeholder}
          </Text>
          <Text style={styles.selectArrow}>▼</Text>
        </TouchableOpacity>
        {/* MISSING: Text-based error message for screen readers */}
        {/* Only visual color indication (red border) is provided */}
      </View>
    );
  };

  const renderCheckbox = (field, label, description) => {
    const hasError = errors[field] && touched[field];
    
    return (
      <View style={styles.checkboxGroup}>
        <TouchableOpacity
          style={styles.checkboxContainer}
          onPress={() => {
            handleInputChange(field, !formData[field]);
            handleInputBlur(field);
          }}
        >
          <View style={[
            styles.checkbox,
            formData[field] && styles.checkedBox,
            hasError && styles.errorInput // COLOR-ONLY ERROR INDICATION
          ]}>
            {formData[field] && <Text style={styles.checkmark}>✓</Text>}
          </View>
          <View style={styles.checkboxTextContainer}>
            <Text style={styles.checkboxLabel}>{label}</Text>
            {description && (
              <Text style={styles.checkboxDescription}>{description}</Text>
            )}
          </View>
        </TouchableOpacity>
        {/* MISSING: Text-based error message for screen readers */}
        {/* Only visual color indication (red border) is provided */}
      </View>
    );
  };

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
            {renderInput('firstName', 'First Name *', 'Enter your first name', {
              autoCapitalize: 'words'
            })}
          </View>
          <View style={styles.inputGroupHalf}>
            {renderInput('lastName', 'Last Name *', 'Enter your last name', {
              autoCapitalize: 'words'
            })}
          </View>
        </View>

        {renderInput('email', 'Email Address *', 'Enter your email address', {
          keyboardType: 'email-address',
          autoCapitalize: 'none'
        })}

        {renderInput('phone', 'Phone Number *', 'Enter your phone number', {
          keyboardType: 'phone-pad'
        })}

        {renderInput('dateOfBirth', 'Date of Birth *', 'MM/DD/YYYY', {
          keyboardType: 'numeric'
        })}

        {renderSelect('gender', 'Gender *', 'Select your gender', genders)}

        <Text style={styles.sectionTitle}>Address Information</Text>

        {renderInput('address', 'Street Address *', 'Enter your street address')}

        <View style={styles.inputRow}>
          <View style={styles.inputGroupHalf}>
            {renderInput('city', 'City *', 'Enter your city')}
          </View>
          <View style={styles.inputGroupHalf}>
            {renderSelect('state', 'State *', 'Select state', states)}
          </View>
        </View>

        <View style={styles.inputRow}>
          <View style={styles.inputGroupHalf}>
            {renderInput('zipCode', 'ZIP Code *', 'Enter ZIP code', {
              keyboardType: 'numeric'
            })}
          </View>
          <View style={styles.inputGroupHalf}>
            {renderSelect('country', 'Country *', 'Select country', countries)}
          </View>
        </View>

        <Text style={styles.sectionTitle}>Security</Text>

        {renderInput('password', 'Password *', 'Create a strong password', {
          secureTextEntry: true
        })}

        {renderInput('confirmPassword', 'Confirm Password *', 'Re-enter your password', {
          secureTextEntry: true
        })}

        <Text style={styles.sectionTitle}>Terms & Conditions</Text>

        {renderCheckbox(
          'termsAccepted',
          'I agree to the Terms of Service and Privacy Policy *',
          'By checking this box, you agree to our terms and conditions'
        )}

        {/* Error Summary - Only shows if there are errors */}
        {Object.keys(errors).some(key => errors[key] && touched[key]) && (
          <View style={styles.errorSummary}>
            <Text style={styles.errorSummaryTitle}>Please fix the following errors:</Text>
            {Object.keys(errors).map(key => {
              if (errors[key] && touched[key]) {
                return (
                  <Text key={key} style={styles.errorSummaryItem}>
                    • {errors[key]}
                  </Text>
                );
              }
              return null;
            })}
          </View>
        )}
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
  inputLabel: {
    fontSize: 16,
    fontWeight: '500',
    color: '#2C3E50',
    marginBottom: 8,
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
    borderColor: '#F44336', // COLOR-ONLY ERROR INDICATION
    borderWidth: 2,
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
  checkboxGroup: {
    marginBottom: 20,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
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
  checkboxTextContainer: {
    flex: 1,
  },
  checkboxLabel: {
    fontSize: 16,
    color: '#2C3E50',
    lineHeight: 22,
  },
  checkboxDescription: {
    fontSize: 14,
    color: '#7F8C8D',
    marginTop: 4,
    lineHeight: 18,
  },
  errorSummary: {
    backgroundColor: '#FFEBEE',
    padding: 16,
    borderRadius: 8,
    marginTop: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#F44336',
  },
  errorSummaryTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#C62828',
    marginBottom: 8,
  },
  errorSummaryItem: {
    fontSize: 14,
    color: '#C62828',
    marginBottom: 4,
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

export default ColorOnlyErrorIndication;

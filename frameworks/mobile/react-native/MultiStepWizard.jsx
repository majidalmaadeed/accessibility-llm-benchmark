import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Alert,
  Switch,
  Modal,
  Dimensions,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const MultiStepWizard = () => {
  const [currentStep, setCurrentStep] = useState(1);
  const [formData, setFormData] = useState({
    personalInfo: {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      dateOfBirth: '',
    },
    addressInfo: {
      street: '',
      city: '',
      state: '',
      zipCode: '',
      country: '',
    },
    preferences: {
      newsletter: false,
      notifications: true,
      theme: 'light',
      language: 'en',
    },
    paymentInfo: {
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      cardholderName: '',
    },
    review: {
      termsAccepted: false,
      privacyAccepted: false,
    },
  });
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  const totalSteps = 5;
  const steps = [
    { id: 1, title: 'Personal Info', icon: 'person' },
    { id: 2, title: 'Address', icon: 'location' },
    { id: 3, title: 'Preferences', icon: 'settings' },
    { id: 4, title: 'Payment', icon: 'card' },
    { id: 5, title: 'Review', icon: 'checkmark-circle' },
  ];

  const validateStep = (step) => {
    const newErrors = {};
    
    switch (step) {
      case 1:
        if (!formData.personalInfo.firstName.trim()) {
          newErrors.firstName = 'First name is required';
        }
        if (!formData.personalInfo.lastName.trim()) {
          newErrors.lastName = 'Last name is required';
        }
        if (!formData.personalInfo.email.trim()) {
          newErrors.email = 'Email is required';
        } else if (!/\S+@\S+\.\S+/.test(formData.personalInfo.email)) {
          newErrors.email = 'Email is invalid';
        }
        if (!formData.personalInfo.phone.trim()) {
          newErrors.phone = 'Phone number is required';
        }
        break;
      case 2:
        if (!formData.addressInfo.street.trim()) {
          newErrors.street = 'Street address is required';
        }
        if (!formData.addressInfo.city.trim()) {
          newErrors.city = 'City is required';
        }
        if (!formData.addressInfo.state.trim()) {
          newErrors.state = 'State is required';
        }
        if (!formData.addressInfo.zipCode.trim()) {
          newErrors.zipCode = 'ZIP code is required';
        }
        break;
      case 3:
        // Preferences are optional, no validation needed
        break;
      case 4:
        if (!formData.paymentInfo.cardNumber.trim()) {
          newErrors.cardNumber = 'Card number is required';
        } else if (formData.paymentInfo.cardNumber.replace(/\s/g, '').length < 16) {
          newErrors.cardNumber = 'Card number must be 16 digits';
        }
        if (!formData.paymentInfo.expiryDate.trim()) {
          newErrors.expiryDate = 'Expiry date is required';
        }
        if (!formData.paymentInfo.cvv.trim()) {
          newErrors.cvv = 'CVV is required';
        }
        if (!formData.paymentInfo.cardholderName.trim()) {
          newErrors.cardholderName = 'Cardholder name is required';
        }
        break;
      case 5:
        if (!formData.review.termsAccepted) {
          newErrors.termsAccepted = 'You must accept the terms and conditions';
        }
        if (!formData.review.privacyAccepted) {
          newErrors.privacyAccepted = 'You must accept the privacy policy';
        }
        break;
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleNext = () => {
    if (validateStep(currentStep)) {
      if (currentStep < totalSteps) {
        setCurrentStep(currentStep + 1);
      }
    }
  };

  const handlePrevious = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1);
    }
  };

  const handleSubmit = async () => {
    if (validateStep(currentStep)) {
      setIsSubmitting(true);
      
      // Simulate API call
      setTimeout(() => {
        setIsSubmitting(false);
        Alert.alert(
          'Success!',
          'Your registration has been completed successfully.',
          [{ text: 'OK', onPress: () => setCurrentStep(1) }]
        );
      }, 2000);
    }
  };

  const updateFormData = (section, field, value) => {
    setFormData(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value,
      },
    }));
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: undefined,
      }));
    }
  };

  const renderStepIndicator = () => (
    <View style={styles.stepIndicator}>
      {steps.map((step, index) => (
        <View key={step.id} style={styles.stepContainer}>
          <View style={[
            styles.stepCircle,
            currentStep >= step.id && styles.stepCircleActive,
            currentStep === step.id && styles.stepCircleCurrent,
          ]}>
            <Ionicons
              name={step.icon}
              size={20}
              color={currentStep >= step.id ? '#fff' : '#666'}
            />
          </View>
          <Text style={[
            styles.stepTitle,
            currentStep >= step.id && styles.stepTitleActive,
          ]}>
            {step.title}
          </Text>
          {index < steps.length - 1 && (
            <View style={[
              styles.stepConnector,
              currentStep > step.id && styles.stepConnectorActive,
            ]} />
          )}
        </View>
      ))}
    </View>
  );

  const renderPersonalInfo = () => (
    <ScrollView style={styles.stepContent}>
      <Text style={styles.stepHeader}>Personal Information</Text>
      <Text style={styles.stepDescription}>
        Please provide your basic personal details.
      </Text>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>First Name *</Text>
        <TextInput
          style={[styles.input, errors.firstName && styles.inputError]}
          value={formData.personalInfo.firstName}
          onChangeText={(value) => updateFormData('personalInfo', 'firstName', value)}
          placeholder="Enter your first name"
          placeholderTextColor="#999"
        />
        {errors.firstName && <Text style={styles.errorText}>{errors.firstName}</Text>}
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Last Name *</Text>
        <TextInput
          style={[styles.input, errors.lastName && styles.inputError]}
          value={formData.personalInfo.lastName}
          onChangeText={(value) => updateFormData('personalInfo', 'lastName', value)}
          placeholder="Enter your last name"
          placeholderTextColor="#999"
        />
        {errors.lastName && <Text style={styles.errorText}>{errors.lastName}</Text>}
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Email Address *</Text>
        <TextInput
          style={[styles.input, errors.email && styles.inputError]}
          value={formData.personalInfo.email}
          onChangeText={(value) => updateFormData('personalInfo', 'email', value)}
          placeholder="Enter your email"
          placeholderTextColor="#999"
          keyboardType="email-address"
          autoCapitalize="none"
        />
        {errors.email && <Text style={styles.errorText}>{errors.email}</Text>}
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Phone Number *</Text>
        <TextInput
          style={[styles.input, errors.phone && styles.inputError]}
          value={formData.personalInfo.phone}
          onChangeText={(value) => updateFormData('personalInfo', 'phone', value)}
          placeholder="Enter your phone number"
          placeholderTextColor="#999"
          keyboardType="phone-pad"
        />
        {errors.phone && <Text style={styles.errorText}>{errors.phone}</Text>}
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Date of Birth</Text>
        <TextInput
          style={styles.input}
          value={formData.personalInfo.dateOfBirth}
          onChangeText={(value) => updateFormData('personalInfo', 'dateOfBirth', value)}
          placeholder="MM/DD/YYYY"
          placeholderTextColor="#999"
        />
      </View>
    </ScrollView>
  );

  const renderAddressInfo = () => (
    <ScrollView style={styles.stepContent}>
      <Text style={styles.stepHeader}>Address Information</Text>
      <Text style={styles.stepDescription}>
        Please provide your current address details.
      </Text>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Street Address *</Text>
        <TextInput
          style={[styles.input, errors.street && styles.inputError]}
          value={formData.addressInfo.street}
          onChangeText={(value) => updateFormData('addressInfo', 'street', value)}
          placeholder="Enter your street address"
          placeholderTextColor="#999"
        />
        {errors.street && <Text style={styles.errorText}>{errors.street}</Text>}
      </View>

      <View style={styles.inputRow}>
        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>City *</Text>
          <TextInput
            style={[styles.input, errors.city && styles.inputError]}
            value={formData.addressInfo.city}
            onChangeText={(value) => updateFormData('addressInfo', 'city', value)}
            placeholder="City"
            placeholderTextColor="#999"
          />
          {errors.city && <Text style={styles.errorText}>{errors.city}</Text>}
        </View>

        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>State *</Text>
          <TextInput
            style={[styles.input, errors.state && styles.inputError]}
            value={formData.addressInfo.state}
            onChangeText={(value) => updateFormData('addressInfo', 'state', value)}
            placeholder="State"
            placeholderTextColor="#999"
          />
          {errors.state && <Text style={styles.errorText}>{errors.state}</Text>}
        </View>
      </View>

      <View style={styles.inputRow}>
        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>ZIP Code *</Text>
          <TextInput
            style={[styles.input, errors.zipCode && styles.inputError]}
            value={formData.addressInfo.zipCode}
            onChangeText={(value) => updateFormData('addressInfo', 'zipCode', value)}
            placeholder="ZIP Code"
            placeholderTextColor="#999"
            keyboardType="numeric"
          />
          {errors.zipCode && <Text style={styles.errorText}>{errors.zipCode}</Text>}
        </View>

        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>Country</Text>
          <TextInput
            style={styles.input}
            value={formData.addressInfo.country}
            onChangeText={(value) => updateFormData('addressInfo', 'country', value)}
            placeholder="Country"
            placeholderTextColor="#999"
          />
        </View>
      </View>
    </ScrollView>
  );

  const renderPreferences = () => (
    <ScrollView style={styles.stepContent}>
      <Text style={styles.stepHeader}>Preferences</Text>
      <Text style={styles.stepDescription}>
        Customize your experience with these optional settings.
      </Text>

      <View style={styles.preferenceItem}>
        <View style={styles.preferenceContent}>
          <Text style={styles.preferenceTitle}>Newsletter Subscription</Text>
          <Text style={styles.preferenceDescription}>
            Receive updates and news via email
          </Text>
        </View>
        <Switch
          value={formData.preferences.newsletter}
          onValueChange={(value) => updateFormData('preferences', 'newsletter', value)}
          trackColor={{ false: '#e0e0e0', true: '#007AFF' }}
          thumbColor={formData.preferences.newsletter ? '#fff' : '#f4f3f4'}
        />
      </View>

      <View style={styles.preferenceItem}>
        <View style={styles.preferenceContent}>
          <Text style={styles.preferenceTitle}>Push Notifications</Text>
          <Text style={styles.preferenceDescription}>
            Get notified about important updates
          </Text>
        </View>
        <Switch
          value={formData.preferences.notifications}
          onValueChange={(value) => updateFormData('preferences', 'notifications', value)}
          trackColor={{ false: '#e0e0e0', true: '#007AFF' }}
          thumbColor={formData.preferences.notifications ? '#fff' : '#f4f3f4'}
        />
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Theme Preference</Text>
        <View style={styles.radioGroup}>
          {['light', 'dark', 'auto'].map((theme) => (
            <TouchableOpacity
              key={theme}
              style={[
                styles.radioOption,
                formData.preferences.theme === theme && styles.radioOptionSelected,
              ]}
              onPress={() => updateFormData('preferences', 'theme', theme)}
            >
              <View style={styles.radioCircle}>
                {formData.preferences.theme === theme && (
                  <View style={styles.radioCircleInner} />
                )}
              </View>
              <Text style={[
                styles.radioText,
                formData.preferences.theme === theme && styles.radioTextSelected,
              ]}>
                {theme.charAt(0).toUpperCase() + theme.slice(1)}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Language</Text>
        <View style={styles.radioGroup}>
          {[
            { value: 'en', label: 'English' },
            { value: 'es', label: 'Spanish' },
            { value: 'fr', label: 'French' },
          ].map((lang) => (
            <TouchableOpacity
              key={lang.value}
              style={[
                styles.radioOption,
                formData.preferences.language === lang.value && styles.radioOptionSelected,
              ]}
              onPress={() => updateFormData('preferences', 'language', lang.value)}
            >
              <View style={styles.radioCircle}>
                {formData.preferences.language === lang.value && (
                  <View style={styles.radioCircleInner} />
                )}
              </View>
              <Text style={[
                styles.radioText,
                formData.preferences.language === lang.value && styles.radioTextSelected,
              ]}>
                {lang.label}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </ScrollView>
  );

  const renderPaymentInfo = () => (
    <ScrollView style={styles.stepContent}>
      <Text style={styles.stepHeader}>Payment Information</Text>
      <Text style={styles.stepDescription}>
        Enter your payment details securely.
      </Text>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Cardholder Name *</Text>
        <TextInput
          style={[styles.input, errors.cardholderName && styles.inputError]}
          value={formData.paymentInfo.cardholderName}
          onChangeText={(value) => updateFormData('paymentInfo', 'cardholderName', value)}
          placeholder="Name on card"
          placeholderTextColor="#999"
        />
        {errors.cardholderName && <Text style={styles.errorText}>{errors.cardholderName}</Text>}
      </View>

      <View style={styles.inputGroup}>
        <Text style={styles.inputLabel}>Card Number *</Text>
        <TextInput
          style={[styles.input, errors.cardNumber && styles.inputError]}
          value={formData.paymentInfo.cardNumber}
          onChangeText={(value) => updateFormData('paymentInfo', 'cardNumber', value)}
          placeholder="1234 5678 9012 3456"
          placeholderTextColor="#999"
          keyboardType="numeric"
        />
        {errors.cardNumber && <Text style={styles.errorText}>{errors.cardNumber}</Text>}
      </View>

      <View style={styles.inputRow}>
        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>Expiry Date *</Text>
          <TextInput
            style={[styles.input, errors.expiryDate && styles.inputError]}
            value={formData.paymentInfo.expiryDate}
            onChangeText={(value) => updateFormData('paymentInfo', 'expiryDate', value)}
            placeholder="MM/YY"
            placeholderTextColor="#999"
            keyboardType="numeric"
          />
          {errors.expiryDate && <Text style={styles.errorText}>{errors.expiryDate}</Text>}
        </View>

        <View style={[styles.inputGroup, styles.inputGroupHalf]}>
          <Text style={styles.inputLabel}>CVV *</Text>
          <TextInput
            style={[styles.input, errors.cvv && styles.inputError]}
            value={formData.paymentInfo.cvv}
            onChangeText={(value) => updateFormData('paymentInfo', 'cvv', value)}
            placeholder="123"
            placeholderTextColor="#999"
            keyboardType="numeric"
            secureTextEntry
          />
          {errors.cvv && <Text style={styles.errorText}>{errors.cvv}</Text>}
        </View>
      </View>
    </ScrollView>
  );

  const renderReview = () => (
    <ScrollView style={styles.stepContent}>
      <Text style={styles.stepHeader}>Review & Confirm</Text>
      <Text style={styles.stepDescription}>
        Please review your information and accept the terms.
      </Text>

      <View style={styles.reviewSection}>
        <Text style={styles.reviewSectionTitle}>Personal Information</Text>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Name:</Text>
          <Text style={styles.reviewValue}>
            {formData.personalInfo.firstName} {formData.personalInfo.lastName}
          </Text>
        </View>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Email:</Text>
          <Text style={styles.reviewValue}>{formData.personalInfo.email}</Text>
        </View>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Phone:</Text>
          <Text style={styles.reviewValue}>{formData.personalInfo.phone}</Text>
        </View>
      </View>

      <View style={styles.reviewSection}>
        <Text style={styles.reviewSectionTitle}>Address</Text>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Address:</Text>
          <Text style={styles.reviewValue}>{formData.addressInfo.street}</Text>
        </View>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>City, State ZIP:</Text>
          <Text style={styles.reviewValue}>
            {formData.addressInfo.city}, {formData.addressInfo.state} {formData.addressInfo.zipCode}
          </Text>
        </View>
      </View>

      <View style={styles.reviewSection}>
        <Text style={styles.reviewSectionTitle}>Preferences</Text>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Newsletter:</Text>
          <Text style={styles.reviewValue}>
            {formData.preferences.newsletter ? 'Yes' : 'No'}
          </Text>
        </View>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Notifications:</Text>
          <Text style={styles.reviewValue}>
            {formData.preferences.notifications ? 'Enabled' : 'Disabled'}
          </Text>
        </View>
        <View style={styles.reviewItem}>
          <Text style={styles.reviewLabel}>Theme:</Text>
          <Text style={styles.reviewValue}>
            {formData.preferences.theme.charAt(0).toUpperCase() + formData.preferences.theme.slice(1)}
          </Text>
        </View>
      </View>

      <View style={styles.checkboxGroup}>
        <TouchableOpacity
          style={styles.checkboxItem}
          onPress={() => updateFormData('review', 'termsAccepted', !formData.review.termsAccepted)}
        >
          <View style={[
            styles.checkbox,
            formData.review.termsAccepted && styles.checkboxChecked,
          ]}>
            {formData.review.termsAccepted && (
              <Ionicons name="checkmark" size={16} color="#fff" />
            )}
          </View>
          <Text style={styles.checkboxText}>
            I accept the Terms and Conditions
          </Text>
        </TouchableOpacity>
        {errors.termsAccepted && <Text style={styles.errorText}>{errors.termsAccepted}</Text>}

        <TouchableOpacity
          style={styles.checkboxItem}
          onPress={() => updateFormData('review', 'privacyAccepted', !formData.review.privacyAccepted)}
        >
          <View style={[
            styles.checkbox,
            formData.review.privacyAccepted && styles.checkboxChecked,
          ]}>
            {formData.review.privacyAccepted && (
              <Ionicons name="checkmark" size={16} color="#fff" />
            )}
          </View>
          <Text style={styles.checkboxText}>
            I accept the Privacy Policy
          </Text>
        </TouchableOpacity>
        {errors.privacyAccepted && <Text style={styles.errorText}>{errors.privacyAccepted}</Text>}
      </View>
    </ScrollView>
  );

  const renderStepContent = () => {
    switch (currentStep) {
      case 1:
        return renderPersonalInfo();
      case 2:
        return renderAddressInfo();
      case 3:
        return renderPreferences();
      case 4:
        return renderPaymentInfo();
      case 5:
        return renderReview();
      default:
        return null;
    }
  };

  const renderNavigation = () => (
    <View style={styles.navigation}>
      <TouchableOpacity
        style={[styles.navButton, currentStep === 1 && styles.navButtonDisabled]}
        onPress={handlePrevious}
        disabled={currentStep === 1}
      >
        <Ionicons name="chevron-back" size={20} color={currentStep === 1 ? '#999' : '#007AFF'} />
        <Text style={[styles.navButtonText, currentStep === 1 && styles.navButtonTextDisabled]}>
          Previous
        </Text>
      </TouchableOpacity>

      <View style={styles.stepIndicator}>
        <Text style={styles.stepText}>
          Step {currentStep} of {totalSteps}
        </Text>
      </View>

      {currentStep < totalSteps ? (
        <TouchableOpacity
          style={styles.navButton}
          onPress={handleNext}
        >
          <Text style={styles.navButtonText}>Next</Text>
          <Ionicons name="chevron-forward" size={20} color="#007AFF" />
        </TouchableOpacity>
      ) : (
        <TouchableOpacity
          style={[styles.navButton, styles.submitButton]}
          onPress={handleSubmit}
          disabled={isSubmitting}
        >
          {isSubmitting ? (
            <Text style={styles.submitButtonText}>Submitting...</Text>
          ) : (
            <>
              <Text style={styles.submitButtonText}>Submit</Text>
              <Ionicons name="checkmark" size={20} color="#fff" />
            </>
          )}
        </TouchableOpacity>
      )}
    </View>
  );

  return (
    <View style={styles.container}>
      {renderStepIndicator()}
      {renderStepContent()}
      {renderNavigation()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  stepIndicator: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 20,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  stepContainer: {
    flex: 1,
    alignItems: 'center',
    position: 'relative',
  },
  stepCircle: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#e0e0e0',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  stepCircleActive: {
    backgroundColor: '#007AFF',
  },
  stepCircleCurrent: {
    backgroundColor: '#0056b3',
  },
  stepTitle: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
  },
  stepTitleActive: {
    color: '#007AFF',
    fontWeight: '600',
  },
  stepConnector: {
    position: 'absolute',
    top: 20,
    left: '60%',
    right: '-60%',
    height: 2,
    backgroundColor: '#e0e0e0',
    zIndex: -1,
  },
  stepConnectorActive: {
    backgroundColor: '#007AFF',
  },
  stepContent: {
    flex: 1,
    padding: 20,
  },
  stepHeader: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  stepDescription: {
    fontSize: 16,
    color: '#666',
    marginBottom: 24,
  },
  inputGroup: {
    marginBottom: 20,
  },
  inputGroupHalf: {
    flex: 1,
    marginRight: 10,
  },
  inputRow: {
    flexDirection: 'row',
    marginBottom: 20,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 8,
  },
  input: {
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  inputError: {
    borderColor: '#F44336',
  },
  errorText: {
    color: '#F44336',
    fontSize: 14,
    marginTop: 4,
  },
  preferenceItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  preferenceContent: {
    flex: 1,
    marginRight: 16,
  },
  preferenceTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  preferenceDescription: {
    fontSize: 14,
    color: '#666',
  },
  radioGroup: {
    marginTop: 8,
  },
  radioOption: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  radioOptionSelected: {
    // Add selected styling if needed
  },
  radioCircle: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: '#e0e0e0',
    marginRight: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  radioCircleInner: {
    width: 10,
    height: 10,
    borderRadius: 5,
    backgroundColor: '#007AFF',
  },
  radioText: {
    fontSize: 16,
    color: '#333',
  },
  radioTextSelected: {
    color: '#007AFF',
    fontWeight: '600',
  },
  reviewSection: {
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 16,
    marginBottom: 16,
  },
  reviewSectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  reviewItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  reviewLabel: {
    fontSize: 14,
    color: '#666',
    fontWeight: '500',
  },
  reviewValue: {
    fontSize: 14,
    color: '#333',
    flex: 1,
    textAlign: 'right',
  },
  checkboxGroup: {
    marginTop: 20,
  },
  checkboxItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 4,
    borderWidth: 2,
    borderColor: '#e0e0e0',
    marginRight: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  checkboxChecked: {
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  },
  checkboxText: {
    fontSize: 16,
    color: '#333',
    flex: 1,
  },
  navigation: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 16,
    backgroundColor: '#fff',
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
  navButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#007AFF',
    backgroundColor: '#fff',
  },
  navButtonDisabled: {
    borderColor: '#e0e0e0',
    backgroundColor: '#f5f5f5',
  },
  navButtonText: {
    color: '#007AFF',
    fontSize: 16,
    fontWeight: '600',
    marginHorizontal: 8,
  },
  navButtonTextDisabled: {
    color: '#999',
  },
  submitButton: {
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  },
  submitButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
    marginHorizontal: 8,
  },
  stepText: {
    fontSize: 14,
    color: '#666',
    fontWeight: '500',
  },
});

export default MultiStepWizard;

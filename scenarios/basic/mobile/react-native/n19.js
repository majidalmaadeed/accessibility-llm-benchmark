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

const UngroupedRadioButtons = () => {
  const [formData, setFormData] = useState({
    // Contact Preferences - UNGROUPED RADIO BUTTONS
    email: false,
    sms: false,
    phone: false,
    push: false,
    
    // Newsletter Preferences - UNGROUPED RADIO BUTTONS
    daily: false,
    weekly: false,
    monthly: false,
    never: false,
    
    // Account Type - UNGROUPED RADIO BUTTONS
    personal: false,
    business: false,
    enterprise: false,
    
    // Other form fields
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    company: '',
    message: ''
  });

  const [currentStep, setCurrentStep] = useState(1);
  const totalSteps = 3;

  const handleRadioChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleNext = () => {
    if (currentStep < totalSteps) {
      setCurrentStep(currentStep + 1);
    }
  };

  const handlePrevious = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1);
    }
  };

  const handleSubmit = () => {
    // Validate required fields
    const requiredFields = ['firstName', 'lastName', 'email'];
    const missingFields = requiredFields.filter(field => !formData[field]);
    
    if (missingFields.length > 0) {
      Alert.alert('Missing Information', 'Please fill in all required fields');
      return;
    }

    // Check if at least one contact preference is selected
    const contactPreferences = ['email', 'sms', 'phone', 'push'];
    const hasContactPreference = contactPreferences.some(pref => formData[pref]);
    
    if (!hasContactPreference) {
      Alert.alert('Contact Preference Required', 'Please select at least one contact preference');
      return;
    }

    Alert.alert('Success', 'Form submitted successfully!');
    console.log('Form Data:', formData);
  };

  const renderStepIndicator = () => (
    <View style={styles.stepIndicator}>
      {Array.from({ length: totalSteps }, (_, index) => (
        <View
          key={index}
          style={[
            styles.stepDot,
            index + 1 <= currentStep && styles.activeStepDot
          ]}
        />
      ))}
    </View>
  );

  const renderContactPreferences = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Contact Preferences</Text>
      <Text style={styles.sectionDescription}>
        How would you like us to contact you? (Select all that apply)
      </Text>
      
      {/* UNGROUPED RADIO BUTTONS - No fieldset grouping */}
      <View style={styles.radioContainer}>
        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('email', !formData.email)}
        >
          <View style={styles.radioButton}>
            {formData.email && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Email notifications</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('sms', !formData.sms)}
        >
          <View style={styles.radioButton}>
            {formData.sms && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>SMS messages</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('phone', !formData.phone)}
        >
          <View style={styles.radioButton}>
            {formData.phone && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Phone calls</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('push', !formData.push)}
        >
          <View style={styles.radioButton}>
            {formData.push && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Push notifications</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderNewsletterPreferences = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Newsletter Frequency</Text>
      <Text style={styles.sectionDescription}>
        How often would you like to receive our newsletter?
      </Text>
      
      {/* UNGROUPED RADIO BUTTONS - No fieldset grouping */}
      <View style={styles.radioContainer}>
        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('daily', !formData.daily)}
        >
          <View style={styles.radioButton}>
            {formData.daily && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Daily</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('weekly', !formData.weekly)}
        >
          <View style={styles.radioButton}>
            {formData.weekly && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Weekly</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('monthly', !formData.monthly)}
        >
          <View style={styles.radioButton}>
            {formData.monthly && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Monthly</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('never', !formData.never)}
        >
          <View style={styles.radioButton}>
            {formData.never && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Never</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderAccountType = () => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>Account Type</Text>
      <Text style={styles.sectionDescription}>
        What type of account are you creating?
      </Text>
      
      {/* UNGROUPED RADIO BUTTONS - No fieldset grouping */}
      <View style={styles.radioContainer}>
        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('personal', !formData.personal)}
        >
          <View style={styles.radioButton}>
            {formData.personal && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Personal Account</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('business', !formData.business)}
        >
          <View style={styles.radioButton}>
            {formData.business && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Business Account</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.radioOption}
          onPress={() => handleRadioChange('enterprise', !formData.enterprise)}
        >
          <View style={styles.radioButton}>
            {formData.enterprise && <View style={styles.radioButtonSelected} />}
          </View>
          <Text style={styles.radioLabel}>Enterprise Account</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderStepContent = () => {
    switch (currentStep) {
      case 1:
        return (
          <View>
            <Text style={styles.stepTitle}>Personal Information</Text>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>First Name *</Text>
              <TextInput
                style={styles.textInput}
                value={formData.firstName}
                onChangeText={(value) => handleInputChange('firstName', value)}
                placeholder="Enter your first name"
              />
            </View>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>Last Name *</Text>
              <TextInput
                style={styles.textInput}
                value={formData.lastName}
                onChangeText={(value) => handleInputChange('lastName', value)}
                placeholder="Enter your last name"
              />
            </View>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>Email Address *</Text>
              <TextInput
                style={styles.textInput}
                value={formData.email}
                onChangeText={(value) => handleInputChange('email', value)}
                placeholder="Enter your email address"
                keyboardType="email-address"
                autoCapitalize="none"
              />
            </View>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>Phone Number</Text>
              <TextInput
                style={styles.textInput}
                value={formData.phone}
                onChangeText={(value) => handleInputChange('phone', value)}
                placeholder="Enter your phone number"
                keyboardType="phone-pad"
              />
            </View>
            {renderContactPreferences()}
          </View>
        );
      case 2:
        return (
          <View>
            <Text style={styles.stepTitle}>Preferences</Text>
            {renderNewsletterPreferences()}
            {renderAccountType()}
          </View>
        );
      case 3:
        return (
          <View>
            <Text style={styles.stepTitle}>Additional Information</Text>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>Company Name</Text>
              <TextInput
                style={styles.textInput}
                value={formData.company}
                onChangeText={(value) => handleInputChange('company', value)}
                placeholder="Enter your company name"
              />
            </View>
            <View style={styles.inputGroup}>
              <Text style={styles.inputLabel}>Message</Text>
              <TextInput
                style={[styles.textInput, styles.textArea]}
                value={formData.message}
                onChangeText={(value) => handleInputChange('message', value)}
                placeholder="Any additional information..."
                multiline
                numberOfLines={4}
              />
            </View>
          </View>
        );
      default:
        return null;
    }
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Account Registration</Text>
        <Text style={styles.headerSubtitle}>Create your account in 3 simple steps</Text>
        {renderStepIndicator()}
      </View>

      {/* Form Content */}
      <View style={styles.formContainer}>
        {renderStepContent()}
      </View>

      {/* Navigation Buttons */}
      <View style={styles.navigationContainer}>
        <View style={styles.navigationButtons}>
          {currentStep > 1 && (
            <TouchableOpacity
              style={styles.previousButton}
              onPress={handlePrevious}
            >
              <Text style={styles.previousButtonText}>Previous</Text>
            </TouchableOpacity>
          )}
          
          <View style={styles.spacer} />
          
          {currentStep < totalSteps ? (
            <TouchableOpacity
              style={styles.nextButton}
              onPress={handleNext}
            >
              <Text style={styles.nextButtonText}>Next</Text>
            </TouchableOpacity>
          ) : (
            <TouchableOpacity
              style={styles.submitButton}
              onPress={handleSubmit}
            >
              <Text style={styles.submitButtonText}>Submit</Text>
            </TouchableOpacity>
          )}
        </View>
      </View>

      {/* Progress Info */}
      <View style={styles.progressInfo}>
        <Text style={styles.progressText}>
          Step {currentStep} of {totalSteps}
        </Text>
        <Text style={styles.progressPercentage}>
          {Math.round((currentStep / totalSteps) * 100)}% Complete
        </Text>
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
    marginBottom: 24,
  },
  stepIndicator: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  stepDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
    marginHorizontal: 6,
  },
  activeStepDot: {
    backgroundColor: '#FFFFFF',
  },
  formContainer: {
    padding: 24,
  },
  stepTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginBottom: 24,
  },
  section: {
    marginBottom: 32,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 8,
  },
  sectionDescription: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 16,
    lineHeight: 20,
  },
  inputGroup: {
    marginBottom: 20,
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
  textArea: {
    height: 100,
    textAlignVertical: 'top',
  },
  radioContainer: {
    // NO FIELDSET GROUPING - Radio buttons are not properly grouped
  },
  radioOption: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    marginBottom: 8,
    borderWidth: 1,
    borderColor: '#E0E0E0',
  },
  radioButton: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: '#BDBDBD',
    marginRight: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  radioButtonSelected: {
    width: 10,
    height: 10,
    borderRadius: 5,
    backgroundColor: '#2196F3',
  },
  radioLabel: {
    fontSize: 16,
    color: '#2C3E50',
    flex: 1,
  },
  navigationContainer: {
    padding: 24,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
  },
  navigationButtons: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  previousButton: {
    backgroundColor: '#F5F5F5',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#BDBDBD',
  },
  previousButtonText: {
    color: '#2C3E50',
    fontSize: 16,
    fontWeight: '500',
  },
  spacer: {
    flex: 1,
  },
  nextButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  nextButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  submitButton: {
    backgroundColor: '#4CAF50',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  submitButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  progressInfo: {
    padding: 16,
    backgroundColor: '#F5F5F5',
    alignItems: 'center',
  },
  progressText: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 4,
  },
  progressPercentage: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2196F3',
  },
});

export default UngroupedRadioButtons;

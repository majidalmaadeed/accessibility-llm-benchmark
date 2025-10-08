import React, { useState, useRef, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  TextInput,
  Modal,
  Alert,
} from 'react-native';

const KeyboardTrapInWidget = () => {
  const [selectedDate, setSelectedDate] = useState('');
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [currentMonth, setCurrentMonth] = useState(new Date());
  const [selectedDay, setSelectedDay] = useState(null);
  
  const [formData, setFormData] = useState({
    eventName: '',
    eventDate: '',
    eventTime: '',
    eventLocation: '',
    eventDescription: '',
    eventType: '',
    attendees: '',
    reminder: false
  });

  const [activeInput, setActiveInput] = useState(null);
  const inputRefs = useRef({});

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  const eventTypes = [
    { id: 'meeting', name: 'Meeting' },
    { id: 'conference', name: 'Conference' },
    { id: 'workshop', name: 'Workshop' },
    { id: 'social', name: 'Social Event' },
    { id: 'training', name: 'Training' },
    { id: 'other', name: 'Other' }
  ];

  const generateCalendarDays = () => {
    const year = currentMonth.getFullYear();
    const month = currentMonth.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();
    const startingDayOfWeek = firstDay.getDay();

    const days = [];
    
    // Add empty cells for days before the first day of the month
    for (let i = 0; i < startingDayOfWeek; i++) {
      days.push(null);
    }
    
    // Add days of the month
    for (let day = 1; day <= daysInMonth; day++) {
      days.push(day);
    }
    
    return days;
  };

  const handleDateSelect = (day) => {
    if (day) {
      setSelectedDay(day);
      const selectedDate = new Date(currentMonth.getFullYear(), currentMonth.getMonth(), day);
      const formattedDate = selectedDate.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
      setSelectedDate(formattedDate);
      setFormData(prev => ({ ...prev, eventDate: formattedDate }));
    }
  };

  const navigateMonth = (direction) => {
    setCurrentMonth(prev => {
      const newMonth = new Date(prev);
      newMonth.setMonth(prev.getMonth() + direction);
      return newMonth;
    });
  };

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleInputFocus = (field) => {
    setActiveInput(field);
  };

  const handleInputBlur = () => {
    setActiveInput(null);
  };

  const handleSubmit = () => {
    if (!formData.eventName || !formData.eventDate) {
      Alert.alert('Missing Information', 'Please fill in the required fields');
      return;
    }
    Alert.alert('Success', 'Event created successfully!');
    console.log('Event Data:', formData);
  };

  const renderDatePicker = () => {
    const calendarDays = generateCalendarDays();
    
    return (
      <Modal
        visible={showDatePicker}
        transparent={true}
        animationType="slide"
        onRequestClose={() => setShowDatePicker(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={styles.datePickerContainer}>
            {/* Date Picker Header */}
            <View style={styles.datePickerHeader}>
              <TouchableOpacity
                style={styles.navButton}
                onPress={() => navigateMonth(-1)}
              >
                <Text style={styles.navButtonText}>‹</Text>
              </TouchableOpacity>
              
              <Text style={styles.monthYearText}>
                {months[currentMonth.getMonth()]} {currentMonth.getFullYear()}
              </Text>
              
              <TouchableOpacity
                style={styles.navButton}
                onPress={() => navigateMonth(1)}
              >
                <Text style={styles.navButtonText}>›</Text>
              </TouchableOpacity>
            </View>

            {/* Days of Week Header */}
            <View style={styles.daysOfWeekContainer}>
              {daysOfWeek.map(day => (
                <Text key={day} style={styles.dayOfWeekText}>{day}</Text>
              ))}
            </View>

            {/* Calendar Grid */}
            <View style={styles.calendarGrid}>
              {calendarDays.map((day, index) => (
                <TouchableOpacity
                  key={index}
                  style={[
                    styles.calendarDay,
                    day === selectedDay && styles.selectedDay,
                    !day && styles.emptyDay
                  ]}
                  onPress={() => day && handleDateSelect(day)}
                >
                  <Text style={[
                    styles.calendarDayText,
                    day === selectedDay && styles.selectedDayText
                  ]}>
                    {day}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>

            {/* Date Picker Actions */}
            <View style={styles.datePickerActions}>
              <TouchableOpacity
                style={styles.cancelButton}
                onPress={() => setShowDatePicker(false)}
              >
                <Text style={styles.cancelButtonText}>Cancel</Text>
              </TouchableOpacity>
              
              <TouchableOpacity
                style={styles.confirmButton}
                onPress={() => setShowDatePicker(false)}
              >
                <Text style={styles.confirmButtonText}>Confirm</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </Modal>
    );
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Event Planner</Text>
        <Text style={styles.headerSubtitle}>Create and manage your events</Text>
      </View>

      {/* Form */}
      <View style={styles.formContainer}>
        <Text style={styles.sectionTitle}>Event Details</Text>
        
        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Event Name *</Text>
          <TextInput
            ref={ref => inputRefs.current.eventName = ref}
            style={styles.textInput}
            value={formData.eventName}
            onChangeText={(value) => handleInputChange('eventName', value)}
            onFocus={() => handleInputFocus('eventName')}
            onBlur={handleInputBlur}
            placeholder="Enter event name"
          />
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Event Date *</Text>
          <TouchableOpacity
            style={styles.dateInput}
            onPress={() => setShowDatePicker(true)}
          >
            <Text style={[styles.dateInputText, !selectedDate && styles.placeholderText]}>
              {selectedDate || 'Select date'}
            </Text>
            <Text style={styles.dateInputIcon}>📅</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Event Time</Text>
          <TextInput
            ref={ref => inputRefs.current.eventTime = ref}
            style={styles.textInput}
            value={formData.eventTime}
            onChangeText={(value) => handleInputChange('eventTime', value)}
            onFocus={() => handleInputFocus('eventTime')}
            onBlur={handleInputBlur}
            placeholder="e.g., 2:00 PM"
          />
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Location</Text>
          <TextInput
            ref={ref => inputRefs.current.eventLocation = ref}
            style={styles.textInput}
            value={formData.eventLocation}
            onChangeText={(value) => handleInputChange('eventLocation', value)}
            onFocus={() => handleInputFocus('eventLocation')}
            onBlur={handleInputBlur}
            placeholder="Enter event location"
          />
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Event Type</Text>
          <TouchableOpacity style={styles.selectButton}>
            <Text style={[styles.selectText, !formData.eventType && styles.placeholderText]}>
              {formData.eventType || 'Select event type'}
            </Text>
            <Text style={styles.selectArrow}>▼</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Description</Text>
          <TextInput
            ref={ref => inputRefs.current.eventDescription = ref}
            style={[styles.textInput, styles.textArea]}
            value={formData.eventDescription}
            onChangeText={(value) => handleInputChange('eventDescription', value)}
            onFocus={() => handleInputFocus('eventDescription')}
            onBlur={handleInputBlur}
            placeholder="Enter event description"
            multiline
            numberOfLines={4}
          />
        </View>

        <View style={styles.inputGroup}>
          <Text style={styles.inputLabel}>Expected Attendees</Text>
          <TextInput
            ref={ref => inputRefs.current.attendees = ref}
            style={styles.textInput}
            value={formData.attendees}
            onChangeText={(value) => handleInputChange('attendees', value)}
            onFocus={() => handleInputFocus('attendees')}
            onBlur={handleInputBlur}
            placeholder="Enter number of attendees"
            keyboardType="numeric"
          />
        </View>

        <View style={styles.checkboxGroup}>
          <TouchableOpacity
            style={styles.checkboxContainer}
            onPress={() => handleInputChange('reminder', !formData.reminder)}
          >
            <View style={[styles.checkbox, formData.reminder && styles.checkedBox]}>
              {formData.reminder && <Text style={styles.checkmark}>✓</Text>}
            </View>
            <Text style={styles.checkboxLabel}>Send reminder notifications</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Action Buttons */}
      <View style={styles.actionContainer}>
        <TouchableOpacity
          style={styles.cancelButton}
          onPress={() => Alert.alert('Cancel', 'Are you sure you want to cancel?')}
        >
          <Text style={styles.cancelButtonText}>Cancel</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.submitButton}
          onPress={handleSubmit}
        >
          <Text style={styles.submitButtonText}>Create Event</Text>
        </TouchableOpacity>
      </View>

      {/* Date Picker Modal */}
      {renderDatePicker()}
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
    marginBottom: 20,
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
  dateInput: {
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
  dateInputText: {
    fontSize: 16,
    color: '#2C3E50',
  },
  placeholderText: {
    color: '#9E9E9E',
  },
  dateInputIcon: {
    fontSize: 16,
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
  selectArrow: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  checkboxGroup: {
    marginBottom: 20,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'center',
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
  checkboxLabel: {
    fontSize: 16,
    color: '#2C3E50',
  },
  actionContainer: {
    flexDirection: 'row',
    padding: 24,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
  },
  cancelButton: {
    flex: 1,
    backgroundColor: '#F5F5F5',
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: 'center',
    marginRight: 12,
    borderWidth: 1,
    borderColor: '#BDBDBD',
  },
  cancelButtonText: {
    color: '#2C3E50',
    fontSize: 16,
    fontWeight: '500',
  },
  submitButton: {
    flex: 1,
    backgroundColor: '#4CAF50',
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: 'center',
  },
  submitButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  datePickerContainer: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 20,
    width: '90%',
    maxWidth: 400,
    // KEYBOARD TRAP - Modal prevents focus from escaping
    // No escape mechanism for keyboard users
  },
  datePickerHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  navButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
  },
  navButtonText: {
    fontSize: 20,
    color: '#2196F3',
    fontWeight: 'bold',
  },
  monthYearText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#2C3E50',
  },
  daysOfWeekContainer: {
    flexDirection: 'row',
    marginBottom: 10,
  },
  dayOfWeekText: {
    flex: 1,
    textAlign: 'center',
    fontSize: 14,
    fontWeight: '500',
    color: '#7F8C8D',
  },
  calendarGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginBottom: 20,
  },
  calendarDay: {
    width: '14.28%',
    aspectRatio: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  emptyDay: {
    // Empty day styling
  },
  selectedDay: {
    backgroundColor: '#2196F3',
    borderRadius: 20,
  },
  calendarDayText: {
    fontSize: 16,
    color: '#2C3E50',
  },
  selectedDayText: {
    color: '#FFFFFF',
    fontWeight: 'bold',
  },
  datePickerActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  confirmButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 6,
  },
  confirmButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
});

export default KeyboardTrapInWidget;

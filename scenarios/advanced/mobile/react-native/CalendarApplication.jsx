import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Modal,
  Alert,
  Dimensions,
  TextInput,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const CalendarApplication = () => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState(new Date());
  const [viewMode, setViewMode] = useState('month'); // month, week, day
  const [events, setEvents] = useState([]);
  const [showEventModal, setShowEventModal] = useState(false);
  const [showEventDetails, setShowEventDetails] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [recurringOptions, setRecurringOptions] = useState([]);
  const [reminderSettings, setReminderSettings] = useState([]);
  const [categoryFilters, setCategoryFilters] = useState([]);
  const [newEvent, setNewEvent] = useState({
    title: '',
    description: '',
    startTime: '',
    endTime: '',
    category: 'personal',
    isAllDay: false,
    location: '',
    attendees: [],
    recurring: 'none',
    reminders: [],
  });

  const categories = [
    { id: 'personal', name: 'Personal', color: '#4CAF50' },
    { id: 'work', name: 'Work', color: '#2196F3' },
    { id: 'meeting', name: 'Meeting', color: '#FF9800' },
    { id: 'appointment', name: 'Appointment', color: '#9C27B0' },
    { id: 'reminder', name: 'Reminder', color: '#F44336' },
  ];

  const timeSlots = [
    '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM',
    '6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM',
    '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM',
  ];

  useEffect(() => {
    loadEvents();
  }, [currentDate]);

  const loadEvents = async () => {
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      setEvents(generateSampleEvents());
      setIsLoading(false);
    }, 1000);
  };

  const generateSampleEvents = () => {
    const sampleEvents = [
      {
        id: '1',
        title: 'Team Meeting',
        description: 'Weekly team standup',
        startTime: new Date(2024, 0, 15, 10, 0),
        endTime: new Date(2024, 0, 15, 11, 0),
        category: 'work',
        isAllDay: false,
        location: 'Conference Room A',
        attendees: ['john@example.com', 'jane@example.com'],
        recurring: 'weekly',
        reminders: ['15min', '1hour'],
      },
      {
        id: '2',
        title: 'Doctor Appointment',
        description: 'Annual checkup',
        startTime: new Date(2024, 0, 16, 14, 30),
        endTime: new Date(2024, 0, 16, 15, 30),
        category: 'appointment',
        isAllDay: false,
        location: 'Medical Center',
        attendees: [],
        recurring: 'none',
        reminders: ['1day', '2hours'],
      },
      {
        id: '3',
        title: 'Project Deadline',
        description: 'Submit final report',
        startTime: new Date(2024, 0, 20, 17, 0),
        endTime: new Date(2024, 0, 20, 17, 0),
        category: 'work',
        isAllDay: true,
        location: '',
        attendees: [],
        recurring: 'none',
        reminders: ['1week', '1day'],
      },
    ];
    return sampleEvents;
  };

  const getDaysInMonth = (date) => {
    const year = date.getFullYear();
    const month = date.getMonth();
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
      days.push(new Date(year, month, day));
    }

    return days;
  };

  const getEventsForDate = (date) => {
    if (!date) return [];
    return events.filter(event => {
      const eventDate = new Date(event.startTime);
      return eventDate.toDateString() === date.toDateString();
    });
  };

  const formatDate = (date) => {
    return date.toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  const navigateMonth = (direction) => {
    const newDate = new Date(currentDate);
    newDate.setMonth(currentDate.getMonth() + direction);
    setCurrentDate(newDate);
  };

  const navigateWeek = (direction) => {
    const newDate = new Date(currentDate);
    newDate.setDate(currentDate.getDate() + (direction * 7));
    setCurrentDate(newDate);
  };

  const navigateDay = (direction) => {
    const newDate = new Date(currentDate);
    newDate.setDate(currentDate.getDate() + direction);
    setCurrentDate(newDate);
  };

  const handleDateSelect = (date) => {
    setSelectedDate(date);
    const dayEvents = getEventsForDate(date);
    if (dayEvents.length > 0) {
      setSelectedEvent(dayEvents[0]);
      setShowEventDetails(true);
    }
  };

  const handleCreateEvent = () => {
    setNewEvent({
      title: '',
      description: '',
      startTime: selectedDate.toISOString().slice(0, 16),
      endTime: new Date(selectedDate.getTime() + 60 * 60 * 1000).toISOString().slice(0, 16),
      category: 'personal',
      isAllDay: false,
      location: '',
      attendees: [],
      recurring: 'none',
      reminders: [],
    });
    setShowEventModal(true);
  };

  const handleSaveEvent = () => {
    if (!newEvent.title.trim()) {
      Alert.alert('Error', 'Please enter a title for the event');
      return;
    }

    const event = {
      id: Date.now().toString(),
      ...newEvent,
      startTime: new Date(newEvent.startTime),
      endTime: new Date(newEvent.endTime),
    };

    setEvents(prev => [...prev, event]);
    setShowEventModal(false);
    Alert.alert('Success', 'Event created successfully');
  };

  const handleDeleteEvent = (eventId) => {
    Alert.alert(
      'Delete Event',
      'Are you sure you want to delete this event?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Delete',
          style: 'destructive',
          onPress: () => {
            setEvents(prev => prev.filter(event => event.id !== eventId));
            setShowEventDetails(false);
          },
        },
      ]
    );
  };

  const renderHeader = () => (
    <View style={styles.header}>
      <View style={styles.headerTop}>
        <Text style={styles.headerTitle}>Calendar</Text>
        <View style={styles.headerActions}>
          <TouchableOpacity
            style={styles.headerButton}
            onPress={() => setCurrentDate(new Date())}
          >
            <Ionicons name="today" size={20} color="#007AFF" />
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.headerButton}
            onPress={handleCreateEvent}
          >
            <Ionicons name="add" size={20} color="#007AFF" />
          </TouchableOpacity>
        </View>
      </View>

      <View style={styles.viewModeSelector}>
        {['month', 'week', 'day'].map((mode) => (
          <TouchableOpacity
            key={mode}
            style={[
              styles.viewModeButton,
              viewMode === mode && styles.viewModeButtonActive,
            ]}
            onPress={() => setViewMode(mode)}
          >
            <Text
              style={[
                styles.viewModeText,
                viewMode === mode && styles.viewModeTextActive,
              ]}
            >
              {mode.charAt(0).toUpperCase() + mode.slice(1)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <View style={styles.navigation}>
        <TouchableOpacity
          style={styles.navButton}
          onPress={() => {
            if (viewMode === 'month') navigateMonth(-1);
            else if (viewMode === 'week') navigateWeek(-1);
            else navigateDay(-1);
          }}
        >
          <Ionicons name="chevron-back" size={24} color="#007AFF" />
        </TouchableOpacity>

        <Text style={styles.currentDateText}>
          {formatDate(currentDate)}
        </Text>

        <TouchableOpacity
          style={styles.navButton}
          onPress={() => {
            if (viewMode === 'month') navigateMonth(1);
            else if (viewMode === 'week') navigateWeek(1);
            else navigateDay(1);
          }}
        >
          <Ionicons name="chevron-forward" size={24} color="#007AFF" />
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderMonthView = () => {
    const days = getDaysInMonth(currentDate);
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return (
      <View style={styles.monthView}>
        <View style={styles.weekDaysHeader}>
          {weekDays.map((day) => (
            <Text key={day} style={styles.weekDayText}>
              {day}
            </Text>
          ))}
        </View>

        <View style={styles.calendarGrid}>
          {days.map((date, index) => {
            const dayEvents = getEventsForDate(date);
            const isToday = date && date.toDateString() === new Date().toDateString();
            const isSelected = date && date.toDateString() === selectedDate.toDateString();

            return (
              <TouchableOpacity
                key={index}
                style={[
                  styles.dayCell,
                  isToday && styles.todayCell,
                  isSelected && styles.selectedCell,
                ]}
                onPress={() => date && handleDateSelect(date)}
              >
                {date && (
                  <>
                    <Text
                      style={[
                        styles.dayText,
                        isToday && styles.todayText,
                        isSelected && styles.selectedText,
                      ]}
                    >
                      {date.getDate()}
                    </Text>
                    {dayEvents.length > 0 && (
                      <View style={styles.eventIndicators}>
                        {dayEvents.slice(0, 3).map((event, eventIndex) => (
                          <View
                            key={eventIndex}
                            style={[
                              styles.eventIndicator,
                              { backgroundColor: categories.find(c => c.id === event.category)?.color || '#007AFF' },
                            ]}
                          />
                        ))}
                        {dayEvents.length > 3 && (
                          <Text style={styles.moreEventsText}>+{dayEvents.length - 3}</Text>
                        )}
                      </View>
                    )}
                  </>
                )}
              </TouchableOpacity>
            );
          })}
        </View>
      </View>
    );
  };

  const renderWeekView = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());
    
    const weekDays = [];
    for (let i = 0; i < 7; i++) {
      const day = new Date(startOfWeek);
      day.setDate(startOfWeek.getDate() + i);
      weekDays.push(day);
    }

    return (
      <View style={styles.weekView}>
        <View style={styles.weekHeader}>
          {weekDays.map((day, index) => {
            const dayEvents = getEventsForDate(day);
            const isToday = day.toDateString() === new Date().toDateString();
            const isSelected = day.toDateString() === selectedDate.toDateString();

            return (
              <TouchableOpacity
                key={index}
                style={[
                  styles.weekDayCell,
                  isToday && styles.todayCell,
                  isSelected && styles.selectedCell,
                ]}
                onPress={() => handleDateSelect(day)}
              >
                <Text style={styles.weekDayName}>
                  {day.toLocaleDateString('en-US', { weekday: 'short' })}
                </Text>
                <Text
                  style={[
                    styles.weekDayNumber,
                    isToday && styles.todayText,
                    isSelected && styles.selectedText,
                  ]}
                >
                  {day.getDate()}
                </Text>
                {dayEvents.length > 0 && (
                  <View style={styles.weekEventIndicators}>
                    {dayEvents.slice(0, 2).map((event, eventIndex) => (
                      <View
                        key={eventIndex}
                        style={[
                          styles.weekEventIndicator,
                          { backgroundColor: categories.find(c => c.id === event.category)?.color || '#007AFF' },
                        ]}
                      />
                    ))}
                  </View>
                )}
              </TouchableOpacity>
            );
          })}
        </View>
      </View>
    );
  };

  const renderDayView = () => {
    const dayEvents = getEventsForDate(currentDate);
    const isToday = currentDate.toDateString() === new Date().toDateString();

    return (
      <View style={styles.dayView}>
        <View style={styles.dayHeader}>
          <Text style={styles.dayDateText}>
            {currentDate.getDate()}
          </Text>
          <View>
            <Text style={styles.dayMonthText}>
              {currentDate.toLocaleDateString('en-US', { month: 'long' })}
            </Text>
            <Text style={styles.dayYearText}>
              {currentDate.getFullYear()}
            </Text>
          </View>
        </View>

        <ScrollView style={styles.dayEventsList}>
          {dayEvents.map((event) => (
            <TouchableOpacity
              key={event.id}
              style={styles.dayEventItem}
              onPress={() => {
                setSelectedEvent(event);
                setShowEventDetails(true);
              }}
            >
              <View
                style={[
                  styles.eventColorBar,
                  { backgroundColor: categories.find(c => c.id === event.category)?.color || '#007AFF' },
                ]}
              />
              <View style={styles.eventContent}>
                <Text style={styles.eventTitle}>{event.title}</Text>
                <Text style={styles.eventTime}>
                  {event.isAllDay ? 'All Day' : `${event.startTime.toLocaleTimeString()} - ${event.endTime.toLocaleTimeString()}`}
                </Text>
                {event.location && (
                  <Text style={styles.eventLocation}>{event.location}</Text>
                )}
              </View>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>
    );
  };

  const renderEventModal = () => (
    <Modal
      visible={showEventModal}
      animationType="slide"
      onRequestClose={() => setShowEventModal(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowEventModal(false)}>
            <Text style={styles.modalCancelText}>Cancel</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>New Event</Text>
          <TouchableOpacity onPress={handleSaveEvent}>
            <Text style={styles.modalSaveText}>Save</Text>
          </TouchableOpacity>
        </View>

        <ScrollView style={styles.modalContent}>
          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Title *</Text>
            <TextInput
              style={styles.textInput}
              value={newEvent.title}
              onChangeText={(text) => setNewEvent(prev => ({ ...prev, title: text }))}
              placeholder="Event title"
            />
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Description</Text>
            <TextInput
              style={[styles.textInput, styles.textArea]}
              value={newEvent.description}
              onChangeText={(text) => setNewEvent(prev => ({ ...prev, description: text }))}
              placeholder="Event description"
              multiline
              numberOfLines={3}
            />
          </View>

          <View style={styles.inputRow}>
            <View style={styles.inputGroupHalf}>
              <Text style={styles.inputLabel}>Start Time</Text>
              <TextInput
                style={styles.textInput}
                value={newEvent.startTime}
                onChangeText={(text) => setNewEvent(prev => ({ ...prev, startTime: text }))}
                placeholder="YYYY-MM-DDTHH:MM"
              />
            </View>
            <View style={styles.inputGroupHalf}>
              <Text style={styles.inputLabel}>End Time</Text>
              <TextInput
                style={styles.textInput}
                value={newEvent.endTime}
                onChangeText={(text) => setNewEvent(prev => ({ ...prev, endTime: text }))}
                placeholder="YYYY-MM-DDTHH:MM"
              />
            </View>
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Category</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {categories.map((category) => (
                <TouchableOpacity
                  key={category.id}
                  style={[
                    styles.categoryChip,
                    { backgroundColor: category.color },
                    newEvent.category === category.id && styles.categoryChipSelected,
                  ]}
                  onPress={() => setNewEvent(prev => ({ ...prev, category: category.id }))}
                >
                  <Text style={styles.categoryChipText}>{category.name}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>

          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Location</Text>
            <TextInput
              style={styles.textInput}
              value={newEvent.location}
              onChangeText={(text) => setNewEvent(prev => ({ ...prev, location: text }))}
              placeholder="Event location"
            />
          </View>
        </ScrollView>
      </View>
    </Modal>
  );

  const renderEventDetails = () => (
    <Modal
      visible={showEventDetails}
      animationType="slide"
      onRequestClose={() => setShowEventDetails(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowEventDetails(false)}>
            <Text style={styles.modalCancelText}>Close</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Event Details</Text>
          <TouchableOpacity onPress={() => handleDeleteEvent(selectedEvent?.id)}>
            <Ionicons name="trash" size={20} color="#F44336" />
          </TouchableOpacity>
        </View>

        {selectedEvent && (
          <ScrollView style={styles.modalContent}>
            <View style={styles.eventDetailsHeader}>
              <View
                style={[
                  styles.eventDetailsColorBar,
                  { backgroundColor: categories.find(c => c.id === selectedEvent.category)?.color || '#007AFF' },
                ]}
              />
              <View style={styles.eventDetailsContent}>
                <Text style={styles.eventDetailsTitle}>{selectedEvent.title}</Text>
                <Text style={styles.eventDetailsTime}>
                  {selectedEvent.isAllDay ? 'All Day' : `${selectedEvent.startTime.toLocaleString()} - ${selectedEvent.endTime.toLocaleString()}`}
                </Text>
              </View>
            </View>

            {selectedEvent.description && (
              <View style={styles.eventDetailsSection}>
                <Text style={styles.eventDetailsLabel}>Description</Text>
                <Text style={styles.eventDetailsText}>{selectedEvent.description}</Text>
              </View>
            )}

            {selectedEvent.location && (
              <View style={styles.eventDetailsSection}>
                <Text style={styles.eventDetailsLabel}>Location</Text>
                <Text style={styles.eventDetailsText}>{selectedEvent.location}</Text>
              </View>
            )}

            {selectedEvent.attendees.length > 0 && (
              <View style={styles.eventDetailsSection}>
                <Text style={styles.eventDetailsLabel}>Attendees</Text>
                {selectedEvent.attendees.map((attendee, index) => (
                  <Text key={index} style={styles.eventDetailsText}>{attendee}</Text>
                ))}
              </View>
            )}
          </ScrollView>
        )}
      </View>
    </Modal>
  );

  return (
    <View style={styles.container}>
      {renderHeader()}
      
      {isLoading ? (
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingText}>Loading events...</Text>
        </View>
      ) : (
        <>
          {viewMode === 'month' && renderMonthView()}
          {viewMode === 'week' && renderWeekView()}
          {viewMode === 'day' && renderDayView()}
        </>
      )}

      {renderEventModal()}
      {renderEventDetails()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#fff',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  headerActions: {
    flexDirection: 'row',
    gap: 12,
  },
  headerButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  viewModeSelector: {
    flexDirection: 'row',
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    padding: 4,
    marginBottom: 16,
  },
  viewModeButton: {
    flex: 1,
    paddingVertical: 8,
    alignItems: 'center',
    borderRadius: 6,
  },
  viewModeButtonActive: {
    backgroundColor: '#007AFF',
  },
  viewModeText: {
    fontSize: 14,
    color: '#666',
    fontWeight: '500',
  },
  viewModeTextActive: {
    color: '#fff',
  },
  navigation: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  navButton: {
    padding: 8,
  },
  currentDateText: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
  },
  monthView: {
    flex: 1,
    padding: 16,
  },
  weekDaysHeader: {
    flexDirection: 'row',
    marginBottom: 8,
  },
  weekDayText: {
    flex: 1,
    textAlign: 'center',
    fontSize: 14,
    fontWeight: '600',
    color: '#666',
    paddingVertical: 8,
  },
  calendarGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  dayCell: {
    width: width / 7 - 2,
    height: 80,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    backgroundColor: '#fff',
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    padding: 4,
  },
  todayCell: {
    backgroundColor: '#e3f2fd',
  },
  selectedCell: {
    backgroundColor: '#007AFF',
  },
  dayText: {
    fontSize: 16,
    color: '#333',
  },
  todayText: {
    color: '#007AFF',
    fontWeight: 'bold',
  },
  selectedText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  eventIndicators: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginTop: 2,
  },
  eventIndicator: {
    width: 6,
    height: 6,
    borderRadius: 3,
    marginRight: 2,
    marginBottom: 2,
  },
  moreEventsText: {
    fontSize: 10,
    color: '#666',
  },
  weekView: {
    flex: 1,
    padding: 16,
  },
  weekHeader: {
    flexDirection: 'row',
  },
  weekDayCell: {
    flex: 1,
    alignItems: 'center',
    padding: 8,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    backgroundColor: '#fff',
  },
  weekDayName: {
    fontSize: 12,
    color: '#666',
    marginBottom: 4,
  },
  weekDayNumber: {
    fontSize: 16,
    color: '#333',
    fontWeight: '600',
  },
  weekEventIndicators: {
    flexDirection: 'row',
    marginTop: 4,
  },
  weekEventIndicator: {
    width: 4,
    height: 4,
    borderRadius: 2,
    marginRight: 2,
  },
  dayView: {
    flex: 1,
    padding: 16,
  },
  dayHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  dayDateText: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#333',
    marginRight: 16,
  },
  dayMonthText: {
    fontSize: 18,
    color: '#666',
  },
  dayYearText: {
    fontSize: 14,
    color: '#666',
  },
  dayEventsList: {
    flex: 1,
  },
  dayEventItem: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderRadius: 8,
    marginBottom: 8,
    padding: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  eventColorBar: {
    width: 4,
    borderRadius: 2,
    marginRight: 12,
  },
  eventContent: {
    flex: 1,
  },
  eventTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  eventTime: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  eventLocation: {
    fontSize: 12,
    color: '#999',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
  },
  modalContainer: {
    flex: 1,
    backgroundColor: '#fff',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  modalCancelText: {
    fontSize: 16,
    color: '#666',
  },
  modalSaveText: {
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '600',
  },
  modalContent: {
    flex: 1,
    padding: 16,
  },
  inputGroup: {
    marginBottom: 20,
  },
  inputGroupHalf: {
    flex: 1,
    marginRight: 8,
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
  textInput: {
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  textArea: {
    height: 80,
    textAlignVertical: 'top',
  },
  categoryChip: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginRight: 8,
  },
  categoryChipSelected: {
    borderWidth: 2,
    borderColor: '#fff',
  },
  categoryChipText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '500',
  },
  eventDetailsHeader: {
    flexDirection: 'row',
    marginBottom: 20,
  },
  eventDetailsColorBar: {
    width: 4,
    borderRadius: 2,
    marginRight: 12,
  },
  eventDetailsContent: {
    flex: 1,
  },
  eventDetailsTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  eventDetailsTime: {
    fontSize: 16,
    color: '#666',
  },
  eventDetailsSection: {
    marginBottom: 20,
  },
  eventDetailsLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 8,
  },
  eventDetailsText: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
});

export default CalendarApplication;

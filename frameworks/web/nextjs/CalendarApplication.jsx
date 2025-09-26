'use client';

import { useState, useEffect } from 'react';
import styles from './CalendarApplication.module.css';

const CalendarApplication = () => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [view, setView] = useState('month');
  const [events, setEvents] = useState([
    {
      id: 1,
      title: 'Team Meeting',
      start: new Date(2024, 0, 15, 10, 0),
      end: new Date(2024, 0, 15, 11, 0),
      category: 'work',
      recurring: false,
      reminder: 15
    },
    {
      id: 2,
      title: 'Doctor Appointment',
      start: new Date(2024, 0, 18, 14, 30),
      end: new Date(2024, 0, 18, 15, 30),
      category: 'personal',
      recurring: false,
      reminder: 30
    },
    {
      id: 3,
      title: 'Weekly Standup',
      start: new Date(2024, 0, 16, 9, 0),
      end: new Date(2024, 0, 16, 9, 30),
      category: 'work',
      recurring: true,
      reminder: 5
    }
  ]);
  const [showEventForm, setShowEventForm] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [selectedDate, setSelectedDate] = useState(null);
  const [showCategoryFilter, setShowCategoryFilter] = useState(false);
  const [categoryFilter, setCategoryFilter] = useState('all');
  const [newEvent, setNewEvent] = useState({
    title: '',
    start: '',
    end: '',
    category: 'work',
    recurring: false,
    reminder: 15
  });

  const categories = [
    { id: 'work', name: 'Work', color: '#4caf50' },
    { id: 'personal', name: 'Personal', color: '#2196f3' },
    { id: 'health', name: 'Health', color: '#f44336' },
    { id: 'social', name: 'Social', color: '#ff9800' }
  ];

  const timeSlots = Array.from({ length: 24 }, (_, i) => `${i.toString().padStart(2, '0')}:00`);

  const getDaysInMonth = () => {
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();
    const startingDayOfWeek = firstDay.getDay();

    const days = [];
    
    for (let i = 0; i < startingDayOfWeek; i++) {
      days.push(null);
    }
    
    for (let day = 1; day <= daysInMonth; day++) {
      days.push(new Date(year, month, day));
    }
    
    return days;
  };

  const getEventsForDate = (date) => {
    if (!date) return [];
    
    return events.filter(event => {
      const eventDate = new Date(event.start);
      return eventDate.toDateString() === date.toDateString();
    });
  };

  const getStartOfWeek = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());
    return startOfWeek;
  };

  const getWeekDate = (dayIndex) => {
    const startOfWeek = getStartOfWeek();
    const date = new Date(startOfWeek);
    date.setDate(startOfWeek.getDate() + dayIndex - 1);
    return date;
  };

  const isToday = (date) => {
    return date && date.toDateString() === new Date().toDateString();
  };

  const isCurrentMonth = (date) => {
    return date && date.getMonth() === currentDate.getMonth();
  };

  const getMonthName = () => {
    return currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
  };

  const getDayName = () => {
    return currentDate.toLocaleDateString('en-US', { 
      weekday: 'long', 
      month: 'long', 
      day: 'numeric', 
      year: 'numeric' 
    });
  };

  const formatTime = (date) => {
    return new Date(date).toLocaleTimeString('en-US', { 
      hour: 'numeric', 
      minute: '2-digit' 
    });
  };

  const getEventStyle = (event) => {
    const startHours = event.start.getHours() + event.start.getMinutes() / 60;
    const duration = (event.end.getTime() - event.start.getTime()) / (1000 * 60 * 60);
    
    return {
      top: `${startHours * 40}px`,
      height: `${duration * 40}px`
    };
  };

  const handleDateClick = (date) => {
    setSelectedDate(date);
    setShowEventForm(true);
    setNewEvent({
      title: '',
      start: date.toISOString().slice(0, 16),
      end: new Date(date.getTime() + 60 * 60 * 1000).toISOString().slice(0, 16),
      category: 'work',
      recurring: false,
      reminder: 15
    });
  };

  const handleEventClick = (event) => {
    setSelectedEvent(event);
    setShowEventForm(true);
    setNewEvent({
      title: event.title,
      start: event.start.toISOString().slice(0, 16),
      end: event.end.toISOString().slice(0, 16),
      category: event.category,
      recurring: event.recurring,
      reminder: event.reminder
    });
  };

  const closeEventForm = () => {
    setShowEventForm(false);
    setSelectedEvent(null);
    setSelectedDate(null);
  };

  const handleSaveEvent = () => {
    if (!newEvent.title.trim()) return;

    const eventData = {
      ...newEvent,
      start: new Date(newEvent.start),
      end: new Date(newEvent.end),
      id: selectedEvent ? selectedEvent.id : Date.now()
    };

    if (selectedEvent) {
      setEvents(prev => prev.map(event => 
        event.id === selectedEvent.id ? eventData : event
      ));
    } else {
      setEvents(prev => [...prev, eventData]);
    }

    closeEventForm();
  };

  const handleDeleteEvent = () => {
    if (selectedEvent) {
      setEvents(prev => prev.filter(event => event.id !== selectedEvent.id));
      closeEventForm();
    }
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

  const getCategoryName = (categoryId) => {
    const category = categories.find(c => c.id === categoryId);
    return category ? category.name : 'All Categories';
  };

  const getCategoryColor = (categoryId) => {
    const category = categories.find(c => c.id === categoryId);
    return category ? category.color : '#4caf50';
  };

  const getFilteredEvents = () => {
    return categoryFilter === 'all' 
      ? events 
      : events.filter(event => event.category === categoryFilter);
  };

  return (
    <div className={styles.calendarApplication}>
      <div className={styles.calendarToolbar}>
        <div className={styles.viewControls}>
          <button 
            className={`${styles.viewBtn} ${view === 'month' ? styles.active : ''}`}
            onClick={() => setView('month')}
          >
            Month
          </button>
          <button 
            className={`${styles.viewBtn} ${view === 'week' ? styles.active : ''}`}
            onClick={() => setView('week')}
          >
            Week
          </button>
          <button 
            className={`${styles.viewBtn} ${view === 'day' ? styles.active : ''}`}
            onClick={() => setView('day')}
          >
            Day
          </button>
        </div>

        <div className={styles.toolbarActions}>
          <button 
            className={styles.newEventBtn}
            onClick={() => setShowEventForm(true)}
          >
            + New Event
          </button>
          
          <div className={styles.categoryFilter}>
            <button 
              className={styles.filterBtn}
              onClick={() => setShowCategoryFilter(!showCategoryFilter)}
            >
              Filter: {getCategoryName(categoryFilter)}
            </button>
            
            {showCategoryFilter && (
              <div className={styles.categoryDropdown}>
                <button 
                  className={`${styles.categoryOption} ${categoryFilter === 'all' ? styles.active : ''}`}
                  onClick={() => setCategoryFilter('all')}
                >
                  All Categories
                </button>
                {categories.map(category => (
                  <button
                    key={category.id}
                    className={`${styles.categoryOption} ${categoryFilter === category.id ? styles.active : ''}`}
                    onClick={() => setCategoryFilter(category.id)}
                  >
                    {category.name}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>

      <div className={styles.calendarContent}>
        {view === 'month' && (
          <div className={styles.monthView}>
            <div className={styles.calendarHeader}>
              <h2>{getMonthName()}</h2>
              <div className={styles.navigation}>
                <button onClick={() => navigateMonth(-1)}>‹</button>
                <button onClick={() => setCurrentDate(new Date())}>Today</button>
                <button onClick={() => navigateMonth(1)}>›</button>
              </div>
            </div>

            <div className={styles.calendarGrid}>
              <div className={styles.dayHeaders}>
                {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
                  <div key={day} className={styles.dayHeader}>{day}</div>
                ))}
              </div>
              
              <div className={styles.daysGrid}>
                {getDaysInMonth().map((day, index) => (
                  <div
                    key={index}
                    className={`${styles.dayCell} ${isToday(day) ? styles.today : ''} ${!isCurrentMonth(day) ? styles.otherMonth : ''}`}
                    onClick={() => day && handleDateClick(day)}
                  >
                    {day && (
                      <>
                        <div className={styles.dayNumber}>{day.getDate()}</div>
                        <div className={styles.dayEvents}>
                          {getEventsForDate(day).slice(0, 3).map(event => (
                            <div
                              key={event.id}
                              className={`${styles.eventDot} ${event.category}`}
                              onClick={(e) => {
                                handleEventClick(event);
                                e.stopPropagation();
                              }}
                            >
                              {event.title}
                            </div>
                          ))}
                          {getEventsForDate(day).length > 3 && (
                            <div className={styles.moreEvents}>
                              +{getEventsForDate(day).length - 3} more
                            </div>
                          )}
                        </div>
                      </>
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {view === 'week' && (
          <div className={styles.weekView}>
            <div className={styles.calendarHeader}>
              <h2>Week of {getStartOfWeek().toLocaleDateString()}</h2>
              <div className={styles.navigation}>
                <button onClick={() => navigateWeek(-1)}>‹</button>
                <button onClick={() => setCurrentDate(new Date())}>Today</button>
                <button onClick={() => navigateWeek(1)}>›</button>
              </div>
            </div>

            <div className={styles.weekGrid}>
              <div className={styles.timeColumn}>
                {timeSlots.map(time => (
                  <div key={time} className={styles.timeSlot}>{time}</div>
                ))}
              </div>
              
              {[1,2,3,4,5,6,7].map(i => (
                <div
                  key={i}
                  className={`${styles.dayColumn} ${isToday(getWeekDate(i)) ? styles.today : ''}`}
                >
                  <div className={styles.dayHeader}>
                    <div className={styles.dayName}>
                      {getWeekDate(i).toLocaleDateString('en-US', { weekday: 'short' })}
                    </div>
                    <div className={styles.dayNumber}>{getWeekDate(i).getDate()}</div>
                  </div>
                  
                  <div className={styles.dayEvents}>
                    {getEventsForDate(getWeekDate(i)).map(event => (
                      <div
                        key={event.id}
                        className={`${styles.eventBlock} ${event.category}`}
                        style={getEventStyle(event)}
                        onClick={() => handleEventClick(event)}
                      >
                        {event.title}
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {view === 'day' && (
          <div className={styles.dayView}>
            <div className={styles.calendarHeader}>
              <h2>{getDayName()}</h2>
              <div className={styles.navigation}>
                <button onClick={() => navigateDay(-1)}>‹</button>
                <button onClick={() => setCurrentDate(new Date())}>Today</button>
                <button onClick={() => navigateDay(1)}>›</button>
              </div>
            </div>

            <div className={styles.dayGrid}>
              <div className={styles.timeColumn}>
                {timeSlots.map(time => (
                  <div key={time} className={styles.timeSlot}>{time}</div>
                ))}
              </div>
              
              <div className={styles.dayEvents}>
                {getEventsForDate(currentDate).map(event => (
                  <div
                    key={event.id}
                    className={`${styles.eventBlock} ${event.category}`}
                    style={getEventStyle(event)}
                    onClick={() => handleEventClick(event)}
                  >
                    <div className={styles.eventTitle}>{event.title}</div>
                    <div className={styles.eventTime}>
                      {formatTime(event.start)} - {formatTime(event.end)}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>

      {showEventForm && (
        <div className={styles.eventFormOverlay}>
          <div className={styles.eventForm}>
            <div className={styles.formHeader}>
              <h3>{selectedEvent ? 'Edit Event' : 'New Event'}</h3>
              <button onClick={closeEventForm} className={styles.closeBtn}>✕</button>
            </div>

            <div className={styles.formContent}>
              <div className={styles.formGroup}>
                <label className={styles.formLabel}>Event Title</label>
                <input
                  type="text"
                  value={newEvent.title}
                  onChange={(e) => setNewEvent(prev => ({ ...prev, title: e.target.value }))}
                  placeholder="Enter event title"
                  className={styles.formInput}
                />
              </div>

              <div className={styles.formRow}>
                <div className={styles.formGroup}>
                  <label className={styles.formLabel}>Start Time</label>
                  <input
                    type="datetime-local"
                    value={newEvent.start}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, start: e.target.value }))}
                    className={styles.formInput}
                  />
                </div>
                <div className={styles.formGroup}>
                  <label className={styles.formLabel}>End Time</label>
                  <input
                    type="datetime-local"
                    value={newEvent.end}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, end: e.target.value }))}
                    className={styles.formInput}
                  />
                </div>
              </div>

              <div className={styles.formGroup}>
                <label className={styles.formLabel}>Category</label>
                <select 
                  value={newEvent.category}
                  onChange={(e) => setNewEvent(prev => ({ ...prev, category: e.target.value }))}
                  className={styles.formInput}
                >
                  {categories.map(category => (
                    <option key={category.id} value={category.id}>
                      {category.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className={styles.formRow}>
                <div className={styles.formGroup}>
                  <label className={styles.checkboxLabel}>
                    <input
                      type="checkbox"
                      checked={newEvent.recurring}
                      onChange={(e) => setNewEvent(prev => ({ ...prev, recurring: e.target.checked }))}
                    />
                    Recurring Event
                  </label>
                </div>
                <div className={styles.formGroup}>
                  <label className={styles.formLabel}>Reminder (minutes)</label>
                  <select 
                    value={newEvent.reminder}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, reminder: parseInt(e.target.value) }))}
                    className={styles.formInput}
                  >
                    <option value="5">5 minutes</option>
                    <option value="15">15 minutes</option>
                    <option value="30">30 minutes</option>
                    <option value="60">1 hour</option>
                  </select>
                </div>
              </div>
            </div>

            <div className={styles.formActions}>
              {selectedEvent && (
                <button onClick={handleDeleteEvent} className={styles.deleteBtn}>
                  Delete
                </button>
              )}
              <div className={styles.formActionsRight}>
                <button onClick={closeEventForm} className={styles.cancelBtn}>
                  Cancel
                </button>
                <button onClick={handleSaveEvent} className={styles.saveBtn}>
                  Save
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default CalendarApplication;

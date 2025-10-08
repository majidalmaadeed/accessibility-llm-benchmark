import React, { useState, useEffect } from 'react';
import './CalendarApplication.css';

const CalendarApplication = () => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [view, setView] = useState('month'); // month, week, day
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

  const timeSlots = Array.from({ length: 24 }, (_, i) => {
    const hour = i;
    return `${hour.toString().padStart(2, '0')}:00`;
  });

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
      const eventDate = new Date(event.start);
      return eventDate.toDateString() === date.toDateString();
    });
  };

  const getEventsForWeek = (startDate) => {
    const weekEvents = [];
    for (let i = 0; i < 7; i++) {
      const date = new Date(startDate);
      date.setDate(startDate.getDate() + i);
      weekEvents.push(...getEventsForDate(date));
    }
    return weekEvents;
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

    setShowEventForm(false);
    setSelectedEvent(null);
    setSelectedDate(null);
  };

  const handleDeleteEvent = () => {
    if (selectedEvent) {
      setEvents(prev => prev.filter(event => event.id !== selectedEvent.id));
      setShowEventForm(false);
      setSelectedEvent(null);
    }
  };

  const navigateMonth = (direction) => {
    setCurrentDate(prev => {
      const newDate = new Date(prev);
      newDate.setMonth(prev.getMonth() + direction);
      return newDate;
    });
  };

  const navigateWeek = (direction) => {
    setCurrentDate(prev => {
      const newDate = new Date(prev);
      newDate.setDate(prev.getDate() + (direction * 7));
      return newDate;
    });
  };

  const navigateDay = (direction) => {
    setCurrentDate(prev => {
      const newDate = new Date(prev);
      newDate.setDate(prev.getDate() + direction);
      return newDate;
    });
  };

  const renderMonthView = () => {
    const days = getDaysInMonth(currentDate);
    const monthName = currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });

    return (
      <div className="month-view">
        <div className="calendar-header">
          <h2>{monthName}</h2>
          <div className="navigation">
            <button onClick={() => navigateMonth(-1)}>‹</button>
            <button onClick={() => setCurrentDate(new Date())}>Today</button>
            <button onClick={() => navigateMonth(1)}>›</button>
          </div>
        </div>

        <div className="calendar-grid">
          <div className="day-headers">
            {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
              <div key={day} className="day-header">{day}</div>
            ))}
          </div>
          
          <div className="days-grid">
            {days.map((day, index) => {
              const dayEvents = getEventsForDate(day);
              const isToday = day && day.toDateString() === new Date().toDateString();
              const isCurrentMonth = day && day.getMonth() === currentDate.getMonth();

              return (
                <div
                  key={index}
                  className={`day-cell ${isToday ? 'today' : ''} ${!isCurrentMonth ? 'other-month' : ''}`}
                  onClick={() => day && handleDateClick(day)}
                >
                  {day && (
                    <>
                      <div className="day-number">{day.getDate()}</div>
                      <div className="day-events">
                        {dayEvents.slice(0, 3).map(event => (
                          <div
                            key={event.id}
                            className={`event-dot ${event.category}`}
                            onClick={(e) => {
                              e.stopPropagation();
                              handleEventClick(event);
                            }}
                          >
                            {event.title}
                          </div>
                        ))}
                        {dayEvents.length > 3 && (
                          <div className="more-events">+{dayEvents.length - 3} more</div>
                        )}
                      </div>
                    </>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  };

  const renderWeekView = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());
    const weekEvents = getEventsForWeek(startOfWeek);

    return (
      <div className="week-view">
        <div className="calendar-header">
          <h2>Week of {startOfWeek.toLocaleDateString()}</h2>
          <div className="navigation">
            <button onClick={() => navigateWeek(-1)}>‹</button>
            <button onClick={() => setCurrentDate(new Date())}>Today</button>
            <button onClick={() => navigateWeek(1)}>›</button>
          </div>
        </div>

        <div className="week-grid">
          <div className="time-column">
            {timeSlots.map(time => (
              <div key={time} className="time-slot">{time}</div>
            ))}
          </div>
          
          {Array.from({ length: 7 }, (_, i) => {
            const date = new Date(startOfWeek);
            date.setDate(startOfWeek.getDate() + i);
            const dayEvents = getEventsForDate(date);
            const isToday = date.toDateString() === new Date().toDateString();

            return (
              <div key={i} className={`day-column ${isToday ? 'today' : ''}`}>
                <div className="day-header">
                  <div className="day-name">{date.toLocaleDateString('en-US', { weekday: 'short' })}</div>
                  <div className="day-number">{date.getDate()}</div>
                </div>
                
                <div className="day-events">
                  {dayEvents.map(event => (
                    <div
                      key={event.id}
                      className={`event-block ${event.category}`}
                      style={{
                        top: `${(event.start.getHours() + event.start.getMinutes() / 60) * 40}px`,
                        height: `${((event.end - event.start) / (1000 * 60 * 60)) * 40}px`
                      }}
                      onClick={() => handleEventClick(event)}
                    >
                      {event.title}
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    );
  };

  const renderDayView = () => {
    const dayEvents = getEventsForDate(currentDate);

    return (
      <div className="day-view">
        <div className="calendar-header">
          <h2>{currentDate.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' })}</h2>
          <div className="navigation">
            <button onClick={() => navigateDay(-1)}>‹</button>
            <button onClick={() => setCurrentDate(new Date())}>Today</button>
            <button onClick={() => navigateDay(1)}>›</button>
          </div>
        </div>

        <div className="day-grid">
          <div className="time-column">
            {timeSlots.map(time => (
              <div key={time} className="time-slot">{time}</div>
            ))}
          </div>
          
          <div className="day-events">
            {dayEvents.map(event => (
              <div
                key={event.id}
                className={`event-block ${event.category}`}
                style={{
                  top: `${(event.start.getHours() + event.start.getMinutes() / 60) * 40}px`,
                  height: `${((event.end - event.start) / (1000 * 60 * 60)) * 40}px`
                }}
                onClick={() => handleEventClick(event)}
              >
                <div className="event-title">{event.title}</div>
                <div className="event-time">
                  {event.start.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })} - 
                  {event.end.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  };

  const filteredEvents = categoryFilter === 'all' 
    ? events 
    : events.filter(event => event.category === categoryFilter);

  return (
    <div className="calendar-application">
      <div className="calendar-toolbar">
        <div className="view-controls">
          <button 
            className={view === 'month' ? 'active' : ''}
            onClick={() => setView('month')}
          >
            Month
          </button>
          <button 
            className={view === 'week' ? 'active' : ''}
            onClick={() => setView('week')}
          >
            Week
          </button>
          <button 
            className={view === 'day' ? 'active' : ''}
            onClick={() => setView('day')}
          >
            Day
          </button>
        </div>

        <div className="toolbar-actions">
          <button 
            className="new-event-btn"
            onClick={() => setShowEventForm(true)}
          >
            + New Event
          </button>
          
          <div className="category-filter">
            <button 
              onClick={() => setShowCategoryFilter(!showCategoryFilter)}
              className="filter-btn"
            >
              Filter: {categoryFilter === 'all' ? 'All' : categories.find(c => c.id === categoryFilter)?.name}
            </button>
            
            {showCategoryFilter && (
              <div className="category-dropdown">
                <button 
                  className={categoryFilter === 'all' ? 'active' : ''}
                  onClick={() => setCategoryFilter('all')}
                >
                  All Categories
                </button>
                {categories.map(category => (
                  <button
                    key={category.id}
                    className={categoryFilter === category.id ? 'active' : ''}
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

      <div className="calendar-content">
        {view === 'month' && renderMonthView()}
        {view === 'week' && renderWeekView()}
        {view === 'day' && renderDayView()}
      </div>

      {showEventForm && (
        <div className="event-form-overlay">
          <div className="event-form">
            <div className="form-header">
              <h3>{selectedEvent ? 'Edit Event' : 'New Event'}</h3>
              <button 
                onClick={() => setShowEventForm(false)}
                className="close-btn"
              >
                ✕
              </button>
            </div>

            <div className="form-content">
              <div className="form-group">
                <label>Event Title</label>
                <input
                  type="text"
                  value={newEvent.title}
                  onChange={(e) => setNewEvent(prev => ({ ...prev, title: e.target.value }))}
                  placeholder="Enter event title"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Start Time</label>
                  <input
                    type="datetime-local"
                    value={newEvent.start}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, start: e.target.value }))}
                  />
                </div>
                <div className="form-group">
                  <label>End Time</label>
                  <input
                    type="datetime-local"
                    value={newEvent.end}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, end: e.target.value }))}
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Category</label>
                <select
                  value={newEvent.category}
                  onChange={(e) => setNewEvent(prev => ({ ...prev, category: e.target.value }))}
                >
                  {categories.map(category => (
                    <option key={category.id} value={category.id}>
                      {category.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>
                    <input
                      type="checkbox"
                      checked={newEvent.recurring}
                      onChange={(e) => setNewEvent(prev => ({ ...prev, recurring: e.target.checked }))}
                    />
                    Recurring Event
                  </label>
                </div>
                <div className="form-group">
                  <label>Reminder (minutes)</label>
                  <select
                    value={newEvent.reminder}
                    onChange={(e) => setNewEvent(prev => ({ ...prev, reminder: parseInt(e.target.value) }))}
                  >
                    <option value={5}>5 minutes</option>
                    <option value={15}>15 minutes</option>
                    <option value={30}>30 minutes</option>
                    <option value={60}>1 hour</option>
                  </select>
                </div>
              </div>
            </div>

            <div className="form-actions">
              {selectedEvent && (
                <button 
                  onClick={handleDeleteEvent}
                  className="delete-btn"
                >
                  Delete
                </button>
              )}
              <div className="form-actions-right">
                <button 
                  onClick={() => setShowEventForm(false)}
                  className="cancel-btn"
                >
                  Cancel
                </button>
                <button 
                  onClick={handleSaveEvent}
                  className="save-btn"
                >
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

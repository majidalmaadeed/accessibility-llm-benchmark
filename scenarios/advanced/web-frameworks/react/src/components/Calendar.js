import React, { useState } from 'react';

const Calendar = () => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState(null);
  const [events, setEvents] = useState([
    { id: 1, title: 'Team Meeting', date: '2024-01-15', time: '10:00 AM', type: 'meeting' },
    { id: 2, title: 'Project Deadline', date: '2024-01-20', time: '5:00 PM', type: 'deadline' },
    { id: 3, title: 'Client Call', date: '2024-01-22', time: '2:00 PM', type: 'call' },
    { id: 4, title: 'Workshop', date: '2024-01-25', time: '9:00 AM', type: 'workshop' }
  ]);
  const [showEventModal, setShowEventModal] = useState(false);
  const [newEvent, setNewEvent] = useState({
    title: '',
    date: '',
    time: '',
    type: 'meeting',
    description: ''
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
    const dateStr = date.toISOString().split('T')[0];
    return events.filter(event => event.date === dateStr);
  };

  const navigateMonth = (direction) => {
    setCurrentDate(prev => {
      const newDate = new Date(prev);
      newDate.setMonth(prev.getMonth() + direction);
      return newDate;
    });
  };

  const handleDateClick = (date) => {
    setSelectedDate(date);
    setNewEvent({
      title: '',
      date: date.toISOString().split('T')[0],
      time: '',
      type: 'meeting',
      description: ''
    });
    setShowEventModal(true);
  };

  const addEvent = () => {
    if (newEvent.title && newEvent.date && newEvent.time) {
      const event = {
        id: Date.now(),
        ...newEvent
      };
      setEvents([...events, event]);
      setShowEventModal(false);
      setNewEvent({ title: '', date: '', time: '', type: 'meeting', description: '' });
    }
  };

  const deleteEvent = (eventId) => {
    setEvents(events.filter(event => event.id !== eventId));
  };

  const getEventTypeColor = (type) => {
    const colors = {
      meeting: '#007bff',
      deadline: '#dc3545',
      call: '#28a745',
      workshop: '#ffc107'
    };
    return colors[type] || '#6c757d';
  };

  const monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  const days = getDaysInMonth(currentDate);

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Calendar Application</h1>
        <p className="page-subtitle">
          Calendar application with events
        </p>
      </div>

      <div className="grid grid-2">
        <div className="card">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
            <h2>{monthNames[currentDate.getMonth()]} {currentDate.getFullYear()}</h2>
            <div style={{ display: 'flex', gap: '0.5rem' }}>
              <button className="btn btn-secondary" onClick={() => navigateMonth(-1)}>
                ←
              </button>
              <button className="btn btn-secondary" onClick={() => setCurrentDate(new Date())}>
                Today
              </button>
              <button className="btn btn-secondary" onClick={() => navigateMonth(1)}>
                →
              </button>
            </div>
          </div>

          <div className="calendar-grid">
            {dayNames.map(day => (
              <div key={day} style={{ 
                padding: '1rem', 
                textAlign: 'center', 
                fontWeight: 'bold', 
                backgroundColor: '#f8f9fa',
                borderBottom: '1px solid #ddd'
              }}>
                {day}
              </div>
            ))}
            {days.map((day, index) => {
              const dayEvents = getEventsForDate(day);
              const isToday = day && day.toDateString() === new Date().toDateString();
              const isSelected = day && selectedDate && day.toDateString() === selectedDate.toDateString();
              
              return (
                <div
                  key={index}
                  className={`calendar-day ${isToday ? 'today' : ''} ${isSelected ? 'selected' : ''}`}
                  onClick={() => day && handleDateClick(day)}
                  style={{ cursor: day ? 'pointer' : 'default' }}
                >
                  {day && (
                    <>
                      <div className="calendar-day-number">{day.getDate()}</div>
                      {dayEvents.slice(0, 2).map(event => (
                        <div
                          key={event.id}
                          className="calendar-event"
                          style={{ 
                            backgroundColor: getEventTypeColor(event.type),
                            color: 'white',
                            fontSize: '0.7rem',
                            padding: '0.2rem',
                            margin: '0.1rem 0',
                            borderRadius: '3px',
                            overflow: 'hidden',
                            textOverflow: 'ellipsis',
                            whiteSpace: 'nowrap'
                          }}
                        >
                          {event.title}
                        </div>
                      ))}
                      {dayEvents.length > 2 && (
                        <div style={{ 
                          fontSize: '0.7rem', 
                          color: '#666',
                          marginTop: '0.1rem'
                        }}>
                          +{dayEvents.length - 2} more
                        </div>
                      )}
                    </>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        <div className="card">
          <h2>Upcoming Events</h2>
          <div style={{ maxHeight: '400px', overflowY: 'auto' }}>
            {events
              .sort((a, b) => new Date(a.date + ' ' + a.time) - new Date(b.date + ' ' + b.time))
              .map(event => (
                <div key={event.id} style={{ 
                  padding: '0.75rem', 
                  borderBottom: '1px solid #eee',
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center'
                }}>
                  <div>
                    <div style={{ fontWeight: '600', marginBottom: '0.25rem' }}>
                      {event.title}
                    </div>
                    <div style={{ fontSize: '0.9rem', color: '#666' }}>
                      {new Date(event.date).toLocaleDateString()} at {event.time}
                    </div>
                    <div style={{ 
                      fontSize: '0.8rem', 
                      color: getEventTypeColor(event.type),
                      textTransform: 'capitalize',
                      marginTop: '0.25rem'
                    }}>
                      {event.type}
                    </div>
                  </div>
                  <button
                    className="btn btn-secondary"
                    onClick={() => deleteEvent(event.id)}
                    style={{ padding: '0.25rem 0.5rem', fontSize: '0.8rem' }}
                  >
                    Delete
                  </button>
                </div>
              ))}
          </div>
        </div>
      </div>

      {showEventModal && (
        <div className="modal">
          <div className="modal-content">
            <div className="modal-header">
              <h3 className="modal-title">Add Event</h3>
              <button className="modal-close" onClick={() => setShowEventModal(false)}>
                ×
              </button>
            </div>
            <div className="form-group">
              <label className="form-label">Event Title</label>
              <input
                type="text"
                className="form-control"
                value={newEvent.title}
                onChange={(e) => setNewEvent({...newEvent, title: e.target.value})}
                placeholder="Enter event title"
              />
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Date</label>
                <input
                  type="date"
                  className="form-control"
                  value={newEvent.date}
                  onChange={(e) => setNewEvent({...newEvent, date: e.target.value})}
                />
              </div>
              <div className="form-group">
                <label className="form-label">Time</label>
                <input
                  type="time"
                  className="form-control"
                  value={newEvent.time}
                  onChange={(e) => setNewEvent({...newEvent, time: e.target.value})}
                />
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Event Type</label>
              <select
                className="form-control"
                value={newEvent.type}
                onChange={(e) => setNewEvent({...newEvent, type: e.target.value})}
              >
                <option value="meeting">Meeting</option>
                <option value="deadline">Deadline</option>
                <option value="call">Call</option>
                <option value="workshop">Workshop</option>
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Description</label>
              <textarea
                className="form-control"
                rows="3"
                value={newEvent.description}
                onChange={(e) => setNewEvent({...newEvent, description: e.target.value})}
                placeholder="Enter event description"
              />
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowEventModal(false)}>
                Cancel
              </button>
              <button className="btn" onClick={addEvent}>
                Add Event
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Calendar;

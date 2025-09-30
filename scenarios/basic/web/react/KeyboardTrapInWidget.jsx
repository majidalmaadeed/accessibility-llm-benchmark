import React, { useState, useEffect } from 'react';

const KeyboardTrapInWidget = () => {
  const [isDatePickerOpen, setIsDatePickerOpen] = useState(false);
  const [selectedDate, setSelectedDate] = useState('');
  const [currentMonth, setCurrentMonth] = useState(new Date());
  const [focusedDate, setFocusedDate] = useState(null);

  const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  const getCalendarDays = () => {
    const daysInMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 0).getDate();
    const firstDay = new Date(currentMonth.getFullYear(), currentMonth.getMonth(), 1).getDay();
    const days = [];
    
    // Add empty cells for days before the first day of the month
    for (let i = 0; i < firstDay; i++) {
      days.push(null);
    }
    
    // Add days of the month
    for (let day = 1; day <= daysInMonth; day++) {
      days.push(day);
    }
    
    return days;
  };

  const getCurrentMonthText = () => {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return `${months[currentMonth.getMonth()]} ${currentMonth.getFullYear()}`;
  };

  const toggleDatePicker = () => {
    setIsDatePickerOpen(!isDatePickerOpen);
  };

  const selectDate = (day) => {
    if (day) {
      const date = new Date(currentMonth.getFullYear(), currentMonth.getMonth(), day);
      setSelectedDate(date.toLocaleDateString());
      setIsDatePickerOpen(false);
      setFocusedDate(null);
    }
  };

  const navigateMonth = (direction) => {
    setCurrentMonth(new Date(currentMonth.getFullYear(), currentMonth.getMonth() + direction));
  };

  const handleKeyDown = (e) => {
    if (!isDatePickerOpen) return;
    
    const days = getCalendarDays();
    const currentIndex = focusedDate ? days.indexOf(focusedDate) : -1;
    let newIndex = currentIndex;
    
    switch (e.key) {
      case 'ArrowRight':
        e.preventDefault();
        newIndex = Math.min(currentIndex + 1, days.length - 1);
        break;
      case 'ArrowLeft':
        e.preventDefault();
        newIndex = Math.max(currentIndex - 1, 0);
        break;
      case 'ArrowDown':
        e.preventDefault();
        newIndex = Math.min(currentIndex + 7, days.length - 1);
        break;
      case 'ArrowUp':
        e.preventDefault();
        newIndex = Math.max(currentIndex - 7, 0);
        break;
      case 'Enter':
      case ' ':
        e.preventDefault();
        if (focusedDate) {
          selectDate(focusedDate);
        }
        break;
      case 'Escape':
        e.preventDefault();
        setIsDatePickerOpen(false);
        setFocusedDate(null);
        break;
      case 'Tab':
        // Prevent tab from escaping the date picker
        e.preventDefault();
        break;
    }
    
    if (newIndex !== currentIndex && days[newIndex] !== null) {
      setFocusedDate(days[newIndex]);
    }
  };

  useEffect(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [isDatePickerOpen, focusedDate, currentMonth]);

  return (
    <div style={{ 
      maxWidth: '600px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Event Planning Form</h1>
      <p>Create a new event by filling out the form below.</p>
      
      <form style={{
        background: 'white',
        padding: '30px',
        borderRadius: '8px',
        boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
        border: '1px solid #e0e0e0'
      }}>
        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Event Name *
          </label>
          <input
            type="text"
            required
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box'
            }}
          />
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Event Date *
          </label>
          <div style={{ position: 'relative', display: 'inline-block' }}>
            <input
              type="text"
              value={selectedDate}
              readOnly
              onClick={toggleDatePicker}
              placeholder="Select a date"
              style={{
                width: '300px',
                padding: '12px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                fontSize: '16px',
                boxSizing: 'border-box',
                cursor: 'pointer',
                background: 'white'
              }}
            />
            
            {/* Custom date picker traps keyboard focus inside */}
            {isDatePickerOpen && (
              <div 
                tabIndex="-1"
                style={{
                  position: 'absolute',
                  top: '100%',
                  left: 0,
                  right: 0,
                  background: 'white',
                  border: '1px solid #ddd',
                  borderRadius: '4px',
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                  zIndex: 1000,
                  padding: '20px'
                }}
              >
                <div style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                  marginBottom: '15px'
                }}>
                  <button 
                    type="button" 
                    onClick={() => navigateMonth(-1)}
                    style={{
                      background: 'transparent',
                      border: 'none',
                      fontSize: '18px',
                      cursor: 'pointer',
                      padding: '5px'
                    }}
                  >
                    ‹
                  </button>
                  <h3 style={{ margin: 0, fontSize: '16px' }}>
                    {getCurrentMonthText()}
                  </h3>
                  <button 
                    type="button" 
                    onClick={() => navigateMonth(1)}
                    style={{
                      background: 'transparent',
                      border: 'none',
                      fontSize: '18px',
                      cursor: 'pointer',
                      padding: '5px'
                    }}
                  >
                    ›
                  </button>
                </div>
                
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(7, 1fr)',
                  gap: '2px',
                  marginBottom: '10px'
                }}>
                  {weekdays.map(day => (
                    <div key={day} style={{
                      padding: '8px',
                      textAlign: 'center',
                      fontSize: '12px',
                      fontWeight: 'bold',
                      color: '#666'
                    }}>
                      {day}
                    </div>
                  ))}
                </div>
                
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(7, 1fr)',
                  gap: '2px'
                }}>
                  {getCalendarDays().map((day, index) => (
                    <button
                      key={index}
                      type="button"
                      onClick={() => selectDate(day)}
                      disabled={!day}
                      style={{
                        padding: '8px',
                        border: 'none',
                        background: focusedDate === day ? '#007bff' : '#f8f9fa',
                        color: focusedDate === day ? 'white' : '#333',
                        cursor: day ? 'pointer' : 'default',
                        borderRadius: '4px',
                        fontSize: '14px'
                      }}
                    >
                      {day}
                    </button>
                  ))}
                </div>
                
                <div style={{
                  marginTop: '15px',
                  padding: '10px',
                  background: '#f8f9fa',
                  borderRadius: '4px',
                  fontSize: '12px',
                  color: '#666',
                  textAlign: 'center'
                }}>
                  Use arrow keys to navigate, Enter to select, Escape to close
                </div>
              </div>
            )}
          </div>
        </div>

        <div style={{ marginBottom: '25px' }}>
          <label style={{
            display: 'block',
            marginBottom: '5px',
            fontWeight: 'bold',
            color: '#333'
          }}>
            Event Description
          </label>
          <textarea
            rows="4"
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              boxSizing: 'border-box',
              resize: 'vertical'
            }}
          />
        </div>

        <div style={{
          display: 'flex',
          gap: '15px',
          justifyContent: 'flex-end'
        }}>
          <button
            type="button"
            style={{
              background: '#6c757d',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '16px'
            }}
          >
            Cancel
          </button>
          <button
            type="submit"
            style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '16px'
            }}
          >
            Create Event
          </button>
        </div>
      </form>
    </div>
  );
};

export default KeyboardTrapInWidget;

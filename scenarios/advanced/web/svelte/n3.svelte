<script>
  import { onMount } from 'svelte';
  
  let currentDate = new Date();
  let selectedDate = null;
  let viewMode = 'month';
  let showEventForm = false;
  let showEventDetails = false;
  let selectedEvent = null;
  let events = [];
  let newEvent = {
    title: '',
    description: '',
    startTime: '',
    endTime: '',
    date: '',
    category: 'meeting',
    recurring: false,
    reminder: false,
    reminderTime: '15'
  };
  let filters = {
    category: 'all',
    search: ''
  };

  const categories = [
    { value: 'meeting', label: 'Meeting', color: '#4caf50' },
    { value: 'personal', label: 'Personal', color: '#2196f3' },
    { value: 'work', label: 'Work', color: '#ff9800' },
    { value: 'health', label: 'Health', color: '#f44336' },
    { value: 'social', label: 'Social', color: '#9c27b0' }
  ];

  const reminderOptions = [
    { value: '5', label: '5 minutes before' },
    { value: '15', label: '15 minutes before' },
    { value: '30', label: '30 minutes before' },
    { value: '60', label: '1 hour before' },
    { value: '1440', label: '1 day before' }
  ];

  onMount(() => {
    loadEvents();
    generateSampleEvents();
  });

  function loadEvents() {
    const saved = localStorage.getItem('calendarEvents');
    if (saved) {
      events = JSON.parse(saved);
    }
  }

  function saveEvents() {
    localStorage.setItem('calendarEvents', JSON.stringify(events));
  }

  function generateSampleEvents() {
    if (events.length === 0) {
      const today = new Date();
      const sampleEvents = [
        {
          id: 1,
          title: 'Team Meeting',
          description: 'Weekly team standup',
          startTime: '09:00',
          endTime: '10:00',
          date: formatDate(today),
          category: 'meeting',
          recurring: true,
          reminder: true,
          reminderTime: '15'
        },
        {
          id: 2,
          title: 'Doctor Appointment',
          description: 'Annual checkup',
          startTime: '14:00',
          endTime: '15:00',
          date: formatDate(new Date(today.getTime() + 24 * 60 * 60 * 1000)),
          category: 'health',
          recurring: false,
          reminder: true,
          reminderTime: '30'
        },
        {
          id: 3,
          title: 'Project Deadline',
          description: 'Submit final report',
          startTime: '17:00',
          endTime: '18:00',
          date: formatDate(new Date(today.getTime() + 7 * 24 * 60 * 60 * 1000)),
          category: 'work',
          recurring: false,
          reminder: true,
          reminderTime: '60'
        }
      ];
      events = sampleEvents;
      saveEvents();
    }
  }

  function formatDate(date) {
    return date.toISOString().split('T')[0];
  }

  function formatTime(time) {
    return time;
  }

  function getMonthName(month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  function getDayName(day) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[day];
  }

  function getDaysInMonth(date) {
    return new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
  }

  function getFirstDayOfMonth(date) {
    return new Date(date.getFullYear(), date.getMonth(), 1).getDay();
  }

  function getCalendarDays() {
    const days = [];
    const daysInMonth = getDaysInMonth(currentDate);
    const firstDay = getFirstDayOfMonth(currentDate);
    
    for (let i = 0; i < firstDay; i++) {
      days.push(null);
    }
    
    for (let i = 1; i <= daysInMonth; i++) {
      days.push(i);
    }
    
    return days;
  }

  function getEventsForDate(date) {
    const dateStr = formatDate(new Date(currentDate.getFullYear(), currentDate.getMonth(), date));
    return events.filter(event => event.date === dateStr);
  }

  function getEventsForToday() {
    const today = formatDate(new Date());
    return events.filter(event => event.date === today);
  }

  function getUpcomingEvents() {
    const today = new Date();
    return events
      .filter(event => new Date(event.date) >= today)
      .sort((a, b) => new Date(a.date) - new Date(b.date))
      .slice(0, 5);
  }

  function handleDateClick(date) {
    selectedDate = date;
    newEvent.date = formatDate(new Date(currentDate.getFullYear(), currentDate.getMonth(), date));
    showEventForm = true;
  }

  function handleEventClick(event) {
    selectedEvent = event;
    showEventDetails = true;
  }

  function handleCreateEvent() {
    if (!newEvent.title.trim()) {
      alert('Please enter an event title');
      return;
    }

    const event = {
      id: Date.now(),
      ...newEvent,
      startTime: newEvent.startTime || '09:00',
      endTime: newEvent.endTime || '10:00'
    };

    events = [...events, event];
    saveEvents();
    resetEventForm();
    showEventForm = false;
  }

  function handleDeleteEvent(eventId) {
    events = events.filter(event => event.id !== eventId);
    saveEvents();
    showEventDetails = false;
    selectedEvent = null;
  }

  function handleEditEvent() {
    if (selectedEvent) {
      newEvent = { ...selectedEvent };
      showEventDetails = false;
      showEventForm = true;
    }
  }

  function resetEventForm() {
    newEvent = {
      title: '',
      description: '',
      startTime: '',
      endTime: '',
      date: '',
      category: 'meeting',
      recurring: false,
      reminder: false,
      reminderTime: '15'
    };
  }

  function navigateMonth(direction) {
    currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + direction, 1);
  }

  function navigateToToday() {
    currentDate = new Date();
  }

  function getCategoryColor(category) {
    const cat = categories.find(c => c.value === category);
    return cat ? cat.color : '#666';
  }

  function getCategoryLabel(category) {
    const cat = categories.find(c => c.value === category);
    return cat ? cat.label : category;
  }

  function getReminderLabel(time) {
    const option = reminderOptions.find(r => r.value === time);
    return option ? option.label : `${time} minutes before`;
  }

  function getFilteredEvents() {
    let filtered = events;

    if (filters.category !== 'all') {
      filtered = filtered.filter(event => event.category === filters.category);
    }

    if (filters.search) {
      filtered = filtered.filter(event => 
        event.title.toLowerCase().includes(filters.search.toLowerCase()) ||
        event.description.toLowerCase().includes(filters.search.toLowerCase())
      );
    }

    return filtered;
  }

  function getEventTimeRange(event) {
    return `${event.startTime} - ${event.endTime}`;
  }

  function isToday(date) {
    const today = new Date();
    return date === today.getDate() && 
           currentDate.getMonth() === today.getMonth() && 
           currentDate.getFullYear() === today.getFullYear();
  }

  function isSelected(date) {
    return selectedDate === date;
  }
</script>

<div class="calendar-app">
  <div class="calendar-header">
    <h1>Calendar Application</h1>
    <div class="header-controls">
      <div class="view-controls">
        <button 
          on:click={() => viewMode = 'month'}
          class="view-btn"
          class:active={viewMode === 'month'}
        >
          Month
        </button>
        <button 
          on:click={() => viewMode = 'week'}
          class="view-btn"
          class:active={viewMode === 'week'}
        >
          Week
        </button>
        <button 
          on:click={() => viewMode = 'day'}
          class="view-btn"
          class:active={viewMode === 'day'}
        >
          Day
        </button>
      </div>
      
      <div class="navigation-controls">
        <button 
          on:click={() => navigateMonth(-1)}
          class="nav-btn"
        >
          ←
        </button>
        <button 
          on:click={navigateToToday}
          class="today-btn"
        >
          Today
        </button>
        <button 
          on:click={() => navigateMonth(1)}
          class="nav-btn"
        >
          →
        </button>
      </div>
    </div>
  </div>

  <div class="calendar-content">
    <div class="calendar-main">
      <div class="calendar-header-info">
        <h2>{getMonthName(currentDate.getMonth())} {currentDate.getFullYear()}</h2>
        <button 
          on:click={() => showEventForm = true}
          class="add-event-btn"
        >
          + Add Event
        </button>
      </div>

      <div class="calendar-grid">
        <div class="calendar-days-header">
          {#each ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'] as day}
            <div class="day-header">{day}</div>
          {/each}
        </div>

        <div class="calendar-days">
          {#each getCalendarDays() as day}
            {#if day}
              <div 
                class="calendar-day"
                class:today={isToday(day)}
                class:selected={isSelected(day)}
                on:click={() => handleDateClick(day)}
              >
                <div class="day-number">{day}</div>
                <div class="day-events">
                  {#each getEventsForDate(day) as event}
                    <div 
                      class="event-item"
                      style="background-color: {getCategoryColor(event.category)}"
                      on:click|stopPropagation={() => handleEventClick(event)}
                    >
                      <span class="event-time">{event.startTime}</span>
                      <span class="event-title">{event.title}</span>
                    </div>
                  {/each}
                </div>
              </div>
            {:else}
              <div class="calendar-day empty"></div>
            {/if}
          {/each}
        </div>
      </div>
    </div>

    <div class="calendar-sidebar">
      <div class="sidebar-section">
        <h3>Today's Events</h3>
        <div class="events-list">
          {#each getEventsForToday() as event}
            <div 
              class="event-item-sidebar"
              on:click={() => handleEventClick(event)}
            >
              <div 
                class="event-color"
                style="background-color: {getCategoryColor(event.category)}"
              />
              <div class="event-info">
                <div class="event-title">{event.title}</div>
                <div class="event-time">{getEventTimeRange(event)}</div>
              </div>
            </div>
          {/each}
          {#if getEventsForToday().length === 0}
            <p class="no-events">No events today</p>
          {/if}
        </div>
      </div>

      <div class="sidebar-section">
        <h3>Upcoming Events</h3>
        <div class="events-list">
          {#each getUpcomingEvents() as event}
            <div 
              class="event-item-sidebar"
              on:click={() => handleEventClick(event)}
            >
              <div 
                class="event-color"
                style="background-color: {getCategoryColor(event.category)}"
              />
              <div class="event-info">
                <div class="event-title">{event.title}</div>
                <div class="event-date">{event.date}</div>
                <div class="event-time">{getEventTimeRange(event)}</div>
              </div>
            </div>
          {/each}
        </div>
      </div>

      <div class="sidebar-section">
        <h3>Filters</h3>
        <div class="filter-controls">
          <select bind:value={filters.category} class="filter-select">
            <option value="all">All Categories</option>
            {#each categories as category}
              <option value={category.value}>{category.label}</option>
            {/each}
          </select>
          
          <input
            type="text"
            bind:value={filters.search}
            placeholder="Search events..."
            class="filter-input"
          />
        </div>
      </div>
    </div>
  </div>

  {#if showEventForm}
    <div class="modal-overlay">
      <div class="event-form">
        <div class="form-header">
          <h3>{selectedEvent ? 'Edit Event' : 'Create New Event'}</h3>
          <button 
            on:click={() => { showEventForm = false; resetEventForm(); }}
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="form-content">
          <div class="form-group">
            <label class="form-label">Event Title</label>
            <input
              type="text"
              bind:value={newEvent.title}
              placeholder="Enter event title"
              class="form-input"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Description</label>
            <textarea
              bind:value={newEvent.description}
              placeholder="Enter event description"
              class="form-textarea"
            />
          </div>
          
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Date</label>
              <input
                type="date"
                bind:value={newEvent.date}
                class="form-input"
              />
            </div>
            
            <div class="form-group">
              <label class="form-label">Category</label>
              <select bind:value={newEvent.category} class="form-input">
                {#each categories as category}
                  <option value={category.value}>{category.label}</option>
                {/each}
              </select>
            </div>
          </div>
          
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Start Time</label>
              <input
                type="time"
                bind:value={newEvent.startTime}
                class="form-input"
              />
            </div>
            
            <div class="form-group">
              <label class="form-label">End Time</label>
              <input
                type="time"
                bind:value={newEvent.endTime}
                class="form-input"
              />
            </div>
          </div>
          
          <div class="form-group">
            <label class="checkbox-label">
              <input
                type="checkbox"
                bind:checked={newEvent.recurring}
              />
              Recurring Event
            </label>
          </div>
          
          <div class="form-group">
            <label class="checkbox-label">
              <input
                type="checkbox"
                bind:checked={newEvent.reminder}
              />
              Set Reminder
            </label>
          </div>
          
          {#if newEvent.reminder}
            <div class="form-group">
              <label class="form-label">Reminder Time</label>
              <select bind:value={newEvent.reminderTime} class="form-input">
                {#each reminderOptions as option}
                  <option value={option.value}>{option.label}</option>
                {/each}
              </select>
            </div>
          {/if}
        </div>
        
        <div class="form-actions">
          <button 
            on:click={() => { showEventForm = false; resetEventForm(); }}
            class="btn-secondary"
          >
            Cancel
          </button>
          <button 
            on:click={handleCreateEvent}
            class="btn-primary"
          >
            {selectedEvent ? 'Update Event' : 'Create Event'}
          </button>
        </div>
      </div>
    </div>
  {/if}

  {#if showEventDetails && selectedEvent}
    <div class="modal-overlay">
      <div class="event-details">
        <div class="details-header">
          <h3>{selectedEvent.title}</h3>
          <button 
            on:click={() => { showEventDetails = false; selectedEvent = null; }}
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="details-content">
          <div class="detail-item">
            <strong>Date:</strong> {selectedEvent.date}
          </div>
          <div class="detail-item">
            <strong>Time:</strong> {getEventTimeRange(selectedEvent)}
          </div>
          <div class="detail-item">
            <strong>Category:</strong> 
            <span 
              class="category-badge"
              style="background-color: {getCategoryColor(selectedEvent.category)}"
            >
              {getCategoryLabel(selectedEvent.category)}
            </span>
          </div>
          {#if selectedEvent.description}
            <div class="detail-item">
              <strong>Description:</strong> {selectedEvent.description}
            </div>
          {/if}
          {#if selectedEvent.recurring}
            <div class="detail-item">
              <strong>Recurring:</strong> Yes
            </div>
          {/if}
          {#if selectedEvent.reminder}
            <div class="detail-item">
              <strong>Reminder:</strong> {getReminderLabel(selectedEvent.reminderTime)}
            </div>
          {/if}
        </div>
        
        <div class="details-actions">
          <button 
            on:click={handleEditEvent}
            class="btn-secondary"
          >
            Edit
          </button>
          <button 
            on:click={() => handleDeleteEvent(selectedEvent.id)}
            class="btn-danger"
          >
            Delete
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .calendar-app {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: #f5f5f5;
    min-height: 100vh;
  }

  .calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .calendar-header h1 {
    margin: 0;
    color: #333;
    font-size: 28px;
  }

  .header-controls {
    display: flex;
    gap: 20px;
    align-items: center;
  }

  .view-controls {
    display: flex;
    gap: 5px;
  }

  .view-btn {
    padding: 8px 16px;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: all 0.3s ease;
  }

  .view-btn:hover {
    background: #e0e0e0;
  }

  .view-btn.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .navigation-controls {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .nav-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 50%;
    cursor: pointer;
    font-size: 18px;
    color: #333;
    transition: all 0.3s ease;
  }

  .nav-btn:hover {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .today-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .today-btn:hover {
    background: #45a049;
  }

  .calendar-content {
    display: grid;
    grid-template-columns: 1fr 300px;
    gap: 20px;
  }

  .calendar-main {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }

  .calendar-header-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #e0e0e0;
  }

  .calendar-header-info h2 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .add-event-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .add-event-btn:hover {
    background: #45a049;
  }

  .calendar-grid {
    padding: 20px;
  }

  .calendar-days-header {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 1px;
    margin-bottom: 10px;
  }

  .day-header {
    padding: 10px;
    text-align: center;
    font-weight: 600;
    color: #666;
    background: #f8f9fa;
    border-radius: 4px;
  }

  .calendar-days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 1px;
    background: #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
  }

  .calendar-day {
    background: white;
    min-height: 120px;
    padding: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
  }

  .calendar-day:hover {
    background: #f8f9fa;
  }

  .calendar-day.today {
    background: #e3f2fd;
  }

  .calendar-day.selected {
    background: #4caf50;
    color: white;
  }

  .calendar-day.empty {
    background: #f8f9fa;
    cursor: default;
  }

  .day-number {
    font-weight: 600;
    margin-bottom: 5px;
  }

  .day-events {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  .event-item {
    padding: 2px 4px;
    border-radius: 3px;
    color: white;
    font-size: 10px;
    cursor: pointer;
    transition: opacity 0.3s ease;
  }

  .event-item:hover {
    opacity: 0.8;
  }

  .event-time {
    font-weight: 600;
    margin-right: 4px;
  }

  .event-title {
    font-weight: 500;
  }

  .calendar-sidebar {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .sidebar-section {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .sidebar-section h3 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 16px;
  }

  .events-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .event-item-sidebar {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .event-item-sidebar:hover {
    background: #f8f9fa;
    border-color: #4caf50;
  }

  .event-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    flex-shrink: 0;
  }

  .event-info {
    flex: 1;
    min-width: 0;
  }

  .event-title {
    font-weight: 600;
    color: #333;
    font-size: 14px;
    margin-bottom: 2px;
  }

  .event-time,
  .event-date {
    font-size: 12px;
    color: #666;
  }

  .no-events {
    text-align: center;
    color: #666;
    font-style: italic;
    padding: 20px;
  }

  .filter-controls {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .filter-select,
  .filter-input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
  }

  .filter-select:focus,
  .filter-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .event-form,
  .event-details {
    background: white;
    border-radius: 8px;
    width: 90%;
    max-width: 500px;
    max-height: 90vh;
    overflow-y: auto;
  }

  .form-header,
  .details-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #e0e0e0;
  }

  .form-header h3,
  .details-header h3 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }

  .close-btn {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: #666;
    padding: 4px;
  }

  .close-btn:hover {
    color: #333;
  }

  .form-content {
    padding: 20px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
  }

  .form-label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .form-input,
  .form-textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
    box-sizing: border-box;
  }

  .form-input:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #4caf50;
  }

  .form-textarea {
    min-height: 80px;
    resize: vertical;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
  }

  .checkbox-label input[type="checkbox"] {
    margin: 0;
  }

  .form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    padding: 20px;
    border-top: 1px solid #e0e0e0;
  }

  .btn-primary,
  .btn-secondary,
  .btn-danger {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .btn-primary {
    background: #4caf50;
    color: white;
  }

  .btn-primary:hover {
    background: #45a049;
  }

  .btn-secondary {
    background: #f5f5f5;
    color: #333;
    border: 1px solid #ddd;
  }

  .btn-secondary:hover {
    background: #e0e0e0;
  }

  .btn-danger {
    background: #f44336;
    color: white;
  }

  .btn-danger:hover {
    background: #d32f2f;
  }

  .details-content {
    padding: 20px;
  }

  .detail-item {
    margin-bottom: 15px;
    font-size: 14px;
  }

  .detail-item strong {
    color: #333;
    margin-right: 8px;
  }

  .category-badge {
    display: inline-block;
    padding: 2px 8px;
    border-radius: 4px;
    color: white;
    font-size: 12px;
    font-weight: 600;
  }

  .details-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    padding: 20px;
    border-top: 1px solid #e0e0e0;
  }

  @media (max-width: 768px) {
    .calendar-app {
      padding: 15px;
    }
    
    .calendar-header {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .header-controls {
      justify-content: center;
      flex-wrap: wrap;
    }
    
    .calendar-content {
      grid-template-columns: 1fr;
    }
    
    .calendar-sidebar {
      order: -1;
    }
    
    .calendar-day {
      min-height: 80px;
    }
    
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .event-form,
    .event-details {
      width: 95%;
    }
  }

  @media (max-width: 480px) {
    .calendar-app {
      padding: 10px;
    }
    
    .calendar-header {
      padding: 15px;
    }
    
    .calendar-grid {
      padding: 10px;
    }
    
    .calendar-day {
      min-height: 60px;
      padding: 4px;
    }
    
    .day-number {
      font-size: 12px;
    }
    
    .event-item {
      font-size: 8px;
    }
    
    .sidebar-section {
      padding: 15px;
    }
  }
</style>

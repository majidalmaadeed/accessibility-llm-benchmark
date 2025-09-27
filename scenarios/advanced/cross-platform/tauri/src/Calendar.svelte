<script>
  export let data
  
  let calendarData = null
  let currentDate = new Date()
  let selectedDate = null
  let currentView = 'month'
  let showEventModal = false
  let editingEvent = null
  let newEvent = {
    title: '',
    date: '',
    time: '',
    duration: 60,
    category: 'work',
    location: '',
    description: ''
  }
  
  $: {
    if (data) {
      calendarData = JSON.parse(data)
    }
  }
  
  $: year = currentDate.getFullYear()
  $: month = currentDate.getMonth()
  $: firstDay = new Date(year, month, 1)
  $: lastDay = new Date(year, month + 1, 0)
  $: startDate = new Date(firstDay)
  startDate.setDate(startDate.getDate() - firstDay.getDay())
  
  function navigateCalendar(direction) {
    if (currentView === 'month') {
      currentDate.setMonth(currentDate.getMonth() + direction)
    } else if (currentView === 'week') {
      currentDate.setDate(currentDate.getDate() + (direction * 7))
    } else {
      currentDate.setDate(currentDate.getDate() + direction)
    }
    currentDate = currentDate
  }
  
  function goToToday() {
    currentDate = new Date()
    selectedDate = null
  }
  
  function setView(view) {
    currentView = view
  }
  
  function selectDate(date) {
    selectedDate = date
  }
  
  function createEvent() {
    editingEvent = null
    newEvent = {
      title: '',
      date: selectedDate ? selectedDate.toISOString().split('T')[0] : '',
      time: '',
      duration: 60,
      category: 'work',
      location: '',
      description: ''
    }
    showEventModal = true
  }
  
  function editEvent(event) {
    editingEvent = event
    newEvent = { ...event }
    showEventModal = true
  }
  
  function saveEvent() {
    if (editingEvent) {
      // Update existing event
      const index = calendarData.events.findIndex(e => e.id === editingEvent.id)
      if (index !== -1) {
        calendarData.events[index] = { ...newEvent, id: editingEvent.id }
      }
    } else {
      // Create new event
      const newId = Math.max(...calendarData.events.map(e => e.id), 0) + 1
      calendarData.events.push({ ...newEvent, id: newId })
    }
    showEventModal = false
  }
  
  function deleteEvent(eventId) {
    if (confirm('Delete this event?')) {
      calendarData.events = calendarData.events.filter(e => e.id !== eventId)
    }
  }
  
  function getEventsForDate(date) {
    if (!calendarData?.events) return []
    const dateStr = date.toISOString().split('T')[0]
    return calendarData.events.filter(event => event.date === dateStr)
  }
  
  function getCategoryColor(category) {
    const colors = {
      work: '#007bff',
      personal: '#28a745',
      meetings: '#ffc107',
      travel: '#dc3545'
    }
    return colors[category] || '#6c757d'
  }
  
  function formatDate(date) {
    return date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' })
  }
  
  function isToday(date) {
    return date.toDateString() === new Date().toDateString()
  }
  
  function isSelected(date) {
    return selectedDate && date.toDateString() === selectedDate.toDateString()
  }
  
  function isOtherMonth(date) {
    return date.getMonth() !== month
  }
</script>

<div class="calendar-container">
  <div class="calendar-header">
    <h2>Calendar Application</h2>
    <div class="view-controls">
      <button class="view-btn" class:active={currentView === 'month'} on:click={() => setView('month')}>Month</button>
      <button class="view-btn" class:active={currentView === 'week'} on:click={() => setView('week')}>Week</button>
      <button class="view-btn" class:active={currentView === 'day'} on:click={() => setView('day')}>Day</button>
    </div>
  </div>
  
  <div class="calendar-toolbar">
    <div class="date-navigation">
      <button class="nav-btn" on:click={() => navigateCalendar(-1)}>‹</button>
      <div class="current-date">{formatDate(currentDate)}</div>
      <button class="nav-btn" on:click={() => navigateCalendar(1)}>›</button>
      <button class="nav-btn" on:click={goToToday}>Today</button>
    </div>
    <div class="calendar-actions">
      <button class="action-btn" on:click={() => alert('Filters')}>Filters</button>
      <button class="action-btn primary" on:click={createEvent}>New Event</button>
    </div>
  </div>
  
  <div class="calendar-content">
    <div class="calendar-sidebar">
      <div class="sidebar-section">
        <h3>Categories</h3>
        <div class="category-list">
          {#each calendarData?.categories || [] as category}
            <div class="category-item">
              <div class="category-color" style="background: {getCategoryColor(category)};"></div>
              <span class="category-name">{category}</span>
              <span class="category-count">{calendarData?.events.filter(e => e.category === category).length || 0}</span>
            </div>
          {/each}
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Quick Actions</h3>
        <button class="action-btn" on:click={() => alert('Export Calendar')}>Export Calendar</button>
        <button class="action-btn" on:click={() => alert('Import Calendar')}>Import Calendar</button>
        <button class="action-btn" on:click={() => alert('Share Calendar')}>Share Calendar</button>
      </div>
    </div>
    
    <div class="calendar-main">
      <div class="calendar-grid">
        <div class="calendar-day-header">Sun</div>
        <div class="calendar-day-header">Mon</div>
        <div class="calendar-day-header">Tue</div>
        <div class="calendar-day-header">Wed</div>
        <div class="calendar-day-header">Thu</div>
        <div class="calendar-day-header">Fri</div>
        <div class="calendar-day-header">Sat</div>
        
        {#each Array(42) as _, i}
          {@const date = new Date(startDate)}
          {@const dayNumber = startDate.getDate() + i}
          {@const currentDate = new Date(startDate)}
          currentDate.setDate(startDate.getDate() + i)
          {@const events = getEventsForDate(currentDate)}
          
          <div class="calendar-day" 
               class:other-month={isOtherMonth(currentDate)}
               class:today={isToday(currentDate)}
               class:selected={isSelected(currentDate)}
               on:click={() => selectDate(currentDate)}>
            <div class="day-number">{currentDate.getDate()}</div>
            {#if events.length > 0}
              <div class="event-list">
                {#each events.slice(0, 3) as event}
                  <div class="event-item" 
                       style="background-color: {getCategoryColor(event.category)};"
                       on:click|stopPropagation={() => editEvent(event)}>
                    {event.title}
                  </div>
                {/each}
                {#if events.length > 3}
                  <div class="event-more">+{events.length - 3} more</div>
                {/if}
              </div>
            {/if}
          </div>
        {/each}
      </div>
    </div>
  </div>
</div>

{#if showEventModal}
  <div class="event-modal">
    <div class="event-modal-content">
      <div class="event-modal-header">
        <h2>{editingEvent ? 'Edit Event' : 'Create Event'}</h2>
        <button class="close-btn" on:click={() => showEventModal = false}>&times;</button>
      </div>
      
      <div class="event-form">
        <div class="form-group">
          <label for="eventTitle">Event Title</label>
          <input type="text" id="eventTitle" bind:value={newEvent.title}>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="eventDate">Date</label>
            <input type="date" id="eventDate" bind:value={newEvent.date}>
          </div>
          <div class="form-group">
            <label for="eventTime">Time</label>
            <input type="time" id="eventTime" bind:value={newEvent.time}>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="eventDuration">Duration</label>
            <select id="eventDuration" bind:value={newEvent.duration}>
              <option value="30">30 minutes</option>
              <option value="60">1 hour</option>
              <option value="90">1.5 hours</option>
              <option value="120">2 hours</option>
              <option value="480">All day</option>
            </select>
          </div>
          <div class="form-group">
            <label for="eventCategory">Category</label>
            <select id="eventCategory" bind:value={newEvent.category}>
              {#each calendarData?.categories || [] as category}
                <option value={category}>{category}</option>
              {/each}
            </select>
          </div>
        </div>
        
        <div class="form-group">
          <label for="eventLocation">Location</label>
          <input type="text" id="eventLocation" bind:value={newEvent.location}>
        </div>
        
        <div class="form-group">
          <label for="eventDescription">Description</label>
          <textarea id="eventDescription" bind:value={newEvent.description} rows="4"></textarea>
        </div>
        
        <div class="modal-actions">
          <button class="btn btn-secondary" on:click={() => showEventModal = false}>Cancel</button>
          {#if editingEvent}
            <button class="btn btn-danger" on:click={() => { deleteEvent(editingEvent.id); showEventModal = false; }}>Delete</button>
          {/if}
          <button class="btn btn-primary" on:click={saveEvent}>Save Event</button>
        </div>
      </div>
    </div>
  </div>
{/if}

<style>
  .calendar-container {
    max-width: 1400px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .calendar-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .calendar-header h2 {
    margin: 0;
    font-size: 24px;
  }
  
  .view-controls {
    display: flex;
    gap: 10px;
  }
  
  .view-btn {
    padding: 8px 16px;
    background: rgba(255,255,255,0.2);
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
  }
  
  .view-btn.active {
    background: rgba(255,255,255,0.3);
  }
  
  .view-btn:hover {
    background: rgba(255,255,255,0.25);
  }
  
  .calendar-toolbar {
    padding: 20px;
    background: #f8f9fa;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .date-navigation {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .nav-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }
  
  .nav-btn:hover {
    background: #f8f9fa;
  }
  
  .current-date {
    font-size: 20px;
    font-weight: 600;
    color: #333;
    min-width: 200px;
    text-align: center;
  }
  
  .calendar-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    padding: 10px 20px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }
  
  .action-btn.primary {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .action-btn.primary:hover {
    background: #0056b3;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .calendar-content {
    display: flex;
    min-height: 600px;
  }
  
  .calendar-sidebar {
    width: 300px;
    background: #f8f9fa;
    border-right: 1px solid #e9ecef;
    padding: 20px;
  }
  
  .sidebar-section {
    margin-bottom: 30px;
  }
  
  .sidebar-section h3 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 15px;
    color: #333;
  }
  
  .category-list {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .category-item {
    display: flex;
    align-items: center;
    padding: 8px 0;
    cursor: pointer;
  }
  
  .category-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-right: 10px;
  }
  
  .category-name {
    font-size: 14px;
    color: #333;
    flex: 1;
  }
  
  .category-count {
    font-size: 12px;
    color: #666;
    background: #e9ecef;
    padding: 2px 6px;
    border-radius: 10px;
  }
  
  .calendar-main {
    flex: 1;
    padding: 20px;
  }
  
  .calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 1px;
    background: #e9ecef;
    border: 1px solid #e9ecef;
  }
  
  .calendar-day-header {
    background: #f8f9fa;
    padding: 15px 10px;
    text-align: center;
    font-weight: 600;
    color: #666;
    font-size: 14px;
  }
  
  .calendar-day {
    background: white;
    min-height: 120px;
    padding: 10px;
    cursor: pointer;
    position: relative;
    border: 1px solid #f0f0f0;
  }
  
  .calendar-day:hover {
    background: #f8f9fa;
  }
  
  .calendar-day.other-month {
    background: #f8f9fa;
    color: #ccc;
  }
  
  .calendar-day.today {
    background: #e3f2fd;
  }
  
  .calendar-day.selected {
    background: #007bff;
    color: white;
  }
  
  .day-number {
    font-weight: 600;
    margin-bottom: 5px;
  }
  
  .event-list {
    max-height: 80px;
    overflow-y: auto;
  }
  
  .event-item {
    font-size: 11px;
    padding: 2px 4px;
    margin-bottom: 2px;
    border-radius: 3px;
    cursor: pointer;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    color: white;
  }
  
  .event-item:hover {
    opacity: 0.8;
  }
  
  .event-more {
    font-size: 11px;
    color: #666;
    font-style: italic;
  }
  
  .event-modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  
  .event-modal-content {
    background: white;
    border-radius: 12px;
    padding: 30px;
    max-width: 500px;
    width: 90%;
    max-height: 80vh;
    overflow-y: auto;
  }
  
  .event-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
  }
  
  .event-modal-header h2 {
    margin: 0;
    font-size: 20px;
  }
  
  .close-btn {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #666;
  }
  
  .form-group {
    margin-bottom: 20px;
  }
  
  .form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #333;
  }
  
  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
  }
  
  .form-group textarea {
    height: 80px;
    resize: vertical;
  }
  
  .form-row {
    display: flex;
    gap: 15px;
  }
  
  .form-row .form-group {
    flex: 1;
  }
  
  .modal-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #f0f0f0;
  }
  
  .btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }
  
  .btn-primary {
    background: #007bff;
    color: white;
  }
  
  .btn-primary:hover {
    background: #0056b3;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
  
  .btn-danger {
    background: #dc3545;
    color: white;
  }
  
  .btn-danger:hover {
    background: #c82333;
  }
</style>

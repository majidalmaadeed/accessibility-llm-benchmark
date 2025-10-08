<script>
  import { onMount, onDestroy } from 'svelte';
  
  let isDatePickerOpen = false;
  let isTimePickerOpen = false;
  let selectedDate = '';
  let selectedTime = '';
  let hour = 12;
  let minute = 0;
  
  function openDatePicker() {
    // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
    isDatePickerOpen = true;
    selectedDate = '';
  }
  
  function openTimePicker() {
    // KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
    isTimePickerOpen = true;
    selectedTime = '';
  }
  
  function closeDatePicker() {
    isDatePickerOpen = false;
  }
  
  function closeTimePicker() {
    isTimePickerOpen = false;
  }
  
  function confirmDate() {
    if (selectedDate) {
      const date = new Date(selectedDate);
      const formattedDate = date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
      });
      selectedDate = formattedDate;
    }
    closeDatePicker();
  }
  
  function confirmTime() {
    const formattedHour = hour.toString().padStart(2, '0');
    const formattedMinute = minute.toString().padStart(2, '0');
    selectedTime = `${formattedHour}:${formattedMinute}`;
    closeTimePicker();
  }
  
  function handleKeydown(event) {
    if (isDatePickerOpen || isTimePickerOpen) {
      if (event.key === 'Escape') {
        if (isDatePickerOpen) closeDatePicker();
        if (isTimePickerOpen) closeTimePicker();
      }
      
      // KEYBOARD TRAP IN WIDGET - Prevent focus from escaping the modal
      if (event.key === 'Tab') {
        const modal = isDatePickerOpen ? 
          document.querySelector('#datePickerModal') :
          document.querySelector('#timePickerModal');
        
        if (modal) {
          const focusableElements = modal.querySelectorAll('button, input, select, textarea, [tabindex]:not([tabindex="-1"])');
          const firstElement = focusableElements[0];
          const lastElement = focusableElements[focusableElements.length - 1];
          
          if (event.shiftKey) {
            if (document.activeElement === firstElement) {
              event.preventDefault();
              lastElement.focus();
            }
          } else {
            if (document.activeElement === lastElement) {
              event.preventDefault();
              firstElement.focus();
            }
          }
        }
      }
    }
  }
  
  onMount(() => {
    document.addEventListener('keydown', handleKeydown);
  });
  
  onDestroy(() => {
    document.removeEventListener('keydown', handleKeydown);
  });
</script>

<div class="event-scheduler">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">Event Scheduler</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Help clicked')}>
          ❓ Help
        </button>
        <button class="header-btn" on:click={() => alert('Settings clicked')}>
          ⚙️ Settings
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="form-container">
      <div class="form-header">
        <h2 class="form-title">Create New Event</h2>
        <p class="form-subtitle">Schedule your event with date and time</p>
      </div>
      
      <form class="event-form">
        <div class="form-group">
          <label for="eventTitle" class="form-label">Event Title</label>
          <input 
            type="text" 
            id="eventTitle" 
            class="form-input" 
            placeholder="Enter event title"
          />
        </div>
        
        <div class="form-group">
          <label for="eventDescription" class="form-label">Event Description</label>
          <textarea 
            id="eventDescription" 
            class="form-textarea" 
            placeholder="Enter event description"
            rows="4"
          ></textarea>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="eventDate" class="form-label">Event Date</label>
            <button 
              type="button" 
              class="date-time-btn" 
              on:click={openDatePicker}
            >
              <span>📅 {selectedDate || 'Select Date'}</span>
              <span>▼</span>
            </button>
          </div>
          
          <div class="form-group">
            <label for="eventTime" class="form-label">Event Time</label>
            <button 
              type="button" 
              class="date-time-btn" 
              on:click={openTimePicker}
            >
              <span>🕐 {selectedTime || 'Select Time'}</span>
              <span>▼</span>
            </button>
          </div>
        </div>
        
        <div class="form-group">
          <label for="eventLocation" class="form-label">Event Location</label>
          <input 
            type="text" 
            id="eventLocation" 
            class="form-input" 
            placeholder="Enter event location"
          />
        </div>
        
        <div class="form-group">
          <label for="attendees" class="form-label">Attendees</label>
          <input 
            type="text" 
            id="attendees" 
            class="form-input" 
            placeholder="Enter attendee emails (comma separated)"
          />
        </div>
        
        <div class="form-actions">
          <button type="button" class="form-btn secondary" on:click={() => alert('Cancel clicked')}>
            Cancel
          </button>
          <button type="button" class="form-btn primary" on:click={() => alert('Create Event clicked')}>
            Create Event
          </button>
        </div>
      </form>
    </div>
  </main>
  
  <!-- KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside -->
  {#if isDatePickerOpen}
    <div class="modal-overlay" on:click={closeDatePicker}>
      <div class="modal-content" id="datePickerModal" on:click|stopPropagation>
        <div class="modal-header">
          <h3 class="modal-title">Select Date</h3>
          <button class="modal-close" on:click={closeDatePicker}>×</button>
        </div>
        
        <div class="modal-body">
          <div class="date-picker">
            <input 
              type="date" 
              class="date-input" 
              bind:value={selectedDate}
              on:keydown={(e) => e.stopPropagation()}
            />
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="modal-btn secondary" on:click={closeDatePicker}>
            Cancel
          </button>
          <button type="button" class="modal-btn primary" on:click={confirmDate}>
            Done
          </button>
        </div>
      </div>
    </div>
  {/if}
  
  <!-- KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside -->
  {#if isTimePickerOpen}
    <div class="modal-overlay" on:click={closeTimePicker}>
      <div class="modal-content" id="timePickerModal" on:click|stopPropagation>
        <div class="modal-header">
          <h3 class="modal-title">Select Time</h3>
          <button class="modal-close" on:click={closeTimePicker}>×</button>
        </div>
        
        <div class="modal-body">
          <div class="time-picker">
            <div class="time-input-group">
              <label for="hourInput" class="time-label">Hour</label>
              <input 
                type="number" 
                id="hourInput" 
                class="time-input" 
                min="0" 
                max="23" 
                bind:value={hour}
                on:keydown={(e) => e.stopPropagation()}
              />
            </div>
            
            <div class="time-separator">:</div>
            
            <div class="time-input-group">
              <label for="minuteInput" class="time-label">Minute</label>
              <input 
                type="number" 
                id="minuteInput" 
                class="time-input" 
                min="0" 
                max="59" 
                bind:value={minute}
                on:keydown={(e) => e.stopPropagation()}
              />
            </div>
          </div>
          
          <div class="time-presets">
            <button type="button" class="preset-btn" on:click={() => { hour = 9; minute = 0; }}>
              9:00 AM
            </button>
            <button type="button" class="preset-btn" on:click={() => { hour = 12; minute = 0; }}>
              12:00 PM
            </button>
            <button type="button" class="preset-btn" on:click={() => { hour = 15; minute = 0; }}>
              3:00 PM
            </button>
            <button type="button" class="preset-btn" on:click={() => { hour = 18; minute = 0; }}>
              6:00 PM
            </button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="modal-btn secondary" on:click={closeTimePicker}>
            Cancel
          </button>
          <button type="button" class="modal-btn primary" on:click={confirmTime}>
            Done
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
  .event-scheduler {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  
  .header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 30px 20px;
  }
  
  .form-container {
    background: white;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .form-header {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .form-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin: 0 0 10px 0;
  }
  
  .form-subtitle {
    font-size: 18px;
    color: #666;
    margin: 0;
  }
  
  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
  }
  
  .form-group {
    margin-bottom: 25px;
  }
  
  .form-label {
    display: block;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
  }
  
  .form-input,
  .form-textarea {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    box-sizing: border-box;
    transition: border-color 0.2s;
  }
  
  .form-input:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .form-textarea {
    resize: vertical;
    min-height: 100px;
  }
  
  .date-time-btn {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: all 0.2s;
  }
  
  .date-time-btn:hover {
    background: #f8f9fa;
  }
  
  .date-time-btn:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .form-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid #eee;
  }
  
  .form-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .form-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .form-btn.primary:hover {
    background: #0056b3;
  }
  
  .form-btn.secondary {
    background: #6c757d;
    color: white;
  }
  
  .form-btn.secondary:hover {
    background: #545b62;
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
  
  .modal-content {
    background: white;
    border-radius: 12px;
    padding: 0;
    max-width: 400px;
    width: 90%;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    max-height: 90vh;
    overflow: hidden;
  }
  
  .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #eee;
  }
  
  .modal-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .modal-close {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #666;
    padding: 0;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    transition: all 0.2s;
  }
  
  .modal-close:hover {
    background: #f8f9fa;
    color: #333;
  }
  
  .modal-body {
    padding: 20px;
  }
  
  .date-picker {
    text-align: center;
  }
  
  .date-input {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    text-align: center;
  }
  
  .date-input:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .time-picker {
    text-align: center;
    margin-bottom: 20px;
  }
  
  .time-input-group {
    display: inline-block;
    margin: 0 10px;
  }
  
  .time-label {
    display: block;
    font-size: 14px;
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
  }
  
  .time-input {
    width: 80px;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    text-align: center;
  }
  
  .time-input:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .time-separator {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    display: inline-block;
    vertical-align: top;
    margin-top: 25px;
  }
  
  .time-presets {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;
  }
  
  .preset-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .preset-btn:hover {
    background: #f8f9fa;
  }
  
  .preset-btn:focus {
    outline: none;
    border-color: #007bff;
  }
  
  .modal-footer {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    padding: 20px;
    border-top: 1px solid #eee;
  }
  
  .modal-btn {
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: all 0.2s;
  }
  
  .modal-btn.primary {
    background: #007bff;
    color: white;
  }
  
  .modal-btn.primary:hover {
    background: #0056b3;
  }
  
  .modal-btn.secondary {
    background: #6c757d;
    color: white;
  }
  
  .modal-btn.secondary:hover {
    background: #545b62;
  }
  
  @media (max-width: 768px) {
    .form-container {
      padding: 20px;
    }
    
    .form-title {
      font-size: 24px;
    }
    
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .form-actions {
      flex-direction: column;
    }
    
    .time-presets {
      grid-template-columns: 1fr;
    }
  }
</style>

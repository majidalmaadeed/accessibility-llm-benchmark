<script>
  let selectedDate = null;
  let isCalendarOpen = false;
  let currentMonth = new Date().getMonth();
  let currentYear = new Date().getFullYear();
  let focusedDate = null;
  let calendarElement = null;

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  function getDaysInMonth(month, year) {
    return new Date(year, month + 1, 0).getDate();
  }

  function getFirstDayOfMonth(month, year) {
    return new Date(year, month, 1).getDay();
  }

  function getCalendarDays() {
    const daysInMonth = getDaysInMonth(currentMonth, currentYear);
    const firstDay = getFirstDayOfMonth(currentMonth, currentYear);
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
  }

  function isToday(day) {
    const today = new Date();
    return day === today.getDate() && 
           currentMonth === today.getMonth() && 
           currentYear === today.getFullYear();
  }

  function isSelected(day) {
    if (!selectedDate) return false;
    return day === selectedDate.getDate() && 
           currentMonth === selectedDate.getMonth() && 
           currentYear === selectedDate.getFullYear();
  }

  function selectDate(day) {
    selectedDate = new Date(currentYear, currentMonth, day);
    isCalendarOpen = false;
  }

  function toggleCalendar() {
    isCalendarOpen = !isCalendarOpen;
    if (isCalendarOpen) {
      setTimeout(() => {
        if (calendarElement) {
          calendarElement.focus();
        }
      }, 100);
    }
  }

  function navigateMonth(direction) {
    if (direction === 'prev') {
      if (currentMonth === 0) {
        currentMonth = 11;
        currentYear--;
      } else {
        currentMonth--;
      }
    } else {
      if (currentMonth === 11) {
        currentMonth = 0;
        currentYear++;
      } else {
        currentMonth++;
      }
    }
  }

  function handleKeydown(event) {
    if (!isCalendarOpen) return;
    
    const days = getCalendarDays();
    const currentIndex = focusedDate ? days.indexOf(focusedDate) : 0;
    let newIndex = currentIndex;
    
    switch (event.key) {
      case 'ArrowLeft':
        event.preventDefault();
        newIndex = Math.max(0, currentIndex - 1);
        break;
      case 'ArrowRight':
        event.preventDefault();
        newIndex = Math.min(days.length - 1, currentIndex + 1);
        break;
      case 'ArrowUp':
        event.preventDefault();
        newIndex = Math.max(0, currentIndex - 7);
        break;
      case 'ArrowDown':
        event.preventDefault();
        newIndex = Math.min(days.length - 1, currentIndex + 7);
        break;
      case 'Enter':
      case ' ':
        event.preventDefault();
        if (focusedDate) {
          selectDate(focusedDate);
        }
        break;
      case 'Escape':
        event.preventDefault();
        isCalendarOpen = false;
        break;
    }
    
    if (newIndex !== currentIndex && days[newIndex]) {
      focusedDate = days[newIndex];
    }
  }

  function formatSelectedDate() {
    if (!selectedDate) return '';
    return selectedDate.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  function handleAction(action) {
    alert(`${action} action performed`);
  }
</script>

<div class="date-picker-demo">
  <header class="demo-header">
    <h1>Date Picker Widget</h1>
    <p>Interactive date selection with calendar widget</p>
  </header>

  <div class="demo-content">
    <div class="date-picker-container">
      <label for="date-input" class="date-label">Select a Date</label>
      <div class="date-input-wrapper">
        <input 
          type="text" 
          id="date-input" 
          bind:this={calendarElement}
          value={formatSelectedDate()}
          on:click={toggleCalendar}
          on:keydown={handleKeydown}
          class="date-input"
          placeholder="Click to select date"
          readonly
        />
        <button 
          type="button" 
          class="calendar-toggle"
          on:click={toggleCalendar}
        >
          📅
        </button>
      </div>

      {#if isCalendarOpen}
        <div class="calendar-widget" on:keydown={handleKeydown}>
          <div class="calendar-header">
            <button 
              type="button" 
              class="nav-btn prev"
              on:click={() => navigateMonth('prev')}
            >
              ‹
            </button>
            <h3 class="month-year">
              {months[currentMonth]} {currentYear}
            </h3>
            <button 
              type="button" 
              class="nav-btn next"
              on:click={() => navigateMonth('next')}
            >
              ›
            </button>
          </div>

          <div class="calendar-grid">
            <div class="weekdays">
              {#each weekDays as day}
                <div class="weekday">{day}</div>
              {/each}
            </div>
            
            <div class="days">
              {#each getCalendarDays() as day}
                {#if day}
                  <button 
                    type="button"
                    class="day-btn {isToday(day) ? 'today' : ''} {isSelected(day) ? 'selected' : ''} {focusedDate === day ? 'focused' : ''}"
                    on:click={() => selectDate(day)}
                    on:mouseenter={() => focusedDate = day}
                  >
                    {day}
                  </button>
                {:else}
                  <div class="day-empty"></div>
                {/if}
              {/each}
            </div>
          </div>

          <div class="calendar-actions">
            <button 
              type="button" 
              class="action-btn secondary"
              on:click={() => isCalendarOpen = false}
            >
              Cancel
            </button>
            <button 
              type="button" 
              class="action-btn primary"
              on:click={() => {
                if (focusedDate) selectDate(focusedDate);
              }}
            >
              Select
            </button>
          </div>
        </div>
      {/if}
    </div>

    <div class="selected-info">
      {#if selectedDate}
        <h3>Selected Date</h3>
        <p>You selected: <strong>{formatSelectedDate()}</strong></p>
        <div class="date-actions">
          <button 
            class="action-btn primary"
            on:click={() => handleAction('Save Date')}
          >
            Save Date
          </button>
          <button 
            class="action-btn secondary"
            on:click={() => {
              selectedDate = null;
              isCalendarOpen = false;
            }}
          >
            Clear Date
          </button>
        </div>
      {:else}
        <h3>No Date Selected</h3>
        <p>Please select a date using the calendar widget above.</p>
      {/if}
    </div>
  </div>

  <div class="demo-features">
    <h2>Widget Features</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">⌨️</div>
        <h3>Keyboard Navigation</h3>
        <p>Use arrow keys to navigate through dates</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">🖱️</div>
        <h3>Mouse Support</h3>
        <p>Click on dates to select them directly</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">📅</div>
        <h3>Month Navigation</h3>
        <p>Navigate between months using arrow buttons</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3>Visual Feedback</h3>
        <p>Clear indication of today, selected, and focused dates</p>
      </div>
    </div>
  </div>

  <div class="accessibility-notes">
    <h3>Accessibility Considerations</h3>
    <div class="notes-content">
      <div class="note-item">
        <span class="note-icon">⚠️</span>
        <div class="note-text">
          <h4>Keyboard Trap Issue</h4>
          <p>This widget demonstrates a keyboard trap where focus cannot escape the calendar using Tab key</p>
        </div>
      </div>
      
      <div class="note-item">
        <span class="note-icon">💡</span>
        <div class="note-text">
          <h4>Proper Implementation</h4>
          <p>Calendar widgets should allow Tab navigation to move focus outside the widget</p>
        </div>
      </div>
      
      <div class="note-item">
        <span class="note-icon">🔧</span>
        <div class="note-text">
          <h4>Solution</h4>
          <p>Implement proper focus management with Escape key to close and Tab to exit</p>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .date-picker-demo {
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .demo-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .demo-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .demo-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .demo-content {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 30px;
  }

  .date-picker-container {
    position: relative;
    margin-bottom: 30px;
  }

  .date-label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
  }

  .date-input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
  }

  .date-input {
    flex: 1;
    padding: 12px 40px 12px 16px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    transition: border-color 0.2s ease;
  }

  .date-input:focus {
    outline: none;
    border-color: #007bff;
  }

  .calendar-toggle {
    position: absolute;
    right: 8px;
    background: none;
    border: none;
    font-size: 18px;
    cursor: pointer;
    padding: 4px;
  }

  .calendar-widget {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    border: 2px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 1000;
    margin-top: 4px;
  }

  .calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #eee;
  }

  .nav-btn {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    padding: 8px;
    border-radius: 4px;
    transition: background-color 0.2s ease;
  }

  .nav-btn:hover {
    background: #f8f9fa;
  }

  .month-year {
    margin: 0;
    font-size: 18px;
    color: #333;
  }

  .calendar-grid {
    padding: 15px;
  }

  .weekdays {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 4px;
    margin-bottom: 10px;
  }

  .weekday {
    text-align: center;
    font-size: 12px;
    font-weight: bold;
    color: #666;
    padding: 8px 4px;
  }

  .days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 4px;
  }

  .day-btn {
    background: none;
    border: none;
    padding: 8px;
    cursor: pointer;
    border-radius: 4px;
    font-size: 14px;
    transition: all 0.2s ease;
  }

  .day-btn:hover {
    background: #f8f9fa;
  }

  .day-btn.today {
    background: #e3f2fd;
    color: #1976d2;
    font-weight: bold;
  }

  .day-btn.selected {
    background: #007bff;
    color: white;
  }

  .day-btn.focused {
    background: #0056b3;
    color: white;
  }

  .day-empty {
    padding: 8px;
  }

  .calendar-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    padding: 15px;
    border-top: 1px solid #eee;
  }

  .action-btn {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .action-btn.primary {
    background: #007bff;
    color: white;
  }

  .action-btn.primary:hover {
    background: #0056b3;
  }

  .action-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .action-btn.secondary:hover {
    background: #545b62;
  }

  .selected-info {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 6px;
    text-align: center;
  }

  .selected-info h3 {
    margin: 0 0 10px 0;
    color: #333;
  }

  .selected-info p {
    margin: 0 0 15px 0;
    color: #666;
  }

  .date-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
  }

  .demo-features {
    margin-bottom: 30px;
  }

  .demo-features h2 {
    margin: 0 0 25px 0;
    font-size: 24px;
    color: #333;
  }

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
  }

  .feature-card {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    text-align: center;
  }

  .feature-icon {
    font-size: 32px;
    margin-bottom: 10px;
  }

  .feature-card h3 {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: #333;
  }

  .feature-card p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  .accessibility-notes {
    background: #fff3cd;
    border: 1px solid #ffeaa7;
    border-radius: 8px;
    padding: 25px;
  }

  .accessibility-notes h3 {
    margin: 0 0 20px 0;
    color: #856404;
    font-size: 20px;
  }

  .notes-content {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .note-item {
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }

  .note-icon {
    font-size: 20px;
    flex-shrink: 0;
  }

  .note-text h4 {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #856404;
  }

  .note-text p {
    margin: 0;
    color: #856404;
    font-size: 14px;
    line-height: 1.4;
  }

  @media (max-width: 768px) {
    .calendar-widget {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 90%;
      max-width: 350px;
    }

    .date-actions {
      flex-direction: column;
    }

    .action-btn {
      width: 100%;
    }
  }
</style>

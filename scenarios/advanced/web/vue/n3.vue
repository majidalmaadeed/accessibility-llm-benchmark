<template>
  <div class="calendar-application">
    <div class="calendar-toolbar">
      <div class="view-controls">
        <button 
          :class="{ active: view === 'month' }"
          @click="view = 'month'"
        >
          Month
        </button>
        <button 
          :class="{ active: view === 'week' }"
          @click="view = 'week'"
        >
          Week
        </button>
        <button 
          :class="{ active: view === 'day' }"
          @click="view = 'day'"
        >
          Day
        </button>
      </div>

      <div class="toolbar-actions">
        <button 
          class="new-event-btn"
          @click="showEventForm = true"
        >
          + New Event
        </button>
        
        <div class="category-filter">
          <button 
            @click="showCategoryFilter = !showCategoryFilter"
            class="filter-btn"
          >
            Filter: {{ categoryFilter === 'all' ? 'All' : categories.find(c => c.id === categoryFilter)?.name }}
          </button>
          
          <div v-if="showCategoryFilter" class="category-dropdown">
            <button 
              :class="{ active: categoryFilter === 'all' }"
              @click="categoryFilter = 'all'"
            >
              All Categories
            </button>
            <button
              v-for="category in categories"
              :key="category.id"
              :class="{ active: categoryFilter === category.id }"
              @click="categoryFilter = category.id"
            >
              {{ category.name }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="calendar-content">
      <!-- Month View -->
      <div v-if="view === 'month'" class="month-view">
        <div class="calendar-header">
          <h2>{{ getMonthName() }}</h2>
          <div class="navigation">
            <button @click="navigateMonth(-1)">‹</button>
            <button @click="currentDate = new Date()">Today</button>
            <button @click="navigateMonth(1)">›</button>
          </div>
        </div>

        <div class="calendar-grid">
          <div class="day-headers">
            <div v-for="day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']" :key="day" class="day-header">{{ day }}</div>
          </div>
          
          <div class="days-grid">
            <div
              v-for="(day, index) in getDaysInMonth()"
              :key="index"
              :class="`day-cell ${isToday(day) ? 'today' : ''} ${!isCurrentMonth(day) ? 'other-month' : ''}`"
              @click="day && handleDateClick(day)"
            >
              <div v-if="day" class="day-number">{{ day.getDate() }}</div>
              <div v-if="day" class="day-events">
                <div
                  v-for="event in getEventsForDate(day).slice(0, 3)"
                  :key="event.id"
                  :class="`event-dot ${event.category}`"
                  @click.stop="handleEventClick(event)"
                >
                  {{ event.title }}
                </div>
                <div v-if="getEventsForDate(day).length > 3" class="more-events">
                  +{{ getEventsForDate(day).length - 3 }} more
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Week View -->
      <div v-if="view === 'week'" class="week-view">
        <div class="calendar-header">
          <h2>Week of {{ getStartOfWeek().toLocaleDateString() }}</h2>
          <div class="navigation">
            <button @click="navigateWeek(-1)">‹</button>
            <button @click="currentDate = new Date()">Today</button>
            <button @click="navigateWeek(1)">›</button>
          </div>
        </div>

        <div class="week-grid">
          <div class="time-column">
            <div v-for="time in timeSlots" :key="time" class="time-slot">{{ time }}</div>
          </div>
          
          <div
            v-for="i in 7"
            :key="i"
            :class="`day-column ${isToday(getWeekDate(i)) ? 'today' : ''}`"
          >
            <div class="day-header">
              <div class="day-name">{{ getWeekDate(i).toLocaleDateString('en-US', { weekday: 'short' }) }}</div>
              <div class="day-number">{{ getWeekDate(i).getDate() }}</div>
            </div>
            
            <div class="day-events">
              <div
                v-for="event in getEventsForDate(getWeekDate(i))"
                :key="event.id"
                :class="`event-block ${event.category}`"
                :style="getEventStyle(event)"
                @click="handleEventClick(event)"
              >
                {{ event.title }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Day View -->
      <div v-if="view === 'day'" class="day-view">
        <div class="calendar-header">
          <h2>{{ getDayName() }}</h2>
          <div class="navigation">
            <button @click="navigateDay(-1)">‹</button>
            <button @click="currentDate = new Date()">Today</button>
            <button @click="navigateDay(1)">›</button>
          </div>
        </div>

        <div class="day-grid">
          <div class="time-column">
            <div v-for="time in timeSlots" :key="time" class="time-slot">{{ time }}</div>
          </div>
          
          <div class="day-events">
            <div
              v-for="event in getEventsForDate(currentDate)"
              :key="event.id"
              :class="`event-block ${event.category}`"
              :style="getEventStyle(event)"
              @click="handleEventClick(event)"
            >
              <div class="event-title">{{ event.title }}</div>
              <div class="event-time">
                {{ formatTime(event.start) }} - {{ formatTime(event.end) }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Event Form Modal -->
    <div v-if="showEventForm" class="event-form-overlay">
      <div class="event-form">
        <div class="form-header">
          <h3>{{ selectedEvent ? 'Edit Event' : 'New Event' }}</h3>
          <button @click="closeEventForm" class="close-btn">✕</button>
        </div>

        <div class="form-content">
          <div class="form-group">
            <label>Event Title</label>
            <input
              type="text"
              v-model="newEvent.title"
              placeholder="Enter event title"
            />
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Start Time</label>
              <input
                type="datetime-local"
                v-model="newEvent.start"
              />
            </div>
            <div class="form-group">
              <label>End Time</label>
              <input
                type="datetime-local"
                v-model="newEvent.end"
              />
            </div>
          </div>

          <div class="form-group">
            <label>Category</label>
            <select v-model="newEvent.category">
              <option v-for="category in categories" :key="category.id" :value="category.id">
                {{ category.name }}
              </option>
            </select>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>
                <input
                  type="checkbox"
                  v-model="newEvent.recurring"
                />
                Recurring Event
              </label>
            </div>
            <div class="form-group">
              <label>Reminder (minutes)</label>
              <select v-model="newEvent.reminder">
                <option value="5">5 minutes</option>
                <option value="15">15 minutes</option>
                <option value="30">30 minutes</option>
                <option value="60">1 hour</option>
              </select>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button v-if="selectedEvent" @click="handleDeleteEvent" class="delete-btn">
            Delete
          </button>
          <div class="form-actions-right">
            <button @click="closeEventForm" class="cancel-btn">
              Cancel
            </button>
            <button @click="handleSaveEvent" class="save-btn">
              Save
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CalendarApplication',
  data() {
    return {
      currentDate: new Date(),
      view: 'month',
      events: [
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
      ],
      showEventForm: false,
      selectedEvent: null,
      selectedDate: null,
      showCategoryFilter: false,
      categoryFilter: 'all',
      newEvent: {
        title: '',
        start: '',
        end: '',
        category: 'work',
        recurring: false,
        reminder: 15
      },
      categories: [
        { id: 'work', name: 'Work', color: '#4caf50' },
        { id: 'personal', name: 'Personal', color: '#2196f3' },
        { id: 'health', name: 'Health', color: '#f44336' },
        { id: 'social', name: 'Social', color: '#ff9800' }
      ],
      timeSlots: Array.from({ length: 24 }, (_, i) => `${i.toString().padStart(2, '0')}:00`)
    }
  },
  computed: {
    filteredEvents() {
      return this.categoryFilter === 'all' 
        ? this.events 
        : this.events.filter(event => event.category === this.categoryFilter);
    }
  },
  methods: {
    getDaysInMonth() {
      const year = this.currentDate.getFullYear();
      const month = this.currentDate.getMonth();
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
    },
    getEventsForDate(date) {
      if (!date) return [];
      
      return this.filteredEvents.filter(event => {
        const eventDate = new Date(event.start);
        return eventDate.toDateString() === date.toDateString();
      });
    },
    getStartOfWeek() {
      const startOfWeek = new Date(this.currentDate);
      startOfWeek.setDate(this.currentDate.getDate() - this.currentDate.getDay());
      return startOfWeek;
    },
    getWeekDate(dayIndex) {
      const startOfWeek = this.getStartOfWeek();
      const date = new Date(startOfWeek);
      date.setDate(startOfWeek.getDate() + dayIndex - 1);
      return date;
    },
    isToday(date) {
      return date && date.toDateString() === new Date().toDateString();
    },
    isCurrentMonth(date) {
      return date && date.getMonth() === this.currentDate.getMonth();
    },
    getMonthName() {
      return this.currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
    },
    getDayName() {
      return this.currentDate.toLocaleDateString('en-US', { 
        weekday: 'long', 
        month: 'long', 
        day: 'numeric', 
        year: 'numeric' 
      });
    },
    formatTime(date) {
      return new Date(date).toLocaleTimeString('en-US', { 
        hour: 'numeric', 
        minute: '2-digit' 
      });
    },
    getEventStyle(event) {
      const startHours = event.start.getHours() + event.start.getMinutes() / 60;
      const duration = (event.end - event.start) / (1000 * 60 * 60);
      
      return {
        top: `${startHours * 40}px`,
        height: `${duration * 40}px`
      };
    },
    handleDateClick(date) {
      this.selectedDate = date;
      this.showEventForm = true;
      this.newEvent = {
        title: '',
        start: date.toISOString().slice(0, 16),
        end: new Date(date.getTime() + 60 * 60 * 1000).toISOString().slice(0, 16),
        category: 'work',
        recurring: false,
        reminder: 15
      };
    },
    handleEventClick(event) {
      this.selectedEvent = event;
      this.showEventForm = true;
      this.newEvent = {
        title: event.title,
        start: event.start.toISOString().slice(0, 16),
        end: event.end.toISOString().slice(0, 16),
        category: event.category,
        recurring: event.recurring,
        reminder: event.reminder
      };
    },
    closeEventForm() {
      this.showEventForm = false;
      this.selectedEvent = null;
      this.selectedDate = null;
    },
    handleSaveEvent() {
      if (!this.newEvent.title.trim()) return;

      const eventData = {
        ...this.newEvent,
        start: new Date(this.newEvent.start),
        end: new Date(this.newEvent.end),
        id: this.selectedEvent ? this.selectedEvent.id : Date.now()
      };

      if (this.selectedEvent) {
        this.events = this.events.map(event => 
          event.id === this.selectedEvent.id ? eventData : event
        );
      } else {
        this.events.push(eventData);
      }

      this.closeEventForm();
    },
    handleDeleteEvent() {
      if (this.selectedEvent) {
        this.events = this.events.filter(event => event.id !== this.selectedEvent.id);
        this.closeEventForm();
      }
    },
    navigateMonth(direction) {
      const newDate = new Date(this.currentDate);
      newDate.setMonth(this.currentDate.getMonth() + direction);
      this.currentDate = newDate;
    },
    navigateWeek(direction) {
      const newDate = new Date(this.currentDate);
      newDate.setDate(this.currentDate.getDate() + (direction * 7));
      this.currentDate = newDate;
    },
    navigateDay(direction) {
      const newDate = new Date(this.currentDate);
      newDate.setDate(this.currentDate.getDate() + direction);
      this.currentDate = newDate;
    }
  }
}
</script>

<style scoped>
.calendar-application {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.calendar-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.view-controls {
  display: flex;
  gap: 5px;
  background: white;
  border-radius: 6px;
  padding: 4px;
}

.view-controls button {
  padding: 8px 16px;
  border: none;
  background: transparent;
  color: #666;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.view-controls button.active {
  background: #4caf50;
  color: white;
}

.view-controls button:hover:not(.active) {
  background: #e9ecef;
}

.toolbar-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.new-event-btn {
  padding: 10px 20px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.new-event-btn:hover {
  background: #45a049;
}

.category-filter {
  position: relative;
}

.filter-btn {
  padding: 8px 16px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: border-color 0.3s ease;
}

.filter-btn:hover {
  border-color: #4caf50;
}

.category-dropdown {
  position: absolute;
  top: 100%;
  right: 0;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 100;
  min-width: 150px;
  margin-top: 5px;
}

.category-dropdown button {
  display: block;
  width: 100%;
  padding: 10px 15px;
  border: none;
  background: none;
  text-align: left;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: background-color 0.3s ease;
}

.category-dropdown button:hover {
  background: #f5f5f5;
}

.category-dropdown button.active {
  background: #4caf50;
  color: white;
}

.calendar-content {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.calendar-header h2 {
  margin: 0;
  color: #333;
  font-size: 20px;
}

.navigation {
  display: flex;
  gap: 10px;
}

.navigation button {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  transition: all 0.3s ease;
}

.navigation button:hover {
  background: #f5f5f5;
  border-color: #4caf50;
}

/* Month View */
.month-view {
  padding: 20px;
}

.calendar-grid {
  display: flex;
  flex-direction: column;
}

.day-headers {
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
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.days-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 1px;
  background: #e0e0e0;
}

.day-cell {
  min-height: 120px;
  background: white;
  padding: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  position: relative;
}

.day-cell:hover {
  background: #f8f9fa;
}

.day-cell.today {
  background: #e3f2fd;
}

.day-cell.other-month {
  background: #f5f5f5;
  color: #ccc;
}

.day-number {
  font-weight: 600;
  margin-bottom: 5px;
  color: #333;
}

.day-events {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.event-dot {
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 10px;
  color: white;
  cursor: pointer;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.event-dot.work {
  background: #4caf50;
}

.event-dot.personal {
  background: #2196f3;
}

.event-dot.health {
  background: #f44336;
}

.event-dot.social {
  background: #ff9800;
}

.more-events {
  font-size: 10px;
  color: #666;
  font-style: italic;
}

/* Week View */
.week-view {
  padding: 20px;
}

.week-grid {
  display: grid;
  grid-template-columns: 80px repeat(7, 1fr);
  gap: 1px;
  background: #e0e0e0;
  min-height: 600px;
}

.time-column {
  background: #f8f9fa;
  padding: 10px 5px;
}

.time-slot {
  height: 40px;
  display: flex;
  align-items: center;
  font-size: 11px;
  color: #666;
  border-bottom: 1px solid #e0e0e0;
}

.day-column {
  background: white;
  position: relative;
}

.day-column.today {
  background: #e3f2fd;
}

.day-header {
  padding: 10px;
  text-align: center;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.day-name {
  font-size: 11px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.day-number {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-top: 2px;
}

.day-events {
  position: relative;
  height: 960px;
}

.event-block {
  position: absolute;
  left: 2px;
  right: 2px;
  background: #4caf50;
  color: white;
  padding: 4px 6px;
  border-radius: 3px;
  cursor: pointer;
  font-size: 11px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.event-block.work {
  background: #4caf50;
}

.event-block.personal {
  background: #2196f3;
}

.event-block.health {
  background: #f44336;
}

.event-block.social {
  background: #ff9800;
}

/* Day View */
.day-view {
  padding: 20px;
}

.day-grid {
  display: grid;
  grid-template-columns: 80px 1fr;
  gap: 1px;
  background: #e0e0e0;
  min-height: 600px;
}

.event-title {
  font-weight: 600;
  margin-bottom: 2px;
}

.event-time {
  font-size: 10px;
  opacity: 0.9;
}

/* Event Form */
.event-form-overlay {
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

.event-form {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
}

.form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.form-header h3 {
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
  padding: 5px;
  border-radius: 3px;
  transition: background-color 0.3s ease;
}

.close-btn:hover {
  background: #f5f5f5;
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

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.form-group input,
.form-group select {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group select:focus {
  outline: none;
  border-color: #4caf50;
}

.form-group label input[type="checkbox"] {
  width: auto;
  margin-right: 8px;
}

.form-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-top: 1px solid #e0e0e0;
}

.form-actions-right {
  display: flex;
  gap: 10px;
}

.delete-btn {
  padding: 10px 20px;
  background: #f44336;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.delete-btn:hover {
  background: #d32f2f;
}

.cancel-btn {
  padding: 10px 20px;
  background: #f5f5f5;
  color: #666;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.cancel-btn:hover {
  background: #e0e0e0;
}

.save-btn {
  padding: 10px 20px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.save-btn:hover {
  background: #45a049;
}

@media (max-width: 768px) {
  .calendar-application {
    padding: 15px;
  }
  
  .calendar-toolbar {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .toolbar-actions {
    justify-content: center;
  }
  
  .calendar-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .navigation {
    justify-content: center;
  }
  
  .day-cell {
    min-height: 80px;
  }
  
  .week-grid {
    grid-template-columns: 60px repeat(7, 1fr);
  }
  
  .day-grid {
    grid-template-columns: 60px 1fr;
  }
  
  .time-slot {
    height: 30px;
    font-size: 10px;
  }
  
  .day-events {
    height: 720px;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
    gap: 15px;
  }
  
  .form-actions-right {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .view-controls {
    width: 100%;
    justify-content: center;
  }
  
  .view-controls button {
    flex: 1;
  }
  
  .days-grid {
    gap: 0;
  }
  
  .day-cell {
    min-height: 60px;
    padding: 4px;
  }
  
  .day-number {
    font-size: 12px;
  }
  
  .event-dot {
    font-size: 8px;
    padding: 1px 3px;
  }
  
  .week-grid {
    grid-template-columns: 50px repeat(7, 1fr);
  }
  
  .day-grid {
    grid-template-columns: 50px 1fr;
  }
}
</style>

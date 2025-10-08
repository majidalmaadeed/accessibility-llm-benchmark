<template>
  <div class="calendar-app">
    <div class="calendar-header">
      <div class="header-controls">
        <button 
          @click="previousMonth"
          class="nav-btn"
        >
          ←
        </button>
        <h2 class="month-year">{{ getMonthYear() }}</h2>
        <button 
          @click="nextMonth"
          class="nav-btn"
        >
          →
        </button>
      </div>
      
      <div class="view-controls">
        <button 
          @click="setView('month')"
          :class="{ active: currentView === 'month' }"
          class="view-btn"
        >
          Month
        </button>
        <button 
          @click="setView('week')"
          :class="{ active: currentView === 'week' }"
          class="view-btn"
        >
          Week
        </button>
        <button 
          @click="setView('day')"
          :class="{ active: currentView === 'day' }"
          class="view-btn"
        >
          Day
        </button>
      </div>
    </div>

    <div class="calendar-filters">
      <div class="filter-group">
        <label class="filter-label">Show Events</label>
        <div class="filter-options">
          <label 
            v-for="category in eventCategories"
            :key="category.value"
            class="filter-option"
          >
            <input
              v-model="selectedCategories"
              type="checkbox"
              :value="category.value"
            />
            <span 
              class="category-indicator"
              :style="{ backgroundColor: category.color }"
            />
            {{ category.label }}
          </label>
        </div>
      </div>
      
      <div class="filter-group">
        <button 
          @click="showEventForm = !showEventForm"
          class="add-event-btn"
        >
          + Add Event
        </button>
      </div>
    </div>

    <div v-if="showEventForm" class="event-form-overlay">
      <div class="event-form">
        <div class="form-header">
          <h3>{{ editingEvent ? 'Edit Event' : 'Create New Event' }}</h3>
          <button 
            @click="closeEventForm"
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <form @submit.prevent="saveEvent" class="event-form-content">
          <div class="form-group">
            <label class="form-label">Event Title</label>
            <input
              v-model="eventForm.title"
              type="text"
              required
              class="form-input"
              placeholder="Enter event title"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Date & Time</label>
            <div class="datetime-inputs">
              <input
                v-model="eventForm.date"
                type="date"
                required
                class="form-input"
              />
              <input
                v-model="eventForm.startTime"
                type="time"
                required
                class="form-input"
              />
              <span class="time-separator">to</span>
              <input
                v-model="eventForm.endTime"
                type="time"
                required
                class="form-input"
              />
            </div>
          </div>
          
          <div class="form-group">
            <label class="form-label">Category</label>
            <select v-model="eventForm.category" class="form-select">
              <option
                v-for="category in eventCategories"
                :key="category.value"
                :value="category.value"
              >
                {{ category.label }}
              </option>
            </select>
          </div>
          
          <div class="form-group">
            <label class="form-label">Description</label>
            <textarea
              v-model="eventForm.description"
              class="form-textarea"
              rows="3"
              placeholder="Enter event description"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label">Recurring</label>
            <select v-model="eventForm.recurring" class="form-select">
              <option value="none">No Recurrence</option>
              <option value="daily">Daily</option>
              <option value="weekly">Weekly</option>
              <option value="monthly">Monthly</option>
              <option value="yearly">Yearly</option>
            </select>
          </div>
          
          <div class="form-group">
            <label class="form-label">Reminder</label>
            <select v-model="eventForm.reminder" class="form-select">
              <option value="none">No Reminder</option>
              <option value="5min">5 minutes before</option>
              <option value="15min">15 minutes before</option>
              <option value="30min">30 minutes before</option>
              <option value="1hour">1 hour before</option>
              <option value="1day">1 day before</option>
            </select>
          </div>
          
          <div class="form-actions">
            <button 
              type="button"
              @click="closeEventForm"
              class="cancel-btn"
            >
              Cancel
            </button>
            <button 
              type="submit"
              class="save-btn"
            >
              {{ editingEvent ? 'Update' : 'Create' }} Event
            </button>
          </div>
        </form>
      </div>
    </div>

    <div class="calendar-container">
      <div v-if="currentView === 'month'" class="month-view">
        <div class="calendar-grid">
          <div class="day-header" v-for="day in dayHeaders" :key="day">
            {{ day }}
          </div>
          
          <div 
            v-for="day in calendarDays"
            :key="day.date"
            class="calendar-day"
            :class="{ 
              'other-month': !day.isCurrentMonth,
              'today': day.isToday,
              'has-events': day.events.length > 0
            }"
            @click="selectDate(day.date)"
          >
            <div class="day-number">{{ day.dayNumber }}</div>
            <div class="day-events">
              <div 
                v-for="event in day.events.slice(0, 3)"
                :key="event.id"
                class="event-indicator"
                :style="{ backgroundColor: getCategoryColor(event.category) }"
                @click.stop="viewEvent(event)"
              >
                {{ event.title }}
              </div>
              <div 
                v-if="day.events.length > 3"
                class="more-events"
              >
                +{{ day.events.length - 3 }} more
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="currentView === 'week'" class="week-view">
        <div class="week-grid">
          <div class="time-column">
            <div class="time-slot" v-for="hour in timeSlots" :key="hour">
              {{ hour }}
            </div>
          </div>
          
          <div 
            v-for="day in weekDays"
            :key="day.date"
            class="week-day"
          >
            <div class="day-header">
              <div class="day-name">{{ day.name }}</div>
              <div class="day-date">{{ day.date }}</div>
            </div>
            
            <div class="day-slots">
              <div 
                v-for="hour in timeSlots"
                :key="`${day.date}-${hour}`"
                class="time-slot"
                @click="createEventAtTime(day.date, hour)"
              >
                <div 
                  v-for="event in getEventsForDayAndTime(day.date, hour)"
                  :key="event.id"
                  class="week-event"
                  :style="{ backgroundColor: getCategoryColor(event.category) }"
                  @click.stop="viewEvent(event)"
                >
                  {{ event.title }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="currentView === 'day'" class="day-view">
        <div class="day-header">
          <h3>{{ formatDate(selectedDate) }}</h3>
          <div class="day-actions">
            <button 
              @click="previousDay"
              class="nav-btn"
            >
              ←
            </button>
            <button 
              @click="nextDay"
              class="nav-btn"
            >
              →
            </button>
          </div>
        </div>
        
        <div class="day-timeline">
          <div 
            v-for="hour in timeSlots"
            :key="hour"
            class="timeline-slot"
          >
            <div class="time-label">{{ hour }}</div>
            <div 
              class="time-content"
              @click="createEventAtTime(selectedDate, hour)"
            >
              <div 
                v-for="event in getEventsForDayAndTime(selectedDate, hour)"
                :key="event.id"
                class="timeline-event"
                :style="{ backgroundColor: getCategoryColor(event.category) }"
                @click.stop="viewEvent(event)"
              >
                <div class="event-title">{{ event.title }}</div>
                <div class="event-time">{{ event.startTime }} - {{ event.endTime }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedEvent" class="event-details-overlay">
      <div class="event-details">
        <div class="details-header">
          <h3>{{ selectedEvent.title }}</h3>
          <button 
            @click="selectedEvent = null"
            class="close-btn"
          >
            ✕
          </button>
        </div>
        
        <div class="details-content">
          <div class="detail-row">
            <span class="detail-label">Date:</span>
            <span class="detail-value">{{ selectedEvent.date }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">Time:</span>
            <span class="detail-value">{{ selectedEvent.startTime }} - {{ selectedEvent.endTime }}</span>
          </div>
          <div class="detail-row">
            <span class="detail-label">Category:</span>
            <span class="detail-value">{{ getCategoryLabel(selectedEvent.category) }}</span>
          </div>
          <div v-if="selectedEvent.description" class="detail-row">
            <span class="detail-label">Description:</span>
            <span class="detail-value">{{ selectedEvent.description }}</span>
          </div>
          <div v-if="selectedEvent.recurring !== 'none'" class="detail-row">
            <span class="detail-label">Recurring:</span>
            <span class="detail-value">{{ selectedEvent.recurring }}</span>
          </div>
        </div>
        
        <div class="details-actions">
          <button 
            @click="editEvent(selectedEvent)"
            class="edit-btn"
          >
            Edit
          </button>
          <button 
            @click="deleteEvent(selectedEvent.id)"
            class="delete-btn"
          >
            Delete
          </button>
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
      currentView: 'month',
      selectedDate: new Date(),
      selectedEvent: null,
      showEventForm: false,
      editingEvent: null,
      selectedCategories: ['work', 'personal', 'meeting', 'reminder'],
      eventForm: {
        title: '',
        date: '',
        startTime: '',
        endTime: '',
        category: 'work',
        description: '',
        recurring: 'none',
        reminder: 'none'
      },
      events: [
        {
          id: 1,
          title: 'Team Meeting',
          date: '2024-01-15',
          startTime: '10:00',
          endTime: '11:00',
          category: 'meeting',
          description: 'Weekly team standup',
          recurring: 'weekly',
          reminder: '15min'
        },
        {
          id: 2,
          title: 'Doctor Appointment',
          date: '2024-01-18',
          startTime: '14:30',
          endTime: '15:30',
          category: 'personal',
          description: 'Annual checkup',
          recurring: 'none',
          reminder: '1hour'
        },
        {
          id: 3,
          title: 'Project Deadline',
          date: '2024-01-20',
          startTime: '17:00',
          endTime: '17:00',
          category: 'work',
          description: 'Submit final report',
          recurring: 'none',
          reminder: '1day'
        }
      ],
      eventCategories: [
        { value: 'work', label: 'Work', color: '#4caf50' },
        { value: 'personal', label: 'Personal', color: '#2196f3' },
        { value: 'meeting', label: 'Meeting', color: '#ff9800' },
        { value: 'reminder', label: 'Reminder', color: '#9c27b0' }
      ],
      dayHeaders: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      timeSlots: [
        '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM',
        '6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
        '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM',
        '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM'
      ]
    }
  },
  computed: {
    calendarDays() {
      const year = this.currentDate.getFullYear()
      const month = this.currentDate.getMonth()
      
      const firstDay = new Date(year, month, 1)
      const lastDay = new Date(year, month + 1, 0)
      const startDate = new Date(firstDay)
      startDate.setDate(startDate.getDate() - firstDay.getDay())
      
      const days = []
      const today = new Date()
      
      for (let i = 0; i < 42; i++) {
        const date = new Date(startDate)
        date.setDate(startDate.getDate() + i)
        
        const dayEvents = this.getEventsForDate(date)
        
        days.push({
          date: this.formatDateForComparison(date),
          dayNumber: date.getDate(),
          isCurrentMonth: date.getMonth() === month,
          isToday: this.isSameDate(date, today),
          events: dayEvents
        })
      }
      
      return days
    },
    weekDays() {
      const startOfWeek = new Date(this.selectedDate)
      startOfWeek.setDate(this.selectedDate.getDate() - this.selectedDate.getDay())
      
      const days = []
      for (let i = 0; i < 7; i++) {
        const date = new Date(startOfWeek)
        date.setDate(startOfWeek.getDate() + i)
        
        days.push({
          date: this.formatDateForComparison(date),
          name: this.dayHeaders[date.getDay()],
          date: date.getDate()
        })
      }
      
      return days
    }
  },
  methods: {
    getMonthYear() {
      return this.currentDate.toLocaleDateString('en-US', { 
        month: 'long', 
        year: 'numeric' 
      })
    },
    previousMonth() {
      this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() - 1, 1)
    },
    nextMonth() {
      this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() + 1, 1)
    },
    previousDay() {
      this.selectedDate = new Date(this.selectedDate.getTime() - 24 * 60 * 60 * 1000)
    },
    nextDay() {
      this.selectedDate = new Date(this.selectedDate.getTime() + 24 * 60 * 60 * 1000)
    },
    setView(view) {
      this.currentView = view
    },
    selectDate(date) {
      this.selectedDate = new Date(date)
      if (this.currentView === 'day') {
        this.selectedDate = new Date(date)
      }
    },
    getEventsForDate(date) {
      const dateStr = this.formatDateForComparison(date)
      return this.events.filter(event => 
        event.date === dateStr && 
        this.selectedCategories.includes(event.category)
      )
    },
    getEventsForDayAndTime(date, time) {
      return this.events.filter(event => 
        event.date === date && 
        this.selectedCategories.includes(event.category) &&
        event.startTime === time
      )
    },
    createEventAtTime(date, time) {
      this.eventForm = {
        title: '',
        date: date,
        startTime: time,
        endTime: this.getNextHour(time),
        category: 'work',
        description: '',
        recurring: 'none',
        reminder: 'none'
      }
      this.editingEvent = null
      this.showEventForm = true
    },
    getNextHour(time) {
      const hour = parseInt(time.split(':')[0])
      const nextHour = (hour + 1) % 24
      return `${nextHour.toString().padStart(2, '0')}:00`
    },
    viewEvent(event) {
      this.selectedEvent = event
    },
    editEvent(event) {
      this.editingEvent = event
      this.eventForm = { ...event }
      this.showEventForm = true
      this.selectedEvent = null
    },
    saveEvent() {
      if (this.editingEvent) {
        const index = this.events.findIndex(e => e.id === this.editingEvent.id)
        this.events[index] = { ...this.eventForm, id: this.editingEvent.id }
      } else {
        const newEvent = {
          ...this.eventForm,
          id: Date.now()
        }
        this.events.push(newEvent)
      }
      
      this.closeEventForm()
    },
    deleteEvent(eventId) {
      this.events = this.events.filter(e => e.id !== eventId)
      this.selectedEvent = null
    },
    closeEventForm() {
      this.showEventForm = false
      this.editingEvent = null
      this.eventForm = {
        title: '',
        date: '',
        startTime: '',
        endTime: '',
        category: 'work',
        description: '',
        recurring: 'none',
        reminder: 'none'
      }
    },
    getCategoryColor(category) {
      const cat = this.eventCategories.find(c => c.value === category)
      return cat ? cat.color : '#666'
    },
    getCategoryLabel(category) {
      const cat = this.eventCategories.find(c => c.value === category)
      return cat ? cat.label : category
    },
    formatDate(date) {
      return new Date(date).toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
    },
    formatDateForComparison(date) {
      return date.toISOString().split('T')[0]
    },
    isSameDate(date1, date2) {
      return date1.toDateString() === date2.toDateString()
    }
  }
}
</script>

<style scoped>
.calendar-app {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 2px solid #e0e0e0;
}

.header-controls {
  display: flex;
  align-items: center;
  gap: 20px;
}

.nav-btn {
  width: 40px;
  height: 40px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
  transition: all 0.3s ease;
}

.nav-btn:hover {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.month-year {
  margin: 0;
  color: #333;
  font-size: 24px;
  font-weight: 600;
}

.view-controls {
  display: flex;
  gap: 5px;
}

.view-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.view-btn:hover {
  background: #f0f0f0;
}

.view-btn.active {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.calendar-filters {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.filter-group {
  display: flex;
  align-items: center;
  gap: 15px;
}

.filter-label {
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.filter-options {
  display: flex;
  gap: 15px;
}

.filter-option {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
  font-size: 12px;
}

.category-indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
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

.event-form-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
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
  font-size: 18px;
  cursor: pointer;
  color: #666;
}

.event-form-content {
  padding: 20px;
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.form-input,
.form-select,
.form-textarea {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s ease;
}

.form-input:focus,
.form-select:focus,
.form-textarea:focus {
  outline: none;
  border-color: #4caf50;
}

.datetime-inputs {
  display: flex;
  align-items: center;
  gap: 10px;
}

.time-separator {
  color: #666;
  font-size: 14px;
}

.form-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
  margin-top: 30px;
}

.cancel-btn,
.save-btn {
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.cancel-btn {
  background: #f5f5f5;
  color: #666;
}

.cancel-btn:hover {
  background: #e0e0e0;
}

.save-btn {
  background: #4caf50;
  color: white;
}

.save-btn:hover {
  background: #45a049;
}

.calendar-container {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
}

.month-view .calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
}

.day-header {
  padding: 15px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
  text-align: center;
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.calendar-day {
  min-height: 120px;
  padding: 10px;
  border-right: 1px solid #e0e0e0;
  border-bottom: 1px solid #e0e0e0;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.calendar-day:hover {
  background: #f8f9fa;
}

.calendar-day.other-month {
  background: #fafafa;
  color: #ccc;
}

.calendar-day.today {
  background: #e8f5e8;
}

.calendar-day.has-events {
  background: #fff3e0;
}

.day-number {
  font-weight: 600;
  margin-bottom: 5px;
  font-size: 14px;
}

.day-events {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.event-indicator {
  padding: 2px 6px;
  border-radius: 3px;
  color: white;
  font-size: 10px;
  font-weight: 500;
  cursor: pointer;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.more-events {
  font-size: 10px;
  color: #666;
  font-style: italic;
}

.week-view .week-grid {
  display: grid;
  grid-template-columns: 80px repeat(7, 1fr);
}

.time-column {
  background: #f8f9fa;
  border-right: 1px solid #e0e0e0;
}

.time-slot {
  height: 60px;
  padding: 5px;
  border-bottom: 1px solid #e0e0e0;
  font-size: 12px;
  color: #666;
  display: flex;
  align-items: center;
}

.week-day {
  border-right: 1px solid #e0e0e0;
}

.week-day .day-header {
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
  text-align: center;
  padding: 10px;
}

.day-name {
  font-weight: 600;
  color: #333;
  font-size: 12px;
}

.day-date {
  font-size: 14px;
  color: #666;
  margin-top: 2px;
}

.day-slots .time-slot {
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.day-slots .time-slot:hover {
  background: #f0f8ff;
}

.week-event {
  padding: 2px 4px;
  border-radius: 3px;
  color: white;
  font-size: 10px;
  font-weight: 500;
  margin-bottom: 2px;
  cursor: pointer;
}

.day-view .day-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.day-view .day-header h3 {
  margin: 0;
  color: #333;
  font-size: 20px;
}

.day-actions {
  display: flex;
  gap: 10px;
}

.day-timeline {
  display: flex;
  flex-direction: column;
}

.timeline-slot {
  display: flex;
  min-height: 60px;
  border-bottom: 1px solid #e0e0e0;
}

.time-label {
  width: 80px;
  padding: 10px;
  background: #f8f9fa;
  border-right: 1px solid #e0e0e0;
  font-size: 12px;
  color: #666;
  display: flex;
  align-items: center;
}

.time-content {
  flex: 1;
  padding: 10px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.time-content:hover {
  background: #f0f8ff;
}

.timeline-event {
  padding: 8px 12px;
  border-radius: 6px;
  color: white;
  margin-bottom: 5px;
  cursor: pointer;
}

.event-title {
  font-weight: 600;
  font-size: 14px;
  margin-bottom: 2px;
}

.event-time {
  font-size: 12px;
  opacity: 0.9;
}

.event-details-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.event-details {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 400px;
}

.details-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.details-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.details-content {
  padding: 20px;
}

.detail-row {
  display: flex;
  margin-bottom: 10px;
}

.detail-label {
  font-weight: 600;
  color: #333;
  width: 100px;
  font-size: 14px;
}

.detail-value {
  color: #666;
  font-size: 14px;
}

.details-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
  padding: 20px;
  border-top: 1px solid #e0e0e0;
}

.edit-btn,
.delete-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.edit-btn {
  background: #4caf50;
  color: white;
}

.edit-btn:hover {
  background: #45a049;
}

.delete-btn {
  background: #f44336;
  color: white;
}

.delete-btn:hover {
  background: #d32f2f;
}

@media (max-width: 768px) {
  .calendar-app {
    padding: 15px;
  }
  
  .calendar-header {
    flex-direction: column;
    gap: 20px;
    align-items: stretch;
  }
  
  .header-controls {
    justify-content: center;
  }
  
  .view-controls {
    justify-content: center;
  }
  
  .calendar-filters {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .filter-group {
    justify-content: center;
  }
  
  .filter-options {
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .calendar-day {
    min-height: 80px;
    padding: 5px;
  }
  
  .day-number {
    font-size: 12px;
  }
  
  .event-indicator {
    font-size: 9px;
    padding: 1px 4px;
  }
  
  .week-view .week-grid {
    grid-template-columns: 60px repeat(7, 1fr);
  }
  
  .time-column .time-slot {
    height: 40px;
    font-size: 10px;
  }
  
  .day-view .day-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .day-actions {
    justify-content: center;
  }
  
  .timeline-slot {
    min-height: 40px;
  }
  
  .time-label {
    width: 60px;
    font-size: 10px;
  }
}

@media (max-width: 480px) {
  .calendar-app {
    padding: 10px;
  }
  
  .calendar-day {
    min-height: 60px;
    padding: 3px;
  }
  
  .day-number {
    font-size: 10px;
  }
  
  .event-indicator {
    font-size: 8px;
    padding: 1px 2px;
  }
  
  .datetime-inputs {
    flex-direction: column;
    align-items: stretch;
  }
  
  .time-separator {
    text-align: center;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .details-actions {
    flex-direction: column;
  }
}
</style>

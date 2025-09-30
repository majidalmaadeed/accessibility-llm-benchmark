<template>
  <div class="calendar-application">
    <header class="app-header">
      <div class="header-content">
        <h1 class="app-title">Calendar & Events</h1>
        <div class="header-actions">
          <button class="action-btn" @click="showDatePicker = true">Select Date</button>
          <button class="action-btn" @click="createEvent">New Event</button>
          <button class="action-btn" @click="showSettings = true">Settings</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="calendar-container">
        <div class="calendar-header">
          <div class="month-navigation">
            <button class="nav-btn" @click="previousMonth">‹</button>
            <h2 class="current-month">{{ currentMonth }}</h2>
            <button class="nav-btn" @click="nextMonth">›</button>
          </div>
          
          <div class="view-controls">
            <button class="view-btn" :class="{ active: view === 'month' }" @click="view = 'month'">Month</button>
            <button class="view-btn" :class="{ active: view === 'week' }" @click="view = 'week'">Week</button>
            <button class="view-btn" :class="{ active: view === 'day' }" @click="view = 'day'">Day</button>
          </div>
        </div>

        <div class="calendar-grid" v-if="view === 'month'">
          <div class="calendar-header-row">
            <div class="day-header" v-for="day in dayNames" :key="day">{{ day }}</div>
          </div>
          <div class="calendar-body">
            <div 
              v-for="day in calendarDays" 
              :key="day.date"
              class="calendar-day"
              :class="{ 
                'other-month': !day.isCurrentMonth,
                'today': day.isToday,
                'selected': day.isSelected
              }"
              @click="selectDate(day)"
            >
              <div class="day-number">{{ day.day }}</div>
              <div class="day-events">
                <div 
                  v-for="event in day.events" 
                  :key="event.id"
                  class="event-item"
                  :class="event.type"
                  @click.stop="openEvent(event)"
                >
                  {{ event.title }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="week-view" v-if="view === 'week'">
          <div class="week-header">
            <div class="time-column"></div>
            <div class="day-column" v-for="day in weekDays" :key="day.date">
              <div class="day-name">{{ day.name }}</div>
              <div class="day-date">{{ day.date }}</div>
            </div>
          </div>
          <div class="week-body">
            <div class="time-slot" v-for="hour in hours" :key="hour">
              <div class="time-label">{{ hour }}:00</div>
              <div class="day-column" v-for="day in weekDays" :key="`${day.date}-${hour}`">
                <div class="time-cell"></div>
              </div>
            </div>
          </div>
        </div>

        <div class="day-view" v-if="view === 'day'">
          <div class="day-header">
            <h3 class="day-title">{{ selectedDate }}</h3>
          </div>
          <div class="day-body">
            <div class="time-slot" v-for="hour in hours" :key="hour">
              <div class="time-label">{{ hour }}:00</div>
              <div class="time-cell"></div>
            </div>
          </div>
        </div>
      </div>

      <div class="events-sidebar">
        <h3 class="sidebar-title">Upcoming Events</h3>
        <div class="events-list">
          <div 
            v-for="event in upcomingEvents" 
            :key="event.id"
            class="event-card"
            @click="openEvent(event)"
          >
            <div class="event-time">{{ event.time }}</div>
            <div class="event-title">{{ event.title }}</div>
            <div class="event-location">{{ event.location }}</div>
          </div>
        </div>
      </div>
    </main>

    <!-- Date Picker Modal -->
    <div class="modal-overlay" v-if="showDatePicker" @click="closeDatePicker">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">Select Date</h3>
          <button class="close-btn" @click="closeDatePicker">×</button>
        </div>
        <div class="date-picker-widget">
          <div class="date-picker-header">
            <button class="nav-btn" @click="previousPickerMonth">‹</button>
            <h4 class="picker-month">{{ pickerMonth }}</h4>
            <button class="nav-btn" @click="nextPickerMonth">›</button>
          </div>
          <div class="date-picker-grid">
            <div class="picker-day-header" v-for="day in dayNames" :key="day">{{ day }}</div>
            <div 
              v-for="day in pickerDays" 
              :key="day.date"
              class="picker-day"
              :class="{ 
                'other-month': !day.isCurrentMonth,
                'today': day.isToday,
                'selected': day.isSelected
              }"
              @click="selectPickerDate(day)"
            >
              {{ day.day }}
            </div>
          </div>
          <div class="date-picker-actions">
            <button class="btn btn-secondary" @click="closeDatePicker">Cancel</button>
            <button class="btn btn-primary" @click="confirmDateSelection">Select Date</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Event Creation Modal -->
    <div class="modal-overlay" v-if="showEventModal" @click="closeEventModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">Create New Event</h3>
          <button class="close-btn" @click="closeEventModal">×</button>
        </div>
        <form class="event-form" @submit.prevent="saveEvent">
          <div class="form-group">
            <label class="form-label">Event Title</label>
            <input 
              type="text" 
              v-model="newEvent.title"
              class="form-input"
              required
            />
          </div>
          <div class="form-group">
            <label class="form-label">Date</label>
            <input 
              type="date" 
              v-model="newEvent.date"
              class="form-input"
              required
            />
          </div>
          <div class="form-group">
            <label class="form-label">Time</label>
            <input 
              type="time" 
              v-model="newEvent.time"
              class="form-input"
              required
            />
          </div>
          <div class="form-group">
            <label class="form-label">Location</label>
            <input 
              type="text" 
              v-model="newEvent.location"
              class="form-input"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Description</label>
            <textarea 
              v-model="newEvent.description"
              class="form-textarea"
              rows="3"
            ></textarea>
          </div>
          <div class="form-actions">
            <button type="button" class="btn btn-secondary" @click="closeEventModal">Cancel</button>
            <button type="submit" class="btn btn-primary">Save Event</button>
          </div>
        </form>
      </div>
    </div>

    <!-- Settings Modal -->
    <div class="modal-overlay" v-if="showSettings" @click="closeSettings">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">Calendar Settings</h3>
          <button class="close-btn" @click="closeSettings">×</button>
        </div>
        <div class="settings-content">
          <div class="setting-group">
            <h4 class="setting-title">Display Options</h4>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.showWeekends" />
                Show weekends
              </label>
            </div>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.showTimeGrid" />
                Show time grid
              </label>
            </div>
          </div>
          <div class="setting-group">
            <h4 class="setting-title">Notifications</h4>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.emailReminders" />
                Email reminders
              </label>
            </div>
            <div class="setting-item">
              <label class="setting-label">
                <input type="checkbox" v-model="settings.pushNotifications" />
                Push notifications
              </label>
            </div>
          </div>
          <div class="setting-actions">
            <button class="btn btn-secondary" @click="closeSettings">Cancel</button>
            <button class="btn btn-primary" @click="saveSettings">Save Settings</button>
          </div>
        </div>
      </div>
    </div>

    <footer class="app-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Calendar</h4>
          <ul class="footer-links">
            <li><a href="/month">Month View</a></li>
            <li><a href="/week">Week View</a></li>
            <li><a href="/day">Day View</a></li>
            <li><a href="/agenda">Agenda</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Events</h4>
          <ul class="footer-links">
            <li><a href="/create">Create Event</a></li>
            <li><a href="/import">Import Events</a></li>
            <li><a href="/export">Export Events</a></li>
            <li><a href="/templates">Templates</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Settings</h4>
          <ul class="footer-links">
            <li><a href="/preferences">Preferences</a></li>
            <li><a href="/notifications">Notifications</a></li>
            <li><a href="/sync">Sync Settings</a></li>
            <li><a href="/privacy">Privacy</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h4>Help</h4>
          <ul class="footer-links">
            <li><a href="/help">Help Center</a></li>
            <li><a href="/tutorials">Tutorials</a></li>
            <li><a href="/contact">Contact Support</a></li>
            <li><a href="/feedback">Feedback</a></li>
          </ul>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>&copy; 2024 Calendar Application. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const view = ref('month')
const showDatePicker = ref(false)
const showEventModal = ref(false)
const showSettings = ref(false)
const currentDate = ref(new Date())
const selectedDate = ref('')
const selectedPickerDate = ref(null)

const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
const hours = Array.from({ length: 24 }, (_, i) => i)

const settings = ref({
  showWeekends: true,
  showTimeGrid: true,
  emailReminders: true,
  pushNotifications: false
})

const newEvent = ref({
  title: '',
  date: '',
  time: '',
  location: '',
  description: ''
})

const events = ref([
  {
    id: 1,
    title: 'Team Meeting',
    date: '2024-01-15',
    time: '10:00',
    location: 'Conference Room A',
    type: 'meeting'
  },
  {
    id: 2,
    title: 'Project Deadline',
    date: '2024-01-20',
    time: '17:00',
    location: 'Office',
    type: 'deadline'
  },
  {
    id: 3,
    title: 'Client Presentation',
    date: '2024-01-18',
    time: '14:00',
    location: 'Meeting Room B',
    type: 'presentation'
  }
])

const currentMonth = computed(() => {
  return currentDate.value.toLocaleDateString('en-US', { 
    month: 'long', 
    year: 'numeric' 
  })
})

const pickerMonth = computed(() => {
  return currentDate.value.toLocaleDateString('en-US', { 
    month: 'long', 
    year: 'numeric' 
  })
})

const calendarDays = computed(() => {
  const year = currentDate.value.getFullYear()
  const month = currentDate.value.getMonth()
  const firstDay = new Date(year, month, 1)
  const lastDay = new Date(year, month + 1, 0)
  const startDate = new Date(firstDay)
  startDate.setDate(startDate.getDate() - firstDay.getDay())
  
  const days = []
  const today = new Date()
  
  for (let i = 0; i < 42; i++) {
    const date = new Date(startDate)
    date.setDate(startDate.getDate() + i)
    
    const dayEvents = events.value.filter(event => 
      event.date === date.toISOString().split('T')[0]
    )
    
    days.push({
      date: date.toISOString().split('T')[0],
      day: date.getDate(),
      isCurrentMonth: date.getMonth() === month,
      isToday: date.toDateString() === today.toDateString(),
      isSelected: selectedDate.value === date.toISOString().split('T')[0],
      events: dayEvents
    })
  }
  
  return days
})

const pickerDays = computed(() => {
  const year = currentDate.value.getFullYear()
  const month = currentDate.value.getMonth()
  const firstDay = new Date(year, month, 1)
  const startDate = new Date(firstDay)
  startDate.setDate(startDate.getDate() - firstDay.getDay())
  
  const days = []
  const today = new Date()
  
  for (let i = 0; i < 42; i++) {
    const date = new Date(startDate)
    date.setDate(startDate.getDate() + i)
    
    days.push({
      date: date.toISOString().split('T')[0],
      day: date.getDate(),
      isCurrentMonth: date.getMonth() === month,
      isToday: date.toDateString() === today.toDateString(),
      isSelected: selectedPickerDate.value === date.toISOString().split('T')[0]
    })
  }
  
  return days
})

const weekDays = computed(() => {
  const startOfWeek = new Date(currentDate.value)
  startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay())
  
  const days = []
  for (let i = 0; i < 7; i++) {
    const date = new Date(startOfWeek)
    date.setDate(startOfWeek.getDate() + i)
    
    days.push({
      date: date.toISOString().split('T')[0],
      name: dayNames[date.getDay()],
      date: date.getDate()
    })
  }
  
  return days
})

const upcomingEvents = computed(() => {
  const today = new Date().toISOString().split('T')[0]
  return events.value
    .filter(event => event.date >= today)
    .sort((a, b) => a.date.localeCompare(b.date))
    .slice(0, 5)
})

const selectDate = (day) => {
  selectedDate.value = day.date
  if (view.value === 'day') {
    // Update day view
  }
}

const selectPickerDate = (day) => {
  selectedPickerDate.value = day.date
}

const confirmDateSelection = () => {
  if (selectedPickerDate.value) {
    selectedDate.value = selectedPickerDate.value
    currentDate.value = new Date(selectedPickerDate.value)
  }
  closeDatePicker()
}

const previousMonth = () => {
  currentDate.value = new Date(currentDate.value.getFullYear(), currentDate.value.getMonth() - 1, 1)
}

const nextMonth = () => {
  currentDate.value = new Date(currentDate.value.getFullYear(), currentDate.value.getMonth() + 1, 1)
}

const previousPickerMonth = () => {
  currentDate.value = new Date(currentDate.value.getFullYear(), currentDate.value.getMonth() - 1, 1)
}

const nextPickerMonth = () => {
  currentDate.value = new Date(currentDate.value.getFullYear(), currentDate.value.getMonth() + 1, 1)
}

const createEvent = () => {
  newEvent.value = {
    title: '',
    date: selectedDate.value || new Date().toISOString().split('T')[0],
    time: '',
    location: '',
    description: ''
  }
  showEventModal.value = true
}

const saveEvent = () => {
  const event = {
    id: Date.now(),
    ...newEvent.value,
    type: 'event'
  }
  events.value.push(event)
  closeEventModal()
}

const openEvent = (event) => {
  console.log('Opening event:', event)
}

const closeDatePicker = () => {
  showDatePicker.value = false
  selectedPickerDate.value = null
}

const closeEventModal = () => {
  showEventModal.value = false
  newEvent.value = {
    title: '',
    date: '',
    time: '',
    location: '',
    description: ''
  }
}

const closeSettings = () => {
  showSettings.value = false
}

const saveSettings = () => {
  console.log('Saving settings:', settings.value)
  closeSettings()
}

const handleKeydown = (event) => {
  if (showDatePicker.value || showEventModal.value || showSettings.value) {
    if (event.key === 'Escape') {
      if (showDatePicker.value) closeDatePicker()
      if (showEventModal.value) closeEventModal()
      if (showSettings.value) closeSettings()
    }
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.calendar-application {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.app-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px;
}

.app-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.action-btn {
  padding: 10px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 30px 20px;
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 30px;
}

.calendar-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
}

.month-navigation {
  display: flex;
  align-items: center;
  gap: 20px;
}

.nav-btn {
  width: 40px;
  height: 40px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 50%;
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
  transition: all 0.2s ease;
}

.nav-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.current-month {
  margin: 0;
  font-size: 20px;
  color: #333;
}

.view-controls {
  display: flex;
  gap: 4px;
}

.view-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s ease;
}

.view-btn.active {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.view-btn:hover:not(.active) {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.calendar-grid {
  padding: 20px;
}

.calendar-header-row {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 1px;
  margin-bottom: 10px;
}

.day-header {
  padding: 15px 10px;
  text-align: center;
  font-weight: bold;
  color: #666;
  background: #f8f9fa;
  border-radius: 4px;
}

.calendar-body {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 1px;
}

.calendar-day {
  min-height: 120px;
  padding: 10px;
  border: 1px solid #eee;
  background: white;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.calendar-day:hover {
  background: #f8f9ff;
  border-color: #007bff;
}

.calendar-day.other-month {
  background: #f8f9fa;
  color: #ccc;
}

.calendar-day.today {
  background: #e3f2fd;
  border-color: #007bff;
}

.calendar-day.selected {
  background: #007bff;
  color: white;
}

.day-number {
  font-weight: bold;
  margin-bottom: 8px;
}

.day-events {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.event-item {
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 11px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.event-item.meeting {
  background: #e3f2fd;
  color: #1976d2;
}

.event-item.deadline {
  background: #ffebee;
  color: #d32f2f;
}

.event-item.presentation {
  background: #f3e5f5;
  color: #7b1fa2;
}

.event-item:hover {
  opacity: 0.8;
}

.week-view,
.day-view {
  padding: 20px;
}

.week-header {
  display: grid;
  grid-template-columns: 60px repeat(7, 1fr);
  gap: 1px;
  margin-bottom: 10px;
}

.time-column {
  background: #f8f9fa;
  border-radius: 4px;
}

.day-column {
  padding: 15px 10px;
  text-align: center;
  background: #f8f9fa;
  border-radius: 4px;
}

.day-name {
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.day-date {
  color: #666;
  font-size: 14px;
}

.week-body {
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.time-slot {
  display: grid;
  grid-template-columns: 60px repeat(7, 1fr);
  gap: 1px;
  min-height: 60px;
}

.time-label {
  padding: 10px;
  background: #f8f9fa;
  border-radius: 4px;
  font-size: 12px;
  color: #666;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
}

.time-cell {
  border: 1px solid #eee;
  background: white;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.time-cell:hover {
  background: #f8f9ff;
  border-color: #007bff;
}

.day-header {
  padding: 20px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
}

.day-title {
  margin: 0;
  font-size: 24px;
  color: #333;
}

.day-body {
  padding: 20px;
}

.events-sidebar {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  padding: 30px;
  height: fit-content;
}

.sidebar-title {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

.events-list {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.event-card {
  padding: 15px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #f8f9fa;
  cursor: pointer;
  transition: all 0.2s ease;
}

.event-card:hover {
  border-color: #007bff;
  background: #f8f9ff;
  transform: translateY(-1px);
}

.event-time {
  font-size: 12px;
  color: #666;
  margin-bottom: 5px;
}

.event-title {
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}

.event-location {
  font-size: 12px;
  color: #666;
}

.modal-overlay {
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

.modal-content {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
  border-radius: 12px 12px 0 0;
}

.modal-title {
  margin: 0;
  font-size: 18px;
  color: #333;
}

.close-btn {
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
  transition: all 0.2s ease;
}

.close-btn:hover {
  background: #f0f0f0;
  color: #333;
}

.date-picker-widget {
  padding: 30px;
}

.date-picker-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.picker-month {
  margin: 0;
  font-size: 18px;
  color: #333;
}

.date-picker-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 1px;
  margin-bottom: 20px;
}

.picker-day-header {
  padding: 10px;
  text-align: center;
  font-weight: bold;
  color: #666;
  background: #f8f9fa;
  border-radius: 4px;
}

.picker-day {
  padding: 15px 10px;
  text-align: center;
  border: 1px solid #eee;
  background: white;
  cursor: pointer;
  transition: all 0.2s ease;
  border-radius: 4px;
}

.picker-day:hover {
  background: #f8f9ff;
  border-color: #007bff;
}

.picker-day.other-month {
  background: #f8f9fa;
  color: #ccc;
}

.picker-day.today {
  background: #e3f2fd;
  border-color: #007bff;
}

.picker-day.selected {
  background: #007bff;
  color: white;
}

.date-picker-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
}

.event-form {
  padding: 30px;
}

.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.form-input,
.form-textarea {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s ease;
  box-sizing: border-box;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #007bff;
}

.form-textarea {
  resize: vertical;
  min-height: 80px;
}

.form-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #eee;
}

.settings-content {
  padding: 30px;
}

.setting-group {
  margin-bottom: 30px;
}

.setting-title {
  margin: 0 0 15px 0;
  font-size: 16px;
  color: #333;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

.setting-item {
  margin-bottom: 15px;
}

.setting-label {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.setting-label input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #007bff;
}

.setting-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #eee;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #007bff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #545b62;
}

.app-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 1024px) {
  .main-content {
    grid-template-columns: 1fr;
  }
  
  .events-sidebar {
    order: -1;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    height: auto;
    padding: 20px;
  }

  .header-actions {
    flex-wrap: wrap;
    justify-content: center;
  }

  .calendar-header {
    flex-direction: column;
    gap: 20px;
    align-items: stretch;
  }

  .month-navigation {
    justify-content: center;
  }

  .view-controls {
    justify-content: center;
  }

  .calendar-day {
    min-height: 80px;
  }

  .modal-content {
    width: 95%;
  }

  .form-actions,
  .date-picker-actions,
  .setting-actions {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .calendar-day {
    min-height: 60px;
    padding: 5px;
  }

  .day-number {
    font-size: 12px;
  }

  .event-item {
    font-size: 10px;
    padding: 1px 4px;
  }

  .modal-header,
  .event-form,
  .settings-content,
  .date-picker-widget {
    padding: 20px;
  }
}
</style>

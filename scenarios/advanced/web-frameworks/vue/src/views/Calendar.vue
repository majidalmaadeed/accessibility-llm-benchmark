<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Calendar Application</h1>
      <p class="page-subtitle">
        Calendar application with events
      </p>
    </div>

    <div class="grid grid-2">
      <div class="card">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem">
          <h2>{{ monthNames[currentDate.getMonth()] }} {{ currentDate.getFullYear() }}</h2>
          <div style="display: flex; gap: 0.5rem">
            <button class="btn btn-secondary" @click="navigateMonth(-1)">
              ←
            </button>
            <button class="btn btn-secondary" @click="setCurrentDate(new Date())">
              Today
            </button>
            <button class="btn btn-secondary" @click="navigateMonth(1)">
              →
            </button>
          </div>
        </div>

        <div class="calendar-grid">
          <div
            v-for="day in dayNames"
            :key="day"
            style="padding: 1rem; text-align: center; fontWeight: bold; backgroundColor: #f8f9fa; borderBottom: 1px solid #ddd"
          >
            {{ day }}
          </div>
          <div
            v-for="(day, index) in days"
            :key="index"
            :class="[
              'calendar-day',
              { today: day && isToday(day) },
              { selected: day && selectedDate && isSameDay(day, selectedDate) },
              { 'other-month': !day }
            ]"
            @click="day && handleDateClick(day)"
            :style="{ cursor: day ? 'pointer' : 'default' }"
          >
            <div v-if="day">
              <div class="calendar-day-number">{{ day.getDate() }}</div>
              <div
                v-for="event in getEventsForDate(day)"
                :key="event.id"
                class="calendar-event"
                :style="{
                  backgroundColor: getEventTypeColor(event.type),
                  color: 'white',
                  fontSize: '0.7rem',
                  padding: '0.2rem',
                  margin: '0.1rem 0',
                  borderRadius: '3px',
                  overflow: 'hidden',
                  textOverflow: 'ellipsis',
                  whiteSpace: 'nowrap'
                }"
              >
                {{ event.title }}
              </div>
              <div
                v-if="getEventsForDate(day).length > 2"
                style="fontSize: 0.7rem; color: #666; marginTop: 0.1rem"
              >
                +{{ getEventsForDate(day).length - 2 }} more
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <h2>Upcoming Events</h2>
        <div style="max-height: 400px; overflow-y: auto">
          <div
            v-for="event in sortedEvents"
            :key="event.id"
            style="display: flex; justifyContent: space-between; alignItems: center; padding: 0.75rem; borderBottom: 1px solid #eee"
          >
            <div>
              <div style="fontWeight: 600; marginBottom: 0.25rem">
                {{ event.title }}
              </div>
              <div style="fontSize: 0.9rem; color: #666">
                {{ new Date(event.date).toLocaleDateString() }} at {{ event.time }}
              </div>
              <div
                style="fontSize: 0.8rem; color: getEventTypeColor(event.type); textTransform: capitalize; marginTop: 0.25rem"
              >
                {{ event.type }}
              </div>
            </div>
            <button
              class="btn btn-secondary"
              @click="deleteEvent(event.id)"
              style="fontSize: 0.8rem; padding: 0.25rem 0.5rem"
            >
              Delete
            </button>
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedDate" class="card">
      <h2>Location Details</h2>
      <div style="display: flex; justifyContent: space-between; alignItems: flex-start">
        <div>
          <h3 style="margin: 0 0 0.5rem 0">
            {{ selectedDate.title || 'Selected Location' }}
          </h3>
          <p style="margin: 0 0 0.5rem 0; color: #666">
            {{ selectedDate.description || 'No description available' }}
          </p>
          <div style="fontSize: 0.9rem; color: #666">
            Coordinates: {{ selectedDate.lat?.toFixed(6) || 'N/A' }}, {{ selectedDate.lng?.toFixed(6) || 'N/A' }}
          </div>
        </div>
        <button
          class="btn btn-secondary"
          @click="selectedDate = null"
        >
          Close
        </button>
      </div>
    </div>

    <div v-if="showEventModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Add Event</h3>
          <button class="modal-close" @click="showEventModal = false">
            ×
          </button>
        </div>
        <div class="form-group">
          <label class="form-label">Event Title</label>
          <input
            type="text"
            class="form-control"
            v-model="newEvent.title"
            placeholder="Enter event title"
          />
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Date</label>
            <input
              type="date"
              class="form-control"
              v-model="newEvent.date"
            />
          </div>
          <div class="form-group">
            <label class="form-label">Time</label>
            <input
              type="time"
              class="form-control"
              v-model="newEvent.time"
            />
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Event Type</label>
          <select
            class="form-control"
            v-model="newEvent.type"
          >
            <option value="meeting">Meeting</option>
            <option value="deadline">Deadline</option>
            <option value="call">Call</option>
            <option value="workshop">Workshop</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Description</label>
          <textarea
            class="form-control"
            rows="3"
            v-model="newEvent.description"
            placeholder="Enter event description"
          />
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showEventModal = false">
            Cancel
          </button>
          <button class="btn" @click="addEvent">
            Add Event
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: new Date(),
      selectedDate: null,
      events: [
        { id: 1, title: 'Team Meeting', date: '2024-01-15', time: '10:00 AM', type: 'meeting' },
        { id: 2, title: 'Project Deadline', date: '2024-01-20', time: '5:00 PM', type: 'deadline' },
        { id: 3, title: 'Client Call', date: '2024-01-22', time: '2:00 PM', type: 'call' },
        { id: 4, title: 'Workshop', date: '2024-01-25', time: '9:00 AM', type: 'workshop' }
      ],
      showEventModal: false,
      newEvent: {
        title: '',
        date: '',
        time: '',
        type: 'meeting',
        description: ''
      }
    }
  },
  computed: {
    monthNames() {
      return [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ]
    },
    dayNames() {
      return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    },
    days() {
      const year = this.currentDate.getFullYear()
      const month = this.currentDate.getMonth()
      const firstDay = new Date(year, month, 1)
      const lastDay = new Date(year, month + 1, 0)
      const daysInMonth = lastDay.getDate()
      const startingDayOfWeek = firstDay.getDay()

      const days = []
      
      for (let i = 0; i < startingDayOfWeek; i++) {
        days.push(null)
      }
      
      for (let day = 1; day <= daysInMonth; day++) {
        days.push(new Date(year, month, day))
      }
      
      return days
    },
    sortedEvents() {
      return [...this.events].sort((a, b) => new Date(a.date + ' ' + a.time) - new Date(b.date + ' ' + b.time))
    }
  },
  methods: {
    getEventsForDate(date) {
      if (!date) return []
      const dateStr = date.toISOString().split('T')[0]
      return this.events.filter(event => event.date === dateStr)
    },
    navigateMonth(direction) {
      const newDate = new Date(this.currentDate)
      newDate.setMonth(this.currentDate.getMonth() + direction)
      this.currentDate = newDate
    },
    setCurrentDate(date) {
      this.currentDate = date
    },
    handleDateClick(date) {
      this.selectedDate = date
      this.newEvent = {
        title: '',
        date: date.toISOString().split('T')[0],
        time: '',
        type: 'meeting',
        description: ''
      }
      this.showEventModal = true
    },
    addEvent() {
      if (this.newEvent.title && this.newEvent.date && this.newEvent.time) {
        const event = {
          id: Date.now(),
          ...this.newEvent
        }
        this.events.push(event)
        this.showEventModal = false
        this.newEvent = { title: '', date: '', time: '', type: 'meeting', description: '' }
      }
    },
    deleteEvent(eventId) {
      this.events = this.events.filter(event => event.id !== eventId)
    },
    getEventTypeColor(type) {
      const colors = {
        meeting: '#007bff',
        deadline: '#dc3545',
        call: '#28a745',
        workshop: '#ffc107'
      }
      return colors[type] || '#6c757d'
    },
    isToday(date) {
      return date && date.toDateString() === new Date().toDateString()
    },
    isSameDay(date1, date2) {
      return date1 && date2 && date1.toDateString() === date2.toDateString()
    }
  }
}
</script>

<template>
  <div class="event-form">
    <h1>Event Planning Form</h1>
    <p>Create a new event by filling out the form below.</p>
    
    <form @submit.prevent="handleSubmit" class="form-container">
      <div class="form-group">
        <label class="form-label">Event Name *</label>
        <input
          type="text"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label class="form-label">Event Date *</label>
        <div class="date-picker-container">
          <input
            ref="dateInput"
            type="text"
            v-model="selectedDate"
            readonly
            @click="toggleDatePicker"
            class="form-input date-input"
            placeholder="Select a date"
          />
          
          <!-- Custom date picker traps keyboard focus inside -->
          <div v-if="isDatePickerOpen" class="date-picker" ref="datePicker" tabindex="-1">
            <div class="date-picker-header">
              <button type="button" @click="navigateMonth(-1)" class="nav-btn">‹</button>
              <h3>{{ currentMonthText }}</h3>
              <button type="button" @click="navigateMonth(1)" class="nav-btn">›</button>
            </div>
            
            <div class="date-picker-weekdays">
              <div v-for="day in weekdays" :key="day" class="weekday">{{ day }}</div>
            </div>
            
            <div class="date-picker-days">
              <button
                v-for="(day, index) in calendarDays"
                :key="index"
                type="button"
                @click="selectDate(day)"
                :class="['day-btn', { 'focused': focusedDate === day }]"
                :disabled="!day"
              >
                {{ day }}
              </button>
            </div>
            
            <div class="date-picker-instructions">
              Use arrow keys to navigate, Enter to select, Escape to close
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Event Description</label>
        <textarea
          rows="4"
          class="form-textarea"
        ></textarea>
      </div>

      <div class="form-actions">
        <button type="button" class="btn-secondary">Cancel</button>
        <button type="submit" class="btn-primary">Create Event</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: 'KeyboardTrapInWidget',
  data() {
    return {
      selectedDate: '',
      isDatePickerOpen: false,
      currentMonth: new Date(),
      focusedDate: null,
      weekdays: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    }
  },
  computed: {
    currentMonthText() {
      const months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ]
      return `${months[this.currentMonth.getMonth()]} ${this.currentMonth.getFullYear()}`
    },
    calendarDays() {
      const daysInMonth = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth() + 1, 0).getDate()
      const firstDay = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth(), 1).getDay()
      const days = []
      
      // Add empty cells for days before the first day of the month
      for (let i = 0; i < firstDay; i++) {
        days.push(null)
      }
      
      // Add days of the month
      for (let day = 1; day <= daysInMonth; day++) {
        days.push(day)
      }
      
      return days
    }
  },
  mounted() {
    this.setupKeyboardHandlers()
  },
  beforeDestroy() {
    document.removeEventListener('keydown', this.handleKeyDown)
  },
  methods: {
    toggleDatePicker() {
      this.isDatePickerOpen = !this.isDatePickerOpen
      if (this.isDatePickerOpen) {
        this.$nextTick(() => {
          this.$refs.datePicker.focus()
        })
      }
    },
    selectDate(day) {
      if (day) {
        const date = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth(), day)
        this.selectedDate = date.toLocaleDateString()
        this.isDatePickerOpen = false
        this.focusedDate = null
      }
    },
    navigateMonth(direction) {
      this.currentMonth = new Date(this.currentMonth.getFullYear(), this.currentMonth.getMonth() + direction)
    },
    setupKeyboardHandlers() {
      document.addEventListener('keydown', this.handleKeyDown)
    },
    handleKeyDown(e) {
      if (!this.isDatePickerOpen) return
      
      const days = this.calendarDays
      const currentIndex = this.focusedDate ? days.indexOf(this.focusedDate) : -1
      let newIndex = currentIndex
      
      switch (e.key) {
        case 'ArrowRight':
          e.preventDefault()
          newIndex = Math.min(currentIndex + 1, days.length - 1)
          break
        case 'ArrowLeft':
          e.preventDefault()
          newIndex = Math.max(currentIndex - 1, 0)
          break
        case 'ArrowDown':
          e.preventDefault()
          newIndex = Math.min(currentIndex + 7, days.length - 1)
          break
        case 'ArrowUp':
          e.preventDefault()
          newIndex = Math.max(currentIndex - 7, 0)
          break
        case 'Enter':
        case ' ':
          e.preventDefault()
          if (this.focusedDate) {
            this.selectDate(this.focusedDate)
          }
          break
        case 'Escape':
          e.preventDefault()
          this.isDatePickerOpen = false
          this.focusedDate = null
          this.$refs.dateInput.focus()
          break
        case 'Tab':
          // Prevent tab from escaping the date picker
          e.preventDefault()
          break
      }
      
      if (newIndex !== currentIndex && days[newIndex] !== null) {
        this.focusedDate = days[newIndex]
      }
    },
    handleSubmit() {
      alert('Form submitted successfully!')
    }
  }
}
</script>

<style scoped>
.event-form {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.form-container {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  border: 1px solid #e0e0e0;
}

.form-group {
  margin-bottom: 25px;
}

.form-label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #333;
}

.form-input, .form-textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
}

.date-picker-container {
  position: relative;
  display: inline-block;
}

.date-input {
  cursor: pointer;
  background: white;
}

.date-picker {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 1000;
  padding: 20px;
}

.date-picker-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.nav-btn {
  background: transparent;
  border: none;
  font-size: 18px;
  cursor: pointer;
  padding: 5px;
}

.date-picker-header h3 {
  margin: 0;
  font-size: 16px;
}

.date-picker-weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 2px;
  margin-bottom: 10px;
}

.weekday {
  padding: 8px;
  text-align: center;
  font-size: 12px;
  font-weight: bold;
  color: #666;
}

.date-picker-days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 2px;
}

.day-btn {
  padding: 8px;
  border: none;
  background: #f8f9fa;
  color: #333;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
}

.day-btn:disabled {
  background: transparent;
  color: transparent;
  cursor: default;
}

.day-btn.focused {
  background: #007bff;
  color: white;
}

.day-btn:hover:not(:disabled) {
  background: #e9ecef;
}

.day-btn.focused:hover {
  background: #0056b3;
}

.date-picker-instructions {
  margin-top: 15px;
  padding: 10px;
  background: #f8f9fa;
  border-radius: 4px;
  font-size: 12px;
  color: #666;
  text-align: center;
}

.form-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
}

.btn-primary {
  background: #007bff;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

.btn-secondary {
  background: #6c757d;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}
</style>

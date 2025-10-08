import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';

interface CalendarDay {
  date: Date;
  dayNumber: number;
  isToday: boolean;
  isSelected: boolean;
  isEmpty: boolean;
  hasEvents: boolean;
  events: Event[];
}

interface Event {
  id: string;
  title: string;
  description: string;
  startTime: Date;
  endTime: Date;
  category: string;
  isAllDay: boolean;
  location: string;
  attendees: string[];
  recurring: string;
  reminders: string[];
}

@Component({
  selector: 'app-calendar-application',
  templateUrl: './calendar-application.page.html',
  styleUrls: ['./calendar-application.page.scss'],
})
export class CalendarApplicationPage implements OnInit {
  currentDate = new Date();
  selectedDate = new Date();
  viewMode = 'month';
  events: Event[] = [];
  calendarDays: CalendarDay[] = [];
  weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  weekDaysData: CalendarDay[] = [];
  dayEvents: Event[] = [];
  isLoading = false;
  showEventModal = false;
  showEventDetails = false;
  selectedEvent: Event | null = null;
  newEvent: Partial<Event> = {
    title: '',
    description: '',
    startTime: new Date(),
    endTime: new Date(),
    category: 'personal',
    isAllDay: false,
    location: '',
    attendees: [],
    recurring: 'none',
    reminders: []
  };

  categories = [
    { id: 'personal', name: 'Personal', color: '#4CAF50' },
    { id: 'work', name: 'Work', color: '#2196F3' },
    { id: 'meeting', name: 'Meeting', color: '#FF9800' },
    { id: 'appointment', name: 'Appointment', color: '#9C27B0' },
    { id: 'reminder', name: 'Reminder', color: '#F44336' }
  ];

  constructor(
    private alertController: AlertController,
    private modalController: ModalController
  ) {}

  ngOnInit() {
    this.loadEvents();
  }

  get currentDateText(): string {
    return this.currentDate.toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  async loadEvents() {
    this.isLoading = true;
    
    // Simulate API call
    setTimeout(() => {
      this.events = this.generateSampleEvents();
      this.updateCalendar();
      this.isLoading = false;
    }, 1000);
  }

  generateSampleEvents(): Event[] {
    return [
      {
        id: '1',
        title: 'Team Meeting',
        description: 'Weekly team standup',
        startTime: new Date(2024, 0, 15, 10, 0),
        endTime: new Date(2024, 0, 15, 11, 0),
        category: 'work',
        isAllDay: false,
        location: 'Conference Room A',
        attendees: ['john@example.com', 'jane@example.com'],
        recurring: 'weekly',
        reminders: ['15min', '1hour']
      },
      {
        id: '2',
        title: 'Doctor Appointment',
        description: 'Annual checkup',
        startTime: new Date(2024, 0, 16, 14, 30),
        endTime: new Date(2024, 0, 16, 15, 30),
        category: 'appointment',
        isAllDay: false,
        location: 'Medical Center',
        attendees: [],
        recurring: 'none',
        reminders: ['1day', '2hours']
      },
      {
        id: '3',
        title: 'Project Deadline',
        description: 'Submit final report',
        startTime: new Date(2024, 0, 20, 17, 0),
        endTime: new Date(2024, 0, 20, 17, 0),
        category: 'work',
        isAllDay: true,
        location: '',
        attendees: [],
        recurring: 'none',
        reminders: ['1week', '1day']
      }
    ];
  }

  updateCalendar() {
    if (this.viewMode === 'month') {
      this.updateMonthView();
    } else if (this.viewMode === 'week') {
      this.updateWeekView();
    } else if (this.viewMode === 'day') {
      this.updateDayView();
    }
  }

  updateMonthView() {
    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const startingDayOfWeek = firstDay.getDay();

    this.calendarDays = [];

    // Add empty cells for days before the first day of the month
    for (let i = 0; i < startingDayOfWeek; i++) {
      this.calendarDays.push({
        date: new Date(0),
        dayNumber: 0,
        isToday: false,
        isSelected: false,
        isEmpty: true,
        hasEvents: false,
        events: []
      });
    }

    // Add days of the month
    for (let day = 1; day <= lastDay.getDate(); day++) {
      const date = new Date(year, month, day);
      const dayEvents = this.getEventsForDate(date);
      const isToday = this.isSameDay(date, new Date());
      const isSelected = this.isSameDay(date, this.selectedDate);

      this.calendarDays.push({
        date: date,
        dayNumber: day,
        isToday: isToday,
        isSelected: isSelected,
        isEmpty: false,
        hasEvents: dayEvents.length > 0,
        events: dayEvents
      });
    }
  }

  updateWeekView() {
    const startOfWeek = new Date(this.currentDate);
    startOfWeek.setDate(this.currentDate.getDate() - this.currentDate.getDay());
    
    this.weekDaysData = [];
    
    for (let i = 0; i < 7; i++) {
      const date = new Date(startOfWeek);
      date.setDate(startOfWeek.getDate() + i);
      const dayEvents = this.getEventsForDate(date);
      const isToday = this.isSameDay(date, new Date());
      const isSelected = this.isSameDay(date, this.selectedDate);

      this.weekDaysData.push({
        date: date,
        dayNumber: date.getDate(),
        isToday: isToday,
        isSelected: isSelected,
        isEmpty: false,
        hasEvents: dayEvents.length > 0,
        events: dayEvents
      });
    }
  }

  updateDayView() {
    this.dayEvents = this.getEventsForDate(this.currentDate);
  }

  getEventsForDate(date: Date): Event[] {
    return this.events.filter(event => {
      const eventDate = new Date(event.startTime);
      return this.isSameDay(eventDate, date);
    });
  }

  isSameDay(date1: Date, date2: Date): boolean {
    return date1.getFullYear() === date2.getFullYear() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getDate() === date2.getDate();
  }

  getCategoryColor(category: string): string {
    const categoryObj = this.categories.find(c => c.id === category);
    return categoryObj ? categoryObj.color : '#2196F3';
  }

  getMonthName(month: number): string {
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
                   'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month];
  }

  onTodayClicked() {
    this.currentDate = new Date();
    this.selectedDate = new Date();
    this.updateCalendar();
  }

  onCreateEventClicked() {
    this.newEvent = {
      title: '',
      description: '',
      startTime: this.selectedDate,
      endTime: new Date(this.selectedDate.getTime() + 60 * 60 * 1000),
      category: 'personal',
      isAllDay: false,
      location: '',
      attendees: [],
      recurring: 'none',
      reminders: []
    };
    this.showEventModal = true;
  }

  onViewModeChanged() {
    this.updateCalendar();
  }

  onPreviousClicked() {
    if (this.viewMode === 'month') {
      this.currentDate.setMonth(this.currentDate.getMonth() - 1);
    } else if (this.viewMode === 'week') {
      this.currentDate.setDate(this.currentDate.getDate() - 7);
    } else {
      this.currentDate.setDate(this.currentDate.getDate() - 1);
    }
    this.updateCalendar();
  }

  onNextClicked() {
    if (this.viewMode === 'month') {
      this.currentDate.setMonth(this.currentDate.getMonth() + 1);
    } else if (this.viewMode === 'week') {
      this.currentDate.setDate(this.currentDate.getDate() + 7);
    } else {
      this.currentDate.setDate(this.currentDate.getDate() + 1);
    }
    this.updateCalendar();
  }

  onDayClicked(day: CalendarDay) {
    if (day.isEmpty) return;
    
    this.selectedDate = day.date;
    
    if (day.hasEvents) {
      this.selectedEvent = day.events[0];
      this.showEventDetails = true;
    } else {
      this.onCreateEventClicked();
    }
    
    this.updateCalendar();
  }

  onEventModalDismissed() {
    this.showEventModal = false;
  }

  onEventDetailsDismissed() {
    this.showEventDetails = false;
  }

  async onSaveEvent() {
    if (!this.newEvent.title?.trim()) {
      const alert = await this.alertController.create({
        header: 'Error',
        message: 'Please enter a title for the event',
        buttons: ['OK']
      });
      await alert.present();
      return;
    }

    const event: Event = {
      id: Date.now().toString(),
      title: this.newEvent.title!,
      description: this.newEvent.description || '',
      startTime: new Date(this.newEvent.startTime!),
      endTime: new Date(this.newEvent.endTime!),
      category: this.newEvent.category || 'personal',
      isAllDay: this.newEvent.isAllDay || false,
      location: this.newEvent.location || '',
      attendees: this.newEvent.attendees || [],
      recurring: this.newEvent.recurring || 'none',
      reminders: this.newEvent.reminders || []
    };

    this.events.push(event);
    this.showEventModal = false;
    this.updateCalendar();

    const alert = await this.alertController.create({
      header: 'Success',
      message: 'Event created successfully',
      buttons: ['OK']
    });
    await alert.present();
  }

  async onDeleteEvent() {
    if (!this.selectedEvent) return;

    const alert = await this.alertController.create({
      header: 'Delete Event',
      message: 'Are you sure you want to delete this event?',
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Delete',
          role: 'destructive',
          handler: () => {
            this.events = this.events.filter(event => event.id !== this.selectedEvent!.id);
            this.showEventDetails = false;
            this.updateCalendar();
          }
        }
      ]
    });
    await alert.present();
  }
}

import { Component, OnInit } from '@angular/core';

interface Event {
  id: number;
  title: string;
  start: Date;
  end: Date;
  category: string;
  recurring: boolean;
  reminder: number;
}

interface Step {
  id: number;
  title: string;
  description: string;
}

interface NewEvent {
  title: string;
  start: string;
  end: string;
  category: string;
  recurring: boolean;
  reminder: number;
}

@Component({
  selector: 'app-calendar-application',
  templateUrl: './calendar-application.component.html',
  styleUrls: ['./calendar-application.component.css']
})
export class CalendarApplicationComponent implements OnInit {
  currentDate: Date = new Date();
  view: 'month' | 'week' | 'day' = 'month';
  events: Event[] = [
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
  ];
  showEventForm: boolean = false;
  selectedEvent: Event | null = null;
  selectedDate: Date | null = null;
  showCategoryFilter: boolean = false;
  categoryFilter: string = 'all';
  newEvent: NewEvent = {
    title: '',
    start: '',
    end: '',
    category: 'work',
    recurring: false,
    reminder: 15
  };
  categories: { id: string; name: string; color: string }[] = [
    { id: 'work', name: 'Work', color: '#4caf50' },
    { id: 'personal', name: 'Personal', color: '#2196f3' },
    { id: 'health', name: 'Health', color: '#f44336' },
    { id: 'social', name: 'Social', color: '#ff9800' }
  ];
  timeSlots: string[] = Array.from({ length: 24 }, (_, i) => `${i.toString().padStart(2, '0')}:00`);

  constructor() { }

  ngOnInit(): void {
  }

  getDaysInMonth(): (Date | null)[] {
    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();
    const startingDayOfWeek = firstDay.getDay();

    const days: (Date | null)[] = [];
    
    for (let i = 0; i < startingDayOfWeek; i++) {
      days.push(null);
    }
    
    for (let day = 1; day <= daysInMonth; day++) {
      days.push(new Date(year, month, day));
    }
    
    return days;
  }

  getEventsForDate(date: Date): Event[] {
    if (!date) return [];
    
    return this.events.filter(event => {
      const eventDate = new Date(event.start);
      return eventDate.toDateString() === date.toDateString();
    });
  }

  getStartOfWeek(): Date {
    const startOfWeek = new Date(this.currentDate);
    startOfWeek.setDate(this.currentDate.getDate() - this.currentDate.getDay());
    return startOfWeek;
  }

  getWeekDate(dayIndex: number): Date {
    const startOfWeek = this.getStartOfWeek();
    const date = new Date(startOfWeek);
    date.setDate(startOfWeek.getDate() + dayIndex - 1);
    return date;
  }

  isToday(date: Date): boolean {
    return date && date.toDateString() === new Date().toDateString();
  }

  isCurrentMonth(date: Date): boolean {
    return date && date.getMonth() === this.currentDate.getMonth();
  }

  getMonthName(): string {
    return this.currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
  }

  getDayName(): string {
    return this.currentDate.toLocaleDateString('en-US', { 
      weekday: 'long', 
      month: 'long', 
      day: 'numeric', 
      year: 'numeric' 
    });
  }

  formatTime(date: Date): string {
    return new Date(date).toLocaleTimeString('en-US', { 
      hour: 'numeric', 
      minute: '2-digit' 
    });
  }

  getEventStyle(event: Event): { [key: string]: string } {
    const startHours = event.start.getHours() + event.start.getMinutes() / 60;
    const duration = (event.end.getTime() - event.start.getTime()) / (1000 * 60 * 60);
    
    return {
      'top.px': (startHours * 40).toString(),
      'height.px': (duration * 40).toString()
    };
  }

  handleDateClick(date: Date): void {
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
  }

  handleEventClick(event: Event): void {
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
  }

  closeEventForm(): void {
    this.showEventForm = false;
    this.selectedEvent = null;
    this.selectedDate = null;
  }

  handleSaveEvent(): void {
    if (!this.newEvent.title.trim()) return;

    const eventData: Event = {
      ...this.newEvent,
      start: new Date(this.newEvent.start),
      end: new Date(this.newEvent.end),
      id: this.selectedEvent ? this.selectedEvent.id : Date.now()
    };

    if (this.selectedEvent) {
      this.events = this.events.map(event => 
        event.id === this.selectedEvent!.id ? eventData : event
      );
    } else {
      this.events.push(eventData);
    }

    this.closeEventForm();
  }

  handleDeleteEvent(): void {
    if (this.selectedEvent) {
      this.events = this.events.filter(event => event.id !== this.selectedEvent!.id);
      this.closeEventForm();
    }
  }

  navigateMonth(direction: number): void {
    const newDate = new Date(this.currentDate);
    newDate.setMonth(this.currentDate.getMonth() + direction);
    this.currentDate = newDate;
  }

  navigateWeek(direction: number): void {
    const newDate = new Date(this.currentDate);
    newDate.setDate(this.currentDate.getDate() + (direction * 7));
    this.currentDate = newDate;
  }

  navigateDay(direction: number): void {
    const newDate = new Date(this.currentDate);
    newDate.setDate(this.currentDate.getDate() + direction);
    this.currentDate = newDate;
  }

  getCategoryName(categoryId: string): string {
    const category = this.categories.find(c => c.id === categoryId);
    return category ? category.name : 'All Categories';
  }

  getCategoryColor(categoryId: string): string {
    const category = this.categories.find(c => c.id === categoryId);
    return category ? category.color : '#4caf50';
  }

  getFilteredEvents(): Event[] {
    return this.categoryFilter === 'all' 
      ? this.events 
      : this.events.filter(event => event.category === this.categoryFilter);
  }
}

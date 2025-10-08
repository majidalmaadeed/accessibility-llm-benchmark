#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, GLib, Pango
from datetime import datetime, timedelta
import calendar

class CalendarApplication(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Calendar Application")
        self.set_default_size(1000, 700)
        self.set_border_width(10)
        
        # Data
        self.current_date = datetime.now()
        self.selected_date = datetime.now()
        self.events = []
        self.current_view_mode = "Month"
        
        # Load sample data
        self.load_sample_events()
        
        # Create UI
        self.create_ui()
        
        # Update calendar
        self.update_calendar()
    
    def create_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Header
        header_box = self.create_header()
        main_box.pack_start(header_box, False, False, 0)
        
        # Date label
        self.date_label = Gtk.Label()
        self.date_label.set_markup("<span size='large' weight='bold'>January 2024</span>")
        self.date_label.set_margin_top(16)
        self.date_label.set_margin_bottom(16)
        main_box.pack_start(self.date_label, False, False, 0)
        
        # Calendar content
        self.calendar_content = Gtk.Notebook()
        main_box.pack_start(self.calendar_content, True, True, 0)
        
        # Create views
        self.create_month_view()
        self.create_week_view()
        self.create_day_view()
        
        # Status bar
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        status_box.set_margin_top(8)
        status_box.set_margin_bottom(8)
        
        self.status_label = Gtk.Label("Ready")
        status_box.pack_start(self.status_label, True, True, 0)
        
        main_box.pack_start(status_box, False, False, 0)
    
    def create_header(self):
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        header_box.set_margin_bottom(16)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold' foreground='white'>Calendar</span>")
        header_box.pack_start(title_label, True, True, 0)
        
        # Navigation buttons
        nav_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        
        self.prev_button = Gtk.Button(label="◀")
        self.prev_button.connect("clicked", self.on_previous_clicked)
        nav_box.pack_start(self.prev_button, False, False, 0)
        
        self.next_button = Gtk.Button(label="▶")
        self.next_button.connect("clicked", self.on_next_clicked)
        nav_box.pack_start(self.next_button, False, False, 0)
        
        header_box.pack_start(nav_box, False, False, 0)
        
        # View mode and create event
        controls_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        
        # View mode combo
        self.view_mode_combo = Gtk.ComboBoxText()
        self.view_mode_combo.append_text("Month")
        self.view_mode_combo.append_text("Week")
        self.view_mode_combo.append_text("Day")
        self.view_mode_combo.set_active(0)
        self.view_mode_combo.connect("changed", self.on_view_mode_changed)
        controls_box.pack_start(self.view_mode_combo, False, False, 0)
        
        # Create event button
        self.create_event_button = Gtk.Button(label="+ New Event")
        self.create_event_button.connect("clicked", self.on_create_event_clicked)
        controls_box.pack_start(self.create_event_button, False, False, 0)
        
        header_box.pack_start(controls_box, False, False, 0)
        
        # Style header
        header_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.2, 0.4, 0.8, 1.0))
        
        return header_box
    
    def create_month_view(self):
        month_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        month_box.set_margin_start(24)
        month_box.set_margin_end(24)
        
        # Day headers
        day_headers = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=4)
        
        for day in day_headers:
            label = Gtk.Label()
            label.set_markup("<span weight='bold'>" + day + "</span>")
            label.set_hexpand(True)
            label.set_halign(Gtk.Align.CENTER)
            header_box.pack_start(label, True, True, 0)
        
        month_box.pack_start(header_box, False, False, 0)
        
        # Calendar grid
        self.calendar_grid = Gtk.Grid()
        self.calendar_grid.set_column_homogeneous(True)
        self.calendar_grid.set_row_homogeneous(True)
        month_box.pack_start(self.calendar_grid, True, True, 0)
        
        self.calendar_content.append_page(month_box, Gtk.Label("Month"))
    
    def create_week_view(self):
        week_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=2)
        week_box.set_margin_start(24)
        week_box.set_margin_end(24)
        
        self.week_days = []
        for i in range(7):
            day_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
            day_box.set_hexpand(True)
            
            # Day header
            day_label = Gtk.Label()
            day_label.set_markup("<span weight='bold'>Mon</span>")
            day_box.pack_start(day_label, False, False, 0)
            
            # Day number
            day_number = Gtk.Label()
            day_number.set_markup("<span size='large'>1</span>")
            day_box.pack_start(day_number, False, False, 0)
            
            # Events list
            events_list = Gtk.ListBox()
            events_list.set_vexpand(True)
            day_box.pack_start(events_list, True, True, 0)
            
            week_box.pack_start(day_box, True, True, 0)
            self.week_days.append({
                'day_label': day_label,
                'day_number': day_number,
                'events_list': events_list
            })
        
        self.calendar_content.append_page(week_box, Gtk.Label("Week"))
    
    def create_day_view(self):
        day_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        day_box.set_margin_start(24)
        day_box.set_margin_end(24)
        
        # Day date label
        self.day_date_label = Gtk.Label()
        self.day_date_label.set_markup("<span size='x-large' weight='bold'>Monday, January 1, 2024</span>")
        day_box.pack_start(self.day_date_label, False, False, 0)
        
        # Events list
        self.day_events_list = Gtk.ListBox()
        self.day_events_list.set_vexpand(True)
        day_box.pack_start(self.day_events_list, True, True, 0)
        
        self.calendar_content.append_page(day_box, Gtk.Label("Day"))
    
    def load_sample_events(self):
        self.events = [
            {
                'id': '1',
                'title': 'Team Meeting',
                'description': 'Weekly team standup',
                'start_time': datetime.now() + timedelta(days=1),
                'end_time': datetime.now() + timedelta(days=1, hours=1),
                'category': 'work',
                'is_all_day': False,
                'location': 'Conference Room A',
                'attendees': ['john@example.com', 'jane@example.com'],
                'recurring': 'weekly',
                'reminders': ['15min', '1hour']
            },
            {
                'id': '2',
                'title': 'Doctor Appointment',
                'description': 'Annual checkup',
                'start_time': datetime.now() + timedelta(days=2, hours=14, minutes=30),
                'end_time': datetime.now() + timedelta(days=2, hours=15, minutes=30),
                'category': 'appointment',
                'is_all_day': False,
                'location': 'Medical Center',
                'attendees': [],
                'recurring': 'none',
                'reminders': ['1day', '2hours']
            },
            {
                'id': '3',
                'title': 'Project Deadline',
                'description': 'Submit final report',
                'start_time': datetime.now() + timedelta(days=5, hours=17),
                'end_time': datetime.now() + timedelta(days=5, hours=18),
                'category': 'work',
                'is_all_day': True,
                'location': '',
                'attendees': [],
                'recurring': 'none',
                'reminders': ['1week', '1day']
            }
        ]
    
    def update_calendar(self):
        # Update date label
        self.date_label.set_markup(f"<span size='large' weight='bold'>{self.current_date.strftime('%B %Y')}</span>")
        
        # Update based on view mode
        if self.current_view_mode == "Month":
            self.update_month_view()
        elif self.current_view_mode == "Week":
            self.update_week_view()
        elif self.current_view_mode == "Day":
            self.update_day_view()
    
    def update_month_view(self):
        # Clear existing buttons
        for child in self.calendar_grid.get_children():
            self.calendar_grid.remove(child)
        
        # Get calendar data
        cal = calendar.monthcalendar(self.current_date.year, self.current_date.month)
        first_day = datetime(self.current_date.year, self.current_date.month, 1)
        start_date = first_day - timedelta(days=first_day.weekday())
        
        # Create day buttons
        for week in range(6):
            for day in range(7):
                day_date = start_date + timedelta(days=week * 7 + day)
                day_button = self.create_day_button(day_date)
                self.calendar_grid.attach(day_button, day, week, 1, 1)
    
    def create_day_button(self, date):
        button = Gtk.Button()
        button.set_hexpand(True)
        button.set_vexpand(True)
        
        # Get events for this date
        day_events = self.get_events_for_date(date)
        
        # Create button content
        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        
        # Day number
        day_label = Gtk.Label()
        day_label.set_markup(f"<span size='large'>{date.day}</span>")
        content_box.pack_start(day_label, True, True, 0)
        
        # Event indicators
        if day_events:
            events_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=2)
            for event in day_events[:3]:  # Show max 3 indicators
                indicator = Gtk.Label("•")
                indicator.set_markup(f"<span color='{self.get_category_color(event['category'])}'>•</span>")
                events_box.pack_start(indicator, False, False, 0)
            content_box.pack_start(events_box, False, False, 0)
        
        button.add(content_box)
        
        # Style button
        if date.date() == datetime.now().date():
            button.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.2, 0.4, 0.8, 1.0))
            day_label.set_markup(f"<span size='large' foreground='white'>{date.day}</span>")
        elif date.date() == self.selected_date.date():
            button.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(1.0, 1.0, 0.0, 1.0))
            day_label.set_markup(f"<span size='large' foreground='black'>{date.day}</span>")
        elif date.month != self.current_date.month:
            day_label.set_markup(f"<span size='large' foreground='gray'>{date.day}</span>")
        
        # Connect click handler
        button.connect("clicked", self.on_day_clicked, date)
        
        return button
    
    def update_week_view(self):
        # Get week start date
        week_start = self.current_date - timedelta(days=self.current_date.weekday())
        
        for i, day_data in enumerate(self.week_days):
            day_date = week_start + timedelta(days=i)
            
            # Update day labels
            day_data['day_label'].set_markup(f"<span weight='bold'>{day_date.strftime('%a')}</span>")
            day_data['day_number'].set_markup(f"<span size='large'>{day_date.day}</span>")
            
            # Clear and update events
            for child in day_data['events_list'].get_children():
                day_data['events_list'].remove(child)
            
            day_events = self.get_events_for_date(day_date)
            for event in day_events:
                event_row = Gtk.ListBoxRow()
                event_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
                
                time_label = Gtk.Label(event['start_time'].strftime('%H:%M'))
                time_label.set_markup(f"<span size='small'>{event['start_time'].strftime('%H:%M')}</span>")
                event_box.pack_start(time_label, False, False, 0)
                
                title_label = Gtk.Label(event['title'])
                title_label.set_hexpand(True)
                title_label.set_halign(Gtk.Align.START)
                event_box.pack_start(title_label, True, True, 0)
                
                event_row.add(event_box)
                day_data['events_list'].add(event_row)
            
            day_data['events_list'].show_all()
    
    def update_day_view(self):
        # Update day date label
        self.day_date_label.set_markup(f"<span size='x-large' weight='bold'>{self.current_date.strftime('%A, %B %d, %Y')}</span>")
        
        # Clear and update events
        for child in self.day_events_list.get_children():
            self.day_events_list.remove(child)
        
        day_events = self.get_events_for_date(self.current_date)
        for event in day_events:
            event_row = self.create_event_detail_row(event)
            self.day_events_list.add(event_row)
        
        self.day_events_list.show_all()
    
    def create_event_detail_row(self, event):
        row = Gtk.ListBoxRow()
        
        event_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        event_box.set_margin_start(16)
        event_box.set_margin_end(16)
        event_box.set_margin_top(12)
        event_box.set_margin_bottom(12)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup(f"<span size='large' weight='bold'>{event['title']}</span>")
        title_label.set_halign(Gtk.Align.START)
        event_box.pack_start(title_label, False, False, 0)
        
        # Time
        time_text = event['start_time'].strftime('%I:%M %p')
        if not event['is_all_day']:
            time_text += f" - {event['end_time'].strftime('%I:%M %p')}"
        else:
            time_text = "All Day"
        
        time_label = Gtk.Label(time_text)
        time_label.set_markup(f"<span size='small'>{time_text}</span>")
        time_label.set_halign(Gtk.Align.START)
        event_box.pack_start(time_label, False, False, 0)
        
        # Description
        if event['description']:
            desc_label = Gtk.Label(event['description'])
            desc_label.set_halign(Gtk.Align.START)
            desc_label.set_line_wrap(True)
            event_box.pack_start(desc_label, False, False, 0)
        
        # Location
        if event['location']:
            loc_label = Gtk.Label(f"📍 {event['location']}")
            loc_label.set_halign(Gtk.Align.START)
            event_box.pack_start(loc_label, False, False, 0)
        
        # Category
        cat_label = Gtk.Label()
        cat_label.set_markup(f"<span size='small' foreground='{self.get_category_color(event['category'])}'>{event['category'].upper()}</span>")
        cat_label.set_halign(Gtk.Align.START)
        event_box.pack_start(cat_label, False, False, 0)
        
        row.add(event_box)
        return row
    
    def get_events_for_date(self, date):
        return [event for event in self.events if event['start_time'].date() == date.date()]
    
    def get_category_color(self, category):
        colors = {
            'work': 'blue',
            'personal': 'green',
            'appointment': 'purple',
            'meeting': 'orange',
            'reminder': 'red'
        }
        return colors.get(category, 'blue')
    
    def on_previous_clicked(self, button):
        if self.current_view_mode == "Month":
            self.current_date = self.current_date.replace(month=self.current_date.month - 1) if self.current_date.month > 1 else self.current_date.replace(year=self.current_date.year - 1, month=12)
        elif self.current_view_mode == "Week":
            self.current_date = self.current_date - timedelta(weeks=1)
        elif self.current_view_mode == "Day":
            self.current_date = self.current_date - timedelta(days=1)
        
        self.update_calendar()
    
    def on_next_clicked(self, button):
        if self.current_view_mode == "Month":
            self.current_date = self.current_date.replace(month=self.current_date.month + 1) if self.current_date.month < 12 else self.current_date.replace(year=self.current_date.year + 1, month=1)
        elif self.current_view_mode == "Week":
            self.current_date = self.current_date + timedelta(weeks=1)
        elif self.current_view_mode == "Day":
            self.current_date = self.current_date + timedelta(days=1)
        
        self.update_calendar()
    
    def on_view_mode_changed(self, combo):
        self.current_view_mode = combo.get_active_text()
        self.calendar_content.set_current_page(combo.get_active())
        self.update_calendar()
    
    def on_create_event_clicked(self, button):
        dialog = CreateEventDialog(self)
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            new_event = dialog.get_event()
            if new_event:
                self.events.append(new_event)
                self.update_calendar()
        dialog.destroy()
    
    def on_day_clicked(self, button, date):
        self.selected_date = date
        day_events = self.get_events_for_date(date)
        
        if day_events:
            self.show_event_details(day_events[0])
        else:
            self.on_create_event_clicked(None)
        
        self.update_calendar()
    
    def show_event_details(self, event):
        dialog = EventDetailsDialog(self, event)
        response = dialog.run()
        if response == Gtk.ResponseType.ACCEPT:  # Delete
            self.events = [e for e in self.events if e['id'] != event['id']]
            self.update_calendar()
        dialog.destroy()

class CreateEventDialog(Gtk.Dialog):
    def __init__(self, parent):
        Gtk.Dialog.__init__(self, "Create Event", parent, 0,
                           (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                            Gtk.STOCK_OK, Gtk.ResponseType.OK))
        
        self.set_default_size(400, 500)
        
        # Create form
        content_area = self.get_content_area()
        content_area.set_spacing(16)
        
        # Title
        title_label = Gtk.Label("Title:")
        title_label.set_halign(Gtk.Align.START)
        content_area.pack_start(title_label, False, False, 0)
        
        self.title_entry = Gtk.Entry()
        content_area.pack_start(self.title_entry, False, False, 0)
        
        # Description
        desc_label = Gtk.Label("Description:")
        desc_label.set_halign(Gtk.Align.START)
        content_area.pack_start(desc_label, False, False, 0)
        
        self.desc_textview = Gtk.TextView()
        self.desc_textview.set_size_request(-1, 80)
        content_area.pack_start(self.desc_textview, False, False, 0)
        
        # Start date/time
        start_label = Gtk.Label("Start Date & Time:")
        start_label.set_halign(Gtk.Align.START)
        content_area.pack_start(start_label, False, False, 0)
        
        start_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        
        self.start_date = Gtk.Calendar()
        self.start_date.set_display_options(Gtk.CalendarDisplayOptions.SHOW_HEADING | Gtk.CalendarDisplayOptions.SHOW_DAY_NAMES | Gtk.CalendarDisplayOptions.SHOW_WEEK_NUMBERS)
        start_box.pack_start(self.start_date, True, True, 0)
        
        time_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        
        self.start_hour = Gtk.SpinButton()
        self.start_hour.set_range(0, 23)
        self.start_hour.set_value(datetime.now().hour)
        time_box.pack_start(Gtk.Label("Hour:"), False, False, 0)
        time_box.pack_start(self.start_hour, False, False, 0)
        
        self.start_minute = Gtk.SpinButton()
        self.start_minute.set_range(0, 59)
        self.start_minute.set_value(datetime.now().minute)
        time_box.pack_start(Gtk.Label("Minute:"), False, False, 0)
        time_box.pack_start(self.start_minute, False, False, 0)
        
        start_box.pack_start(time_box, False, False, 0)
        content_area.pack_start(start_box, False, False, 0)
        
        # End date/time
        end_label = Gtk.Label("End Date & Time:")
        end_label.set_halign(Gtk.Align.START)
        content_area.pack_start(end_label, False, False, 0)
        
        end_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        
        self.end_date = Gtk.Calendar()
        self.end_date.set_display_options(Gtk.CalendarDisplayOptions.SHOW_HEADING | Gtk.CalendarDisplayOptions.SHOW_DAY_NAMES | Gtk.CalendarDisplayOptions.SHOW_WEEK_NUMBERS)
        end_box.pack_start(self.end_date, True, True, 0)
        
        end_time_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        
        self.end_hour = Gtk.SpinButton()
        self.end_hour.set_range(0, 23)
        self.end_hour.set_value(datetime.now().hour + 1)
        end_time_box.pack_start(Gtk.Label("Hour:"), False, False, 0)
        end_time_box.pack_start(self.end_hour, False, False, 0)
        
        self.end_minute = Gtk.SpinButton()
        self.end_minute.set_range(0, 59)
        self.end_minute.set_value(datetime.now().minute)
        end_time_box.pack_start(Gtk.Label("Minute:"), False, False, 0)
        end_time_box.pack_start(self.end_minute, False, False, 0)
        
        end_box.pack_start(end_time_box, False, False, 0)
        content_area.pack_start(end_box, False, False, 0)
        
        # Category
        cat_label = Gtk.Label("Category:")
        cat_label.set_halign(Gtk.Align.START)
        content_area.pack_start(cat_label, False, False, 0)
        
        self.category_combo = Gtk.ComboBoxText()
        self.category_combo.append_text("personal")
        self.category_combo.append_text("work")
        self.category_combo.append_text("meeting")
        self.category_combo.append_text("appointment")
        self.category_combo.append_text("reminder")
        self.category_combo.set_active(0)
        content_area.pack_start(self.category_combo, False, False, 0)
        
        # Location
        loc_label = Gtk.Label("Location:")
        loc_label.set_halign(Gtk.Align.START)
        content_area.pack_start(loc_label, False, False, 0)
        
        self.location_entry = Gtk.Entry()
        content_area.pack_start(self.location_entry, False, False, 0)
        
        # All day checkbox
        self.all_day_check = Gtk.CheckButton("All Day Event")
        content_area.pack_start(self.all_day_check, False, False, 0)
        
        self.show_all()
    
    def get_event(self):
        title = self.title_entry.get_text().strip()
        if not title:
            return None
        
        description = self.desc_textview.get_buffer().get_text(self.desc_textview.get_buffer().get_start_iter(), self.desc_textview.get_buffer().get_end_iter(), False)
        
        start_date = self.start_date.get_date()
        start_time = datetime(start_date.year, start_date.month, start_date.day, 
                             int(self.start_hour.get_value()), int(self.start_minute.get_value()))
        
        end_date = self.end_date.get_date()
        end_time = datetime(end_date.year, end_date.month, end_date.day,
                           int(self.end_hour.get_value()), int(self.end_minute.get_value()))
        
        return {
            'id': str(datetime.now().timestamp()),
            'title': title,
            'description': description,
            'start_time': start_time,
            'end_time': end_time,
            'category': self.category_combo.get_active_text(),
            'is_all_day': self.all_day_check.get_active(),
            'location': self.location_entry.get_text().strip(),
            'attendees': [],
            'recurring': 'none',
            'reminders': []
        }

class EventDetailsDialog(Gtk.Dialog):
    def __init__(self, parent, event):
        Gtk.Dialog.__init__(self, "Event Details", parent, 0,
                           (Gtk.STOCK_DELETE, Gtk.ResponseType.ACCEPT,
                            Gtk.STOCK_CLOSE, Gtk.ResponseType.CANCEL))
        
        self.set_default_size(400, 300)
        
        content_area = self.get_content_area()
        content_area.set_spacing(16)
        
        # Event title
        title_label = Gtk.Label()
        title_label.set_markup(f"<span size='large' weight='bold'>{event['title']}</span>")
        title_label.set_halign(Gtk.Align.START)
        content_area.pack_start(title_label, False, False, 0)
        
        # Event details
        details_text = f"{event['description']}\n\n"
        details_text += f"Time: {event['start_time'].strftime('%B %d, %Y %I:%M %p')}"
        if not event['is_all_day']:
            details_text += f" - {event['end_time'].strftime('%I:%M %p')}"
        else:
            details_text += " (All Day)"
        
        if event['location']:
            details_text += f"\nLocation: {event['location']}"
        
        details_text += f"\nCategory: {event['category']}"
        details_text += f"\nRecurring: {event['recurring']}"
        
        details_label = Gtk.Label(details_text)
        details_label.set_halign(Gtk.Align.START)
        details_label.set_line_wrap(True)
        content_area.pack_start(details_label, False, False, 0)
        
        self.show_all()

def main():
    app = CalendarApplication()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

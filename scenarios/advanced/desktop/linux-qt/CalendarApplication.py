#!/usr/bin/env python3

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QGridLayout, QLabel, QPushButton, 
                             QComboBox, QListWidget, QListWidgetItem, QTextEdit,
                             QDialog, QFormLayout, QLineEdit, QDateTimeEdit,
                             QCheckBox, QMessageBox, QFrame, QScrollArea)
from PyQt5.QtCore import Qt, QDate, QTime, QDateTime, pyqtSignal
from PyQt5.QtGui import QFont, QPalette, QColor, QIcon
from datetime import datetime, timedelta
import calendar

class CalendarApplication(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Calendar Application")
        self.setGeometry(100, 100, 1000, 700)
        
        # Data
        self.current_date = QDate.currentDate()
        self.selected_date = QDate.currentDate()
        self.events = []
        self.current_view_mode = "Month"
        
        # Load sample data
        self.load_sample_events()
        
        # Create UI
        self.create_ui()
        
        # Update calendar
        self.update_calendar()
    
    def create_ui(self):
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        
        # Header
        header_widget = self.create_header()
        main_layout.addWidget(header_widget)
        
        # Date label
        self.date_label = QLabel()
        self.date_label.setFont(QFont("Arial", 16, QFont.Bold))
        self.date_label.setAlignment(Qt.AlignCenter)
        self.date_label.setStyleSheet("padding: 16px;")
        main_layout.addWidget(self.date_label)
        
        # Calendar content
        self.calendar_content = QWidget()
        self.calendar_layout = QVBoxLayout()
        self.calendar_content.setLayout(self.calendar_layout)
        main_layout.addWidget(self.calendar_content)
        
        # Status bar
        self.status_bar = self.statusBar()
        self.status_bar.showMessage("Ready")
    
    def create_header(self):
        header_widget = QFrame()
        header_widget.setStyleSheet("""
            QFrame {
                background-color: #4A90E2;
                padding: 20px;
                border: none;
            }
        """)
        
        header_layout = QHBoxLayout()
        header_widget.setLayout(header_layout)
        
        # Title
        title_label = QLabel("Calendar")
        title_label.setStyleSheet("""
            QLabel {
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
        """)
        header_layout.addWidget(title_label)
        
        header_layout.addStretch()
        
        # Navigation buttons
        nav_layout = QHBoxLayout()
        
        self.prev_button = QPushButton("◀")
        self.prev_button.setStyleSheet("""
            QPushButton {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 16px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        """)
        self.prev_button.clicked.connect(self.on_previous_clicked)
        nav_layout.addWidget(self.prev_button)
        
        self.next_button = QPushButton("▶")
        self.next_button.setStyleSheet("""
            QPushButton {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 16px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        """)
        self.next_button.clicked.connect(self.on_next_clicked)
        nav_layout.addWidget(self.next_button)
        
        header_layout.addLayout(nav_layout)
        
        # View mode and create event
        controls_layout = QHBoxLayout()
        
        # View mode combo
        self.view_mode_combo = QComboBox()
        self.view_mode_combo.addItems(["Month", "Week", "Day"])
        self.view_mode_combo.setStyleSheet("""
            QComboBox {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px;
                border-radius: 4px;
            }
        """)
        self.view_mode_combo.currentTextChanged.connect(self.on_view_mode_changed)
        controls_layout.addWidget(self.view_mode_combo)
        
        # Create event button
        self.create_event_button = QPushButton("+ New Event")
        self.create_event_button.setStyleSheet("""
            QPushButton {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        """)
        self.create_event_button.clicked.connect(self.on_create_event_clicked)
        controls_layout.addWidget(self.create_event_button)
        
        header_layout.addLayout(controls_layout)
        
        return header_widget
    
    def load_sample_events(self):
        self.events = [
            {
                'id': '1',
                'title': 'Team Meeting',
                'description': 'Weekly team standup',
                'start_time': QDateTime.currentDateTime().addDays(1).addSecs(10 * 3600),
                'end_time': QDateTime.currentDateTime().addDays(1).addSecs(11 * 3600),
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
                'start_time': QDateTime.currentDateTime().addDays(2).addSecs(14.5 * 3600),
                'end_time': QDateTime.currentDateTime().addDays(2).addSecs(15.5 * 3600),
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
                'start_time': QDateTime.currentDateTime().addDays(5).addSecs(17 * 3600),
                'end_time': QDateTime.currentDateTime().addDays(5).addSecs(18 * 3600),
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
        self.date_label.setText(self.current_date.toString("MMMM yyyy"))
        
        # Clear existing content
        for i in reversed(range(self.calendar_layout.count())):
            self.calendar_layout.itemAt(i).widget().setParent(None)
        
        # Update based on view mode
        if self.current_view_mode == "Month":
            self.update_month_view()
        elif self.current_view_mode == "Week":
            self.update_week_view()
        elif self.current_view_mode == "Day":
            self.update_day_view()
    
    def update_month_view(self):
        # Day headers
        day_headers = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        header_layout = QHBoxLayout()
        
        for day in day_headers:
            label = QLabel(day)
            label.setAlignment(Qt.AlignCenter)
            label.setFont(QFont("Arial", 12, QFont.Bold))
            header_layout.addWidget(label)
        
        self.calendar_layout.addLayout(header_layout)
        
        # Calendar grid
        grid_layout = QGridLayout()
        grid_layout.setSpacing(4)
        
        # Get calendar data
        year = self.current_date.year()
        month = self.current_date.month()
        first_day = QDate(year, month, 1)
        start_date = first_day.addDays(-first_day.dayOfWeek() % 7)
        
        # Create day buttons
        for week in range(6):
            for day in range(7):
                day_date = start_date.addDays(week * 7 + day)
                day_button = self.create_day_button(day_date)
                grid_layout.addWidget(day_button, week, day)
        
        self.calendar_layout.addLayout(grid_layout)
    
    def create_day_button(self, date):
        button = QPushButton(str(date.day()))
        button.setMinimumSize(40, 40)
        button.setMaximumSize(40, 40)
        
        # Get events for this date
        day_events = self.get_events_for_date(date)
        
        # Style button
        if date == QDate.currentDate():
            button.setStyleSheet("""
                QPushButton {
                    background-color: #4A90E2;
                    color: white;
                    border: none;
                    border-radius: 4px;
                    font-weight: bold;
                }
            """)
        elif date == self.selected_date:
            button.setStyleSheet("""
                QPushButton {
                    background-color: #FFD700;
                    color: black;
                    border: none;
                    border-radius: 4px;
                    font-weight: bold;
                }
            """)
        elif date.month() != self.current_date.month():
            button.setStyleSheet("""
                QPushButton {
                    background-color: #F0F0F0;
                    color: #999999;
                    border: none;
                    border-radius: 4px;
                }
            """)
        else:
            button.setStyleSheet("""
                QPushButton {
                    background-color: white;
                    color: black;
                    border: 1px solid #E0E0E0;
                    border-radius: 4px;
                }
                QPushButton:hover {
                    background-color: #F5F5F5;
                }
            """)
        
        # Add event indicators
        if day_events:
            button.setText(button.text() + " •")
        
        # Connect click handler
        button.clicked.connect(lambda: self.on_day_clicked(date))
        
        return button
    
    def update_week_view(self):
        # Get week start date
        week_start = self.current_date.addDays(-self.current_date.dayOfWeek() % 7)
        
        week_layout = QHBoxLayout()
        week_layout.setSpacing(2)
        
        for i in range(7):
            day_date = week_start.addDays(i)
            day_widget = self.create_week_day_widget(day_date)
            week_layout.addWidget(day_widget)
        
        self.calendar_layout.addLayout(week_layout)
    
    def create_week_day_widget(self, date):
        day_widget = QFrame()
        day_widget.setStyleSheet("""
            QFrame {
                background-color: #F8F8F8;
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                padding: 8px;
            }
        """)
        
        day_layout = QVBoxLayout()
        day_widget.setLayout(day_layout)
        
        # Day header
        day_label = QLabel(date.toString("ddd"))
        day_label.setAlignment(Qt.AlignCenter)
        day_label.setFont(QFont("Arial", 12, QFont.Bold))
        day_layout.addWidget(day_label)
        
        # Day number
        day_number = QLabel(str(date.day()))
        day_number.setAlignment(Qt.AlignCenter)
        day_number.setFont(QFont("Arial", 16))
        day_layout.addWidget(day_number)
        
        # Events list
        events_list = QListWidget()
        events_list.setMaximumHeight(200)
        
        day_events = self.get_events_for_date(date)
        for event in day_events:
            item = QListWidgetItem(f"{event['title']} - {event['start_time'].toString('hh:mm')}")
            events_list.addItem(item)
        
        day_layout.addWidget(events_list)
        
        return day_widget
    
    def update_day_view(self):
        # Day date label
        day_date_label = QLabel(self.current_date.toString("dddd, MMMM d, yyyy"))
        day_date_label.setFont(QFont("Arial", 18, QFont.Bold))
        day_date_label.setAlignment(Qt.AlignCenter)
        day_date_label.setStyleSheet("padding: 16px;")
        self.calendar_layout.addWidget(day_date_label)
        
        # Events list
        events_list = QListWidget()
        
        day_events = self.get_events_for_date(self.current_date)
        for event in day_events:
            item = QListWidgetItem()
            item_widget = self.create_event_detail_widget(event)
            item.setSizeHint(item_widget.sizeHint())
            events_list.addItem(item)
            events_list.setItemWidget(item, item_widget)
        
        self.calendar_layout.addWidget(events_list)
    
    def create_event_detail_widget(self, event):
        widget = QFrame()
        widget.setStyleSheet("""
            QFrame {
                background-color: white;
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                padding: 16px;
                margin: 4px;
            }
        """)
        
        layout = QVBoxLayout()
        widget.setLayout(layout)
        
        # Title
        title_label = QLabel(event['title'])
        title_label.setFont(QFont("Arial", 14, QFont.Bold))
        layout.addWidget(title_label)
        
        # Time
        time_text = event['start_time'].toString("h:mm AP")
        if not event['is_all_day']:
            time_text += f" - {event['end_time'].toString('h:mm AP')}"
        else:
            time_text = "All Day"
        
        time_label = QLabel(time_text)
        time_label.setFont(QFont("Arial", 12))
        time_label.setStyleSheet("color: #666666;")
        layout.addWidget(time_label)
        
        # Description
        if event['description']:
            desc_label = QLabel(event['description'])
            desc_label.setWordWrap(True)
            desc_label.setStyleSheet("color: #666666;")
            layout.addWidget(desc_label)
        
        # Location
        if event['location']:
            loc_label = QLabel(f"📍 {event['location']}")
            loc_label.setStyleSheet("color: #666666;")
            layout.addWidget(loc_label)
        
        # Category
        cat_label = QLabel(event['category'].upper())
        cat_label.setStyleSheet(f"""
            QLabel {{
                color: {self.get_category_color(event['category'])};
                font-weight: bold;
                background-color: {self.get_category_color(event['category'])}20;
                padding: 4px 8px;
                border-radius: 4px;
            }}
        """)
        layout.addWidget(cat_label)
        
        return widget
    
    def get_events_for_date(self, date):
        return [event for event in self.events if event['start_time'].date() == date]
    
    def get_category_color(self, category):
        colors = {
            'work': '#4A90E2',
            'personal': '#7ED321',
            'appointment': '#9013FE',
            'meeting': '#F5A623',
            'reminder': '#D0021B'
        }
        return colors.get(category, '#4A90E2')
    
    def on_previous_clicked(self):
        if self.current_view_mode == "Month":
            self.current_date = self.current_date.addMonths(-1)
        elif self.current_view_mode == "Week":
            self.current_date = self.current_date.addDays(-7)
        elif self.current_view_mode == "Day":
            self.current_date = self.current_date.addDays(-1)
        
        self.update_calendar()
    
    def on_next_clicked(self):
        if self.current_view_mode == "Month":
            self.current_date = self.current_date.addMonths(1)
        elif self.current_view_mode == "Week":
            self.current_date = self.current_date.addDays(7)
        elif self.current_view_mode == "Day":
            self.current_date = self.current_date.addDays(1)
        
        self.update_calendar()
    
    def on_view_mode_changed(self, mode):
        self.current_view_mode = mode
        self.update_calendar()
    
    def on_create_event_clicked(self):
        dialog = CreateEventDialog(self)
        if dialog.exec_() == QDialog.Accepted:
            new_event = dialog.get_event()
            if new_event:
                self.events.append(new_event)
                self.update_calendar()
    
    def on_day_clicked(self, date):
        self.selected_date = date
        day_events = self.get_events_for_date(date)
        
        if day_events:
            self.show_event_details(day_events[0])
        else:
            self.on_create_event_clicked()
        
        self.update_calendar()
    
    def show_event_details(self, event):
        dialog = EventDetailsDialog(self, event)
        if dialog.exec_() == QDialog.Accepted:
            # Delete event
            self.events = [e for e in self.events if e['id'] != event['id']]
            self.update_calendar()

class CreateEventDialog(QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle("Create Event")
        self.setModal(True)
        self.resize(400, 500)
        
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # Form layout
        form_layout = QFormLayout()
        
        # Title
        self.title_edit = QLineEdit()
        form_layout.addRow("Title:", self.title_edit)
        
        # Description
        self.desc_edit = QTextEdit()
        self.desc_edit.setMaximumHeight(80)
        form_layout.addRow("Description:", self.desc_edit)
        
        # Start date/time
        self.start_datetime = QDateTimeEdit()
        self.start_datetime.setDateTime(QDateTime.currentDateTime())
        form_layout.addRow("Start Date & Time:", self.start_datetime)
        
        # End date/time
        self.end_datetime = QDateTimeEdit()
        self.end_datetime.setDateTime(QDateTime.currentDateTime().addSecs(3600))
        form_layout.addRow("End Date & Time:", self.end_datetime)
        
        # Category
        self.category_combo = QComboBox()
        self.category_combo.addItems(["personal", "work", "meeting", "appointment", "reminder"])
        form_layout.addRow("Category:", self.category_combo)
        
        # Location
        self.location_edit = QLineEdit()
        form_layout.addRow("Location:", self.location_edit)
        
        # All day checkbox
        self.all_day_check = QCheckBox("All Day Event")
        form_layout.addRow("", self.all_day_check)
        
        layout.addLayout(form_layout)
        
        # Buttons
        button_layout = QHBoxLayout()
        
        cancel_button = QPushButton("Cancel")
        cancel_button.clicked.connect(self.reject)
        button_layout.addWidget(cancel_button)
        
        save_button = QPushButton("Save")
        save_button.clicked.connect(self.accept)
        button_layout.addWidget(save_button)
        
        layout.addLayout(button_layout)
    
    def get_event(self):
        title = self.title_edit.text().strip()
        if not title:
            return None
        
        description = self.desc_edit.toPlainText()
        start_time = self.start_datetime.dateTime()
        end_time = self.end_datetime.dateTime()
        category = self.category_combo.currentText()
        location = self.location_edit.text().strip()
        is_all_day = self.all_day_check.isChecked()
        
        return {
            'id': str(datetime.now().timestamp()),
            'title': title,
            'description': description,
            'start_time': start_time,
            'end_time': end_time,
            'category': category,
            'is_all_day': is_all_day,
            'location': location,
            'attendees': [],
            'recurring': 'none',
            'reminders': []
        }

class EventDetailsDialog(QDialog):
    def __init__(self, parent, event):
        super().__init__(parent)
        self.setWindowTitle("Event Details")
        self.setModal(True)
        self.resize(400, 300)
        self.event = event
        
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # Event details
        details_text = f"{self.event['title']}\n\n"
        details_text += f"{self.event['description']}\n\n"
        details_text += f"Time: {self.event['start_time'].toString('MMMM d, yyyy h:mm AP')}"
        if not self.event['is_all_day']:
            details_text += f" - {self.event['end_time'].toString('h:mm AP')}"
        else:
            details_text += " (All Day)"
        
        if self.event['location']:
            details_text += f"\nLocation: {self.event['location']}"
        
        details_text += f"\nCategory: {self.event['category']}"
        details_text += f"\nRecurring: {self.event['recurring']}"
        
        details_label = QLabel(details_text)
        details_label.setWordWrap(True)
        layout.addWidget(details_label)
        
        # Buttons
        button_layout = QHBoxLayout()
        
        delete_button = QPushButton("Delete")
        delete_button.setStyleSheet("QPushButton { background-color: #D0021B; color: white; }")
        delete_button.clicked.connect(self.accept)
        button_layout.addWidget(delete_button)
        
        close_button = QPushButton("Close")
        close_button.clicked.connect(self.reject)
        button_layout.addWidget(close_button)
        
        layout.addLayout(button_layout)

def main():
    app = QApplication(sys.argv)
    
    # Set application style
    app.setStyle('Fusion')
    
    # Set color palette
    palette = QPalette()
    palette.setColor(QPalette.Window, QColor(240, 240, 240))
    palette.setColor(QPalette.WindowText, QColor(0, 0, 0))
    app.setPalette(palette)
    
    window = CalendarApplication()
    window.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

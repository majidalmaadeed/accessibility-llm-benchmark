import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QLineEdit, QTextEdit, 
                             QCalendarWidget, QSpinBox, QMessageBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class KeyboardTrapInWidget(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Event Scheduler")
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(20)
        main_layout.setContentsMargins(20, 20, 20, 20)
        
        # Header
        header_layout = QVBoxLayout()
        header_layout.setAlignment(Qt.AlignCenter)
        
        title_label = QLabel("Event Scheduler")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(title_label)
        
        subtitle_label = QLabel("Create and manage your events")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(header_layout)
        
        # Event form
        form_frame = QFrame()
        form_frame.setFrameStyle(QFrame.Box)
        form_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        form_layout = QVBoxLayout(form_frame)
        form_layout.setSpacing(20)
        form_layout.setContentsMargins(20, 20, 20, 20)
        
        # Event title
        title_layout = QVBoxLayout()
        
        title_label = QLabel("Event Title")
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_layout.addWidget(title_label)
        
        self.title_entry = QLineEdit()
        self.title_entry.setPlaceholderText("Enter event title")
        self.title_entry.setFixedSize(300, 35)
        title_layout.addWidget(self.title_entry)
        
        form_layout.addLayout(title_layout)
        
        # Event description
        description_layout = QVBoxLayout()
        
        description_label = QLabel("Event Description")
        description_font = QFont()
        description_font.setPointSize(16)
        description_font.setBold(True)
        description_label.setFont(description_font)
        description_layout.addWidget(description_label)
        
        self.description_text = QTextEdit()
        self.description_text.setFixedSize(300, 100)
        description_layout.addWidget(self.description_text)
        
        form_layout.addLayout(description_layout)
        
        # Date and time selection
        datetime_layout = QHBoxLayout()
        datetime_layout.setSpacing(20)
        
        # Date selection - KEYBOARD TRAP IN WIDGET
        date_layout = QVBoxLayout()
        
        date_label = QLabel("Event Date")
        date_font = QFont()
        date_font.setPointSize(16)
        date_font.setBold(True)
        date_label.setFont(date_font)
        date_layout.addWidget(date_label)
        
        self.date_button = QPushButton("📅 Select Date")
        self.date_button.setFixedSize(150, 35)
        self.date_button.clicked.connect(self.on_date_button_clicked)
        date_layout.addWidget(self.date_button)
        
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.date_picker_frame = QFrame()
        self.date_picker_frame.setFrameStyle(QFrame.Box)
        self.date_picker_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        self.date_picker_frame.setVisible(False)
        
        date_picker_layout = QVBoxLayout(self.date_picker_frame)
        date_picker_layout.setSpacing(10)
        date_picker_layout.setContentsMargins(10, 10, 10, 10)
        
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.date_picker = QCalendarWidget()
        self.date_picker.selectionChanged.connect(self.on_date_selected)
        date_picker_layout.addWidget(self.date_picker)
        
        # Date picker buttons
        date_buttons_layout = QHBoxLayout()
        date_buttons_layout.setSpacing(10)
        
        date_cancel_button = QPushButton("Cancel")
        date_cancel_button.clicked.connect(self.on_date_cancel_clicked)
        date_buttons_layout.addWidget(date_cancel_button)
        
        date_done_button = QPushButton("Done")
        date_done_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        date_done_button.clicked.connect(self.on_date_done_clicked)
        date_buttons_layout.addWidget(date_done_button)
        
        date_picker_layout.addLayout(date_buttons_layout)
        date_layout.addWidget(self.date_picker_frame)
        
        datetime_layout.addLayout(date_layout)
        
        # Time selection - KEYBOARD TRAP IN WIDGET
        time_layout = QVBoxLayout()
        
        time_label = QLabel("Event Time")
        time_font = QFont()
        time_font.setPointSize(16)
        time_font.setBold(True)
        time_label.setFont(time_font)
        time_layout.addWidget(time_label)
        
        self.time_button = QPushButton("🕐 Select Time")
        self.time_button.setFixedSize(150, 35)
        self.time_button.clicked.connect(self.on_time_button_clicked)
        time_layout.addWidget(self.time_button)
        
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        self.time_picker_frame = QFrame()
        self.time_picker_frame.setFrameStyle(QFrame.Box)
        self.time_picker_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        self.time_picker_frame.setVisible(False)
        
        time_picker_layout = QVBoxLayout(self.time_picker_frame)
        time_picker_layout.setSpacing(10)
        time_picker_layout.setContentsMargins(10, 10, 10, 10)
        
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        time_picker_hbox = QHBoxLayout()
        
        self.hour_spin = QSpinBox()
        self.hour_spin.setRange(0, 23)
        self.hour_spin.setValue(12)
        time_picker_hbox.addWidget(self.hour_spin)
        
        colon_label = QLabel(":")
        time_picker_hbox.addWidget(colon_label)
        
        self.minute_spin = QSpinBox()
        self.minute_spin.setRange(0, 59)
        self.minute_spin.setValue(0)
        time_picker_hbox.addWidget(self.minute_spin)
        
        time_picker_layout.addLayout(time_picker_hbox)
        
        # Time picker buttons
        time_buttons_layout = QHBoxLayout()
        time_buttons_layout.setSpacing(10)
        
        time_cancel_button = QPushButton("Cancel")
        time_cancel_button.clicked.connect(self.on_time_cancel_clicked)
        time_buttons_layout.addWidget(time_cancel_button)
        
        time_done_button = QPushButton("Done")
        time_done_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        time_done_button.clicked.connect(self.on_time_done_clicked)
        time_buttons_layout.addWidget(time_done_button)
        
        time_picker_layout.addLayout(time_buttons_layout)
        time_layout.addWidget(self.time_picker_frame)
        
        datetime_layout.addLayout(time_layout)
        
        form_layout.addLayout(datetime_layout)
        
        # Event location
        location_layout = QVBoxLayout()
        
        location_label = QLabel("Event Location")
        location_font = QFont()
        location_font.setPointSize(16)
        location_font.setBold(True)
        location_label.setFont(location_font)
        location_layout.addWidget(location_label)
        
        self.location_entry = QLineEdit()
        self.location_entry.setPlaceholderText("Enter event location")
        self.location_entry.setFixedSize(300, 35)
        location_layout.addWidget(self.location_entry)
        
        form_layout.addLayout(location_layout)
        
        # Attendees
        attendees_layout = QVBoxLayout()
        
        attendees_label = QLabel("Attendees")
        attendees_font = QFont()
        attendees_font.setPointSize(16)
        attendees_font.setBold(True)
        attendees_label.setFont(attendees_font)
        attendees_layout.addWidget(attendees_label)
        
        self.attendees_entry = QLineEdit()
        self.attendees_entry.setPlaceholderText("Enter attendee emails")
        self.attendees_entry.setFixedSize(300, 35)
        attendees_layout.addWidget(self.attendees_entry)
        
        form_layout.addLayout(attendees_layout)
        
        main_layout.addWidget(form_frame)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        
        create_event_button = QPushButton("Create Event")
        create_event_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        create_event_button.setFixedSize(120, 40)
        create_event_button.clicked.connect(self.on_create_event_clicked)
        button_layout.addWidget(create_event_button)
        
        save_draft_button = QPushButton("Save Draft")
        save_draft_button.setFixedSize(120, 40)
        save_draft_button.clicked.connect(self.on_save_draft_clicked)
        button_layout.addWidget(save_draft_button)
        
        cancel_button = QPushButton("Cancel")
        cancel_button.setFixedSize(120, 40)
        cancel_button.clicked.connect(self.on_cancel_clicked)
        button_layout.addWidget(cancel_button)
        
        main_layout.addLayout(button_layout)
        
        # State
        self.selected_date = None
        self.selected_time = None
        self.is_date_picker_open = False
        self.is_time_picker_open = False
        
    def on_date_button_clicked(self):
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.is_date_picker_open = not self.is_date_picker_open
        self.date_picker_frame.setVisible(self.is_date_picker_open)
        
        if self.is_date_picker_open:
            # KEYBOARD TRAP IN WIDGET - Focus is trapped inside the date picker widget
            self.date_picker.setFocus()
    
    def on_time_button_clicked(self):
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        self.is_time_picker_open = not self.is_time_picker_open
        self.time_picker_frame.setVisible(self.is_time_picker_open)
        
        if self.is_time_picker_open:
            # KEYBOARD TRAP IN WIDGET - Focus is trapped inside the time picker widget
            self.hour_spin.setFocus()
    
    def on_date_selected(self):
        # Handle date selection
        pass
    
    def on_date_cancel_clicked(self):
        self.is_date_picker_open = False
        self.date_picker_frame.setVisible(False)
    
    def on_date_done_clicked(self):
        self.is_date_picker_open = False
        self.date_picker_frame.setVisible(False)
        # Update date button text
        date = self.date_picker.selectedDate()
        self.date_button.setText(f"📅 {date.toString('dd/MM/yyyy')}")
    
    def on_time_cancel_clicked(self):
        self.is_time_picker_open = False
        self.time_picker_frame.setVisible(False)
    
    def on_time_done_clicked(self):
        self.is_time_picker_open = False
        self.time_picker_frame.setVisible(False)
        # Update time button text
        hour = self.hour_spin.value()
        minute = self.minute_spin.value()
        self.time_button.setText(f"🕐 {hour:02d}:{minute:02d}")
    
    def on_create_event_clicked(self):
        QMessageBox.information(self, "Event Created", "Your event has been created successfully!")
    
    def on_save_draft_clicked(self):
        QMessageBox.information(self, "Draft Saved", "Your event draft has been saved!")
    
    def on_cancel_clicked(self):
        response = QMessageBox.question(self, "Cancel Event", 
                                       "Are you sure you want to cancel creating this event?",
                                       QMessageBox.Yes | QMessageBox.No)
        
        if response == QMessageBox.Yes:
            # Clear form
            self.title_entry.clear()
            self.description_text.clear()
            self.location_entry.clear()
            self.attendees_entry.clear()
            self.date_button.setText("📅 Select Date")
            self.time_button.setText("🕐 Select Time")

def main():
    app = QApplication(sys.argv)
    window = KeyboardTrapInWidget()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

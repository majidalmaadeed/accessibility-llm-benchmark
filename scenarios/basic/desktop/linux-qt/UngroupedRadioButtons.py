import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QRadioButton, QButtonGroup)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class UngroupedRadioButtons(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Contact Preferences")
        self.setGeometry(100, 100, 600, 500)
        
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
        
        title_label = QLabel("Contact Preferences")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(title_label)
        
        subtitle_label = QLabel("How would you like us to contact you?")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(header_layout)
        
        # Contact Method Section - UNGROUPED RADIO BUTTONS
        contact_frame = QFrame()
        contact_frame.setFrameStyle(QFrame.Box)
        contact_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        contact_layout = QVBoxLayout(contact_frame)
        contact_layout.setSpacing(15)
        contact_layout.setContentsMargins(20, 20, 20, 20)
        
        contact_title = QLabel("Preferred Contact Method")
        contact_title_font = QFont()
        contact_title_font.setPointSize(16)
        contact_title_font.setBold(True)
        contact_title.setFont(contact_title_font)
        contact_layout.addWidget(contact_title)
        
        # UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        self.contact_buttons = []
        contact_methods = [
            ("email", "Email"),
            ("phone", "Phone"),
            ("sms", "SMS"),
            ("mail", "Mail")
        ]
        
        for value, label in contact_methods:
            button = QRadioButton(label)
            if value == "email":
                button.setChecked(True)
                self.selected_contact_method = "email"
            button.toggled.connect(lambda checked, v=value: self.on_contact_method_changed(v) if checked else None)
            self.contact_buttons.append(button)
            contact_layout.addWidget(button)
        
        main_layout.addWidget(contact_frame)
        
        # Newsletter Subscription Section - UNGROUPED RADIO BUTTONS
        newsletter_frame = QFrame()
        newsletter_frame.setFrameStyle(QFrame.Box)
        newsletter_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        newsletter_layout = QVBoxLayout(newsletter_frame)
        newsletter_layout.setSpacing(15)
        newsletter_layout.setContentsMargins(20, 20, 20, 20)
        
        newsletter_title = QLabel("Newsletter Subscription")
        newsletter_title_font = QFont()
        newsletter_title_font.setPointSize(16)
        newsletter_title_font.setBold(True)
        newsletter_title.setFont(newsletter_title_font)
        newsletter_layout.addWidget(newsletter_title)
        
        # UNGROUPED RADIO BUTTONS - Newsletter preference radio buttons without fieldset grouping
        self.newsletter_buttons = []
        newsletter_options = [
            ("yes", "Yes, send me newsletters"),
            ("no", "No, don't send newsletters")
        ]
        
        for value, label in newsletter_options:
            button = QRadioButton(label)
            if value == "yes":
                button.setChecked(True)
                self.selected_newsletter = "yes"
            button.toggled.connect(lambda checked, v=value: self.on_newsletter_changed(v) if checked else None)
            self.newsletter_buttons.append(button)
            newsletter_layout.addWidget(button)
        
        main_layout.addWidget(newsletter_frame)
        
        # Notification Preferences Section - UNGROUPED RADIO BUTTONS
        notifications_frame = QFrame()
        notifications_frame.setFrameStyle(QFrame.Box)
        notifications_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        notifications_layout = QVBoxLayout(notifications_frame)
        notifications_layout.setSpacing(15)
        notifications_layout.setContentsMargins(20, 20, 20, 20)
        
        notifications_title = QLabel("Notification Preferences")
        notifications_title_font = QFont()
        notifications_title_font.setPointSize(16)
        notifications_title_font.setBold(True)
        notifications_title.setFont(notifications_title_font)
        notifications_layout.addWidget(notifications_title)
        
        # UNGROUPED RADIO BUTTONS - Notification preference radio buttons without fieldset grouping
        self.notification_buttons = []
        notification_options = [
            ("all", "All notifications"),
            ("important", "Important only"),
            ("none", "No notifications")
        ]
        
        for value, label in notification_options:
            button = QRadioButton(label)
            if value == "all":
                button.setChecked(True)
                self.selected_notifications = "all"
            button.toggled.connect(lambda checked, v=value: self.on_notifications_changed(v) if checked else None)
            self.notification_buttons.append(button)
            notifications_layout.addWidget(button)
        
        main_layout.addWidget(notifications_frame)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        button_layout.setSpacing(15)
        
        save_button = QPushButton("Save Preferences")
        save_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        save_button.setFixedSize(150, 40)
        save_button.clicked.connect(self.on_save_clicked)
        button_layout.addWidget(save_button)
        
        reset_button = QPushButton("Reset to Defaults")
        reset_button.setFixedSize(150, 40)
        reset_button.clicked.connect(self.on_reset_clicked)
        button_layout.addWidget(reset_button)
        
        main_layout.addLayout(button_layout)
        
    def on_contact_method_changed(self, value):
        self.selected_contact_method = value
    
    def on_newsletter_changed(self, value):
        self.selected_newsletter = value
    
    def on_notifications_changed(self, value):
        self.selected_notifications = value
    
    def on_save_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Preferences Saved", 
                               f"Contact Method: {self.selected_contact_method}\n"
                               f"Newsletter: {self.selected_newsletter}\n"
                               f"Notifications: {self.selected_notifications}")
    
    def on_reset_clicked(self):
        # Reset to defaults
        self.selected_contact_method = "email"
        self.selected_newsletter = "yes"
        self.selected_notifications = "all"
        
        # Reset contact method buttons
        for i, button in enumerate(self.contact_buttons):
            if i == 0:  # Email
                button.setChecked(True)
            else:
                button.setChecked(False)
        
        # Reset newsletter buttons
        for i, button in enumerate(self.newsletter_buttons):
            if i == 0:  # Yes
                button.setChecked(True)
            else:
                button.setChecked(False)
        
        # Reset notification buttons
        for i, button in enumerate(self.notification_buttons):
            if i == 0:  # All
                button.setChecked(True)
            else:
                button.setChecked(False)

def main():
    app = QApplication(sys.argv)
    window = UngroupedRadioButtons()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

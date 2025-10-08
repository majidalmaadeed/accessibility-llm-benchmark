import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QLineEdit, QMessageBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class InaccessibleTooltip(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Contact Form")
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
        
        title_label = QLabel("Contact Form")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(title_label)
        
        subtitle_label = QLabel("Please fill out the form below")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(header_layout)
        
        # Form
        form_frame = QFrame()
        form_frame.setFrameStyle(QFrame.Box)
        form_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        form_layout = QVBoxLayout(form_frame)
        form_layout.setSpacing(20)
        form_layout.setContentsMargins(20, 20, 20, 20)
        
        # Form fields
        self.form_fields = []
        
        # Full Name field
        name_layout = QVBoxLayout()
        
        name_label = QLabel("Full Name")
        name_font = QFont()
        name_font.setPointSize(16)
        name_font.setBold(True)
        name_label.setFont(name_font)
        name_layout.addWidget(name_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        name_field_layout = QHBoxLayout()
        
        self.name_entry = QLineEdit()
        self.name_entry.setPlaceholderText("Enter your full name")
        self.name_entry.setFixedSize(300, 35)
        name_field_layout.addWidget(self.name_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Enter your full legal name")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("name"))
        name_field_layout.addWidget(help_button)
        
        name_layout.addLayout(name_field_layout)
        form_layout.addLayout(name_layout)
        
        # Email field
        email_layout = QVBoxLayout()
        
        email_label = QLabel("Email Address")
        email_font = QFont()
        email_font.setPointSize(16)
        email_font.setBold(True)
        email_label.setFont(email_font)
        email_layout.addWidget(email_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        email_field_layout = QHBoxLayout()
        
        self.email_entry = QLineEdit()
        self.email_entry.setPlaceholderText("Enter your email")
        self.email_entry.setFixedSize(300, 35)
        email_field_layout.addWidget(self.email_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Enter a valid email address")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("email"))
        email_field_layout.addWidget(help_button)
        
        email_layout.addLayout(email_field_layout)
        form_layout.addLayout(email_layout)
        
        # Phone field
        phone_layout = QVBoxLayout()
        
        phone_label = QLabel("Phone Number")
        phone_font = QFont()
        phone_font.setPointSize(16)
        phone_font.setBold(True)
        phone_label.setFont(phone_font)
        phone_layout.addWidget(phone_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        phone_field_layout = QHBoxLayout()
        
        self.phone_entry = QLineEdit()
        self.phone_entry.setPlaceholderText("Enter your phone number")
        self.phone_entry.setFixedSize(300, 35)
        phone_field_layout.addWidget(self.phone_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Include country code if international")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("phone"))
        phone_field_layout.addWidget(help_button)
        
        phone_layout.addLayout(phone_field_layout)
        form_layout.addLayout(phone_layout)
        
        # Street Address field
        address_layout = QVBoxLayout()
        
        address_label = QLabel("Street Address")
        address_font = QFont()
        address_font.setPointSize(16)
        address_font.setBold(True)
        address_label.setFont(address_font)
        address_layout.addWidget(address_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        address_field_layout = QHBoxLayout()
        
        self.address_entry = QLineEdit()
        self.address_entry.setPlaceholderText("Enter your street address")
        self.address_entry.setFixedSize(300, 35)
        address_field_layout.addWidget(self.address_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Include apartment or suite number")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("address"))
        address_field_layout.addWidget(help_button)
        
        address_layout.addLayout(address_field_layout)
        form_layout.addLayout(address_layout)
        
        # City field
        city_layout = QVBoxLayout()
        
        city_label = QLabel("City")
        city_font = QFont()
        city_font.setPointSize(16)
        city_font.setBold(True)
        city_label.setFont(city_font)
        city_layout.addWidget(city_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        city_field_layout = QHBoxLayout()
        
        self.city_entry = QLineEdit()
        self.city_entry.setPlaceholderText("Enter your city")
        self.city_entry.setFixedSize(300, 35)
        city_field_layout.addWidget(self.city_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Enter the city name")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("city"))
        city_field_layout.addWidget(help_button)
        
        city_layout.addLayout(city_field_layout)
        form_layout.addLayout(city_layout)
        
        # ZIP Code field
        zip_layout = QVBoxLayout()
        
        zip_label = QLabel("ZIP Code")
        zip_font = QFont()
        zip_font.setPointSize(16)
        zip_font.setBold(True)
        zip_label.setFont(zip_font)
        zip_layout.addWidget(zip_label)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        zip_field_layout = QHBoxLayout()
        
        self.zip_entry = QLineEdit()
        self.zip_entry.setPlaceholderText("Enter your ZIP code")
        self.zip_entry.setFixedSize(300, 35)
        zip_field_layout.addWidget(self.zip_entry)
        
        help_button = QPushButton("?")
        help_button.setFixedSize(30, 30)
        help_button.setToolTip("Enter 5-digit ZIP code")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.clicked.connect(lambda: self.on_help_clicked("zip"))
        zip_field_layout.addWidget(help_button)
        
        zip_layout.addLayout(zip_field_layout)
        form_layout.addLayout(zip_layout)
        
        main_layout.addWidget(form_frame)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        
        submit_button = QPushButton("Submit Form")
        submit_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        submit_button.setFixedSize(120, 40)
        submit_button.clicked.connect(self.on_submit_clicked)
        button_layout.addWidget(submit_button)
        
        clear_button = QPushButton("Clear Form")
        clear_button.setFixedSize(120, 40)
        clear_button.clicked.connect(self.on_clear_clicked)
        button_layout.addWidget(clear_button)
        
        main_layout.addLayout(button_layout)
        
    def on_help_clicked(self, field_name):
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        # This method is called when the help button is clicked, but the tooltip is not accessible via keyboard
        help_messages = {
            "name": "Enter your full legal name as it appears on official documents.",
            "email": "Enter a valid email address where we can reach you.",
            "phone": "Include country code if international. Example: +1 (555) 123-4567",
            "address": "Include apartment or suite number if applicable.",
            "city": "Enter the city name where you reside.",
            "zip": "Enter your 5-digit ZIP code or postal code."
        }
        
        QMessageBox.information(self, "Help", help_messages.get(field_name, "Help information not available."))
    
    def on_submit_clicked(self):
        QMessageBox.information(self, "Form Submitted", "Your form has been submitted successfully!")
    
    def on_clear_clicked(self):
        self.name_entry.clear()
        self.email_entry.clear()
        self.phone_entry.clear()
        self.address_entry.clear()
        self.city_entry.clear()
        self.zip_entry.clear()

def main():
    app = QApplication(sys.argv)
    window = InaccessibleTooltip()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

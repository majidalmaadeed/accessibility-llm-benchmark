import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QLineEdit, QMessageBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class ColorOnlyErrorIndication(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Account Registration")
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
        
        title_label = QLabel("Create Account")
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
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.name_entry = QLineEdit()
        self.name_entry.setPlaceholderText("Enter your full name")
        self.name_entry.setFixedSize(300, 35)
        self.name_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        name_layout.addWidget(self.name_entry)
        
        form_layout.addLayout(name_layout)
        
        # Email field
        email_layout = QVBoxLayout()
        
        email_label = QLabel("Email Address")
        email_font = QFont()
        email_font.setPointSize(16)
        email_font.setBold(True)
        email_label.setFont(email_font)
        email_layout.addWidget(email_label)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.email_entry = QLineEdit()
        self.email_entry.setPlaceholderText("Enter your email")
        self.email_entry.setFixedSize(300, 35)
        self.email_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        email_layout.addWidget(self.email_entry)
        
        form_layout.addLayout(email_layout)
        
        # Password field
        password_layout = QVBoxLayout()
        
        password_label = QLabel("Password")
        password_font = QFont()
        password_font.setPointSize(16)
        password_font.setBold(True)
        password_label.setFont(password_font)
        password_layout.addWidget(password_label)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.password_entry = QLineEdit()
        self.password_entry.setPlaceholderText("Enter your password")
        self.password_entry.setEchoMode(QLineEdit.Password)
        self.password_entry.setFixedSize(300, 35)
        self.password_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        password_layout.addWidget(self.password_entry)
        
        form_layout.addLayout(password_layout)
        
        # Confirm Password field
        confirm_password_layout = QVBoxLayout()
        
        confirm_password_label = QLabel("Confirm Password")
        confirm_password_font = QFont()
        confirm_password_font.setPointSize(16)
        confirm_password_font.setBold(True)
        confirm_password_label.setFont(confirm_password_font)
        confirm_password_layout.addWidget(confirm_password_label)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.confirm_password_entry = QLineEdit()
        self.confirm_password_entry.setPlaceholderText("Confirm your password")
        self.confirm_password_entry.setEchoMode(QLineEdit.Password)
        self.confirm_password_entry.setFixedSize(300, 35)
        self.confirm_password_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        confirm_password_layout.addWidget(self.confirm_password_entry)
        
        form_layout.addLayout(confirm_password_layout)
        
        # Phone Number field
        phone_layout = QVBoxLayout()
        
        phone_label = QLabel("Phone Number")
        phone_font = QFont()
        phone_font.setPointSize(16)
        phone_font.setBold(True)
        phone_label.setFont(phone_font)
        phone_layout.addWidget(phone_label)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.phone_entry = QLineEdit()
        self.phone_entry.setPlaceholderText("Enter your phone number")
        self.phone_entry.setFixedSize(300, 35)
        self.phone_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        phone_layout.addWidget(self.phone_entry)
        
        form_layout.addLayout(phone_layout)
        
        # ZIP Code field
        zip_layout = QVBoxLayout()
        
        zip_label = QLabel("ZIP Code")
        zip_font = QFont()
        zip_font.setPointSize(16)
        zip_font.setBold(True)
        zip_label.setFont(zip_font)
        zip_layout.addWidget(zip_label)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.zip_entry = QLineEdit()
        self.zip_entry.setPlaceholderText("Enter your ZIP code")
        self.zip_entry.setFixedSize(300, 35)
        self.zip_entry.setStyleSheet("QLineEdit { border: 2px solid #ff0000; border-radius: 4px; }")  # Red border styling
        zip_layout.addWidget(self.zip_entry)
        
        form_layout.addLayout(zip_layout)
        
        main_layout.addWidget(form_frame)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        
        create_account_button = QPushButton("Create Account")
        create_account_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        create_account_button.setFixedSize(120, 40)
        create_account_button.clicked.connect(self.on_create_account_clicked)
        button_layout.addWidget(create_account_button)
        
        cancel_button = QPushButton("Cancel")
        cancel_button.setFixedSize(120, 40)
        cancel_button.clicked.connect(self.on_cancel_clicked)
        button_layout.addWidget(cancel_button)
        
        main_layout.addLayout(button_layout)
        
    def on_create_account_clicked(self):
        QMessageBox.information(self, "Account Created", "Your account has been created successfully!")
    
    def on_cancel_clicked(self):
        self.name_entry.clear()
        self.email_entry.clear()
        self.password_entry.clear()
        self.confirm_password_entry.clear()
        self.phone_entry.clear()
        self.zip_entry.clear()

def main():
    app = QApplication(sys.argv)
    window = ColorOnlyErrorIndication()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

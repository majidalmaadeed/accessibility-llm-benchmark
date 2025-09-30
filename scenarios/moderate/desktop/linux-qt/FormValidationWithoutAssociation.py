#!/usr/bin/env python3
"""
FormValidationWithoutAssociation - Linux Qt Implementation
"""
import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QFrame, QScrollArea, QMessageBox, QCheckBox,
                             QComboBox, QTextEdit)
from PyQt5.QtCore import Qt, QTimer, pyqtSignal
from PyQt5.QtGui import QFont, QPalette, QColor
class FormValidationWithoutAssociation(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setGeometry(100, 100, 600, 700)
        # State
        self.is_submitting = False
        self.setup_ui()
    def setup_ui(self):
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        # Main layout
        main_layout = QVBoxLayout()
        main_layout.setSpacing(20)
        main_layout.setContentsMargins(20, 20, 20, 20)
        central_widget.setLayout(main_layout)
        # Main content card
        main_card = QFrame()
        main_card.setFrameStyle(QFrame.Box | QFrame.Raised)
        main_card.setLineWidth(1)
        main_card.setStyleSheet("""
            QFrame {
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                padding: 20px;
            }
        """)
        card_layout = QVBoxLayout()
        card_layout.setSpacing(20)
        main_card.setLayout(card_layout)
        # Title
        # Description
        # Login form
        form_layout = QVBoxLayout()
        form_layout.setSpacing(20)
        # Username field
        username_layout = QVBoxLayout()
        username_layout.setSpacing(5)
        self.username_input = QLineEdit()
        self.username_input.setPlaceholderText("Enter username")
        self.username_input.setStyleSheet("""
            QLineEdit {
                padding: 10px;
                border: 2px solid #dddddd;
                border-radius: 4px;
                font-size: 16px;
            }
        """)
        self.username_input.textChanged.connect(self.on_username_changed)
        username_layout.addWidget(self.username_input)
        self.username_error.setStyleSheet("color: #dc3545;")
        self.username_error.setVisible(False)
        username_layout.addWidget(self.username_error)
        form_layout.addLayout(username_layout)
        # Password field
        password_layout = QVBoxLayout()
        password_layout.setSpacing(5)
        self.password_input = QLineEdit()
        self.password_input.setPlaceholderText("Enter password")
        self.password_input.setEchoMode(QLineEdit.Password)
        self.password_input.setStyleSheet("""
            QLineEdit {
                padding: 10px;
                border: 2px solid #dddddd;
                border-radius: 4px;
                font-size: 16px;
            }
        """)
        self.password_input.textChanged.connect(self.on_password_changed)
        password_layout.addWidget(self.password_input)
        self.password_error.setStyleSheet("color: #dc3545;")
        self.password_error.setVisible(False)
        password_layout.addWidget(self.password_error)
        form_layout.addLayout(password_layout)
        # Generic Error Message - NOT ASSOCIATED WITH SPECIFIC FIELDS
        self.generic_error_frame = QFrame()
        self.generic_error_frame.setStyleSheet("""
            QFrame {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
                padding: 10px;
            }
        """)
        self.generic_error_frame.setVisible(False)
        generic_error_layout = QHBoxLayout()
        generic_error_layout.setContentsMargins(10, 10, 10, 10)
        error_icon.setStyleSheet("color: #dc3545;")
        generic_error_layout.addWidget(error_icon)
        self.generic_error_message.setStyleSheet("color: #dc3545;")
        generic_error_layout.addWidget(self.generic_error_message)
        self.generic_error_frame.setLayout(generic_error_layout)
        form_layout.addWidget(self.generic_error_frame)
        # Login button
        self.login_button = QPushButton("Login")
        self.login_button.setStyleSheet("""
            QPushButton {
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 15px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #0056b3;
            }
            QPushButton:pressed {
                background-color: #004085;
            }
        """)
        self.login_button.clicked.connect(self.on_login_clicked)
        form_layout.addWidget(self.login_button)
        card_layout.addLayout(form_layout)
        main_layout.addWidget(main_card)
        info_frame = QFrame()
        info_frame.setFrameStyle(QFrame.Box | QFrame.Raised)
        info_frame.setLineWidth(1)
        info_frame.setStyleSheet("""
            QFrame {
                background-color: #e9ecef;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                padding: 20px;
            }
        """)
        info_layout = QVBoxLayout()
        info_layout.setSpacing(15)
        info_frame.setLayout(info_layout)
• Generic error: Generic error message doesn't specify which fields have issues
        issues_text.setStyleSheet("color: #666666; background-color: transparent; border: none;")
        issues_text.setReadOnly(True)
        issues_text.setMaximumHeight(100)
        info_layout.addWidget(issues_text)
        # How to Fix
        fix_title.setStyleSheet("color: #333333;")
        info_layout.addWidget(fix_title)
        fix_text = QTextEdit()
• Use specific error messages for each field
        fix_text.setStyleSheet("color: #666666; background-color: transparent; border: none;")
        fix_text.setReadOnly(True)
        fix_text.setMaximumHeight(100)
        info_layout.addWidget(fix_text)
        parent_layout.addWidget(info_frame)
        # Basic setup only
        self.username_input.setAccessibleName("Username input field")
        self.password_input.setAccessibleName("Password input field")
        self.login_button.setAccessibleName("Login button")
    def on_username_changed(self):
        self.clear_field_error("username")
    def on_password_changed(self):
        self.clear_field_error("password")
    def on_login_clicked(self):
        if self.is_submitting:
            return
        self.clear_all_errors()
        username = self.username_input.text().strip()
        password = self.password_input.text()
        has_errors = False
        # Validate username
        if not username:
            self.show_field_error("username", "Username is required")
            has_errors = True
        elif len(username) < 3:
            self.show_field_error("username", "Username must be at least 3 characters")
            has_errors = True
        # Validate password
        if not password:
            self.show_field_error("password", "Password is required")
            has_errors = True
        elif len(password) < 8:
            self.show_field_error("password", "Password must be at least 8 characters")
            has_errors = True
        if has_errors:
            # Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
            self.show_generic_error("Please fill in all required fields.")
            return
        # Simulate login process
        self.is_submitting = True
        self.login_button.setText("Logging in...")
        self.login_button.setEnabled(False)
        # Simulate API call
        QTimer.singleShot(2000, self.login_complete)
    def login_complete(self):
        self.is_submitting = False
        self.login_button.setText("Login")
        self.login_button.setEnabled(True)
        # Show success message
        QMessageBox.information(self, "Success", "Login successful!")
    def clear_all_errors(self):
        self.username_error.setVisible(False)
        self.password_error.setVisible(False)
        self.generic_error_frame.setVisible(False)
        # Reset field borders
        self.username_input.setStyleSheet("""
            QLineEdit {
                padding: 10px;
                border: 2px solid #dddddd;
                border-radius: 4px;
                font-size: 16px;
            }
        """)
        self.password_input.setStyleSheet("""
            QLineEdit {
                padding: 10px;
                border: 2px solid #dddddd;
                border-radius: 4px;
                font-size: 16px;
            }
        """)
    def clear_field_error(self, field_name):
        if field_name == "username":
            self.username_error.setVisible(False)
            self.username_input.setStyleSheet("""
                QLineEdit {
                    padding: 10px;
                    border: 2px solid #dddddd;
                    border-radius: 4px;
                    font-size: 16px;
                }
            """)
        elif field_name == "password":
            self.password_error.setVisible(False)
            self.password_input.setStyleSheet("""
                QLineEdit {
                    padding: 10px;
                    border: 2px solid #dddddd;
                    border-radius: 4px;
                    font-size: 16px;
                }
            """)
    def show_field_error(self, field_name, message):
        if field_name == "username":
            self.username_error.setText(message)
            self.username_error.setVisible(True)
            self.username_input.setStyleSheet("""
                QLineEdit {
                    padding: 10px;
                    border: 2px solid #dc3545;
                    border-radius: 4px;
                    font-size: 16px;
                }
            """)
        elif field_name == "password":
            self.password_error.setText(message)
            self.password_error.setVisible(True)
            self.password_input.setStyleSheet("""
                QLineEdit {
                    padding: 10px;
                    border: 2px solid #dc3545;
                    border-radius: 4px;
                    font-size: 16px;
                }
            """)
    def show_generic_error(self, message):
        self.generic_error_message.setText(message)
        self.generic_error_frame.setVisible(True)
def main():
    app = QApplication(sys.argv)
    window = FormValidationWithoutAssociation()
    window.show()
    sys.exit(app.exec_())
if __name__ == '__main__':
    main()

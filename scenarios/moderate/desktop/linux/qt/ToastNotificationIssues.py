#!/usr/bin/env python3
"""
ToastNotificationIssues - Linux Qt Implementation
"""
import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QScrollArea, QTextEdit, QSizePolicy)
from PyQt5.QtCore import Qt, QTimer, pyqtSignal, QPropertyAnimation, QEasingCurve
from PyQt5.QtGui import QFont, QPalette, QColor
class ToastNotificationIssues(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setGeometry(100, 100, 600, 700)
        # State
        self.notifications = []
        self.notification_count = 0
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
        # Notification Controls
        controls_layout = QVBoxLayout()
        controls_layout.setSpacing(15)
        # Success Notification
        self.show_success_button = QPushButton("Show Success Notification")
        self.show_success_button.setStyleSheet("""
            QPushButton {
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 15px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #218838;
            }
            QPushButton:pressed {
                background-color: #1e7e34;
            }
        """)
        self.show_success_button.clicked.connect(self.on_show_success_clicked)
        controls_layout.addWidget(self.show_success_button)
        # Error Notification
        self.show_error_button = QPushButton("Show Error Notification")
        self.show_error_button.setStyleSheet("""
            QPushButton {
                background-color: #dc3545;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 15px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #c82333;
            }
            QPushButton:pressed {
                background-color: #bd2130;
            }
        """)
        self.show_error_button.clicked.connect(self.on_show_error_clicked)
        controls_layout.addWidget(self.show_error_button)
        # Warning Notification
        self.show_warning_button = QPushButton("Show Warning Notification")
        self.show_warning_button.setStyleSheet("""
            QPushButton {
                background-color: #ffc107;
                color: #212529;
                border: none;
                border-radius: 4px;
                padding: 15px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #e0a800;
            }
            QPushButton:pressed {
                background-color: #d39e00;
            }
        """)
        self.show_warning_button.clicked.connect(self.on_show_warning_clicked)
        controls_layout.addWidget(self.show_warning_button)
        # Info Notification
        self.show_info_button = QPushButton("Show Info Notification")
        self.show_info_button.setStyleSheet("""
            QPushButton {
                background-color: #17a2b8;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 15px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #138496;
            }
            QPushButton:pressed {
                background-color: #117a8b;
            }
        """)
        self.show_info_button.clicked.connect(self.on_show_info_clicked)
        controls_layout.addWidget(self.show_info_button)
        # Clear All Button
        self.clear_all_button = QPushButton("Clear All Notifications")
        self.clear_all_button.setStyleSheet("""
            QPushButton {
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 10px;
                font-size: 14px;
            }
            QPushButton:hover {
                background-color: #5a6268;
            }
        """)
        self.clear_all_button.clicked.connect(self.on_clear_all_clicked)
        controls_layout.addWidget(self.clear_all_button)
        card_layout.addLayout(controls_layout)
        main_layout.addWidget(main_card)
        # Toast Notifications Container
        self.toast_container = QVBoxLayout()
        self.toast_container.setSpacing(10)
        main_layout.addLayout(self.toast_container)
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
• Missing dismiss button: No way to close notifications programmatically
• No auto-hide timer: Notifications don't disappear automatically
        issues_text.setStyleSheet("color: #666666;")
        issues_text.setWordWrap(True)
        info_layout.addWidget(issues_text)
        # How to Fix
        fix_title.setStyleSheet("color: #333333;")
        info_layout.addWidget(fix_title)
• Implement auto-hide timer with configurable duration
        fix_text.setStyleSheet("color: #666666;")
        fix_text.setWordWrap(True)
        info_layout.addWidget(fix_text)
        parent_layout.addWidget(info_frame)
        # Basic setup only
        self.show_success_button.setAccessibleName("Show Success Notification button")
        self.show_error_button.setAccessibleName("Show Error Notification button")
        self.show_warning_button.setAccessibleName("Show Warning Notification button")
        self.show_info_button.setAccessibleName("Show Info Notification button")
        self.clear_all_button.setAccessibleName("Clear All Notifications button")
    def on_show_success_clicked(self):
        self.show_toast("success", "Operation completed successfully!")
    def on_show_error_clicked(self):
        self.show_toast("error", "An error occurred while processing your request.")
    def on_show_warning_clicked(self):
        self.show_toast("warning", "Please review your input before proceeding.")
    def on_show_info_clicked(self):
        self.show_toast("info", "New updates are available for download.")
    def on_clear_all_clicked(self):
        self.clear_all_notifications()
    def show_toast(self, notification_type, message):
        self.notification_count += 1
        notification = {
            "id": self.notification_count,
            "type": notification_type,
            "message": message
        }
        self.notifications.insert(0, notification)
        # Create toast view
        toast_view = self.create_toast_view(notification)
        self.toast_container.insertWidget(0, toast_view)
        # Should implement auto-hide functionality with configurable duration
        # Basic auto-hide (5 seconds)
        QTimer.singleShot(5000, lambda: self.remove_toast(notification))
    def create_toast_view(self, notification):
        # Container
        container = QFrame()
        container.setFrameStyle(QFrame.Box | QFrame.Raised)
        container.setLineWidth(1)
        container.setStyleSheet(f"""
            QFrame {{
                background-color: {self.get_background_color_for_type(notification['type'])};
                border: 1px solid {self.get_border_color_for_type(notification['type'])};
                border-radius: 8px;
                padding: 15px;
            }}
        """)
        container.setAccessibleName(f"Toast {notification['id']}: {notification['type']} notification")
        # Content layout
        content_layout = QHBoxLayout()
        content_layout.setSpacing(10)
        content_layout.setContentsMargins(0, 0, 0, 0)
        container.setLayout(content_layout)
        # Icon
        # Message
        dismiss_button = QPushButton("×")
        dismiss_button.setFixedSize(24, 24)
        dismiss_button.setStyleSheet("""
            QPushButton {
                background-color: transparent;
                border: none;
                color: #666666;
            }
            QPushButton:hover {
                background-color: rgba(0, 0, 0, 0.1);
                border-radius: 12px;
            }
        """)
        dismiss_button.clicked.connect(lambda: self.on_dismiss_toast(notification['id']))
        content_layout.addWidget(dismiss_button)
        # Basic setup only
        container.setAccessibleName(f"Toast {notification['id']}: {notification['type']} notification")
        return container
    def get_icon_for_type(self, notification_type):
        icons = {
            "success": "✓",
            "error": "✗",
            "warning": "⚠",
            "info": "ℹ"
        }
        return icons.get(notification_type, "•")
    def get_color_for_type(self, notification_type):
        colors = {
            "success": "#28a745",
            "error": "#dc3545",
            "warning": "#ffc107",
            "info": "#17a2b8"
        }
        return colors.get(notification_type, "#666666")
    def get_background_color_for_type(self, notification_type):
        colors = {
            "success": "rgba(40, 167, 69, 0.1)",
            "error": "rgba(220, 53, 69, 0.1)",
            "warning": "rgba(255, 193, 7, 0.1)",
            "info": "rgba(23, 162, 184, 0.1)"
        }
        return colors.get(notification_type, "rgba(108, 117, 125, 0.1)")
    def get_border_color_for_type(self, notification_type):
        colors = {
            "success": "rgba(40, 167, 69, 0.3)",
            "error": "rgba(220, 53, 69, 0.3)",
            "warning": "rgba(255, 193, 7, 0.3)",
            "info": "rgba(23, 162, 184, 0.3)"
        }
        return colors.get(notification_type, "rgba(108, 117, 125, 0.3)")
    def on_dismiss_toast(self, notification_id):
        self.remove_toast_by_id(notification_id)
    def remove_toast(self, notification):
        self.remove_toast_by_id(notification['id'])
    def remove_toast_by_id(self, notification_id):
        # Remove from notifications list
        self.notifications = [n for n in self.notifications if n['id'] != notification_id]
        # Remove from UI
        for i in range(self.toast_container.count()):
            widget = self.toast_container.itemAt(i).widget()
            if widget and widget.accessibleName() == f"Toast {notification_id}: {self.get_type_for_id(notification_id)} notification":
                self.toast_container.removeWidget(widget)
                widget.deleteLater()
                break
    def get_type_for_id(self, notification_id):
        for notification in self.notifications:
            if notification['id'] == notification_id:
                return notification['type']
        return "unknown"
    def clear_all_notifications(self):
        self.notifications.clear()
        self.notification_count = 0
        # Remove all toast views
        while self.toast_container.count():
            child = self.toast_container.takeAt(0)
            if child.widget():
                child.widget().deleteLater()
    # Should implement methods to:
    # 4. Provide programmatic access to notification content
def main():
    app = QApplication(sys.argv)
    window = ToastNotificationIssues()
    window.show()
    sys.exit(app.exec_())
if __name__ == '__main__':
    main()

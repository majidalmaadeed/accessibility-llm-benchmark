import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QComboBox, QSwitch)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class MissingPageTitle(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Settings")  # MISSING PAGE TITLE - Settings page without descriptive title element
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # MISSING PAGE TITLE - Settings page without descriptive title element
        # Tab Navigation
        tab_layout = QHBoxLayout()
        tab_layout.setSpacing(0)
        
        tab_buttons = [
            ("General", True),
            ("Privacy", False),
            ("Security", False),
            ("Notifications", False)
        ]
        
        for label, is_active in tab_buttons:
            button = QPushButton(label)
            if is_active:
                button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
            button.clicked.connect(lambda checked, l=label: self.on_tab_clicked(l))
            tab_layout.addWidget(button)
        
        main_layout.addLayout(tab_layout)
        
        # Content area
        content_frame = QFrame()
        content_frame.setFrameStyle(QFrame.Box)
        content_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        content_layout = QVBoxLayout(content_frame)
        content_layout.setSpacing(20)
        content_layout.setContentsMargins(20, 20, 20, 20)
        
        # General Settings
        general_frame = QFrame()
        general_frame.setFrameStyle(QFrame.Box)
        general_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        general_layout = QVBoxLayout(general_frame)
        general_layout.setSpacing(15)
        general_layout.setContentsMargins(15, 15, 15, 15)
        
        # Language selection
        language_layout = QVBoxLayout()
        
        language_label = QLabel("Language")
        language_font = QFont()
        language_font.setPointSize(16)
        language_font.setBold(True)
        language_label.setFont(language_font)
        language_layout.addWidget(language_label)
        
        self.language_combo = QComboBox()
        languages = ["English", "Spanish", "French", "German", "Italian", "Portuguese"]
        for lang in languages:
            self.language_combo.addItem(lang)
        self.language_combo.setCurrentIndex(0)
        self.language_combo.currentTextChanged.connect(self.on_language_changed)
        language_layout.addWidget(self.language_combo)
        
        general_layout.addLayout(language_layout)
        
        # Theme selection
        theme_layout = QVBoxLayout()
        
        theme_label = QLabel("Theme")
        theme_font = QFont()
        theme_font.setPointSize(16)
        theme_font.setBold(True)
        theme_label.setFont(theme_font)
        theme_layout.addWidget(theme_label)
        
        self.theme_combo = QComboBox()
        themes = ["System", "Light", "Dark"]
        for theme in themes:
            self.theme_combo.addItem(theme)
        self.theme_combo.setCurrentIndex(0)
        self.theme_combo.currentTextChanged.connect(self.on_theme_changed)
        theme_layout.addWidget(self.theme_combo)
        
        general_layout.addLayout(theme_layout)
        
        # Auto-save toggle
        auto_save_layout = QHBoxLayout()
        
        self.auto_save_toggle = QSwitch()
        self.auto_save_toggle.setChecked(True)
        self.auto_save_toggle.toggled.connect(self.on_auto_save_changed)
        auto_save_layout.addWidget(self.auto_save_toggle)
        
        auto_save_label = QLabel("Auto-save")
        auto_save_layout.addWidget(auto_save_label)
        
        general_layout.addLayout(auto_save_layout)
        
        content_layout.addWidget(general_frame)
        
        # Privacy Settings
        privacy_frame = QFrame()
        privacy_frame.setFrameStyle(QFrame.Box)
        privacy_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        privacy_layout = QVBoxLayout(privacy_frame)
        privacy_layout.setSpacing(15)
        privacy_layout.setContentsMargins(15, 15, 15, 15)
        
        # Data Collection toggle
        data_collection_layout = QHBoxLayout()
        
        self.data_collection_toggle = QSwitch()
        self.data_collection_toggle.setChecked(False)
        self.data_collection_toggle.toggled.connect(self.on_data_collection_changed)
        data_collection_layout.addWidget(self.data_collection_toggle)
        
        data_collection_label = QLabel("Data Collection")
        data_collection_layout.addWidget(data_collection_label)
        
        privacy_layout.addLayout(data_collection_layout)
        
        # Analytics toggle
        analytics_layout = QHBoxLayout()
        
        self.analytics_toggle = QSwitch()
        self.analytics_toggle.setChecked(True)
        self.analytics_toggle.toggled.connect(self.on_analytics_changed)
        analytics_layout.addWidget(self.analytics_toggle)
        
        analytics_label = QLabel("Analytics")
        analytics_layout.addWidget(analytics_label)
        
        privacy_layout.addLayout(analytics_layout)
        
        # Crash Reports toggle
        crash_reports_layout = QHBoxLayout()
        
        self.crash_reports_toggle = QSwitch()
        self.crash_reports_toggle.setChecked(True)
        self.crash_reports_toggle.toggled.connect(self.on_crash_reports_changed)
        crash_reports_layout.addWidget(self.crash_reports_toggle)
        
        crash_reports_label = QLabel("Crash Reports")
        crash_reports_layout.addWidget(crash_reports_label)
        
        privacy_layout.addLayout(crash_reports_layout)
        
        content_layout.addWidget(privacy_frame)
        
        # Security Settings
        security_frame = QFrame()
        security_frame.setFrameStyle(QFrame.Box)
        security_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        security_layout = QVBoxLayout(security_frame)
        security_layout.setSpacing(15)
        security_layout.setContentsMargins(15, 15, 15, 15)
        
        # Two-Factor Authentication toggle
        two_factor_layout = QHBoxLayout()
        
        self.two_factor_toggle = QSwitch()
        self.two_factor_toggle.setChecked(True)
        self.two_factor_toggle.toggled.connect(self.on_two_factor_changed)
        two_factor_layout.addWidget(self.two_factor_toggle)
        
        two_factor_label = QLabel("Two-Factor Authentication")
        two_factor_layout.addWidget(two_factor_label)
        
        security_layout.addLayout(two_factor_layout)
        
        # Biometric Login toggle
        biometric_layout = QHBoxLayout()
        
        self.biometric_toggle = QSwitch()
        self.biometric_toggle.setChecked(False)
        self.biometric_toggle.toggled.connect(self.on_biometric_changed)
        biometric_layout.addWidget(self.biometric_toggle)
        
        biometric_label = QLabel("Biometric Login")
        biometric_layout.addWidget(biometric_label)
        
        security_layout.addLayout(biometric_layout)
        
        # Session Timeout
        session_timeout_layout = QVBoxLayout()
        
        session_timeout_label = QLabel("Session Timeout")
        session_timeout_font = QFont()
        session_timeout_font.setPointSize(16)
        session_timeout_font.setBold(True)
        session_timeout_label.setFont(session_timeout_font)
        session_timeout_layout.addWidget(session_timeout_label)
        
        self.session_timeout_combo = QComboBox()
        timeouts = ["5 minutes", "15 minutes", "30 minutes", "1 hour"]
        for timeout in timeouts:
            self.session_timeout_combo.addItem(timeout)
        self.session_timeout_combo.setCurrentIndex(1)
        self.session_timeout_combo.currentTextChanged.connect(self.on_session_timeout_changed)
        session_timeout_layout.addWidget(self.session_timeout_combo)
        
        security_layout.addLayout(session_timeout_layout)
        
        content_layout.addWidget(security_frame)
        
        # Notification Settings
        notification_frame = QFrame()
        notification_frame.setFrameStyle(QFrame.Box)
        notification_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        notification_layout = QVBoxLayout(notification_frame)
        notification_layout.setSpacing(15)
        notification_layout.setContentsMargins(15, 15, 15, 15)
        
        # Push Notifications toggle
        push_notifications_layout = QHBoxLayout()
        
        self.push_notifications_toggle = QSwitch()
        self.push_notifications_toggle.setChecked(True)
        self.push_notifications_toggle.toggled.connect(self.on_push_notifications_changed)
        push_notifications_layout.addWidget(self.push_notifications_toggle)
        
        push_notifications_label = QLabel("Push Notifications")
        push_notifications_layout.addWidget(push_notifications_label)
        
        notification_layout.addLayout(push_notifications_layout)
        
        # Email Notifications toggle
        email_notifications_layout = QHBoxLayout()
        
        self.email_notifications_toggle = QSwitch()
        self.email_notifications_toggle.setChecked(False)
        self.email_notifications_toggle.toggled.connect(self.on_email_notifications_changed)
        email_notifications_layout.addWidget(self.email_notifications_toggle)
        
        email_notifications_label = QLabel("Email Notifications")
        email_notifications_layout.addWidget(email_notifications_label)
        
        notification_layout.addLayout(email_notifications_layout)
        
        # SMS Notifications toggle
        sms_notifications_layout = QHBoxLayout()
        
        self.sms_notifications_toggle = QSwitch()
        self.sms_notifications_toggle.setChecked(False)
        self.sms_notifications_toggle.toggled.connect(self.on_sms_notifications_changed)
        sms_notifications_layout.addWidget(self.sms_notifications_toggle)
        
        sms_notifications_label = QLabel("SMS Notifications")
        sms_notifications_layout.addWidget(sms_notifications_label)
        
        notification_layout.addLayout(sms_notifications_layout)
        
        content_layout.addWidget(notification_frame)
        
        main_layout.addWidget(content_frame)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        button_layout.setContentsMargins(20, 20, 20, 20)
        
        save_button = QPushButton("Save Changes")
        save_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        save_button.setFixedSize(120, 40)
        save_button.clicked.connect(self.on_save_clicked)
        button_layout.addWidget(save_button)
        
        reset_button = QPushButton("Reset to Defaults")
        reset_button.setFixedSize(120, 40)
        reset_button.clicked.connect(self.on_reset_clicked)
        button_layout.addWidget(reset_button)
        
        main_layout.addLayout(button_layout)
        
    def on_tab_clicked(self, tab_name):
        # Update tab buttons
        for i in range(self.findChild(QHBoxLayout).count()):
            widget = self.findChild(QHBoxLayout).itemAt(i).widget()
            if isinstance(widget, QPushButton):
                widget.setStyleSheet("")
        
        # Find and highlight the clicked button
        for i in range(self.findChild(QHBoxLayout).count()):
            widget = self.findChild(QHBoxLayout).itemAt(i).widget()
            if isinstance(widget, QPushButton) and widget.text() == tab_name:
                widget.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
                break
        
        # Handle tab change
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Tab Changed", f"Switched to {tab_name} tab")
    
    def on_language_changed(self, text):
        # Handle language change
        pass
    
    def on_theme_changed(self, text):
        # Handle theme change
        pass
    
    def on_auto_save_changed(self, checked):
        # Handle auto-save change
        pass
    
    def on_data_collection_changed(self, checked):
        # Handle data collection change
        pass
    
    def on_analytics_changed(self, checked):
        # Handle analytics change
        pass
    
    def on_crash_reports_changed(self, checked):
        # Handle crash reports change
        pass
    
    def on_two_factor_changed(self, checked):
        # Handle two-factor change
        pass
    
    def on_biometric_changed(self, checked):
        # Handle biometric change
        pass
    
    def on_session_timeout_changed(self, text):
        # Handle session timeout change
        pass
    
    def on_push_notifications_changed(self, checked):
        # Handle push notifications change
        pass
    
    def on_email_notifications_changed(self, checked):
        # Handle email notifications change
        pass
    
    def on_sms_notifications_changed(self, checked):
        # Handle SMS notifications change
        pass
    
    def on_save_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Settings Saved", "Your settings have been saved successfully!")
    
    def on_reset_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        response = QMessageBox.question(self, "Reset Settings", 
                                       "Are you sure you want to reset all settings to their default values?",
                                       QMessageBox.Yes | QMessageBox.No)
        
        if response == QMessageBox.Yes:
            # Reset all settings
            self.language_combo.setCurrentIndex(0)
            self.theme_combo.setCurrentIndex(0)
            self.auto_save_toggle.setChecked(True)
            self.data_collection_toggle.setChecked(False)
            self.analytics_toggle.setChecked(True)
            self.crash_reports_toggle.setChecked(True)
            self.two_factor_toggle.setChecked(True)
            self.biometric_toggle.setChecked(False)
            self.session_timeout_combo.setCurrentIndex(1)
            self.push_notifications_toggle.setChecked(True)
            self.email_notifications_toggle.setChecked(False)
            self.sms_notifications_toggle.setChecked(False)

def main():
    app = QApplication(sys.argv)
    window = MissingPageTitle()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

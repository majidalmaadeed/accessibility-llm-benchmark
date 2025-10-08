import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont, QPalette, QColor

class LowContrastWarningText(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Dashboard")
        self.setGeometry(100, 100, 1000, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Warning banner - LOW CONTRAST WARNING TEXT
        self.warning_frame = QFrame()
        self.warning_frame.setFixedHeight(80)
        self.warning_frame.setStyleSheet("QFrame { background-color: #ff0000; }")
        
        warning_layout = QHBoxLayout(self.warning_frame)
        warning_layout.setSpacing(15)
        warning_layout.setContentsMargins(20, 10, 20, 10)
        
        # Warning icon
        warning_icon = QLabel("⚠️")
        warning_icon.setStyleSheet("font-size: 24px;")
        warning_layout.addWidget(warning_icon)
        
        # Warning content
        warning_content_layout = QVBoxLayout()
        
        # LOW CONTRAST WARNING TEXT - Session timeout warning with insufficient color contrast
        warning_title = QLabel("Session Timeout Warning")
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        warning_title.setFont(title_font)
        warning_title.setStyleSheet("color: #757575;")  # LOW CONTRAST
        warning_content_layout.addWidget(warning_title)
        
        warning_message = QLabel("Your session will expire in 5 minutes. Please save your work and extend your session to continue.")
        warning_message.setWordWrap(True)
        warning_message.setStyleSheet("color: #BDBDBD;")  # LOW CONTRAST
        warning_content_layout.addWidget(warning_message)
        
        warning_layout.addLayout(warning_content_layout)
        
        # Action buttons - LOW CONTRAST
        button_layout = QHBoxLayout()
        button_layout.setSpacing(10)
        
        extend_button = QPushButton("Extend")
        extend_button.setStyleSheet("QPushButton { color: #90CAF9; background-color: transparent; border: 1px solid #90CAF9; }")
        button_layout.addWidget(extend_button)
        
        logout_button = QPushButton("Logout")
        logout_button.setStyleSheet("QPushButton { color: #EF9A9A; background-color: transparent; border: 1px solid #EF9A9A; }")
        button_layout.addWidget(logout_button)
        
        # Flash count label
        self.flash_count_label = QLabel("Flashes: 0")
        self.flash_count_label.setStyleSheet("color: white; font-weight: bold; background-color: rgba(0, 0, 0, 0.2); padding: 4px 8px; border-radius: 6px;")
        button_layout.addWidget(self.flash_count_label)
        
        warning_layout.addLayout(button_layout)
        
        main_layout.addWidget(self.warning_frame)
        
        # Main content
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        content_widget = QWidget()
        content_layout = QVBoxLayout(content_widget)
        content_layout.setSpacing(20)
        content_layout.setContentsMargins(20, 20, 20, 20)
        
        # Dashboard title
        dashboard_title = QLabel("Welcome back!")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        dashboard_title.setFont(title_font)
        dashboard_title.setAlignment(Qt.AlignCenter)
        content_layout.addWidget(dashboard_title)
        
        dashboard_subtitle = QLabel("Your session is active and secure")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        dashboard_subtitle.setFont(subtitle_font)
        dashboard_subtitle.setAlignment(Qt.AlignCenter)
        content_layout.addWidget(dashboard_subtitle)
        
        time_remaining = QLabel("⏰ 5 minutes remaining")
        time_remaining.setAlignment(Qt.AlignCenter)
        content_layout.addWidget(time_remaining)
        
        # Quick actions
        quick_actions_label = QLabel("Quick Actions")
        actions_font = QFont()
        actions_font.setPointSize(18)
        actions_font.setBold(True)
        quick_actions_label.setFont(actions_font)
        content_layout.addWidget(quick_actions_label)
        
        quick_actions_grid = QGridLayout()
        quick_actions_grid.setSpacing(20)
        
        actions = [
            ("📊", "View Reports", "Learn new skills"),
            ("👥", "Manage Users", "User management"),
            ("⚙️", "Settings", "App configuration"),
            ("❓", "Help & Support", "Get assistance")
        ]
        
        for i, (icon, title, subtitle) in enumerate(actions):
            action_frame = self.create_action_card(icon, title, subtitle)
            quick_actions_grid.addWidget(action_frame, i // 2, i % 2)
        
        content_layout.addLayout(quick_actions_grid)
        
        # Recent activity
        recent_activity_label = QLabel("Recent Activity")
        recent_activity_label.setFont(actions_font)
        content_layout.addWidget(recent_activity_label)
        
        recent_activity_frame = QFrame()
        recent_activity_frame.setFrameStyle(QFrame.Box)
        recent_activity_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        activity_layout = QVBoxLayout(recent_activity_frame)
        activity_layout.setSpacing(10)
        activity_layout.setContentsMargins(15, 15, 15, 15)
        
        activities = [
            ("🟢", "User logged in", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("⚙️", "Settings updated", "1 hour ago")
        ]
        
        for icon, title, time in activities:
            activity_row = QHBoxLayout()
            
            icon_label = QLabel(icon)
            activity_row.addWidget(icon_label)
            
            title_label = QLabel(title)
            title_font = QFont()
            title_font.setBold(True)
            title_label.setFont(title_font)
            activity_row.addWidget(title_label)
            
            time_label = QLabel(time)
            time_label.setAlignment(Qt.AlignRight)
            activity_row.addWidget(time_label)
            
            activity_layout.addLayout(activity_row)
        
        content_layout.addWidget(recent_activity_frame)
        
        scroll_area.setWidget(content_widget)
        main_layout.addWidget(scroll_area)
        
        # Start flash animation
        self.flash_count = 0
        self.flash_timer = QTimer()
        self.flash_timer.timeout.connect(self.update_flash_display)
        self.flash_timer.start(200)  # 5 times per second
        
    def create_action_card(self, icon, title, subtitle):
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setFixedSize(200, 120)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        layout = QVBoxLayout(frame)
        layout.setSpacing(8)
        layout.setContentsMargins(15, 15, 15, 15)
        
        icon_label = QLabel(icon)
        icon_label.setAlignment(Qt.AlignCenter)
        icon_label.setStyleSheet("font-size: 36px;")
        layout.addWidget(icon_label)
        
        title_label = QLabel(title)
        title_font = QFont()
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(title_label)
        
        subtitle_label = QLabel(subtitle)
        subtitle_label.setAlignment(Qt.AlignCenter)
        subtitle_label.setWordWrap(True)
        layout.addWidget(subtitle_label)
        
        return frame
    
    def update_flash_display(self):
        self.flash_count += 1
        self.flash_count_label.setText(f"Flashes: {self.flash_count}")
        
        # Toggle between red and orange
        if self.flash_count % 2 == 0:
            self.warning_frame.setStyleSheet("QFrame { background-color: #ff0000; }")
        else:
            self.warning_frame.setStyleSheet("QFrame { background-color: #ff8800; }")

def main():
    app = QApplication(sys.argv)
    window = LowContrastWarningText()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

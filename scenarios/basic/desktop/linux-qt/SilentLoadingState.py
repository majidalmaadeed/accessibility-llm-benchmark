import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QTableWidget, 
                             QTableWidgetItem, QHeaderView, QProgressBar, QSpinner)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont

class SilentLoadingState(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Data Dashboard")
        self.setGeometry(100, 100, 1000, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Toolbar
        toolbar_layout = QHBoxLayout()
        toolbar_layout.setSpacing(10)
        toolbar_layout.setContentsMargins(10, 10, 10, 10)
        toolbar_layout.setAlignment(Qt.AlignCenter)
        
        # Action buttons
        refresh_button = QPushButton("Refresh Data")
        refresh_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        refresh_button.setFixedSize(120, 40)
        refresh_button.clicked.connect(self.on_refresh_clicked)
        toolbar_layout.addWidget(refresh_button)
        
        export_button = QPushButton("Export Data")
        export_button.setFixedSize(120, 40)
        export_button.clicked.connect(self.on_export_clicked)
        toolbar_layout.addWidget(export_button)
        
        generate_report_button = QPushButton("Generate Report")
        generate_report_button.setFixedSize(120, 40)
        generate_report_button.clicked.connect(self.on_generate_report_clicked)
        toolbar_layout.addWidget(generate_report_button)
        
        main_layout.addLayout(toolbar_layout)
        
        # Loading view - SILENT LOADING STATE
        self.loading_frame = QFrame()
        self.loading_frame.setFrameStyle(QFrame.Box)
        self.loading_frame.setFixedHeight(100)
        self.loading_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        self.loading_frame.setVisible(False)
        
        loading_layout = QVBoxLayout(self.loading_frame)
        loading_layout.setSpacing(15)
        loading_layout.setContentsMargins(20, 20, 20, 20)
        loading_layout.setAlignment(Qt.AlignCenter)
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_spinner = QLabel("⏳")
        self.progress_spinner.setAlignment(Qt.AlignCenter)
        self.progress_spinner.setStyleSheet("font-size: 40px;")
        loading_layout.addWidget(self.progress_spinner)
        
        loading_label = QLabel("Loading...")
        loading_font = QFont()
        loading_font.setPointSize(16)
        loading_font.setBold(True)
        loading_label.setFont(loading_font)
        loading_label.setAlignment(Qt.AlignCenter)
        loading_layout.addWidget(loading_label)
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_bar = QProgressBar()
        self.progress_bar.setFixedWidth(300)
        self.progress_bar.setValue(0)
        loading_layout.addWidget(self.progress_bar)
        
        progress_label = QLabel("0%")
        progress_label.setAlignment(Qt.AlignCenter)
        loading_layout.addWidget(progress_label)
        
        main_layout.addWidget(self.loading_frame)
        
        # Main content
        content_widget = QWidget()
        content_layout = QVBoxLayout(content_widget)
        content_layout.setSpacing(20)
        content_layout.setContentsMargins(20, 20, 20, 20)
        
        # Data summary
        summary_label = QLabel("Data Summary")
        summary_font = QFont()
        summary_font.setPointSize(18)
        summary_font.setBold(True)
        summary_label.setFont(summary_font)
        content_layout.addWidget(summary_label)
        
        summary_grid = QHBoxLayout()
        summary_grid.setSpacing(20)
        
        summary_items = [
            ("📊", "Total Records", "1,234", "blue"),
            ("✅", "Completed", "987", "green"),
            ("⏳", "Pending", "247", "orange")
        ]
        
        for icon, title, value, color in summary_items:
            summary_frame = self.create_summary_card(icon, title, value, color)
            summary_grid.addWidget(summary_frame)
        
        content_layout.addLayout(summary_grid)
        
        # Recent activity
        activity_label = QLabel("Recent Activity")
        activity_label.setFont(summary_font)
        content_layout.addWidget(activity_label)
        
        activity_frame = QFrame()
        activity_frame.setFrameStyle(QFrame.Box)
        activity_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        activity_layout = QVBoxLayout(activity_frame)
        activity_layout.setSpacing(10)
        activity_layout.setContentsMargins(15, 15, 15, 15)
        
        activities = [
            ("🟢", "Data refreshed", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("📤", "Data exported", "1 hour ago")
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
        
        content_layout.addWidget(activity_frame)
        
        # Data table
        table_label = QLabel("Data Records")
        table_label.setFont(summary_font)
        content_layout.addWidget(table_label)
        
        # Create table widget for data
        self.table_widget = QTableWidget()
        self.table_widget.setRowCount(5)
        self.table_widget.setColumnCount(4)
        self.table_widget.setHorizontalHeaderLabels(["ID", "Name", "Status", "Date"])
        self.table_widget.setFixedHeight(200)
        
        # Load sample data
        self.load_data()
        
        content_layout.addWidget(self.table_widget)
        
        main_layout.addWidget(content_widget)
        
        # State
        self.is_loading = False
        self.loading_progress = 0.0
        self.progress_timer = QTimer()
        self.progress_timer.timeout.connect(self.update_progress)
        
    def create_summary_card(self, icon, title, value, color):
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
        
        value_label = QLabel(value)
        value_font = QFont()
        value_font.setPointSize(16)
        value_font.setBold(True)
        value_label.setFont(value_font)
        value_label.setAlignment(Qt.AlignCenter)
        value_label.setStyleSheet(f"color: {color};")
        layout.addWidget(value_label)
        
        return frame
    
    def load_data(self):
        data = [
            ("1", "Record 1", "Active", "2024-01-01"),
            ("2", "Record 2", "Pending", "2024-01-02"),
            ("3", "Record 3", "Active", "2024-01-03"),
            ("4", "Record 4", "Pending", "2024-01-04"),
            ("5", "Record 5", "Active", "2024-01-05")
        ]
        
        for i, record in enumerate(data):
            for j, item in enumerate(record):
                self.table_widget.setItem(i, j, QTableWidgetItem(item))
    
    def start_loading(self):
        self.is_loading = True
        self.loading_frame.setVisible(True)
        self.loading_progress = 0.0
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_bar.setValue(0)
        
        # Start progress timer
        self.progress_timer.start(100)  # Update every 100ms
    
    def update_progress(self):
        if self.is_loading and self.loading_progress < 100:
            self.loading_progress += 2
            self.progress_bar.setValue(int(self.loading_progress))
            
            # Update progress label
            progress_label = self.loading_frame.findChild(QLabel)
            if progress_label and progress_label.text() != "Loading...":
                progress_label.setText(f"{int(self.loading_progress)}%")
        else:
            self.stop_loading()
    
    def stop_loading(self):
        self.is_loading = False
        self.loading_frame.setVisible(False)
        self.progress_timer.stop()
    
    def on_refresh_clicked(self):
        self.start_loading()
    
    def on_export_clicked(self):
        self.start_loading()
    
    def on_generate_report_clicked(self):
        self.start_loading()

def main():
    app = QApplication(sys.argv)
    window = SilentLoadingState()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QGridLayout, QLabel, QPushButton, 
                             QComboBox, QListWidget, QListWidgetItem, QLineEdit,
                             QCheckBox, QMessageBox, QFrame, QScrollArea,
                             QGroupBox, QSlider, QSpinBox, QTextEdit, QDialog)
from PyQt5.QtCore import Qt, QTimer, pyqtSignal, QRect
from PyQt5.QtGui import QFont, QPalette, QColor, QIcon, QPainter, QPen, QBrush
from datetime import datetime

class InteractiveMap(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Interactive Map")
        self.setGeometry(100, 100, 1200, 800)
        
        # Data
        self.all_locations = []
        self.search_results = []
        self.bookmarks = []
        self.current_map_type = "Standard"
        self.current_zoom = 10
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.show_user_location = True
        self.traffic_enabled = False
        self.transit_enabled = False
        self.bike_lanes_enabled = False
        self.selected_location = None
        
        # Load sample data
        self.load_sample_data()
        
        # Create UI
        self.create_ui()
    
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
        
        # Search bar
        search_widget = self.create_search_bar()
        main_layout.addWidget(search_widget)
        
        # Main content
        content_layout = QHBoxLayout()
        main_layout.addLayout(content_layout)
        
        # Map area
        self.create_map_area(content_layout)
        
        # Side panel
        self.create_side_panel(content_layout)
        
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
        title_label = QLabel("Interactive Map")
        title_label.setStyleSheet("""
            QLabel {
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
        """)
        header_layout.addWidget(title_label)
        
        header_layout.addStretch()
        
        # Controls
        controls_layout = QHBoxLayout()
        
        # Map type combo
        self.map_type_combo = QComboBox()
        self.map_type_combo.addItems(["Standard", "Satellite", "Hybrid", "Terrain"])
        self.map_type_combo.currentTextChanged.connect(self.on_map_type_changed)
        controls_layout.addWidget(self.map_type_combo)
        
        # Layers button
        layers_btn = QPushButton("Layers")
        layers_btn.clicked.connect(self.on_layers_clicked)
        controls_layout.addWidget(layers_btn)
        
        # Bookmarks button
        bookmarks_btn = QPushButton("Bookmarks")
        bookmarks_btn.clicked.connect(self.on_bookmarks_clicked)
        controls_layout.addWidget(bookmarks_btn)
        
        header_layout.addLayout(controls_layout)
        
        return header_widget
    
    def create_search_bar(self):
        search_widget = QFrame()
        search_widget.setStyleSheet("""
            QFrame {
                background-color: white;
                padding: 16px;
                border: none;
            }
        """)
        
        search_layout = QHBoxLayout()
        search_widget.setLayout(search_layout)
        
        # Search entry
        self.search_entry = QLineEdit()
        self.search_entry.setPlaceholderText("Search for places, addresses, or businesses...")
        self.search_entry.setStyleSheet("""
            QLineEdit {
                padding: 12px;
                border: 2px solid #E0E0E0;
                border-radius: 8px;
                font-size: 14px;
            }
            QLineEdit:focus {
                border-color: #4A90E2;
            }
        """)
        self.search_entry.textChanged.connect(self.on_search_changed)
        search_layout.addWidget(self.search_entry)
        
        # My location button
        my_location_btn = QPushButton("📍")
        my_location_btn.setToolTip("My Location")
        my_location_btn.setStyleSheet("""
            QPushButton {
                background-color: #F0F0F0;
                border: 1px solid #E0E0E0;
                padding: 12px;
                border-radius: 8px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #E0E0E0;
            }
        """)
        my_location_btn.clicked.connect(self.on_my_location_clicked)
        search_layout.addWidget(my_location_btn)
        
        return search_widget
    
    def create_map_area(self, parent):
        # Map container
        map_widget = QWidget()
        map_widget.setStyleSheet("""
            QWidget {
                background-color: #F0F0F0;
                border: 1px solid #E0E0E0;
                border-radius: 8px;
            }
        """)
        
        map_layout = QVBoxLayout()
        map_widget.setLayout(map_layout)
        
        # Map drawing area
        self.map_area = MapWidget()
        self.map_area.setMinimumHeight(400)
        map_layout.addWidget(self.map_area)
        
        # Map controls overlay
        controls_widget = QWidget()
        controls_widget.setStyleSheet("background-color: transparent;")
        controls_layout = QHBoxLayout()
        controls_widget.setLayout(controls_layout)
        
        # Map controls
        controls_group = QGroupBox()
        controls_group.setStyleSheet("""
            QGroupBox {
                background-color: rgba(255, 255, 255, 0.9);
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                padding: 8px;
            }
        """)
        controls_group_layout = QVBoxLayout()
        controls_group.setLayout(controls_group_layout)
        
        zoom_in_btn = QPushButton("+")
        zoom_in_btn.setToolTip("Zoom In")
        zoom_in_btn.clicked.connect(self.on_zoom_in)
        controls_group_layout.addWidget(zoom_in_btn)
        
        zoom_out_btn = QPushButton("-")
        zoom_out_btn.setToolTip("Zoom Out")
        zoom_out_btn.clicked.connect(self.on_zoom_out)
        controls_group_layout.addWidget(zoom_out_btn)
        
        center_btn = QPushButton("⌂")
        center_btn.setToolTip("Center")
        center_btn.clicked.connect(self.on_center_clicked)
        controls_group_layout.addWidget(center_btn)
        
        controls_layout.addStretch()
        controls_layout.addWidget(controls_group)
        controls_layout.addStretch()
        
        map_layout.addWidget(controls_widget)
        
        parent.addWidget(map_widget)
    
    def create_side_panel(self, parent):
        side_panel = QWidget()
        side_panel.setMaximumWidth(320)
        side_panel.setMinimumWidth(320)
        
        layout = QVBoxLayout()
        side_panel.setLayout(layout)
        
        # Search Results
        self.create_search_results(layout)
        
        # Location Details
        self.create_location_details(layout)
        
        # Quick Actions
        self.create_quick_actions(layout)
        
        parent.addWidget(side_panel)
    
    def create_search_results(self, parent):
        results_group = QGroupBox("Search Results")
        results_layout = QVBoxLayout()
        results_group.setLayout(results_layout)
        
        # Results list
        self.results_list = QListWidget()
        self.results_list.setMaximumHeight(160)
        self.results_list.setStyleSheet("""
            QListWidget {
                border: 1px solid #E0E0E0;
                border-radius: 4px;
                background-color: white;
            }
            QListWidget::item {
                padding: 8px;
                border-bottom: 1px solid #F0F0F0;
            }
            QListWidget::item:hover {
                background-color: #F5F5F5;
            }
            QListWidget::item:selected {
                background-color: #E3F2FD;
            }
        """)
        self.results_list.itemClicked.connect(self.on_result_clicked)
        results_layout.addWidget(self.results_list)
        
        parent.addWidget(results_group)
    
    def create_location_details(self, parent):
        details_group = QGroupBox("Location Details")
        details_layout = QVBoxLayout()
        details_group.setLayout(details_layout)
        
        # Details text
        self.details_text = QTextEdit()
        self.details_text.setReadOnly(True)
        self.details_text.setMaximumHeight(200)
        self.details_text.setStyleSheet("""
            QTextEdit {
                border: 1px solid #E0E0E0;
                border-radius: 4px;
                background-color: white;
            }
        """)
        details_layout.addWidget(self.details_text)
        
        parent.addWidget(details_group)
    
    def create_quick_actions(self, parent):
        actions_group = QGroupBox("Quick Actions")
        actions_layout = QVBoxLayout()
        actions_group.setLayout(actions_layout)
        
        # Action buttons grid
        grid_layout = QGridLayout()
        
        # Get Directions
        directions_btn = QPushButton("Get Directions")
        directions_btn.clicked.connect(self.on_get_directions)
        grid_layout.addWidget(directions_btn, 0, 0)
        
        # Share
        share_btn = QPushButton("Share")
        share_btn.clicked.connect(self.on_share_location)
        grid_layout.addWidget(share_btn, 0, 1)
        
        # Save
        save_btn = QPushButton("Save")
        save_btn.clicked.connect(self.on_save_location)
        grid_layout.addWidget(save_btn, 1, 0)
        
        # Report
        report_btn = QPushButton("Report")
        report_btn.clicked.connect(self.on_report_issue)
        grid_layout.addWidget(report_btn, 1, 1)
        
        actions_layout.addLayout(grid_layout)
        
        parent.addWidget(actions_group)
    
    def load_sample_data(self):
        self.all_locations = [
            {
                'id': '1',
                'name': 'Golden Gate Bridge',
                'address': 'Golden Gate Bridge, San Francisco, CA',
                'latitude': 37.8199,
                'longitude': -122.4783,
                'type': 'landmark',
                'rating': 4.8,
                'description': 'Famous suspension bridge spanning the Golden Gate strait.',
                'category': 'Tourist Attraction',
                'price': 0.0,
                'hours': '24/7',
                'phone': '(415) 921-5858'
            },
            {
                'id': '2',
                'name': 'Fisherman\'s Wharf',
                'address': 'Pier 39, San Francisco, CA',
                'latitude': 37.8087,
                'longitude': -122.4098,
                'type': 'attraction',
                'rating': 4.2,
                'description': 'Popular tourist destination with shops, restaurants, and sea lions.',
                'category': 'Shopping & Dining',
                'price': 0.0,
                'hours': '9:00 AM - 10:00 PM',
                'phone': '(415) 705-5500'
            },
            {
                'id': '3',
                'name': 'Alcatraz Island',
                'address': 'Alcatraz Island, San Francisco, CA',
                'latitude': 37.8270,
                'longitude': -122.4230,
                'type': 'landmark',
                'rating': 4.6,
                'description': 'Former federal prison, now a popular tourist attraction.',
                'category': 'Historical Site',
                'price': 45.0,
                'hours': '9:00 AM - 6:30 PM',
                'phone': '(415) 561-4926'
            },
            {
                'id': '4',
                'name': 'Lombard Street',
                'address': 'Lombard St, San Francisco, CA',
                'latitude': 37.8021,
                'longitude': -122.4187,
                'type': 'landmark',
                'rating': 4.3,
                'description': 'Famous steep, winding street with eight hairpin turns.',
                'category': 'Tourist Attraction',
                'price': 0.0,
                'hours': '24/7',
                'phone': 'N/A'
            },
            {
                'id': '5',
                'name': 'Union Square',
                'address': 'Union Square, San Francisco, CA',
                'latitude': 37.7880,
                'longitude': -122.4074,
                'type': 'shopping',
                'rating': 4.1,
                'description': 'Major shopping and entertainment district in downtown San Francisco.',
                'category': 'Shopping District',
                'price': 0.0,
                'hours': '10:00 AM - 9:00 PM',
                'phone': 'N/A'
            }
        ]
    
    def perform_search(self):
        query = self.search_entry.text().lower()
        
        if not query:
            self.search_results = []
        else:
            self.search_results = [location for location in self.all_locations
                                 if query in location['name'].lower() or
                                 query in location['address'].lower() or
                                 query in location['category'].lower()]
        
        self.update_search_results()
    
    def update_search_results(self):
        # Clear existing results
        self.results_list.clear()
        
        # Add search results
        for location in self.search_results:
            item = QListWidgetItem()
            item.setText(f"{location['name']}\n{location['address']}\n{location['category']}")
            item.setData(Qt.UserRole, location)
            self.results_list.addItem(item)
    
    def show_location_details(self, location):
        details = f"{location['name']}\n\n"
        details += f"{location['description']}\n\n"
        details += f"Type: {location['type']}\n"
        details += f"Rating: {location['rating']:.1f}/5\n"
        details += f"Price: ${location['price']:.0f}" if location['price'] > 0 else "Price: Free"
        details += f"\nHours: {location['hours']}\n"
        if location['phone'] != 'N/A':
            details += f"Phone: {location['phone']}"
        
        self.details_text.setPlainText(details)
    
    # Event handlers
    def on_search_changed(self):
        self.perform_search()
    
    def on_map_type_changed(self, map_type):
        self.current_map_type = map_type
        self.map_area.update()
        self.status_bar.showMessage(f"Map type changed to {map_type}")
    
    def on_layers_clicked(self):
        dialog = LayersDialog(self)
        if dialog.exec_() == QDialog.Accepted:
            self.traffic_enabled = dialog.traffic_check.isChecked()
            self.transit_enabled = dialog.transit_check.isChecked()
            self.bike_lanes_enabled = dialog.bike_lanes_check.isChecked()
            self.show_user_location = dialog.user_location_check.isChecked()
            self.status_bar.showMessage("Map layers updated")
    
    def on_bookmarks_clicked(self):
        if not self.bookmarks:
            QMessageBox.information(self, "Bookmarks", "No bookmarks yet.\nBookmark locations to see them here.")
        else:
            bookmark_names = [bookmark['name'] for bookmark in self.bookmarks]
            QMessageBox.information(self, "Bookmarks", "Bookmarks:\n" + "\n".join(bookmark_names))
    
    def on_my_location_clicked(self):
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.current_zoom = 10
        self.map_area.update()
        self.status_bar.showMessage("Centered on your location")
    
    def on_zoom_in(self):
        self.current_zoom = min(self.current_zoom + 1, 20)
        self.map_area.update()
    
    def on_zoom_out(self):
        self.current_zoom = max(self.current_zoom - 1, 1)
        self.map_area.update()
    
    def on_center_clicked(self):
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.current_zoom = 10
        self.map_area.update()
        self.status_bar.showMessage("Map centered")
    
    def on_result_clicked(self, item):
        location = item.data(Qt.UserRole)
        self.selected_location = location
        self.show_location_details(location)
        self.status_bar.showMessage("Location selected")
    
    def on_get_directions(self):
        QMessageBox.information(self, "Get Directions", "Turn-by-turn directions would be displayed here.")
    
    def on_share_location(self):
        QMessageBox.information(self, "Share Location", "Location sharing options would be displayed here.")
    
    def on_save_location(self):
        if self.selected_location:
            if self.selected_location not in self.bookmarks:
                self.bookmarks.append(self.selected_location)
                QMessageBox.information(self, "Bookmark", f"Location '{self.selected_location['name']}' bookmarked!")
            else:
                QMessageBox.information(self, "Bookmark", "Location already bookmarked.")
        else:
            QMessageBox.information(self, "Bookmark", "Please select a location first.")
    
    def on_report_issue(self):
        QMessageBox.information(self, "Report Issue", "Report issue form would be displayed here.")

class MapWidget(QWidget):
    def __init__(self):
        super().__init__()
        self.setMinimumSize(400, 300)
    
    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)
        
        # Draw map background
        painter.fillRect(self.rect(), QColor(240, 240, 240))
        
        # Draw grid lines
        painter.setPen(QPen(QColor(200, 200, 200), 1))
        
        width = self.width()
        height = self.height()
        
        # Vertical lines
        for x in range(0, width, 50):
            painter.drawLine(x, 0, x, height)
        
        # Horizontal lines
        for y in range(0, height, 50):
            painter.drawLine(0, y, width, y)
        
        # Draw location markers
        painter.setPen(QPen(QColor(74, 144, 226), 2))
        painter.setBrush(QBrush(QColor(74, 144, 226)))
        
        # Sample locations (simplified coordinates)
        locations = [
            (100, 100), (200, 150), (300, 120), (150, 200), (250, 250)
        ]
        
        for x, y in locations:
            painter.drawEllipse(x - 8, y - 8, 16, 16)

class LayersDialog(QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle("Map Layers")
        self.setModal(True)
        self.resize(300, 200)
        
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # Layer checkboxes
        self.traffic_check = QCheckBox("Traffic")
        layout.addWidget(self.traffic_check)
        
        self.transit_check = QCheckBox("Transit")
        layout.addWidget(self.transit_check)
        
        self.bike_lanes_check = QCheckBox("Bike Lanes")
        layout.addWidget(self.bike_lanes_check)
        
        self.user_location_check = QCheckBox("User Location")
        layout.addWidget(self.user_location_check)
        
        # Buttons
        button_layout = QHBoxLayout()
        
        cancel_button = QPushButton("Cancel")
        cancel_button.clicked.connect(self.reject)
        button_layout.addWidget(cancel_button)
        
        apply_button = QPushButton("Apply")
        apply_button.clicked.connect(self.accept)
        button_layout.addWidget(apply_button)
        
        layout.addLayout(button_layout)

def main():
    app = QApplication(sys.argv)
    
    # Set application style
    app.setStyle('Fusion')
    
    window = InteractiveMap()
    window.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

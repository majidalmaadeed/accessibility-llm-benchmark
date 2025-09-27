#!/usr/bin/env python3

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QGridLayout, QLabel, QPushButton, 
                             QComboBox, QListWidget, QListWidgetItem, QLineEdit,
                             QCheckBox, QMessageBox, QFrame, QScrollArea,
                             QGroupBox, QSlider, QSpinBox, QProgressBar)
from PyQt5.QtCore import Qt, QTimer, pyqtSignal
from PyQt5.QtGui import QFont, QPalette, QColor, QIcon
from datetime import datetime, timedelta

class ComplexSearchInterface(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Advanced Search")
        self.setGeometry(100, 100, 1200, 800)
        
        # Data
        self.all_results = []
        self.filtered_results = []
        self.active_filters = []
        self.current_sort = "Relevance"
        self.current_category = "All"
        self.current_page = 1
        self.results_per_page = 25
        self.total_pages = 1
        
        # Load sample data
        self.load_sample_data()
        
        # Create UI
        self.create_ui()
        
        # Perform initial search
        self.perform_search()
    
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
        
        # Filters
        filters_widget = self.create_filters()
        main_layout.addWidget(filters_widget)
        
        # Results
        results_widget = self.create_results()
        main_layout.addWidget(results_widget)
        
        # Pagination
        pagination_widget = self.create_pagination()
        main_layout.addWidget(pagination_widget)
        
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
        title_label = QLabel("Advanced Search")
        title_label.setStyleSheet("""
            QLabel {
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
        """)
        header_layout.addWidget(title_label)
        
        header_layout.addStretch()
        
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
        self.search_entry.setPlaceholderText("Search for files, documents, images...")
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
        
        # Advanced search button
        advanced_btn = QPushButton("Advanced")
        advanced_btn.setStyleSheet("""
            QPushButton {
                background-color: #F0F0F0;
                border: 1px solid #E0E0E0;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #E0E0E0;
            }
        """)
        advanced_btn.clicked.connect(self.on_advanced_search_clicked)
        search_layout.addWidget(advanced_btn)
        
        return search_widget
    
    def create_filters(self):
        filters_widget = QFrame()
        filters_widget.setStyleSheet("""
            QFrame {
                background-color: #F8F8F8;
                padding: 16px;
                border: none;
            }
        """)
        
        filters_layout = QVBoxLayout()
        filters_widget.setLayout(filters_layout)
        
        # Main filters
        main_filters_layout = QHBoxLayout()
        
        # Category filter
        cat_group = QGroupBox("Category")
        cat_layout = QVBoxLayout()
        cat_group.setLayout(cat_layout)
        
        self.category_combo = QComboBox()
        self.category_combo.addItems(["All", "Documents", "Images", "Videos", "Audio", "Archives"])
        self.category_combo.currentTextChanged.connect(self.on_category_changed)
        cat_layout.addWidget(self.category_combo)
        
        main_filters_layout.addWidget(cat_group)
        
        # Sort filter
        sort_group = QGroupBox("Sort by")
        sort_layout = QVBoxLayout()
        sort_group.setLayout(sort_layout)
        
        self.sort_combo = QComboBox()
        self.sort_combo.addItems(["Relevance", "Date", "Name", "Size", "Type", "Rating"])
        self.sort_combo.currentTextChanged.connect(self.on_sort_changed)
        sort_layout.addWidget(self.sort_combo)
        
        main_filters_layout.addWidget(sort_group)
        
        # View mode
        view_group = QGroupBox("View")
        view_layout = QVBoxLayout()
        view_group.setLayout(view_layout)
        
        self.view_combo = QComboBox()
        self.view_combo.addItems(["List", "Grid", "Compact"])
        self.view_combo.currentTextChanged.connect(self.on_view_changed)
        view_layout.addWidget(self.view_combo)
        
        main_filters_layout.addWidget(view_group)
        
        main_filters_layout.addStretch()
        
        # Clear filters button
        clear_btn = QPushButton("Clear All")
        clear_btn.setStyleSheet("""
            QPushButton {
                background-color: #FF6B6B;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #FF5252;
            }
        """)
        clear_btn.clicked.connect(self.on_clear_filters_clicked)
        main_filters_layout.addWidget(clear_btn)
        
        filters_layout.addLayout(main_filters_layout)
        
        # Quick filters
        quick_filters_layout = QHBoxLayout()
        
        quick_label = QLabel("Quick Filters:")
        quick_label.setFont(QFont("Arial", 12, QFont.Bold))
        quick_filters_layout.addWidget(quick_label)
        
        self.filter_checkboxes = {}
        filter_names = ["Recent", "Large Files", "Images Only", "Videos Only", "Free", "Premium"]
        
        for filter_name in filter_names:
            checkbox = QCheckBox(filter_name)
            checkbox.stateChanged.connect(lambda state, name=filter_name: self.on_filter_changed(name, state))
            quick_filters_layout.addWidget(checkbox)
            self.filter_checkboxes[filter_name] = checkbox
        
        quick_filters_layout.addStretch()
        
        filters_layout.addLayout(quick_filters_layout)
        
        return filters_widget
    
    def create_results(self):
        results_widget = QWidget()
        results_layout = QVBoxLayout()
        results_widget.setLayout(results_layout)
        
        # Results header
        header_layout = QHBoxLayout()
        
        self.results_count_label = QLabel("0 results found")
        self.results_count_label.setFont(QFont("Arial", 14, QFont.Bold))
        header_layout.addWidget(self.results_count_label)
        
        header_layout.addStretch()
        
        # Results per page
        per_page_layout = QHBoxLayout()
        per_page_label = QLabel("Results per page:")
        per_page_layout.addWidget(per_page_label)
        
        self.per_page_combo = QComboBox()
        self.per_page_combo.addItems(["10", "25", "50", "100"])
        self.per_page_combo.setCurrentText("25")
        self.per_page_combo.currentTextChanged.connect(self.on_per_page_changed)
        per_page_layout.addWidget(self.per_page_combo)
        
        header_layout.addLayout(per_page_layout)
        
        results_layout.addLayout(header_layout)
        
        # Results list
        self.results_list = QListWidget()
        self.results_list.setStyleSheet("""
            QListWidget {
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                background-color: white;
            }
            QListWidget::item {
                padding: 12px;
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
        
        # Empty state
        self.empty_state_widget = QWidget()
        empty_layout = QVBoxLayout()
        self.empty_state_widget.setLayout(empty_layout)
        
        empty_icon = QLabel("🔍")
        empty_icon.setAlignment(Qt.AlignCenter)
        empty_icon.setStyleSheet("font-size: 64px; color: #CCCCCC;")
        empty_layout.addWidget(empty_icon)
        
        empty_title = QLabel("No results found")
        empty_title.setAlignment(Qt.AlignCenter)
        empty_title.setFont(QFont("Arial", 18, QFont.Bold))
        empty_title.setStyleSheet("color: #666666;")
        empty_layout.addWidget(empty_title)
        
        empty_desc = QLabel("Try adjusting your search terms or filters")
        empty_desc.setAlignment(Qt.AlignCenter)
        empty_desc.setStyleSheet("color: #999999;")
        empty_layout.addWidget(empty_desc)
        
        results_layout.addWidget(self.empty_state_widget)
        
        return results_widget
    
    def create_pagination(self):
        pagination_widget = QFrame()
        pagination_widget.setStyleSheet("""
            QFrame {
                background-color: #F8F8F8;
                padding: 12px;
                border: none;
            }
        """)
        
        pagination_layout = QHBoxLayout()
        pagination_widget.setLayout(pagination_layout)
        
        # First page button
        self.first_btn = QPushButton("⏮")
        self.first_btn.setStyleSheet("""
            QPushButton {
                background-color: white;
                border: 1px solid #E0E0E0;
                padding: 8px 12px;
                border-radius: 4px;
            }
            QPushButton:hover:enabled {
                background-color: #F0F0F0;
            }
            QPushButton:disabled {
                background-color: #F5F5F5;
                color: #CCCCCC;
            }
        """)
        self.first_btn.clicked.connect(self.on_first_page)
        pagination_layout.addWidget(self.first_btn)
        
        # Previous page button
        self.prev_btn = QPushButton("◀")
        self.prev_btn.setStyleSheet("""
            QPushButton {
                background-color: white;
                border: 1px solid #E0E0E0;
                padding: 8px 12px;
                border-radius: 4px;
            }
            QPushButton:hover:enabled {
                background-color: #F0F0F0;
            }
            QPushButton:disabled {
                background-color: #F5F5F5;
                color: #CCCCCC;
            }
        """)
        self.prev_btn.clicked.connect(self.on_prev_page)
        pagination_layout.addWidget(self.prev_btn)
        
        pagination_layout.addStretch()
        
        # Page info
        self.page_info_label = QLabel("Page 1 of 1")
        self.page_info_label.setAlignment(Qt.AlignCenter)
        pagination_layout.addWidget(self.page_info_label)
        
        pagination_layout.addStretch()
        
        # Next page button
        self.next_btn = QPushButton("▶")
        self.next_btn.setStyleSheet("""
            QPushButton {
                background-color: white;
                border: 1px solid #E0E0E0;
                padding: 8px 12px;
                border-radius: 4px;
            }
            QPushButton:hover:enabled {
                background-color: #F0F0F0;
            }
            QPushButton:disabled {
                background-color: #F5F5F5;
                color: #CCCCCC;
            }
        """)
        self.next_btn.clicked.connect(self.on_next_page)
        pagination_layout.addWidget(self.next_btn)
        
        # Last page button
        self.last_btn = QPushButton("⏭")
        self.last_btn.setStyleSheet("""
            QPushButton {
                background-color: white;
                border: 1px solid #E0E0E0;
                padding: 8px 12px;
                border-radius: 4px;
            }
            QPushButton:hover:enabled {
                background-color: #F0F0F0;
            }
            QPushButton:disabled {
                background-color: #F5F5F5;
                color: #CCCCCC;
            }
        """)
        self.last_btn.clicked.connect(self.on_last_page)
        pagination_layout.addWidget(self.last_btn)
        
        return pagination_widget
    
    def load_sample_data(self):
        self.all_results = [
            {
                'id': '1',
                'title': 'React Native Development Guide',
                'description': 'Comprehensive guide to building mobile apps with React Native',
                'type': 'document',
                'category': 'Documents',
                'size': '2.5 MB',
                'size_value': 2.5,
                'date': '2024-01-15',
                'rating': 4.8,
                'price': 0.0,
                'icon': '📄',
                'url': 'https://example.com/react-native-guide'
            },
            {
                'id': '2',
                'title': 'Mobile UI Design Patterns',
                'description': 'Best practices for mobile user interface design',
                'type': 'image',
                'category': 'Images',
                'size': '1.2 MB',
                'size_value': 1.2,
                'date': '2024-01-14',
                'rating': 4.6,
                'price': 29.99,
                'icon': '🖼️',
                'url': 'https://example.com/ui-patterns'
            },
            {
                'id': '3',
                'title': 'JavaScript Tutorial Series',
                'description': 'Complete JavaScript tutorial for beginners',
                'type': 'video',
                'category': 'Videos',
                'size': '150 MB',
                'size_value': 150.0,
                'date': '2024-01-13',
                'rating': 4.9,
                'price': 49.99,
                'icon': '🎥',
                'url': 'https://example.com/js-tutorial'
            },
            {
                'id': '4',
                'title': 'Web Development News',
                'description': 'Latest news and updates in web development',
                'type': 'news',
                'category': 'News',
                'size': '500 KB',
                'size_value': 0.5,
                'date': '2024-01-12',
                'rating': 4.3,
                'price': 0.0,
                'icon': '📰',
                'url': 'https://example.com/web-news'
            },
            {
                'id': '5',
                'title': 'E-commerce Product Catalog',
                'description': 'Complete product catalog for online store',
                'type': 'product',
                'category': 'Products',
                'size': '5.8 MB',
                'size_value': 5.8,
                'date': '2024-01-11',
                'rating': 4.5,
                'price': 99.99,
                'icon': '🛍️',
                'url': 'https://example.com/product-catalog'
            },
            {
                'id': '6',
                'title': 'Database Design Principles',
                'description': 'Fundamental concepts of database design and optimization',
                'type': 'document',
                'category': 'Documents',
                'size': '3.2 MB',
                'size_value': 3.2,
                'date': '2024-01-10',
                'rating': 4.7,
                'price': 0.0,
                'icon': '📄',
                'url': 'https://example.com/database-design'
            },
            {
                'id': '7',
                'title': 'Cloud Architecture Diagrams',
                'description': 'Visual representations of cloud infrastructure patterns',
                'type': 'image',
                'category': 'Images',
                'size': '2.1 MB',
                'size_value': 2.1,
                'date': '2024-01-09',
                'rating': 4.4,
                'price': 19.99,
                'icon': '🖼️',
                'url': 'https://example.com/cloud-diagrams'
            },
            {
                'id': '8',
                'title': 'Machine Learning Course',
                'description': 'Complete course on machine learning algorithms and applications',
                'type': 'video',
                'category': 'Videos',
                'size': '2.5 GB',
                'size_value': 2500.0,
                'date': '2024-01-08',
                'rating': 4.9,
                'price': 199.99,
                'icon': '🎥',
                'url': 'https://example.com/ml-course'
            }
        ]
    
    def perform_search(self):
        search_text = self.search_entry.text().lower()
        
        # Filter by search text
        self.filtered_results = [result for result in self.all_results
                               if not search_text or
                               search_text in result['title'].lower() or
                               search_text in result['description'].lower() or
                               search_text in result['category'].lower()]
        
        # Filter by category
        if self.current_category != "All":
            self.filtered_results = [result for result in self.filtered_results
                                   if result['category'] == self.current_category]
        
        # Apply active filters
        for filter_name in self.active_filters:
            if filter_name == "Recent":
                week_ago = datetime.now() - timedelta(days=7)
                self.filtered_results = [result for result in self.filtered_results
                                       if datetime.strptime(result['date'], '%Y-%m-%d') >= week_ago]
            elif filter_name == "Large Files":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['size_value'] > 10.0]
            elif filter_name == "Images Only":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['type'] == 'image']
            elif filter_name == "Videos Only":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['type'] == 'video']
            elif filter_name == "Free":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['price'] == 0.0]
            elif filter_name == "Premium":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['price'] > 0.0]
        
        # Apply sorting
        if self.current_sort == "Date":
            self.filtered_results.sort(key=lambda x: x['date'], reverse=True)
        elif self.current_sort == "Name":
            self.filtered_results.sort(key=lambda x: x['title'])
        elif self.current_sort == "Size":
            self.filtered_results.sort(key=lambda x: x['size_value'], reverse=True)
        elif self.current_sort == "Type":
            self.filtered_results.sort(key=lambda x: x['type'])
        elif self.current_sort == "Rating":
            self.filtered_results.sort(key=lambda x: x['rating'], reverse=True)
        else:  # Relevance
            self.filtered_results.sort(key=lambda x: x['rating'], reverse=True)
        
        self.update_results()
    
    def update_results(self):
        # Update results count
        count = len(self.filtered_results)
        self.results_count_label.setText(f"{count} results found")
        
        # Update pagination
        self.total_pages = max(1, (count + self.results_per_page - 1) // self.results_per_page)
        self.current_page = min(self.current_page, self.total_pages)
        self.current_page = max(1, self.current_page)
        
        # Update page info
        self.page_info_label.setText(f"Page {self.current_page} of {self.total_pages}")
        
        # Update pagination buttons
        self.first_btn.setEnabled(self.current_page > 1)
        self.prev_btn.setEnabled(self.current_page > 1)
        self.next_btn.setEnabled(self.current_page < self.total_pages)
        self.last_btn.setEnabled(self.current_page < self.total_pages)
        
        # Clear results list
        self.results_list.clear()
        
        if count == 0:
            # Show empty state
            self.results_list.hide()
            self.empty_state_widget.show()
        else:
            # Hide empty state
            self.empty_state_widget.hide()
            self.results_list.show()
            
            # Add results
            start_idx = (self.current_page - 1) * self.results_per_page
            end_idx = min(start_idx + self.results_per_page, count)
            
            for i in range(start_idx, end_idx):
                result = self.filtered_results[i]
                item = self.create_result_item(result)
                self.results_list.addItem(item)
    
    def create_result_item(self, result):
        item = QListWidgetItem()
        
        # Create custom widget for result
        widget = QWidget()
        layout = QHBoxLayout()
        widget.setLayout(layout)
        
        # Icon
        icon_label = QLabel(result['icon'])
        icon_label.setStyleSheet("font-size: 32px;")
        layout.addWidget(icon_label)
        
        # Content
        content_layout = QVBoxLayout()
        
        # Title
        title_label = QLabel(result['title'])
        title_label.setFont(QFont("Arial", 14, QFont.Bold))
        title_label.setWordWrap(True)
        content_layout.addWidget(title_label)
        
        # Description
        desc_label = QLabel(result['description'])
        desc_label.setStyleSheet("color: #666666;")
        desc_label.setWordWrap(True)
        content_layout.addWidget(desc_label)
        
        # Metadata
        metadata_layout = QHBoxLayout()
        
        cat_label = QLabel(result['category'])
        cat_label.setStyleSheet("color: #4A90E2; font-weight: bold;")
        metadata_layout.addWidget(cat_label)
        
        date_label = QLabel(result['date'])
        date_label.setStyleSheet("color: #999999;")
        metadata_layout.addWidget(date_label)
        
        rating_label = QLabel(f"⭐ {result['rating']:.1f}")
        rating_label.setStyleSheet("color: #999999;")
        metadata_layout.addWidget(rating_label)
        
        size_label = QLabel(result['size'])
        size_label.setStyleSheet("color: #999999;")
        metadata_layout.addWidget(size_label)
        
        metadata_layout.addStretch()
        
        content_layout.addLayout(metadata_layout)
        
        layout.addLayout(content_layout)
        layout.addStretch()
        
        # Price/Actions
        right_layout = QVBoxLayout()
        
        # Price
        price_text = f"${result['price']:.2f}" if result['price'] > 0 else "Free"
        price_label = QLabel(price_text)
        price_label.setFont(QFont("Arial", 16, QFont.Bold))
        price_label.setAlignment(Qt.AlignRight)
        right_layout.addWidget(price_label)
        
        # Actions
        actions_layout = QHBoxLayout()
        
        preview_btn = QPushButton("👁")
        preview_btn.setToolTip("Preview")
        preview_btn.clicked.connect(lambda: self.on_preview_clicked(result))
        actions_layout.addWidget(preview_btn)
        
        download_btn = QPushButton("⬇")
        download_btn.setToolTip("Download")
        download_btn.clicked.connect(lambda: self.on_download_clicked(result))
        actions_layout.addWidget(download_btn)
        
        bookmark_btn = QPushButton("🔖")
        bookmark_btn.setToolTip("Bookmark")
        bookmark_btn.clicked.connect(lambda: self.on_bookmark_clicked(result))
        actions_layout.addWidget(bookmark_btn)
        
        right_layout.addLayout(actions_layout)
        
        layout.addLayout(right_layout)
        
        item.setSizeHint(widget.sizeHint())
        self.results_list.setItemWidget(item, widget)
        
        return item
    
    # Event handlers
    def on_search_changed(self):
        self.perform_search()
    
    def on_category_changed(self, category):
        self.current_category = category
        self.perform_search()
    
    def on_sort_changed(self, sort):
        self.current_sort = sort
        self.perform_search()
    
    def on_view_changed(self, view):
        self.status_bar.showMessage(f"View mode changed to {view}")
    
    def on_clear_filters_clicked(self):
        self.active_filters.clear()
        for checkbox in self.filter_checkboxes.values():
            checkbox.setChecked(False)
        self.current_category = "All"
        self.category_combo.setCurrentText("All")
        self.search_entry.clear()
        self.perform_search()
    
    def on_filter_changed(self, filter_name, state):
        if state == Qt.Checked:
            if filter_name not in self.active_filters:
                self.active_filters.append(filter_name)
        else:
            if filter_name in self.active_filters:
                self.active_filters.remove(filter_name)
        self.perform_search()
    
    def on_per_page_changed(self, per_page):
        self.results_per_page = int(per_page)
        self.current_page = 1
        self.update_results()
    
    def on_result_clicked(self, item):
        self.status_bar.showMessage("Result selected")
    
    def on_preview_clicked(self, result):
        QMessageBox.information(self, "Preview", f"Preview: {result['title']}\n\n{result['description']}")
    
    def on_download_clicked(self, result):
        QMessageBox.information(self, "Download", f"Downloading: {result['title']}")
    
    def on_bookmark_clicked(self, result):
        QMessageBox.information(self, "Bookmark", f"Bookmarked: {result['title']}")
    
    def on_advanced_search_clicked(self):
        QMessageBox.information(self, "Advanced Search", "Advanced search options would be implemented here.")
    
    def on_first_page(self):
        self.current_page = 1
        self.update_results()
    
    def on_prev_page(self):
        if self.current_page > 1:
            self.current_page -= 1
            self.update_results()
    
    def on_next_page(self):
        if self.current_page < self.total_pages:
            self.current_page += 1
            self.update_results()
    
    def on_last_page(self):
        self.current_page = self.total_pages
        self.update_results()

def main():
    app = QApplication(sys.argv)
    
    # Set application style
    app.setStyle('Fusion')
    
    window = ComplexSearchInterface()
    window.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

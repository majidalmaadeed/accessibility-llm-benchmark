import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class MissingSkipLink(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Company Website")
        self.setGeometry(100, 100, 1000, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # MISSING SKIP LINK - Page navigation without skip-to-content link
        # Tab Navigation
        tab_layout = QHBoxLayout()
        tab_layout.setSpacing(0)
        
        tab_buttons = [
            ("Home", True),
            ("Products", False),
            ("About", False),
            ("Contact", False)
        ]
        
        for label, is_active in tab_buttons:
            button = QPushButton(label)
            if is_active:
                button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
            button.clicked.connect(lambda checked, l=label: self.on_tab_clicked(l))
            tab_layout.addWidget(button)
        
        main_layout.addLayout(tab_layout)
        
        # Main content scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        content_widget = QWidget()
        content_layout = QVBoxLayout(content_widget)
        content_layout.setSpacing(30)
        content_layout.setContentsMargins(20, 30, 20, 30)
        
        # Hero section
        hero_layout = QVBoxLayout()
        hero_layout.setAlignment(Qt.AlignCenter)
        
        hero_title = QLabel("Welcome to Our Website")
        hero_title_font = QFont()
        hero_title_font.setPointSize(24)
        hero_title_font.setBold(True)
        hero_title.setFont(hero_title_font)
        hero_title.setAlignment(Qt.AlignCenter)
        hero_layout.addWidget(hero_title)
        
        hero_subtitle = QLabel("Discover amazing products and services")
        hero_subtitle_font = QFont()
        hero_subtitle_font.setPointSize(16)
        hero_subtitle.setFont(hero_subtitle_font)
        hero_subtitle.setAlignment(Qt.AlignCenter)
        hero_layout.addWidget(hero_subtitle)
        
        get_started_button = QPushButton("Get Started")
        get_started_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        get_started_button.setFixedSize(120, 40)
        get_started_button.clicked.connect(self.on_get_started_clicked)
        hero_layout.addWidget(get_started_button)
        
        content_layout.addLayout(hero_layout)
        
        # Features section
        features_label = QLabel("Our Features")
        features_font = QFont()
        features_font.setPointSize(18)
        features_font.setBold(True)
        features_label.setFont(features_font)
        content_layout.addWidget(features_label)
        
        features_grid = QGridLayout()
        features_grid.setSpacing(20)
        
        features = [
            ("🚀", "Fast Performance", "Lightning-fast loading times"),
            ("🔒", "Secure", "Your data is safe with us"),
            ("💡", "Innovative", "Cutting-edge technology")
        ]
        
        for i, (icon, title, subtitle) in enumerate(features):
            feature_frame = self.create_feature_card(icon, title, subtitle)
            features_grid.addWidget(feature_frame, i // 3, i % 3)
        
        content_layout.addLayout(features_grid)
        
        # Products section
        products_label = QLabel("Featured Products")
        products_label.setFont(features_font)
        content_layout.addWidget(products_label)
        
        products_grid = QGridLayout()
        products_grid.setSpacing(20)
        
        products = [
            {
                "name": "Product 1",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "📱"
            },
            {
                "name": "Product 2",
                "price": "$199.99",
                "original_price": "$249.99",
                "rating": "4.8",
                "image": "💻"
            },
            {
                "name": "Product 3",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.7",
                "image": "⌚"
            }
        ]
        
        for i, product in enumerate(products):
            product_frame = self.create_product_card(product)
            products_grid.addWidget(product_frame, i // 3, i % 3)
        
        content_layout.addLayout(products_grid)
        
        scroll_area.setWidget(content_widget)
        main_layout.addWidget(scroll_area)
        
    def create_feature_card(self, icon, title, subtitle):
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
    
    def create_product_card(self, product):
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setFixedSize(250, 300)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QVBoxLayout(frame)
        main_layout.setSpacing(10)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # Product image
        product_image = QLabel(product["image"])
        product_image.setAlignment(Qt.AlignCenter)
        product_image.setStyleSheet("font-size: 100px;")
        product_image.setFixedHeight(150)
        main_layout.addWidget(product_image)
        
        # Product name
        name_label = QLabel(product["name"])
        name_font = QFont()
        name_font.setPointSize(16)
        name_font.setBold(True)
        name_label.setFont(name_font)
        name_label.setWordWrap(True)
        main_layout.addWidget(name_label)
        
        # Rating
        rating_label = QLabel(f"⭐ {product['rating']}")
        main_layout.addWidget(rating_label)
        
        # Price
        price_layout = QHBoxLayout()
        
        current_price = QLabel(product["price"])
        price_font = QFont()
        price_font.setPointSize(16)
        price_font.setBold(True)
        current_price.setFont(price_font)
        current_price.setStyleSheet("color: green;")
        price_layout.addWidget(current_price)
        
        original_price = QLabel(product["original_price"])
        original_price.setStyleSheet("text-decoration: line-through; color: gray;")
        price_layout.addWidget(original_price)
        
        price_layout.addStretch()
        main_layout.addLayout(price_layout)
        
        # Add to cart button
        add_to_cart_button = QPushButton("Add to Cart")
        add_to_cart_button.setStyleSheet("QPushButton { background-color: #28a745; color: white; font-weight: bold; }")
        add_to_cart_button.setFixedHeight(40)
        main_layout.addWidget(add_to_cart_button)
        
        return frame
    
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
    
    def on_get_started_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Get Started", 
                               "Welcome! Let's get you started with our amazing products and services.")

def main():
    app = QApplication(sys.argv)
    window = MissingSkipLink()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

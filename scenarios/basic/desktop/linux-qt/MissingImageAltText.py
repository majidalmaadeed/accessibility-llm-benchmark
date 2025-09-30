import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont, QPixmap

class MissingImageAltText(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("TechStore")
        self.setGeometry(100, 100, 1200, 800)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(20)
        
        # Header
        header_layout = QVBoxLayout()
        header_layout.setAlignment(Qt.AlignCenter)
        
        title_label = QLabel("TechStore")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(title_label)
        
        subtitle_label = QLabel("Discover amazing tech products")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(header_layout)
        
        # Category filter
        category_layout = QHBoxLayout()
        category_layout.setAlignment(Qt.AlignCenter)
        category_layout.setSpacing(10)
        
        categories = ["All", "Electronics", "Clothing", "Home", "Sports"]
        for category in categories:
            button = QPushButton(category)
            if category == "All":
                button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
            button.setFixedSize(100, 40)
            category_layout.addWidget(button)
        
        main_layout.addLayout(category_layout)
        
        # Products scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        scroll_area.setHorizontalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        # Products container
        products_widget = QWidget()
        products_layout = QGridLayout(products_widget)
        products_layout.setSpacing(20)
        
        # Load products
        self.load_products(products_layout)
        
        scroll_area.setWidget(products_widget)
        main_layout.addWidget(scroll_area)
        
    def load_products(self, layout):
        products = [
            {
                "name": "Wireless Headphones",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "🎧"
            },
            {
                "name": "Smart Watch",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.8",
                "image": "⌚"
            },
            {
                "name": "Portable Speaker",
                "price": "$79.99",
                "original_price": "$99.99",
                "rating": "4.3",
                "image": "🔊"
            },
            {
                "name": "Gaming Mouse",
                "price": "$59.99",
                "original_price": "$79.99",
                "rating": "4.6",
                "image": "🖱️"
            },
            {
                "name": "Mechanical Keyboard",
                "price": "$129.99",
                "original_price": "$179.99",
                "rating": "4.7",
                "image": "⌨️"
            },
            {
                "name": "USB-C Hub",
                "price": "$49.99",
                "original_price": "$69.99",
                "rating": "4.2",
                "image": "🔌"
            }
        ]
        
        row = 0
        col = 0
        max_cols = 3
        
        for product in products:
            product_frame = self.create_product_card(product)
            layout.addWidget(product_frame, row, col)
            
            col += 1
            if col >= max_cols:
                col = 0
                row += 1
    
    def create_product_card(self, product):
        # Product frame
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setFixedSize(300, 400)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        layout = QVBoxLayout(frame)
        layout.setSpacing(10)
        layout.setContentsMargins(10, 10, 10, 10)
        
        # MISSING IMAGE ALT TEXT - Product image without alternative text
        image_label = QLabel(product["image"])
        image_label.setAlignment(Qt.AlignCenter)
        image_label.setStyleSheet("font-size: 100px;")
        image_label.setFixedHeight(200)
        layout.addWidget(image_label)
        
        # Product name
        name_label = QLabel(product["name"])
        name_font = QFont()
        name_font.setPointSize(16)
        name_font.setBold(True)
        name_label.setFont(name_font)
        name_label.setWordWrap(True)
        layout.addWidget(name_label)
        
        # Rating
        rating_label = QLabel(f"⭐ {product['rating']}")
        layout.addWidget(rating_label)
        
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
        layout.addLayout(price_layout)
        
        # Add to cart button
        add_to_cart_button = QPushButton("Add to Cart")
        add_to_cart_button.setStyleSheet("QPushButton { background-color: #28a745; color: white; font-weight: bold; }")
        add_to_cart_button.setFixedHeight(40)
        layout.addWidget(add_to_cart_button)
        
        return frame

def main():
    app = QApplication(sys.argv)
    window = MissingImageAltText()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

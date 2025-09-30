import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont, QPalette, QColor

class DecorativeImageWithAltText(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Product Store")
        self.setGeometry(100, 100, 1200, 800)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Hero section with decorative images
        hero_frame = QFrame()
        hero_frame.setFixedHeight(200)
        hero_frame.setStyleSheet("QFrame { background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2); }")
        
        hero_layout = QVBoxLayout(hero_frame)
        hero_layout.setAlignment(Qt.AlignCenter)
        hero_layout.setSpacing(15)
        
        # Hero title
        title_label = QLabel("Discover Amazing Products")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        title_label.setStyleSheet("color: white;")
        hero_layout.addWidget(title_label)
        
        subtitle_label = QLabel("Find the perfect items for your needs")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        subtitle_label.setStyleSheet("color: white;")
        hero_layout.addWidget(subtitle_label)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative background pattern has unnecessary descriptive alt text
        decorative_bg = QLabel("🎨")
        decorative_bg.setAlignment(Qt.AlignRight | Qt.AlignTop)
        decorative_bg.setStyleSheet("font-size: 100px; opacity: 0.3;")
        hero_layout.addWidget(decorative_bg)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Another decorative element has unnecessary descriptive alt text
        decorative_corner = QLabel("🎨")
        decorative_corner.setAlignment(Qt.AlignLeft | Qt.AlignBottom)
        decorative_corner.setStyleSheet("font-size: 80px; opacity: 0.5;")
        hero_layout.addWidget(decorative_corner)
        
        main_layout.addWidget(hero_frame)
        
        # Category filter
        category_layout = QHBoxLayout()
        category_layout.setAlignment(Qt.AlignCenter)
        category_layout.setSpacing(10)
        category_layout.setContentsMargins(20, 20, 20, 20)
        
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
        products_layout.setContentsMargins(20, 20, 20, 20)
        
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
        
        main_layout = QVBoxLayout(frame)
        main_layout.setSpacing(10)
        main_layout.setContentsMargins(10, 10, 10, 10)
        
        # Product image container with decorative elements
        image_container = QVBoxLayout()
        
        # MISSING IMAGE ALT TEXT - Product image without alternative text
        product_image = QLabel(product["image"])
        product_image.setAlignment(Qt.AlignCenter)
        product_image.setStyleSheet("font-size: 100px;")
        product_image.setFixedHeight(200)
        image_container.addWidget(product_image)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative border pattern has unnecessary descriptive alt text
        decorative_border = QLabel("🎨")
        decorative_border.setAlignment(Qt.AlignCenter)
        decorative_border.setStyleSheet("font-size: 200px; opacity: 0.3;")
        image_container.addWidget(decorative_border)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative corner element has unnecessary descriptive alt text
        corner_layout = QHBoxLayout()
        corner_layout.addStretch()
        
        decorative_corner = QLabel("🎨")
        decorative_corner.setStyleSheet("font-size: 20px;")
        corner_layout.addWidget(decorative_corner)
        
        image_container.addLayout(corner_layout)
        main_layout.addLayout(image_container)
        
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

def main():
    app = QApplication(sys.argv)
    window = DecorativeImageWithAltText()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

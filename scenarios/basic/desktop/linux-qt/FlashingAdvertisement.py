import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont

class FlashingAdvertisement(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Flash Sale Store")
        self.setGeometry(100, 100, 1200, 800)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # FLASHING ADVERTISEMENT - FLASHING 5 TIMES PER SECOND
        self.flash_frame = QFrame()
        self.flash_frame.setFixedHeight(80)
        self.flash_frame.setStyleSheet("QFrame { background-color: #ff0000; }")
        
        flash_layout = QHBoxLayout(self.flash_frame)
        flash_layout.setSpacing(15)
        flash_layout.setContentsMargins(20, 10, 20, 10)
        
        # Flash icon
        flash_icon = QLabel("🔥")
        flash_icon.setStyleSheet("font-size: 24px;")
        flash_layout.addWidget(flash_icon)
        
        # Flash content
        flash_content_layout = QVBoxLayout()
        
        flash_title = QLabel("FLASH SALE!")
        flash_title_font = QFont()
        flash_title_font.setPointSize(16)
        flash_title_font.setBold(True)
        flash_title.setFont(flash_title_font)
        flash_title.setStyleSheet("color: white;")
        flash_content_layout.addWidget(flash_title)
        
        flash_message = QLabel("Up to 50% OFF!")
        flash_message_font = QFont()
        flash_message_font.setPointSize(14)
        flash_message.setFont(flash_message_font)
        flash_message.setStyleSheet("color: white;")
        flash_content_layout.addWidget(flash_message)
        
        flash_layout.addLayout(flash_content_layout)
        
        # Flash count and pause button
        control_layout = QVBoxLayout()
        
        self.flash_count_label = QLabel("Flashes: 0")
        self.flash_count_label.setStyleSheet("color: white; font-weight: bold; background-color: rgba(0, 0, 0, 0.2); padding: 4px 8px; border-radius: 6px;")
        control_layout.addWidget(self.flash_count_label)
        
        self.pause_button = QPushButton("⏸️")
        self.pause_button.setFixedSize(40, 40)
        self.pause_button.clicked.connect(self.on_pause_clicked)
        control_layout.addWidget(self.pause_button)
        
        flash_layout.addLayout(control_layout)
        
        main_layout.addWidget(self.flash_frame)
        
        # Products section
        products_label = QLabel("Featured Products")
        products_font = QFont()
        products_font.setPointSize(18)
        products_font.setBold(True)
        products_label.setFont(products_font)
        products_label.setAlignment(Qt.AlignCenter)
        products_label.setContentsMargins(20, 20, 20, 20)
        main_layout.addWidget(products_label)
        
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
        
        # Start flash animation
        self.flash_count = 0
        self.is_flashing = True
        self.flash_timer = QTimer()
        self.flash_timer.timeout.connect(self.update_flash_display)
        self.flash_timer.start(200)  # 5 times per second
        
    def load_products(self, layout):
        products = [
            {
                "name": "Wireless Headphones",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "🎧",
                "is_out_of_stock": False
            },
            {
                "name": "Smart Watch",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.8",
                "image": "⌚",
                "is_out_of_stock": False
            },
            {
                "name": "Portable Speaker",
                "price": "$79.99",
                "original_price": "$99.99",
                "rating": "4.3",
                "image": "🔊",
                "is_out_of_stock": True
            },
            {
                "name": "Gaming Mouse",
                "price": "$59.99",
                "original_price": "$79.99",
                "rating": "4.6",
                "image": "🖱️",
                "is_out_of_stock": False
            },
            {
                "name": "Mechanical Keyboard",
                "price": "$129.99",
                "original_price": "$179.99",
                "rating": "4.7",
                "image": "⌨️",
                "is_out_of_stock": False
            },
            {
                "name": "USB-C Hub",
                "price": "$49.99",
                "original_price": "$69.99",
                "rating": "4.2",
                "image": "🔌",
                "is_out_of_stock": False
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
        
        # Product image container
        image_container = QVBoxLayout()
        
        # Product image
        product_image = QLabel(product["image"])
        product_image.setAlignment(Qt.AlignCenter)
        product_image.setStyleSheet("font-size: 100px;")
        product_image.setFixedHeight(200)
        image_container.addWidget(product_image)
        
        # Out of stock overlay
        if product["is_out_of_stock"]:
            out_of_stock_label = QLabel("Out of Stock")
            out_of_stock_label.setAlignment(Qt.AlignCenter)
            out_of_stock_label.setStyleSheet("color: white; font-weight: bold; background-color: rgba(0, 0, 0, 0.7); border-radius: 8px; padding: 4px 8px;")
            image_container.addWidget(out_of_stock_label)
        
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
        
        # Save label
        save_amount = float(product['original_price'].replace('$', '')) - float(product['price'].replace('$', ''))
        save_label = QLabel(f"Save ${int(save_amount)}")
        save_label.setAlignment(Qt.AlignCenter)
        save_label.setStyleSheet("color: white; font-weight: bold; background-color: #4CAF50; border-radius: 4px; padding: 4px 8px;")
        main_layout.addWidget(save_label)
        
        # Add to cart button
        add_to_cart_button = QPushButton("Add to Cart" if not product["is_out_of_stock"] else "Out of Stock")
        if not product["is_out_of_stock"]:
            add_to_cart_button.setStyleSheet("QPushButton { background-color: #28a745; color: white; font-weight: bold; }")
        else:
            add_to_cart_button.setEnabled(False)
        add_to_cart_button.setFixedHeight(40)
        main_layout.addWidget(add_to_cart_button)
        
        return frame
    
    def update_flash_display(self):
        if self.is_flashing:
            self.flash_count += 1
            self.flash_count_label.setText(f"Flashes: {self.flash_count}")
            
            # Toggle between red and orange
            if self.flash_count % 2 == 0:
                self.flash_frame.setStyleSheet("QFrame { background-color: #ff0000; }")
            else:
                self.flash_frame.setStyleSheet("QFrame { background-color: #ff8800; }")
    
    def on_pause_clicked(self):
        self.is_flashing = not self.is_flashing
        if self.is_flashing:
            self.pause_button.setText("⏸️")
        else:
            self.pause_button.setText("▶️")

def main():
    app = QApplication(sys.argv)
    window = FlashingAdvertisement()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

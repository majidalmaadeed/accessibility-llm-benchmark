import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time

class FlashingAdvertisement(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Flash Sale Store")
        self.set_default_size(1200, 800)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # FLASHING ADVERTISEMENT - FLASHING 5 TIMES PER SECOND
        self.flash_banner = Gtk.Frame()
        self.flash_banner.set_size_request(-1, 80)
        self.flash_banner.get_style_context().add_class("flash-banner")
        
        flash_box = Gtk.HBox(spacing=15)
        flash_box.set_margin_left(20)
        flash_box.set_margin_right(20)
        flash_box.set_margin_top(10)
        flash_box.set_margin_bottom(10)
        
        # Flash icon
        flash_icon = Gtk.Label("🔥")
        flash_icon.set_markup("<span size='large'>🔥</span>")
        flash_box.pack_start(flash_icon, False, False, 0)
        
        # Flash content
        flash_content = Gtk.VBox(spacing=5)
        
        flash_title = Gtk.Label("FLASH SALE!")
        flash_title.set_markup("<span weight='bold' size='large' color='white'>FLASH SALE!</span>")
        flash_title.set_halign(Gtk.Align.START)
        flash_content.pack_start(flash_title, False, False, 0)
        
        flash_message = Gtk.Label("Up to 50% OFF!")
        flash_message.set_markup("<span size='large' color='white'>Up to 50% OFF!</span>")
        flash_message.set_halign(Gtk.Align.START)
        flash_content.pack_start(flash_message, False, False, 0)
        
        flash_box.pack_start(flash_content, True, True, 0)
        
        # Flash count and pause button
        control_box = Gtk.VBox(spacing=5)
        
        self.flash_count_label = Gtk.Label("Flashes: 0")
        self.flash_count_label.set_markup("<span weight='bold' color='white'>Flashes: 0</span>")
        self.flash_count_label.get_style_context().add_class("flash-count")
        control_box.pack_start(self.flash_count_label, False, False, 0)
        
        self.pause_button = Gtk.Button("⏸️")
        self.pause_button.set_size_request(40, 40)
        self.pause_button.connect("clicked", self.on_pause_clicked)
        control_box.pack_start(self.pause_button, False, False, 0)
        
        flash_box.pack_start(control_box, False, False, 0)
        
        self.flash_banner.add(flash_box)
        main_box.pack_start(self.flash_banner, False, False, 0)
        
        # Products section
        products_label = Gtk.Label()
        products_label.set_markup("<span size='x-large' weight='bold'>Featured Products</span>")
        products_label.set_halign(Gtk.Align.CENTER)
        products_label.set_margin_top(20)
        products_label.set_margin_bottom(20)
        main_box.pack_start(products_label, False, False, 0)
        
        # Products scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        # Grid for products
        self.products_grid = Gtk.Grid()
        self.products_grid.set_column_spacing(20)
        self.products_grid.set_row_spacing(20)
        self.products_grid.set_margin_left(20)
        self.products_grid.set_margin_right(20)
        self.products_grid.set_margin_top(20)
        self.products_grid.set_margin_bottom(20)
        
        scrolled_window.add(self.products_grid)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # Load products
        self.load_products()
        
        # Start flash animation
        self.flash_count = 0
        self.is_flashing = True
        self.start_flash_animation()
        
    def load_products(self):
        products = [
            {
                "name": "Wireless Headphones",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "audio-headphones",
                "is_out_of_stock": False
            },
            {
                "name": "Smart Watch",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.8",
                "image": "preferences-desktop-wallpaper",
                "is_out_of_stock": False
            },
            {
                "name": "Portable Speaker",
                "price": "$79.99",
                "original_price": "$99.99",
                "rating": "4.3",
                "image": "audio-speakers",
                "is_out_of_stock": True
            },
            {
                "name": "Gaming Mouse",
                "price": "$59.99",
                "original_price": "$79.99",
                "rating": "4.6",
                "image": "input-mouse",
                "is_out_of_stock": False
            },
            {
                "name": "Mechanical Keyboard",
                "price": "$129.99",
                "original_price": "$179.99",
                "rating": "4.7",
                "image": "input-keyboard",
                "is_out_of_stock": False
            },
            {
                "name": "USB-C Hub",
                "price": "$49.99",
                "original_price": "$69.99",
                "rating": "4.2",
                "image": "network-wired",
                "is_out_of_stock": False
            }
        ]
        
        row = 0
        col = 0
        max_cols = 3
        
        for product in products:
            product_frame = self.create_product_card(product)
            self.products_grid.attach(product_frame, col, row, 1, 1)
            
            col += 1
            if col >= max_cols:
                col = 0
                row += 1
    
    def create_product_card(self, product):
        # Product frame
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_size_request(300, 400)
        
        # Main container
        main_box = Gtk.VBox(spacing=10)
        main_box.set_margin_left(10)
        main_box.set_margin_right(10)
        main_box.set_margin_top(10)
        main_box.set_margin_bottom(10)
        frame.add(main_box)
        
        # Product image container
        image_container = Gtk.VBox()
        
        # Product image
        product_image = Gtk.Image()
        product_image.set_from_icon_name(product["image"], Gtk.IconSize.DIALOG)
        product_image.set_pixel_size(200)
        image_container.pack_start(product_image, True, True, 0)
        
        # Out of stock overlay
        if product["is_out_of_stock"]:
            out_of_stock_label = Gtk.Label("Out of Stock")
            out_of_stock_label.set_markup("<span weight='bold' color='white'>Out of Stock</span>")
            out_of_stock_label.get_style_context().add_class("out-of-stock")
            out_of_stock_label.set_halign(Gtk.Align.CENTER)
            out_of_stock_label.set_valign(Gtk.Align.CENTER)
            image_container.pack_start(out_of_stock_label, True, True, 0)
        
        main_box.pack_start(image_container, False, False, 0)
        
        # Product name
        name_label = Gtk.Label()
        name_label.set_markup(f"<span weight='bold' size='large'>{product['name']}</span>")
        name_label.set_line_wrap(True)
        name_label.set_halign(Gtk.Align.START)
        main_box.pack_start(name_label, False, False, 0)
        
        # Rating
        rating_label = Gtk.Label(f"⭐ {product['rating']}")
        rating_label.set_halign(Gtk.Align.START)
        main_box.pack_start(rating_label, False, False, 0)
        
        # Price
        price_box = Gtk.HBox(spacing=5)
        
        current_price_label = Gtk.Label()
        current_price_label.set_markup(f"<span weight='bold' size='large' color='green'>{product['price']}</span>")
        price_box.pack_start(current_price_label, False, False, 0)
        
        original_price_label = Gtk.Label()
        original_price_label.set_markup(f"<span strikethrough='true' color='gray'>{product['original_price']}</span>")
        price_box.pack_start(original_price_label, False, False, 0)
        
        main_box.pack_start(price_box, False, False, 0)
        
        # Save label
        save_amount = float(product['original_price'].replace('$', '')) - float(product['price'].replace('$', ''))
        save_label = Gtk.Label(f"Save ${int(save_amount)}")
        save_label.set_markup(f"<span weight='bold' color='white'>Save ${int(save_amount)}</span>")
        save_label.get_style_context().add_class("save-label")
        save_label.set_halign(Gtk.Align.CENTER)
        main_box.pack_start(save_label, False, False, 0)
        
        # Add to cart button
        add_to_cart_button = Gtk.Button("Add to Cart" if not product["is_out_of_stock"] else "Out of Stock")
        if not product["is_out_of_stock"]:
            add_to_cart_button.get_style_context().add_class("suggested-action")
        else:
            add_to_cart_button.set_sensitive(False)
        main_box.pack_start(add_to_cart_button, False, False, 0)
        
        return frame
    
    def start_flash_animation(self):
        def flash_loop():
            while True:
                if self.is_flashing:
                    self.flash_count += 1
                    GLib.idle_add(self.update_flash_display)
                time.sleep(0.2)  # 5 times per second
        
        thread = threading.Thread(target=flash_loop, daemon=True)
        thread.start()
    
    def update_flash_display(self):
        self.flash_count_label.set_markup(f"<span weight='bold' color='white'>Flashes: {self.flash_count}</span>")
        
        # Toggle between red and orange
        if self.flash_count % 2 == 0:
            self.flash_banner.get_style_context().add_class("flash-red")
            self.flash_banner.get_style_context().remove_class("flash-orange")
        else:
            self.flash_banner.get_style_context().add_class("flash-orange")
            self.flash_banner.get_style_context().remove_class("flash-red")
        
        return False
    
    def on_pause_clicked(self, button):
        self.is_flashing = not self.is_flashing
        if self.is_flashing:
            button.set_label("⏸️")
        else:
            button.set_label("▶️")

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .flash-banner {
        background-color: #ff0000;
    }
    .flash-red {
        background-color: #ff0000;
    }
    .flash-orange {
        background-color: #ff8800;
    }
    .flash-count {
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 6px;
        padding: 4px 8px;
    }
    .out-of-stock {
        background-color: rgba(0, 0, 0, 0.7);
        border-radius: 8px;
    }
    .save-label {
        background-color: #4CAF50;
        border-radius: 4px;
        padding: 4px 8px;
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = FlashingAdvertisement()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

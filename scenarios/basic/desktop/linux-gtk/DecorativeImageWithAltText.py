import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class DecorativeImageWithAltText(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Product Store")
        self.set_default_size(1200, 800)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Hero section with decorative images
        hero_frame = Gtk.Frame()
        hero_frame.set_size_request(-1, 200)
        hero_frame.get_style_context().add_class("hero-section")
        
        hero_box = Gtk.VBox(spacing=15)
        hero_box.set_halign(Gtk.Align.CENTER)
        hero_box.set_valign(Gtk.Align.CENTER)
        
        # Hero title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold' color='white'>Discover Amazing Products</span>")
        title_label.set_halign(Gtk.Align.CENTER)
        hero_box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label()
        subtitle_label.set_markup("<span size='large' color='white'>Find the perfect items for your needs</span>")
        subtitle_label.set_halign(Gtk.Align.CENTER)
        hero_box.pack_start(subtitle_label, False, False, 0)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative background pattern has unnecessary descriptive alt text
        decorative_bg = Gtk.Image()
        decorative_bg.set_from_icon_name("applications-graphics", Gtk.IconSize.DIALOG)
        decorative_bg.set_pixel_size(100)
        decorative_bg.set_opacity(0.3)
        decorative_bg.set_halign(Gtk.Align.END)
        decorative_bg.set_valign(Gtk.Align.START)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Another decorative element has unnecessary descriptive alt text
        decorative_corner = Gtk.Image()
        decorative_corner.set_from_icon_name("applications-graphics", Gtk.IconSize.BUTTON)
        decorative_corner.set_pixel_size(80)
        decorative_corner.set_opacity(0.5)
        decorative_corner.set_halign(Gtk.Align.START)
        decorative_corner.set_valign(Gtk.Align.END)
        
        hero_frame.add(hero_box)
        main_box.pack_start(hero_frame, False, False, 0)
        
        # Category filter
        category_box = Gtk.HBox(spacing=10)
        category_box.set_halign(Gtk.Align.CENTER)
        category_box.set_margin_top(20)
        category_box.set_margin_bottom(20)
        
        categories = ["All", "Electronics", "Clothing", "Home", "Sports"]
        for category in categories:
            button = Gtk.Button(category)
            if category == "All":
                button.get_style_context().add_class("suggested-action")
            category_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(category_box, False, False, 0)
        
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
        
    def load_products(self):
        products = [
            {
                "name": "Wireless Headphones",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "audio-headphones"
            },
            {
                "name": "Smart Watch",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.8",
                "image": "preferences-desktop-wallpaper"
            },
            {
                "name": "Portable Speaker",
                "price": "$79.99",
                "original_price": "$99.99",
                "rating": "4.3",
                "image": "audio-speakers"
            },
            {
                "name": "Gaming Mouse",
                "price": "$59.99",
                "original_price": "$79.99",
                "rating": "4.6",
                "image": "input-mouse"
            },
            {
                "name": "Mechanical Keyboard",
                "price": "$129.99",
                "original_price": "$179.99",
                "rating": "4.7",
                "image": "input-keyboard"
            },
            {
                "name": "USB-C Hub",
                "price": "$49.99",
                "original_price": "$69.99",
                "rating": "4.2",
                "image": "network-wired"
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
        
        # Product image container with decorative elements
        image_container = Gtk.VBox()
        
        # MISSING IMAGE ALT TEXT - Product image without alternative text
        product_image = Gtk.Image()
        product_image.set_from_icon_name(product["image"], Gtk.IconSize.DIALOG)
        product_image.set_pixel_size(200)
        image_container.pack_start(product_image, True, True, 0)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative border pattern has unnecessary descriptive alt text
        decorative_border = Gtk.Image()
        decorative_border.set_from_icon_name("applications-graphics", Gtk.IconSize.DIALOG)
        decorative_border.set_pixel_size(200)
        decorative_border.set_opacity(0.3)
        image_container.pack_start(decorative_border, True, True, 0)
        
        # DECORATIVE IMAGE WITH ALT TEXT - Decorative corner element has unnecessary descriptive alt text
        corner_container = Gtk.HBox()
        corner_container.pack_end(Gtk.Label(), True, True, 0)  # Spacer
        
        decorative_corner = Gtk.Image()
        decorative_corner.set_from_icon_name("applications-graphics", Gtk.IconSize.BUTTON)
        decorative_corner.set_pixel_size(20)
        corner_container.pack_end(decorative_corner, False, False, 0)
        
        image_container.pack_start(corner_container, False, False, 0)
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
        
        # Add to cart button
        add_to_cart_button = Gtk.Button("Add to Cart")
        add_to_cart_button.get_style_context().add_class("suggested-action")
        main_box.pack_start(add_to_cart_button, False, False, 0)
        
        return frame

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .hero-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = DecorativeImageWithAltText()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

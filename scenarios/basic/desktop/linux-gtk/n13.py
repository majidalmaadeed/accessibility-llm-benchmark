import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class MissingSkipLink(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Company Website")
        self.set_default_size(1000, 700)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # MISSING SKIP LINK - Page navigation without skip-to-content link
        # Tab Navigation
        tab_box = Gtk.HBox(spacing=0)
        
        tab_buttons = [
            ("Home", True),
            ("Products", False),
            ("About", False),
            ("Contact", False)
        ]
        
        for label, is_active in tab_buttons:
            button = Gtk.Button(label)
            if is_active:
                button.get_style_context().add_class("suggested-action")
            button.connect("clicked", self.on_tab_clicked, label)
            tab_box.pack_start(button, True, True, 0)
        
        main_box.pack_start(tab_box, False, False, 0)
        
        # Main content scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        content_box = Gtk.VBox(spacing=30)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top(30)
        content_box.set_margin_bottom=30
        
        # Hero section
        hero_box = Gtk.VBox(spacing=20)
        hero_box.set_halign(Gtk.Align.CENTER)
        
        hero_title = Gtk.Label()
        hero_title.set_markup("<span size='xx-large' weight='bold'>Welcome to Our Website</span>")
        hero_title.set_halign(Gtk.Align.CENTER)
        hero_box.pack_start(hero_title, False, False, 0)
        
        hero_subtitle = Gtk.Label()
        hero_subtitle.set_markup("<span size='large'>Discover amazing products and services</span>")
        hero_subtitle.set_halign(Gtk.Align.CENTER)
        hero_box.pack_start(hero_subtitle, False, False, 0)
        
        get_started_button = Gtk.Button("Get Started")
        get_started_button.get_style_context().add_class("suggested-action")
        get_started_button.set_size_request(120, 40)
        get_started_button.connect("clicked", self.on_get_started_clicked)
        hero_box.pack_start(get_started_button, False, False, 0)
        
        content_box.pack_start(hero_box, False, False, 0)
        
        # Features section
        features_label = Gtk.Label()
        features_label.set_markup("<span size='x-large' weight='bold'>Our Features</span>")
        features_label.set_halign(Gtk.Align.START)
        content_box.pack_start(features_label, False, False, 0)
        
        features_grid = Gtk.Grid()
        features_grid.set_column_spacing(20)
        features_grid.set_row_spacing(20)
        
        features = [
            ("🚀", "Fast Performance", "Lightning-fast loading times"),
            ("🔒", "Secure", "Your data is safe with us"),
            ("💡", "Innovative", "Cutting-edge technology")
        ]
        
        for i, (icon, title, subtitle) in enumerate(features):
            feature_frame = self.create_feature_card(icon, title, subtitle)
            features_grid.attach(feature_frame, i % 3, i // 3, 1, 1)
        
        content_box.pack_start(features_grid, False, False, 0)
        
        # Products section
        products_label = Gtk.Label()
        products_label.set_markup("<span size='x-large' weight='bold'>Featured Products</span>")
        products_label.set_halign(Gtk.Align.START)
        content_box.pack_start(products_label, False, False, 0)
        
        products_grid = Gtk.Grid()
        products_grid.set_column_spacing(20)
        products_grid.set_row_spacing(20)
        
        products = [
            {
                "name": "Product 1",
                "price": "$99.99",
                "original_price": "$149.99",
                "rating": "4.5",
                "image": "applications-graphics"
            },
            {
                "name": "Product 2",
                "price": "$199.99",
                "original_price": "$249.99",
                "rating": "4.8",
                "image": "applications-graphics"
            },
            {
                "name": "Product 3",
                "price": "$299.99",
                "original_price": "$399.99",
                "rating": "4.7",
                "image": "applications-graphics"
            }
        ]
        
        for i, product in enumerate(products):
            product_frame = self.create_product_card(product)
            products_grid.attach(product_frame, i % 3, i // 3, 1, 1)
        
        content_box.pack_start(products_grid, False, False, 0)
        
        scrolled_window.add(content_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
    def create_feature_card(self, icon, title, subtitle):
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_size_request(200, 120)
        
        box = Gtk.VBox(spacing=8)
        box.set_margin_left(15)
        box.set_margin_right(15)
        box.set_margin_top(15)
        box.set_margin_bottom(15)
        
        icon_label = Gtk.Label(icon)
        icon_label.set_markup(f"<span size='xx-large'>{icon}</span>")
        icon_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(icon_label, False, False, 0)
        
        title_label = Gtk.Label()
        title_label.set_markup(f"<span weight='bold'>{title}</span>")
        title_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label(subtitle)
        subtitle_label.set_halign(Gtk.Align.CENTER)
        subtitle_label.set_line_wrap(True)
        box.pack_start(subtitle_label, False, False, 0)
        
        frame.add(box)
        return frame
    
    def create_product_card(self, product):
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_size_request(250, 300)
        
        main_box = Gtk.VBox(spacing=10)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # Product image
        product_image = Gtk.Image()
        product_image.set_from_icon_name(product["image"], Gtk.IconSize.DIALOG)
        product_image.set_pixel_size(150)
        main_box.pack_start(product_image, False, False, 0)
        
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
    
    def on_tab_clicked(self, button, tab_name):
        # Update tab buttons
        for child in button.get_parent().get_children():
            if isinstance(child, Gtk.Button):
                child.get_style_context().remove_class("suggested-action")
        button.get_style_context().add_class("suggested-action")
        
        # Handle tab change
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text=f"Tab Changed"
        )
        dialog.format_secondary_text(f"Switched to {tab_name} tab")
        dialog.run()
        dialog.destroy()
    
    def on_get_started_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Get Started"
        )
        dialog.format_secondary_text("Welcome! Let's get you started with our amazing products and services.")
        dialog.run()
        dialog.destroy()

def main():
    win = MissingSkipLink()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

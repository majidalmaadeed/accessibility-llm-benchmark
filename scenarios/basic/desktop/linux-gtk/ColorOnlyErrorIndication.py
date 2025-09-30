import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class ColorOnlyErrorIndication(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Account Registration")
        self.set_default_size(600, 500)
        self.set_border_width(20)
        
        # Main container
        main_box = Gtk.VBox(spacing=20)
        self.add(main_box)
        
        # Header
        header_box = Gtk.VBox(spacing=10)
        header_box.set_halign(Gtk.Align.CENTER)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold'>Create Account</span>")
        header_box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label()
        subtitle_label.set_markup("<span size='large'>Please fill out the form below</span>")
        subtitle_label.set_halign(Gtk.Align.CENTER)
        header_box.pack_start(subtitle_label, False, False, 0)
        
        main_box.pack_start(header_box, False, False, 0)
        
        # Form
        form_frame = Gtk.Frame()
        form_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        form_box = Gtk.VBox(spacing=20)
        form_box.set_margin_left(20)
        form_box.set_margin_right(20)
        form_box.set_margin_top(20)
        form_box.set_margin_bottom=20)
        form_frame.add(form_box)
        
        # Form fields
        self.form_fields = []
        
        # Full Name field
        name_box = Gtk.VBox(spacing=5)
        
        name_label = Gtk.Label()
        name_label.set_markup("<span weight='bold' size='large'>Full Name</span>")
        name_label.set_halign(Gtk.Align.START)
        name_box.pack_start(name_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.name_entry = Gtk.Entry()
        self.name_entry.set_placeholder_text("Enter your full name")
        self.name_entry.set_size_request(300, 35)
        self.name_entry.get_style_context().add_class("error-field")  # Red border styling
        name_box.pack_start(self.name_entry, False, False, 0)
        
        form_box.pack_start(name_box, False, False, 0)
        
        # Email field
        email_box = Gtk.VBox(spacing=5)
        
        email_label = Gtk.Label()
        email_label.set_markup("<span weight='bold' size='large'>Email Address</span>")
        email_label.set_halign(Gtk.Align.START)
        email_box.pack_start(email_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.email_entry = Gtk.Entry()
        self.email_entry.set_placeholder_text("Enter your email")
        self.email_entry.set_size_request(300, 35)
        self.email_entry.get_style_context().add_class("error-field")  # Red border styling
        email_box.pack_start(self.email_entry, False, False, 0)
        
        form_box.pack_start(email_box, False, False, 0)
        
        # Password field
        password_box = Gtk.VBox(spacing=5)
        
        password_label = Gtk.Label()
        password_label.set_markup("<span weight='bold' size='large'>Password</span>")
        password_label.set_halign(Gtk.Align.START)
        password_box.pack_start(password_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.password_entry = Gtk.Entry()
        self.password_entry.set_placeholder_text("Enter your password")
        self.password_entry.set_visibility(False)
        self.password_entry.set_size_request(300, 35)
        self.password_entry.get_style_context().add_class("error-field")  # Red border styling
        password_box.pack_start(self.password_entry, False, False, 0)
        
        form_box.pack_start(password_box, False, False, 0)
        
        # Confirm Password field
        confirm_password_box = Gtk.VBox(spacing=5)
        
        confirm_password_label = Gtk.Label()
        confirm_password_label.set_markup("<span weight='bold' size='large'>Confirm Password</span>")
        confirm_password_label.set_halign(Gtk.Align.START)
        confirm_password_box.pack_start(confirm_password_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.confirm_password_entry = Gtk.Entry()
        self.confirm_password_entry.set_placeholder_text("Confirm your password")
        self.confirm_password_entry.set_visibility(False)
        self.confirm_password_entry.set_size_request(300, 35)
        self.confirm_password_entry.get_style_context().add_class("error-field")  # Red border styling
        confirm_password_box.pack_start(self.confirm_password_entry, False, False, 0)
        
        form_box.pack_start(confirm_password_box, False, False, 0)
        
        # Phone Number field
        phone_box = Gtk.VBox(spacing=5)
        
        phone_label = Gtk.Label()
        phone_label.set_markup("<span weight='bold' size='large'>Phone Number</span>")
        phone_label.set_halign(Gtk.Align.START)
        phone_box.pack_start(phone_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.phone_entry = Gtk.Entry()
        self.phone_entry.set_placeholder_text("Enter your phone number")
        self.phone_entry.set_size_request(300, 35)
        self.phone_entry.get_style_context().add_class("error-field")  # Red border styling
        phone_box.pack_start(self.phone_entry, False, False, 0)
        
        form_box.pack_start(phone_box, False, False, 0)
        
        # ZIP Code field
        zip_box = Gtk.VBox(spacing=5)
        
        zip_label = Gtk.Label()
        zip_label.set_markup("<span weight='bold' size='large'>ZIP Code</span>")
        zip_label.set_halign(Gtk.Align.START)
        zip_box.pack_start(zip_label, False, False, 0)
        
        # COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        self.zip_entry = Gtk.Entry()
        self.zip_entry.set_placeholder_text("Enter your ZIP code")
        self.zip_entry.set_size_request(300, 35)
        self.zip_entry.get_style_context().add_class("error-field")  # Red border styling
        zip_box.pack_start(self.zip_entry, False, False, 0)
        
        form_box.pack_start(zip_box, False, False, 0)
        
        main_box.pack_start(form_frame, False, False, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        
        create_account_button = Gtk.Button("Create Account")
        create_account_button.get_style_context().add_class("suggested-action")
        create_account_button.set_size_request(120, 40)
        create_account_button.connect("clicked", self.on_create_account_clicked)
        button_box.pack_start(create_account_button, False, False, 0)
        
        cancel_button = Gtk.Button("Cancel")
        cancel_button.set_size_request(120, 40)
        cancel_button.connect("clicked", self.on_cancel_clicked)
        button_box.pack_start(cancel_button, False, False, 0)
        
        main_box.pack_start(button_box, False, False, 0)
        
    def on_create_account_clicked(self, button):
        # Handle create account
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Account Created"
        )
        dialog.format_secondary_text("Your account has been created successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_cancel_clicked(self, button):
        # Handle cancel
        self.name_entry.set_text("")
        self.email_entry.set_text("")
        self.password_entry.set_text("")
        self.confirm_password_entry.set_text("")
        self.phone_entry.set_text("")
        self.zip_entry.set_text("")

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .error-field {
        border: 2px solid #ff0000;
        border-radius: 4px;
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = ColorOnlyErrorIndication()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

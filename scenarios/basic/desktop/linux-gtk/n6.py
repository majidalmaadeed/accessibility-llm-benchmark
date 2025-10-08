import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class InaccessibleTooltip(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Contact Form")
        self.set_default_size(600, 500)
        self.set_border_width(20)
        
        # Main container
        main_box = Gtk.VBox(spacing=20)
        self.add(main_box)
        
        # Header
        header_box = Gtk.VBox(spacing=10)
        header_box.set_halign(Gtk.Align.CENTER)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold'>Contact Form</span>")
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
        form_box.set_margin_bottom=20
        form_frame.add(form_box)
        
        # Form fields
        self.form_fields = []
        
        # Full Name field
        name_box = Gtk.VBox(spacing=5)
        
        name_label = Gtk.Label()
        name_label.set_markup("<span weight='bold' size='large'>Full Name</span>")
        name_label.set_halign(Gtk.Align.START)
        name_box.pack_start(name_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        name_field_box = Gtk.HBox(spacing=10)
        
        self.name_entry = Gtk.Entry()
        self.name_entry.set_placeholder_text("Enter your full name")
        self.name_entry.set_size_request(300, 35)
        name_field_box.pack_start(self.name_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Enter your full legal name")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "name")
        name_field_box.pack_start(help_button, False, False, 0)
        
        name_box.pack_start(name_field_box, False, False, 0)
        form_box.pack_start(name_box, False, False, 0)
        
        # Email field
        email_box = Gtk.VBox(spacing=5)
        
        email_label = Gtk.Label()
        email_label.set_markup("<span weight='bold' size='large'>Email Address</span>")
        email_label.set_halign(Gtk.Align.START)
        email_box.pack_start(email_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        email_field_box = Gtk.HBox(spacing=10)
        
        self.email_entry = Gtk.Entry()
        self.email_entry.set_placeholder_text("Enter your email")
        self.email_entry.set_size_request(300, 35)
        email_field_box.pack_start(self.email_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Enter a valid email address")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "email")
        email_field_box.pack_start(help_button, False, False, 0)
        
        email_box.pack_start(email_field_box, False, False, 0)
        form_box.pack_start(email_box, False, False, 0)
        
        # Phone field
        phone_box = Gtk.VBox(spacing=5)
        
        phone_label = Gtk.Label()
        phone_label.set_markup("<span weight='bold' size='large'>Phone Number</span>")
        phone_label.set_halign(Gtk.Align.START)
        phone_box.pack_start(phone_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        phone_field_box = Gtk.HBox(spacing=10)
        
        self.phone_entry = Gtk.Entry()
        self.phone_entry.set_placeholder_text("Enter your phone number")
        self.phone_entry.set_size_request(300, 35)
        phone_field_box.pack_start(self.phone_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Include country code if international")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "phone")
        phone_field_box.pack_start(help_button, False, False, 0)
        
        phone_box.pack_start(phone_field_box, False, False, 0)
        form_box.pack_start(phone_box, False, False, 0)
        
        # Street Address field
        address_box = Gtk.VBox(spacing=5)
        
        address_label = Gtk.Label()
        address_label.set_markup("<span weight='bold' size='large'>Street Address</span>")
        address_label.set_halign(Gtk.Align.START)
        address_box.pack_start(address_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        address_field_box = Gtk.HBox(spacing=10)
        
        self.address_entry = Gtk.Entry()
        self.address_entry.set_placeholder_text("Enter your street address")
        self.address_entry.set_size_request(300, 35)
        address_field_box.pack_start(self.address_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Include apartment or suite number")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "address")
        address_field_box.pack_start(help_button, False, False, 0)
        
        address_box.pack_start(address_field_box, False, False, 0)
        form_box.pack_start(address_box, False, False, 0)
        
        # City field
        city_box = Gtk.VBox(spacing=5)
        
        city_label = Gtk.Label()
        city_label.set_markup("<span weight='bold' size='large'>City</span>")
        city_label.set_halign(Gtk.Align.START)
        city_box.pack_start(city_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        city_field_box = Gtk.HBox(spacing=10)
        
        self.city_entry = Gtk.Entry()
        self.city_entry.set_placeholder_text("Enter your city")
        self.city_entry.set_size_request(300, 35)
        city_field_box.pack_start(self.city_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Enter the city name")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "city")
        city_field_box.pack_start(help_button, False, False, 0)
        
        city_box.pack_start(city_field_box, False, False, 0)
        form_box.pack_start(city_box, False, False, 0)
        
        # ZIP Code field
        zip_box = Gtk.VBox(spacing=5)
        
        zip_label = Gtk.Label()
        zip_label.set_markup("<span weight='bold' size='large'>ZIP Code</span>")
        zip_label.set_halign(Gtk.Align.START)
        zip_box.pack_start(zip_label, False, False, 0)
        
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        zip_field_box = Gtk.HBox(spacing=10)
        
        self.zip_entry = Gtk.Entry()
        self.zip_entry.set_placeholder_text("Enter your ZIP code")
        self.zip_entry.set_size_request(300, 35)
        zip_field_box.pack_start(self.zip_entry, True, True, 0)
        
        help_button = Gtk.Button("?")
        help_button.set_size_request(30, 30)
        help_button.set_tooltip_text("Enter 5-digit ZIP code")  # INACCESSIBLE TOOLTIP - Tooltip only shows on hover
        help_button.connect("clicked", self.on_help_clicked, "zip")
        zip_field_box.pack_start(help_button, False, False, 0)
        
        zip_box.pack_start(zip_field_box, False, False, 0)
        form_box.pack_start(zip_box, False, False, 0)
        
        main_box.pack_start(form_frame, False, False, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        
        submit_button = Gtk.Button("Submit Form")
        submit_button.get_style_context().add_class("suggested-action")
        submit_button.set_size_request(120, 40)
        submit_button.connect("clicked", self.on_submit_clicked)
        button_box.pack_start(submit_button, False, False, 0)
        
        clear_button = Gtk.Button("Clear Form")
        clear_button.set_size_request(120, 40)
        clear_button.connect("clicked", self.on_clear_clicked)
        button_box.pack_start(clear_button, False, False, 0)
        
        main_box.pack_start(button_box, False, False, 0)
        
    def on_help_clicked(self, button, field_name):
        # INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        # This method is called when the help button is clicked, but the tooltip is not accessible via keyboard
        help_messages = {
            "name": "Enter your full legal name as it appears on official documents.",
            "email": "Enter a valid email address where we can reach you.",
            "phone": "Include country code if international. Example: +1 (555) 123-4567",
            "address": "Include apartment or suite number if applicable.",
            "city": "Enter the city name where you reside.",
            "zip": "Enter your 5-digit ZIP code or postal code."
        }
        
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Help"
        )
        dialog.format_secondary_text(help_messages.get(field_name, "Help information not available."))
        dialog.run()
        dialog.destroy()
    
    def on_submit_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Form Submitted"
        )
        dialog.format_secondary_text("Your form has been submitted successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_clear_clicked(self, button):
        self.name_entry.set_text("")
        self.email_entry.set_text("")
        self.phone_entry.set_text("")
        self.address_entry.set_text("")
        self.city_entry.set_text("")
        self.zip_entry.set_text("")

def main():
    win = InaccessibleTooltip()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

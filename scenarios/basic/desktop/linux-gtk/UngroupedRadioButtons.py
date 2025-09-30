import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class UngroupedRadioButtons(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Contact Preferences")
        self.set_default_size(600, 500)
        self.set_border_width(20)
        
        # Main container
        main_box = Gtk.VBox(spacing=20)
        self.add(main_box)
        
        # Header
        header_box = Gtk.VBox(spacing=10)
        header_box.set_halign(Gtk.Align.CENTER)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold'>Contact Preferences</span>")
        header_box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label()
        subtitle_label.set_markup("<span size='large'>How would you like us to contact you?</span>")
        subtitle_label.set_halign(Gtk.Align.CENTER)
        header_box.pack_start(subtitle_label, False, False, 0)
        
        main_box.pack_start(header_box, False, False, 0)
        
        # Contact Method Section - UNGROUPED RADIO BUTTONS
        contact_frame = Gtk.Frame()
        contact_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        contact_box = Gtk.VBox(spacing=15)
        contact_box.set_margin_left(20)
        contact_box.set_margin_right(20)
        contact_box.set_margin_top(20)
        contact_box.set_margin_bottom(20)
        contact_frame.add(contact_box)
        
        contact_title = Gtk.Label()
        contact_title.set_markup("<span size='large' weight='bold'>Preferred Contact Method</span>")
        contact_title.set_halign(Gtk.Align.START)
        contact_box.pack_start(contact_title, False, False, 0)
        
        # UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        self.contact_buttons = []
        contact_methods = [
            ("email", "Email"),
            ("phone", "Phone"),
            ("sms", "SMS"),
            ("mail", "Mail")
        ]
        
        for value, label in contact_methods:
            button = Gtk.RadioButton()
            button.set_label(label)
            if value == "email":
                button.set_active(True)
                self.selected_contact_method = "email"
            button.connect("toggled", self.on_contact_method_changed, value)
            self.contact_buttons.append(button)
            contact_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(contact_frame, False, False, 0)
        
        # Newsletter Subscription Section - UNGROUPED RADIO BUTTONS
        newsletter_frame = Gtk.Frame()
        newsletter_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        newsletter_box = Gtk.VBox(spacing=15)
        newsletter_box.set_margin_left(20)
        newsletter_box.set_margin_right(20)
        newsletter_box.set_margin_top(20)
        newsletter_box.set_margin_bottom(20)
        newsletter_frame.add(newsletter_box)
        
        newsletter_title = Gtk.Label()
        newsletter_title.set_markup("<span size='large' weight='bold'>Newsletter Subscription</span>")
        newsletter_title.set_halign(Gtk.Align.START)
        newsletter_box.pack_start(newsletter_title, False, False, 0)
        
        # UNGROUPED RADIO BUTTONS - Newsletter preference radio buttons without fieldset grouping
        self.newsletter_buttons = []
        newsletter_options = [
            ("yes", "Yes, send me newsletters"),
            ("no", "No, don't send newsletters")
        ]
        
        for value, label in newsletter_options:
            button = Gtk.RadioButton()
            button.set_label(label)
            if value == "yes":
                button.set_active(True)
                self.selected_newsletter = "yes"
            button.connect("toggled", self.on_newsletter_changed, value)
            self.newsletter_buttons.append(button)
            newsletter_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(newsletter_frame, False, False, 0)
        
        # Notification Preferences Section - UNGROUPED RADIO BUTTONS
        notifications_frame = Gtk.Frame()
        notifications_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        notifications_box = Gtk.VBox(spacing=15)
        notifications_box.set_margin_left(20)
        notifications_box.set_margin_right(20)
        notifications_box.set_margin_top(20)
        notifications_box.set_margin_bottom(20)
        notifications_frame.add(notifications_box)
        
        notifications_title = Gtk.Label()
        notifications_title.set_markup("<span size='large' weight='bold'>Notification Preferences</span>")
        notifications_title.set_halign(Gtk.Align.START)
        notifications_box.pack_start(notifications_title, False, False, 0)
        
        # UNGROUPED RADIO BUTTONS - Notification preference radio buttons without fieldset grouping
        self.notification_buttons = []
        notification_options = [
            ("all", "All notifications"),
            ("important", "Important only"),
            ("none", "No notifications")
        ]
        
        for value, label in notification_options:
            button = Gtk.RadioButton()
            button.set_label(label)
            if value == "all":
                button.set_active(True)
                self.selected_notifications = "all"
            button.connect("toggled", self.on_notifications_changed, value)
            self.notification_buttons.append(button)
            notifications_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(notifications_frame, False, False, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        
        save_button = Gtk.Button("Save Preferences")
        save_button.get_style_context().add_class("suggested-action")
        save_button.set_size_request(150, 40)
        save_button.connect("clicked", self.on_save_clicked)
        button_box.pack_start(save_button, False, False, 0)
        
        reset_button = Gtk.Button("Reset to Defaults")
        reset_button.set_size_request(150, 40)
        reset_button.connect("clicked", self.on_reset_clicked)
        button_box.pack_start(reset_button, False, False, 0)
        
        main_box.pack_start(button_box, False, False, 0)
        
    def on_contact_method_changed(self, button, value):
        if button.get_active():
            self.selected_contact_method = value
    
    def on_newsletter_changed(self, button, value):
        if button.get_active():
            self.selected_newsletter = value
    
    def on_notifications_changed(self, button, value):
        if button.get_active():
            self.selected_notifications = value
    
    def on_save_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Preferences Saved"
        )
        dialog.format_secondary_text(f"""
Contact Method: {self.selected_contact_method}
Newsletter: {self.selected_newsletter}
Notifications: {self.selected_notifications}
        """)
        dialog.run()
        dialog.destroy()
    
    def on_reset_clicked(self, button):
        # Reset to defaults
        self.selected_contact_method = "email"
        self.selected_newsletter = "yes"
        self.selected_notifications = "all"
        
        # Reset contact method buttons
        for i, button in enumerate(self.contact_buttons):
            if i == 0:  # Email
                button.set_active(True)
            else:
                button.set_active(False)
        
        # Reset newsletter buttons
        for i, button in enumerate(self.newsletter_buttons):
            if i == 0:  # Yes
                button.set_active(True)
            else:
                button.set_active(False)
        
        # Reset notification buttons
        for i, button in enumerate(self.notification_buttons):
            if i == 0:  # All
                button.set_active(True)
            else:
                button.set_active(False)

def main():
    win = UngroupedRadioButtons()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

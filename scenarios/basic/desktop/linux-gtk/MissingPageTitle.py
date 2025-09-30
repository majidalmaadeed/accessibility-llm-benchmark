import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class MissingPageTitle(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Settings")  # MISSING PAGE TITLE - Settings page without descriptive title element
        self.set_default_size(800, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # MISSING PAGE TITLE - Settings page without descriptive title element
        # Tab Navigation
        tab_box = Gtk.HBox(spacing=0)
        
        tab_buttons = [
            ("General", True),
            ("Privacy", False),
            ("Security", False),
            ("Notifications", False)
        ]
        
        for label, is_active in tab_buttons:
            button = Gtk.Button(label)
            if is_active:
                button.get_style_context().add_class("suggested-action")
            button.connect("clicked", self.on_tab_clicked, label)
            tab_box.pack_start(button, True, True, 0)
        
        main_box.pack_start(tab_box, False, False, 0)
        
        # Content area
        content_frame = Gtk.Frame()
        content_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        content_box = Gtk.VBox(spacing=20)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top=20
        content_box.set_margin_bottom=20
        content_frame.add(content_box)
        
        # General Settings
        general_frame = Gtk.Frame()
        general_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        general_box = Gtk.VBox(spacing=15)
        general_box.set_margin_left(15)
        general_box.set_margin_right(15)
        general_box.set_margin_top(15)
        general_box.set_margin_bottom(15)
        general_frame.add(general_box)
        
        # Language selection
        language_box = Gtk.VBox(spacing=5)
        
        language_label = Gtk.Label()
        language_label.set_markup("<span weight='bold' size='large'>Language</span>")
        language_label.set_halign(Gtk.Align.START)
        language_box.pack_start(language_label, False, False, 0)
        
        self.language_combo = Gtk.ComboBoxText()
        languages = ["English", "Spanish", "French", "German", "Italian", "Portuguese"]
        for lang in languages:
            self.language_combo.append_text(lang)
        self.language_combo.set_active(0)
        self.language_combo.connect("changed", self.on_language_changed)
        language_box.pack_start(self.language_combo, False, False, 0)
        
        general_box.pack_start(language_box, False, False, 0)
        
        # Theme selection
        theme_box = Gtk.VBox(spacing=5)
        
        theme_label = Gtk.Label()
        theme_label.set_markup("<span weight='bold' size='large'>Theme</span>")
        theme_label.set_halign(Gtk.Align.START)
        theme_box.pack_start(theme_label, False, False, 0)
        
        self.theme_combo = Gtk.ComboBoxText()
        themes = ["System", "Light", "Dark"]
        for theme in themes:
            self.theme_combo.append_text(theme)
        self.theme_combo.set_active(0)
        self.theme_combo.connect("changed", self.on_theme_changed)
        theme_box.pack_start(self.theme_combo, False, False, 0)
        
        general_box.pack_start(theme_box, False, False, 0)
        
        # Auto-save toggle
        auto_save_box = Gtk.HBox(spacing=10)
        
        self.auto_save_toggle = Gtk.Switch()
        self.auto_save_toggle.set_active(True)
        self.auto_save_toggle.connect("notify::active", self.on_auto_save_changed)
        auto_save_box.pack_start(self.auto_save_toggle, False, False, 0)
        
        auto_save_label = Gtk.Label("Auto-save")
        auto_save_label.set_halign(Gtk.Align.START)
        auto_save_box.pack_start(auto_save_label, False, False, 0)
        
        general_box.pack_start(auto_save_box, False, False, 0)
        
        content_box.pack_start(general_frame, False, False, 0)
        
        # Privacy Settings
        privacy_frame = Gtk.Frame()
        privacy_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        privacy_box = Gtk.VBox(spacing=15)
        privacy_box.set_margin_left(15)
        privacy_box.set_margin_right(15)
        privacy_box.set_margin_top(15)
        privacy_box.set_margin_bottom(15)
        privacy_frame.add(privacy_box)
        
        # Data Collection toggle
        data_collection_box = Gtk.HBox(spacing=10)
        
        self.data_collection_toggle = Gtk.Switch()
        self.data_collection_toggle.set_active(False)
        self.data_collection_toggle.connect("notify::active", self.on_data_collection_changed)
        data_collection_box.pack_start(self.data_collection_toggle, False, False, 0)
        
        data_collection_label = Gtk.Label("Data Collection")
        data_collection_label.set_halign(Gtk.Align.START)
        data_collection_box.pack_start(data_collection_label, False, False, 0)
        
        privacy_box.pack_start(data_collection_box, False, False, 0)
        
        # Analytics toggle
        analytics_box = Gtk.HBox(spacing=10)
        
        self.analytics_toggle = Gtk.Switch()
        self.analytics_toggle.set_active(True)
        self.analytics_toggle.connect("notify::active", self.on_analytics_changed)
        analytics_box.pack_start(self.analytics_toggle, False, False, 0)
        
        analytics_label = Gtk.Label("Analytics")
        analytics_label.set_halign(Gtk.Align.START)
        analytics_box.pack_start(analytics_label, False, False, 0)
        
        privacy_box.pack_start(analytics_box, False, False, 0)
        
        # Crash Reports toggle
        crash_reports_box = Gtk.HBox(spacing=10)
        
        self.crash_reports_toggle = Gtk.Switch()
        self.crash_reports_toggle.set_active(True)
        self.crash_reports_toggle.connect("notify::active", self.on_crash_reports_changed)
        crash_reports_box.pack_start(self.crash_reports_toggle, False, False, 0)
        
        crash_reports_label = Gtk.Label("Crash Reports")
        crash_reports_label.set_halign(Gtk.Align.START)
        crash_reports_box.pack_start(crash_reports_label, False, False, 0)
        
        privacy_box.pack_start(crash_reports_box, False, False, 0)
        
        content_box.pack_start(privacy_frame, False, False, 0)
        
        # Security Settings
        security_frame = Gtk.Frame()
        security_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        security_box = Gtk.VBox(spacing=15)
        security_box.set_margin_left(15)
        security_box.set_margin_right(15)
        security_box.set_margin_top(15)
        security_box.set_margin_bottom(15)
        security_frame.add(security_box)
        
        # Two-Factor Authentication toggle
        two_factor_box = Gtk.HBox(spacing=10)
        
        self.two_factor_toggle = Gtk.Switch()
        self.two_factor_toggle.set_active(True)
        self.two_factor_toggle.connect("notify::active", self.on_two_factor_changed)
        two_factor_box.pack_start(self.two_factor_toggle, False, False, 0)
        
        two_factor_label = Gtk.Label("Two-Factor Authentication")
        two_factor_label.set_halign(Gtk.Align.START)
        two_factor_box.pack_start(two_factor_label, False, False, 0)
        
        security_box.pack_start(two_factor_box, False, False, 0)
        
        # Biometric Login toggle
        biometric_box = Gtk.HBox(spacing=10)
        
        self.biometric_toggle = Gtk.Switch()
        self.biometric_toggle.set_active(False)
        self.biometric_toggle.connect("notify::active", self.on_biometric_changed)
        biometric_box.pack_start(self.biometric_toggle, False, False, 0)
        
        biometric_label = Gtk.Label("Biometric Login")
        biometric_label.set_halign(Gtk.Align.START)
        biometric_box.pack_start(biometric_label, False, False, 0)
        
        security_box.pack_start(biometric_box, False, False, 0)
        
        # Session Timeout
        session_timeout_box = Gtk.VBox(spacing=5)
        
        session_timeout_label = Gtk.Label()
        session_timeout_label.set_markup("<span weight='bold' size='large'>Session Timeout</span>")
        session_timeout_label.set_halign(Gtk.Align.START)
        session_timeout_box.pack_start(session_timeout_label, False, False, 0)
        
        self.session_timeout_combo = Gtk.ComboBoxText()
        timeouts = ["5 minutes", "15 minutes", "30 minutes", "1 hour"]
        for timeout in timeouts:
            self.session_timeout_combo.append_text(timeout)
        self.session_timeout_combo.set_active(1)
        self.session_timeout_combo.connect("changed", self.on_session_timeout_changed)
        session_timeout_box.pack_start(self.session_timeout_combo, False, False, 0)
        
        security_box.pack_start(session_timeout_box, False, False, 0)
        
        content_box.pack_start(security_frame, False, False, 0)
        
        # Notification Settings
        notification_frame = Gtk.Frame()
        notification_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        notification_box = Gtk.VBox(spacing=15)
        notification_box.set_margin_left(15)
        notification_box.set_margin_right(15)
        notification_box.set_margin_top(15)
        notification_box.set_margin_bottom(15)
        notification_frame.add(notification_box)
        
        # Push Notifications toggle
        push_notifications_box = Gtk.HBox(spacing=10)
        
        self.push_notifications_toggle = Gtk.Switch()
        self.push_notifications_toggle.set_active(True)
        self.push_notifications_toggle.connect("notify::active", self.on_push_notifications_changed)
        push_notifications_box.pack_start(self.push_notifications_toggle, False, False, 0)
        
        push_notifications_label = Gtk.Label("Push Notifications")
        push_notifications_label.set_halign(Gtk.Align.START)
        push_notifications_box.pack_start(push_notifications_label, False, False, 0)
        
        notification_box.pack_start(push_notifications_box, False, False, 0)
        
        # Email Notifications toggle
        email_notifications_box = Gtk.HBox(spacing=10)
        
        self.email_notifications_toggle = Gtk.Switch()
        self.email_notifications_toggle.set_active(False)
        self.email_notifications_toggle.connect("notify::active", self.on_email_notifications_changed)
        email_notifications_box.pack_start(self.email_notifications_toggle, False, False, 0)
        
        email_notifications_label = Gtk.Label("Email Notifications")
        email_notifications_label.set_halign(Gtk.Align.START)
        email_notifications_box.pack_start(email_notifications_label, False, False, 0)
        
        notification_box.pack_start(email_notifications_box, False, False, 0)
        
        # SMS Notifications toggle
        sms_notifications_box = Gtk.HBox(spacing=10)
        
        self.sms_notifications_toggle = Gtk.Switch()
        self.sms_notifications_toggle.set_active(False)
        self.sms_notifications_toggle.connect("notify::active", self.on_sms_notifications_changed)
        sms_notifications_box.pack_start(self.sms_notifications_toggle, False, False, 0)
        
        sms_notifications_label = Gtk.Label("SMS Notifications")
        sms_notifications_label.set_halign(Gtk.Align.START)
        sms_notifications_box.pack_start(sms_notifications_label, False, False, 0)
        
        notification_box.pack_start(sms_notifications_box, False, False, 0)
        
        content_box.pack_start(notification_frame, False, False, 0)
        
        main_box.pack_start(content_frame, True, True, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        button_box.set_margin_top(20)
        button_box.set_margin_bottom=20
        
        save_button = Gtk.Button("Save Changes")
        save_button.get_style_context().add_class("suggested-action")
        save_button.set_size_request(120, 40)
        save_button.connect("clicked", self.on_save_clicked)
        button_box.pack_start(save_button, False, False, 0)
        
        reset_button = Gtk.Button("Reset to Defaults")
        reset_button.set_size_request(120, 40)
        reset_button.connect("clicked", self.on_reset_clicked)
        button_box.pack_start(reset_button, False, False, 0)
        
        main_box.pack_start(button_box, False, False, 0)
        
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
    
    def on_language_changed(self, combo):
        # Handle language change
        pass
    
    def on_theme_changed(self, combo):
        # Handle theme change
        pass
    
    def on_auto_save_changed(self, switch, gparam):
        # Handle auto-save change
        pass
    
    def on_data_collection_changed(self, switch, gparam):
        # Handle data collection change
        pass
    
    def on_analytics_changed(self, switch, gparam):
        # Handle analytics change
        pass
    
    def on_crash_reports_changed(self, switch, gparam):
        # Handle crash reports change
        pass
    
    def on_two_factor_changed(self, switch, gparam):
        # Handle two-factor change
        pass
    
    def on_biometric_changed(self, switch, gparam):
        # Handle biometric change
        pass
    
    def on_session_timeout_changed(self, combo):
        # Handle session timeout change
        pass
    
    def on_push_notifications_changed(self, switch, gparam):
        # Handle push notifications change
        pass
    
    def on_email_notifications_changed(self, switch, gparam):
        # Handle email notifications change
        pass
    
    def on_sms_notifications_changed(self, switch, gparam):
        # Handle SMS notifications change
        pass
    
    def on_save_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Settings Saved"
        )
        dialog.format_secondary_text("Your settings have been saved successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_reset_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.QUESTION,
            buttons=Gtk.ButtonsType.YES_NO,
            text="Reset Settings"
        )
        dialog.format_secondary_text("Are you sure you want to reset all settings to their default values?")
        
        response = dialog.run()
        if response == Gtk.ResponseType.YES:
            # Reset all settings
            self.language_combo.set_active(0)
            self.theme_combo.set_active(0)
            self.auto_save_toggle.set_active(True)
            self.data_collection_toggle.set_active(False)
            self.analytics_toggle.set_active(True)
            self.crash_reports_toggle.set_active(True)
            self.two_factor_toggle.set_active(True)
            self.biometric_toggle.set_active(False)
            self.session_timeout_combo.set_active(1)
            self.push_notifications_toggle.set_active(True)
            self.email_notifications_toggle.set_active(False)
            self.sms_notifications_toggle.set_active(False)
        
        dialog.destroy()

def main():
    win = MissingPageTitle()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
